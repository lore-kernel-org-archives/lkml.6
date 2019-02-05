Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D44C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AF220811
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6bXHjCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfBEPOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:14:24 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43645 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729499AbfBEPOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:14:23 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so1602207plb.10;
        Tue, 05 Feb 2019 07:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EnNbfDymy3z49X8lufa7TsEcH7z15yYEcuta2uFe46I=;
        b=C6bXHjCTw0mW4OTZXvQYC9dCWfqZJIOoCBq0eGwXHUfDoEsJHgzipA/Ll+cXDP6Qaq
         WmLe/5W1zvVLbPupqeeZpHhfjtarx6TeHcg3Ro9jDiQ0EWY/3y4w+5TY7f+87DgITI+g
         HjoOxGfdcwVTLu9Ff5KeFuvBD2HX6aGNinOnRxWl0qbJ4lUHkwe6uqnNpSFyVH2jSEXs
         guw5iYtblWpIwUOP9JXk40i05jo5UzsQ5rAPG09VoQOfV/AVY0nESViyJ7U1BELgWzRz
         aCt/NUYGBli6+XioLb0wZABd4xof2r1L83kdKwbRkZjp3Tbc2OtnxVIOafzQrAzbtfQK
         YrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EnNbfDymy3z49X8lufa7TsEcH7z15yYEcuta2uFe46I=;
        b=e1ukShUllICydIv6EJ8lcWtFzZ0s4l+v07MqDaob0P6aeEeFmYtRkZHDVZcKyFwhgV
         x2L7GbVAArydD7O7+gO/RShiAKJ18UxDOuLS6WuTocXdIS1rsujgfA97rM8PXa5427Xa
         fZVLCyAcdTO+L5PGucsy3c8xTSxLDuFRLIv97bmJ3Qtt+qNpwi7T4hAoZyFealm0A4Lh
         w2iRf1yBtJOiJmTRIEGQwl4rAD3RzB1fxTkXJiSVYD/zhuJ3+F6HmfIGhBfvtjv5j0n5
         mQ/zf5WVHf5wiXlsJjucPz7fKlw2uaQYPjPx5KB8eNa8vZ3rDRnnHTZjXyOREouxB2sY
         yazw==
X-Gm-Message-State: AHQUAuZTgGX1cLujLftpriSLwXmGtaA4W0jtU6P1t3uSRy24BKJZDuB2
        QMYYCUbjokHrqOOKG8hEnaAtXWK4
X-Google-Smtp-Source: AHgI3IbreHVdbRreR172zi9cUYL28hP7o00JN5QkpYozArGAJV2A/8U+IAeCpSTz6IW5yGG+93XQdA==
X-Received: by 2002:a17:902:1122:: with SMTP id d31mr5600439pla.246.1549379662094;
        Tue, 05 Feb 2019 07:14:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r6sm4828547pgk.91.2019.02.05.07.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 07:14:21 -0800 (PST)
Subject: Re: [PATCH v6 10/10] watchdog: bd70528: Initial support for ROHM
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
References: <cover.1549356505.git.matti.vaittinen@fi.rohmeurope.com>
 <a0079e8a89a770933062c14cab82d24c1370266e.1549356505.git.matti.vaittinen@fi.rohmeurope.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <58a0eafc-96d5-7f9e-dbe9-efcd66f06d51@roeck-us.net>
Date:   Tue, 5 Feb 2019 07:14:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a0079e8a89a770933062c14cab82d24c1370266e.1549356505.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/19 1:09 AM, Matti Vaittinen wrote:
> Initial support for watchdog block included in ROHM BD70528
> power management IC.
> 
> Configurations for low power states are still to be checked.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> ---
> 
> Please note that I translated following comment:
> 
> "Otherwise I am ok with the patch." from Guenter into an acked-by
> above. Please let me know if that's not Ok.

That is ok.

Thanks,
Guenter

> 
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
> index 000000000000..cab802ddde06
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
> +	return bd70528->wdt_set(bd70528, enable, NULL);
> +}
> +
> +static int bd70528_wdt_set(struct wdtbd70528 *w, int enable)
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
> +	return bd70528_wdt_set(w, 1);
> +}
> +
> +static int bd70528_wdt_stop(struct watchdog_device *wdt)
> +{
> +	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
> +
> +	dev_dbg(w->dev, "WDT stopping...\n");
> +	return bd70528_wdt_set(w, 0);
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

