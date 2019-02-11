Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30003C282CC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EF620855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549862339;
	bh=sLtQvk20ns1oSP8Q9sQvqJkAwlCLaGet1Y13+6s646A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pOkYP2pnY9n+/SX5yJJLlGbtIezordFYRT/U3xVlQ0hiSKnn5Moi6IGEa5F8MzcHl
	 yu5EEs9DPzK9RVPSGfdKxux2ndtZ12rdBaAR6f3kgOiRL58rNQOPekj7hhToNU6lQM
	 4NSEnuO7ANSNLeu9WPNVyhzKuvkjjvW5K4URi1lU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfBKFS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 00:18:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfBKFS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 00:18:57 -0500
Received: from localhost (unknown [117.99.91.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 948E020855;
        Mon, 11 Feb 2019 05:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549862335;
        bh=sLtQvk20ns1oSP8Q9sQvqJkAwlCLaGet1Y13+6s646A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0BJ1nxQQyM+oxVACLgSlma9krPyMgyIm+mHwCzWQLkT/2Y+84mVGhYIRTPH2CT9ZA
         duTuyaQ28ALh4leZrrjtDA5vh06J1E9AtuHfSb2APdbKLV6czJcfK1EVth4ueqkK6u
         jZhlygj4MqbspRq1/LhFxUEm613/GBRQ8MYZ6XBs=
Date:   Mon, 11 Feb 2019 10:48:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, marc.w.gonzalez@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] clk: qcom: Make common clk_hw registrations
Message-ID: <20190211051846.GO4296@vkoul-mobl>
References: <1549829645-24400-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549829645-24400-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-02-19, 13:14, Jeffrey Hugo wrote:
> Several clock controller drivers define a list of clk_hw devices, and then
> register those devices in probe() before using common code to process the
> rest of initialization.  Extend the common code to accept a list of clk_hw
> devices to process, thus eliminating many duplicate implementations.

Thanks, this looks nice to me. I verfified this on couple of devices.


Reviewed-by: Vinod Koul <vkoul@kernel.org>
Tested-by: Vinod Koul <vkoul@kernel.org>

> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  drivers/clk/qcom/common.c       |  8 ++++++++
>  drivers/clk/qcom/common.h       |  2 ++
>  drivers/clk/qcom/gcc-ipq8074.c  | 10 ++--------
>  drivers/clk/qcom/gcc-mdm9615.c  | 11 ++---------
>  drivers/clk/qcom/gcc-msm8996.c  | 10 ++--------
>  drivers/clk/qcom/gcc-msm8998.c  | 10 ++++++----
>  drivers/clk/qcom/gcc-qcs404.c   |  9 ++-------
>  drivers/clk/qcom/gcc-sdm660.c   | 11 +++--------
>  drivers/clk/qcom/mmcc-msm8996.c | 10 ++--------
>  9 files changed, 29 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index 0a48ed5..a6b2f861 100644
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> @@ -231,6 +231,8 @@ int qcom_cc_really_probe(struct platform_device *pdev,
>  	struct gdsc_desc *scd;
>  	size_t num_clks = desc->num_clks;
>  	struct clk_regmap **rclks = desc->clks;
> +	size_t num_clk_hws = desc->num_clk_hws;
> +	struct clk_hw **clk_hws = desc->clk_hws;
>  
>  	cc = devm_kzalloc(dev, sizeof(*cc), GFP_KERNEL);
>  	if (!cc)
> @@ -269,6 +271,12 @@ int qcom_cc_really_probe(struct platform_device *pdev,
>  
>  	qcom_cc_drop_protected(dev, cc);
>  
> +	for (i = 0; i < num_clk_hws; i++) {
> +		ret = devm_clk_hw_register(dev, clk_hws[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	for (i = 0; i < num_clks; i++) {
>  		if (!rclks[i])
>  			continue;
> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> index 4aa33ee..1e2a8bd 100644
> --- a/drivers/clk/qcom/common.h
> +++ b/drivers/clk/qcom/common.h
> @@ -27,6 +27,8 @@ struct qcom_cc_desc {
>  	size_t num_resets;
>  	struct gdsc **gdscs;
>  	size_t num_gdscs;
> +	struct clk_hw **clk_hws;
> +	size_t num_clk_hws;
>  };
>  
>  /**
> diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
> index 505c626..0e32892 100644
> --- a/drivers/clk/qcom/gcc-ipq8074.c
> +++ b/drivers/clk/qcom/gcc-ipq8074.c
> @@ -4715,18 +4715,12 @@ enum {
>  	.num_clks = ARRAY_SIZE(gcc_ipq8074_clks),
>  	.resets = gcc_ipq8074_resets,
>  	.num_resets = ARRAY_SIZE(gcc_ipq8074_resets),
> +	.clk_hws = gcc_ipq8074_hws,
> +	.num_clk_hws = ARRAY_SIZE(gcc_ipq8074_hws),
>  };
>  
>  static int gcc_ipq8074_probe(struct platform_device *pdev)
>  {
> -	int ret, i;
> -
> -	for (i = 0; i < ARRAY_SIZE(gcc_ipq8074_hws); i++) {
> -		ret = devm_clk_hw_register(&pdev->dev, gcc_ipq8074_hws[i]);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	return qcom_cc_probe(pdev, &gcc_ipq8074_desc);
>  }
>  
> diff --git a/drivers/clk/qcom/gcc-mdm9615.c b/drivers/clk/qcom/gcc-mdm9615.c
> index 849046f..8c6d931 100644
> --- a/drivers/clk/qcom/gcc-mdm9615.c
> +++ b/drivers/clk/qcom/gcc-mdm9615.c
> @@ -1702,6 +1702,8 @@ enum {
>  	.num_clks = ARRAY_SIZE(gcc_mdm9615_clks),
>  	.resets = gcc_mdm9615_resets,
>  	.num_resets = ARRAY_SIZE(gcc_mdm9615_resets),
> +	.clk_hws = gcc_mdm9615_hws,
> +	.num_clk_hws = ARRAY_SIZE(gcc_mdm9615_hws),
>  };
>  
>  static const struct of_device_id gcc_mdm9615_match_table[] = {
> @@ -1712,21 +1714,12 @@ enum {
>  
>  static int gcc_mdm9615_probe(struct platform_device *pdev)
>  {
> -	struct device *dev = &pdev->dev;
>  	struct regmap *regmap;
> -	int ret;
> -	int i;
>  
>  	regmap = qcom_cc_map(pdev, &gcc_mdm9615_desc);
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>  
> -	for (i = 0; i < ARRAY_SIZE(gcc_mdm9615_hws); i++) {
> -		ret = devm_clk_hw_register(dev, gcc_mdm9615_hws[i]);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	return qcom_cc_really_probe(pdev, &gcc_mdm9615_desc, regmap);
>  }
>  
> diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
> index 9d13617..4632b92 100644
> --- a/drivers/clk/qcom/gcc-msm8996.c
> +++ b/drivers/clk/qcom/gcc-msm8996.c
> @@ -3656,6 +3656,8 @@ enum {
>  	.num_resets = ARRAY_SIZE(gcc_msm8996_resets),
>  	.gdscs = gcc_msm8996_gdscs,
>  	.num_gdscs = ARRAY_SIZE(gcc_msm8996_gdscs),
> +	.clk_hws = gcc_msm8996_hws,
> +	.num_clk_hws = ARRAY_SIZE(gcc_msm8996_hws),
>  };
>  
>  static const struct of_device_id gcc_msm8996_match_table[] = {
> @@ -3666,8 +3668,6 @@ enum {
>  
>  static int gcc_msm8996_probe(struct platform_device *pdev)
>  {
> -	struct device *dev = &pdev->dev;
> -	int i, ret;
>  	struct regmap *regmap;
>  
>  	regmap = qcom_cc_map(pdev, &gcc_msm8996_desc);
> @@ -3680,12 +3680,6 @@ static int gcc_msm8996_probe(struct platform_device *pdev)
>  	 */
>  	regmap_update_bits(regmap, 0x52008, BIT(21), BIT(21));
>  
> -	for (i = 0; i < ARRAY_SIZE(gcc_msm8996_hws); i++) {
> -		ret = devm_clk_hw_register(dev, gcc_msm8996_hws[i]);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	return qcom_cc_really_probe(pdev, &gcc_msm8996_desc, regmap);
>  }
>  
> diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
> index 3cbabbb..c240fba 100644
> --- a/drivers/clk/qcom/gcc-msm8998.c
> +++ b/drivers/clk/qcom/gcc-msm8998.c
> @@ -2959,6 +2959,10 @@ enum {
>  	.fast_io	= true,
>  };
>  
> +static struct clk_hw *gcc_msm8998_hws[] = {
> +	&xo.hw,
> +};
> +
>  static const struct qcom_cc_desc gcc_msm8998_desc = {
>  	.config = &gcc_msm8998_regmap_config,
>  	.clks = gcc_msm8998_clocks,
> @@ -2967,6 +2971,8 @@ enum {
>  	.num_resets = ARRAY_SIZE(gcc_msm8998_resets),
>  	.gdscs = gcc_msm8998_gdscs,
>  	.num_gdscs = ARRAY_SIZE(gcc_msm8998_gdscs),
> +	.clk_hws = gcc_msm8998_hws,
> +	.num_clk_hws = ARRAY_SIZE(gcc_msm8998_hws),
>  };
>  
>  static int gcc_msm8998_probe(struct platform_device *pdev)
> @@ -2986,10 +2992,6 @@ static int gcc_msm8998_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_clk_hw_register(&pdev->dev, &xo.hw);
> -	if (ret)
> -		return ret;
> -
>  	return qcom_cc_really_probe(pdev, &gcc_msm8998_desc, regmap);
>  }
>  
> diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
> index 64da032..a7b2fe0 100644
> --- a/drivers/clk/qcom/gcc-qcs404.c
> +++ b/drivers/clk/qcom/gcc-qcs404.c
> @@ -2692,6 +2692,8 @@ enum {
>  	.num_clks = ARRAY_SIZE(gcc_qcs404_clocks),
>  	.resets = gcc_qcs404_resets,
>  	.num_resets = ARRAY_SIZE(gcc_qcs404_resets),
> +	.clk_hws = gcc_qcs404_hws,
> +	.num_clk_hws = ARRAY_SIZE(gcc_qcs404_hws),
>  };
>  
>  static const struct of_device_id gcc_qcs404_match_table[] = {
> @@ -2703,7 +2705,6 @@ enum {
>  static int gcc_qcs404_probe(struct platform_device *pdev)
>  {
>  	struct regmap *regmap;
> -	int ret, i;
>  
>  	regmap = qcom_cc_map(pdev, &gcc_qcs404_desc);
>  	if (IS_ERR(regmap))
> @@ -2711,12 +2712,6 @@ static int gcc_qcs404_probe(struct platform_device *pdev)
>  
>  	clk_alpha_pll_configure(&gpll3_out_main, regmap, &gpll3_config);
>  
> -	for (i = 0; i < ARRAY_SIZE(gcc_qcs404_hws); i++) {
> -		ret = devm_clk_hw_register(&pdev->dev, gcc_qcs404_hws[i]);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	return qcom_cc_really_probe(pdev, &gcc_qcs404_desc, regmap);
>  }
>  
> diff --git a/drivers/clk/qcom/gcc-sdm660.c b/drivers/clk/qcom/gcc-sdm660.c
> index ba239ea..8827db2 100644
> --- a/drivers/clk/qcom/gcc-sdm660.c
> +++ b/drivers/clk/qcom/gcc-sdm660.c
> @@ -2420,6 +2420,8 @@ enum {
>  	.num_resets = ARRAY_SIZE(gcc_sdm660_resets),
>  	.gdscs = gcc_sdm660_gdscs,
>  	.num_gdscs = ARRAY_SIZE(gcc_sdm660_gdscs),
> +	.clk_hws = gcc_sdm660_hws,
> +	.num_clk_hws = ARRAY_SIZE(gcc_sdm660_hws),
>  };
>  
>  static const struct of_device_id gcc_sdm660_match_table[] = {
> @@ -2431,7 +2433,7 @@ enum {
>  
>  static int gcc_sdm660_probe(struct platform_device *pdev)
>  {
> -	int i, ret;
> +	int ret;
>  	struct regmap *regmap;
>  
>  	regmap = qcom_cc_map(pdev, &gcc_sdm660_desc);
> @@ -2446,13 +2448,6 @@ static int gcc_sdm660_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	/* Register the hws */
> -	for (i = 0; i < ARRAY_SIZE(gcc_sdm660_hws); i++) {
> -		ret = devm_clk_hw_register(&pdev->dev, gcc_sdm660_hws[i]);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	return qcom_cc_really_probe(pdev, &gcc_sdm660_desc, regmap);
>  }
>  
> diff --git a/drivers/clk/qcom/mmcc-msm8996.c b/drivers/clk/qcom/mmcc-msm8996.c
> index 7d4ee10..7235510 100644
> --- a/drivers/clk/qcom/mmcc-msm8996.c
> +++ b/drivers/clk/qcom/mmcc-msm8996.c
> @@ -3347,6 +3347,8 @@ enum {
>  	.num_resets = ARRAY_SIZE(mmcc_msm8996_resets),
>  	.gdscs = mmcc_msm8996_gdscs,
>  	.num_gdscs = ARRAY_SIZE(mmcc_msm8996_gdscs),
> +	.clk_hws = mmcc_msm8996_hws,
> +	.num_clk_hws = ARRAY_SIZE(mmcc_msm8996_hws),
>  };
>  
>  static const struct of_device_id mmcc_msm8996_match_table[] = {
> @@ -3357,8 +3359,6 @@ enum {
>  
>  static int mmcc_msm8996_probe(struct platform_device *pdev)
>  {
> -	struct device *dev = &pdev->dev;
> -	int i, ret;
>  	struct regmap *regmap;
>  
>  	regmap = qcom_cc_map(pdev, &mmcc_msm8996_desc);
> @@ -3370,12 +3370,6 @@ static int mmcc_msm8996_probe(struct platform_device *pdev)
>  	/* Disable the NoC FSM for mmss_mmagic_cfg_ahb_clk */
>  	regmap_update_bits(regmap, 0x5054, BIT(15), 0);
>  
> -	for (i = 0; i < ARRAY_SIZE(mmcc_msm8996_hws); i++) {
> -		ret = devm_clk_hw_register(dev, mmcc_msm8996_hws[i]);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	return qcom_cc_really_probe(pdev, &mmcc_msm8996_desc, regmap);
>  }
>  
> -- 
> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.

-- 
~Vinod
