Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB5CC04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61232080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VmDfLxKj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ERB6r/oq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61232080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbeKTHQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:16:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48764 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730797AbeKTHQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:16:30 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A1F9A60767; Mon, 19 Nov 2018 20:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542660665;
        bh=Tvedk6gG6j/+vMjsnmAh0ulWCXTZ3/NRUAJbsYpIOv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VmDfLxKjP8CcQhiDVbhZQD+mVZbrbnuzZz0JDXbJsDnj9BCmmzHk0IC8AqZqKqKrc
         DfTPT0U1buIoEZ/JoJ/c59yTPjnDL6XiuifkdpK5sCs6X9+J1TIYwQS5WhxL8HnAnG
         2DUVrUove7bmpw3+LGC1GJslArWjVIB+inTBE6gg=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B38A360767;
        Mon, 19 Nov 2018 20:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542660663;
        bh=Tvedk6gG6j/+vMjsnmAh0ulWCXTZ3/NRUAJbsYpIOv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ERB6r/oqWqp1QlFM0BrxNy0R9ACN0iYVN95xNlGXTXHbUstoyIJHAlW80L9xYEovE
         8GAQxxnO52wmxr5FZKTAIVOoBV20Nilxv7StJAqPwXJ+pdAnI6zgNOyk82n1Kk7611
         W75vVR6M3+g9VDOkopSPvHeDbFzXHzGdQxPamrao=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B38A360767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 19 Nov 2018 13:51:00 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Amit Nischal <anischal@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] clk: qcom: Add graphics clock controller driver
 for SDM845
Message-ID: <20181119205100.GB31792@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Amit Nischal <anischal@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1534141987-29601-1-git-send-email-anischal@codeaurora.org>
 <1534141987-29601-5-git-send-email-anischal@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534141987-29601-5-git-send-email-anischal@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 12:03:07PM +0530, Amit Nischal wrote:
> Add support for the graphics clock controller found on SDM845
> based devices. This would allow graphics drivers to probe and
> control their clocks.
> 
> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> ---
>  drivers/clk/qcom/Kconfig        |   9 +
>  drivers/clk/qcom/Makefile       |   1 +
>  drivers/clk/qcom/gpucc-sdm845.c | 438 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 448 insertions(+)
>  create mode 100644 drivers/clk/qcom/gpucc-sdm845.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 0647686..1595464 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -244,6 +244,15 @@ config SDM_GCC_845
>  	  Say Y if you want to use peripheral devices such as UART, SPI,
>  	  i2C, USB, UFS, SDDC, PCIe, etc.
>  
> +config SDM_GPUCC_845
> +	tristate "SDM845 Graphics Clock Controller"
> +	depends on COMMON_CLK_QCOM
> +	select SDM_GCC_845
> +	help
> +	  Support for the graphics clock controller on SDM845 devices.
> +	  Say Y if you want to support graphics controller devices and
> +	  functionality such as 3D graphics.
> +
>  config SDM_VIDEOCC_845
>  	tristate "SDM845 Video Clock Controller"
>  	depends on COMMON_CLK_QCOM
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index c4ed36f..93c1089 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -42,5 +42,6 @@ obj-$(CONFIG_QCOM_CLK_RPMH) += clk-rpmh.o
>  obj-$(CONFIG_QCOM_CLK_SMD_RPM) += clk-smd-rpm.o
>  obj-$(CONFIG_SDM_DISPCC_845) += dispcc-sdm845.o
>  obj-$(CONFIG_SDM_GCC_845) += gcc-sdm845.o
> +obj-$(CONFIG_SDM_GPUCC_845) += gpucc-sdm845.o
>  obj-$(CONFIG_SDM_VIDEOCC_845) += videocc-sdm845.o
>  obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
> diff --git a/drivers/clk/qcom/gpucc-sdm845.c b/drivers/clk/qcom/gpucc-sdm845.c
> new file mode 100644
> index 0000000..7a11b70
> --- /dev/null
> +++ b/drivers/clk/qcom/gpucc-sdm845.c
> @@ -0,0 +1,438 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,gpucc-sdm845.h>
> +
> +#include "common.h"
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-pll.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "gdsc.h"
> +
> +#define CX_GMU_CBCR_SLEEP_MASK		0xf
> +#define CX_GMU_CBCR_SLEEP_SHIFT		4
> +#define CX_GMU_CBCR_WAKE_MASK		0xf
> +#define CX_GMU_CBCR_WAKE_SHIFT		8
> +#define CLK_DIS_WAIT_SHIFT		12
> +#define CLK_DIS_WAIT_MASK		(0xf << CLK_DIS_WAIT_SHIFT)
> +
> +enum {
> +	P_BI_TCXO,
> +	P_CORE_BI_PLL_TEST_SE,
> +	P_GPLL0_OUT_MAIN,
> +	P_GPLL0_OUT_MAIN_DIV,
> +	P_GPU_CC_PLL0_OUT_EVEN,
> +	P_GPU_CC_PLL0_OUT_MAIN,
> +	P_GPU_CC_PLL0_OUT_ODD,
> +	P_GPU_CC_PLL1_OUT_EVEN,
> +	P_GPU_CC_PLL1_OUT_MAIN,
> +	P_GPU_CC_PLL1_OUT_ODD,
> +};
> +
> +static const struct parent_map gpu_cc_parent_map_0[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GPU_CC_PLL0_OUT_MAIN, 1 },
> +	{ P_GPU_CC_PLL1_OUT_MAIN, 3 },
> +	{ P_GPLL0_OUT_MAIN, 5 },
> +	{ P_GPLL0_OUT_MAIN_DIV, 6 },
> +	{ P_CORE_BI_PLL_TEST_SE, 7 },
> +};
> +
> +static const char * const gpu_cc_parent_names_0[] = {
> +	"bi_tcxo",
> +	"gpu_cc_pll0",
> +	"gpu_cc_pll1",
> +	"gcc_gpu_gpll0_clk_src",
> +	"gcc_gpu_gpll0_div_clk_src",
> +	"core_bi_pll_test_se",
> +};
> +
> +static const struct parent_map gpu_cc_parent_map_1[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GPU_CC_PLL0_OUT_EVEN, 1 },
> +	{ P_GPU_CC_PLL0_OUT_ODD, 2 },
> +	{ P_GPU_CC_PLL1_OUT_EVEN, 3 },
> +	{ P_GPU_CC_PLL1_OUT_ODD, 4 },
> +	{ P_GPLL0_OUT_MAIN, 5 },
> +	{ P_CORE_BI_PLL_TEST_SE, 7 },
> +};
> +
> +static const char * const gpu_cc_parent_names_1[] = {
> +	"bi_tcxo",
> +	"gpu_cc_pll0_out_even",
> +	"gpu_cc_pll0_out_odd",
> +	"gpu_cc_pll1_out_even",
> +	"gpu_cc_pll1_out_odd",
> +	"gcc_gpu_gpll0_clk_src",
> +	"core_bi_pll_test_se",
> +};
> +
> +static const struct alpha_pll_config gpu_cc_pll0_config = {
> +	.l = 0x1d,
> +	.alpha = 0x2aaa,
> +};
> +
> +static const struct alpha_pll_config gpu_cc_pll1_config = {
> +	.l = 0x1a,
> +	.alpha = 0xaab,
> +};
> +
> +static struct clk_alpha_pll gpu_cc_pll0 = {
> +	.offset = 0x0,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
> +	.clkr = {
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_pll0",
> +			.parent_names = (const char *[]){ "bi_tcxo" },
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_fabia_ops,
> +		},
> +	},
> +};
> +
> +static const struct clk_div_table post_div_table_fabia_even[] = {
> +	{ 0x0, 1 },
> +};
> +
> +static struct clk_alpha_pll_postdiv gpu_cc_pll0_out_even = {
> +	.offset = 0x0,
> +	.post_div_shift = 8,
> +	.post_div_table = post_div_table_fabia_even,
> +	.num_post_div = ARRAY_SIZE(post_div_table_fabia_even),
> +	.width = 4,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gpu_cc_pll0_out_even",
> +		.parent_names = (const char *[]){ "gpu_cc_pll0" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_alpha_pll_postdiv_fabia_ops,
> +	},
> +};
> +
> +static struct clk_alpha_pll gpu_cc_pll1 = {
> +	.offset = 0x100,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
> +	.clkr = {
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_pll1",
> +			.parent_names = (const char *[]){ "bi_tcxo" },
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_fabia_ops,
> +		},
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gpu_cc_gmu_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(200000000, P_GPLL0_OUT_MAIN_DIV, 1.5, 0, 0),
> +	F(500000000, P_GPU_CC_PLL1_OUT_MAIN, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gpu_cc_gmu_clk_src = {
> +	.cmd_rcgr = 0x1120,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gpu_cc_parent_map_0,
> +	.freq_tbl = ftbl_gpu_cc_gmu_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gpu_cc_gmu_clk_src",
> +		.parent_names = gpu_cc_parent_names_0,
> +		.num_parents = 6,
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gpu_cc_gx_gfx3d_clk_src = {
> +	.cmd_rcgr = 0x101c,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gpu_cc_parent_map_1,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gpu_cc_gx_gfx3d_clk_src",
> +		.parent_names = gpu_cc_parent_names_1,
> +		.num_parents = 7,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_gfx3d_ops,
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_crc_ahb_clk = {
> +	.halt_reg = 0x107c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x107c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_crc_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_apb_clk = {
> +	.halt_reg = 0x1088,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x1088,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_apb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_gfx3d_clk = {
> +	.halt_reg = 0x10a4,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x10a4,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_gfx3d_clk",
> +			.parent_names = (const char *[]){
> +				"gpu_cc_gx_gfx3d_clk_src",
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_gfx3d_slv_clk = {
> +	.halt_reg = 0x10a8,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x10a8,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_gfx3d_slv_clk",
> +			.parent_names = (const char *[]){
> +				"gpu_cc_gx_gfx3d_clk_src",
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_gmu_clk = {
> +	.halt_reg = 0x1098,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x1098,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_gmu_clk",
> +			.parent_names = (const char *[]){
> +				"gpu_cc_gmu_clk_src",
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_snoc_dvm_clk = {
> +	.halt_reg = 0x108c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x108c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_snoc_dvm_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cxo_clk = {
> +	.halt_reg = 0x109c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x109c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cxo_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_gx_gfx3d_clk = {
> +	.halt_reg = 0x1054,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x1054,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_gx_gfx3d_clk",
> +			.parent_names = (const char *[]){
> +				"gpu_cc_gx_gfx3d_clk_src",
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_gx_gmu_clk = {
> +	.halt_reg = 0x1064,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x1064,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_gx_gmu_clk",
> +			.parent_names = (const char *[]){
> +				"gpu_cc_gmu_clk_src",
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct gdsc gpu_cx_gdsc = {
> +	.gdscr = 0x106c,
> +	.gds_hw_ctrl = 0x1540,
> +	.pd = {
> +		.name = "gpu_cx_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = VOTABLE,
> +};
> +
> +static struct gdsc gpu_gx_gdsc = {
> +	.gdscr = 0x100c,
> +	.clamp_io_ctrl = 0x1508,
> +	.pd = {
> +		.name = "gpu_gx_gdsc",
> +	},
> +	.clk_hws = {
> +		&gpu_cc_gx_gfx3d_clk_src.clkr.hw,
> +	},
> +	.clk_count = 1,

So from my perspective, this isn't needed - it at least seems that if the CX
domain is still enabled that I can safely toggle this gdsc off even if these
clocks are not defined. Full disclosure, my experiment has the "enable" hacked
out so its possible that might have needed this in some past life but from what
I can tell we won't need it upstream.

> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = CLAMP_IO | AON_RESET | POLL_CFG_GDSCR,
> +};
> +
> +static struct clk_regmap *gpu_cc_sdm845_clocks[] = {
> +	[GPU_CC_CRC_AHB_CLK] = &gpu_cc_crc_ahb_clk.clkr,

It does not appear that we control this clock from the CPU.

> +	[GPU_CC_CX_APB_CLK] = &gpu_cc_cx_apb_clk.clkr,

Same.

> +	[GPU_CC_CX_GFX3D_CLK] = &gpu_cc_cx_gfx3d_clk.clkr,

Same.

> +	[GPU_CC_CX_GFX3D_SLV_CLK] = &gpu_cc_cx_gfx3d_slv_clk.clkr,

Same.

> +	[GPU_CC_CX_GMU_CLK] = &gpu_cc_cx_gmu_clk.clkr,
> +	[GPU_CC_CX_SNOC_DVM_CLK] = &gpu_cc_cx_snoc_dvm_clk.clkr,

Same.

> +	[GPU_CC_CXO_CLK] = &gpu_cc_cxo_clk.clkr,
> +	[GPU_CC_GMU_CLK_SRC] = &gpu_cc_gmu_clk_src.clkr,
> +	[GPU_CC_GX_GMU_CLK] = &gpu_cc_gx_gmu_clk.clkr,

Same.

> +	[GPU_CC_GX_GFX3D_CLK_SRC] = &gpu_cc_gx_gfx3d_clk_src.clkr,
> +	[GPU_CC_GX_GFX3D_CLK] = &gpu_cc_gx_gfx3d_clk.clkr,

With the discussion above, these are no longer used.

> +	[GPU_CC_PLL0] = &gpu_cc_pll0.clkr,
> +	[GPU_CC_PLL0_OUT_EVEN] = &gpu_cc_pll0_out_even.clkr,

If GX_GFX3D goes away, this can too.

> +	[GPU_CC_PLL1] = &gpu_cc_pll1.clkr,
> +};
> +
> +static struct gdsc *gpu_cc_sdm845_gdscs[] = {
> +	[GPU_CX_GDSC] = &gpu_cx_gdsc,
> +	[GPU_GX_GDSC] = &gpu_gx_gdsc,
> +};
> +
> +static const struct regmap_config gpu_cc_sdm845_regmap_config = {
> +	.reg_bits	= 32,
> +	.reg_stride	= 4,
> +	.val_bits	= 32,
> +	.max_register	= 0x8008,
> +	.fast_io	= true,
> +};
> +
> +static const struct qcom_cc_desc gpu_cc_sdm845_desc = {
> +	.config = &gpu_cc_sdm845_regmap_config,
> +	.clks = gpu_cc_sdm845_clocks,
> +	.num_clks = ARRAY_SIZE(gpu_cc_sdm845_clocks),
> +	.gdscs = gpu_cc_sdm845_gdscs,
> +	.num_gdscs = ARRAY_SIZE(gpu_cc_sdm845_gdscs),
> +};
> +
> +static const struct of_device_id gpu_cc_sdm845_match_table[] = {
> +	{ .compatible = "qcom,sdm845-gpucc" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, gpu_cc_sdm845_match_table);
> +
> +static int gpu_cc_sdm845_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +	unsigned int value, mask;
> +	int ret;
> +
> +	regmap = qcom_cc_map(pdev, &gpu_cc_sdm845_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	clk_fabia_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
> +	clk_fabia_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
> +
> +	/*
> +	 * Configure gpu_cc_cx_gmu_clk with recommended
> +	 * wakeup/sleep settings
> +	 */
> +	mask = CX_GMU_CBCR_WAKE_MASK << CX_GMU_CBCR_WAKE_SHIFT;
> +	mask |= CX_GMU_CBCR_SLEEP_MASK << CX_GMU_CBCR_SLEEP_SHIFT;
> +	value = 0xf << CX_GMU_CBCR_WAKE_SHIFT | 0xf << CX_GMU_CBCR_SLEEP_SHIFT;
> +	regmap_update_bits(regmap, 0x1098, mask, value);
> +
> +	ret = qcom_cc_really_probe(pdev, &gpu_cc_sdm845_desc, regmap);
> +	if (ret)
> +		return ret;
> +
> +	/* Configure clk_dis_wait for gpu_cx_gdsc */
> +	regmap_update_bits(regmap, 0x106c, CLK_DIS_WAIT_MASK,
> +						8 << CLK_DIS_WAIT_SHIFT);
> +
> +	/* Set supported range of frequencies for gfx3d clock */
> +	clk_hw_set_rate_range(&gpu_cc_gx_gfx3d_clk_src.clkr.hw, 180000000,
> +								710000000);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver gpu_cc_sdm845_driver = {
> +	.probe = gpu_cc_sdm845_probe,
> +	.driver = {
> +		.name = "sdm845-gpucc",
> +		.of_match_table = gpu_cc_sdm845_match_table,
> +	},
> +};
> +
> +static int __init gpu_cc_sdm845_init(void)
> +{
> +	return platform_driver_register(&gpu_cc_sdm845_driver);
> +}
> +subsys_initcall(gpu_cc_sdm845_init);
> +
> +static void __exit gpu_cc_sdm845_exit(void)
> +{
> +	platform_driver_unregister(&gpu_cc_sdm845_driver);
> +}
> +module_exit(gpu_cc_sdm845_exit);
> +
> +MODULE_DESCRIPTION("QTI GPUCC SDM845 Driver");
> +MODULE_LICENSE("GPL v2");

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
