Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbeFELUg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:20:36 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5794 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbeFELUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:20:34 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 05 Jun 2018 04:20:39 -0700
Date: Tue, 5 Jun 2018 14:20:31 +0300
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Dmitry Osipenko <digetx@gmail.com>
CC: Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] clk: tegra: Mark Memory Controller clock as critical
Message-ID: <20180605112031.GE27696@tbergstrom-lnx.Nvidia.com>
References: <20180603224805.495-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180603224805.495-1-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 01:48:05AM +0300, Dmitry Osipenko wrote:
> Memory Controller should be always-on. Currently the sibling EMC clock is
> marked as critical, let's mark MC clock too for consistency.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>

> ---
>  drivers/clk/tegra/clk-divider.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
> index 16e0aee14773..58874c1bbf5e 100644
> --- a/drivers/clk/tegra/clk-divider.c
> +++ b/drivers/clk/tegra/clk-divider.c
> @@ -194,6 +194,7 @@ static const struct clk_div_table mc_div_table[] = {
>  struct clk *tegra_clk_register_mc(const char *name, const char *parent_name,
>  				  void __iomem *reg, spinlock_t *lock)
>  {
> -	return clk_register_divider_table(NULL, name, parent_name, 0, reg,
> -					  16, 1, 0, mc_div_table, lock);
> +	return clk_register_divider_table(NULL, name, parent_name,
> +					  CLK_IS_CRITICAL, reg, 16, 1, 0,
> +					  mc_div_table, lock);
>  }
> -- 
> 2.17.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
