Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9E0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180602086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlMFTtOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180602086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbeGQOGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:06:46 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38436 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731324AbeGQOGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:06:45 -0400
Received: by mail-pf0-f195.google.com with SMTP id v15-v6so520409pff.5;
        Tue, 17 Jul 2018 06:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S3i9NYoqd19PcOZqpT5wMvWnbv+PIyLIf1B3xO8x5qo=;
        b=PlMFTtOXAp7iBf+aaBVDVCSsYD6F5P93SArQCaAYLiM3sxBzktuTjDwfpaoTs71xTr
         9Y2yy89O85ZlyPMaEVc+afSV6u02oHnWZG1LPy5DNwMymVfLHaM5mnhVfdWc7PEJSGx+
         YzoEankq0W89Gs1GmDCPrNawCr7iFvYUYvxbu8O1wBb1/cgfJvbiJLTR43bclJP1N+vU
         U9qGOSIE7PRbMtEdc5Qj3Ty1wioYLBqMNmZXJLZnTq6Jt/rP91XbaN5f9lgPQQV0jgli
         ZqbP2bNVwi6GJoVOdsPtn63gqkeYzR+FJrCN418S33mdDwyQNG1H0aoeTN16kJazvWe8
         Kg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S3i9NYoqd19PcOZqpT5wMvWnbv+PIyLIf1B3xO8x5qo=;
        b=CDwjp6UCKTZmlNibHMDToeraU6kPeR4c23oJ18FFXxnj58AIsXXQpQkmuvaWTXcRnA
         YCimnjlO4aGre6/vxdaufw5JxLng2ND/D6uUpBjTq5SGHS1nmp3S+W7fnLsNFf2xK7s6
         t4Fl0C1bcHJreEC7BdVKdgRDDwm0AMg93UJhe5eo/BWHrqF3xQiawM72GO8CV8LELncX
         +o70MIqoLmdOlfFDsvHDfI72zO6IMY6ViFpOBVHValP0iYTVhGEBpCEZe83hojFDLF17
         HomEsMzkcmFvMCdmFb5nr8tjPDfa33xCOjoLyxTv0NX9Do/+xsRcRMQ+awt1ld9n2OW7
         iNaQ==
X-Gm-Message-State: AOUpUlFvm088C+r8zCSSiRvcyKsgrT1HkTtSUMpIMvOgSSS5+BRx1/Sg
        Cav6a9RNpDqCf7Ry2y9+UswHEw==
X-Google-Smtp-Source: AAOMgpfr5dhG1LP8pQkgGRbdUFOe4JBWeKP4V2QxF5pV+9+M18KU6PTpgcJmPuO796di2vdiJA1/YA==
X-Received: by 2002:a63:f18:: with SMTP id e24-v6mr1657263pgl.320.1531834443093;
        Tue, 17 Jul 2018 06:34:03 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id b76-v6sm3691934pfj.184.2018.07.17.06.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 06:34:01 -0700 (PDT)
Subject: Re: [PATCH v2] watchdog: add driver for the MEN 16z069 IP-Core
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        mmoese@suse.de
References: <20180716072510.6939-1-jthumshirn@suse.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <004b89c5-05f0-73ed-b707-bc1c1cb9bfec@roeck-us.net>
Date:   Tue, 17 Jul 2018 06:33:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180716072510.6939-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16/2018 12:25 AM, Johannes Thumshirn wrote:
> Add a driver for the MEN 16z069 Watchdog and Reset Controller IP-Core.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> Changes to v1:
> * Sorted includes alphabetically
> * Indented defines with tabs
> * Removed unnecessary timeout validation
> * Removed unnecessary masking of values
> * Fixed error return in .probe
> * Directly accessed drv->wdt
> * Removed leftover timeout resetting
> ---
>   MAINTAINERS                   |   6 ++
>   drivers/watchdog/Kconfig      |  10 +++
>   drivers/watchdog/Makefile     |   1 +
>   drivers/watchdog/menz69_wdt.c | 170 ++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 187 insertions(+)
>   create mode 100644 drivers/watchdog/menz69_wdt.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 07d1576fc766..67a76f740294 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9298,6 +9298,12 @@ F:	drivers/leds/leds-menf21bmc.c
>   F:	drivers/hwmon/menf21bmc_hwmon.c
>   F:	Documentation/hwmon/menf21bmc
>   
> +MEN Z069 WATCHDOG DRIVER
> +M:	Johannes Thumshirn <jth@kernel.org>
> +L:	linux-watchdog@vger.kernel.org
> +S:	Maintained
> +F:	drivers/watchdog/menz069_wdt.c
> +
>   MESON AO CEC DRIVER FOR AMLOGIC SOCS
>   M:	Neil Armstrong <narmstrong@baylibre.com>
>   L:	linux-media@lists.freedesktop.org
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9af07fd92763..df55d65bbb1c 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -161,6 +161,16 @@ config MENF21BMC_WATCHDOG
>   	  This driver can also be built as a module. If so the module
>   	  will be called menf21bmc_wdt.
>   
> +config MENZ069_WATCHDOG
> +	tristate "MEN 16Z069 Watchdog"
> +	depends on MCB || COMPILE_TEST
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support for the MEN 16Z069 Watchdog.
> +
> +	  This driver can also be built as a module. If so the module
> +	  will be called menz069_wdt.
> +
>   config TANGOX_WATCHDOG
>   	tristate "Sigma Designs SMP86xx/SMP87xx watchdog"
>   	select WATCHDOG_CORE
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 1d3c6b094fe5..bf92e7bf9ce0 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -215,4 +215,5 @@ obj-$(CONFIG_MAX77620_WATCHDOG) += max77620_wdt.o
>   obj-$(CONFIG_ZIIRAVE_WATCHDOG) += ziirave_wdt.o
>   obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
>   obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
> +obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
>   obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
> diff --git a/drivers/watchdog/menz69_wdt.c b/drivers/watchdog/menz69_wdt.c
> new file mode 100644
> index 000000000000..ed18238c5407
> --- /dev/null
> +++ b/drivers/watchdog/menz69_wdt.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Watchdog driver for the MEN z069 IP-Core
> + *
> + * Copyright (C) 2018 Johannes Thumshirn <jth@kernel.org>
> + */
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mcb.h>
> +#include <linux/module.h>
> +#include <linux/watchdog.h>
> +
> +struct men_z069_drv {
> +	struct watchdog_device wdt;
> +	void __iomem *base;
> +	struct resource *mem;
> +};
> +
> +#define MEN_Z069_WTR			0x10
> +#define MEN_Z069_WTR_WDEN		BIT(15)
> +#define MEN_Z069_WTR_WDET_MASK		0x7fff
> +#define MEN_Z069_WVR			0x14
> +
> +#define MEN_Z069_TIMER_FREQ		500 /* 500 Hz */
> +#define MEN_Z069_WDT_COUNTER_MIN	1
> +#define MEN_Z069_WDT_COUNTER_MAX	0x7fff
> +#define MEN_Z069_DEFAULT_TIMEOUT	30
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +			    __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static int men_z069_wdt_start(struct watchdog_device *wdt)
> +{
> +	struct men_z069_drv *drv = watchdog_get_drvdata(wdt);
> +	u16 val;
> +
> +	val = readw(drv->base + MEN_Z069_WTR);
> +	val |= MEN_Z069_WTR_WDEN;
> +	writew(val, drv->base + MEN_Z069_WTR);
> +
> +	return 0;
> +}
> +
> +static int men_z069_wdt_stop(struct watchdog_device *wdt)
> +{
> +	struct men_z069_drv *drv = watchdog_get_drvdata(wdt);
> +	u16 val;
> +
> +	val = readw(drv->base + MEN_Z069_WTR);
> +	val &= ~MEN_Z069_WTR_WDEN;
> +	writew(val, drv->base + MEN_Z069_WTR);
> +
> +	return 0;
> +}
> +
> +static int men_z069_wdt_ping(struct watchdog_device *wdt)
> +{
> +	struct men_z069_drv *drv = watchdog_get_drvdata(wdt);
> +	u16 val;
> +
> +	/* The watchdog trigger value toggles between 0x5555 and 0xaaaa */
> +	val = readw(drv->base + MEN_Z069_WVR);
> +	val ^= 0xffff;
> +	writew(val, drv->base + MEN_Z069_WVR);
> +
> +	return 0;
> +}
> +
> +static int men_z069_wdt_set_timeout(struct watchdog_device *wdt,
> +				    unsigned int timeout)
> +{
> +	struct men_z069_drv *drv = watchdog_get_drvdata(wdt);
> +	u16 reg, val, ena;
> +
> +	wdt->timeout = timeout;
> +	val = timeout * MEN_Z069_TIMER_FREQ;
> +
> +	reg = readw(drv->base + MEN_Z069_WVR);
> +	ena = reg & MEN_Z069_WTR_WDEN;
> +	reg = ena | val;
> +	writew(reg, drv->base + MEN_Z069_WTR);
> +
> +	return 0;
> +}
> +
> +static const struct watchdog_info men_z069_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +	.identity = "MEN z069 Watchdog",
> +};
> +
> +static const struct watchdog_ops men_z069_ops = {
> +	.owner = THIS_MODULE,
> +	.start = men_z069_wdt_start,
> +	.stop = men_z069_wdt_stop,
> +	.ping = men_z069_wdt_ping,
> +	.set_timeout = men_z069_wdt_set_timeout,
> +};
> +
> +static struct watchdog_device men_z069_wdt = {
> +	.info = &men_z069_info,
> +	.ops = &men_z069_ops,
> +	.timeout = MEN_Z069_DEFAULT_TIMEOUT,
> +	.min_timeout = 1,
> +	.max_timeout = MEN_Z069_WDT_COUNTER_MAX / MEN_Z069_TIMER_FREQ,
> +};
> +
> +static int men_z069_probe(struct mcb_device *dev,
> +			  const struct mcb_device_id *id)
> +{
> +	struct men_z069_drv *drv;
> +	struct resource *mem;
> +
> +	drv = devm_kzalloc(&dev->dev, sizeof(struct men_z069_drv), GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +
> +	mem = mcb_request_mem(dev, "z069-wdt");
> +	if (IS_ERR(mem))
> +		return PTR_ERR(mem);
> +
> +	drv->base = devm_ioremap(&dev->dev, mem->start, resource_size(mem));
> +	if (drv->base == NULL)
> +		goto release_mem;
> +
> +	drv->mem = mem;
> +
> +	drv->wdt = men_z069_wdt;
> +	watchdog_init_timeout(&drv->wdt, 0, &dev->dev);
> +	watchdog_set_nowayout(&drv->wdt, nowayout);
> +	watchdog_set_drvdata(&drv->wdt, drv);
> +	drv->wdt.parent = &dev->dev;
> +	mcb_set_drvdata(dev, drv);
> +
> +	return watchdog_register_device(&men_z069_wdt);
> +
> +release_mem:
> +	mcb_release_mem(mem);
> +	return -ENOMEM;
> +}
> +
> +static void men_z069_remove(struct mcb_device *dev)
> +{
> +	struct men_z069_drv *drv = mcb_get_drvdata(dev);
> +
> +	watchdog_unregister_device(&drv->wdt);
> +	mcb_release_mem(drv->mem);
> +}
> +
> +static const struct mcb_device_id men_z069_ids[] = {
> +	{ .device = 0x45 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(mcb, men_z069_ids);
> +
> +static struct mcb_driver men_z069_driver = {
> +	.driver = {
> +		.name = "z069-wdt",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = men_z069_probe,
> +	.remove = men_z069_remove,
> +	.id_table = men_z069_ids,
> +};
> +module_mcb_driver(men_z069_driver);
> +
> +MODULE_AUTHOR("Johannes Thumshirn <jth@kernel.org>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("mcb:16z069");
> 

