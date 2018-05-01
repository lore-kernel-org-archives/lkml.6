Return-Path: <tytso@thunk.org>
X-Google-Smtp-Source: AB8JxZqQlwBg/qi1JpANgQBn+cU7w4eVwUW35MysL7DFu6jC2+EOSvjuromeHC7qNc/SyihQVhLz
ARC-Seal: i=1; a=rsa-sha256; t=1525203893; cv=none;
        d=google.com; s=arc-20160816;
        b=G0HedYJDRilHSHWjDtTQScwXEDLSwnK36F6K59evml7B03kCYTjvOf0aJezlkKdKW2
         DeojEFw/qqT0PN6anTlGQLd7N7SUv6a+ZTM27GGZp9eoxM64klO3oOI68aUmJAxAkW6L
         Sx4T1dap4VTvpLgUVyut2OLrsMCN5vT5nU1Vch5nrKL2j7h9GckThU3ZdjUq3UvktilB
         EIUiyCulGGd8q2GBcgprzLn28MSs9nl0kKnW3r71nl4GSG25+nmWHho7jcScbs7dM6Dd
         8VjtDMv/pSx6YZCJ6Pgjad9o2DYS/uvhOtvUbw/URsl0YZrkKi8YYPyXY673cw91fXr0
         45AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=HqIowR+sbiMsVxcjRKMzalryKDPi8FdEXAM4Lt4DMKc=;
        b=fjK8Imi2jaNDi3MGXVzIJ7onrQLlI56LvzKjIOrMv9Yz5BrdrW1aRQNXc61b1SWLig
         Ox5790JvH0Jp8HxcygynolSv4tE1fXZlV8h9XtBM6Znayvj4TrIkLQ3H/+6QpT439yZW
         fVr/cOCn4S5Jjhv7hK4bynRuKkqCJ/D2luT8Tvonbq3Cx50gbExTpE3uARAipPklcu4g
         +4EnxVB56qfdfOARHHrc+cMO83KARQsgeziwrr7ZCsCCR6SoriUZ/fNpmHwWHxIkTddS
         R0VOON+F8p+6Z2V4ReKznzdpBClDJgvGDW2INYLjiGKQvhC7p0mVoRPzltFXPHXIHURE
         AgVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=lrfrSrvL;
       spf=pass (google.com: domain of tytso@thunk.org designates 2600:3c02::f03c:91ff:fe96:be03 as permitted sender) smtp.mailfrom=tytso@thunk.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=lrfrSrvL;
       spf=pass (google.com: domain of tytso@thunk.org designates 2600:3c02::f03c:91ff:fe96:be03 as permitted sender) smtp.mailfrom=tytso@thunk.org
Date: Tue, 1 May 2018 15:44:50 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: bug-introducing patches
Message-ID: <20180501194450.GD10479@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180501163818.GD1468@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501163818.GD1468@sasha-vm>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599292198437287794?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 04:38:21PM +0000, Sasha Levin wrote:
>  - A merge window commit spent 50% more days, on average, in -next than a -rc
>    commit.

So it *used* to be the case that after the merge window, I would queue
up bug fixes for the next merge window.  Greg K-H pushed for me to
send them to Linus sooner, instead of waiting for the next merge
window.  TBH, it's actually easier for me to just wait until the next
merge window, but please understand that there are multiple pressures
on maintainers going on here, and the latest efforts to try to use
AUTOSEL is just the most recent pressure placed on maintainers.

The other thing is that when there is a regression users who are
testing linux-next want it fixed *fast*.  That's considered more
important to them than waiting for one, perfect patch, just to keep
AUTOSEL happy.

So please understand that when you say that maintainers *need* to do X
or Y, that there you are not the only one standing in line putting
pressures on maintainers saying they *need* to do something.  And
quite frankly, I consider keeping people who are nice enough to test
linux-next happy to be **far** more important than AUTOSEL.

Sorry.

						- Ted
