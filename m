Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82533C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE61216E6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="4KNOrHgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE61216E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933597AbeFUQxj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:53:39 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:35891 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933409AbeFUQxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PNjlK1Xn3wu+Xmz9AbnGqn72OqBUx/fmrOjog3za1Ag=; b=4KNOrHgQLP+bb/49sAUz6VoLBl
        ZLRoNANZZ7Xz1/g1ryFo4Hy/PuVOKQbShITkmOZrIRfZzMhFHrPgOM2puFOs6ASIOFXCg4QV87byV
        9C0crKEna5BH3AUHTQXJUqB559rFQ1cRmcGBZDuK5DQbhtqa9k5xWm9XxtCYU8TyeCWc33MHJWKyn
        HLtmcshADBFGAiUcExG/Hfh6z4kJ994nmbmpfWfgLZbeOdsFwKy37YHb1h8DXxMANQAFSn+XDX23Q
        STO1jHjvXWPRfafq4wVhSssetOOFfFkob1Of3T3XIHdiKcinvQLdPYVWBjGlQyq8iCD/txur4Anpx
        nkDqxwpQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:35490 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fW2q0-003MwK-9R; Thu, 21 Jun 2018 16:53:36 +0000
Date:   Thu, 21 Jun 2018 09:53:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V4 2/4] watchdog: stm32: add pclk feature for stm32mp1
Message-ID: <20180621165335.GA4563@roeck-us.net>
References: <1529571737-3552-1-git-send-email-ludovic.Barre@st.com>
 <1529571737-3552-3-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529571737-3552-3-git-send-email-ludovic.Barre@st.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 11:02:15AM +0200, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch adds compatible data to manage pclk clock by
> compatible. Adds stm32mp1 support which requires pclk clock.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/watchdog/stm32_iwdg.c | 116 +++++++++++++++++++++++++++---------------
>  1 file changed, 74 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index c97ad56..e00e3b3 100644
> --- a/drivers/watchdog/stm32_iwdg.c
> +++ b/drivers/watchdog/stm32_iwdg.c
> @@ -11,12 +11,13 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/watchdog.h>
>  
> @@ -54,11 +55,15 @@
>  #define TIMEOUT_US	100000
>  #define SLEEP_US	1000
>  
> +#define HAS_PCLK	true
> +
>  struct stm32_iwdg {
>  	struct watchdog_device	wdd;
>  	void __iomem		*regs;
> -	struct clk		*clk;
> +	struct clk		*clk_lsi;
> +	struct clk		*clk_pclk;
>  	unsigned int		rate;
> +	bool			has_pclk;
>  };
>  
>  static inline u32 reg_read(void __iomem *base, u32 reg)
> @@ -133,6 +138,44 @@ static int stm32_iwdg_set_timeout(struct watchdog_device *wdd,
>  	return 0;
>  }
>  
> +static int stm32_iwdg_clk_init(struct platform_device *pdev,
> +			       struct stm32_iwdg *wdt)
> +{
> +	u32 ret;
> +
> +	wdt->clk_lsi = devm_clk_get(&pdev->dev, "lsi");

I just noticed a subtle difference: This used to be
			devm_clk_get(&pdev->dev, NULL);
which would always get the first clock, no matter how it is named.
Can that cause problems with backward compatibility ?

Thanks,
Guenter

> +	if (IS_ERR(wdt->clk_lsi)) {
> +		dev_err(&pdev->dev, "Unable to get lsi clock\n");
> +		return PTR_ERR(wdt->clk_lsi);
> +	}
> +
> +	/* optional peripheral clock */
> +	if (wdt->has_pclk) {
> +		wdt->clk_pclk = devm_clk_get(&pdev->dev, "pclk");
> +		if (IS_ERR(wdt->clk_pclk)) {
> +			dev_err(&pdev->dev, "Unable to get pclk clock\n");
> +			return PTR_ERR(wdt->clk_pclk);
> +		}
> +
> +		ret = clk_prepare_enable(wdt->clk_pclk);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Unable to prepare pclk clock\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = clk_prepare_enable(wdt->clk_lsi);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to prepare lsi clock\n");
> +		clk_disable_unprepare(wdt->clk_pclk);
> +		return ret;
> +	}
> +
> +	wdt->rate = clk_get_rate(wdt->clk_lsi);
> +
> +	return 0;
> +}
> +
>  static const struct watchdog_info stm32_iwdg_info = {
>  	.options	= WDIOF_SETTIMEOUT |
>  			  WDIOF_MAGICCLOSE |
> @@ -147,49 +190,42 @@ static const struct watchdog_ops stm32_iwdg_ops = {
>  	.set_timeout	= stm32_iwdg_set_timeout,
>  };
>  
> +static const struct of_device_id stm32_iwdg_of_match[] = {
> +	{ .compatible = "st,stm32-iwdg", .data = (void *)!HAS_PCLK },
> +	{ .compatible = "st,stm32mp1-iwdg", .data = (void *)HAS_PCLK },
> +	{ /* end node */ }
> +};
> +MODULE_DEVICE_TABLE(of, stm32_iwdg_of_match);
> +
>  static int stm32_iwdg_probe(struct platform_device *pdev)
>  {
>  	struct watchdog_device *wdd;
> +	const struct of_device_id *match;
>  	struct stm32_iwdg *wdt;
>  	struct resource *res;
> -	void __iomem *regs;
> -	struct clk *clk;
>  	int ret;
>  
> +	match = of_match_device(stm32_iwdg_of_match, &pdev->dev);
> +	if (!match)
> +		return -ENODEV;
> +
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	wdt->has_pclk = match->data;
> +
>  	/* This is the timer base. */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	regs = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(regs)) {
> +	wdt->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(wdt->regs)) {
>  		dev_err(&pdev->dev, "Could not get resource\n");
> -		return PTR_ERR(regs);
> +		return PTR_ERR(wdt->regs);
>  	}
>  
> -	clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(clk)) {
> -		dev_err(&pdev->dev, "Unable to get clock\n");
> -		return PTR_ERR(clk);
> -	}
> -
> -	ret = clk_prepare_enable(clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Unable to prepare clock %p\n", clk);
> +	ret = stm32_iwdg_clk_init(pdev, wdt);
> +	if (ret)
>  		return ret;
> -	}
> -
> -	/*
> -	 * Allocate our watchdog driver data, which has the
> -	 * struct watchdog_device nested within it.
> -	 */
> -	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> -	if (!wdt) {
> -		ret = -ENOMEM;
> -		goto err;
> -	}
> -
> -	/* Initialize struct stm32_iwdg. */
> -	wdt->regs = regs;
> -	wdt->clk = clk;
> -	wdt->rate = clk_get_rate(clk);
>  
>  	/* Initialize struct watchdog_device. */
>  	wdd = &wdt->wdd;
> @@ -217,7 +253,8 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
>  
>  	return 0;
>  err:
> -	clk_disable_unprepare(clk);
> +	clk_disable_unprepare(wdt->clk_lsi);
> +	clk_disable_unprepare(wdt->clk_pclk);
>  
>  	return ret;
>  }
> @@ -227,23 +264,18 @@ static int stm32_iwdg_remove(struct platform_device *pdev)
>  	struct stm32_iwdg *wdt = platform_get_drvdata(pdev);
>  
>  	watchdog_unregister_device(&wdt->wdd);
> -	clk_disable_unprepare(wdt->clk);
> +	clk_disable_unprepare(wdt->clk_lsi);
> +	clk_disable_unprepare(wdt->clk_pclk);
>  
>  	return 0;
>  }
>  
> -static const struct of_device_id stm32_iwdg_of_match[] = {
> -	{ .compatible = "st,stm32-iwdg" },
> -	{ /* end node */ }
> -};
> -MODULE_DEVICE_TABLE(of, stm32_iwdg_of_match);
> -
>  static struct platform_driver stm32_iwdg_driver = {
>  	.probe		= stm32_iwdg_probe,
>  	.remove		= stm32_iwdg_remove,
>  	.driver = {
>  		.name	= "iwdg",
> -		.of_match_table = stm32_iwdg_of_match,
> +		.of_match_table = of_match_ptr(stm32_iwdg_of_match),
>  	},
>  };
>  module_platform_driver(stm32_iwdg_driver);
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
