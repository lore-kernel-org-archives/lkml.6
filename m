Return-Path: <tytso@thunk.org>
X-Google-Smtp-Source: AB8JxZrXPQgcThscO+kMb7NRIUzxDY1q+Dz/hU28smG1PTv86BjRRrPdJpU3pMHBL55A5pOXOpL9
ARC-Seal: i=1; a=rsa-sha256; t=1525751304; cv=none;
        d=google.com; s=arc-20160816;
        b=azWFKQOcaLdw8+pdjFJg2oxhs1WFwC1R/FPQr2Gf+VYIeg5Rs8Cl8b3xr/EtPjNNQz
         b82ikDeT4kdSVSu5sj/Bxuxz+TwbjAim2Ck/vD7/HgF2OKnFtPt2N3q6/Y9naTAwZlz0
         bWqQ+rUqqd+EBXURxc3QIv6WQId4ImAte1TlALFbgT+Ncf320pyx+iJIF5QHdWK53rVv
         9Y0x206LZPuWK/hMVDnTuTFygZVAIRZcowB5iOdh9uOT4EdOw1BCpemXas2RyrftpQQ7
         X2QEL5wM23jhDLiC7esQZu4P2WeUAftOkP9UyHFs8s/OdvA88N/r6+qJgEjSFg8q17fE
         M6rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=aYAeCYGuKx7VoFeH5tB9Jg4Q6MUfeWhgrup5zrf9iGw=;
        b=t6Lngn9Z9xV1ZKpC2Sq6mU55r/RocoDy/0mKDiI17lyXM49mYbaboRGsQQMi7rpSu4
         2WJuwrwAuQvAnq5im56ocUevRr/KPhhus4Ear8s5njC3BhVG84l1O4hlx2baz2gkOO04
         p0te+oULNp1u793IdejohVz8X/Jx498V3c/inoClF00G71i2UAGi/kVsGDj6WYPXxh0t
         b8gatFCw08cT4/lBQi0N+JB90GNoSUB63jSTYd5oRjy0Ez9rUKcv4oqq0gJGGIUM3BeX
         ByLaz8V/QzyTB9zUxPgxl/bPcDk/aGehyQ0q/0oAYT2a8itrwS0hCsLw9iSGTTGepzjv
         AOug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=Qj/oKUG+;
       spf=pass (google.com: domain of tytso@thunk.org designates 2600:3c02::f03c:91ff:fe96:be03 as permitted sender) smtp.mailfrom=tytso@thunk.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=Qj/oKUG+;
       spf=pass (google.com: domain of tytso@thunk.org designates 2600:3c02::f03c:91ff:fe96:be03 as permitted sender) smtp.mailfrom=tytso@thunk.org
Date: Mon, 7 May 2018 23:48:20 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@linuxfoundation.org>,
	"w@1wt.eu" <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180508034820.GE999@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Tony Lindgren <tony@atomide.com>,
	Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180501205448.GE10479@thunk.org>
 <20180501211551.GI2714@sirena.org.uk>
 <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
 <20180502194632.GB18390@sasha-vm>
 <20180503020550.GP2714@sirena.org.uk>
 <20180503031000.GC29205@thunk.org>
 <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk>
 <20180503230905.GA98604@atomide.com>
 <20180508023439.GA8514@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508023439.GA8514@sasha-vm>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599866200599460539?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 02:34:41AM +0000, Sasha Levin via Ksummit-discuss wrote:
> 
> Tony, I'm curious, how many users are you aware of who actually run
> Linus's tree? All the users I've encountered so far on Azure seem to be
> running something based on -stable.

The people who run Linus's tree and test -rc kernels tend to be kernel
developers and individual users who want to run bleeding edge kernels
and who generally are technically clueful.  If you were talking about
SLR cameras, you'd call them the "prosumers" segment of the market.

It tends to be more on desktops and laptops, so it doesn't surprise me
that you don't often see them in a hosting environment where you have
to pay $$$.  (And where you do see them in a hosting environment, it's
probably for things like gce-xfstests.)

> I think that a question we should be asking ourselves is whether we
> should be basing our decisions here on the assumption that (pretty much)
> no one runs Linus's tree anymore?

These people *do* exist, because as a maintainer, I get bug reports
from them.  (And sometimes as a user, I send bug reports when running
-rc kernels to other maintainers, such as the i915 drivers and the
Intel Wireless driver folks.)

Such reports are incredibly valuable and precious to me, since it
allows me to find problems that weren't picked up in my own testing.
(In the case of Intel Wireless, a while back the IWL team didn't have
Aruba Enterprise Access Points in their test hardware library, so I
found a regression after the merge window because I was running -rcX
on my laptop, and wireless access to googleguest network broke.  If I
hadn't been running -rcX, they probably wouldn't have discovered this
problem until after that particular kernel had been released.)

So keeping those users happy is a good thing; since they tend to be
very technically clueful, they can do bisections for you, and they are
able to give a detailed and useful bug report.  If they report that a
regression that was introduced in -rc2 is fixed by a particular patch,
I want to push it into -rc3 immediately, and not let it stall in
linux-next.  If the reason why is because you don't trust my patch
because it "only" got tested by the technically advanced user
reporting the regression, then don't take patches from -rc3 into your
stable branch right away!  Let it bake in Linus's tree anfor a week or
two, instead of demanding that patches stick around in Linux-next
before flowing into Linus's tree.

Because I will guarantee you this --- there are more real users
running Linus's tree than linux-next.  This is because Linus's tree
tends to be far more stable than linux-next, since after -rc2
linux-next starts getting the first set of experiments for what will
be going into the next merge window.  So while I am willing to run
something based on -rc2 or later on my laptop, there is no way in heck
I would be willing to put linux-next on my laptop.  That's just way
too exciting for me....

Would I pull down linux-next, and fire up a VM running gce-xfstests?
Sure.  But that's not a real-life use case; that's just running canned
test cases.  And more often than not, linux-next will be broken while
Linus's -rcX tree is just fine; which is why I do most of my ext4
testing using patches based on top of -rcX, not based on top of
linux-next.

       		     		 	     - Ted
