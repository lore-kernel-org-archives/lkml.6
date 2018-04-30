Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752429AbeD3Hqw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:46:52 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3316 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbeD3Hqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:46:50 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 30 Apr 2018 00:46:49 -0700
Date: Mon, 30 Apr 2018 10:46:44 +0300
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Dmitry Osipenko <digetx@gmail.com>
CC: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Marcel Ziswiler <marcel@ziswiler.com>, Marc Dietrich <marvin24@gmx.de>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/4] clk: tegra20: Set correct parents for CDEV1/2
 clocks
Message-ID: <20180430074644.GL6835@tbergstrom-lnx.Nvidia.com>
References: <20180426235818.10018-1-digetx@gmail.com>
 <20180426235818.10018-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180426235818.10018-4-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.21.24.170]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To UKMAIL102.nvidia.com
 (10.26.138.15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 02:58:17AM +0300, Dmitry Osipenko wrote:
> Parents of CDEV1/2 clocks are determined by muxing of the corresponding
> pins. Pinctrl driver now provides the CDEV1/2 clock muxes and hence
> CDEV1/2 clocks could have correct parents. Set CDEV1/2 parents to the
> corresponding muxes to fix the parents.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-By:  Peter De Schrijver <pdeschrijver@nvidia.com>

> ---
>  drivers/clk/tegra/clk-tegra20.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
> index 16cf4108f2ff..7e8b6de86d89 100644
> --- a/drivers/clk/tegra/clk-tegra20.c
> +++ b/drivers/clk/tegra/clk-tegra20.c
> @@ -844,14 +844,12 @@ static void __init tegra20_periph_clk_init(void)
>  			     CLK_DIVIDER_POWER_OF_TWO, NULL);
>  
>  	/* cdev1 */
> -	clk = clk_register_fixed_rate(NULL, "cdev1_fixed", NULL, 0, 26000000);
> -	clk = tegra_clk_register_periph_gate("cdev1", "cdev1_fixed", 0,
> +	clk = tegra_clk_register_periph_gate("cdev1", "cdev1_mux", 0,
>  				    clk_base, 0, 94, periph_clk_enb_refcnt);
>  	clks[TEGRA20_CLK_CDEV1] = clk;
>  
>  	/* cdev2 */
> -	clk = clk_register_fixed_rate(NULL, "cdev2_fixed", NULL, 0, 26000000);
> -	clk = tegra_clk_register_periph_gate("cdev2", "cdev2_fixed", 0,
> +	clk = tegra_clk_register_periph_gate("cdev2", "cdev2_mux", 0,
>  				    clk_base, 0, 93, periph_clk_enb_refcnt);
>  	clks[TEGRA20_CLK_CDEV2] = clk;
>  
> -- 
> 2.17.0
> 
