Return-Path: <pavel@ucw.cz>
X-Cyrus-Session-Id: sloti22d1t05-108815-1520461056-2-9141058421359949728
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_MED -2.3, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='195.113.26.193', Host='atrey.karlin.mff.cuni.cz', Country='CZ',
  FromHeader='cz', MailFrom='cz'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: pavel@ucw.cz
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520461056; b=ZQeALCq4hWon8Dqf/fiS9MZctPfDZ7sO9mdya0Z0J4fJp7y
    /wdQaAD/JUGdMysa27edDc2Gaz7J+0tR89lpMheryrnWvRyPhq7lbZbH9e4xdJKI
    kmzAB19ZLo+f7ZiJfbQ4btj5kLzLiOUctBSbhoCuUbq8oC7I7ncn9QO4/OYu0ymf
    A2ljT89pUHGYTqZTZH93+lBNBV9Qk3diXdgbSX9HtgkAzQPnsALZGNUtsBaa77XR
    VHkHMpOnw1TjyyG9vMBPcjYaExJZ34vdkQvWrWeLHIPHGfAPDZRYTNX9OMqAEYCC
    TEC+mNgg6gZ5TaKmSUpKBuI5qr/OK4O/aMO+YMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1520461056; bh=1oHDBq1BpemT29ShMxvTnOyujmtpwENZxNTdpWuiCa0=; b=W
    3/RNmX28K6A+herOAfZqA7+y1d/aOjnjZF0eM1BiNQXOcLOMWOqhkIp1IWNNkyPJ
    YorJzJkyIcCTHRQsa3DhIdWRVpVph5XQDRiI3RIzs0sf4uiLYM22qt9zcrZrFikI
    cKc26nsaLmqkMC8yYGi/CMGmX0/w7PNOpdJGEKnB5DMianLwHrpI29vF3hent/vH
    IPmWX/QZTGpSDFxXgWN608wSW4I7w+si1Ru04eLYn4w1nBkPOeE7lsgUSJEssBTE
    LqvD5+I9J+GgF2v4x6+77ZVQstBfqmRqbmcltv4eGiwDsQK9PTB+PM8We6ZfcYGJ
    HOtS2nGpcbkk5Pm9/BuvA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=195.113.26.193 (atrey.karlin.mff.cuni.cz);
    spf=none smtp.mailfrom=pavel@ucw.cz smtp.helo=atrey.karlin.mff.cuni.cz;
    x-aligned-from=pass;
    x-category=clean score=-51 state=0;
    x-ptr=pass x-ptr-helo=atrey.karlin.mff.cuni.cz x-ptr-lookup=atrey.karlin.mff.cuni.cz;
    x-return-mx=pass smtp.domain=ucw.cz smtp.result=pass smtp_is_org_domain=yes header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=195.113.26.193 (atrey.karlin.mff.cuni.cz);
    spf=none smtp.mailfrom=pavel@ucw.cz smtp.helo=atrey.karlin.mff.cuni.cz;
    x-aligned-from=pass;
    x-category=clean score=-51 state=0;
    x-ptr=pass x-ptr-helo=atrey.karlin.mff.cuni.cz x-ptr-lookup=atrey.karlin.mff.cuni.cz;
    x-return-mx=pass smtp.domain=ucw.cz smtp.result=pass smtp_is_org_domain=yes header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Date: Wed, 7 Mar 2018 23:17:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>
Cc: Steve deRosier <derosier@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	dedekind1@gmail.com, tharvey@gateworks.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
	cyrille.pitchen@wedev4u.fr, computersforpeace@gmail.com
Subject: Re: [PATCH] ubi: Reject MLC NAND
Message-ID: <20180307221733.GE10438@amd>
References: <20180303104554.5958-1-richard@nod.at>
 <20180306231805.GA28183@amd>
 <6772577.AmT7QaWTNU@blindfold>
 <20180307214342.GA9852@amd>
 <CALLGbRK4w9Yhznt6+aqr8jptQjsp7FmbjQMPtvhh2h354n2G0A@mail.gmail.com>
 <1520460673.31298.136.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520460673.31298.136.camel@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed 2018-03-07 22:11:13, David Woodhouse wrote:
> 
> 
> On Wed, 2018-03-07 at 14:08 -0800, Steve deRosier wrote:
> > 
> > To clarify one thing: the reason for this is MLC has actually never
> > been supported, nor worked properly. The fact that it kinda worked was
> > incidental and the cause of major problems for people due to that not
> > being clear. This patch only makes it explicit and avoids people
> > mistakenly trying to use UBIFS on MLC flash and risking their data and
> > products. To me, that's what's important.
> > 
> > This is an important patch, even if all it does is keep people from
> > loosing data. It also changes the conversation from "I have a
> > corrupted UBIFS device, BTW it's on MLC..." to "What can we do to get
> > UBIFS to work on MLC".

Well, for -stable I'd suggest printk(KERN_ALERT ...) but keep the
system running.

> This is a bug fix.
> 
> UBI on MLC never worked. It was a bug that we ever permitted it. This
> is now fixed.

Yeah, well, so lets say I have a working hardware (maybe using
read-only UBI on MLC), update to next stable kernel, and now kernel
refuses to see the partition.

I'll certainly not consider this patch a bug fix.

Removing support for hardware that "only works by mistake" may be good
idea, but maybe it is slightly too surprising for a -stable.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
