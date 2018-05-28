Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754020AbeE1HzR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:55:17 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4440 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753797AbeE1HzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:55:15 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 28 May 2018 00:55:14 -0700
Date: Mon, 28 May 2018 10:55:10 +0300
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Stefan Agner <stefan@agner.ch>
CC: <boris.brezillon@bootlin.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <dev@lynxeye.de>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <marcel@ziswiler.com>, <krzk@kernel.org>,
        <digetx@gmail.com>, <benjamin.lindqvist@endian.se>,
        <jonathanh@nvidia.com>, <pgaikwad@nvidia.com>, <mirza.krak@gmail.com>,
        <linux-mtd@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] clk: tegra20: init NDFLASH clock to sensible rate
Message-ID: <20180528075510.GQ6835@tbergstrom-lnx.Nvidia.com>
References: <20180527215442.14760-5-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180527215442.14760-5-stefan@agner.ch>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2018 at 11:54:40PM +0200, Stefan Agner wrote:
> From: Lucas Stach <dev@lynxeye.de>
> 
> Set up the NAND Flash controller clock to run at 150MHz
> instead of the rate set by the bootloader. This is a
> conservative rate which also yields good performance.
> 
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/clk/tegra/clk-tegra20.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
> index 0ee56dd04cec..dff8c425cd28 100644
> --- a/drivers/clk/tegra/clk-tegra20.c
> +++ b/drivers/clk/tegra/clk-tegra20.c
> @@ -1049,6 +1049,7 @@ static struct tegra_clk_init_table init_table[] __initdata = {
>  	{ TEGRA20_CLK_GR2D, TEGRA20_CLK_PLL_C, 300000000, 0 },
>  	{ TEGRA20_CLK_GR3D, TEGRA20_CLK_PLL_C, 300000000, 0 },
>  	{ TEGRA20_CLK_VDE, TEGRA20_CLK_CLK_MAX, 300000000, 0 },
> +	{ TEGRA20_CLK_NDFLASH, TEGRA20_CLK_PLL_P, 150000000, 0 },
>  	/* must be the last entry */
>  	{ TEGRA20_CLK_CLK_MAX, TEGRA20_CLK_CLK_MAX, 0, 0 },
>  };
> -- 
> 2.17.0
> 

Maybe better to specify this in the Tegra20 dtsi? See 
"Assigned clock parents and rates" in Documentation/devicetree/bindings/clock/clock-bindings.txt

Peter.
