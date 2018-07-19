Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8224EC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC9E20693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gnyXNcET";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gnyXNcET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC9E20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbeGSLrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:47:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44886 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbeGSLrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:47:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BC4F5606DB; Thu, 19 Jul 2018 11:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531998296;
        bh=N17rsaQntn2BpjapzReUbaqnzBfTeF5Ygpq5Vl8MHpI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gnyXNcETEto2HbnugRv6hVljr3/050zVdGWJd7BLUJTVLOyeQlV4TCAsaYS89CBKl
         z57LqewGedNuAHR6OmF9KVKHbQosgrgW7nUR6i1qlv8WQfyvhVu7stjl9LTPMvHKyU
         sJ3yr13oZamF0XSQh5XbVg3r7LFvHVk750jdq7QE=
Received: from [10.4.34.47] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 598FF60131;
        Thu, 19 Jul 2018 11:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531998296;
        bh=N17rsaQntn2BpjapzReUbaqnzBfTeF5Ygpq5Vl8MHpI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gnyXNcETEto2HbnugRv6hVljr3/050zVdGWJd7BLUJTVLOyeQlV4TCAsaYS89CBKl
         z57LqewGedNuAHR6OmF9KVKHbQosgrgW7nUR6i1qlv8WQfyvhVu7stjl9LTPMvHKyU
         sJ3yr13oZamF0XSQh5XbVg3r7LFvHVk750jdq7QE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 598FF60131
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [RFC PATCH 2/2] clk: qcom: Add qspi (Quad SPI) clocks for sdm845
To:     Douglas Anderson <dianders@chromium.org>, sboyd@kernel.org,
        andy.gross@linaro.org
Cc:     girishm@codeaurora.org, anischal@codeaurora.org,
        bjorn.andersson@linaro.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org
References: <20180718180431.48580-1-dianders@chromium.org>
 <20180718180431.48580-3-dianders@chromium.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <6248e3cc-f458-7dec-143c-7d2aeccde590@codeaurora.org>
Date:   Thu, 19 Jul 2018 16:34:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718180431.48580-3-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Please find my comments inline.

On 7/18/2018 11:34 PM, Douglas Anderson wrote:
> Add both the interface and core clock.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   drivers/clk/qcom/gcc-sdm845.c | 73 +++++++++++++++++++++++++++++++++++
>   1 file changed, 73 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
> index 0f694ed4238a..2ee96f9bc217 100644
> --- a/drivers/clk/qcom/gcc-sdm845.c
> +++ b/drivers/clk/qcom/gcc-sdm845.c
> @@ -162,6 +162,20 @@ static const char * const gcc_parent_names_10[] = {
>   	"core_bi_pll_test_se",
>   };
>   
> +static const struct parent_map gcc_parent_map_9[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GPLL0_OUT_MAIN, 1 },
> +	{ P_GPLL0_OUT_EVEN, 6 },
> +	{ P_SLEEP_CLK, 7 },

SRC 7 has 'core_bi_pll_test_se' and not 'sleep_clk'.

Please use the 'gcc_parent_map_0'

> +};
> +
> +static const char * const gcc_parent_names_9[] = {
> +	"bi_tcxo",
> +	"gpll0",
> +	"gpll0_out_even",
> +	"core_pi_sleep_clk",
> +};
> +
>   static struct clk_alpha_pll gpll0 = {
>   	.offset = 0x0,
>   	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
> @@ -358,6 +372,31 @@ static struct clk_rcg2 gcc_pcie_phy_refgen_clk_src = {
>   	},
>   };
>   
> +static const struct freq_tbl ftbl_gcc_qspi_core_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
> +	F(75000000, P_GPLL0_OUT_EVEN, 4, 0, 0),
> +	F(100000000, P_GPLL0_OUT_EVEN, 3, 0, 0),

Is SW planning to use this frequency?

> +	F(150000000, P_GPLL0_OUT_EVEN, 2, 0, 0),

F(150000000, P_GPLL0_OUT_MAIN, 4, 0, 0),

> +	F(300000000, P_GPLL0_OUT_EVEN, 1, 0, 0),

F(300000000, P_GPLL0_OUT_MAIN, 2, 0, 0),

> +	F(400000000, P_GPLL0_OUT_MAIN, 1.5, 0, 0),
Please remove this, the Max supported frequency is 300MHz.
> +	{ }
> +};
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

Could we use the rcg2_ops instead?

> +	},
> +};
> +
>   static const struct freq_tbl ftbl_gcc_pdm2_clk_src[] = {
>   	F(9600000, P_BI_TCXO, 2, 0, 0),
>   	F(19200000, P_BI_TCXO, 1, 0, 0),
> @@ -1935,6 +1974,37 @@ static struct clk_branch gcc_qmip_video_ahb_clk = {
>   	},
>   };
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
>   static struct clk_branch gcc_qupv3_wrap0_s0_clk = {
>   	.halt_reg = 0x17030,
>   	.halt_check = BRANCH_HALT_VOTED,
> @@ -3383,6 +3453,9 @@ static struct clk_regmap *gcc_sdm845_clocks[] = {
>   	[GPLL4] = &gpll4.clkr,
>   	[GCC_CPUSS_DVM_BUS_CLK] = &gcc_cpuss_dvm_bus_clk.clkr,
>   	[GCC_CPUSS_GNOC_CLK] = &gcc_cpuss_gnoc_clk.clkr,
> +	[GCC_QSPI_CORE_CLK_SRC] = &gcc_qspi_core_clk_src.clkr,
> +	[GCC_QSPI_CORE_CLK] = &gcc_qspi_core_clk.clkr,
> +	[GCC_QSPI_CNOC_PERIPH_AHB_CLK] = &gcc_qspi_cnoc_periph_ahb_clk.clkr,
>   };
>   
>   static const struct qcom_reset_map gcc_sdm845_resets[] = {
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
