Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E40C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB266217FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XC2dn2ZT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dsVQd/Re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB266217FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbeHJKiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:38:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44672 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbeHJKiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:38:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B9E0060BE2; Fri, 10 Aug 2018 08:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533888570;
        bh=FaBHguihff+atTJR0j7IOS8FfgIDZL22FbUQ9nrzULY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XC2dn2ZT1eEzEEvcrkXnQ/8KaflN3qIn7EGKqyQnhJeg2RRcihTbX5ZRpa1l78Gra
         hHnvX4qon6+LWG6wNphctNpimI90UFdoDjf6uZPaNLkaGqdHYkKETKNIDKplnO/4Wy
         +x9ugDYM4dAxnsELBDQR/Mq7xtfgL6xbTZMqhTwQ=
Received: from [10.4.34.47] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 871D260B7B;
        Fri, 10 Aug 2018 08:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533888567;
        bh=FaBHguihff+atTJR0j7IOS8FfgIDZL22FbUQ9nrzULY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dsVQd/RepUczRF5XXJAtkISpEWdZ4TglGD3JcYC2TpJen4Z5mAZhBJD/Kxqtw8wP0
         wt5OHLmUrcSKIwDuwnTVNayqDhPj6tfFLUslN4OOjiO7SugSnbtouNotW2s4a5vOpH
         +OG/1GeLKDYwRj7Fj1G1cGijPdQt0lQVwxz6Wkas=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 871D260B7B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v3 2/2] clk: qcom: Add qspi (Quad SPI) clocks for sdm845
To:     Douglas Anderson <dianders@chromium.org>, sboyd@kernel.org,
        andy.gross@linaro.org
Cc:     girishm@codeaurora.org, linux-arm-msm@vger.kernel.org,
        anischal@codeaurora.org, bjorn.andersson@linaro.org,
        grahamr@codeaurora.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, David Brown <david.brown@linaro.org>
References: <20180724174513.174018-1-dianders@chromium.org>
 <20180724174513.174018-3-dianders@chromium.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <7f2ac80d-d4b8-ce46-0f1f-8e62f8868a61@codeaurora.org>
Date:   Fri, 10 Aug 2018 13:39:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724174513.174018-3-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2018 11:15 PM, Douglas Anderson wrote:
> Add both the interface and core clock.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> (am from https://lore.kernel.org/patchwork/patch/966680/mbox)
> 
> ---
> 
> Changes in v3:
> - Removed gcc_parent_names_9 which I had left in (doh!).
> 
> Changes in v2:
> - Only 19.2, 100, 150, and 300 MHz now.
> - All clocks come from MAIN rather than EVEN.
> - Use parent map 0 instead of new parent map 9.
> 
>   drivers/clk/qcom/gcc-sdm845.c | 56 +++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
> index 0f694ed4238a..fc1c6658ad82 100644
> --- a/drivers/clk/qcom/gcc-sdm845.c
> +++ b/drivers/clk/qcom/gcc-sdm845.c
> @@ -358,6 +358,28 @@ static struct clk_rcg2 gcc_pcie_phy_refgen_clk_src = {
>   	},
>   };
>   
> +static const struct freq_tbl ftbl_gcc_qspi_core_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
> +	F(150000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
> +	F(300000000, P_GPLL0_OUT_MAIN, 2, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_qspi_core_clk_src = {
> +	.cmd_rcgr = 0x4b008,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qspi_core_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gcc_qspi_core_clk_src",
> +		.parent_names = gcc_parent_names_0,
> +		.num_parents = 4,
> +		.ops = &clk_rcg2_floor_ops,
> +	},
> +};
> +
>   static const struct freq_tbl ftbl_gcc_pdm2_clk_src[] = {
>   	F(9600000, P_BI_TCXO, 2, 0, 0),
>   	F(19200000, P_BI_TCXO, 1, 0, 0),
> @@ -1935,6 +1957,37 @@ static struct clk_branch gcc_qmip_video_ahb_clk = {
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
> @@ -3383,6 +3436,9 @@ static struct clk_regmap *gcc_sdm845_clocks[] = {
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

Reviewed-by: Taniya Das <tdas@codeaurora.org>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
