Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11CCC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDB22098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1m2/sUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDB22098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeJRVfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:35:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33687 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeJRVfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:35:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id s4-v6so14358892plp.0;
        Thu, 18 Oct 2018 06:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MNnuNx3WL9MEssSOXPjH3PpK0mcXqwdRj+bua6hh/lU=;
        b=f1m2/sUxrM+5BLEKm/Jdvz7w6gc3DkZxrfgkglOWjN0beIem45Cu9aaguYq8JyQjVE
         WkrU8Llp4rQfbYutxY2cYzERuD89xCi6fbSKX9yaWaOFL+3no0MohiqbQaDIqofYAkOF
         ZUAhIlRUxCj+AF8s2jjEcy46X7x8nyF/Oj9GyZB6ndABd36W9b3iLs/LIICCpZ7bFMIV
         lKbcUQBUcsiAdFHPbi0y9Xs8OGZ+Y4w/rTo998bwT5IDfxSy/jS6i89g7P5js/BUVw21
         dGUYRdG7xuvKELNWu08rrg59WbjacR4wZqPwm+TbBZfF8JU0NTMFJBQMFJCr7spaicAk
         srMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MNnuNx3WL9MEssSOXPjH3PpK0mcXqwdRj+bua6hh/lU=;
        b=MDTDRU1Q8frLtmiGPiVvuO+FdAbBDgR1QPmVuNkZT7QvtE20GArzR0jzwUDy+7Hf84
         QAt6dAy8Uorlz+WFO+dKPVDuVh4kk0IF3Xu+vb9O0Jh9UREylcZNCvZU3i6lAyH3GZw5
         LOLGH956x8WdVB8IWZWJOJpjAoI8evuR6LJJOTbfRLc1RR1gtUBwGKMGiPkl895ckINe
         XifIOK2drgvjSHytGYj7PCpVlAoexjEBtl1Z5K1E0DVrXOgbOUJBI3GPF67et1vvdJyr
         3o7CMJeLR61bn6qdO4peZCl3fh3U+nOqhFuCXh8ykUg01+ByPPI7n9odvkzW4IhvlAsn
         QwZA==
X-Gm-Message-State: ABuFfojht3gCHdnrO7PNPMTufTRFL8vEO3X5dyh1vz8lGXH+RLVo2uRC
        7zWC6v4CdoTZh9lICKK7NQw=
X-Google-Smtp-Source: ACcGV60eHrAjowXQSFupA5cyxqq3/2M2cGkan9Doe7MNV+zJuGYUErAgEffECCfPZ+z2DDsbzwDwbg==
X-Received: by 2002:a17:902:9002:: with SMTP id a2-v6mr6800234plp.291.1539869688872;
        Thu, 18 Oct 2018 06:34:48 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 5-v6sm27370393pgt.83.2018.10.18.06.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 06:34:47 -0700 (PDT)
Subject: Re: [PATCH v4 8/8] watchdog: stpmic1: add stpmic1 watchdog driver
To:     Pascal PAILLET-LME <p.paillet@st.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-9-git-send-email-p.paillet@st.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <be9eb164-6ada-25c8-6f75-e3d8667728e1@roeck-us.net>
Date:   Thu, 18 Oct 2018 06:34:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539853324-29051-9-git-send-email-p.paillet@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/2018 02:02 AM, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> The stpmic1 PMIC embeds a watchdog which is disabled by default. As soon
> as the watchdog is started, it must be refreshed periodically otherwise
> the PMIC goes off.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
> changes in v4:
> * fix stop watchdog function
> * Kconfig: fix grammar issue
> 
>   drivers/watchdog/Kconfig       |  12 ++++
>   drivers/watchdog/Makefile      |   1 +
>   drivers/watchdog/stpmic1_wdt.c | 139 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 152 insertions(+)
>   create mode 100644 drivers/watchdog/stpmic1_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 5ea8909..6d2ffef 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -806,6 +806,18 @@ config STM32_WATCHDOG
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called stm32_iwdg.
>   
> +config STPMIC1_WATCHDOG
> +	tristate "STPMIC1 PMIC watchdog support"
> +	depends on MFD_STPMIC1
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include watchdog support embedded into STPMIC1 PMIC.
> +	  If the watchdog timer expires, stpmic1 will shut down all its power
> +	  supplies.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called spmic1_wdt.
> +
>   config UNIPHIER_WATCHDOG
>   	tristate "UniPhier watchdog support"
>   	depends on ARCH_UNIPHIER || COMPILE_TEST
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index bf92e7b..2649cf3 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -217,3 +217,4 @@ obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
>   obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
>   obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
>   obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
> +obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
> diff --git a/drivers/watchdog/stpmic1_wdt.c b/drivers/watchdog/stpmic1_wdt.c
> new file mode 100644
> index 0000000..a6cbc27
> --- /dev/null
> +++ b/drivers/watchdog/stpmic1_wdt.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) STMicroelectronics 2018
> +// Author: Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
> +
> +#include <linux/kernel.h>
> +#include <linux/mfd/stpmic1.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/watchdog.h>
> +
> +/* WATCHDOG CONTROL REGISTER bit */
> +#define WDT_START		BIT(0)
> +#define WDT_PING		BIT(1)
> +#define WDT_START_MASK		BIT(0)
> +#define WDT_PING_MASK		BIT(1)
> +#define WDT_STOP		0
> +
> +#define PMIC_WDT_MIN_TIMEOUT 1
> +#define PMIC_WDT_MAX_TIMEOUT 256
> +#define PMIC_WDT_DEFAULT_TIMEOUT 30
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout,
> +		"Watchdog cannot be stopped once started (default="
> +				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +struct stpmic1_wdt {
> +	struct stpmic1 *pmic;
> +	struct watchdog_device wdtdev;
> +};
> +
> +static int pmic_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct stpmic1_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	return regmap_update_bits(wdt->pmic->regmap,
> +				  WCHDG_CR, WDT_START_MASK, WDT_START);
> +}
> +
> +static int pmic_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct stpmic1_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	return regmap_update_bits(wdt->pmic->regmap,
> +				  WCHDG_CR, WDT_START_MASK, WDT_STOP);
> +}
> +
> +static int pmic_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct stpmic1_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	return regmap_update_bits(wdt->pmic->regmap,
> +				  WCHDG_CR, WDT_PING_MASK, WDT_PING);
> +}
> +
> +static int pmic_wdt_set_timeout(struct watchdog_device *wdd,
> +				unsigned int timeout)
> +{
> +	struct stpmic1_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	wdd->timeout = timeout;
> +	/* timeout is equal to register value + 1 */
> +	return regmap_write(wdt->pmic->regmap, WCHDG_TIMER_CR, timeout - 1);
> +}
> +
> +static const struct watchdog_info pmic_watchdog_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +	.identity = "STPMIC1 PMIC Watchdog",
> +};
> +
> +static const struct watchdog_ops pmic_watchdog_ops = {
> +	.owner = THIS_MODULE,
> +	.start = pmic_wdt_start,
> +	.stop = pmic_wdt_stop,
> +	.ping = pmic_wdt_ping,
> +	.set_timeout = pmic_wdt_set_timeout,
> +};
> +
> +static int pmic_wdt_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct stpmic1 *pmic;
> +	struct stpmic1_wdt *wdt;
> +
> +	if (!pdev->dev.parent)
> +		return -EINVAL;
> +
> +	pmic = dev_get_drvdata(pdev->dev.parent);
> +	if (!pmic)
> +		return -EINVAL;
> +
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(struct stpmic1_wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	wdt->pmic = pmic;
> +
> +	wdt->wdtdev.info = &pmic_watchdog_info;
> +	wdt->wdtdev.ops = &pmic_watchdog_ops;
> +	wdt->wdtdev.min_timeout = PMIC_WDT_MIN_TIMEOUT;
> +	wdt->wdtdev.max_timeout = PMIC_WDT_MAX_TIMEOUT;

Sorry I missed that earlier: You'll also want to set wdtdev.parent.

Thanks,
Guenter

> +
> +	wdt->wdtdev.timeout = PMIC_WDT_DEFAULT_TIMEOUT;
> +	watchdog_init_timeout(&wdt->wdtdev, 0, &pdev->dev);
> +
> +	watchdog_set_nowayout(&wdt->wdtdev, nowayout);
> +	watchdog_set_drvdata(&wdt->wdtdev, wdt);
> +
> +	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdtdev);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(wdt->pmic->dev, "PMIC Watchdog driver probed\n");
> +	return 0;
> +}
> +
> +static const struct of_device_id of_pmic_wdt_match[] = {
> +	{ .compatible = "st,stpmic1-wdt" },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, of_pmic_wdt_match);
> +
> +static struct platform_driver stpmic1_wdt_driver = {
> +	.probe = pmic_wdt_probe,
> +	.driver = {
> +		.name = "stpmic1-wdt",
> +		.of_match_table = of_pmic_wdt_match,
> +	},
> +};
> +module_platform_driver(stpmic1_wdt_driver);
> +
> +MODULE_DESCRIPTION("Watchdog driver for STPMIC1 device");
> +MODULE_AUTHOR("Pascal Paillet <p.paillet@st.com>");
> +MODULE_LICENSE("GPL v2");
> 

