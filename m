Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43441C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19CB2190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7NQi1cB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387625AbfBMPJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:09:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35408 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfBMPJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:09:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id z15so1276209pfa.2;
        Wed, 13 Feb 2019 07:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HNRIMKWaFAmlXZkyfAelVkvcMuYDk4i5e9cS7y34bKs=;
        b=P7NQi1cBGJGIdpInQJLJQLwVrxKVa5abSO/H886lOzAwOKmEBIdbys3lhrSHxQ+nRy
         aNWvRSOv35QVD0zdEaEFRgG5X+57MhBSBpzxy1U9ZWxyEA+RYESk6vBRCcBZ4HUMJIZV
         0KcFLtkPVmXrsE06ULuFT2wqwLPOVZoxRwkAJ/+LGBHPruQEoQUWr36vrKpSN2CsFWN1
         u8RsAkg9en2MxJSZPdZUqUpKyoOKs0bZbhOlqJ3TZStap0IdQJiH4ei3+HqBzDXTdlWp
         KZNJgdyEPsCKig2wErMKDWH6f44Z9UjOJU1LbKexCqgkk2FF+qnJFaa+67B+8KwfuO9v
         n2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HNRIMKWaFAmlXZkyfAelVkvcMuYDk4i5e9cS7y34bKs=;
        b=f5SGuWYhGbdTq76MRUPR7LbpVtjod+4g01PQdemwZLag7xB4EWbz9mdmtKL9RSLMFA
         NeqOvds1tWjw/z4HbTrIiS2Ofvny64vWdsOSSsRq6avJzlBxnHEIxQ8ooiODON8dq2y/
         Qn5ogyvaxrvm/zCnd2yP3ZY5oyjc7oIJyWv71YxCi90ST8n0G/emTPAG5h6owF/q8/uc
         VQm9It+Si7ir+dzE2xqlXFGZQLYR8TIfg9uIzMLOtvIAkdtRCt9wWgDuAN2EDph7GH+s
         EJWxSD+KR7/JEUhC8oGqr9j/DE/LWYOE7uIg/d3We/chqMqpsC/UOpnkadTBGu66CN8F
         MbAA==
X-Gm-Message-State: AHQUAuaTzoKTJgdA2HEJToRtu4kVFMI8GCm5RpLIb6GL4NMKOAZBa0Bj
        NzokkZhYQQ9F2Kbw9xKFjRY=
X-Google-Smtp-Source: AHgI3IYH0IFLcwf5IxoGwp9v50vlvFrk5o9gjKGn16uS56IjoxBbU57lFSMQKnWMc73Qp9/RzuZ7sw==
X-Received: by 2002:a63:4566:: with SMTP id u38mr919000pgk.4.1550070551238;
        Wed, 13 Feb 2019 07:09:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p12sm39793921pfj.81.2019.02.13.07.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 07:09:10 -0800 (PST)
Subject: Re: [PATCH v9 8/8] watchdog: bd70528: Initial support for ROHM
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
        linux-watchdog@vger.kernel.org, bogdan-petru.chircu-mare@nxp.com
References: <cover.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
 <5aab97a1d68d131d0c5d37e0a78d3c8147a52e9e.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f11554b9-1842-13bc-7ceb-ca7589eb4518@roeck-us.net>
Date:   Wed, 13 Feb 2019 07:09:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5aab97a1d68d131d0c5d37e0a78d3c8147a52e9e.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/19 5:37 AM, Matti Vaittinen wrote:
> Initial support for watchdog block included in ROHM BD70528
> power management IC.
> 
> Configurations for low power states are still to be checked.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> ---
> 
> I maintained the ack from Guenter as only change is to use function
> exported by MFD instead of pointer to function provided by MFD. Please
> let me know if this is not Ok.
> 

NP. With functions exported by MFD, my choice would have been to handle
locking there as well with respective locking/unlocking functions exported.
But that is your call to make, not mine.

Guenter

>   drivers/watchdog/Kconfig       |  12 +++
>   drivers/watchdog/Makefile      |   1 +
>   drivers/watchdog/bd70528_wdt.c | 190 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 203 insertions(+)
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
> index 000000000000..5921be93c1ba
> --- /dev/null
> +++ b/drivers/watchdog/bd70528_wdt.c
> @@ -0,0 +1,190 @@
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
> +/*
> + * Max time we can set is 1 hour, 59 minutes and 59 seconds
> + * and Minimum time is 1 second
> + */
> +#define WDT_MAX_MS	((2 * 60 * 60 - 1) * 1000)
> +#define WDT_MIN_MS	1000
> +#define DEFAULT_TIMEOUT	60
> +
> +struct wdtbd70528 {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct mutex *rtc_lock;
> +	struct watchdog_device wdt;
> +};
> +
> +static int bd70528_wdt_set_locked(struct wdtbd70528 *w, int enable)
> +{
> +	struct bd70528 *bd70528;
> +
> +	bd70528 = container_of(w->rtc_lock, struct bd70528, rtc_timer_lock);
> +	return bd70528_wdt_set(bd70528, enable, NULL);
> +}
> +
> +static int bd70528_wdt_change(struct wdtbd70528 *w, int enable)
> +{
> +	int ret;
> +
> +	mutex_lock(w->rtc_lock);
> +	ret = bd70528_wdt_set_locked(w, enable);
> +	mutex_unlock(w->rtc_lock);
> +
> +	return ret;
> +}
> +
> +static int bd70528_wdt_start(struct watchdog_device *wdt)
> +{
> +	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
> +
> +	dev_dbg(w->dev, "WDT ping...\n");
> +	return bd70528_wdt_change(w, 1);
> +}
> +
> +static int bd70528_wdt_stop(struct watchdog_device *wdt)
> +{
> +	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
> +
> +	dev_dbg(w->dev, "WDT stopping...\n");
> +	return bd70528_wdt_change(w, 0);
> +}
> +
> +static int bd70528_wdt_set_timeout(struct watchdog_device *wdt,
> +				    unsigned int timeout)
> +{
> +	unsigned int hours;
> +	unsigned int minutes;
> +	unsigned int seconds;
> +	int ret;
> +	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
> +
> +	seconds = timeout;
> +	hours = timeout / (60 * 60);
> +	/* Maximum timeout is 1h 59m 59s => hours is 1 or 0 */
> +	if (hours)
> +		seconds -= (60 * 60);
> +	minutes = seconds / 60;
> +	seconds = seconds % 60;
> +
> +	mutex_lock(w->rtc_lock);
> +
> +	ret = bd70528_wdt_set_locked(w, 0);
> +	if (ret)
> +		goto out_unlock;
> +
> +	ret = regmap_update_bits(w->regmap, BD70528_REG_WDT_HOUR,
> +				 BD70528_MASK_WDT_HOUR, hours);
> +	if (ret) {
> +		dev_err(w->dev, "Failed to set WDT hours\n");
> +		goto out_en_unlock;
> +	}
> +	ret = regmap_update_bits(w->regmap, BD70528_REG_WDT_MINUTE,
> +				 BD70528_MASK_WDT_MINUTE, bin2bcd(minutes));
> +	if (ret) {
> +		dev_err(w->dev, "Failed to set WDT minutes\n");
> +		goto out_en_unlock;
> +	}
> +	ret = regmap_update_bits(w->regmap, BD70528_REG_WDT_SEC,
> +				 BD70528_MASK_WDT_SEC, bin2bcd(seconds));
> +	if (ret)
> +		dev_err(w->dev, "Failed to set WDT seconds\n");
> +	else
> +		dev_dbg(w->dev, "WDT tmo set to %u\n", timeout);
> +
> +out_en_unlock:
> +	ret = bd70528_wdt_set_locked(w, 1);
> +out_unlock:
> +	mutex_unlock(w->rtc_lock);
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
> +static int bd70528_wdt_probe(struct platform_device *pdev)
> +{
> +	struct bd70528 *bd70528;
> +	struct wdtbd70528 *w;
> +	int ret;
> +	unsigned int reg;
> +
> +	bd70528 = dev_get_drvdata(pdev->dev.parent);
> +	if (!bd70528) {
> +		dev_err(&pdev->dev, "No MFD driver data\n");
> +		return -EINVAL;
> +	}
> +	w = devm_kzalloc(&pdev->dev, sizeof(*w), GFP_KERNEL);
> +	if (!w)
> +		return -ENOMEM;
> +
> +	w->regmap = bd70528->chip.regmap;
> +	w->rtc_lock = &bd70528->rtc_timer_lock;
> +	w->dev = &pdev->dev;
> +
> +	w->wdt.info = &bd70528_wdt_info;
> +	w->wdt.ops =  &bd70528_wdt_ops;
> +	w->wdt.min_hw_heartbeat_ms = WDT_MIN_MS;
> +	w->wdt.max_hw_heartbeat_ms = WDT_MAX_MS;
> +	w->wdt.parent = pdev->dev.parent;
> +	w->wdt.timeout = DEFAULT_TIMEOUT;
> +	watchdog_set_drvdata(&w->wdt, w);
> +	watchdog_init_timeout(&w->wdt, 0, pdev->dev.parent);
> +
> +	ret = bd70528_wdt_set_timeout(&w->wdt, w->wdt.timeout);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to set the watchdog timeout\n");
> +		return ret;
> +	}
> +
> +	mutex_lock(w->rtc_lock);
> +	ret = regmap_read(w->regmap, BD70528_REG_WDT_CTRL, &reg);
> +	mutex_unlock(w->rtc_lock);
> +
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to get the watchdog state\n");
> +		return ret;
> +	}
> +	if (reg & BD70528_MASK_WDT_EN) {
> +		dev_dbg(&pdev->dev, "watchdog was running during probe\n");
> +		set_bit(WDOG_HW_RUNNING, &w->wdt.status);
> +	}
> +
> +	ret = devm_watchdog_register_device(&pdev->dev, &w->wdt);
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

