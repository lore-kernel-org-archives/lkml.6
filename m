Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3326EC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D572D223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACj9JG8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D572D223F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeHJQGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:06:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40124 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbeHJQGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:06:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id x5-v6so4419804pgp.7;
        Fri, 10 Aug 2018 06:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MWi4HQTC5XXguMrj9ksWGJ3W6BoVDo2F+36mb1zaEdU=;
        b=ACj9JG8UqRsckSFmuir2TDeasjRy2Jprj2EenA0eexfmpZHsMqeuGn3Nkgy2pbGaaw
         cc9Y0rq2K+aSZhK4ovoElNYvBdUGodmhMgx6yR4CmFGP6HNeJkCpg7jFG9w7Hf2nKd4r
         WZfr9ktXj6kVZPb8nDGVgvIINHGfz9lN8qlRv7gegV9hbuddRsPxIrGwUgRcwLXv1vSb
         8861rUuYYK3ue2l5rZu4YhFxsILJnzDgnMjMDHVg37zBXawKFYQS94bSXaHQDxiI0H36
         d09iSNQnfRzQhAbak5y98c8nH9tMlQxua9jOcDkUqDwuCmLD8siRv5q1AWN2NKpgpCU8
         um7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MWi4HQTC5XXguMrj9ksWGJ3W6BoVDo2F+36mb1zaEdU=;
        b=b4jM1wUtUCad6mAgJgtw9ZlrT0RyfewJOdBd9JmvNB0ovEMjayL3LpEcII8dkDFKYB
         E1D3zgOGryiVqomMnGWz9aHfappwiCy+xufi5kAjnF1jIDGMgoZR5e082ViZsQTUyH+m
         BAZTWvLLJ0XLioRUqFqv5V8FfvMB8e/vQP6JFf6LUPu4QynONVW683/Q1bfKkUBjeQp2
         42vmniBejaI0WXXP14TUO5iun+wsexcGOo+loPtiH4RXQZzB/y9YejtcXhCmXiRUh/DR
         G+snCPyhF9uyn8up8m83RSJ29fwU4RRFbwOwarjlRjr0hGUU6tbX1rBZZdOb4r+Y4ZeA
         HFEA==
X-Gm-Message-State: AOUpUlE8YiTgn2qAzXYmkk5CwCGhdlBn3aHFIXJlpK1raspARsogsdZc
        WMS7WgaOW7flY7boK5qKGUU=
X-Google-Smtp-Source: AA+uWPzmyUHawkMpNr/J8hAIt26A8jh9Em87aVJT0sCr83vi3xLNQMgklo/hAlxvoAT/BExpsDkEpw==
X-Received: by 2002:a62:cac5:: with SMTP id y66-v6mr7078073pfk.187.1533908211054;
        Fri, 10 Aug 2018 06:36:51 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g5-v6sm10106245pgn.73.2018.08.10.06.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 06:36:49 -0700 (PDT)
Date:   Fri, 10 Aug 2018 06:36:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 08/24] watchdog: jz4740: Use WDT clock provided by TCU
 driver
Message-ID: <20180810133648.GA29028@roeck-us.net>
References: <20180809214414.20905-1-paul@crapouillou.net>
 <20180809214414.20905-9-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809214414.20905-9-paul@crapouillou.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 11:43:58PM +0200, Paul Cercueil wrote:
> Instead of requesting the "ext" clock and handling the watchdog clock
> divider and gating in the watchdog driver, we now request and use the
> "wdt" clock that is supplied by the ingenic-timer "TCU" driver.
> 
> The major benefit is that the watchdog's clock rate and parent can now
> be specified from within devicetree, instead of hardcoded in the driver.
> 
> Also, this driver won't poke anymore into the TCU registers to
> enable/disable the clock, as this is now handled by the TCU driver.
> 
> On the bad side, we break the ABI with devicetree - as we now request a
> different clock. In this very specific case it is still okay, as every
> Ingenic JZ47xx-based board out there compile the devicetree within the
> kernel; so it's still time to push breaking changes, in order to get a
> clean devicetree that won't break once it musn't.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig      |  2 +
>  drivers/watchdog/jz4740_wdt.c | 86 +++++++++++++++++--------------------------
>  2 files changed, 36 insertions(+), 52 deletions(-)
> 
>  v5: New patch
> 
>  v6: - Split regmap change to new patch 09/24
>      - The code now sets the WDT clock to the smallest rate possible and
>        calculates the maximum timeout from that
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9af07fd92763..834222abbbdb 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1476,7 +1476,9 @@ config INDYDOG
>  config JZ4740_WDT
>  	tristate "Ingenic jz4740 SoC hardware watchdog"
>  	depends on MACH_JZ4740 || MACH_JZ4780
> +	depends on COMMON_CLK
>  	select WATCHDOG_CORE
> +	select INGENIC_TIMER
>  	help
>  	  Hardware driver for the built-in watchdog timer on Ingenic jz4740 SoCs.
>  
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index ec4d99a830ba..1d504ecf45e1 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -26,25 +26,9 @@
>  #include <linux/err.h>
>  #include <linux/of.h>
>  
> -#include <asm/mach-jz4740/timer.h>
> -
>  #define JZ_REG_WDT_TIMER_DATA     0x0
>  #define JZ_REG_WDT_COUNTER_ENABLE 0x4
>  #define JZ_REG_WDT_TIMER_COUNTER  0x8
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
>  
>  #define DEFAULT_HEARTBEAT 5
>  #define MAX_HEARTBEAT     2048
> @@ -65,7 +49,8 @@ MODULE_PARM_DESC(heartbeat,
>  struct jz4740_wdt_drvdata {
>  	struct watchdog_device wdt;
>  	void __iomem *base;
> -	struct clk *rtc_clk;
> +	struct clk *clk;
> +	unsigned long clk_rate;
>  };
>  
>  static int jz4740_wdt_ping(struct watchdog_device *wdt_dev)
> @@ -80,31 +65,12 @@ static int jz4740_wdt_set_timeout(struct watchdog_device *wdt_dev,
>  				    unsigned int new_timeout)
>  {
>  	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
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
> -	}
> +	u16 timeout_value = (u16)(drvdata->clk_rate * new_timeout);
>  
>  	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
> -	writew(clock_div, drvdata->base + JZ_REG_WDT_TIMER_CONTROL);
>  
>  	writew((u16)timeout_value, drvdata->base + JZ_REG_WDT_TIMER_DATA);
>  	writew(0x0, drvdata->base + JZ_REG_WDT_TIMER_COUNTER);
> -	writew(clock_div | JZ_WDT_CLOCK_RTC,
> -		drvdata->base + JZ_REG_WDT_TIMER_CONTROL);
>  
>  	writeb(0x1, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
>  
> @@ -114,7 +80,13 @@ static int jz4740_wdt_set_timeout(struct watchdog_device *wdt_dev,
>  
>  static int jz4740_wdt_start(struct watchdog_device *wdt_dev)
>  {
> -	jz4740_timer_enable_watchdog();
> +	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(drvdata->clk);
> +	if (ret)
> +		return ret;
> +
>  	jz4740_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
>  
>  	return 0;
> @@ -125,7 +97,7 @@ static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
>  	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
>  
>  	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
> -	jz4740_timer_disable_watchdog();
> +	clk_disable_unprepare(drvdata->clk);
>  
>  	return 0;
>  }
> @@ -163,26 +135,42 @@ MODULE_DEVICE_TABLE(of, jz4740_wdt_of_matches);
>  
>  static int jz4740_wdt_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	struct jz4740_wdt_drvdata *drvdata;
>  	struct watchdog_device *jz4740_wdt;
>  	struct resource	*res;
> +	long rate;
>  	int ret;
>  
> -	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct jz4740_wdt_drvdata),
> -			       GFP_KERNEL);
> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
>  		return -ENOMEM;
>  
> -	if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
> -		heartbeat = DEFAULT_HEARTBEAT;
> +	drvdata->clk = devm_clk_get(&pdev->dev, "wdt");
> +	if (IS_ERR(drvdata->clk)) {
> +		dev_err(&pdev->dev, "cannot find WDT clock\n");
> +		return PTR_ERR(drvdata->clk);
> +	}
> +
> +	/* Set smallest clock possible */
> +	rate = clk_round_rate(drvdata->clk, 1);
> +	if (rate < 0)
> +		return rate;
>  
> +	ret = clk_set_rate(drvdata->clk, rate);
> +	if (ret)
> +		return ret;
> +
> +	drvdata->clk_rate = rate;
>  	jz4740_wdt = &drvdata->wdt;
>  	jz4740_wdt->info = &jz4740_wdt_info;
>  	jz4740_wdt->ops = &jz4740_wdt_ops;
> -	jz4740_wdt->timeout = heartbeat;
>  	jz4740_wdt->min_timeout = 1;
> -	jz4740_wdt->max_timeout = MAX_HEARTBEAT;
> -	jz4740_wdt->parent = &pdev->dev;
> +	jz4740_wdt->max_timeout = 0xffff / rate;
> +	jz4740_wdt->timeout = clamp(heartbeat,
> +				    jz4740_wdt->min_timeout,
> +				    jz4740_wdt->max_timeout);
> +	jz4740_wdt->parent = dev;
>  	watchdog_set_nowayout(jz4740_wdt, nowayout);
>  	watchdog_set_drvdata(jz4740_wdt, drvdata);
>  
> @@ -191,12 +179,6 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(drvdata->base))
>  		return PTR_ERR(drvdata->base);
>  
> -	drvdata->rtc_clk = devm_clk_get(&pdev->dev, "rtc");
> -	if (IS_ERR(drvdata->rtc_clk)) {
> -		dev_err(&pdev->dev, "cannot find RTC clock\n");
> -		return PTR_ERR(drvdata->rtc_clk);
> -	}
> -
>  	ret = devm_watchdog_register_device(&pdev->dev, &drvdata->wdt);
>  	if (ret < 0)
>  		return ret;
> -- 
> 2.11.0
> 
