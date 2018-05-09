Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AB8JxZrMQGHvb+xoKi2K4MPddEWze8PnTugte5FEcw5LhjrHcj9e17cdGAIgmsTiC7hYYpGImJvP
ARC-Seal: i=1; a=rsa-sha256; t=1525894540; cv=none;
        d=google.com; s=arc-20160816;
        b=fE3HuVDRMtgenDZzdqU9Ts7BSSkzw6qmIFTSFTI353hadsNgS3s2yuEROiVniyqXH3
         /Vc4I78c1aVPiGvZArPXnmHpdkVBRMhBwsDDq/NdMibCA3wxYfS+KyTM4er0+em+7hlA
         /SX2ISOYP52HqC6otTO9E+4nVoazAgozZuw06gN0qyWUdo4f4y2V+IBehkptJ9QJro58
         gJkfVY3BW2DGPhZLhajSbJxRqfZHNTsNaxIMFgzREhpkf6BIp2cYiyVoxCUw7jUHBy4u
         jIiPKO+82waGlyQgPYqbdxggwVUYkBpQmA6oBXfQfK/WemQ8Ymf+wVVEk0IZ4ftTAHuA
         1C4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=2DLwcln4rIdJQjX4BaoaYIuwW/mBz5rwGNG2YdX3CUY=;
        b=tx41grhoA2xguWB0F5kpZBpao1MdHrAOsqhyKm/q55ojZ0fDMpNMAJRwy80e6ITr7f
         Aupyn3a2to0om9aFOt9Ma3ciHLvPoqka+mqePxH+mG5NZlOXJI8QZy5wP3Cnt31UUaxW
         p9FDM+6jDT4tJb/RIaKVicUd1Ra05T8G1kAjrpH6luRaUNWK5PuthARRVwioW+UsUyOI
         CkwvWaT65DwWaFbieCd00UpTzclt1LV5WHyix0qiJeSAvNhswuAYqsw3X8skHDB5UYGq
         GW6i1jF5GAUesuZy00AB81mj8x1+enriWvvHqz1oFDPupB4yOV0fe6HWwhc3ez7jxgYo
         JeSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Wed, 9 May 2018 21:35:28 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ksummit-discuss@lists.linuxfoundation.org"
 <ksummit-discuss@lists.linuxfoundation.org>, Greg KH
 <gregkh@linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180509213528.54bad29b@bbrezillon>
In-Reply-To: <20180509204727.7ff38021@canb.auug.org.au>
References: <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
	<20180502194632.GB18390@sasha-vm>
	<20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
	<20180509084440.GW13402@sirena.org.uk>
	<CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
	<20180509090346.GY13402@sirena.org.uk>
	<20180509204727.7ff38021@canb.auug.org.au>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1600003109861123526?=
X-GMAIL-MSGID: =?utf-8?q?1600016393530698282?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Stephen,

On Wed, 9 May 2018 20:47:27 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> On Wed, 9 May 2018 18:03:46 +0900 Mark Brown <broonie@kernel.org> wrote:
> >
> > On Wed, May 09, 2018 at 10:47:57AM +0200, Daniel Vetter wrote:  
> > > On Wed, May 9, 2018 at 10:44 AM, Mark Brown <broonie@kernel.org> wrote:    
> >   
> > > > I think this is an excellent idea, copying in Stephen for his input.
> > > > I'm currently on holiday but unless someone convinces me it's a terrible
> > > > idea I'm willing to at least give it a go on a trial basis once I'm back
> > > > home.    
> >   
> > > Since Stephen merges all -fixes branches first, before merging all the
> > > -next branches, he already generates that as part of linux-next. All
> > > he'd need to do is push that intermediate state out to some
> > > linux-fixes branch for consumption by test bots.  
> 
> Good idea ... I will see what I can do.
>   
> > True.  It's currently only those -fixes branches that people have asked
> > him to merge separately which isn't as big a proportion of trees as have
> > them (perhaps fortunately given people's enthusiasm for fixes branches
> > that don't merge cleanly with their development branches) so we'd also
> > need to encourage people to add them separately.  
> 
> I currently have 44 such fixes branches.  More welcome!

I see that the nand/fixes and spi-nor/fixes branch are already there [1].
You can add:

mtd-fixes	git	git://git.infradead.org/linux-mtd.git#master

You can also remove the mtd entry [2], since mtd-2.6.git is just a sym
link to linux-mtd.git, so it will just be a duplicate of the mtd-fixes
entry. You can also rename the l2-mtd entry [3] into mtd.

Regards,

Boris

[1]https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/+/43cd1f4979998ba0ef1c0b8e1c5d23d2de5ab172/Next/Trees#41
[2]https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/+/43cd1f4979998ba0ef1c0b8e1c5d23d2de5ab172/Next/Trees#155
[3]https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/+/43cd1f4979998ba0ef1c0b8e1c5d23d2de5ab172/Next/Trees#156
