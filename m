Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9074C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE0420879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfAVRKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:10:32 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35194 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbfAVRKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:10:32 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so21349176ljb.2;
        Tue, 22 Jan 2019 09:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Omd9lHu+tGDackOr8psvsmVsE5lGs+EJhEFZ40+ioJw=;
        b=RDKQTt30EoufpiSMUvMX+ap6W/NPPLf5IKuB3LrVrDb43h/VMiXnYaVpg4j0pQklkn
         R3SsEeWSAzEe31o17SbUjmwF/PT8Yotw32ilQs5RHJpIOdBAhv/Qlk/yHUlJGaVlRbY+
         9xO/7bMIwiiCD1fLr+ZMUY5Y3riYvBgT4ELGWwJyGnUZ+bXS8vLoIqUr0OKnkYpBBBr8
         k1zPrvNgDxD1LBhBoEYmfvaMOSonRy/LXA/J0WExv5fRk7plb/4QIReRu+gg7RZhjANN
         6+gKSlmrET/YUCe4QhgHYHa8P68nffMXBmGdnzmb826/ydE/+4OSCvjUYhGoTerWzmy8
         9wxg==
X-Gm-Message-State: AJcUukeaSn0OmIFamKRaNcXwyFKk+51aPtx5VQpRgtuQAuHd8y/V7cAo
        TDaXC0fQZRDNKyJQ/z9Ho80=
X-Google-Smtp-Source: ALg8bN6tlyTGBSfPMDGZE0TLQdpeOAoramkhomhjg/RhwVbqp3V+5/xIByVf0NtB2G7sRu9BaQZKPg==
X-Received: by 2002:a2e:8855:: with SMTP id z21-v6mr1201262ljj.191.1548177027510;
        Tue, 22 Jan 2019 09:10:27 -0800 (PST)
Received: from localhost.localdomain (82-203-157-3.bb.dnainternet.fi. [82.203.157.3])
        by smtp.gmail.com with ESMTPSA id w9sm87447lfc.66.2019.01.22.09.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 09:10:26 -0800 (PST)
Date:   Tue, 22 Jan 2019 19:10:23 +0200
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
Message-ID: <20190122171023.GC2559@localhost.localdomain>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <ec70833179d1953dbc91e01901b79d3319ff013d.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <20190122154750.GB1705@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122154750.GB1705@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 07:47:50AM -0800, Guenter Roeck wrote:
> On Tue, Jan 22, 2019 at 11:48:36AM +0200, Matti Vaittinen wrote:
> > Initial support for watchdog block included in ROHM BD70528
> > power management IC.
> > 
> > Configurations for low power states are still to be checked.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  drivers/watchdog/Kconfig       |  12 +++
> >  drivers/watchdog/Makefile      |   1 +
> >  drivers/watchdog/bd70528_wdt.c | 161 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 174 insertions(+)
> >  create mode 100644 drivers/watchdog/bd70528_wdt.c
> > 
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 57f017d74a97..f30e3a3e886e 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -90,6 +90,18 @@ config SOFT_WATCHDOG_PRETIMEOUT
> >  	  watchdog. Be aware that governors might affect the watchdog because it
> >  	  is purely software, e.g. the panic governor will stall it!
> >  
> > +config BD70528_WATCHDOG
> > +	tristate "ROHM BD70528 PMIC Watchdog"
> > +	depends on MFD_ROHM_BD70528
> > +	select WATCHDOG_CORE
> > +	help
> > +	  Support for the watchdog in the ROHM BD70528 PMIC. Watchdog trigger
> > +	  cause system reset.
> > +
> > +	  Say Y here to include support for the ROHM BD70528 watchdog.
> > +	  Alternatively say M to compile the driver as a module,
> > +	  which will be called bd70528_wdt.
> > +
> >  config DA9052_WATCHDOG
> >  	tristate "Dialog DA9052 Watchdog"
> >  	depends on PMIC_DA9052 || COMPILE_TEST
> > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > index a0917ef28e07..1ce87a3b1172 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -204,6 +204,7 @@ obj-$(CONFIG_WATCHDOG_SUN4V)		+= sun4v_wdt.o
> >  obj-$(CONFIG_XEN_WDT) += xen_wdt.o
> >  
> >  # Architecture Independent
> > +obj-$(CONFIG_BD70528_WATCHDOG) += bd70528_wdt.o
> >  obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
> >  obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
> >  obj-$(CONFIG_DA9062_WATCHDOG) += da9062_wdt.o
> > diff --git a/drivers/watchdog/bd70528_wdt.c b/drivers/watchdog/bd70528_wdt.c
> > new file mode 100644
> > index 000000000000..e9a32566f595
> > --- /dev/null
> > +++ b/drivers/watchdog/bd70528_wdt.c
> > @@ -0,0 +1,161 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 ROHM Semiconductors
> > +// ROHM BD70528MWV watchdog driver
> > +
> > +#include <linux/bcd.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/rohm-bd70528.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/watchdog.h>
> > +
> > +static int bd70528_wdt_set(struct bd70528 *bd70528, int enable)
> > +{
> > +	int ret;
> > +
> > +	if (bd70528->rtc_timer_lock)
> > +		mutex_lock(bd70528->rtc_timer_lock);
> 
> This looks awkward. I don't think the if() is necessary.

Right. Now when only bd70528 MFD driver uses this WDT this if is not
required.

> > +
> > +	ret = bd70528->wdt_set(bd70528, enable, NULL);
> > +
> > +	if (bd70528->rtc_timer_lock)
> > +		mutex_unlock(bd70528->rtc_timer_lock);
> > +	return ret;
> > +}
> > +
> > +static int bd70528_wdt_start(struct watchdog_device *wdt)
> > +{
> > +	struct bd70528 *bd70528 = watchdog_get_drvdata(wdt);
> > +
> > +	return bd70528_wdt_set(bd70528, 1);
> > +}
> > +
> > +static int bd70528_wdt_stop(struct watchdog_device *wdt)
> > +{
> > +	struct bd70528 *bd70528 = watchdog_get_drvdata(wdt);
> > +
> > +	return bd70528_wdt_set(bd70528, 0);
> > +}
> > +
> > +static int bd70528_wdt_set_timeout(struct watchdog_device *wdt,
> > +				    unsigned int timeout)
> > +{
> > +	unsigned int hours;
> > +	unsigned int minutes;
> > +	unsigned int seconds;
> > +	int ret;
> > +	struct bd70528 *bd70528 = watchdog_get_drvdata(wdt);
> > +
> > +	seconds = timeout;
> > +	hours = timeout / (60 * 60);
> > +	/* Maximum timeout is 1h 59m 59s => hours is 1 or 0 */
> > +	if (hours)
> > +		seconds -= (60 * 60);
> > +	minutes = seconds / 60;
> > +	seconds = seconds % 60;
> > +
> > +	if (bd70528->rtc_timer_lock)
> > +		mutex_lock(bd70528->rtc_timer_lock);
> > +
> > +	ret = bd70528->wdt_set(bd70528, 0, NULL);
> > +	if (ret)
> > +		goto out_unlock;
> > +
> > +	ret = regmap_update_bits(bd70528->chip.regmap, BD70528_REG_WDT_HOUR,
> > +				 BD70528_MASK_WDT_HOUR, hours);
> > +	if (ret) {
> > +		dev_err(bd70528->chip.dev, "Failed to set WDT hours\n");
> > +		goto out_en_unlock;
> > +	}
> > +	ret = regmap_update_bits(bd70528->chip.regmap, BD70528_REG_WDT_MINUTE,
> > +				 BD70528_MASK_WDT_MINUTE, bin2bcd(minutes));
> > +	if (ret) {
> > +		dev_err(bd70528->chip.dev, "Failed to set WDT minutes\n");
> > +		goto out_en_unlock;
> > +	}
> > +	ret = regmap_update_bits(bd70528->chip.regmap, BD70528_REG_WDT_SEC,
> > +				 BD70528_MASK_WDT_SEC, bin2bcd(seconds));
> > +	if (ret) {
> > +		dev_err(bd70528->chip.dev, "Failed to set WDT seconds\n");
> > +		goto out_en_unlock;
> 
> Unnecessary goto.

True. I'll drop this.

> 
> > +	}
> > +
> > +out_en_unlock:
> > +	ret = bd70528->wdt_set(bd70528, 1, NULL);
> > +out_unlock:
> > +	if (bd70528->rtc_timer_lock)
> > +		mutex_lock(bd70528->rtc_timer_lock);
> 
> I don't think this code was ever tested.

Yep. This should be unlock. What comes to testingI'll quote the
cover-sheet for the patch set:

> Currently only MFD core, clk, RTC and regulator portions are
> somehow tested. The RFC series also include initial gpio, power-supply
> and watchdog patches in order to provide better overview on chip
> and to collect initial feedback. Reset and ADC are not supported by
> this series.

I think having the wdt_set and rtc_timer_lock in MFD would have been
completely mysterious if watchdog draft was not included =)

> > +static const struct watchdog_info bd70528_wdt_info = {
> > +	.identity = "bd70528-wdt",
> > +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> > +};
> > +
> > +static const struct watchdog_ops bd70528_wdt_ops = {
> > +	.start		= bd70528_wdt_start,
> > +	.stop		= bd70528_wdt_stop,
> > +	/*
> > +	 *  bd70528 WDT ping is same as enable. Eg, writing 'enable' to enabled
> > +	 * WDT will restart the timeout
> > +	 */
> Unnecessary comment.
> 

Ok. I will remove the comment if this is obvious to others. For me it
was not obvious. I was first writing a separate ping and start functions
untill I realized that it is the same operation. But this was my first
WDT driver so I don't know if this is a normal for all WDTs.

> > +	.ping		= bd70528_wdt_start,
> > +	.set_timeout	= bd70528_wdt_set_timeout,
> > +};
> > +
> > +/* Max time we can set is 1 hour, 59 minutes and 59 seconds */
> > +#define WDT_MAX_MS ((2 * 60 * 60 - 1) * 1000)
> > +/* Minimum time is 1 second */
> > +#define WDT_MIN_MS 1000
> > +static struct watchdog_device bd70528_wd = {
> > +	.info = &bd70528_wdt_info,
> > +	.ops =  &bd70528_wdt_ops,
> > +	.min_hw_heartbeat_ms = WDT_MIN_MS,
> > +	.max_hw_heartbeat_ms = WDT_MAX_MS,
> > +};
> > +
> > +static int bd70528_wdt_probe(struct platform_device *pdev)
> > +{
> > +	struct bd70528 *tmp;
> > +	struct bd70528 *bd70528;
> > +	int ret;
> > +
> > +	tmp = dev_get_drvdata(pdev->dev.parent);
> > +	if (!tmp) {
> > +		dev_err(&pdev->dev, "No MFD driver data\n");
> > +		return -EINVAL;
> > +	}
> > +	bd70528 = devm_kzalloc(&pdev->dev, sizeof(*bd70528), GFP_KERNEL);
> > +	if (!bd70528)
> > +		return -ENOMEM;
> > +
> > +	*bd70528 = *tmp;
> > +	bd70528->chip.dev = &pdev->dev;
> 
> This is wrong.
> You should not copy the parent's driver data but have local driver
> data as needed which then points to the parent's driver data if
> needed. I assume this is why the mutex is a pointer, but that
> just shows that the whole approach is wrong.

Mutex is a pointer because we want to use same mutex from WDT and RTC.
We can sure point to parent data but then we still need our own dev
pointer. So we can have a struct with pointer to parent data and dev
pointer - but I'm not at all sure it is any clearer.
> 
> > +
> > +	/*
> > +	 * TODO: Set the initial state and timeout.
> 
> Confused. Why don't you just do it ?

I will. But it's not ready yet. I still wanted to include the WDT for
this RFC. And I hope I could get the MFD core part included in Lee's
tree at early phase so that the include/linux/mfd/rohm-bd70528.h would
be in other sub trees when they're finalized for upstreaming.

> 
> > +	 * See whether the low power states require special handling
> > +	 */
> > +	watchdog_set_drvdata(&bd70528_wd, bd70528);
> 
> At least in theory there can be more than one of those devices
> in the system, since it is an i2c device. With that in mind, bd70528_wd
> should be locally allocated.

Point taken, thanks.

> Also, bd70528_wd should be fully initialized. For example, the parent
> device is not set.

Thanks for this point too =) I will see what are all the missing
initializations before sending out the final version.

I do really appreciate that you see the trouble of doing the review and
giving me the push to right direction!

Br,
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
