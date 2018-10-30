Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EECC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80DE2064C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEdN/mq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80DE2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeJ3WKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:10:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38732 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbeJ3WKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:10:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id f8-v6so5636705pgq.5;
        Tue, 30 Oct 2018 06:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JUE3awBRxSMlXjGtGjPGUwYbv+duwDDW6RKwfZQxLA4=;
        b=hEdN/mq4M7YJgukiN9UGrcNpsE3194Mf4//eV+BPnf/LZGfPc8s/LWl2XszIz6PQ8G
         dtENmtR8ZHP4iMDW2KkrUg60JMVxemMZl8sauGKpVlnoXIYtQ9QjK2TeVUN9YLXqQaCP
         t7AymSAqQ0TZsmrEBV7LLJaqfDADoWzMG7g8ZjnLj6CnUSY1GhOR5LYry1DrQesTNqW1
         /782AbyGS0bH1B5eVjav8Xl9sLlNPEdAcG4R4G/H+u0hnkZvMIR/IOPzVHy6/VaOH9CR
         z+GHt4RuC3RTxdKd+M4To/sdgBgumj7ej9n2YSPVH9Rm9CUO6i05msR8hkyFS4gFijmg
         j2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JUE3awBRxSMlXjGtGjPGUwYbv+duwDDW6RKwfZQxLA4=;
        b=a02HDHOCjZxKIDbTZyTDQodmxI7LtFt0HnUqHoqPgS4DbCVgKY+q3d2SDnwVbNQA42
         W6QASQ7+XGv8SQb28UutlY985YkoyAH8zd1miOKlNekkovzQD6CZXJX9PWJ+EufVXbZY
         agmxDRYuwy8/bXqNAjSyW1g3MHVnldgRKcuhRXSxAOPbKkdyOMZKl1/Mapj0IsazDHi1
         vA3r16lEtFCDQZW2luSHOAWwiDV7LvKuoRH3DwNd5/mNYJycvNgCUokK1Q9dpcyO+xL9
         nWYSPK4g5/nfZ8/1WnNos8BriK/V/X/Yn3dwLa5uM+LEzzUxrr1IQAIhr2l7QI9bEVAu
         b/Cw==
X-Gm-Message-State: AGRZ1gLgCQkrAYxoF0Kn8ADsA1hRnHTLbgcBxdqXsmICIdAZULL99GKd
        YZHv9jUM0KbvNlFe6KOGIpg=
X-Google-Smtp-Source: AJdET5e98ep8iqaZqyvvjU+VCf3MLQQiZLhJW7DwxHZM34AiV7JxYhskWFIcjyuT0VrUVqu5Fs4R1A==
X-Received: by 2002:a63:6ec4:: with SMTP id j187-v6mr18254329pgc.3.1540905428728;
        Tue, 30 Oct 2018 06:17:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u12-v6sm15211837pfi.83.2018.10.30.06.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 06:17:07 -0700 (PDT)
Subject: Re: [PATCH v5 8/8] watchdog: stpmic1: add stpmic1 watchdog driver
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
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
References: <1540830122-2577-1-git-send-email-p.paillet@st.com>
 <1540830122-2577-9-git-send-email-p.paillet@st.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8a2c1762-76c8-7a46-3d91-ebb2e37ac1f8@roeck-us.net>
Date:   Tue, 30 Oct 2018 06:17:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540830122-2577-9-git-send-email-p.paillet@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/18 9:22 AM, Pascal PAILLET-LME wrote:
> The stpmic1 PMIC embeds a watchdog which is disabled by default. As soon
> as the watchdog is started, it must be refreshed periodically otherwise
> the PMIC goes off.
> 
> Signed-off-by: Pascal Paillet <p.paillet@st.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> changes in v5:
> * initialize wdtdev.parent
> * fix checkpatch warning
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
> index 0000000..ad431d8
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
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
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
> +	wdt->wdtdev.parent = &pdev->dev;
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

