Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751806AbeEFPOl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 11:14:41 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:27350 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbeEFPOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 11:14:40 -0400
Subject: Re: [PATCH] clk: davinci: pll-dm355: fix SYSCLKn parent names
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, <linux-kernel@vger.kernel.org>
References: <20180504142426.4764-1-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <ebe8d8aa-ea7d-62ad-106e-abb0db95edce@ti.com>
Date: Sun, 6 May 2018 20:43:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504142426.4764-1-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Friday 04 May 2018 07:54 PM, David Lechner wrote:
> This fixes the parent clock names of the SYSCLKn clocks for the DM355
> SoC in the TI DaVinici PLL clock driver.
> 
> It appears that this name just didn't get updated to the correct name
> like the other SoCs during the driver's development.
> 
> Reported-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> Sekhar, can you please test to make sure this works?
> 
> 
>  drivers/clk/davinci/pll-dm355.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/davinci/pll-dm355.c b/drivers/clk/davinci/pll-dm355.c
> index a0cff4212ac3..13dc6b8ea97a 100644
> --- a/drivers/clk/davinci/pll-dm355.c
> +++ b/drivers/clk/davinci/pll-dm355.c
> @@ -22,10 +22,10 @@ static const struct davinci_pll_clk_info dm355_pll1_info = {
>  		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_POSTDIV_FIXED_DIV,
>  };
>  
> -SYSCLK(1, pll1_sysclk1, pll1, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
> -SYSCLK(2, pll1_sysclk2, pll1, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
> -SYSCLK(3, pll1_sysclk3, pll1, 5, SYSCLK_ALWAYS_ENABLED);
> -SYSCLK(4, pll1_sysclk4, pll1, 5, SYSCLK_ALWAYS_ENABLED);
> +SYSCLK(1, pll1_sysclk1, pll1_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
> +SYSCLK(2, pll1_sysclk2, pll1_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
> +SYSCLK(3, pll1_sysclk3, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
> +SYSCLK(4, pll1_sysclk4, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
>  
>  int dm355_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
>  {
> @@ -62,8 +62,8 @@ static const struct davinci_pll_clk_info dm355_pll2_info = {
>  		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_POSTDIV_FIXED_DIV,
>  };
>  
> -SYSCLK(1, pll2_sysclk1, pll2, 5, SYSCLK_FIXED_DIV);
> -SYSCLK(2, pll2_sysclk2, pll2, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
> +SYSCLK(1, pll2_sysclk1, pll2_pllen, 5, SYSCLK_FIXED_DIV);

We also need SYSCLK_ALWAYS_ENABLED for PLL2 sysclk1. With that change, I
was able to boot DM355 EVM and the clock tree looks good too.

> +SYSCLK(2, pll2_sysclk2, pll2_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
>  
>  int dm355_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
>  {

Regards,
Sekhar
