Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4F5C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C87C256CE
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="p7rd7M5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C87C256CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754699AbeFYJcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:32:15 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42328 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbeFYJcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:32:13 -0400
Received: by mail-wr0-f194.google.com with SMTP id w10-v6so12913966wrk.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 02:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=93J91QxsRn6UdWIiibKE88EwPvh0PhZbn39aIK/Oca0=;
        b=p7rd7M5oIUDfcaKHfVUpzD4mhQ+qSH4uoi86d7G0mkGeQmLY572+eFLbduQvOfipx9
         lLVZs+f4jUFV92oCoqe4J/HX+0EiCzV5nuTlXM212YLuxW2vZ2txjmQVUy39zp3sLJoz
         6+Jbbkjil8MNJ+K81xYj/SUbm83Q41IrSWxjkUjYQLD/l2wKB/yCPfShhOkTga148GAX
         7O/TJW8dY/aiww6xMXufDvGaQRNxRtUvLnwWHbgSZwJx6zltzoy4DROkLEQPgP11fLWQ
         rfsrO4DtjrP+KrjbCSu6ngZuBko68R2Lq5Nxhdw8v0WpQCj9nq1nAUK0KTI/ScFhGjmE
         YCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=93J91QxsRn6UdWIiibKE88EwPvh0PhZbn39aIK/Oca0=;
        b=oSMJjxySh1g6plTQRPPaMSDQ+/V+NJ3qI0lMuNG9QrbLOQiQg/lOTL2t7DatL7etjA
         6mHj7KO2ZrqySVX7tWCyf7S2tiBbJh8l/tlW80y7bUEVQRpzCmwO7MyemjPU6YezXKII
         /wMj57CeW0izsyenM1HYJ1Ng9y+EbJKCCF/HHtONzV3ibjiJ6k/HTeiKMWA2Q/URJrnT
         J+2Tn4ewYGxa17fuofNIV7qROfKogCkU78wfT7f76rNT1A/xeg7RtS5TvHa/RJc4trW+
         5jC9C3+ymEGaYOp8+656Ee+oohKNmRhko9yPoLmRzJWfyzOhzYAoYRDjznTN0Fjnj8sG
         trug==
X-Gm-Message-State: APt69E34EuLOmdX/jCwRyCuDG3lHEmR4qwwYDJXTgkwDdk/0VIMPoOy4
        5MGgnUEYRzkldsrYf/L42piMkg==
X-Google-Smtp-Source: AAOMgpfXemmtRfd+AFoZYNWVowI46eI4U3MXAX4Myi736q51ao+r685x+cUIkUUEk4iO5Qv1vFDsRw==
X-Received: by 2002:adf:9102:: with SMTP id j2-v6mr6143952wrj.57.1529919132019;
        Mon, 25 Jun 2018 02:32:12 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f133-v6sm8145820wme.42.2018.06.25.02.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 02:32:11 -0700 (PDT)
Message-ID: <1529919130.2900.22.camel@baylibre.com>
Subject: Re: [PATCH] clk: meson-axg: add clocks required by pcie driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Qin <jianxin.qin@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 Jun 2018 11:32:10 +0200
In-Reply-To: <20180621122620.13195-1-yixun.lan@amlogic.com>
References: <20180621122620.13195-1-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-21 at 12:26 +0000, Yixun Lan wrote:
> Adding clocks for pcie driver, due to the ASIC design,
Adding clocks for the pcie driver. Due to the ASIC design,

> the pcie controller re-use part of the mipi clock logic,
> so the mipi clock is also required.
> 
> Tested-by: Jianxin Qin <jianxin.qin@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  drivers/clk/meson/axg.c              | 145 +++++++++++++++++++++++++++
>  drivers/clk/meson/axg.h              |   6 +-
>  include/dt-bindings/clock/axg-clkc.h |   3 +
>  3 files changed, 153 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> index bd4dbc696b88..f1dc5433b69d 100644
> --- a/drivers/clk/meson/axg.c
> +++ b/drivers/clk/meson/axg.c
> @@ -626,6 +626,137 @@ static struct clk_regmap axg_mpll3 = {
>  	},
>  };
>  
> +static const struct pll_rate_table axg_pcie_pll_rate_table[] = {
> +	{
> +		.rate	= 100000000,
> +		.m	= 200,
> +		.n	= 3,
> +		.od	= 1,
> +		.od2	= 3,
> +	},
> +	{ /* sentinel */ },
> +};
> +
> +static const struct reg_sequence axg_pcie_init_regs[] = {
> +	{ .reg = HHI_PCIE_PLL_CNTL,	.def = 0x400106c8 },
> +	{ .reg = HHI_PCIE_PLL_CNTL1,	.def = 0x0084a2aa },
> +	{ .reg = HHI_PCIE_PLL_CNTL2,	.def = 0xb75020be },
> +	{ .reg = HHI_PCIE_PLL_CNTL3,	.def = 0x0a47488e },
> +	{ .reg = HHI_PCIE_PLL_CNTL4,	.def = 0xc000004d },
> +	{ .reg = HHI_PCIE_PLL_CNTL5,	.def = 0x00078000 },
> +	{ .reg = HHI_PCIE_PLL_CNTL6,	.def = 0x002323c6 },
> +};
> +
> +static struct clk_regmap axg_pcie_pll = {
> +	.data = &(struct meson_clk_pll_data){
> +		.m = {
> +			.reg_off = HHI_PCIE_PLL_CNTL,
> +			.shift   = 0,
> +			.width   = 9,
> +		},
> +		.n = {
> +			.reg_off = HHI_PCIE_PLL_CNTL,
> +			.shift   = 9,
> +			.width   = 5,
> +		},
> +		.od = {
> +			.reg_off = HHI_PCIE_PLL_CNTL,
> +			.shift   = 16,
> +			.width   = 2,
> +		},
> +		.od2 = {
> +			.reg_off = HHI_PCIE_PLL_CNTL6,
> +			.shift   = 6,
> +			.width   = 2,
> +		},
> +		.frac = {
> +			.reg_off = HHI_PCIE_PLL_CNTL1,
> +			.shift   = 0,
> +			.width   = 12,
> +		},
> +		.l = {
> +			.reg_off = HHI_PCIE_PLL_CNTL,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = HHI_PCIE_PLL_CNTL,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +		.table = axg_pcie_pll_rate_table,
> +		.init_regs = axg_pcie_init_regs,
> +		.init_count = ARRAY_SIZE(axg_pcie_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pcie_pll",
> +		.ops = &meson_clk_pll_ops,
> +		.parent_names = (const char *[]){ "xtal" },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap axg_pcie_mux = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_PCIE_PLL_CNTL6,
> +		.mask = 0x1,
> +		.shift = 2,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pcie_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_names = (const char *[]){ "mpll3", "pcie_pll" },
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap axg_pcie_ref = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_PCIE_PLL_CNTL6,
> +		.mask = 0x1,
> +		.shift = 1,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pcie_ref",
> +		.ops = &clk_regmap_mux_ops,
> +		/* do not select the first partent, debug only */
> +		.parent_names = (const char *[]){ "",
> +			"pcie_mux" },

A) No declaring a clock name "" is not the way to do it.

Either declare a mux with just one parent and provide a table with the index of
the said parent (have a look around, other clocks mux are using table), OR just
declare what parent 0 is.

Looking at your clock, the pcie driver will have to call
clk_set_rate(clk, 100000000) to make sure everything is setup properly,
including this mux - otherwise you are relying on the setting provided by the
bootloader, which should be avoided whenever possible.

In this case, CCF should pick the right parent anyway, so there should be no
harm describing what your clock tree is.

B) Please fix the indentation.

C) This mux deal with bit "CML_INPUT_SEL0". there is also a "CML_INPUT_SEL1"
which seems to hint that there is a mux each CML_EN clock. Are you sure your
description of the tree is accurate ?

> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap axg_pcie_cml_en0 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_PCIE_PLL_CNTL6,
> +		.bit_idx = 4,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "pcie_cml_en0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_names = (const char *[]){ "pcie_ref" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +
> +	},
> +};
> +
> +static struct clk_regmap axg_pcie_cml_en1 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_PCIE_PLL_CNTL6,
> +		.bit_idx = 3,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "pcie_cml_en1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_names = (const char *[]){ "pcie_ref" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
>  static u32 mux_table_clk81[]	= { 0, 2, 3, 4, 5, 6, 7 };
>  static const char * const clk81_parent_names[] = {
>  	"xtal", "fclk_div7", "mpll1", "mpll2", "fclk_div4",
> @@ -821,6 +952,7 @@ static MESON_GATE(axg_mmc_pclk, HHI_GCLK_MPEG2, 11);
>  static MESON_GATE(axg_vpu_intr, HHI_GCLK_MPEG2, 25);
>  static MESON_GATE(axg_sec_ahb_ahb3_bridge, HHI_GCLK_MPEG2, 26);
>  static MESON_GATE(axg_gic, HHI_GCLK_MPEG2, 30);
> +static MESON_GATE(axg_mipi_enable, HHI_MIPI_CNTL0, 29);
>  
>  /* Always On (AO) domain gates */
>  
> @@ -910,6 +1042,13 @@ static struct clk_hw_onecell_data axg_hw_onecell_data = {
>  		[CLKID_FCLK_DIV4_DIV]		= &axg_fclk_div4_div.hw,
>  		[CLKID_FCLK_DIV5_DIV]		= &axg_fclk_div5_div.hw,
>  		[CLKID_FCLK_DIV7_DIV]		= &axg_fclk_div7_div.hw,
> +		[CLKID_PCIE_PLL]		= &axg_pcie_pll.hw,
> +		[CLKID_PCIE_MUX]		= &axg_pcie_mux.hw,
> +		[CLKID_PCIE_REF]		= &axg_pcie_ref.hw,
> +		[CLKID_PCIE_CML_EN0]		= &axg_pcie_cml_en0.hw,
> +		[CLKID_PCIE_CML_EN1]		= &axg_pcie_cml_en1.hw,
> +		[CLKID_MIPI_ENABLE]		= &axg_mipi_enable.hw,
> +
>  		[NR_CLKS]			= NULL,
>  	},
>  	.num = NR_CLKS,
> @@ -988,6 +1127,12 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
>  	&axg_fclk_div4,
>  	&axg_fclk_div5,
>  	&axg_fclk_div7,
> +	&axg_pcie_pll,
> +	&axg_pcie_mux,
> +	&axg_pcie_ref,
> +	&axg_pcie_cml_en0,
> +	&axg_pcie_cml_en1,
> +	&axg_mipi_enable,
>  };
>  
>  static const struct of_device_id clkc_match_table[] = {
> diff --git a/drivers/clk/meson/axg.h b/drivers/clk/meson/axg.h
> index b421df6a7ea0..6e55ebd6c77d 100644
> --- a/drivers/clk/meson/axg.h
> +++ b/drivers/clk/meson/axg.h
> @@ -16,6 +16,7 @@
>   * Register offsets from the data sheet must be multiplied by 4 before
>   * adding them to the base address to get the right value.
>   */
> +#define HHI_MIPI_CNTL0			0x00
>  #define HHI_GP0_PLL_CNTL		0x40
>  #define HHI_GP0_PLL_CNTL2		0x44
>  #define HHI_GP0_PLL_CNTL3		0x48
> @@ -127,8 +128,11 @@
>  #define CLKID_FCLK_DIV4_DIV			73
>  #define CLKID_FCLK_DIV5_DIV			74
>  #define CLKID_FCLK_DIV7_DIV			75
> +#define CLKID_PCIE_PLL				76
> +#define CLKID_PCIE_MUX				77
> +#define CLKID_PCIE_REF				78
>  
> -#define NR_CLKS					76
> +#define NR_CLKS					82
>  
>  /* include the CLKIDs that have been made part of the DT binding */
>  #include <dt-bindings/clock/axg-clkc.h>
> diff --git a/include/dt-bindings/clock/axg-clkc.h b/include/dt-bindings/clock/axg-clkc.h
> index 555937a25504..70371228b7e0 100644
> --- a/include/dt-bindings/clock/axg-clkc.h
> +++ b/include/dt-bindings/clock/axg-clkc.h

As usual, please put dt bindings changes in a separate patch.

> @@ -68,5 +68,8 @@
>  #define CLKID_SD_EMMC_B_CLK0			59
>  #define CLKID_SD_EMMC_C_CLK0			60
>  #define CLKID_HIFI_PLL				69
> +#define CLKID_PCIE_CML_EN0			79
> +#define CLKID_PCIE_CML_EN1			80
> +#define CLKID_MIPI_ENABLE			81
>  
>  #endif /* __AXG_CLKC_H */

