Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B663BC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD0D20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD0D20BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbeGLNJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:09:33 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18483 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbeGLNJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:09:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b4750a60000>; Thu, 12 Jul 2018 05:59:18 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 12 Jul 2018 06:00:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 12 Jul 2018 06:00:03 -0700
Received: from [10.21.132.122] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 12 Jul
 2018 13:00:00 +0000
Subject: Re: [PATCH v6 4/4] clk: tegra: make sdmmc2 and sdmmc4 as sdmmc clocks
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <1531396382-5579-1-git-send-email-avienamo@nvidia.com>
 <1531396382-5579-5-git-send-email-avienamo@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <8e1852c4-1471-ae05-8e55-c30ba4e77554@nvidia.com>
Date:   Thu, 12 Jul 2018 13:59:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531396382-5579-5-git-send-email-avienamo@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/07/18 12:53, Aapo Vienamo wrote:
> From: Peter De-Schrijver <pdeschrijver@nvidia.com>
> 
> These clocks have low jitter paths to certain parents. To model these
> correctly, use the sdmmc mux divider clock type.
> 
> Signed-off-by: Peter De-Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  drivers/clk/tegra/clk-id.h           |  2 --
>  drivers/clk/tegra/clk-tegra-periph.c | 11 -----------
>  drivers/clk/tegra/clk-tegra210.c     | 14 ++++++++++++--
>  3 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-id.h b/drivers/clk/tegra/clk-id.h
> index b616e33..de466b4 100644
> --- a/drivers/clk/tegra/clk-id.h
> +++ b/drivers/clk/tegra/clk-id.h
> @@ -227,13 +227,11 @@ enum clk_id {
>  	tegra_clk_sdmmc1_9,
>  	tegra_clk_sdmmc2,
>  	tegra_clk_sdmmc2_8,
> -	tegra_clk_sdmmc2_9,
>  	tegra_clk_sdmmc3,
>  	tegra_clk_sdmmc3_8,
>  	tegra_clk_sdmmc3_9,
>  	tegra_clk_sdmmc4,
>  	tegra_clk_sdmmc4_8,
> -	tegra_clk_sdmmc4_9,
>  	tegra_clk_se,
>  	tegra_clk_soc_therm,
>  	tegra_clk_soc_therm_8,
> diff --git a/drivers/clk/tegra/clk-tegra-periph.c b/drivers/clk/tegra/clk-tegra-periph.c
> index 2acba29..38c4eb2 100644
> --- a/drivers/clk/tegra/clk-tegra-periph.c
> +++ b/drivers/clk/tegra/clk-tegra-periph.c
> @@ -451,15 +451,6 @@ static u32 mux_pllp_pllc4_out2_pllc4_out1_clkm_pllc4_out0_idx[] = {
>  	[0] = 0, [1] = 3, [2] = 4, [3] = 6, [4] = 7,
>  };
>  
> -static const char *mux_pllp_clkm_pllc4_out2_out1_out0_lj[] = {
> -	"pll_p",
> -	"pll_c4_out2", "pll_c4_out0",	/* LJ input */
> -	"pll_c4_out2", "pll_c4_out1",
> -	"pll_c4_out1",			/* LJ input */
> -	"clk_m", "pll_c4_out0"
> -};
> -#define mux_pllp_clkm_pllc4_out2_out1_out0_lj_idx NULL
> -
>  static const char *mux_pllp_pllc2_c_c3_clkm[] = {
>  	"pll_p", "pll_c2", "pll_c", "pll_c3", "clk_m"
>  };
> @@ -686,9 +677,7 @@ static struct tegra_periph_init_data periph_clks[] = {
>  	MUX("sdmmc3", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SDMMC3, 69, TEGRA_PERIPH_ON_APB, tegra_clk_sdmmc3),
>  	MUX("sdmmc4", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SDMMC4, 15, TEGRA_PERIPH_ON_APB, tegra_clk_sdmmc4),
>  	MUX8("sdmmc1", mux_pllp_pllc4_out2_pllc4_out1_clkm_pllc4_out0, CLK_SOURCE_SDMMC1, 14, TEGRA_PERIPH_ON_APB, tegra_clk_sdmmc1_9),
> -	MUX8("sdmmc2", mux_pllp_clkm_pllc4_out2_out1_out0_lj, CLK_SOURCE_SDMMC2, 9, TEGRA_PERIPH_ON_APB, tegra_clk_sdmmc2_9),
>  	MUX8("sdmmc3", mux_pllp_pllc4_out2_pllc4_out1_clkm_pllc4_out0, CLK_SOURCE_SDMMC3, 69, TEGRA_PERIPH_ON_APB, tegra_clk_sdmmc3_9),
> -	MUX8("sdmmc4", mux_pllp_clkm_pllc4_out2_out1_out0_lj, CLK_SOURCE_SDMMC4, 15, TEGRA_PERIPH_ON_APB, tegra_clk_sdmmc4_9),
>  	MUX("la", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_LA, 76, TEGRA_PERIPH_ON_APB, tegra_clk_la),
>  	MUX("trace", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_TRACE, 77, TEGRA_PERIPH_ON_APB, tegra_clk_trace),
>  	MUX("owr", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_OWR, 71, TEGRA_PERIPH_ON_APB, tegra_clk_owr),
> diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
> index 5435d01..9eb1cb1 100644
> --- a/drivers/clk/tegra/clk-tegra210.c
> +++ b/drivers/clk/tegra/clk-tegra210.c
> @@ -44,6 +44,8 @@
>  #define CLK_SOURCE_EMC 0x19c
>  #define CLK_SOURCE_SOR1 0x410
>  #define CLK_SOURCE_LA 0x1f8
> +#define CLK_SOURCE_SDMMC2 0x154
> +#define CLK_SOURCE_SDMMC4 0x164
>  
>  #define PLLC_BASE 0x80
>  #define PLLC_OUT 0x84
> @@ -2286,11 +2288,9 @@ static struct tegra_clk tegra210_clks[tegra_clk_max] __initdata = {
>  	[tegra_clk_rtc] = { .dt_id = TEGRA210_CLK_RTC, .present = true },
>  	[tegra_clk_timer] = { .dt_id = TEGRA210_CLK_TIMER, .present = true },
>  	[tegra_clk_uarta_8] = { .dt_id = TEGRA210_CLK_UARTA, .present = true },
> -	[tegra_clk_sdmmc2_9] = { .dt_id = TEGRA210_CLK_SDMMC2, .present = true },
>  	[tegra_clk_i2s1] = { .dt_id = TEGRA210_CLK_I2S1, .present = true },
>  	[tegra_clk_i2c1] = { .dt_id = TEGRA210_CLK_I2C1, .present = true },
>  	[tegra_clk_sdmmc1_9] = { .dt_id = TEGRA210_CLK_SDMMC1, .present = true },
> -	[tegra_clk_sdmmc4_9] = { .dt_id = TEGRA210_CLK_SDMMC4, .present = true },
>  	[tegra_clk_pwm] = { .dt_id = TEGRA210_CLK_PWM, .present = true },
>  	[tegra_clk_i2s2] = { .dt_id = TEGRA210_CLK_I2S2, .present = true },
>  	[tegra_clk_usbd] = { .dt_id = TEGRA210_CLK_USBD, .present = true },
> @@ -3030,6 +3030,16 @@ static __init void tegra210_periph_clk_init(void __iomem *clk_base,
>  				0, NULL);
>  	clks[TEGRA210_CLK_ACLK] = clk;
>  
> +	clk = tegra_clk_register_sdmmc_mux_div("sdmmc2", clk_base,
> +					    CLK_SOURCE_SDMMC2, 9,
> +					    TEGRA_DIVIDER_ROUND_UP, 0, NULL);
> +	clks[TEGRA210_CLK_SDMMC2] = clk;
> +
> +	clk = tegra_clk_register_sdmmc_mux_div("sdmmc4", clk_base,
> +					    CLK_SOURCE_SDMMC4, 15,
> +					    TEGRA_DIVIDER_ROUND_UP, 0, NULL);
> +	clks[TEGRA210_CLK_SDMMC4] = clk;
> +

Peter, do we need to check for an error here before populating the pointer
returned?

Cheers
Jon

-- 
nvpublic
