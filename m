Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D6DC282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85CE2184B
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPU/kCY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfAZQgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:36:20 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42682 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfAZQgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:36:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so5410216pga.9;
        Sat, 26 Jan 2019 08:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MN5Yd+GZ+1d0sSpmST1GZif/BnYu5CGKz8fJsuK8Bu4=;
        b=CPU/kCY8OcLI5dPWbX+CLZXgTCVdi0xmnNOMzz8jAk7xjeGEYbcGaxAxqyc7WOfghZ
         GV2v5BZqoJ6e0NtIQw/IpOMpXVGIq/RDlHm6Fhzj+VTvl14DcgRueS7aAYiPkI4zF1eG
         Sn9UMqt6Ogjfhw3Pv31xuCVC4ON3nRFWYZHw4jEzdJDeckXNpDXlS6gss5+rsT6lhMlT
         +7g0agMQ+Z80jTqiOz3HkaKvj2RV8zo1AMiPNaGNfpZcwo04xT05RLkSACxB7I0KrXOd
         bFzkMOha+8cai+FTKrl2JnZT09heLvo1dgW7lfu5pQzGGfodI9iiKC+jZfQ86UAyMboX
         kkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MN5Yd+GZ+1d0sSpmST1GZif/BnYu5CGKz8fJsuK8Bu4=;
        b=RC4SXffzjxfUzEsVNE85sot3jgxwfnC7EhIzrIsqLk7zl2zfjw172fSHtkzMhvtPZ6
         +rJ+MOhfBN/vDM1j+5LFLtz8nEP1Cck2XZFwd/8V/MyQ8q1drrWRkaJumVBrRFgcab3P
         0KauCOOQUWfmhoVCoTHcdmbeKQLcFaazwheUHKECtrMwsat31qndtQ0+tcash4veHsF2
         nd44wRWLxJ9wA3Icgx4RILFnZYJ3ooTvvCKDYhZN2bmvECgSsxGrOBYaR4nnUD7+J8bY
         s4B88a5Jv/UnBzAu8it4NWRVd7os0h+cwQgWwReLCDTKiOKURA6fYbZXcHltwxBZejnO
         eonQ==
X-Gm-Message-State: AJcUukd3mXgaiNeBIqwcm/lhY3QJWIPzRpSq38El/r7oflOkm01KH6PN
        /F8bLx9wncVCoWU78HFtsxoL2SqM
X-Google-Smtp-Source: ALg8bN7qNOWibE0dUFeCdWpZoO793c4GouWzao94ttwYT4K+R8aIoW+i0ZDrZvBaCD4EJCx9O9ztOg==
X-Received: by 2002:a62:5b44:: with SMTP id p65mr15277467pfb.47.1548520578381;
        Sat, 26 Jan 2019 08:36:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v89sm40327183pfk.12.2019.01.26.08.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 08:36:17 -0800 (PST)
Subject: Re: [RFC PATCH v2 10/10] watchdog: bd70528: Initial support for ROHM
 BD70528 watchdog block
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
Cc:     heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
References: <20190125110625.GA29348@localhost.localdomain>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <1d05ec19-daf6-f1d9-f80c-57fc92906d22@roeck-us.net>
Date:   Sat, 26 Jan 2019 08:36:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125110625.GA29348@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/19 3:06 AM, Matti Vaittinen wrote:
> Initial support for watchdog block included in ROHM BD70528
> power management IC.
> 
> Configurations for low power states are still to be checked.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>   drivers/watchdog/Kconfig       |  12 +++
>   drivers/watchdog/Makefile      |   1 +
>   drivers/watchdog/bd70528_wdt.c | 183 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 196 insertions(+)
>   create mode 100644 drivers/watchdog/bd70528_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 57f017d74a97..f30e3a3e886e 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -90,6 +90,18 @@ config SOFT_WATCHDOG_PRETIMEOUT
>   	  watchdog. Be aware that governors might affect the watchdog because it
>   	  is purely software, e.g. the panic governor will stall it!
>   
> +config BD70528_WATCHDOG
> +	tristate "ROHM BD70528 PMIC Watchdog"
> +	depends on MFD_ROHM_BD70528
> +	select WATCHDOG_CORE
> +	help
> +	  Support for the watchdog in the ROHM BD70528 PMIC. Watchdog trigger
> +	  cause system reset.
> +
> +	  Say Y here to include support for the ROHM BD70528 watchdog.
> +	  Alternatively say M to compile the driver as a module,
> +	  which will be called bd70528_wdt.
> +
>   config DA9052_WATCHDOG
>   	tristate "Dialog DA9052 Watchdog"
>   	depends on PMIC_DA9052 || COMPILE_TEST
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index a0917ef28e07..1ce87a3b1172 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -204,6 +204,7 @@ obj-$(CONFIG_WATCHDOG_SUN4V)		+= sun4v_wdt.o
>   obj-$(CONFIG_XEN_WDT) += xen_wdt.o
>   
>   # Architecture Independent
> +obj-$(CONFIG_BD70528_WATCHDOG) += bd70528_wdt.o
>   obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
>   obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
>   obj-$(CONFIG_DA9062_WATCHDOG) += da9062_wdt.o
> diff --git a/drivers/watchdog/bd70528_wdt.c b/drivers/watchdog/bd70528_wdt.c
> new file mode 100644
> index 000000000000..347339683cb9
> --- /dev/null
> +++ b/drivers/watchdog/bd70528_wdt.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 ROHM Semiconductors
> +// ROHM BD70528MWV watchdog driver
> +
> +#include <linux/bcd.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/rohm-bd70528.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/watchdog.h>
> +
> +struct wdtbd70528 {
> +	struct bd70528 *bd;
> +	struct device *dev;
> +};
> +
> +static int bd70528_wdt_set(struct bd70528 *bd70528, int enable)
> +{
> +	int ret;
> +
> +	mutex_lock(&bd70528->rtc_timer_lock);
> +	ret = bd70528->wdt_set(bd70528, enable, NULL);
> +	mutex_unlock(&bd70528->rtc_timer_lock);
> +
> +	return ret;
> +}
> +
> +static int bd70528_wdt_start(struct watchdog_device *wdt)
> +{
> +	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
> +
> +	dev_dbg(w->dev, "WDT ping...\n");
> +	return bd70528_wdt_set(w->bd, 1);
> +}
> +
> +static int bd70528_wdt_stop(struct watchdog_device *wdt)
> +{
> +	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
> +
> +	dev_dbg(w->dev, "WDT stopping...\n");
> +	return bd70528_wdt_set(w->bd, 0);
> +}
> +
> +static int bd70528_wdt_set_timeout(struct watchdog_device *wdt,
> +				    unsigned int timeout)
> +{
> +	unsigned int hours;
> +	unsigned int minutes;
> +	unsigned int seconds;
> +	int ret;
> +	struct bd70528 *bd70528;
> +	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
> +
> +	bd70528 = w->bd;
> +	seconds = timeout;
> +	hours = timeout / (60 * 60);
> +	/* Maximum timeout is 1h 59m 59s => hours is 1 or 0 */
> +	if (hours)
> +		seconds -= (60 * 60);
> +	minutes = seconds / 60;
> +	seconds = seconds % 60;
> +
> +	mutex_lock(&bd70528->rtc_timer_lock);
> +
> +	ret = bd70528->wdt_set(bd70528, 0, NULL);
> +	if (ret)
> +		goto out_unlock;
> +
> +	ret = regmap_update_bits(bd70528->chip.regmap, BD70528_REG_WDT_HOUR,
> +				 BD70528_MASK_WDT_HOUR, hours);
> +	if (ret) {
> +		dev_err(w->dev, "Failed to set WDT hours\n");
> +		goto out_en_unlock;
> +	}
> +	ret = regmap_update_bits(bd70528->chip.regmap, BD70528_REG_WDT_MINUTE,
> +				 BD70528_MASK_WDT_MINUTE, bin2bcd(minutes));
> +	if (ret) {
> +		dev_err(w->dev, "Failed to set WDT minutes\n");
> +		goto out_en_unlock;
> +	}
> +	ret = regmap_update_bits(bd70528->chip.regmap, BD70528_REG_WDT_SEC,
> +				 BD70528_MASK_WDT_SEC, bin2bcd(seconds));
> +	if (ret)
> +		dev_err(w->dev, "Failed to set WDT seconds\n");
> +	else
> +		dev_dbg(w->dev, "WDT tmo set to %u\n", timeout);
> +
> +out_en_unlock:
> +	ret = bd70528->wdt_set(bd70528, 1, NULL);
> +out_unlock:
> +	mutex_unlock(&bd70528->rtc_timer_lock);
> +
> +	return ret;
> +}
> +
> +static const struct watchdog_info bd70528_wdt_info = {
> +	.identity = "bd70528-wdt",
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +};
> +
> +static const struct watchdog_ops bd70528_wdt_ops = {
> +	.start		= bd70528_wdt_start,
> +	.stop		= bd70528_wdt_stop,
> +	.set_timeout	= bd70528_wdt_set_timeout,
> +};
> +
> +/* Max time we can set is 1 hour, 59 minutes and 59 seconds */
> +#define WDT_MAX_MS ((2 * 60 * 60 - 1) * 1000)
> +/* Minimum time is 1 second */
> +#define WDT_MIN_MS 1000
> +#define DEFAULT_TIMEOUT 60
> +
> +static int bd70528_wdt_probe(struct platform_device *pdev)
> +{
> +	struct bd70528 *bd70528;
> +	struct wdtbd70528 *w;
> +	int ret;
> +	unsigned int reg;
> +	struct watchdog_device *wdt;
> +
> +	bd70528 = dev_get_drvdata(pdev->dev.parent);
> +	if (!bd70528) {
> +		dev_err(&pdev->dev, "No MFD driver data\n");
> +		return -EINVAL;
> +	}
> +	w = devm_kzalloc(&pdev->dev, sizeof(*w), GFP_KERNEL);
> +	if (!w)
> +		return -ENOMEM;
> +	w->bd = bd70528;

Unless I am missing something, only the mutex and the regmap pointer
are used from struct bd70528. With that in mind, it might be desirable
to copy those pointers to struct wdtbd70528 to avoid the additional
dereferencing at runtime.

> +	w->dev = &pdev->dev;
> +
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +

struct watchdog_device can be part of struct wdtbd70528. Two separate allocations
are not necessary.

> +	wdt->info = &bd70528_wdt_info;
> +	wdt->ops =  &bd70528_wdt_ops;
> +	wdt->min_hw_heartbeat_ms = WDT_MIN_MS;
> +	wdt->max_hw_heartbeat_ms = WDT_MAX_MS;
> +	wdt->parent = pdev->dev.parent;
> +	wdt->timeout = DEFAULT_TIMEOUT;
> +	watchdog_set_drvdata(wdt, w);
> +	watchdog_init_timeout(wdt, 0, pdev->dev.parent);
> +
> +	ret = bd70528_wdt_set_timeout(wdt, wdt->timeout);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to set the watchdog timeout\n");
> +		return ret;
> +	}
> +
> +	mutex_lock(&bd70528->rtc_timer_lock);
> +	ret = regmap_read(bd70528->chip.regmap, BD70528_REG_WDT_CTRL, &reg);
> +	mutex_unlock(&bd70528->rtc_timer_lock);
> +

I don't see the point for the above mutex locks. This is just reading a
single register. regmap itself provides locking for that already.

> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to get the watchdog state\n");
> +		return ret;
> +	}
> +	if (reg & BD70528_MASK_WDT_EN) {
> +		dev_dbg(&pdev->dev, "watchdog was running during probe\n");
> +		set_bit(WDOG_HW_RUNNING, &wdt->status);
> +	}
> +
> +	ret = devm_watchdog_register_device(&pdev->dev, wdt);
> +	if (ret < 0)
> +		dev_err(&pdev->dev, "watchdog registration failed: %d\n", ret);
> +
> +	return ret;
> +}
> +static struct platform_driver bd70528_wdt = {
> +	.driver = {
> +		.name = "bd70528-wdt"
> +	},
> +	.probe = bd70528_wdt_probe,
> +};
> +
> +module_platform_driver(bd70528_wdt);
> +
> +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> +MODULE_DESCRIPTION("BD70528 watchdog driver");
> +MODULE_LICENSE("GPL");
> 

