Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7D1C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F672082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FskHI+Zz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jXRWZtxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfBDSGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:06:09 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39466 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBDSGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:06:09 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EE923608D4; Mon,  4 Feb 2019 18:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549303568;
        bh=mqri8PoyzzT72SRIz2OSVYMi5LFtLmrsapyGzz2oynI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FskHI+ZzJH4laIq4044eMUFxdE9J7eIanKz0gJhOWfiXh3EAOXDkIzk5qYa39kpCV
         Yoz3wIFCMpUYAQvBzyfObNnuBq2hCkuNTBBfHG+y0qfhB8kXDBVgqgfqLVbE84FsDS
         gzXy3oDV+xhbRsbw6VYKjjZgvLEvHTY0fKYahOVY=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 69D4060112;
        Mon,  4 Feb 2019 18:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549303567;
        bh=mqri8PoyzzT72SRIz2OSVYMi5LFtLmrsapyGzz2oynI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jXRWZtxVGwijMcchLLkpnrWAVJhcQQXP7b9TqZJS37Lu+Bn2wVvG6zTzL/kutgDFi
         wB/crmcGZVQW9pBa7KwS6j4o1ivV+jgZ9440ezR+DJ/mrdi0u1jgO/QBZVv4/3eEy/
         UqjJS/yVRZsusYTTzXOSJNUeP3gUH8J2mQc90odQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69D4060112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3 1/5] arm64: dts: qcom: msm8998: Add UFS nodes
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
References: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
 <a4e160fc-9700-e575-29a9-0cb25cee3630@free.fr>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <aea971ad-cf4b-2595-335b-f94c27d4d73a@codeaurora.org>
Date:   Mon, 4 Feb 2019 11:06:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a4e160fc-9700-e575-29a9-0cb25cee3630@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/2019 10:36 AM, Marc Gonzalez wrote:
> Add host controller and PHY DT nodes.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
> vddp-ref-clk-max-microamp = <100>; sounds tiny and fishy.
> Jeffrey, Bjorn, can you check?
> The PHY driver doesn't seem to try to set any load...

Yes, 0.1mA matches the hardware documentation.
IMO, this should be the last change in the series, not the first.
Otherwise, seems good.

Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

> ---
>   arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 19 +++++++
>   arch/arm64/boot/dts/qcom/msm8998.dtsi     | 63 +++++++++++++++++++++++
>   2 files changed, 82 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> index 50e9033aa7f6..80075283847a 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> @@ -257,3 +257,22 @@
>   	pinctrl-0 = <&sdc2_clk_on  &sdc2_cmd_on  &sdc2_data_on  &sdc2_cd_on>;
>   	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
>   };
> +
> +&ufshc {
> +	vcc-supply = <&vreg_l20a_2p95>;
> +	vccq-supply = <&vreg_l26a_1p2>;
> +	vccq2-supply = <&vreg_s4a_1p8>;
> +	vcc-max-microamp = <750000>;
> +	vccq-max-microamp = <560000>;
> +	vccq2-max-microamp = <750000>;
> +};
> +
> +&ufsphy {
> +	vdda-phy-supply = <&vreg_l1a_0p875>;
> +	vdda-pll-supply = <&vreg_l2a_1p2>;
> +	vddp-ref-clk-supply = <&vreg_l26a_1p2>;
> +	vdda-phy-max-microamp = <51400>;
> +	vdda-pll-max-microamp = <14600>;
> +	vddp-ref-clk-max-microamp = <100>;
> +	vddp-ref-clk-always-on;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 6f4f4b79853b..831af20143da 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -711,6 +711,69 @@
>   			redistributor-stride = <0x0 0x20000>;
>   			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>   		};
> +
> +		ufshc: ufshc@1da4000 {
> +			compatible = "qcom,msm8998-ufshc", "qcom,ufshc",
> +				     "jedec,ufs-2.0";
> +			reg = <0x01da4000 0x2500>;
> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> +			phys = <&ufsphy_lanes>;
> +			phy-names = "ufsphy";
> +			lanes-per-direction = <2>;
> +			power-domains = <&gcc UFS_GDSC>;
> +
> +			clock-names =
> +				"core_clk",
> +				"bus_aggr_clk",
> +				"iface_clk",
> +				"core_clk_unipro",
> +				"ref_clk",
> +				"tx_lane0_sync_clk",
> +				"rx_lane0_sync_clk",
> +				"rx_lane1_sync_clk";
> +			clocks =
> +				<&gcc GCC_UFS_AXI_CLK>,
> +				<&gcc GCC_AGGRE1_UFS_AXI_CLK>,
> +				<&gcc GCC_UFS_AHB_CLK>,
> +				<&gcc GCC_UFS_UNIPRO_CORE_CLK>,
> +				<&rpmcc RPM_SMD_LN_BB_CLK1>,
> +				<&gcc GCC_UFS_TX_SYMBOL_0_CLK>,
> +				<&gcc GCC_UFS_RX_SYMBOL_0_CLK>,
> +				<&gcc GCC_UFS_RX_SYMBOL_1_CLK>;
> +			freq-table-hz =
> +				<50000000 200000000>,
> +				<0 0>,
> +				<0 0>,
> +				<37500000 150000000>,
> +				<0 0>,
> +				<0 0>,
> +				<0 0>,
> +				<0 0>;
> +
> +			resets = <&gcc GCC_UFS_BCR>;
> +			reset-names = "rst";
> +		};
> +
> +		ufsphy: phy@1da7000 {
> +			compatible = "qcom,msm8998-qmp-ufs-phy";
> +			reg = <0x01da7000 0x18c>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			clock-names = "ref", "ref_aux";
> +			clocks =
> +				<&gcc GCC_UFS_CLKREF_CLK>,
> +				<&gcc GCC_UFS_PHY_AUX_CLK>;
> +
> +			ufsphy_lanes: lanes@1da7400 {
> +				reg = <0x01da7400 0x128>,
> +				      <0x01da7600 0x1fc>,
> +				      <0x01da7c00 0x1dc>,
> +				      <0x01da7800 0x128>,
> +				      <0x01da7a00 0x1fc>;
> +				#phy-cells = <0>;
> +			};
> +		};
>   	};
>   };
>   
> 


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
