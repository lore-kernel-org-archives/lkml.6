Return-Path: <w@1wt.eu>
X-Cyrus-Session-Id: sloti22d1t05-255570-1520465256-2-18053498220098815105
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, SPF_HELO_PASS -0.001,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='62.212.114.60', Host='wtarreau.pck.nerim.net', Country='FR',
  FromHeader='eu', MailFrom='eu'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: w@1wt.eu
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520465255; b=hHQ2ijPq8qmSU3v/0Q6as4FJcyj0sfwQ9fw2EdsuStqtha6
    H20R0p172YoyKlA3Zxt7gIr+A4JPY5GBZFQ8BZkVqUUZdtOWUKRh/VDnPemBiQtB
    LVSJhfu33TrhlySJfW8O+T36aEA+oCtsxlNPN7VzN2gtHSb4FbNrIq6zTNtfkao5
    LQCQAc8nIuGlIajOQPhJTvtKMHJlSEmlSSyRCGlauTSpuuKXMcwUt9hEKJV3wggr
    ijAXFBrZs+ChZ8VJRz5sZEXrURAJpNtbOGPN9lzVNPJFiznq5iJ26Fp0sHlWB+QZ
    zHKsTIqvM5nUWGcSwNgBpCXOcKYuoWGAJYgtORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1520465255; bh=gVoE4cOUuOvvDi2DF+IDKSMyqTjYt7iW9iqwWV1UAa0=; b=X
    oHJ9azF83thc6OjYVuD1zgswiyeMjIM+0g1UXwYyK5tJYzEzvWAGJH54Diy/tGdb
    rYW0QuR14ZyNjWK2UppgVIokN4e/k0Q/fyMrhWXOcVrdF5GCCqPHHN9Lbn+BQMh0
    zulSS343xPYirl6H3ufYhDjfy3pQYIXXPLMTUBg/YoDfk8Y9SQIiZahJQHpccURw
    GmfG6GtqmHmQdoqdzqKiGOOsNilppog3VgTOF8704ceKZNrg6X0BZj0iNG/p/DuZ
    /y/Zwc28zENaorPPvvTwRkhNOrdXD5wrOdlOUdprj3dq3eHWwR2w3R/RsgMw7ftF
    Xd7fcdOK9jgL2ioNkh+5Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=1wt.eu;
    iprev=pass policy.iprev=62.212.114.60 (wtarreau.pck.nerim.net);
    spf=pass smtp.mailfrom=w@1wt.eu smtp.helo=1wt.eu;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=1wt.eu x-ptr-lookup=wtarreau.pck.nerim.net;
    x-return-mx=pass smtp.domain=1wt.eu smtp.result=pass smtp_is_org_domain=yes header.domain=1wt.eu header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=1wt.eu;
    iprev=pass policy.iprev=62.212.114.60 (wtarreau.pck.nerim.net);
    spf=pass smtp.mailfrom=w@1wt.eu smtp.helo=1wt.eu;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=1wt.eu x-ptr-lookup=wtarreau.pck.nerim.net;
    x-return-mx=pass smtp.domain=1wt.eu smtp.result=pass smtp_is_org_domain=yes header.domain=1wt.eu header.result=pass header_is_org_domain=yes
Date: Thu, 8 Mar 2018 00:27:14 +0100
From: Willy Tarreau <w@1wt.eu>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Pavel Machek <pavel@ucw.cz>, David Woodhouse <dwmw2@infradead.org>,
        Greg KH <greg@kroah.com>, Steve deRosier <derosier@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        dedekind1@gmail.com, tharvey@gateworks.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        cyrille.pitchen@wedev4u.fr, computersforpeace@gmail.com
Subject: Re: [PATCH] ubi: Reject MLC NAND
Message-ID: <20180307232714.GA10178@1wt.eu>
References: <20180303104554.5958-1-richard@nod.at>
 <20180306231805.GA28183@amd>
 <6772577.AmT7QaWTNU@blindfold>
 <20180307214342.GA9852@amd>
 <CALLGbRK4w9Yhznt6+aqr8jptQjsp7FmbjQMPtvhh2h354n2G0A@mail.gmail.com>
 <1520460673.31298.136.camel@infradead.org>
 <20180307221733.GE10438@amd>
 <20180307233057.54bd35c3@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307233057.54bd35c3@bbrezillon>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Boris,

On Wed, Mar 07, 2018 at 11:30:57PM +0100, Boris Brezillon wrote:
> I have one simple question: did you ever play with MLC NANDs or are you
> just trolling? If you had, like Richard and I did when working on MLC
> support, I'm pretty sure you wouldn't play this "don't backport to
> stable" card.

Just adding my two cents here, I've always had stability issues with
ubifs on NAND and I never knew what type of NAND I've had in these
devices (eg: Iomega Iconnect with 256 MB NAND IIRC), so maybe this
has never been relevant, maybe it has been, I don't know. However,
as a stable maintainer I also know that we want to encourage people
to always keep their kernels up to date with latest fixes, and that
if there is the slightest risk that a loss of functionality makes
people revert and stick to an older, working version, keeping their
bugs forever, it's twice as worse, because :
  - they still run on the bug you wanted to fix
  - they are now exposed to all bugs fixed later.

And we all do this as users, thinking "I'll bisect and report tomorrow"
and priorities change, let's be honnest. Thus I think that if you are
absolutely certain that it's impossible that people are accidently using
this combination, it's probably fine, but if people are using it, you're
just displacing the burden on the stable team who will have to explain
to each and every user complaining "my system stopped booting after an
upgrade to 4.x.y". A big red alert polluting the logs and console every
minute, and a pause at boot saying "your NAND, your data and all your
kids photos will die soon if you don't switch to another FS" is more
productive as users will be less tempted to blindly revert and will at
least ask what the problem is and what their solutions are.

There's nothing more frustrating than a regression in a stable branch,
even for something that was not supposed to work but did by accident.

> I wouldn't say "work by mistake" but "seems to work at first but in the
> end breaks", so definitely a candidate for -stable IMO.

Well, removing support definitely makes the end closer and possibly even
prevents the user from recovering their data. I know that data loss is
terrible, but data confiscation is similar from the user's point of view.

Users don't know the technical details so they will do all things we
often consider stupid or impossible, but when warned they know that the
risk is on their side and they cannot put the fault at anybody anymore.
It tends to work better.

Just my two cents,
Willy
