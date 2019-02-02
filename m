Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66736C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 05:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B2D2086C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 05:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGZEwYEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfBBFN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 00:13:59 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43521 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfBBFN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 00:13:58 -0500
Received: by mail-lf1-f67.google.com with SMTP id x201so5325482lff.10;
        Fri, 01 Feb 2019 21:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ex1oR9FzSa16E8jFNhknx9+ksI7U83eVfvYOHXHT7tM=;
        b=WGZEwYEJkH8t9CQ6X6cecng1FeCT17MQxpdhePq+AiqYOLkUBfEtmdNyJFsg+GeyxA
         CCMgpYjL6PKc/csGZyUlQv0UBwwan5LOre/NaTgIilfogO0r4EatOgE9V6ZXk1xaDmwn
         X7z5GL3r7xbWeaqaGDSnv+AqXmgRmPIYjqL3fKu4tATFBYHc12j3IrX3PWhg+FnZHoHm
         c0TUZu/TBZhlN7+WK3RMZ1BsHA94jvGDYAF1Sn3jYfVT/G0oFzq2JOeVCmCVu1TxBjax
         oxyEBuQTKvX/Dz8Ofn/GAhLSBytRLYrtIXmoLJCegzG4IBJcSXwUETkh6VOJeIt2Kpw7
         GFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ex1oR9FzSa16E8jFNhknx9+ksI7U83eVfvYOHXHT7tM=;
        b=lkgAfEz0c0pgX+u1DakCjcHouZN4/dQNDaCu8uKyRzV2byk+WJQ83er//1zSjc2E1R
         I9SeLfBsGQrf0XNbx6hYsSxgiLZB51T3LK7oKkexSDStIOy57UbKAeIaK074yQPx0Hxe
         H3/gf+nPN7m68Ks2/DNktuyN7MCrqOeT7QChPL6yWdzxlmjIYYGuc277UbRwPbysdJeN
         x3GHWqF/g3tOI3WBRTjcSaAZ4+UdTwpnCMMF9afCF5f2LcnN6yRHNmwEchKAZfEniclp
         ND0yEEyM4iTwxXQZAYr0J6MTNX33oAmy/e9+p7JH2cStBZ7INiUZcV+i+weAfXubylNe
         94Fw==
X-Gm-Message-State: AHQUAuZBN+0J71IjC8PxS54JvJ9SMysUl1ufZWo9XZC+7O/sv36eaHRG
        82uTbbNotq/FjbmS/ZxaxJs=
X-Google-Smtp-Source: AHgI3Ibi7McU5fqAOpKsbZBEs+io9VY0lE69y2TGt7/2TBwre+5UIHzOwW9Zgn4fDNrA1pvB/SFagQ==
X-Received: by 2002:a19:e30d:: with SMTP id a13mr2393388lfh.22.1549084436265;
        Fri, 01 Feb 2019 21:13:56 -0800 (PST)
Received: from im-mac (pool-109-191-226-91.is74.ru. [109.191.226.91])
        by smtp.gmail.com with ESMTPSA id z9sm1692086lfj.79.2019.02.01.21.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 21:13:55 -0800 (PST)
Message-ID: <6f3eec21920413fdbc774d89a6f6bbc2c7863370.camel@gmail.com>
Subject: Re: [RFC PATCH 4/4] watchdog: hpwdt: Make panic behaviour
 configurable
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     Jerry.Hoemann@hpe.com
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Sat, 02 Feb 2019 10:13:54 +0500
In-Reply-To: <20190116023022.GE18342@anatevka>
References: <20190114023617.10656-1-mironov.ivan@gmail.com>
         <20190114023617.10656-5-mironov.ivan@gmail.com>
         <20190116023022.GE18342@anatevka>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-15 at 19:30 -0700, Jerry Hoemann wrote:
> On Mon, Jan 14, 2019 at 07:36:17AM +0500, Ivan Mironov wrote:
> > This adds an option to not panic on NMI even if it was caused by iLO.
> > 
> > Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
> > ---
> >  drivers/watchdog/hpwdt.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> > index 95d002b5b120..b12858491189 100644
> > --- a/drivers/watchdog/hpwdt.c
> > +++ b/drivers/watchdog/hpwdt.c
> > @@ -37,6 +37,10 @@ static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
> >  static bool nowayout = WATCHDOG_NOWAYOUT;
> >  static bool pretimeout = IS_ENABLED(CONFIG_HPWDT_NMI_DECODING);
> >  
> > +#ifdef CONFIG_HPWDT_NMI_DECODING
> > +static bool panic_on_nmi = true;
> > +#endif /* CONFIG_HPWDT_NMI_DECODING */
> > +
> >  static void __iomem *pci_mem_addr;		/* the PCI-memory address */
> >  static unsigned long __iomem *hpwdt_nmistat;
> >  static unsigned long __iomem *hpwdt_timer_reg;
> > @@ -146,7 +150,10 @@ static int hpwdt_set_pretimeout(struct watchdog_device *wdd, unsigned int req)
> >  
> >  static int hpwdt_my_nmi(void)
> >  {
> > -	return ioread8(hpwdt_nmistat) & 0x6;
> > +	int nmistat = ioread8(hpwdt_nmistat);
> > +
> > +	iowrite8(nmistat & ~0x6, hpwdt_nmistat);
> > +	return nmistat & 0x6;
> 
> This is a read only register.
> 

Oops... At least on my system this code has the desired effect:
subsequent function call returns zero.

Probably it would be better to use additional variable to determine
whether NMI from iLO already happened or not.

> 
> >  }
> >  
> >  /*
> > @@ -168,7 +175,10 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
> >  		 "4. iLO Event Log\n",
> >  		 mynmi, ulReason, smp_processor_id());
> >  
> > -	nmi_panic(regs, "hpwdt: NMI: Not continuing");
> > +	if (panic_on_nmi)
> > +		nmi_panic(regs, "hpwdt: NMI: Not continuing");
> > +
> > +	pr_emerg("Dazed and confused, but trying to continue\n");
> >  
> 
> The watchdog core provides a way to enable/disable the NMI pretimeout dynamically
> via ioctl.  The pretimeout NMI can also be disabled via module parameter to hpwdt.
> This adds complexity without really adding functionality.
> 

It looks like disabling pretimout will disable panics only for iLO 5
(mine system has iLO 2). Or am I missing something?

> 
> BTW, don't reuse error messages.  Makes it difficult to tell where the error
> originated from.
> 

Would it be better to just return NMI_DONE and thus reuse normal NMI
handling from kernel, with logging and panic/don't panic logic?

> 
> >  	return NMI_HANDLED;
> >  }
> > @@ -376,6 +386,9 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> >  #ifdef CONFIG_HPWDT_NMI_DECODING
> >  module_param(pretimeout, bool, 0);
> >  MODULE_PARM_DESC(pretimeout, "Watchdog pretimeout enabled");
> > -#endif
> > +
> > +module_param(panic_on_nmi, bool, 0);
> > +MODULE_PARM_DESC(panic_on_nmi, "Cause panic on NMI induced by iLO (default=1)");
> > +#endif /* CONFIG_HPWDT_NMI_DECODING */
> >  
> >  module_pci_driver(hpwdt_driver);
> > -- 
> > 2.20.1

