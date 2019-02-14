Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A15C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0A42229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgs9uJwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407309AbfBNOuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:50:40 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36347 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732706AbfBNOui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:50:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id n22so3222465pfa.3;
        Thu, 14 Feb 2019 06:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/6ddbdebD9iJzQo+1LigKy7GKDZ/EL0wAh/uqRy48F4=;
        b=cgs9uJwd7aQilHTRs0BfGQBJgYPxJ8uesBz2JQKSfzQgq6KmLl3yAhClFLIztuYuOO
         zpLdfeEIUGjc61mTwUZD76zq0nu03uw2oMnH3TdzI6m0TRVJQOVMMEjfVH9B3Oe6ae24
         7gOvVvRbWc2yLYS/D4SqMGUmwXKm35GzHanlh7JeGVhBcLWjVH/UHr5ALl8Jz2Q/6aU6
         ozzz6S4/Wx6Q0GukfYw2VlSMq4zN9/g8xcIkJN9NvIvSSD1sUjvIy7XuiF6JNMYYfs5i
         ssxAWonQtPeC+Sd5MVKrjArmna/6ch+lirdWCNlvG5o8JN/9oB0fNxJscIv/RxHW6mQk
         aCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/6ddbdebD9iJzQo+1LigKy7GKDZ/EL0wAh/uqRy48F4=;
        b=A7yDVMYoAl/zsPsRWvCpXsK/g+6uiK/4YprmNt4oCljpC4z97AmCuvw0RXiwX5ZFHo
         M6AwLxGLeF3bo43bn6dxcXziIHWTone4YCG9uirJOmlDbNs9+zTKP1DTvkDhLbEBTirT
         1J+z9hDCF00vwtMsG0jg7t9mZysivb65K3I8p4+tcLv2T3ZCdzBqVS6wqPL+3UbE+Sqf
         bZ2j+wKQ1HsOOZ7jpzZJLAMiSIPS13fvwoH1of/5V4kwdbC31kVUaGkaaDKahZzuZfHA
         r6pfPBL4DgcKi9HQSCBx1Yyg3ZMnGmHoVPxm2Teaq33GNq0Y3ctaJZgdW+ITBZwpFWmS
         qGvQ==
X-Gm-Message-State: AHQUAubsm3GKa0WM9uBlh58H70/quqddim7cE5euxMC2qaUT1Hl1XRfw
        rEtoq9Nm7cfwqssvG+SDn60=
X-Google-Smtp-Source: AHgI3IYUdduaKqJn681bDKNTZvqHHzr5vcqo0r1q6dCTqk3ZkG27QoyGfnu71hOZ61Fhhyi2NDhP9Q==
X-Received: by 2002:a62:b248:: with SMTP id x69mr4429731pfe.256.1550155837389;
        Thu, 14 Feb 2019 06:50:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 11sm3236506pfh.131.2019.02.14.06.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:50:36 -0800 (PST)
Subject: Re: [PATCH 2/4] watchdog: imx_sc: Add i.MX system controller watchdog
 support
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1550144346-1187-1-git-send-email-Anson.Huang@nxp.com>
 <1550144346-1187-3-git-send-email-Anson.Huang@nxp.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <60e68ebe-389a-b410-d0b3-ad9a286b1a50@roeck-us.net>
Date:   Thu, 14 Feb 2019 06:50:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550144346-1187-3-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 3:44 AM, Anson Huang wrote:
> i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
> inside, the system controller is in charge of controlling power,
> clock and watchdog etc..
> 
> This patch adds i.MX system controller watchdog driver support,
> watchdog operation needs to be done in secure EL3 mode via
> ARM-Trusted-Firmware, using SMC call, CPU will trap into
> ARM-Trusted-Firmware and then it will request system controller
> to do watchdog operation via IPC.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>   drivers/watchdog/Kconfig      |  13 +++
>   drivers/watchdog/Makefile     |   1 +
>   drivers/watchdog/imx_sc_wdt.c | 210 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 224 insertions(+)
>   create mode 100644 drivers/watchdog/imx_sc_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 65c3c42..5c5b8ba 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -625,6 +625,19 @@ config IMX2_WDT
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called imx2_wdt.
>   
> +config IMX_SC_WDT
> +	tristate "IMX SC Watchdog"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	select WATCHDOG_CORE
> +	help
> +	  This is the driver for the system controller watchdog
> +	  on the NXP i.MX SoCs with system controller inside.
> +	  If you have one of these processors and wish to have
> +	  watchdog support enabled, say Y, otherwise say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called imx_sc_wdt.
> +
>   config UX500_WATCHDOG
>   	tristate "ST-Ericsson Ux500 watchdog"
>   	depends on MFD_DB8500_PRCMU
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 4e78a8c..0c9da63 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
>   obj-$(CONFIG_TS4800_WATCHDOG) += ts4800_wdt.o
>   obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
>   obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
> +obj-$(CONFIG_IMX_SC_WDT) += imx_sc_wdt.o
>   obj-$(CONFIG_UX500_WATCHDOG) += ux500_wdt.o
>   obj-$(CONFIG_RETU_WATCHDOG) += retu_wdt.o
>   obj-$(CONFIG_BCM2835_WDT) += bcm2835_wdt.o
> diff --git a/drivers/watchdog/imx_sc_wdt.c b/drivers/watchdog/imx_sc_wdt.c
> new file mode 100644
> index 0000000..ae52e34
> --- /dev/null
> +++ b/drivers/watchdog/imx_sc_wdt.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2018-2019 NXP.
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/watchdog.h>
> +
> +#define DEFAULT_TIMEOUT 60
> +/*
> + * Software timer tick implemented in scfw side, support 10ms to 0xffffffff ms
> + * in theory, but for normal case, 1s~128s is enough, you can change this max
> + * value in case it's not enough.
> + */
> +#define MAX_TIMEOUT 128
> +
> +#define IMX_SIP_TIMER			0xC2000002
> +#define IMX_SIP_TIMER_START_WDOG		0x01
> +#define IMX_SIP_TIMER_STOP_WDOG		0x02
> +#define IMX_SIP_TIMER_SET_WDOG_ACT	0x03
> +#define IMX_SIP_TIMER_PING_WDOG		0x04
> +#define IMX_SIP_TIMER_SET_TIMEOUT_WDOG	0x05
> +#define IMX_SIP_TIMER_GET_WDOG_STAT	0x06
> +#define IMX_SIP_TIMER_SET_PRETIME_WDOG	0x07
> +
> +#define SC_TIMER_WDOG_ACTION_PARTITION	0
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0000);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static unsigned int timeout = DEFAULT_TIMEOUT;
> +module_param(timeout, uint, 0000);
> +MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
> +		 __MODULE_STRING(DEFAULT_TIMEOUT) ")");
> +
> +static struct watchdog_device imx_sc_wdd;
> +
> +static int imx_sc_wdt_ping(struct watchdog_device *wdog)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_PING_WDOG,
> +		      0, 0, 0, 0, 0, 0, &res);
> +
> +	return res.a0;
> +}
> +
> +static int imx_sc_wdt_start(struct watchdog_device *wdog)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_START_WDOG,
> +		      0, 0, 0, 0, 0, 0, &res);
> +	if (res.a0)
> +		return res.a0;
> +
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_SET_WDOG_ACT,
> +		      SC_TIMER_WDOG_ACTION_PARTITION,
> +		      0, 0, 0, 0, 0, &res);
> +
> +	return res.a0;
> +}
> +
> +static int imx_sc_wdt_stop(struct watchdog_device *wdog)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_STOP_WDOG,
> +		      0, 0, 0, 0, 0, 0, &res);
> +
> +	return res.a0;
> +}
> +
> +static int imx_sc_wdt_set_timeout(struct watchdog_device *wdog,
> +				unsigned int timeout)
> +{
> +	struct arm_smccc_res res;
> +
> +	wdog->timeout = timeout;
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_SET_TIMEOUT_WDOG,
> +		      timeout * 1000, 0, 0, 0, 0, 0, &res);
> +
> +	return res.a0;
> +}
> +
> +static const struct watchdog_ops imx_sc_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = imx_sc_wdt_start,
> +	.stop  = imx_sc_wdt_stop,
> +	.ping  = imx_sc_wdt_ping,
> +	.set_timeout = imx_sc_wdt_set_timeout,
> +};
> +
> +static const struct watchdog_info imx_sc_wdt_info = {
> +	.identity	= "i.MX SC watchdog timer",
> +	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
> +			  WDIOF_MAGICCLOSE | WDIOF_PRETIMEOUT,
> +};
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int imx_sc_wdt_suspend(struct device *dev)
> +{
> +	if (test_bit(WDOG_ACTIVE, &imx_sc_wdd.status))
> +		imx_sc_wdt_stop(&imx_sc_wdd);
> +

What is wrong with watchdog_active() ? It is used below ?

> +	return 0;
> +}
> +
> +static int imx_sc_wdt_resume(struct device *dev)
> +{
> +	if (test_bit(WDOG_ACTIVE, &imx_sc_wdd.status))
> +		imx_sc_wdt_start(&imx_sc_wdd);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops imx_sc_wdt_pm_ops = {
> +	.suspend = imx_sc_wdt_suspend,
> +	.resume = imx_sc_wdt_resume,
> +};
> +
> +#define IMX_SC_WDT_PM_OPS	(&imx_sc_wdt_pm_ops)
> +
> +#else
> +
> +#define IMX_SC_WDT_PM_OPS	NULL
> +
> +#endif
> +
> +static int imx_sc_wdt_probe(struct platform_device *pdev)
> +{
> +	struct watchdog_device *wdt = &imx_sc_wdd;

Please use devm_kzalloc() and drop the static variable. You can use
dev_get_drvdata() to access it where needed.

> +	int err;
> +
> +	platform_set_drvdata(pdev, wdt);
> +
> +	wdt->info = &imx_sc_wdt_info;
> +	wdt->ops = &imx_sc_wdt_ops;
> +	wdt->min_timeout = 1;
> +	wdt->max_timeout = MAX_TIMEOUT;
> +	wdt->parent = &pdev->dev;
> +	watchdog_set_drvdata(wdt, NULL);
> +
This is quite pointless.

> +	err = watchdog_init_timeout(wdt, DEFAULT_TIMEOUT, &pdev->dev);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to init the wdog timeout:%d\n",
> +			err);
> +		return err;
> +	}
> +
> +	err = watchdog_register_device(wdt);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to register watchdog device\n");
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx_sc_wdt_remove(struct platform_device *pdev)
> +{
> +	struct watchdog_device *wdt = platform_get_drvdata(pdev);
> +
> +	imx_sc_wdt_stop(wdt);

Any reason for not using watchdog_stop_on_unregister() ?

> +
> +	watchdog_unregister_device(wdt);
> +
> +	return 0;
> +}
> +
> +static void imx_sc_wdt_shutdown(struct platform_device *pdev)
> +{
> +	struct watchdog_device *wdt = platform_get_drvdata(pdev);
> +
> +	if (watchdog_active(wdt))
> +		imx_sc_wdt_stop(wdt);
> +}
> +
Any reason for not using watchdog_stop_on_reboot() ?

> +static const struct of_device_id imx_sc_wdt_dt_ids[] = {
> +	{ .compatible = "fsl,imx8qxp-sc-wdt", },
> +	{ /*sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_sc_wdt_dt_ids);
> +
> +static struct platform_driver imx_sc_wdt_driver = {
> +	.probe		= imx_sc_wdt_probe,
> +	.remove		= imx_sc_wdt_remove,
> +	.shutdown	= imx_sc_wdt_shutdown,
> +	.driver		= {
> +		.name	= "imx-sc-wdt",
> +		.of_match_table = imx_sc_wdt_dt_ids,
> +		.pm	= IMX_SC_WDT_PM_OPS,

I prefer the use of SIMPLE_DEV_PM_OPS() together with
__maybe_unused for the pm functions instead of #ifdef.
This ensures that the unused code compiles even if PM_SLEEP
is not enabled.

Thanks,
Guenter
