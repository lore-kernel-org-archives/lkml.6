Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473F4C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E5820856
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mopsxzkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E5820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388543AbeGYCXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 22:23:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41949 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388457AbeGYCXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 22:23:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id z8-v6so4075759pgu.8;
        Tue, 24 Jul 2018 18:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BxZvccGO6bGf5/GhPclBxSLEQX1rBVRIQWlXRFxtHoo=;
        b=mopsxzkYpGW81ZynHSW0vJfHmkGi/TH2Sn6iCwfrS8Fp4FX4aCcNcRBp93fkzNjLNM
         xv3aaOtMLMHqOI5O6aJ6Z1ZokVUl6+23Oz/xgYNuu8Mjgqm2eD6avH0qBhmjL/uqQfkB
         ldj8oV7eTmbhIXoiiY9LsPDGdngapGpkCgXpv/wEpMJEb/TYtjN9RdO6uvDauBhQBVkX
         LVWIWvIy0mQ8U4H6r6KIVTJG40lDV55u06L8PaCE5tIzjLYT6tyLxMgDVPunt64sQpL1
         YcUBw394oHChyJWLy+NsFWT2AhGS/3rxySEBWeUkNmTCVWvPuhK214x7SgK9FW4zR2np
         Y8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BxZvccGO6bGf5/GhPclBxSLEQX1rBVRIQWlXRFxtHoo=;
        b=C+GutNZ2hvzToKJ8CJOFiuoN3FAn7teN+YsmEn1vPHBydBlNze0Q5jpB2NKBFCJJpG
         OqQwcvjbRpLzavwt9+Ld4kn5ABArXpTbk3gsPv7tEbg9dL7967l9syQ4ONL62z8zjLNq
         43SINED7AFbtTy6ASpewZCPPKQFhR9okg0EBknktskeL/K90pH3nwBHzActff769KGvN
         +UCfFFUN301HovTMqzvT49/9n03HoY88Xm/f1+vMFIuThKIFZW3pvxkV9GB6rMJmeEKI
         KxQr6Kyf+hNniZx2Iavxj624Y4OfDyePz4eGkSj2lbBdz+HdiWpAbfp6M6AdiLOtmAb5
         8WCw==
X-Gm-Message-State: AOUpUlETLxhNkxrqAG8Fo97//ilZ4oqVZZSZDzpSd8aYRa/lhoOVzZC/
        aflV0H2a2+GIcQNwaI/b2OdGJFoF
X-Google-Smtp-Source: AAOMgpe/wSRhco7W/CknJ62VOKJ0+3hdxq9F5nu57NO6jBqT699Kx+uDmPgI8AEXvQgsiGBiSeUdFw==
X-Received: by 2002:a63:6949:: with SMTP id e70-v6mr18971038pgc.119.1532481264917;
        Tue, 24 Jul 2018 18:14:24 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 21-v6sm26065875pgx.20.2018.07.24.18.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 18:14:24 -0700 (PDT)
Subject: Re: [PATCH v5 08/21] watchdog: jz4740: Use regmap and WDT clock
 provided by TCU driver
To:     Paul Cercueil <paul@crapouillou.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20180724231958.20659-1-paul@crapouillou.net>
 <20180724231958.20659-9-paul@crapouillou.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9179ab75-f071-d6a2-ef61-52431ca6409b@roeck-us.net>
Date:   Tue, 24 Jul 2018 18:14:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180724231958.20659-9-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 04:19 PM, Paul Cercueil wrote:
> Instead of requesting the "ext" clock and handling the watchdog clock
> divider and gating in the watchdog driver, we now request and use the
> "wdt" clock that is supplied by the ingenic-timer "TCU" driver.
> 
> The major benefit is that the watchdog's clock rate and parent can now
> be specified from within devicetree, instead of hardcoded in the driver.
> 

Where is the clock _rate_ specified in the devicetree file ?

Changing the clock rate in the driver may not be as hardcoded as before,
but the driver still changes the clock rate.

> Also, this driver won't poke anymore into the TCU registers to
> enable/disable the clock, as this is now handled by the TCU driver.
> 
> On the bad side, we break the ABI with devicetree - as we now request a
> different clock. In this very specific case it is still okay, as every
> Ingenic JZ47xx-based board out there compile the devicetree within the
> kernel; so it's still time to push breaking changes, in order to get a
> clean devicetree that won't break once it musn't.

mustn't

> 

This change needs to be documented in the devicetree bindings and must be
approved by a DT maintainer. The bindings change only changes the clock name
in the example, but not in the bindings description itself (which still
references the rtc clock).

> Since we broke the ABI by changing the clock, the driver was also
> updated to use the regmap provided by the TCU driver.
> 

Odd logic. What does one have to do with the other ? Why not split
the patch into two parts, one per logical change, as would be customary ?

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>   drivers/watchdog/Kconfig      |   2 +
>   drivers/watchdog/jz4740_wdt.c | 128 +++++++++++++++++++++---------------------
>   2 files changed, 66 insertions(+), 64 deletions(-)
> 
>   v5: New patch
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9af07fd92763..834222abbbdb 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1476,7 +1476,9 @@ config INDYDOG
>   config JZ4740_WDT
>   	tristate "Ingenic jz4740 SoC hardware watchdog"
>   	depends on MACH_JZ4740 || MACH_JZ4780
> +	depends on COMMON_CLK
>   	select WATCHDOG_CORE
> +	select INGENIC_TIMER
>   	help
>   	  Hardware driver for the built-in watchdog timer on Ingenic jz4740 SoCs.
>   
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index ec4d99a830ba..aaa6fc87136c 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -13,6 +13,7 @@
>    *
>    */
>   
> +#include <linux/mfd/ingenic-tcu.h>
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
>   #include <linux/types.h>
> @@ -25,26 +26,7 @@
>   #include <linux/slab.h>
>   #include <linux/err.h>
>   #include <linux/of.h>
> -
> -#include <asm/mach-jz4740/timer.h>
> -
> -#define JZ_REG_WDT_TIMER_DATA     0x0
> -#define JZ_REG_WDT_COUNTER_ENABLE 0x4
> -#define JZ_REG_WDT_TIMER_COUNTER  0x8
> -#define JZ_REG_WDT_TIMER_CONTROL  0xC
> -
> -#define JZ_WDT_CLOCK_PCLK 0x1
> -#define JZ_WDT_CLOCK_RTC  0x2
> -#define JZ_WDT_CLOCK_EXT  0x4
> -
> -#define JZ_WDT_CLOCK_DIV_SHIFT   3
> -
> -#define JZ_WDT_CLOCK_DIV_1    (0 << JZ_WDT_CLOCK_DIV_SHIFT)
> -#define JZ_WDT_CLOCK_DIV_4    (1 << JZ_WDT_CLOCK_DIV_SHIFT)
> -#define JZ_WDT_CLOCK_DIV_16   (2 << JZ_WDT_CLOCK_DIV_SHIFT)
> -#define JZ_WDT_CLOCK_DIV_64   (3 << JZ_WDT_CLOCK_DIV_SHIFT)
> -#define JZ_WDT_CLOCK_DIV_256  (4 << JZ_WDT_CLOCK_DIV_SHIFT)
> -#define JZ_WDT_CLOCK_DIV_1024 (5 << JZ_WDT_CLOCK_DIV_SHIFT)
> +#include <linux/regmap.h>
>   
>   #define DEFAULT_HEARTBEAT 5
>   #define MAX_HEARTBEAT     2048
> @@ -64,15 +46,15 @@ MODULE_PARM_DESC(heartbeat,
>   
>   struct jz4740_wdt_drvdata {
>   	struct watchdog_device wdt;
> -	void __iomem *base;
> -	struct clk *rtc_clk;
> +	struct regmap *map;
> +	struct clk *clk;
>   };
>   
>   static int jz4740_wdt_ping(struct watchdog_device *wdt_dev)
>   {
>   	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
>   
> -	writew(0x0, drvdata->base + JZ_REG_WDT_TIMER_COUNTER);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
>   	return 0;
>   }
>   
> @@ -80,52 +62,65 @@ static int jz4740_wdt_set_timeout(struct watchdog_device *wdt_dev,
>   				    unsigned int new_timeout)
>   {
>   	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
> -	unsigned int rtc_clk_rate;
> -	unsigned int timeout_value;
> -	unsigned short clock_div = JZ_WDT_CLOCK_DIV_1;
> -
> -	rtc_clk_rate = clk_get_rate(drvdata->rtc_clk);
> -
> -	timeout_value = rtc_clk_rate * new_timeout;
> -	while (timeout_value > 0xffff) {
> -		if (clock_div == JZ_WDT_CLOCK_DIV_1024) {
> -			/* Requested timeout too high;
> -			* use highest possible value. */
> -			timeout_value = 0xffff;
> -			break;
> -		}
> -		timeout_value >>= 2;
> -		clock_div += (1 << JZ_WDT_CLOCK_DIV_SHIFT);
> +	struct clk *clk = drvdata->clk;
> +	unsigned long clk_rate, timeout_value;
> +	bool change_rate = false;
> +	u32 tcer;
> +	int ret = 0;
> +
> +	clk_rate = clk_get_rate(clk);
> +	timeout_value = clk_rate * new_timeout;
> +
> +	if (timeout_value > 0xffff) {
> +		clk_rate = clk_round_rate(clk, 0xffff / new_timeout);
> +		timeout_value = clk_rate * new_timeout;
> +		if (timeout_value > 0xffff)
> +			return -EINVAL;

This is conceptually wrong. The probe code should determine the
maximum timeout and report it to the watchdog core, and it should
not be necessary to validate the timeout in this function.

Also, unless I am missing something, the new code only ever reduces the clock
rate and never increases it. Given that, you might as well set the clock
rate to the lowest possible rate when instantiating the driver and not
bother with updating it later. That would simplify the code significantly
and make it much easier to understand.

Also, clk_round_rate() can technically return 0 or even a negative (error)
value. Please make sure that the returned rate is valid.

> +		change_rate = true;
>   	}
>   
> -	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
> -	writew(clock_div, drvdata->base + JZ_REG_WDT_TIMER_CONTROL);
> +	regmap_read(drvdata->map, TCU_REG_WDT_TCER, &tcer);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
>   
> -	writew((u16)timeout_value, drvdata->base + JZ_REG_WDT_TIMER_DATA);
> -	writew(0x0, drvdata->base + JZ_REG_WDT_TIMER_COUNTER);
> -	writew(clock_div | JZ_WDT_CLOCK_RTC,
> -		drvdata->base + JZ_REG_WDT_TIMER_CONTROL);
> +	if (change_rate) {
> +		clk_disable_unprepare(clk);
> +		ret = clk_set_rate(clk, clk_rate);
> +		clk_prepare_enable(clk);
> +		if (ret)
> +			goto done;
> +	}
>   
> -	writeb(0x1, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TDR, (u16)timeout_value);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
>   
>   	wdt_dev->timeout = new_timeout;
> -	return 0;
> +
> +done:
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCER, tcer & TCU_WDT_TCER_TCEN);

regmap_read() and regmap_write return errors. Are those ignored on purpose ?

> +	return ret;
>   }
>   
>   static int jz4740_wdt_start(struct watchdog_device *wdt_dev)
>   {
> -	jz4740_timer_enable_watchdog();
> -	jz4740_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
> +	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
> +	int ret;
>   
> -	return 0;
> +	clk_prepare_enable(drvdata->clk);
> +	ret = jz4740_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
> +	if (ret)
> +		clk_disable_unprepare(drvdata->clk);
> +	else
> +		regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
> +

No else here please. Proper error handling is preferred.

> +	return ret;
>   }
>   
>   static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
>   {
>   	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
>   
> -	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
> -	jz4740_timer_disable_watchdog();
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
> +	clk_disable_unprepare(drvdata->clk);
>   
>   	return 0;
>   }
> @@ -163,13 +158,17 @@ MODULE_DEVICE_TABLE(of, jz4740_wdt_of_matches);
>   
>   static int jz4740_wdt_probe(struct platform_device *pdev)
>   {
> +	struct device *dev = &pdev->dev;
>   	struct jz4740_wdt_drvdata *drvdata;
>   	struct watchdog_device *jz4740_wdt;
> -	struct resource	*res;
>   	int ret;
>   
> -	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct jz4740_wdt_drvdata),
> -			       GFP_KERNEL);
> +	if (!dev->of_node) {
> +		dev_err(dev, "jz4740-wdt must be probed via devicetree\n");
> +		return -ENODEV;
> +	}
> +

Please explain. This check seems technically unnecessary and thus pointless.
The driver doesn't even initialize its watchdog timeout from devicetree data.

> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>   	if (!drvdata)
>   		return -ENOMEM;
>   
> @@ -182,19 +181,20 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>   	jz4740_wdt->timeout = heartbeat;
>   	jz4740_wdt->min_timeout = 1;
>   	jz4740_wdt->max_timeout = MAX_HEARTBEAT;
> -	jz4740_wdt->parent = &pdev->dev;
> +	jz4740_wdt->parent = dev;
>   	watchdog_set_nowayout(jz4740_wdt, nowayout);
>   	watchdog_set_drvdata(jz4740_wdt, drvdata);
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(drvdata->base))
> -		return PTR_ERR(drvdata->base);
> +	drvdata->map = dev_get_regmap(dev->parent, NULL);
> +	if (IS_ERR(drvdata->map)) {

dev_get_regmap() does not return an ERR_PTR().

> +		dev_warn(dev, "regmap not found\n");
> +		return PTR_ERR(drvdata->map);
> +	}
>   
> -	drvdata->rtc_clk = devm_clk_get(&pdev->dev, "rtc");
> -	if (IS_ERR(drvdata->rtc_clk)) {
> -		dev_err(&pdev->dev, "cannot find RTC clock\n");
> -		return PTR_ERR(drvdata->rtc_clk);
> +	drvdata->clk = devm_clk_get(&pdev->dev, "wdt");
> +	if (IS_ERR(drvdata->clk)) {
> +		dev_err(&pdev->dev, "cannot find WDT clock\n");
> +		return PTR_ERR(drvdata->clk);
>   	}
>   
>   	ret = devm_watchdog_register_device(&pdev->dev, &drvdata->wdt);
> 

