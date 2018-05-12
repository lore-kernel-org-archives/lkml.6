Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AB8JxZpCEPpaaVmBSpXGCe+Yp1hLs6BcsTCQZsVA+YIEleGAunb3xZqWbc/BR6iB/j04unBc4Qg9
ARC-Seal: i=1; a=rsa-sha256; t=1526147084; cv=none;
        d=google.com; s=arc-20160816;
        b=dz6CZF5zzqi81W5oSRT1fDiNaxDnRMyMS6Dqh5wIjTPxV7DiFUnozW05KrV10UJw4b
         7U/zLA/IbUt195bff4wA4gPDNbOTFE6zWmkztW7Vv/tXRq7Kex+zCxn1JdBLo4Y3hFhs
         bUStGA2GvjN5RLsh8SUbjFA7ke/Ih52jGzest4MDRWMpls4nQAUJpQwmAlmF3iXVmzPV
         2Uxk9tC09AcdsAmQvu51EAnvNZoc/tFWOyOWeVNDcohuuvAA2xuATZVxNc2rVSK1Erg+
         b/WGHb4Qely0hBXlTVniJKxycjPALI6yI1odNmP4V/FnMLla7Dg5Z5CyHmRVa2ia7lEe
         upIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=L9D2B4PC1N3bKtsemT2EO65wopo6XkbRTkWBWUaVruw=;
        b=OJhkTLFV2RP/KMkbe5XfahfVBUBhKOA/VipKymZcYvP0zdKB3u6cgn/OfAACeCZPKa
         h/OTsV89t/47a78CAlgdOWNeYAJkMqs1L2hppsUk+AEerRYqYNmQ65PKQJ5+kB/ka9zQ
         y+gvYNZj36rE1NeNNrxdX7OeWMFSDvwxFt3NfleLg+GFpm30NvcWN0h0nXnRAVc+GJ9J
         Zn+KMghju1ZDB43ImTKjLB9o9xT+Vzb4VodwSbiY6MR26mMI9Kmtcn82S+dY9SjQ4c/V
         8+efoQWhNKfB9ERwS1Atn2JVcMEAhd/H0rGc9uOfhGJNmEGggV3BQLjqhbuT57/4gypC
         WFaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=z7NukP41;
       spf=pass (google.com: domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=z7NukP41;
       spf=pass (google.com: domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Sat, 12 May 2018 18:44:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org, lars@metafoo.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 pmeerw@pmeerw.net, knaack.h@gmx.de, drew.paterson@ams.com
Subject: Re: [PATCH v3 9/9] staging: iio: tsl2x7x/tsl2772: move out of
 staging
Message-ID: <20180512184438.4e4e49b9@archlinux>
In-Reply-To: <20180512123630.f2b7opaob3cb3fom@a2245dbc7726>
References: <20180511001223.12378-1-masneyb@onstation.org>
	<20180511001223.12378-10-masneyb@onstation.org>
	<20180511003206.pgh244sd5t6v4njx@a2245dbc7726>
	<20180512124437.6526c6a0@archlinux>
	<20180512123630.f2b7opaob3cb3fom@a2245dbc7726>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600124417811068124?=
X-GMAIL-MSGID: =?utf-8?q?1600281205246436351?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 12 May 2018 08:36:30 -0400
Brian Masney <masneyb@onstation.org> wrote:

> On Sat, May 12, 2018 at 12:44:37PM +0100, Jonathan Cameron wrote:
> > On Thu, 10 May 2018 20:32:06 -0400
> > Brian Masney <masneyb@onstation.org> wrote:
> >   
> > > On Thu, May 10, 2018 at 08:12:23PM -0400, Brian Masney wrote:  
> > > > Move the tsl2772 driver out of staging and into mainline.    
> > > 
> > > Hey Jonathan,
> > > 
> > > Here is the .c and .h file to make your review easier. Thanks for all
> > > your feedback on all of these changes to this driver plus the other 3
> > > that I've already moved out of staging. I've learned a lot going through
> > > this process.  
> > 
> > I have the great pleasure to say APPLIED! 
> > Congratulations Brian.  This has been the longest and most complex driver
> > cleanup I think we have ever had.
> > 
> > 64? patches 
> > 
> > 930 (+ 366) insertions, 710(+ 368) deletions (brackets for the driver rename
> > which only sort of counts.
> > 
> > + this is the 4th driver as you say.
> > 
> > Particularly pleasing is that we no longer have any light sensors in iio staging.
> > 
> > So what's next?  
> 
> Great! Thank you!
> 
> I have two things that I'm planning to do next:
> 
> 1) See if the tsl2583 driver can be cleanly folded into tsl2772.

Cool.  Always nice to merge similar drivers so hope that works out well.

> 
> 2) I have a Google Nexus 5 phone and I'm going to work towards being
>    able to run an upstream kernel on the device. There has already been
>    some work on this so looking to join forces:
>    https://github.com/flto/linux/wiki/hammerhead-upstream
Best of luck!

Jonathan
> 
> Brian
