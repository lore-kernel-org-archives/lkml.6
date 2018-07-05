Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6227EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0324D240BE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6hOLGsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0324D240BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbeGESs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:48:59 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38627 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753831AbeGESs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:48:56 -0400
Received: by mail-pf0-f194.google.com with SMTP id j17-v6so6193101pfn.5;
        Thu, 05 Jul 2018 11:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bm3crJPcQue0NhjNRdHZpUklT++jnkO3XGqU91/khqc=;
        b=e6hOLGsvInTGsurB/OI9AdTDhyhH5bhionk0jZOIX2BEaQppSWZ4kwl+z3yIA7DZ8o
         jb+zitB+U74G1Q4jc4xE9gw8kmkby9GfXQOKPECyXoJBx9WEVqllWjrQuQ2+gjE5hMzc
         dJi9k1VPKzMg9yJ77ar6kzs8/QIQPegv9C62m0cNlWBikTYDcfYlMKStVt/xvZWJU/Wl
         QEVw7ha1NVyqOhcgaeVnKbM81q7BfPj+KJJhCV9K81o7UqnLNkreo+HJ3O1SVIfJHtA+
         uYRaQGASSoMSndiSryeX9m6zXdBXKtA+9qFbjZ2YIRbtf6lGGaW+ef7qH6rTXeC+vAzg
         +w3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bm3crJPcQue0NhjNRdHZpUklT++jnkO3XGqU91/khqc=;
        b=GKhy7iQ6KHHJ9SqOTRGUJVcU+/qOwXfu2ScdLFXp5QPyJi0GcYPFdNlob6FxKUbAbw
         FfPN0RWOFxYA360Zfn6eJq2XYSIAS5BYZcxm9doGaXxzxjTA79s2ugEcrhYO/NIlJx+D
         XvY5xV/KS01NOxQDApVCi9yTnIJjLQs9UYPrU+nds6kdvb1XmSc+7ooNvuiKVJeLubmf
         XFgeOzORvWvqCbEkPbpMnRztrA6F9fxJGQCaPcyjXBqyBvUEwMVP5Ecf0IZjjs83CMuJ
         fuBOn3RN7w+MjgWRFSibTjaAwllqWH6ZJlJxT+anJ2e+uySKRTQ/kbGEy4Xwyi9RReqU
         Grmg==
X-Gm-Message-State: APt69E1kEn4iAGNxc3dMaorAnU7Gl6P33LEPLmFmdjXaS+jvtdO75eQj
        lPdcFdJnmNdEP+Thj0coy/8=
X-Google-Smtp-Source: AAOMgpc6fw9Di4pbKN88C2vjKKVQuQOYlSgNYPf1COMvBf/Mg9JMmNmEJEF7ru6pnpb6tG61Pq4QEg==
X-Received: by 2002:a62:cd3:: with SMTP id 80-v6mr407586pfm.184.1530816536182;
        Thu, 05 Jul 2018 11:48:56 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x28-v6sm7561555pfk.55.2018.07.05.11.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 11:48:55 -0700 (PDT)
Subject: Re: [PATCH 8/8] watchdog: stpmu1: add stpmu1 watchdog driver
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
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
References: <1530803657-17684-1-git-send-email-p.paillet@st.com>
 <1530803657-17684-9-git-send-email-p.paillet@st.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ade05366-ce30-f643-7111-f3d24378df63@roeck-us.net>
Date:   Thu, 5 Jul 2018 11:48:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530803657-17684-9-git-send-email-p.paillet@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2018 08:14 AM, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> The stpmu1 PMIC embeds a watchdog which is disabled by default. As soon
> as the watchdog is started, it must be refreshed periodically otherwise
> the PMIC goes off.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
>   drivers/watchdog/Kconfig      |  12 +++
>   drivers/watchdog/Makefile     |   1 +
>   drivers/watchdog/stpmu1_wdt.c | 177 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 190 insertions(+)
>   create mode 100644 drivers/watchdog/stpmu1_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9af07fd..2155f4d 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -796,6 +796,18 @@ config STM32_WATCHDOG
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called stm32_iwdg.
>   
> +config STPMU1_WATCHDOG
> +	tristate "STPMU1 PMIC watchdog support"
> +	depends on MFD_STPMU1
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include watchdog support embedded into STPMU1 PMIC.
> +	  If the watchdog timer expires, stpmu1 shut-down all its power
> +	  supplies.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called spmu1_wdt.
> +
>   config UNIPHIER_WATCHDOG
>   	tristate "UniPhier watchdog support"
>   	depends on ARCH_UNIPHIER || COMPILE_TEST
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 1d3c6b0..c9eba94 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -216,3 +216,4 @@ obj-$(CONFIG_ZIIRAVE_WATCHDOG) += ziirave_wdt.o
>   obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
>   obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
>   obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
> +obj-$(CONFIG_STPMU1_WATCHDOG) += stpmu1_wdt.o
> diff --git a/drivers/watchdog/stpmu1_wdt.c b/drivers/watchdog/stpmu1_wdt.c
> new file mode 100644
> index 0000000..57e0afa
> --- /dev/null
> +++ b/drivers/watchdog/stpmu1_wdt.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
> + * Author: Philippe Peurichard <philippe.peurichard@st.com>,
> + * Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/mfd/stpmu1.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/reboot.h>
> +#include <linux/slab.h>
> +#include <linux/watchdog.h>
> +
> +/* WATCHDOG CONTROL REGISTER bit */
> +#define WDT_START		BIT(0)
> +#define WDT_PING		BIT(1)
> +#define WDT_START_MASK		BIT(0)
> +#define WDT_PING_MASK		BIT(1)
> +
> +#define PMIC_WDT_MIN_TIMEOUT 1
> +#define PMIC_WDT_MAX_TIMEOUT 256
> +
> +struct stpmu1_wdt {
> +	struct stpmu1_dev *pmic;
> +	struct watchdog_device wdtdev;
> +	struct notifier_block restart_handler;
> +};
> +
> +static int pmic_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct stpmu1_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	return regmap_update_bits(wdt->pmic->regmap,
> +				  WCHDG_CR, WDT_START_MASK, WDT_START);
> +}
> +
> +static int pmic_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct stpmu1_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	return regmap_update_bits(wdt->pmic->regmap,
> +				  WCHDG_CR, WDT_START_MASK, ~WDT_START);
> +}
> +
> +static int pmic_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct stpmu1_wdt *wdt = watchdog_get_drvdata(wdd);
> +	int ret;
> +
> +	return regmap_update_bits(wdt->pmic->regmap,
> +				  WCHDG_CR, WDT_PING_MASK, WDT_PING);
> +	return ret;
> +}
> +
> +static int pmic_wdt_set_timeout(struct watchdog_device *wdd,
> +				unsigned int timeout)
> +{
> +	struct stpmu1_wdt *wdt = watchdog_get_drvdata(wdd);
> +	int ret;
> +
> +	ret = regmap_write(wdt->pmic->regmap, WCHDG_TIMER_CR, timeout);
> +	if (ret)
> +		dev_err(wdt->pmic->dev,
> +			"Failed to set watchdog timeout (err = %d)\n", ret);
> +	else
> +		wdd->timeout = PMIC_WDT_MAX_TIMEOUT;

First the requested timeout is set, then the caller is notified
that the timeout was set to the maximum possible value ? That doesn't
make sense. If that is really intentional, I would expect a detailed
explanation, and I would expect that the value written into the chip
register matches the value reported back to the user.

> +
> +	return ret;
> +}
> +
> +static int pmic_wdt_restart_handler(struct notifier_block *this,
> +				    unsigned long mode, void *cmd)
> +{
> +	struct stpmu1_wdt *wdt = container_of(this,
> +						   struct stpmu1_wdt,
> +						   restart_handler);
> +
> +	dev_info(wdt->pmic->dev,
> +		 "PMIC Watchdog Elapsed (timeout %d), shutdown of PMIC initiated\n",
> +		 wdt->wdtdev.timeout);
> +

Register a restart handler just to issue a message ? That is quite pointless.
A restart handler is supposed to restart the system. Besides, the message
is highly misleading; there is no reason to believe that it will be called
after the watchdog expired.

This function should restart the system. If it doesn't, drop it.

> +	return NOTIFY_DONE;
> +}
> +
> +static const struct watchdog_info pmic_watchdog_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +	.identity = "STPMU1 PMIC Watchdog",
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
> +	struct stpmu1_dev *pmic;
> +	struct stpmu1_wdt *wdt;
> +
> +	if (!pdev->dev.parent)
> +		return -EINVAL;
> +
> +	pmic = dev_get_drvdata(pdev->dev.parent);
> +	if (!pmic)
> +		return -EINVAL;
> +
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(struct stpmu1_wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	wdt->pmic = pmic;
> +
> +	wdt->wdtdev.info = &pmic_watchdog_info;
> +	wdt->wdtdev.ops = &pmic_watchdog_ops;
> +	wdt->wdtdev.min_timeout = PMIC_WDT_MIN_TIMEOUT;
> +	wdt->wdtdev.max_timeout = PMIC_WDT_MAX_TIMEOUT;
> +	wdt->wdtdev.timeout = PMIC_WDT_MAX_TIMEOUT;

256 seconds default timeout ? Unusual, just making sure that this is what you want.

> +
> +	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
> +
> +	watchdog_set_drvdata(&wdt->wdtdev, wdt);
> +	dev_set_drvdata(&pdev->dev, wdt);
> +
> +	ret = watchdog_register_device(&wdt->wdtdev);
> +	if (ret)
> +		return ret;
> +
> +	wdt->restart_handler.notifier_call = pmic_wdt_restart_handler;
> +	wdt->restart_handler.priority = 128;
> +	ret = register_restart_handler(&wdt->restart_handler);

Why is the restart handler provided by the watchdog core not sufficient ?


> +	if (ret) {
> +		dev_err(wdt->pmic->dev, "failed to register restart handler\n");
> +		return ret;
> +	}
> +
> +	dev_dbg(wdt->pmic->dev, "PMIC Watchdog driver probed\n");

The only reasons not to use the devm_ function to register the watchdog
are the restart handler, which 1) doesn't do anything and 2) should use
the watchdog core, and this debug message. I would suggest to use the
devm_ function to register the watchdog instead.

> +	return 0;
> +}
> +
> +static int pmic_wdt_remove(struct platform_device *pdev)
> +{
> +	struct stpmu1_wdt *wdt = dev_get_drvdata(&pdev->dev);
> +
> +	unregister_restart_handler(&wdt->restart_handler);
> +	watchdog_unregister_device(&wdt->wdtdev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_pmic_wdt_match[] = {
> +	{ .compatible = "st,stpmu1-wdt" },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, of_pmic_wdt_match);
> +
> +static struct platform_driver stpmu1_wdt_driver = {
> +	.probe = pmic_wdt_probe,
> +	.remove = pmic_wdt_remove,
> +	.driver = {
> +		.name = "stpmu1-wdt",
> +		.of_match_table = of_pmic_wdt_match,
> +	},
> +};
> +module_platform_driver(stpmu1_wdt_driver);
> +
> +MODULE_AUTHOR("philippe.peurichard@st.com>");
> +MODULE_DESCRIPTION("Watchdog driver for STPMU1 device");
> +MODULE_LICENSE("GPL");
> 

