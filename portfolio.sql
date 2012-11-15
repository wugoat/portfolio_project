-- SQL for the portfolio project


--
-- portfolio users.  Self explanatory
--
create table portfolio_users (
-- Each user must have an email address and it must be unique
-- the constraint checks to see that there is an "@" in the name
  email varchar(256) not null primary key,
    constraint email_ok CHECK (email LIKE '%@%'),
-- Each user must have a name.
  name  varchar(64) not null,
-- Each user must have a password of at least seven characters
  passwd VARCHAR(64) NOT NULL,
    constraint long_passwd CHECK (passwd LIKE '_______%')
);

create table portfolios (
  user_email varchar(256) not null references portfolio_users(email) ON DELETE cascade,
  name varchar(64) not null,
  cash number default 0,
  primary key(name, user_email)
);


create table new_stocks_daily (
-- this will hold all the stocks daily info for data mined since the end of the stocks_daily table
  symbol char(16) not null references cs339.StocksSymbols(symbol),
  timestamp number not null unique,
  open number not null,
  high number not null,
  low number not null,
  close number not null,
  volume number not null
  );

create table holdings (
  portfolio not null references portfolios(name, user_email),
  symbol char(16) unique not null references cs339.StocksSymbols(symbol),
  count number not null
  );

create table transactions (
  timestamp number not null unique,
  portfolio_acctid varchar(16) not null references portfolios(acctid),
  symbol char(16) not null references holdings(symbol),
  type varchar(4) not null,
  quantity number not null
  );


quit;
