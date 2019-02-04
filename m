Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193B5C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73A82083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKPaJg6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfBDOiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:38:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45740 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbfBDOit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:38:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so4820pgc.12;
        Mon, 04 Feb 2019 06:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kOAELGx8k88bTnoKArCwZ1BN4DgVz6D5T6w5/jtP8Vw=;
        b=DKPaJg6c2hS7EPbUljwoujf1BzMugn8C6ZEvTuHOveG6aituYK445RP+Tugr+80Qss
         JhfI/ZtsOPxWQIdB+mCrbYsdV20H1GEgf6kaMMavdt527s67n0pIlq64deRwQtna9xFX
         qpLO4fwiH80hPtwxsSHVmM85/OHuMpxU675JTvfvXYCir395G/6JOrR5jI9vh/FFpuy1
         esgZ4uPEIHDh67yhvz/+g0d1ufPZrQaUkqyP+cRPl3U3eTRsGpR4KqZDZM0BvWC62ewj
         JzZsUHUPFNAwml0cs84Bx0a0/GT8DHs7Tg7flSuTfXOorr6anTGh1aUQM/2kUhqCY0Qz
         DdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kOAELGx8k88bTnoKArCwZ1BN4DgVz6D5T6w5/jtP8Vw=;
        b=dMoFbYiqIpU960In4WCfPTmkDrU4biQUkSWT7KKmBsvNBIP11M6GONUFGMFQIcA0Xt
         rci0/+3MVHYPkwnv9Igt9v+lS1AmuEskZ0HK3LgT8na/lSvbLsq2hnywKYi3uzVMihdR
         JZWEIbJ2A6uLXRAU0mtliMJHIx0AgLNAZ9qTVXlI9t1xrra8wmY0Ne6TANzVaL1trn1f
         eVvYq487M1fzA3mdhtKh9Ejtv/MaipD5RUFAvBEDDYRWTAco8gyVwwlSlqYnA2QCpPPD
         5As0TVLR9BOQcSdjg24pX87V7qw+BW1PQVrssG/P4sPX8aWP/JMjF+W78fT63SDHWu9B
         txHA==
X-Gm-Message-State: AJcUukcOuABOQ+qa3RACH1+y08DP57pMPcKn4HkDIHTww0KgVeJUkFN3
        XttvZAUq41F6ZXr3ZKa1A/Dxdf/W
X-Google-Smtp-Source: ALg8bN7xx7h4YOw8b4MzjN5x/WuT2j2TiWFX4BFruBPVu9uuvxntj6X/FcHCpo5f78W0CFRFXgZw4Q==
X-Received: by 2002:a62:9fd9:: with SMTP id v86mr51079617pfk.191.1549291127629;
        Mon, 04 Feb 2019 06:38:47 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 24sm1619769pfl.32.2019.02.04.06.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 06:38:46 -0800 (PST)
Subject: Re: [RFC PATCH v5 10/10] watchdog: bd70528: Initial support for ROHM
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
References: <cover.1549283919.git.matti.vaittinen@fi.rohmeurope.com>
 <c03a470dac74047a72dc3ed8f51ab81f456594d1.1549283920.git.matti.vaittinen@fi.rohmeurope.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a76ec2b9-a95e-a17a-f231-c1d04ec8e846@roeck-us.net>
Date:   Mon, 4 Feb 2019 06:38:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c03a470dac74047a72dc3ed8f51ab81f456594d1.1549283920.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/19 4:49 AM, Matti Vaittinen wrote:
> Initial support for watchdog block included in ROHM BD70528
> power management IC.
> 
> Configurations for low power states are still to be checked.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>   drivers/watchdog/Kconfig       |  12 +++
>   drivers/watchdog/Makefile      |   1 +
>   drivers/watchdog/bd70528_wdt.c | 187 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 200 insertions(+)
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
> index 000000000000..c24d4cce5e9c
> --- /dev/null
> +++ b/drivers/watchdog/bd70528_wdt.c
> @@ -0,0 +1,187 @@
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

Please add an empty line here.

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
> +/* Max time we can set is 1 hour, 59 minutes and 59 seconds */
> +#define WDT_MAX_MS ((2 * 60 * 60 - 1) * 1000)
> +/* Minimum time is 1 second */
> +#define WDT_MIN_MS 1000
> +#define DEFAULT_TIMEOUT 60
> +

Please move to top, and tab-align the values.

Otherwise I am ok with the patch.

On a side note, isn't it past time to drop the RFC ?

Guenter

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

