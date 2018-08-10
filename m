Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B98C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0213222404
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsfKQ/Lr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0213222404
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeHJQHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:07:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37530 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbeHJQHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:07:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id n7-v6so4425731pgq.4;
        Fri, 10 Aug 2018 06:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qrD4MvwhbLXYx3O4UgxKv0JmcAAJsljb/JibsHFiXpY=;
        b=EsfKQ/LrQi4sFaomV5SkvorBmveqoIYRx3GnMheCQF41otR5FKp1/gISuLyu4iELqj
         btzsmYkpFIHAz8za+KSdRGDbzQltZFT1AaR/y6AGhIatmrPPwDEr2pV6iAzcC6d8Vsfm
         eulRtJf2bq0DcmxKyRj8sfBI7MwN2/AhYKgmO6Eco8XJ9PgPuCNiliSZYnTYtPmIjjhS
         +dji1qoPUH8ItKVB4qiOrNeLiSJhk1JvAkO+VakKRrJJJ1R4Mo2QijzWCKRKZVNfxRs+
         NWMSSICv12or1FMhN1vfNiDeoESIWJUAZcBv7TUwGYwkhGaLohYifhf85q6zJGnYkMQM
         Pnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qrD4MvwhbLXYx3O4UgxKv0JmcAAJsljb/JibsHFiXpY=;
        b=FKuZYKUSR6Uptj0M7GQ+9pdIDnqMyt1hEvQtRr05SrlgpBIz9WjO9nwdKdpwfIq1Cg
         2cpxOkB8hAn0HIMIlwhFfcrV7o8cBueuvBUV5lA53XFcGT1bL5rx8UxvLXiM6hpbe3CT
         J/9KZiR3Yv6wZrTxgusWeQYUC6PQOxwYQVytrFgwo9kE4aNOCzwRE3bb04a6h5WVlL/Y
         FvOGWo2cFOzcSDKbzFMucy4lbDGnkpLaDvYhJ2lhaO3fSc1jjtMsP/jNkbOPIpNoMl6J
         8n51iH+UX/HVfJaE2WDu8NLua3gpdRur6TTJ/RDL/K1bXV9IYNWpy8zZUQesme/cH0lX
         Zycg==
X-Gm-Message-State: AOUpUlGpiGIyFFTkQ+kZJTBdVRHtZlZM6Wob/BSnmM/F71dAhpKT3uMZ
        UMa1NMGqnxq1If4dmRHdX+0=
X-Google-Smtp-Source: AA+uWPzGRUoq/rQF+MhLIARGldHLiuDiNMCKRLJLRnjt69lvBjDkGVexMXzCK0AEddQHuVDA8vNy4g==
X-Received: by 2002:a62:63c2:: with SMTP id x185-v6mr7034537pfb.13.1533908234304;
        Fri, 10 Aug 2018 06:37:14 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a15-v6sm16487309pfe.32.2018.08.10.06.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 06:37:13 -0700 (PDT)
Date:   Fri, 10 Aug 2018 06:37:12 -0700
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
Subject: Re: [PATCH v6 09/24] watchdog: jz4740: Use regmap provided by TCU
 driver
Message-ID: <20180810133712.GB29028@roeck-us.net>
References: <20180809214414.20905-1-paul@crapouillou.net>
 <20180809214414.20905-10-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809214414.20905-10-paul@crapouillou.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 11:43:59PM +0200, Paul Cercueil wrote:
> Since we broke the ABI by changing the clock, the driver was also
> updated to use the regmap provided by the TCU driver.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/jz4740_wdt.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
>  v6: New patch
> 
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index 1d504ecf45e1..0f54306aee25 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -13,6 +13,7 @@
>   *
>   */
>  
> +#include <linux/mfd/ingenic-tcu.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/types.h>
> @@ -25,10 +26,7 @@
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> -
> -#define JZ_REG_WDT_TIMER_DATA     0x0
> -#define JZ_REG_WDT_COUNTER_ENABLE 0x4
> -#define JZ_REG_WDT_TIMER_COUNTER  0x8
> +#include <linux/regmap.h>
>  
>  #define DEFAULT_HEARTBEAT 5
>  #define MAX_HEARTBEAT     2048
> @@ -48,7 +46,7 @@ MODULE_PARM_DESC(heartbeat,
>  
>  struct jz4740_wdt_drvdata {
>  	struct watchdog_device wdt;
> -	void __iomem *base;
> +	struct regmap *map;
>  	struct clk *clk;
>  	unsigned long clk_rate;
>  };
> @@ -57,7 +55,7 @@ static int jz4740_wdt_ping(struct watchdog_device *wdt_dev)
>  {
>  	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
>  
> -	writew(0x0, drvdata->base + JZ_REG_WDT_TIMER_COUNTER);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
>  	return 0;
>  }
>  
> @@ -67,12 +65,12 @@ static int jz4740_wdt_set_timeout(struct watchdog_device *wdt_dev,
>  	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
>  	u16 timeout_value = (u16)(drvdata->clk_rate * new_timeout);
>  
> -	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
>  
> -	writew((u16)timeout_value, drvdata->base + JZ_REG_WDT_TIMER_DATA);
> -	writew(0x0, drvdata->base + JZ_REG_WDT_TIMER_COUNTER);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TDR, timeout_value);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
>  
> -	writeb(0x1, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
>  
>  	wdt_dev->timeout = new_timeout;
>  	return 0;
> @@ -96,7 +94,7 @@ static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
>  {
>  	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
>  
> -	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
>  	clk_disable_unprepare(drvdata->clk);
>  
>  	return 0;
> @@ -138,7 +136,6 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct jz4740_wdt_drvdata *drvdata;
>  	struct watchdog_device *jz4740_wdt;
> -	struct resource	*res;
>  	long rate;
>  	int ret;
>  
> @@ -174,10 +171,11 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>  	watchdog_set_nowayout(jz4740_wdt, nowayout);
>  	watchdog_set_drvdata(jz4740_wdt, drvdata);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(drvdata->base))
> -		return PTR_ERR(drvdata->base);
> +	drvdata->map = dev_get_regmap(dev->parent, NULL);
> +	if (!drvdata->map) {
> +		dev_err(dev, "regmap not found\n");
> +		return -EINVAL;
> +	}
>  
>  	ret = devm_watchdog_register_device(&pdev->dev, &drvdata->wdt);
>  	if (ret < 0)
> -- 
> 2.11.0
> 
