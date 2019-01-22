Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C20CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D582A20854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfAVSRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:17:34 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38218 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfAVSRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:17:33 -0500
Received: by mail-lf1-f65.google.com with SMTP id a8so18811807lfk.5;
        Tue, 22 Jan 2019 10:17:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rcmy8kGquP69dUpbMBzNh31+Q1f8E6BcCqqAfeXP10M=;
        b=ckZzKF/GYf13KMyUc5UKEmYpc7f7bXKLe5GXOKObMmFhzKMbboKGG7KtCqezSH6FVs
         S/K8fb/VFpaFjJjK4REgAXCl6ROuRhS7BhslPZ6tEb9Z42hiFCiKG0ZTu0BssFXEqVjN
         KPmmwWQCGfz9IYpdvoeWlJzogvKhGmGf1kMuQIYB6Gv4hTpnxqKAVTXEbPSejoRarvzr
         xhttG040K4FX7BJ0t5t/ZkbhNP97hQ1g+eGaBIXtm+mZQH9HuSm4JYDb4KxMzDjRHlHo
         ZtzztcUU1RYB69ZHg83mYKIRhWCw5VaZIY/u+brHxwSvBFfT3MT0qytAYaeHuHCGFbhx
         IXqg==
X-Gm-Message-State: AJcUukcZ4ArHGPuYUu/xjYcWLFjnp8PopP01wqpREJkMe6ddaW7D1iXv
        lEg0SfT7hFqCCAJbQecd5vE=
X-Google-Smtp-Source: ALg8bN5Rj3cgDpw30T2mSxN/u0CKaefBKWn/evi/C6+2LDMOlAPoxo/WdbfD7FkS0vhi0eW8hrInMg==
X-Received: by 2002:a19:4e59:: with SMTP id c86mr22516424lfb.132.1548181049715;
        Tue, 22 Jan 2019 10:17:29 -0800 (PST)
Received: from localhost.localdomain (82-203-157-3.bb.dnainternet.fi. [82.203.157.3])
        by smtp.gmail.com with ESMTPSA id f1sm115417lfm.22.2019.01.22.10.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 10:17:29 -0800 (PST)
Date:   Tue, 22 Jan 2019 20:03:09 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     mazziesaccount@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [RFC PATCH v1 13/13] watchdog: bd70528: Initial support for ROHM
 BD70528 watchdog block
Message-ID: <20190122180309.GD2559@localhost.localdomain>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <ec70833179d1953dbc91e01901b79d3319ff013d.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <20190122154750.GB1705@roeck-us.net>
 <20190122171023.GC2559@localhost.localdomain>
 <20190122174056.GB4964@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122174056.GB4964@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 09:40:56AM -0800, Guenter Roeck wrote:
> On Tue, Jan 22, 2019 at 07:10:23PM +0200, Matti Vaittinen wrote:
> > On Tue, Jan 22, 2019 at 07:47:50AM -0800, Guenter Roeck wrote:
> > > On Tue, Jan 22, 2019 at 11:48:36AM +0200, Matti Vaittinen wrote:
> > > > Initial support for watchdog block included in ROHM BD70528
> > > > power management IC.
> > > > 
> > > > Configurations for low power states are still to be checked.
> > > > 
> > > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > > ---
> > > >  drivers/watchdog/Kconfig       |  12 +++
> > > >  drivers/watchdog/Makefile      |   1 +
> > > >  drivers/watchdog/bd70528_wdt.c | 161 +++++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 174 insertions(+)
> > > >  create mode 100644 drivers/watchdog/bd70528_wdt.c
> > > > 
> > > > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > > > index 57f017d74a97..f30e3a3e886e 100644
> > > > --- a/drivers/watchdog/Kconfig
> > > > +++ b/drivers/watchdog/Kconfig
> > > > @@ -90,6 +90,18 @@ config SOFT_WATCHDOG_PRETIMEOUT
> > > >  	  watchdog. Be aware that governors might affect the watchdog because it
> > > >  	  is purely software, e.g. the panic governor will stall it!
> > > >  
> > > > +config BD70528_WATCHDOG
> > > > +	tristate "ROHM BD70528 PMIC Watchdog"
> > > > +	depends on MFD_ROHM_BD70528
> > > > +	select WATCHDOG_CORE
> > > > +	help
> > > > +	  Support for the watchdog in the ROHM BD70528 PMIC. Watchdog trigger
> > > > +	  cause system reset.
> > > > +
> > > > +	  Say Y here to include support for the ROHM BD70528 watchdog.
> > > > +	  Alternatively say M to compile the driver as a module,
> > > > +	  which will be called bd70528_wdt.
> > > > +
> > > >  config DA9052_WATCHDOG
> > > >  	tristate "Dialog DA9052 Watchdog"
> > > >  	depends on PMIC_DA9052 || COMPILE_TEST
> > > > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > > > index a0917ef28e07..1ce87a3b1172 100644
> > > > --- a/drivers/watchdog/Makefile
> > > > +++ b/drivers/watchdog/Makefile
> > > > @@ -204,6 +204,7 @@ obj-$(CONFIG_WATCHDOG_SUN4V)		+= sun4v_wdt.o
> > > >  obj-$(CONFIG_XEN_WDT) += xen_wdt.o
> > > >  
> > > >  # Architecture Independent
> > > > +obj-$(CONFIG_BD70528_WATCHDOG) += bd70528_wdt.o
> > > >  obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
> > > >  obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
> > > >  obj-$(CONFIG_DA9062_WATCHDOG) += da9062_wdt.o
> > > > diff --git a/drivers/watchdog/bd70528_wdt.c b/drivers/watchdog/bd70528_wdt.c
> > > > new file mode 100644
> > > > index 000000000000..e9a32566f595
> > > > --- /dev/null
> > > > +++ b/drivers/watchdog/bd70528_wdt.c
> > > > @@ -0,0 +1,161 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +// Copyright (C) 2018 ROHM Semiconductors
> > > > +// ROHM BD70528MWV watchdog driver
> > > > +
> > > > +#include <linux/bcd.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/mfd/rohm-bd70528.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/regmap.h>
> > > > +#include <linux/watchdog.h>
> > > > +
> > > > +static int bd70528_wdt_set(struct bd70528 *bd70528, int enable)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	if (bd70528->rtc_timer_lock)
> > > > +		mutex_lock(bd70528->rtc_timer_lock);
> > > 
> > > This looks awkward. I don't think the if() is necessary.
> > 
> > Right. Now when only bd70528 MFD driver uses this WDT this if is not
> > required.
> > 
> That doesn't warrant the conditional. It just bloats the code.
> If there is only one user, the mutex will always be acquired.

Yep. What I meant was that the only possible parent is bd70528 MFD
driver which always initializes the mutex pointer. So pointer should be
always set. I can imagine some other ROHM PMIC having almost identical
watchdog block - in which case we might want to re-use this WDT driver
with this PMIC. And if this PMIC has no RTC, then we may not need this
mutex. But this is all speculation and I will remove check - or see how
this changes when I see what to do with the driver's private data.

> > > > +static const struct watchdog_info bd70528_wdt_info = {
> > > > +	.identity = "bd70528-wdt",
> > > > +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> > > > +};
> > > > +
> > > > +static const struct watchdog_ops bd70528_wdt_ops = {
> > > > +	.start		= bd70528_wdt_start,
> > > > +	.stop		= bd70528_wdt_stop,
> > > > +	/*
> > > > +	 *  bd70528 WDT ping is same as enable. Eg, writing 'enable' to enabled
> > > > +	 * WDT will restart the timeout
> > > > +	 */
> > > Unnecessary comment.
> > > 
> > 
> > Ok. I will remove the comment if this is obvious to others. For me it
> > was not obvious. I was first writing a separate ping and start functions
> > untill I realized that it is the same operation. But this was my first
> > WDT driver so I don't know if this is a normal for all WDTs.
> > 
> It is documented as part of the API.
I'd better read the documentation then. Thanks for pointing this out.
I'll remove the comment.

> > > > +static int bd70528_wdt_probe(struct platform_device *pdev)
> > > > +{
> > > > +	struct bd70528 *tmp;
> > > > +	struct bd70528 *bd70528;
> > > > +	int ret;
> > > > +
> > > > +	tmp = dev_get_drvdata(pdev->dev.parent);
> > > > +	if (!tmp) {
> > > > +		dev_err(&pdev->dev, "No MFD driver data\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +	bd70528 = devm_kzalloc(&pdev->dev, sizeof(*bd70528), GFP_KERNEL);
> > > > +	if (!bd70528)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	*bd70528 = *tmp;
> > > > +	bd70528->chip.dev = &pdev->dev;
> > > 
> > > This is wrong.
> > > You should not copy the parent's driver data but have local driver
> > > data as needed which then points to the parent's driver data if
> > > needed. I assume this is why the mutex is a pointer, but that
> > > just shows that the whole approach is wrong.
> > 
> > Mutex is a pointer because we want to use same mutex from WDT and RTC.
> > We can sure point to parent data but then we still need our own dev
> > pointer. So we can have a struct with pointer to parent data and dev
> > pointer - but I'm not at all sure it is any clearer.
> 
> As I said, that is wrong. To say it in plaintext, I won't accept
> the driver if it copies the parent's driver data. The driver should
> have and use its own driver data, and only maintain a pointer to
> its parent's driver data. And most definitely you don't want to
> copy and use any device data structure from the parent.

Allright. At the moment the WDT driver only needs regmap pointer from
parent. I'm not sure if it will later need DT or "chip type" - but I
will change this.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
