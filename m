Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44421ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF77720857
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ui1TfSyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF77720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbeGMOFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:05:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34356 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbeGMOFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:05:12 -0400
Received: by mail-pf0-f196.google.com with SMTP id e10-v6so22696474pfn.1;
        Fri, 13 Jul 2018 06:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x27ZSesvxYzvRWDfRq8W/7y2aZz/JQi+mUqw5M7MgLw=;
        b=Ui1TfSyioT6VODNH8xwKE0iQ6RQR/5Vg6Kgbyv8BnczIYteNtXBL/K8HBOyoxZHNNj
         0AeHZGhQLHjw3EfkIEkwOicjFXJgmBsa1kMdpf3XbLyvbONSfBcwhhXlYJCsXeHYKcen
         Z9cuGynMCetwl6XHeHjqF6MW6BOUtAGznWN8ynFgOCujPY1IsC/K6ejsNBbbW+WppIt7
         40aaeAxWUUfkLVpJRHcKrrfyoq8rIJg6aGdHgS9Gtu0jmGbEkG7yNyTFntRZUoE1Lm4k
         COWQQywKvIw1xlVC2lhyk9z8uTM/yMLkohBLTL41SdqkEJpJn9AgmoLHhXM3WNhJ5tJP
         SHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x27ZSesvxYzvRWDfRq8W/7y2aZz/JQi+mUqw5M7MgLw=;
        b=oaiSOJeV6WrsjDCJ/sqhP91QMYLdWX7p6e6T+RA+MnFVUlYbZjw6fC7k8r9/l/c3Db
         U9X4U40acHG8/xv3moXUmYWkIPU3ZptQ4RxdhAhOUEP7lEFgkiBOYpodqqPKp4nfgzpM
         jy8Gh8IBh4qYadmFxwlas4kE+DmrS3j3lf4PEOmHtheJNRx7LG80DLI3zg0iOejd+f+P
         eWTUiP+3S6TgAGmwfOAS2Wwp+pdIeSkkDLR4paplNcOftdvnOrNBjvlvMscxzuuw84L4
         sCx2DRDlBcTAtcPQo9KFXJfQURYbP0prr6e2xQLYg+ljGzJXs467SATbsdXNrI2NC2Dx
         0spw==
X-Gm-Message-State: AOUpUlGm/qGf/w+JrKHufFi+DCsIX07zmSqkNS0mztVJlH1zrRxUGJx2
        5RA2EL5WPq3QjzuV2ZsylVRzLQ==
X-Google-Smtp-Source: AAOMgpe/UqGgXFOJmAMKZRVkvSCcvP8eE/KLZ4NHgQ1ZCWVWZOiyyKV5CIUtHQ4hkecEdpvlvB3x/Q==
X-Received: by 2002:a63:1f20:: with SMTP id f32-v6mr6019176pgf.84.1531489827619;
        Fri, 13 Jul 2018 06:50:27 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id q28-v6sm53113978pfg.144.2018.07.13.06.50.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 06:50:26 -0700 (PDT)
Subject: Re: [PATCH] watchdog: add driver for the MEN 16z069 IP-Core
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20180713125831.26074-1-jthumshirn@suse.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3911405c-4192-2554-cfb9-0441c3d8ef9b@roeck-us.net>
Date:   Fri, 13 Jul 2018 06:50:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180713125831.26074-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/2018 05:58 AM, Johannes Thumshirn wrote:
> Add a driver for the MEN 16z069 Watchdog and Reset Controller IP-Core.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>   MAINTAINERS                   |   6 ++
>   drivers/watchdog/Kconfig      |  10 +++
>   drivers/watchdog/Makefile     |   1 +
>   drivers/watchdog/menz69_wdt.c | 175 ++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 192 insertions(+)
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
> index 000000000000..9dccd8aabdb9
> --- /dev/null
> +++ b/drivers/watchdog/menz69_wdt.c
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Watchdog driver for the MEN z069 IP-Core
> + *
> + * Copyright (C) 2018 Johannes Thumshirn <jth@kernel.org>
> + */
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/mcb.h>
> +#include <linux/watchdog.h>
> +#include <linux/io.h>
> +
Alphabetic order, please

> +struct men_z069_drv {
> +	struct watchdog_device wdt;
> +	void __iomem *base;
> +	struct resource *mem;
> +};
> +
> +#define MEN_Z069_WTR 0x10
> +#define MEN_Z069_WTR_WDEN BIT(15)
> +#define MEN_Z069_WTR_WDET_MASK	0x7fff
> +#define MEN_Z069_WVR 0x14
> +
> +#define MEN_Z069_TIMER_FREQ 500 /* 500 Hz */
> +#define MEN_Z069_WDT_COUNTER_MIN 1
> +#define MEN_Z069_WDT_COUNTER_MAX 0x7fff
> +
Looks like you are sometimes using tabs and sometimes not.
Please align all values with tabs, or if you really dislike that don't use
tabs at all.

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
> +	if (val < MEN_Z069_WDT_COUNTER_MIN || val > MEN_Z069_WDT_COUNTER_MAX)
> +		return -EINVAL;
> +

This is unnecessary. As long as the limits are provided, they are validated
by the watchdog core.

Note that it is wrng to set ->timeout and then return an error.
The watchdog core will then report a bad current timeout to user space.

> +	reg = readw(drv->base + MEN_Z069_WVR);
> +	ena = reg & MEN_Z069_WTR_WDEN;
> +	reg = ena | (val & MEN_Z069_WTR_WDET_MASK);

Masking val is unnecessary here. val is already guaranteed to be
smaller than the mask.

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
> +	.min_timeout = 1,
> +	.max_timeout = 65,

I would suggest to use
	.max_timeout = MEN_Z069_WDT_COUNTER_MAX / MEN_Z069_TIMER_FREQ;
or define MAX_TIMEOUT as (MEN_Z069_WDT_COUNTER_MAX / MEN_Z069_TIMER_FREQ) and use it.

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

The proper errr to return here is -ENOMEM, or use devm_ioremap_resource()
and return whatever error it reports.

> +
> +	drv->mem = mem;
> +
> +	watchdog_init_timeout(&men_z069_wdt, 30, &dev->dev);

Please make '30' a define. Unless you know for sure that this will never be used
in a devicetree system, I would suggest to set the default timeout in struct
watchdog_device and pass 0 as argument here; this way the core picks the default
timeout if set in devicetree.

> +	watchdog_set_nowayout(&men_z069_wdt, nowayout);
> +	watchdog_set_drvdata(&men_z069_wdt, drv);
> +	men_z069_wdt.parent = &dev->dev;
> +	drv->wdt = men_z069_wdt;

This is unusual. I would suggest to drop men_z069_wdt and set the necessary fields
in drv->wdt directly.

> +	mcb_set_drvdata(dev, drv);
> +
> +	/* Set initial timeout to 65.5s and disable the watchdog */
> +	writew(MEN_Z069_WDT_COUNTER_MAX, drv->base + MEN_Z069_WTR);
> +

Hmm - above default is set to 30 seconds.

Another possibility would be to detect the current watchdog state
(and possibly timeout) and inform the watchdog core that the watchdog
is running. This way there is no gap in watchdog coverage if the
watchdog was already enabled in BIOS/ROMMON.

> +	return watchdog_register_device(&men_z069_wdt);
> +
> +release_mem:
> +	mcb_release_mem(mem);
> +	return -ENXIO;
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
> +
Double empty line.

> +MODULE_AUTHOR("Johannes Thumshirn <jth@kernel.org>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("mcb:16z069");
> 

