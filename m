Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeDFH5M (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 03:57:12 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43009 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751746AbeDFH5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 03:57:10 -0400
X-Google-Smtp-Source: AIpwx4+C09PUjsgv5YQOACXgGcH3aEoDX/jCgKiT+uw8qV1sFGRZL5tNaZ397M7XdUyTJmwjyt0Gtw==
Date: Fri, 6 Apr 2018 13:27:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: vireshk@kernel.org, shiraz.linux.kernel@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 2/2] clk: spear: fix WDT clock definition on SPEAr600
Message-ID: <20180406075707.GX3572@vireshk-i7>
References: <0635969b6ef0fe528a27a8b6493cc3df770e1f60.1523000725.git-series.quentin.schulz@bootlin.com>
 <c7240072ab53d5d34a9756389729343243028eb3.1523000725.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7240072ab53d5d34a9756389729343243028eb3.1523000725.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-04-18, 09:50, Quentin Schulz wrote:
> There is no SPEAr600 device named "wdt". Instead, the description of the
> WDT (watchdog) was recently added to the Device Tree, and the device
> name is "fc880000.wdt", so we should associate the WDT fixed rate clock
> to this device name.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  drivers/clk/spear/spear6xx_clock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
> index f911d9f..47810be 100644
> --- a/drivers/clk/spear/spear6xx_clock.c
> +++ b/drivers/clk/spear/spear6xx_clock.c
> @@ -147,7 +147,7 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
>  
>  	clk = clk_register_fixed_factor(NULL, "wdt_clk", "osc_30m_clk", 0, 1,
>  			1);
> -	clk_register_clkdev(clk, NULL, "wdt");
> +	clk_register_clkdev(clk, NULL, "fc880000.wdt");
>  
>  	/* clock derived from pll1 clk */
>  	clk = clk_register_fixed_factor(NULL, "cpu_clk", "pll1_clk",

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
