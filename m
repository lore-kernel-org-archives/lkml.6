Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZqkqR6AwjkI8Hy4IBaZ7rBiNnMq/PbADaVsemrZTSPEvvjY68iNwBLCFQ58kGPdRT8mQrmE
ARC-Seal: i=1; a=rsa-sha256; t=1525972521; cv=none;
        d=google.com; s=arc-20160816;
        b=IPevqfTXu3d7Hs/yrHUNrjZsGq2LVuGP3L6JExbFgZ5q43ZfjQDytgw8qftH8wulrJ
         GDyJeKrlJSnFBZBNEhua4Td9tFYqIzjgz+nyXTVtGrsP41LnPrRM8TJBrk/X2/MCucmu
         9I/vaevhSQ/r52jgMEqbGrstqaGSc328AZ0rhYMBzgdhJhHz0wPIghZ8uEUcn4zdxHS+
         w2/W1jBuDd88ol14nVX+A/hh9wFZc/ZkRCtY/qmDL6xIwuweG/SjP4T7SyEnwOB2/bVh
         BKfNWvgESmFT4VLzJ/8VPQb3YOOOHv5ViS4iq8gYAoZ0bDHP5PhfnuqBitODtd4KzxPR
         ptHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=i/V5ywLZbV8+HyQmXzXuAzlMlZhQ6H3FeFFGFkRazUw=;
        b=IY6tNWqtTY/7BIWuX2YbSJ0bAdKQFFEMT2c+Q2iAaQgJ8b3Jik7W59TDezi1X5nUaU
         wZ6zbXcWsrN6l9s1kwIXzgjW5qN5kZWJZIjaTm1BVXaQfhhAFMPsGbud/9hOblWMtI+T
         jm2EXAjOLXKSdfLamxRlowPZiaYSji2OZghAX/8WJKDs9VuLua9DK9xiXJ56eaBNqorW
         cVkECCdM+w/nKPf7CsEQ/xM5eizIn+D6temYQ60B1ZwErgeciCYwfGh4b3Rpgd9jB7aW
         FWrrGL0OZto0LYEMDblOE8KktH7pG+ysc2bhzGdkQEp8Ae9o7c/Nt4yiFrAt7N7xOZOi
         aP6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 10 May 2018 17:15:20 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, arnd@arndb.de,
	willy@infradead.org, geert@linux-m68k.org,
	linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mm: PAGE_KERNEL_* fallbacks
Message-ID: <20180510171520.GD27853@wotan.suse.de>
References: <20180510014447.15989-1-mcgrof@kernel.org>
 <20180510060733.GA23098@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510060733.GA23098@kroah.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600039618816101704?=
X-GMAIL-MSGID: =?utf-8?q?1600098163094824418?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 08:07:33AM +0200, Greg KH wrote:
> On Wed, May 09, 2018 at 06:44:45PM -0700, Luis R. Rodriguez wrote:
> > While dusting out the firmware loader closet I spotted a PAGE_KERNEL_*
> > fallback hack. This hurts my eyes, and it should also be blinding
> > others. Turns out we have other PAGE_KERNEL_* fallback hacks in
> > other places.
> > 
> > This moves them to asm-generic, and keeps track of architectures which
> > need some love or review. At least 0-day was happy with the changes.
> > 
> > Matthew Wilcox did put together a PAGE_KERNEL_RO patch for ia64, that
> > needs review and testing, and if it goes well it should be merged.
> > 
> > Luis R. Rodriguez (2):
> >   mm: provide a fallback for PAGE_KERNEL_RO for architectures
> >   mm: provide a fallback for PAGE_KERNEL_EXEC for architectures
> > 
> >  drivers/base/firmware_loader/fallback.c |  5 ----
> >  include/asm-generic/pgtable.h           | 36 +++++++++++++++++++++++++
> >  mm/nommu.c                              |  4 ---
> >  mm/vmalloc.c                            |  4 ---
> >  4 files changed, 36 insertions(+), 13 deletions(-)
> 
> No list of changes that happened from v1?  :(

Didn't know you'd want it for such simple patch set, but I'll provide one for v3 and
also list the changes in v2.

  Luis
