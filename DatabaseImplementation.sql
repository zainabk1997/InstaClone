


IF NOT EXISTS(SELECT name FROM sys.databases WHERE name = 'GroupEleven')
BEGIN
   CREATE DATABASE GroupEleven;
END
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'GroupEleven')
BEGIN  CREATE DATABASE GroupEleven;END;

USE GroupEleven;

-- Dropping tables if they exist

DROP TABLE IF EXISTS Likes;
DROP TABLE IF EXISTS UserLogin;
DROP TABLE IF EXISTS MediaFilter;
DROP TABLE IF EXISTS MediaHashtags;
DROP TABLE IF EXISTS Tags;
DROP TABLE IF EXISTS Comments;
DROP TABLE IF EXISTS Hashtags;
DROP TABLE IF EXISTS Reels;
DROP TABLE IF EXISTS Story;
DROP TABLE IF EXISTS Followers;
DROP TABLE IF EXISTS Posts;
DROP TABLE IF EXISTS Filters;
DROP TABLE IF EXISTS Interactions;
DROP TABLE IF EXISTS Media;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Location;




-- Table Location

-- -----------------------------------------------------

CREATE TABLE Location (

  LocationID INT NOT NULL,

  LocationName VARCHAR(45) NULL,

  PRIMARY KEY (LocationID));


-- -----------------------------------------------------

-- Table Users

-- -----------------------------------------------------

CREATE TABLE Users (

  UserID INT NOT NULL IDENTITY(1,1),

  UserName VARCHAR(255) NULL,

  ProfilePicture VARBINARY(MAX) NOT NULL,

  Bio VARCHAR(255) NULL DEFAULT CURRENT_TIMESTAMP,

  MediaCount INT NULL,

  FollowersCount INT NULL,

  FollowingCount INT NULL,

  UserAccountType VARCHAR(45) NULL,

  LocationID INT NULL,

  EmailAddress VARCHAR(45) NULL,

  Password VARBINARY(Max) NULL,

  UserFirstName VARCHAR(45) NULL,

  UserLastName VARCHAR(45) NULL,

  PRIMARY KEY (UserID),

  CONSTRAINT fk_LocationID

    FOREIGN KEY (LocationID)

    REFERENCES GroupEleven.dbo.Location (LocationID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION);

-- -----------------------------------------------------

-- Table Filters

-- -----------------------------------------------------

CREATE TABLE Filters (

  FilterID INT NOT NULL,

  FilterName VARCHAR(50) NULL,

  PRIMARY KEY (FilterID));


-- -----------------------------------------------------

-- Table Media

-- -----------------------------------------------------

CREATE TABLE Media (

  MediaID INT NOT NULL,

  CreatedDate DATETIME NULL,

  MediaType INT NULL,

  InteractionCount INT NULL,

LikeCount INT NULL,

CommentCount INT NULL,

  UserID INT NOT NULL,

  LocationID INT NULL,

  Caption VARCHAR(45) NULL,

  Content VARBINARY(MAX) NULL,

NumberofPlays INT NULL,

NumberofSaves INT NULL,

NumberofShares INT NULL,

ReelDuration INT NULL

  PRIMARY KEY (MediaID),

  CONSTRAINT fk_UserID

    FOREIGN KEY (UserID)

    REFERENCES GroupEleven.dbo.Users (UserID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT fk_locationID1

    FOREIGN KEY (LocationID)

    REFERENCES GroupEleven.dbo.Location (LocationID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION);


-- -----------------------------------------------------

-- Table Posts

-- -----------------------------------------------------

CREATE TABLE Posts (

  PostID INT NOT NULL IDENTITY(1,1),

  MediaID INT NOT NULL,

  NumberOfSaves INT NULL,

  PRIMARY KEY (PostID),

  CONSTRAINT fk_MediaID2

    FOREIGN KEY (MediaID)

    REFERENCES GroupEleven.dbo.Media (MediaID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION);

-- -----------------------------------------------------

-- Table Followers

-- -----------------------------------------------------

CREATE TABLE Followers (

  FollowerID INT NOT NULL ,

  UserID INT NOT NULL,

  FollowedDate DATETIME NULL,

  CONSTRAINT fk_UserID2

    FOREIGN KEY (UserID)

    REFERENCES GroupEleven.dbo.Users (UserID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT fk_FollowerID2

    FOREIGN KEY (FollowerID)

    REFERENCES GroupEleven.dbo.Users (UserID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION);


-- -----------------------------------------------------

-- Table Story

-- -----------------------------------------------------

CREATE TABLE Story (

  StoryID INT NOT NULL IDENTITY(1,1),

  MediaID INT NOT NULL,

  PRIMARY KEY (StoryID),

  CONSTRAINT fk_MediaID

    FOREIGN KEY (MediaID)

    REFERENCES GroupEleven.dbo.Media (MediaID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION);


-- -----------------------------------------------------

-- Table Reels

-- -----------------------------------------------------

CREATE TABLE Reels (

  ReelID INT NOT NULL IDENTITY(1,1),

  ReelDuration INT NULL,

  NumberOfPlays INT NULL,

  NumberOfShares INT NULL,

 NumberOfSaves INT NULL,

  MediaID INT NOT NULL,

  PRIMARY KEY (ReelID),

  CONSTRAINT MediaID

    FOREIGN KEY (MediaID)

    REFERENCES GroupEleven.dbo.Media (MediaID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION);

-- -----------------------------------------------------

-- Table Hashtags

-- -----------------------------------------------------

CREATE TABLE Hashtags (

  HashtagID INT NOT NULL IDENTITY(1,1),

  HashtagType VARCHAR(20) NULL,

  HashtagName VARCHAR(45) NOT NULL,

  PRIMARY KEY (HashtagID));


-- -----------------------------------------------------

-- Table Interactions

-- -----------------------------------------------------

CREATE TABLE Interactions (

  InteractionID INT NOT NULL,
InteractionType INT NOT NULL,

  UserID INT NULL,

  MediaID INT NULL,
  CommentText VARCHAR(45) NULL,

  Sentiment VARCHAR(20) NULL,

  Date DATETIME NULL,

  PRIMARY KEY (InteractionID),

  CONSTRAINT fk_UserID3

    FOREIGN KEY (UserID)

    REFERENCES GroupEleven.dbo.Users (UserID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT fk_MediaID3

    FOREIGN KEY (MediaID)

    REFERENCES GroupEleven.dbo.Media (MediaID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION);


-- -----------------------------------------------------

-- Table Comments

-- -----------------------------------------------------

CREATE TABLE Comments (

  CommentID INT IDENTITY NOT NULL,

  CommentText VARCHAR(45) NULL,

  UserID INT NULL,

  InteractionID INT NULL,

  Sentiment VARCHAR(20) NULL,

  PRIMARY KEY (CommentID),

  CONSTRAINT fk_InteractionID4

    FOREIGN KEY (InteractionID)

    REFERENCES GroupEleven.dbo.Interactions (InteractionID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT fk_UserID4

    FOREIGN KEY (UserID)

    REFERENCES GroupEleven.dbo.Users (UserID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION);


-- -----------------------------------------------------

-- Table Tags

-- -----------------------------------------------------

CREATE TABLE Tags (

  UserID INT NULL,

  MediaID INT NULL,

  TaggedText VARCHAR(45) NULL,


  CONSTRAINT fk_MediaID5

    FOREIGN KEY (MediaID)

    REFERENCES GroupEleven.dbo.Media (MediaID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT fk_UserID5

    FOREIGN KEY (UserID)

    REFERENCES GroupEleven.dbo.Users (UserID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION);

-- -----------------------------------------------------

-- Table MediaHashtags

-- -----------------------------------------------------

CREATE TABLE MediaHashtags (

  MediaID INT NOT NULL,

  HashtagID INT NOT NULL,

  CONSTRAINT fk_MediaID6

    FOREIGN KEY (MediaID)

    REFERENCES GroupEleven.dbo.Media (MediaID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT fk_HashtagID6

    FOREIGN KEY (HashtagID)

    REFERENCES GroupEleven.dbo.Hashtags (HashtagID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION);
 



-- -----------------------------------------------------

-- Table MediaFilter

-- -----------------------------------------------------

CREATE TABLE MediaFilter (

  FilterID INT NOT NULL,

  MediaID INT NOT NULL,

  CONSTRAINT fk_MediaID7

    FOREIGN KEY (MediaID)

    REFERENCES GroupEleven.dbo.Media (MediaID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT fk_FilterID7

    FOREIGN KEY (FilterID)

    REFERENCES GroupEleven.dbo.Filters (FilterID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION);


-- -----------------------------------------------------

-- Table UserLogin

-- -----------------------------------------------------

CREATE TABLE UserLogin (

UserLoginID INT NOT NULL,
  UserID INT NOT NULL,

  LoginTime DATETIME NULL,

  LogoutTIme DATETIME NULL,

  Duration DATETIME NULL,

  PRIMARY KEY (UserLoginID),

  CONSTRAINT fk_UserID8

    FOREIGN KEY (UserID)

    REFERENCES GroupEleven.dbo.Users (UserID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION);

-- -----------------------------------------------------

-- Table Likes

-- -----------------------------------------------------

CREATE TABLE Likes (

  LikeID INT Identity NOT NULL ,

  UserID INT NULL,

  InteractionID INT NULL,

  PRIMARY KEY (LikeID),

  CONSTRAINT fk_InteractionID9

    FOREIGN KEY (InteractionID)

    REFERENCES GroupEleven.dbo.Interactions (InteractionID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT fk_UserID9

    FOREIGN KEY (UserID)

    REFERENCES GroupEleven.dbo.Users (UserID)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION);


---------------------------------------------------------------------

-- Triggers and stored procedures and computed columns for all tables

---------------------------------------------------------------------
----- Dropping functions and views if they exist
DROP FUNCTION IF EXISTS durationActivity;
DROP FUNCTION IF EXISTS CountCommentsByMediaID;
DROP FUNCTION IF EXISTS CountLikesByMediaID;
DROP FUNCTION IF EXISTS CalculateInteractionsCount;
DROP FUNCTION IF EXISTS check_user_sentiment;

Drop view if exists HashtagCounts;
Drop view if exists MostVisitedLocations;
Drop view if exists CommentSentimentCounts;


----- Drop Stored Procedure if exists
DROP PROCEDURE IF EXISTS GetTopFiveInfluencers;

-- Computed Column Duration 

CREATE FUNCTION durationActivity (@LoginTime DATETIME, @LogoutTime DATETIME)
RETURNS DATETIME
AS
Begin
	Declare @duration DATETIME;
    Set @duration = @LogoutTime - @LoginTime;
	return @duration;

End;




 --- Function to count the comments - computed column 

CREATE FUNCTION CountCommentsByMediaID
(
@MediaID INT
)
RETURNS INT
AS
BEGIN
DECLARE @CommentsCount INT


SELECT @CommentsCount = COUNT(*)

FROM Interactions

WHERE MediaID = @MediaID AND InteractionType = 2

 

RETURN @CommentsCount

END

-- Function to count the likes - computed column 

CREATE FUNCTION CountLikesByMediaID

(

@MediaID INT

)

RETURNS INT

AS

BEGIN

DECLARE @LikesCount INT

 

SELECT @LikesCount = COUNT(*)

FROM Interactions

WHERE MediaID = @MediaID AND InteractionType = 1

 

RETURN @LikesCount

END

-- Function to find the user engagement but getting count of interactions

 CREATE FUNCTION CalculateInteractionsCount

(
@MediaID INT
)

RETURNS INT

AS

BEGIN

DECLARE @InteractionsCount INT=0

 

SELECT @InteractionsCount = COUNT(InteractionType)

FROM Interactions i

WHERE i.MediaID = @MediaID

 

RETURN @InteractionsCount

END


-- Create function check_user_sentiment


CREATE FUNCTION check_user_sentiment(@UserID INT)

RETURNS INTEGER

AS

BEGIN

DECLARE @num_negative_comments INT;

SELECT @num_negative_comments = COUNT(*) FROM Comments WHERE UserID = @UserID AND Sentiment = 'negative';

RETURN @num_negative_comments;

END;


-- Drop Constraint check_user_sentiment1 if exists
ALTER TABLE Comments
Drop Constraint if exists check_user_sentiment1 ;


-- Check Table Level Constraint for negative comments with a threshold of 7
ALTER TABLE Comments

ADD CONSTRAINT check_user_sentiment1 CHECK (dbo.check_user_sentiment(UserID) <= 7);







------
-- View which tells us about trending number of hashtags 

CREATE VIEW HashtagCounts AS

SELECT
	h.HashtagID,
	COUNT(h.HashtagID) AS [value_occurrence],
	h.HashtagName
FROM
	MediaHashtags mh
JOIN Hashtags h

ON
	mh.HashtagID = h.HashtagID
GROUP BY
	h.HashtagID,
	h.HashtagName;


-- View which tells us about the most visited location

CREATE VIEW MostVisitedLocations AS

SELECT

L.LocationID,

COUNT(L.LocationID) AS [value_occurrence],

L.LocationName


FROM

Location L

JOIN Media m


ON L.LocationID = m.LocationID

GROUP BY

L.LocationID,


L.LocationName;

-- view to get comment sentiment analysis

CREATE VIEW CommentSentimentCounts AS

SELECT

  i.UserID,

  COUNT(CASE WHEN c.Sentiment = 'Positive' THEN 1 END) AS PositiveCount,

  COUNT(CASE WHEN c.Sentiment = 'Negative' THEN 1 END) AS NegativeCount,

  COUNT(CASE WHEN c.Sentiment = 'Neutral' THEN 1 END) AS NeutralCount

FROM Interactions i

JOIN Comments c ON i.InteractionID = c.InteractionID

WHERE i.Date > DATEADD(MONTH,-30,CAST(GETDATE()as Date))

GROUP BY i.UserID;


-----------------------



-- Trigger to insert likes in likes table based on interaction insert

 CREATE TRIGGER TriggerToInsertLikesTableAndCommentsTable
ON Interactions
AFTER INSERT
AS
BEGIN
    IF EXISTS(SELECT * FROM inserted WHERE InteractionType = 1)
    BEGIN
        INSERT INTO Likes (UserID , InteractionID)
        SELECT UserID , InteractionID FROM inserted WHERE InteractionType = 1;
    END

 

    IF EXISTS(SELECT * FROM inserted WHERE InteractionType = 2)
    BEGIN
        INSERT INTO Comments (UserID , InteractionID, CommentText, Sentiment)
        SELECT UserID , InteractionID, CommentText, Sentiment FROM inserted WHERE InteractionType = 2;
    END
END;

 

-- Trigger to insert post, stories, and reels in tables based on media insert

CREATE TRIGGER TriggerToInsertPostsReelsStoriesTable
ON Media
AFTER INSERT
AS
BEGIN
    IF EXISTS(SELECT * FROM inserted WHERE MediaType = 1)
    BEGIN
        INSERT INTO Posts  ( MediaID, NumberOfSaves)
        SELECT  MediaID, NumberOfSaves FROM inserted WHERE MediaType = 1;
    END

 

    IF EXISTS(SELECT * FROM inserted WHERE MediaType = 2)
    BEGIN
        INSERT INTO Story (MediaID)
        SELECT MediaID FROM inserted WHERE MediaType = 2;
    END

        IF EXISTS(SELECT * FROM inserted WHERE MediaType = 3)
    BEGIN
        INSERT INTO Reels (MediaID,ReelDuration, NumberOfPlays, NumberOfShares,NumberOfSaves)
        SELECT MediaID,ReelDuration, NumberOfPlays, NumberOfShares,NumberOfSaves FROM inserted WHERE MediaType = 3;
    END
END;



 
-- Trigger to update comments count
 

CREATE TRIGGER TriggerCommentCount

ON Interactions

AFTER INSERT

AS

BEGIN

DECLARE @MediaID INT, @CommentsCount INT

 

SELECT @MediaID = MediaID FROM INSERTED

SET @CommentsCount = dbo.CountCommentsByMediaID(@MediaID)

UPDATE Media SET CommentCount = @CommentsCount WHERE MediaID = @MediaID

END

 
-- Trigger to update like count
 

CREATE TRIGGER TriggerLikeCount

ON Interactions

AFTER INSERT

AS

BEGIN

DECLARE @MediaID INT, @LikesCount INT


SELECT @MediaID = MediaID FROM INSERTED

SET @LikesCount = dbo.CountLikesByMediaID(@MediaID)

UPDATE Media SET LikeCount = @LikesCount WHERE MediaID = @MediaID

END

 
-- Trigger to update interactions count
 

CREATE TRIGGER TriggerInteractionsCount

ON Interactions

AFTER INSERT

AS

BEGIN

DECLARE @MediaID INT, @InteractionsCount INT

 

SELECT @MediaID = MediaID FROM INSERTED

SET @InteractionsCount = dbo.CalculateInteractionsCount(@MediaID)

UPDATE Media SET InteractionCount = @InteractionsCount WHERE MediaID = @MediaID

END

---- Trigger to update follower and following count 
CREATE TRIGGER TriggerUpdateFollowCounts
ON Followers 
AFTER INSERT AS 
BEGIN    
DECLARE @FollowerID INT, @UserID INT;         
SELECT @FollowerID = inserted.FollowerID FROM inserted;     
SELECT @UserID = UserID FROM Followers WHERE FollowerID = @FollowerID;     
UPDATE Users SET FollowersCount = FollowersCount + 1 WHERE UserID in (select UserID from inserted);     
UPDATE Users SET FollowingCount = FollowingCount + 1 WHERE UserID in (select FollowerID from inserted);
END
--- Trigger to update Duration 
CREATE TRIGGER trg_updateDuration
ON UserLogin
AFTER INSERT
AS
BEGIN
    UPDATE UserLogin 
    SET Duration = dbo.durationActivity(LoginTime, LogoutTime) 
    WHERE UserLogin.UserLoginID  in (select UserLoginID from Inserted);
END

-- Stored procedure to get Top 5 infuencers
CREATE PROCEDURE GetTopFiveInfluencers
AS
BEGIN
    SELECT TOP 5 
        users.*, 
        RANK() OVER (ORDER BY FollowersCount  DESC) AS follower_rank
    FROM users
    ORDER BY FollowersCount  DESC
END



--  Password column encryption code -

--- Drop keys ( if exists)
Drop  SYMMETRIC KEY TestSymmetricKey;
Drop Certificate TestCertificate;
Drop  MASTER KEY ;

--create master key

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'password';

--open master key

OPEN MASTER KEY DECRYPTION BY PASSWORD = 'password';

 

-- Create certificate to protect symmetric key

CREATE CERTIFICATE TestCertificate

WITH SUBJECT = 'AdventureWorks Test Certificate',

EXPIRY_DATE = '2026-10-31';

 

-- Create symmetric key to encrypt data

CREATE SYMMETRIC KEY TestSymmetricKey

WITH ALGORITHM = AES_128

ENCRYPTION BY CERTIFICATE TestCertificate;

 
-- Open symmetric key
OPEN SYMMETRIC KEY TestSymmetricKey

DECRYPTION BY CERTIFICATE TestCertificate;

 







-------------------------------------------------

-- INSERT QUERIES for all tables

-------------------------------------------------

-- Location insert queries

INSERT INTO Location (LocationID, LocationName) VALUES 

(1, 'New York'), 

(2, 'Los Angeles'), 

(3, 'Chicago'), 

(4, 'Houston'), 

(5, 'Phoenix'), 

(6, 'Philadelphia'), 

(7, 'San Antonio'), 

(8, 'San Diego'), 

(9, 'Dallas'), 

(10, 'San Jose'), 

(11, 'Austin'), 

(12, 'Jacksonville'), 

(13, 'Fort Worth'), 

(14, 'Columbus'), 

(15, 'San Francisco'), 

(16, 'Charlotte'), 

(17, 'Indianapolis'), 

(18, 'Seattle'), 

(19, 'Denver'), 

(20, 'Washington'), 

(21, 'Boston'), 

(22, 'Nashville'), 

(23, 'El Paso'), 

(24, 'Detroit'), 

(25, 'Memphis'), 

(26, 'Portland'), 

(27, 'Oklahoma City'), 

(28, 'Las Vegas'), 

(29, 'Louisville'), 

(30, 'Baltimore'), 

(31, 'Milwaukee'), 

(32, 'Albuquerque'), 

(33, 'Tucson'), 

(34, 'Fresno'), 

(35, 'Sacramento'), 

(36, 'Mesa'), 

(37, 'Atlanta'), 

(38, 'Kansas City'), 

(39, 'Colorado Springs'), 

(40, 'Miami'), 

(41, 'Raleigh'), 

(42, 'Omaha'), 

(43, 'Long Beach'), 

(44, 'Virginia Beach'), 

(45, 'Oakland'), 

(46, 'Minneapolis'), 

(47, 'Tulsa'), 

(48, 'Wichita'), 

(49, 'New Orleans'), 

(50, 'Arlington'); 


--INSERT USERS 

INSERT INTO Users (UserName, ProfilePicture, Bio, MediaCount, FollowersCount, FollowingCount, UserAccountType, LocationID, EmailAddress, Password, UserFirstName, UserLastName)
VALUES 
('jane_doe', 0xabcdef0123456789, 'Hello World!', 10, 100, 50, 'regular', 3, 'jane_doe@example.com', 0x0123456789abcdef, 'Jane', 'Doe'),
('john_smith', 0x0123456789abcdef, 'I love coding!', 5, 200, 75, 'premium', 7, 'john_smith@example.com', 0xabcdef0123456789, 'John', 'Smith'),
('sara_williams', 0xabcdef0123456789, 'Music lover and foodie!', 15, 300, 100, 'regular', 2, 'sara_williams@example.com', 0x0123456789abcdef, 'Sara', 'Williams'),
('david_lee', 0x0123456789abcdef, 'Living life to the fullest!', 20, 400, 150, 'premium', 5, 'david_lee@example.com', 0xabcdef0123456789, 'David', 'Lee'),
('olivia_jones', 0xabcdef0123456789, 'Travel enthusiast!', 12, 500, 200, 'regular', 4, 'olivia_jones@example.com', 0x0123456789abcdef, 'Olivia', 'Jones'),
('adam_smith', 0x0123456789abcdef, 'Tech geek and gamer!', 8, 600, 250, 'premium', 9, 'adam_smith@example.com', 0xabcdef0123456789, 'Adam', 'Smith'),
('kate_williams', 0xabcdef0123456789, 'Animal lover and fitness enthusiast!', 18, 700, 300, 'regular', 6, 'kate_williams@example.com', 0x0123456789abcdef, 'Kate', 'Williams'),
('mike_johnson', 0x0123456789abcdef, 'Outdoor adventurer!', 25, 800, 350, 'premium', 1, 'mike_johnson@example.com', 0xabcdef0123456789, 'Mike', 'Johnson'),
('amy_lee', 0xabcdef0123456789, 'Artist and coffee lover!', 30, 900, 400, 'regular', 8, 'amy_lee@example.com', 0x0123456789abcdef, 'Amy', 'Lee'),
('jack_brown', 0x0123456789abcdef, 'Bookworm and cinephile!', 22, 1000, 450, 'premium', 10, 'jack_brown@example.com', 0xabcdef0123456789, 'Jack', 'Brown'),
('sophie_anderson', 0xabcdef0123456789, 'Fashionista and beauty blogger!', 17, 1100, 500, 'regular', 11, 'sophie_anderson@example.com', 0x0123456789abcdef, 'Sophie', 'Anderson'),
('eric_davis', 0x0123456789abcdef, 'Fitness freak and nutritionist!', 10, 1200, 550, 'premium', 12, 'eric_davis@example.com', 0xabcdef0123456789, 'Eric', 'Davis'),
('mikaela1992', 0x7FFE234F54A0, 'I love traveling and taking photos', 25, 200, 300, 'Premium', 3, 'mikaela1992@gmail.com', 0x36A6EE3C6BDB2D59, 'Mikaela', 'Johnson'),
('jacobsmith', 0x7FFE236F54C0, 'I am a software engineer', 150, 1500, 100, 'Free', 5, 'jacobsmith@gmail.com', 0x98A8AD49DCA9CFC4, 'Jacob', 'Smith'),
('alicerose', 0x7FFE238F54E0, 'Exploring the world, one adventure at a time', 80, 500, 400, 'Premium', 7, 'alicerose@hotmail.com', 0xC9ED5F5E5A5F8D5D, 'Alice', 'Rose'),
('taylorjones', 0x7FFE23AF5500, 'Dog mom & coffee addict ☕️🐶', 45, 250, 200, 'Free', 2, 'taylorjones@yahoo.com', 0x7FDDDE92C3A55A0E, 'Taylor', 'Jones'),
('maxwellhill', 0x7FFE23CF5520, 'Journalist, writer, and researcher', 200, 1000, 600, 'Premium', 4, 'maxwellhill@gmail.com', 0x2A59B342B963E37B, 'Maxwell', 'Hill'),
('jenniferadams', 0x7FFE23EF5540, 'Foodie and traveler 🌎🍔', 35, 300, 250, 'Free', 6, 'jenniferadams@gmail.com', 0xB654DD7F109FE80B, 'Jennifer', 'Adams'),
('brandonlee', 0x7FFE240F5560, 'Dreamer and doer', 100, 800, 400, 'Premium', 1, 'brandonlee@yahoo.com', 0x1A2B3C4D5E6F7F8A, 'Brandon', 'Lee'),
('oliviamiller', 0x7FFE242F5580, 'Books and tea are my happy place 📚☕️', 20, 150, 100, 'Free', 8, 'oliviamiller@hotmail.com', 0x9AB4E4FCD39C3DD1, 'Olivia', 'Miller'),
('chrisjackson', 0x7FFE244F55A0, 'Investor, traveler, and adrenaline junkie', 75, 500, 300, 'Premium', 3, 'chrisjackson@gmail.com', 0x2E26CCEF48B933E4, 'Chris', 'Jackson'),
('emma_watson', 0x0A1B2C3D4E5F, 'Actor and activist', 243, 1857364, 53, 'public', 5, 'emma.watson@example.com', 0x7A6B5C4D3E2F1, 'Emma', 'Watson'),
('robert_downey_jr', 0x6F5E4D3C2B1A, 'Actor and producer', 94, 1226378, 128, 'public', 2, 'robert.downey@example.com', 0x1B2C3D4E5F6A7, 'Robert', 'Downey Jr.'),
('dwayne_johnson', 0x7A6B5C4D3E2F, 'Actor and producer', 62, 2024887, 102, 'public', 6, 'dwayne.johnson@example.com', 0x3C2B1A5F4E3D, 'Dwayne', 'Johnson'),
('gwyneth_paltrow', 0x9E8F7D6C5B4A, 'Actor and entrepreneur', 123, 748369, 86, 'public', 1, 'gwyneth.paltrow@example.com', 0x5C4D3E2F1A7B9, 'Gwyneth', 'Paltrow'),
('chris_evans', 0xC3B2A1F9E8D7, 'Actor and director', 36, 981245, 73, 'public', 2, 'chris.evans@example.com', 0xA9B8C7D6E5F4, 'Chris', 'Evans'),
('angelina_jolie', 0xD6E5F4C3B2A1, 'Actor and filmmaker', 84, 1498365, 47, 'public', 3, 'angelina.jolie@example.com', 0xF9E8D7C6B5A4, 'Angelina', 'Jolie'),
('daniel_radcliffe', 0xE5F4D3C2B1A0, 'Actor and producer', 57, 1487392, 27, 'public', 5, 'daniel.radcliffe@example.com', 0x4D3E2F1A7B6C8, 'Daniel', 'Radcliffe'),
('scarlett_johansson', 0xF4E3D2C1B0A9, 'Actor and singer', 96, 2014793, 59, 'public', 4, 'scarlett.johansson@example.com', 0x2F1A7B6C5D4E8, 'Scarlett', 'Johansson'),
('benedict_cumberbatch', 0x1A2B3C4D5E6F, 'Actor and producer', 52, 897621, 44, 'public', 2, 'benedict.cumberbatch@example.com', 0xC3B2A1F9E8D7, 'Benedict', 'Cumberbatch'),
('johnsmith', 0x12AB, 'I am a software engineer.', 10, 100, 50, 'regular', 1, 'johnsmith@email.com', 0x5F5D, 'John', 'Smith'),
('jane_doe', 0x23CD, 'I am a graphic designer.', 8, 500, 200, 'premium', 2, 'jane_doe@email.com', 0xA1B2, 'Jane', 'Doe'),
('jimmyjones', 0x34EF, 'I am a musician.', 20, 300, 100, 'regular', 3, 'jimmyjones@email.com', 0xC3D4, 'Jimmy', 'Jones'),
('janedoe1', 0x45AB, 'I am a photographer.', 15, 400, 150, 'regular', 4, 'janedoe1@email.com', 0xE5F6, 'Jane', 'Doe'),
('billybob', 0x56CD, 'I am a farmer.', 5, 200, 75, 'regular', 5, 'billybob@email.com', 0x7D8F, 'Billy', 'Bob'),
('samanthasmith', 0x67EF, 'I am a teacher.', 12, 150, 80, 'regular', 6, 'samanthasmith@email.com', 0x9A1B, 'Samantha', 'Smith'),
('robertrodriguez', 0x78AB, 'I am a filmmaker.', 18, 250, 120, 'premium', 7, 'robertrodriguez@email.com', 0xB2C3, 'Robert', 'Rodriguez'),
('lindalopez', 0x89CD, 'I am a fashion designer.', 6, 50, 20, 'regular', 8, 'lindalopez@email.com', 0xD4E5, 'Linda', 'Lopez'),
('samueljackson', 0x9AEF, 'I am an actor.', 30, 1000, 500, 'premium', 9, 'samueljackson@email.com', 0xF6F7, 'Samuel', 'Jackson'),
('jilljohnson', 0xAB12, 'I am a writer.', 25, 800, 400, 'premium', 10, 'jilljohnson@email.com', 0x1B2C, 'Jill', 'Johnson'),
('davidlee', 0xBC34, 'I am a chef.', 9, 600, 300, 'regular', 11, 'davidlee@email.com', 0x3D4E, 'David', 'Lee'),
('harrypotter', 0xCD56, 'I am a wizard.', 3, 50, 25, 'regular', 12, 'harrypotter@email.com', 0x5E6F, 'Harry', 'Potter')

----- 
INSERT INTO Users (UserName, ProfilePicture, Bio, MediaCount, FollowersCount, FollowingCount, UserAccountType, LocationID, EmailAddress, Password, UserFirstName, UserLastName)
VALUES 
('johnsmith', 0x12AB, 'I am a software engineer.', 10, 100, 50, 'regular', 1, 'johnsmith@email.com', 0x5F5D, 'John', 'Smith'),
('jane_doe', 0x23CD, 'I am a graphic designer.', 8, 500, 200, 'premium', 2, 'jane_doe@email.com', 0xA1B2, 'Jane', 'Doe'),
('jimmyjones', 0x34EF, 'I am a musician.', 20, 300, 100, 'regular', 3, 'jimmyjones@email.com', 0xC3D4, 'Jimmy', 'Jones'),
('janedoe1', 0x45AB, 'I am a photographer.', 15, 400, 150, 'regular', 4, 'janedoe1@email.com', 0xE5F6, 'Jane', 'Doe'),
('billybob', 0x56CD, 'I am a farmer.', 5, 200, 75, 'regular', 5, 'billybob@email.com', 0x7D8F, 'Billy', 'Bob'),
('samanthasmith', 0x67EF, 'I am a teacher.', 12, 150, 80, 'regular', 6, 'samanthasmith@email.com', 0x9A1B, 'Samantha', 'Smith'),
('robertrodriguez', 0x78AB, 'I am a filmmaker.', 18, 250, 120, 'premium', 7, 'robertrodriguez@email.com', 0xB2C3, 'Robert', 'Rodriguez'),
('lindalopez', 0x89CD, 'I am a fashion designer.', 6, 50, 20, 'regular', 8, 'lindalopez@email.com', 0xD4E5, 'Linda', 'Lopez'),
('samueljackson', 0x9AEF, 'I am an actor.', 30, 1000, 500, 'premium', 9, 'samueljackson@email.com', 0xF6F7, 'Samuel', 'Jackson'),
('jilljohnson', 0xAB12, 'I am a writer.', 25, 800, 400, 'premium', 10, 'jilljohnson@email.com', 0x1B2C, 'Jill', 'Johnson'),
('davidlee', 0xBC34, 'I am a chef.', 9, 600, 300, 'regular', 11, 'davidlee@email.com', 0x3D4E, 'David', 'Lee'),
('harrypotter', 0xCD56, 'I am a wizard.', 3, 50, 25, 'regular', 12, 'harrypotter@email.com', 0x5E6F, 'Harry', 'Potter')

-----
INSERT INTO Users (UserName, ProfilePicture, Bio, MediaCount, FollowersCount, FollowingCount, UserAccountType, LocationID, EmailAddress, Password, UserFirstName, UserLastName)
VALUES 
('johnsmith1', 0x12AB, 'I am a software engineer.', 10, 100, 50, 'regular', 1, 'johnsmith@email.com', 0x5F5D, 'John', 'Smith'),
('jane_doe1', 0x23CD, 'I am a graphic designer.', 8, 500, 200, 'premium', 2, 'jane_doe@email.com', 0xA1B2, 'Jane', 'Doe'),
('jimmyjones1', 0x34EF, 'I am a musician.', 20, 300, 100, 'regular', 3, 'jimmyjones@email.com', 0xC3D4, 'Jimmy', 'Jones'),
('janedoe11', 0x45AB, 'I am a photographer.', 15, 400, 150, 'regular', 4, 'janedoe1@email.com', 0xE5F6, 'Jane', 'Doe'),
('billybob1', 0x56CD, 'I am a farmer.', 5, 200, 75, 'regular', 5, 'billybob@email.com', 0x7D8F, 'Billy', 'Bob'),
('samanthasmith1', 0x67EF, 'I am a teacher.', 12, 150, 80, 'regular', 6, 'samanthasmith@email.com', 0x9A1B, 'Samantha', 'Smith'),
('robertrodriguez1', 0x78AB, 'I am a filmmaker.', 18, 250, 120, 'premium', 7, 'robertrodriguez@email.com', 0xB2C3, 'Robert', 'Rodriguez'),
('lindalopez1', 0x89CD, 'I am a fashion designer.', 6, 50, 20, 'regular', 8, 'lindalopez@email.com', 0xD4E5, 'Linda', 'Lopez'),
('samueljackson1', 0x9AEF, 'I am an actor.', 30, 1000, 500, 'premium', 9, 'samueljackson@email.com', 0xF6F7, 'Samuel', 'Jackson'),
('jilljohnson1', 0xAB12, 'I am a writer.', 25, 800, 400, 'premium', 10, 'jilljohnson@email.com', 0x1B2C, 'Jill', 'Johnson'),
('davidlee1', 0xBC34, 'I am a chef.', 9, 600, 300, 'regular', 11, 'davidlee@email.com', 0x3D4E, 'David', 'Lee'),
('harrypotter1', 0xCD56, 'I am a wizard.', 3, 50, 25, 'regular', 12, 'harrypotter@email.com', 0x5E6F, 'Harry', 'Potter')

-----

------
Update Users set FollowersCount = 0
Update Users set FollowingCount = 0
------

-- INSERT UserLogin

INSERT INTO UserLogin (UserLoginID, UserID, LoginTime, LogoutTime, Duration)
VALUES
  (1, 1, '2023-04-05 09:00:00', '2023-04-05 09:30:00', NULL),
  (2, 2, '2023-04-05 10:00:00', '2023-04-05 10:30:00', NULL),
  (3, 3, '2023-04-05 11:00:00', '2023-04-05 11:30:00', NULL),
  (5, 5, '2023-04-05 13:00:00', '2023-04-05 13:30:00', NULL),
  (6, 6, '2023-04-05 14:00:00', '2023-04-05 14:30:00', NULL),
  (7, 7, '2023-04-05 15:00:00', '2023-04-05 15:30:00', NULL),
  (8, 8, '2023-04-05 16:00:00', '2023-04-05 16:30:00', NULL),
  (9, 9, '2023-04-05 17:00:00', '2023-04-05 17:30:00', NULL),
  (10, 10, '2023-04-05 18:00:00', '2023-04-05 18:30:00', NULL),
  (11, 11, '2023-04-06 09:00:00', '2023-04-06 09:30:00', NULL),
  (12, 12, '2023-04-06 10:00:00', '2023-04-06 10:30:00', NULL),
  (13, 13, '2023-04-06 11:00:00', '2023-04-06 11:30:00', NULL),
  (14, 14, '2023-04-06 12:00:00', '2023-04-06 12:30:00', NULL),
  (15, 15, '2023-04-06 13:00:00', '2023-04-06 13:30:00', NULL),
  (16, 16, '2023-04-06 14:00:00', '2023-04-06 14:30:00', NULL),
  (17, 17, '2023-04-06 15:00:00', '2023-04-06 15:30:00', NULL),
  (18, 18, '2023-04-06 16:00:00', '2023-04-06 16:30:00', NULL),
  (19, 19, '2023-04-06 17:00:00', '2023-04-06 17:30:00', NULL),
  (21, 21, '2023-04-07 09:00:00', '2023-04-07 09:30:00', NULL),
  (22, 22, '2023-04-07 10:00:00', '2023-04-07 10:30:00', NULL),
  (23, 23, '2023-04-07 11:00:00', '2023-04-07 11:30:00', NULL),
  (24, 24, '2023-04-07 12:00:00', '2023-04-07 12:30:00', NULL),
  (25, 25, '2023-04-07 13:00:00', '2023-04-07 13:30:00', NULL),
  (26, 26, '2023-04-07 14:00:00', '2023-04-07 14:30:00', NULL),
  (27, 27, '2023-04-07 15:00:00', '2023-04-07 15:30:00', NULL),
  (28, 28, '2023-04-07 16:00:00', '2023-04-07 16:30:00', NULL),
  (29, 29, '2023-04-07 17:00:00', '2023-04-07 17:30:00', NULL),
  (30, 30, '2023-04-07 18:00:00', '2023-04-07 18:30:00', NULL),
  (31, 31, '2023-04-08 09:00:00', '2023-04-08 09:30:00', NULL),
  (32, 32, '2023-04-08 10:00:00', '2023-04-08 10:30:00', NULL),
  (33, 33, '2023-04-08 11:00:00', '2023-04-08 11:30:00', NULL),
  (34, 34, '2023-04-08 12:00:00', '2023-04-08 12:30:00', NULL),
  (35, 35, '2023-04-08 13:00:00', '2023-04-08 13:30:00', NULL),
  (36, 36, '2023-04-08 14:00:00', '2023-04-08 14:30:00', NULL),
  (37, 37, '2023-04-08 15:00:00', '2023-04-08 15:30:00', NULL),
  (38, 38, '2023-04-08 16:00:00', '2023-04-08 16:30:00', NULL),
  (39, 39, '2023-04-08 17:00:00', '2023-04-08 17:30:00', NULL),
  (40, 40, '2023-04-08 17:20:00', '2023-04-08 17:40:00', NULL),
  (41, 41, '2023-04-08 18:00:00', '2023-04-08 18:30:00', NULL),
  (42, 42, '2023-04-09 09:00:00', '2023-04-09 09:30:00', NULL),
  (43, 43, '2023-04-09 10:00:00', '2023-04-09 10:30:00', NULL),
  (44, 44, '2023-04-09 11:00:00', '2023-04-09 11:30:00', NULL),
  (45, 45, '2023-04-09 12:00:00', '2023-04-09 12:30:00', NULL),
  (46, 46, '2023-04-09 13:00:00', '2023-04-09 13:30:00', NULL),
  (47, 47, '2023-04-09 14:00:00', '2023-04-09 14:30:00', NULL),
  (48, 48, '2023-04-09 15:00:00', '2023-04-09 15:30:00', NULL),
  (49, 49, '2023-04-09 16:00:00', '2023-04-09 16:30:00', NULL),
  (50, 49, '2023-04-09 19:00:00', '2023-04-09 21:30:00', NULL),
  (51, 2, '2023-04-09 12:00:00', '2023-04-09 18:30:00', NULL),
  (52, 3, '2023-04-09 13:00:00', '2023-04-09 15:30:00', NULL),
  (53, 4, '2023-04-09 22:00:00', '2023-04-09 23:00:00', NULL),
  (54, 5, '2023-04-09 14:00:00', '2023-04-09 17:30:00', NULL),
  (55, 3, '2023-04-09 18:00:00', '2023-04-09 21:30:00', NULL),
  (56, 6, '2023-04-09 15:00:00', '2023-04-09 21:30:00', NULL),
  (57, 1, '2023-04-09 12:00:00', '2023-04-09 15:30:00', NULL),
  (58, 1, '2023-04-09 16:00:00', '2023-04-09 22:30:00', NULL),
  (59, 2, '2023-04-09 19:00:00', '2023-04-09 23:30:00', NULL),
  (60, 10, '2023-04-09 08:00:00', '2023-04-09 12:30:00', NULL),
  (61, 15, '2023-04-09 15:00:00', '2023-04-09 17:30:00', NULL),
  (62, 15, '2023-04-09 20:00:00', '2023-04-09 22:30:00', NULL),
  (63, 17, '2023-04-09 17:00:00', '2023-04-09 23:30:00', NULL),
  (65, 19, '2023-04-09 18:00:00', '2023-04-09 23:30:00', NULL),
  (66, 21, '2023-04-09 10:00:00', '2023-04-09 13:30:00', NULL),
  (67, 22, '2023-04-09 15:00:00', '2023-04-09 17:30:00', NULL),
  (68, 21, '2023-04-09 16:00:00', '2023-04-09 22:30:00', NULL),
  (69, 20, '2023-04-09 20:00:00', '2023-04-09 23:30:00', NULL),
  (70, 4, '2023-04-09 16:00:00', '2023-04-09 21:30:00', NULL);




-- INSERT Media

INSERT INTO Media (MediaID, CreatedDate, MediaType, InteractionCount, UserID, LocationID, Caption, Content)
VALUES
(1, '2022-01-01 10:00:00', 1, 100, 1, 1, 'Happy New Year!', 0x424d5601340000000000),
(2, '2022-01-02 12:00:00', 2, 50, 2, 2, 'Enjoying the sunshine ☀️', 0x424d5601350000000000),
(3, '2022-01-03 15:00:00', 3, 80, 3, 3, 'Feeling cozy at home 🏠', 0x424d5601360000000000),
(4, '2022-01-04 18:00:00', 2, 120, 4, 4, 'Night out with friends 🥳', 0x424d5601370000000000),
(5, '2022-01-05 10:30:00', 1, 90, 5, 5, 'Morning coffee ☕️', 0x424d5601380000000000),
(6, '2022-01-06 14:00:00', 3, 75, 6, 6, 'Exploring new places 🌎', 0x424d5601390000000000),
(7, '2022-01-07 20:00:00', 2, 200, 7, 7, 'Cozy night in 🍿', 0x424d5601400000000000),
(8, '2022-01-08 11:00:00', 1, 150, 8, 8, 'Weekend vibes 😎', 0x424d5601410000000000),
(9, '2022-01-09 13:00:00', 3, 70, 9, 9, 'Sunday Funday! 🎉', 0x424d5601420000000000),
(10, '2022-01-10 16:00:00', 1, 110, 10, 10, 'Work hard, play hard 💪', 0x424d5601430000000000),
(11, '2021-07-12 10:30:00', 1, 70, 2, 2, 'My morning coffee', 0xabcdef123456789),
(12, '2021-07-14 14:45:00', 2, 200, 3, 3, 'Fun day at the amusement park!', 0x123456789abcdef),
(13, '2021-07-16 08:20:00', 3, 150, 4, 4, 'Exploring the city', 0x789abcdef123456),
(14, '2021-07-18 16:10:00', 1, 80, 5, 5, 'Taking in the views', 0x456789abcdef123),
(15, '2021-07-20 12:30:00', 2, 120, 6, 6, 'Beach day with my favorite people', 0xabcdef123456789),
(16, '2022-01-16 09:00:00', 1, 150, 7, 8, 'Morning hike with friends 🌲', 0x424d5601570000000000), 
(17, '2022-01-17 14:00:00', 2, 90, 8, 9, 'Lunchtime at the park 🍔', 0x424d5601580000000000), 
(18, '2022-01-18 18:00:00', 3, 80, 9, 10, 'Catching up on some reading 📚', 0x424d5601590000000000), 
(19, '2022-01-19 10:30:00', 1, 120, 10, 1, 'Coffee with a view ☕️🏙', 0x424d5601600000000000), 
(20, '2022-01-20 15:00:00', 2, 70, 1, 2, 'Meeting up with old friends 🤗', 0x424d5601610000000000), 
(21, '2022-01-21 20:00:00', 3, 200, 2, 3, 'Movie night with the family 🎥🍿', 0x424d5601620000000000), 
(22, '2022-01-22 11:00:00', 1, 150, 3, 4, 'Weekend brunch with the girls 🥞🍳', 0x424d5601630000000000), 
(23, '2022-01-23 13:00:00', 3, 70, 4, 5, 'Lazy Sunday at home 🛋', 0x424d5601640000000000), 
(24, '2022-01-24 16:00:00', 1, 110, 5, 6, 'Sunny day at the beach ☀️🌊', 0x424d5601650000000000), 
(25, '2022-01-25 10:00:00', 2, 100, 6, 7, 'Morning run in the park 🏃‍♀️🌳', 0x424d5601660000000000), 
(26, '2022-01-26 14:00:00', 3, 75, 7, 8, 'Trying out a new recipe 🍽', 0x424d5601670000000000), 
(27, '2022-01-27 20:00:00', 2, 200, 8, 9, 'Cozy night in with a good book 📖🍷', 0x424d5601680000000000), 
(28, '2022-01-28 11:00:00', 1, 150, 9, 10, 'Mid-morning coffee break ☕️', 0x424d5601690000000000),
(29, '2022-01-29 11:00:00', 2, 150, 9, 10, 'Mid-morning coffee break ☕️', 0x424d5601690000000000)



-- INSERT Filter 

INSERT INTO Filters (FilterID, FilterName) 

VALUES  

(1, 'Clarendon'), 

(2, 'Gingham'), 

(3, 'Lark'), 

(4, 'Moon'), 

(5, 'Reyes'), 

(6, 'Juno'), 

(7, 'Slumber'), 

(8, 'Crema'), 

(9, 'Ludwig'), 

(10, 'Aden'), 

(11, 'Perpetua'), 

(12, 'Amaro'), 

(13, 'Mayfair'), 

(14, 'Rise'), 

(15, 'Hudson'), 

(16, 'Valencia'), 

(17, 'X-Pro II'), 

(18, 'Sierra'), 

(19, 'Willow'), 

(20, 'Lo-Fi'), 

(21, 'Inkwell'), 

(22, 'Hefe'), 

(23, 'Nashville'), 

(24, 'Stinson'), 

(25, 'Vesper'), 

(26, 'Earlybird'), 

(27, 'Brannan'), 

(28, 'Sutro'), 

(29, 'Toaster'), 

(30, 'Walden'), 

(31, '1977'), 

(32, 'Kelvin'), 

(33, 'Maven'), 

(34, 'Ginza'), 

(35, 'Skyline'), 

(36, 'Dogpatch'), 

(37, 'Charmes'), 

(38, 'Brooklyn'), 

(39, 'Helena'), 

(40, 'Ashby'), 

(41, 'Chloe'), 

(42, 'Maggie'), 

(43, 'Alfred'), 

(44, 'Ruby'), 

(45, 'Mia'), 

(46, 'Bianca'), 

(47, 'Zara'), 

(48, 'Gigi'), 

(49, 'Ava'), 

(50, 'Poppy'); 

-- INSERT MediaFilter

INSERT INTO MediaFilter (FilterID, MediaID) VALUES 

(1, 1), 

(2, 1), 

(3, 2), 

(4, 2), 

(5, 3), 

(6, 3), 

(7, 4), 

(8, 4), 

(9, 5), 

(10, 5), 

(11, 6), 

(12, 6), 

(13, 7), 

(14, 7), 

(15, 8), 

(16, 8), 

(17, 9), 

(18, 9), 

(19, 10), 

(20, 10), 

(21, 11), 

(22, 11), 

(23, 12), 

(24, 12), 

(25, 13), 

(26, 13), 

(27, 14), 

(28, 14), 

(29, 15), 

(30, 15), 

(31, 16), 

(32, 16), 

(33, 17), 

(34, 17), 

(35, 18), 

(36, 18), 

(37, 19), 

(38, 19), 

(39, 20), 

(40, 20), 

(41, 21), 

(42, 21), 

(43, 22), 

(44, 22), 

(45, 23), 

(46, 23), 

(47, 24), 

(48, 24), 

(49, 25), 

(50, 25); 



-- INSERT Hashtags

INSERT INTO Hashtags (HashtagType, HashtagName) VALUES 

('Topic','#covid19'), 

('Brand','#nike'), 

('Topic','#climatechange'), 

('Event','#Olympics'), 

('Brand','#apple'), 

('Topic','#vegan'), 

('Brand','#cocacola'), 

('Topic','#fashion'), 

('Brand','#adidas'), 

('Event','#SuperBowl'), 

('Brand','#mcdonalds'), 

('Topic','#travel'), 

('Brand','#amazon'), 

('Topic','#fitness'), 

('Event','#Eurovision'), 

('Brand','#nintendo'), 

('Topic','#music'), 

('Brand','#pepsi'), 

('Topic','#beauty'), 

('Event','#WorldCup'), 

('Brand','#bmw'), 

('Topic','#foodie'), 

('Brand','#tesla'), 

('Event','#Grammys'), 

('Brand','#samsung'), 

('Topic','#pets'), 

('Event','#Cannes'), 

('Brand','#nissan'), 

('Topic','#photography'), 

('Event','#Emmys'), 

('Brand','#honda'), 

('Topic','#movies'), 

('Brand','#volkswagen'), 

('Topic','#art'), 

('Event','#Tonys'), 

('Brand','#toyota'), 

('Topic','#design'), 

('Brand','#lg'), 

('Topic','#wedding'), 

('Event','#GoldenGlobes'), 

('Brand','#gucci'), 

('Topic','#gaming'), 

('Brand','#underarmour'), 

('Topic','#DIY'), 

('Event','#AcademyAwards'), 

('Brand','#puma'), 

('Topic','#bookstagram'), 

('Event','#CMAAwards'), 

('Brand','#reebok'), 

('Topic','#cooking'), 

('Brand','#nivea'); 

-- INSERT into MediaHashtags

INSERT INTO MediaHashtags (MediaID, HashtagID) VALUES 

(1, 1), 

(1, 2), 

(1, 3), 

(2, 2), 

(2, 4), 

(3, 1), 

(3, 5), 

(4, 2), 

(4, 6), 

(5, 7), 

(6, 8), 

(7, 9), 

(8, 1), 

(8, 2), 

(9, 10), 

(10, 5), 

(11, 11), 

(11, 12), 

(11, 13), 

(12, 14), 

(13, 15), 

(14, 16), 

(15, 17), 

(16, 18), 

(17, 19), 

(18, 20), 

(19, 21), 

(20, 22), 

(21, 23), 

(22, 24), 

(23, 25), 

(24, 26);

-- INSERT into MediaHashtags

INSERT INTO MediaHashtags (MediaID, HashtagID) VALUES

(1, 4),

(1, 5),

(1, 6),

(1, 7),

(1, 8),

(1, 9),

(1, 10),

(2, 1),

(2, 3),

(2, 5),

(2, 6),

(2, 7),

(2, 8),

(2, 9),

(3, 2),

(3, 4),

(3, 6),

(3, 7),

(3, 8),

(4, 1),

(4, 3),

(4, 4),

(4, 5),

(4, 6),

(5, 1),

(1,21),

(2,21),

(3,21),

(4,21),

(5,21),

(6,21),

(7,21),

(8,21),

(9,21),

(13,21),

(15,21);


-- INSERT into Tags

INSERT INTO Tags (UserID, MediaID, TaggedText) 

VALUES (1, 1,'friend1'), 

       (1, 1,'friend2'), 

       (2, 2,'family1'), 

       (2, 2,'family2'), 

       (3, 3,'pet1'), 

       (4, 4,'beach'), 

       (5, 5,'food1'), 

       (6, 6,'nature1'), 

       (7, 7,'city1'), 

       (8, 8,'travel1'), 

       (9, 9,'selfie'), 

       (10, 10,'art1'), 

       (11, 11,'fashion1'), 

       (12, 12,'music1'), 

       (13, 13,'book1'), 

       (14, 14,'sport1'), 

       (15, 15,'car1'), 

       (16, 16,'home1'), 

       (17, 17,'work1'), 

       (18, 18,'study1'), 

       (19, 19,'nightlife1'), 

       (20, 20,'friend3'), 

       (21, 21,'family3'), 

       (22, 22,'pet2'), 

       (23, 23,'beach2'), 

       (24, 24,'food2'), 

       (25, 25,'nature2'), 

       (26, 26,'city2');
     
--    INSERT into Interactions 
      
         
 INSERT INTO Interactions (InteractionID, InteractionType, UserID, MediaID, CommentText, Sentiment, Date) VALUES
(1, 1, 1, 1, 'Great post!', 'Positive', '2022-03-30 12:00:00'),
(2, 2, 2, 2, 'This is awesome!', 'Positive', '2022-03-31 14:00:00'),
(3, 1, 3, 3, 'Interesting article', 'Neutral', '2022-04-01 15:00:00'),
(4, 2, 4, 4, 'Thanks for sharing!', 'Positive', '2022-04-02 16:00:00'),
(5, 1, 5, 5, 'This is helpful', 'Positive', '2022-04-03 10:00:00'),
(6, 2, 6, 6, 'I disagree with this', 'Negative', '2022-04-04 11:00:00'),
(7, 1, 7, 7, 'I have a question', 'Neutral', '2022-04-05 12:00:00'),
(8, 2, 8, 8, 'This is confusing', 'Negative', '2022-04-06 13:00:00'),
(9, 1, 9, 9, 'This is well-written', 'Positive', '2022-04-07 14:00:00'),
(10, 2, 10, 10, 'I agree with this', 'Positive', '2022-04-08 15:00:00'),
(11, 1, 11, 11, 'Thanks for the info', 'Positive', '2022-04-09 16:00:00'),
(12, 2, 12, 12, 'I found a mistake', 'Negative', '2022-04-10 10:00:00'),
(13, 1, 13, 13, 'Can you explain more?', 'Neutral', '2022-04-11 11:00:00'),
(14, 2, 14, 14, 'This is useful', 'Positive', '2022-04-12 12:00:00'),
(15, 1, 15, 15, 'I have a suggestion', 'Neutral', '2022-04-13 13:00:00'),
(16, 2, 16, 16, 'This is not helpful', 'Negative', '2022-04-14 14:00:00'),
(17, 1, 17, 17, 'I need help with this', 'Neutral', '2022-04-15 15:00:00'),
(18, 2, 18, 18, 'This is incorrect', 'Negative', '2022-04-16 16:00:00'),
(19, 1, 19, 19, 'This is interesting', 'Neutral', '2022-04-17 10:00:00')
;

INSERT INTO Interactions (InteractionID,InteractionType, UserID, MediaID, Date , CommentText, Sentiment)

VALUES (35, 2, 4, 3, '2022-12-13 12:00:00.000' ,'bad','negative');

 

INSERT INTO Interactions (InteractionID,InteractionType, UserID, MediaID, Date , CommentText, Sentiment)

VALUES (36, 2, 4, 4, '2022-12-13 12:00:00.000' ,'bad','negative');

 

INSERT INTO Interactions (InteractionID,InteractionType, UserID, MediaID, Date , CommentText, Sentiment)

VALUES (37, 2, 4, 5, '2022-12-13 12:00:00.000' ,'bad','negative');

 

INSERT INTO Interactions (InteractionID,InteractionType, UserID, MediaID, Date , CommentText, Sentiment)

VALUES (38, 2, 4, 6, '2022-12-13 12:00:00.000' ,'bad','negative');

 

INSERT INTO Interactions (InteractionID,InteractionType, UserID, MediaID, Date , CommentText, Sentiment)

VALUES (39, 2, 4, 7, '2022-12-13 12:00:00.000' ,'bad','negative');

 

INSERT INTO Interactions (InteractionID,InteractionType, UserID, MediaID, Date , CommentText, Sentiment)

VALUES (40, 2, 4, 8, '2022-12-13 12:00:00.000' ,'bad','negative');

 



INSERT INTO Interactions (InteractionID,InteractionType, UserID, MediaID, Date , CommentText, Sentiment)

VALUES (47, 2, 5, 14, '2023-03-15 12:00:00.000' ,'Great post!', 'Positive');

 

INSERT INTO Interactions (InteractionID,InteractionType, UserID, MediaID, Date , CommentText, Sentiment)

VALUES (48, 2, 5, 14, '2023-03-16 12:00:00.000' ,'I love this!', 'Positive');

 

INSERT INTO Interactions (InteractionID,InteractionType, UserID, MediaID, Date , CommentText, Sentiment)

VALUES (49, 2, 5, 15, '2023-03-18 12:00:00.000' ,'Awesome!', 'Positive');

 

INSERT INTO Interactions (InteractionID,InteractionType, UserID, MediaID, Date , CommentText, Sentiment)

VALUES (50, 2, 5, 15, '2023-03-20 12:00:00.000' ,'So inspiring!', 'Positive');

 

INSERT INTO Interactions (InteractionID,InteractionType, UserID, MediaID, Date , CommentText, Sentiment)

VALUES (51, 2, 5, 16, '2023-03-22 12:00:00.000' ,'This is great!', 'Positive');

 

INSERT INTO Interactions (InteractionID,InteractionType, UserID, MediaID, Date , CommentText, Sentiment)

VALUES (52, 2, 5, 16, '2023-03-24 12:00:00.000' ,'I couldn''t agree more!', 'Positive');

 

INSERT INTO Interactions (InteractionID,InteractionType, UserID, MediaID, Date , CommentText, Sentiment)

VALUES (53, 2, 5, 17, '2023-03-26 12:00:00.000' ,'I learned a lot from this post!', 'Positive');

 

INSERT INTO Interactions (InteractionID,InteractionType, UserID, MediaID, Date , CommentText, Sentiment)

VALUES (54, 2, 5, 17, '2023-03-27 12:00:00.000' ,'This is exactly what I needed to read today!', 'Positive');

 

INSERT INTO Interactions (InteractionID,InteractionType, UserID, MediaID, Date , CommentText, Sentiment)

VALUES (55, 2, 5, 18, '2023-03-28 12:00:00.000' ,'Thank you for sharing!', 'Positive');

 

INSERT INTO Interactions (InteractionID,InteractionType, UserID, MediaID, Date , CommentText, Sentiment)

VALUES (56, 2, 5, 18, '2022-03-30 12:00:00.000' ,'This is amazing!', 'Positive');

 

INSERT INTO Interactions (InteractionID,InteractionType, UserID, MediaID, Date , CommentText, Sentiment)

VALUES (57, 2, 5, 18, '2023-03-6 12:00:00.000' ,'This is amazing!', 'Positive');

 

INSERT INTO Interactions (InteractionID, InteractionType, UserID, MediaID, CommentText, Sentiment, Date)

VALUES (58, 1, 1, 1, 'Great post!', 'Neutral', '2023-03-30 12:00:00');


INSERT INTO Interactions (InteractionID, InteractionType, UserID, MediaID, CommentText, Sentiment, Date)

VALUES (59, 1, 1, 1, 'Great post!', 'Positive', '2023-04-05 12:00:00'), -- today's date

(60, 1, 2, 2, 'I disagree', 'Negative', '2023-03-15 12:00:00'), -- over 1 month ago

(61, 2, 3, 3, 'Thanks for sharing', 'Positive', '2023-04-01 12:00:00'), -- within the last month

(62, 1, 4, 4, 'Awesome!', 'Positive', '2023-04-03 12:00:00'), -- within the last month

(63, 1, 5, 5, 'Could be better', 'Negative', '2023-03-31 12:00:00'), -- within the last month

(64, 2, 1, 6, 'Interesting point', 'Neutral', '2023-03-20 12:00:00'); -- over 1 month ago




INSERT INTO Interactions (InteractionID, InteractionType, UserID, MediaID, CommentText, Sentiment, Date)

VALUES (66, 1, 1, 1, 'Great post!', 'Positive', '2023-03-06 12:00:00');




 

-- INSERT into Followers

INSERT INTO Followers (FollowerID, UserID, FollowedDate) 

VALUES 

(1, 2, '2022-01-01 12:00:00'), 
(2, 3, '2022-01-02 12:00:00'), 
(3, 4, '2022-01-03 12:00:00'), 
(4, 5, '2022-01-04 12:00:00'), 
(5, 6, '2022-01-05 12:00:00'), 
(6, 7, '2022-01-06 12:00:00'), 
(7, 8, '2022-01-07 12:00:00'), 
(8, 9, '2022-01-08 12:00:00'), 
(9, 10, '2022-01-09 12:00:00'), 
(10, 11, '2022-01-10 12:00:00'), 
(11, 12, '2022-01-11 12:00:00'), 
(12, 13, '2022-01-12 12:00:00'), 
(13, 14, '2022-01-13 12:00:00'), 
(14, 15, '2022-01-14 12:00:00'), 
(15, 16, '2022-01-15 12:00:00'), 
(16, 17, '2022-01-16 12:00:00'), 
(17, 18, '2022-01-17 12:00:00'), 
(18, 19, '2022-01-18 12:00:00'), 
(19, 20, '2022-01-19 12:00:00'), 
(20, 21, '2022-01-20 12:00:00'), 
(21, 22, '2022-01-21 12:00:00'), 
(22, 23, '2022-01-22 12:00:00'), 
(23, 24, '2022-01-23 12:00:00'), 
(24, 25, '2022-01-24 12:00:00'), 
(25, 26, '2022-01-25 12:00:00'), 
(26, 27, '2022-01-26 12:00:00'), 
(27, 28, '2022-01-27 12:00:00'), 
(28, 29, '2022-01-28 12:00:00'), 
(29, 30, '2022-01-29 12:00:00'), 
(30, 31, '2022-01-30 12:00:00'), 
(31, 32, '2022-01-31 12:00:00'), 
(32, 33, '2022-02-01 12:00:00'), 
(33, 34, '2022-02-02 12:00:00'), 
(34, 35, '2022-02-03 12:00:00'), 
(35, 36, '2022-02-04 12:00:00'), 
(36, 37, '2022-02-05 12:00:00');

--- Password Encryption execution query

DECLARE @i INT = 1

DECLARE @max_user_id INT = 54

 

WHILE @i <= @max_user_id

BEGIN

  UPDATE dbo.Users

  SET Password = EncryptByKey(Key_GUID(N'TestSymmetricKey'), CONVERT(varbinary, 'PassTS1'))

  WHERE UserID = @i;


  SET @i = @i + 1

END





--- Executing Procedure updateFollowCounts for user 13 to make sure 
--- EXEC updateFollowCounts @FollowerID = 13;

---- select query for the view HashtagCounts

SELECT * FROM HashtagCounts ORDER BY value_occurrence DESC;
---- select query for the view MostVisitedLocations
SELECT * FROM MostVisitedLocations ORDER BY value_occurrence DESC;
-- Select query for the view CommentSentimentCounts
SELECT * FROM CommentSentimentCounts csc 



--- check level constraint validation
-- this works fine
INSERT INTO Interactions (InteractionID, InteractionType, UserID, MediaID, CommentText, Sentiment, Date)

VALUES (33, 2, 4, 13, 'I am not impressed', 'Negative', '2022-04-11 00:00:00');
--- this violates check constraint
INSERT INTO Interactions (InteractionID, InteractionType, UserID, MediaID, CommentText, Sentiment, Date)

VALUES (67, 2, 4, 2, 'I am not impressed', 'negative', '2022-04-11 00:00:00');

-- Execute Stored PROCEDURE 

EXEC GetTopFiveInfluencers;













