Return-Path: <w@1wt.eu>
X-Google-Smtp-Source: AB8JxZpEjIuJwgcBZMCG7cpNoWsofMWBcaIqAeoURUSgz2BAmJ/TLlEMMoRv0aAQ9nJdLYkpAUb5
ARC-Seal: i=1; a=rsa-sha256; t=1525841258; cv=none;
        d=google.com; s=arc-20160816;
        b=vRv0hmyf3BvWatPfkkg28r+2O0yIFEgx4+oqe+cD0mPsON/Q4XfcMx64tbQViHrU+q
         ECXBlGyccxw1qfLE8YrQ0nW6TPEG8pTZ4XJFI28YntVj4eiW5FrKkeAHRD+Nsl8T8+YW
         L5EeErroHGdSJtFfstNNrge1H79aUrjt8vqSgjYn5iDpvBxt+wY+3B1iPtPMgPD8AxC5
         mTv2oIzteymPozaFRh30b/Ixw/YHeMNBJ8Bf8QSPaTeAxFSyVAoZnjgCKO1efJH0M30U
         VF5gy1eu0G8vxgXermuH/avE/+S06op6ncKhemtDzw09gkutUSfSPKz0Q1avE4j7JqwD
         kWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=oD3CTmnsS6P/Kw4cP4ydICQiE5B+TOOwuwzy/jIo15g=;
        b=e3HGBUfq/d8ZW3kdXTgleOEl+z7UBxwsfedB1uL5WGHqeZNpNgTLJ6Y0P99AAnKHJJ
         wV88Z4JnzKiFmQX86KuoQLUMNKOW1duv6CRYVnZn2+h0IBuPp4xwWsB64kpCr5/DPMSf
         VTg2/kIwA4am7JQ5PFcF79+FWN+ol2UcOgX/jRHrHLmNl3lUv+PxPtJderuhYpApi6pi
         5SUhnpP+LHG/UU5T00vXcSEY3OnEThzn1zaBY92kxJLV8u7Qu7WOaRgk7j7wiFDZDjBG
         0rPjV5SgnoP+zaAFh98TMNJhluExEE2wTTosRQZmdUxrQmTduIRZrxpY0SgZUsfiM+uo
         Hn3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Date: Wed, 9 May 2018 06:47:32 +0200
From: Willy Tarreau <w@1wt.eu>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Tony Lindgren <tony@atomide.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180509044732.GA29311@1wt.eu>
References: <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
 <20180502194632.GB18390@sasha-vm>
 <20180503020550.GP2714@sirena.org.uk>
 <20180503031000.GC29205@thunk.org>
 <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk>
 <20180503230905.GA98604@atomide.com>
 <20180508023439.GA8514@sasha-vm>
 <20180508034820.GE999@thunk.org>
 <20180508202912.GC8514@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508202912.GC8514@sasha-vm>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599960523005371132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 08:29:14PM +0000, Sasha Levin wrote:
> What if, instead, Linus doesn't actually ever release a point release?
> We can make the merge window open more often, and since there's no
> actual release, people won't rush to push fixes in later -rc cycles.

And then what's the purpose of these later -rc cycles if you remove one
release ? You're just removing one step and shifting everything down by
one -rc but the issues are the same.

> We take away the incentive to push poorly tested code. Maintainers still
> free to commit anything they'd like, but there's no reason to commit
> code they're not confident of just to make it to a random release no one
> will use.
> 
> Merge window will happen more often, so there's no real reason to rush
> things in a particular window, and since -stable releases every week
> there's no rush to push a fix in since the next release is just a week
> away.

I'm not sure what model you're having in mind but the description above
reminds me of 2.5 which was constantly had something broken and which
used to be unusable for many developers. Many of us even bought some
SCSI cards and disks by then because for a long time IDE was broken.

The primary purpose of Linus' releases and -rc is to synchronise everyone
on the same goal at the same time. The merge window is "send me your crap,
it must be OK but we know problems happen and you'll be allowed to fix it
later". The -rc ones are there so that everyone fixes their crap in
parallel so that we converge towards something acceptable for everyone.

Your argument that the .0 release is useless is wrong in my opinion. It
is as wrong as saying "statistics show that less people use .3 than .7".
And comparing "stable kernels" to ".0" is wrong because there are roughly
10 times more stable kernels than releases so statistically you'll find
10 times more of them in field. The reality is that deploying .0 always
takes a bit more time for end users so statistically it should be a bit
less common in field :
  - you're never certain when the new version is going to be released
    (will rc8/rc9 exist?)
  - when it's released, you have to update your config and it takes
    some time.
  - by the time you find a quiet moment to do all this, it's not
    unlikely that the end of the week is reached with .1 appearing.

And so what ? The .0 release is a stable release like any other one.
It doesn't deserve to be deployed more than any other specific stable
release. It serves as a reference. Before .0 the code experiences some
possibly breaking changes, even some reverts. After .0 it experiences
only small fixes according to the stable rules.

Overall I think the current model is not that bad, and that what is the
most needed is some education regarding how -stable works to encourage
developers to rush their fixes less (after more tests), and to ensure
that those who generally push good quality fixes can submit them at any
moment in the cycle so that we get them as fast as possible in -stable.

Willy
