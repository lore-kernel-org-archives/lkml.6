Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E83ECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282C420673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OHc5zwgy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eed81UHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282C420673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbeGSA7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 20:59:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59712 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbeGSA7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 20:59:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 320B960B1E; Thu, 19 Jul 2018 00:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531959554;
        bh=nZMy+Fi5BYHXOTKc0bB8B/Xvay038TFV+xLot/J5xso=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OHc5zwgyH48m7Gh/24Cu7Wbgsl1OcxSTZP2j5qogqC+IA1e4SUpUBZCSRldIqvOkQ
         c6VSkbduk4SlkZpb/u16V7z2EUEmOpTaYnc5qzaRsu8ugR3zivWkYIda+1n2f+XoqC
         sNGhf3/6h6JHT9zj5tMXunAt1b3/9LyBG3pD4CUc=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 23955606DB;
        Thu, 19 Jul 2018 00:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531959553;
        bh=nZMy+Fi5BYHXOTKc0bB8B/Xvay038TFV+xLot/J5xso=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eed81UHMDzAduxJpVSM2ZhdO4QSr48YbSskQuSCDzYSc5b4el5kQAQ4g9P7kr6GzM
         CBUaYNr2VLLSeJVob+lesr4EezK+hfOOuT4S0+JhDCzbwiFaK69CG91MA7P/tqEO/s
         uYPdzPP61MZOk6MZDI/nZWogN2LNT9edYO4IUd4A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Jul 2018 17:19:13 -0700
From:   grahamr@codeaurora.org
To:     Douglas Anderson <dianders@chromium.org>
Cc:     sboyd@kernel.org, andy.gross@linaro.org, tdas@codeaurora.org,
        girishm@codeaurora.org, anischal@codeaurora.org,
        bjorn.andersson@linaro.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-clk-owner@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] clk: qcom: Add qspi (Quad SPI) clocks for sdm845
In-Reply-To: <20180718180431.48580-3-dianders@chromium.org>
References: <20180718180431.48580-1-dianders@chromium.org>
 <20180718180431.48580-3-dianders@chromium.org>
Message-ID: <e661adac8af569454ebd4a710bfc58bf@codeaurora.org>
X-Sender: grahamr@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-18 11:04, Douglas Anderson wrote:
> Add both the interface and core clock.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/clk/qcom/gcc-sdm845.c | 73 +++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-sdm845.c 
> b/drivers/clk/qcom/gcc-sdm845.c
> index 0f694ed4238a..2ee96f9bc217 100644
> --- a/drivers/clk/qcom/gcc-sdm845.c
> +++ b/drivers/clk/qcom/gcc-sdm845.c
> @@ -162,6 +162,20 @@ static const char * const gcc_parent_names_10[] = 
> {
>  	"core_bi_pll_test_se",
>  };
> 
> +static const struct parent_map gcc_parent_map_9[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GPLL0_OUT_MAIN, 1 },
> +	{ P_GPLL0_OUT_EVEN, 6 },
> +	{ P_SLEEP_CLK, 7 },
> +};
> +
> +static const char * const gcc_parent_names_9[] = {
> +	"bi_tcxo",
> +	"gpll0",
> +	"gpll0_out_even",
> +	"core_pi_sleep_clk",
> +};
> +
>  static struct clk_alpha_pll gpll0 = {
>  	.offset = 0x0,
>  	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
> @@ -358,6 +372,31 @@ static struct clk_rcg2 gcc_pcie_phy_refgen_clk_src 
> = {
>  	},
>  };
> 
> +static const struct freq_tbl ftbl_gcc_qspi_core_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
> +	F(75000000, P_GPLL0_OUT_EVEN, 4, 0, 0),
> +	F(100000000, P_GPLL0_OUT_EVEN, 3, 0, 0),
> +	F(150000000, P_GPLL0_OUT_EVEN, 2, 0, 0),
> +	F(300000000, P_GPLL0_OUT_EVEN, 1, 0, 0),
> +	F(400000000, P_GPLL0_OUT_MAIN, 1.5, 0, 0),
> +	{ }
> +};

Doug,

400 MHz is beyond the maximum frequency for the QSPI core, which is 300 
MHz.  The complete frequency table with required voltage corner is:
MinSVS@19.2
LowSVS@75
SVS@150
Nominal@300
You can run at intermediate frequencies less than 300 if required by the 
QSPI driver - i.e. the other entries you have are fine.
FYI, Qualcomm does not support QSPI internally on SDM845 which is why 
this code does not exist.

Regards,

Graham Roff


> +
> +static struct clk_rcg2 gcc_qspi_core_clk_src = {
> +	.cmd_rcgr = 0x4b008,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_9,
> +	.freq_tbl = ftbl_gcc_qspi_core_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gcc_qspi_core_clk_src",
> +		.parent_names = gcc_parent_names_9,
> +		.num_parents = 4,
> +		.ops = &clk_rcg2_floor_ops,
> +	},
> +};
> +
>  static const struct freq_tbl ftbl_gcc_pdm2_clk_src[] = {
>  	F(9600000, P_BI_TCXO, 2, 0, 0),
>  	F(19200000, P_BI_TCXO, 1, 0, 0),
> @@ -1935,6 +1974,37 @@ static struct clk_branch gcc_qmip_video_ahb_clk 
> = {
>  	},
>  };
> 
> +static struct clk_branch gcc_qspi_cnoc_periph_ahb_clk = {
> +	.halt_reg = 0x4b000,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x4b000,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_qspi_cnoc_periph_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qspi_core_clk = {
> +	.halt_reg = 0x4b004,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x4b004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_qspi_core_clk",
> +			.parent_names = (const char *[]){
> +				"gcc_qspi_core_clk_src",
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
>  static struct clk_branch gcc_qupv3_wrap0_s0_clk = {
>  	.halt_reg = 0x17030,
>  	.halt_check = BRANCH_HALT_VOTED,
> @@ -3383,6 +3453,9 @@ static struct clk_regmap *gcc_sdm845_clocks[] = {
>  	[GPLL4] = &gpll4.clkr,
>  	[GCC_CPUSS_DVM_BUS_CLK] = &gcc_cpuss_dvm_bus_clk.clkr,
>  	[GCC_CPUSS_GNOC_CLK] = &gcc_cpuss_gnoc_clk.clkr,
> +	[GCC_QSPI_CORE_CLK_SRC] = &gcc_qspi_core_clk_src.clkr,
> +	[GCC_QSPI_CORE_CLK] = &gcc_qspi_core_clk.clkr,
> +	[GCC_QSPI_CNOC_PERIPH_AHB_CLK] = &gcc_qspi_cnoc_periph_ahb_clk.clkr,
>  };
> 
>  static const struct qcom_reset_map gcc_sdm845_resets[] = {
