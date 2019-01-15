Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340E2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E927520657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M0NALSkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388970AbfAOSo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:44:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42329 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388956AbfAOSo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:44:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so1713202pfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5VMURboqCMk5R94j4R7BxDG7vK//VAy0P3GTINh28nk=;
        b=M0NALSkMeVHdE04Gnb+1QYCNQ34PNW36mBMtOLCgoInklxK+Z9BfQt2orEWDttLn7m
         josr27WI7HObS83hRp2DZEkRiVqQP6RlzyyJL+2i9h2c4Yi6w8lNP0s1Lb4O2BKzc29X
         jAg3EY7jmP4vk9U9xeDHENkajQ7Gdmdz1A1p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5VMURboqCMk5R94j4R7BxDG7vK//VAy0P3GTINh28nk=;
        b=e+BI8j2noQADzlJB+ciZJYsl6mWEnDJUV4Cg9qSjuBFfXBq+biCLyBc/fMOqWq4WIy
         JVeCGmWBL7gEPgjg0yE3f3PWDMTDQQ7C1T5rVp58ssjoHN0h/Ig6cMSW6snBbyVbH+j1
         zZWYvPK1Nt8goZjttFENNw4ZodAiREFQ7DjDjVC5DWkE7nCGiETyc0I5heSmtfWtKAQW
         Bc270T/IU0REVd2JJBV//a0TmoH9xtakuU/0tGmzi4ESua0LpDuiiVZMzQHbCWi9kSX/
         v7UU9asAZWs/f7k1T5U3yGfbvm61g5KjMV7XkW3exFsc/DT8Qhsltx8KKS7BNlEcU0eq
         d0Bg==
X-Gm-Message-State: AJcUukdVjQs4dTR4XK7vl9lUzIKhZOBzthFWksrAjQWMPBD+ecy15JIE
        Wy9fGzK0ubkE5mdlMmKS9sYYkg==
X-Google-Smtp-Source: ALg8bN42RzqTRMQ9V9VuZVBO6/xore/nz1SK27kezGCjZijHK7DqmA7/HP2e7YxG1Oz1eH2P1yMwJA==
X-Received: by 2002:a63:4948:: with SMTP id y8mr5076941pgk.32.1547577896069;
        Tue, 15 Jan 2019 10:44:56 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x27sm5997301pfe.178.2019.01.15.10.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 10:44:55 -0800 (PST)
Date:   Tue, 15 Jan 2019 10:44:12 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: msm8998: Add USB-related nodes
Message-ID: <20190115184412.GH28907@builder>
References: <1547483851-5519-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547483851-5519-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Jan 08:37 PST 2019, Jeffrey Hugo wrote:

> Add nodes for USB and related PHYs.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 22 ++++++++
>  arch/arm64/boot/dts/qcom/msm8998.dtsi     | 92 +++++++++++++++++++++++++++++++
>  2 files changed, 114 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> index 50e9033..dc703fc 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> @@ -257,3 +257,25 @@
>  	pinctrl-0 = <&sdc2_clk_on  &sdc2_cmd_on  &sdc2_data_on  &sdc2_cd_on>;
>  	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
>  };
> +
> +&usb1 {
> +	status = "okay";
> +};
> +
> +&usb1_dwc3 {
> +	dr_mode = "host"; /* Force to host until we have Type-C hooked up */
> +};
> +
> +&usb1_hsphy {
> +	status = "okay";
> +
> +	vdda-pll-supply = <&vreg_l12a_1p8>;
> +	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
> +};
> +
> +&usb1_qmpphy {
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l1a_0p875>;
> +	vdda-pll-supply = <&vreg_l2a_1p2>;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 8d41b69..706b303 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -540,6 +540,11 @@
>  			reg = <0x780000 0x621c>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> +
> +			qusb2_hstx_trim: hstx-trim@423a {
> +				reg = <0x423a 0x1>;
> +				bits = <0 4>;
> +			};
>  		};
>  
>  		gcc: clock-controller@100000 {
> @@ -607,6 +612,93 @@
>  			#mbox-cells = <1>;
>  		};
>  
> +		usb1: usb@a8f8800 {
> +			compatible = "qcom,msm8998-dwc3", "qcom,dwc3";
> +			reg = <0xa8f8800 0x400>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_CFG_NOC_USB3_AXI_CLK>,
> +				 <&gcc GCC_USB30_MASTER_CLK>,
> +				 <&gcc GCC_AGGRE1_USB3_AXI_CLK>,
> +				 <&gcc GCC_USB30_MOCK_UTMI_CLK>,
> +				 <&gcc GCC_USB30_SLEEP_CLK>;
> +			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
> +				      "sleep";
> +
> +			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
> +					  <&gcc GCC_USB30_MASTER_CLK>;
> +			assigned-clock-rates = <19200000>, <120000000>;
> +
> +			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hs_phy_irq", "ss_phy_irq";
> +
> +			power-domains = <&gcc USB_30_GDSC>;
> +
> +			resets = <&gcc GCC_USB_30_BCR>;
> +
> +			usb1_dwc3: dwc3@a800000 {
> +				compatible = "snps,dwc3";
> +				reg = <0xa800000 0xcd00>;
> +				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> +				snps,dis_u2_susphy_quirk;
> +				snps,dis_enblslpm_quirk;
> +				phys = <&usb1_hsphy>, <&usb1_ssphy>;
> +				phy-names = "usb2-phy", "usb3-phy";
> +				snps,has-lpm-erratum;
> +				snps,hird-threshold = /bits/ 8 <0x10>;
> +			};
> +		};
> +
> +		usb1_qmpphy: phy@c010000 {
> +			compatible = "qcom,msm8998-qmp-usb3-phy";
> +			reg = <0xc010000 0x18c>;
> +			status = "disabled";
> +			#clock-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_USB3_PHY_AUX_CLK>,
> +				 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
> +				 <&gcc GCC_USB3_CLKREF_CLK>;
> +			clock-names = "aux", "cfg_ahb", "ref";
> +
> +			resets = <&gcc GCC_USB3_PHY_BCR>,
> +				 <&gcc GCC_USB3PHY_PHY_BCR>;
> +			reset-names = "phy", "common";
> +
> +			usb1_ssphy: lane@c010200 {
> +				reg = <0xc010200 0x128>,
> +				      <0xc010400 0x200>,
> +				      <0xc010c00 0x20c>,
> +				      <0xc010600 0x128>,
> +				      <0xc010800 0x200>;
> +				#phy-cells = <0>;
> +				clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
> +				clock-names = "pipe0";
> +				clock-output-names = "usb3_phy_pipe_clk_src";
> +			};
> +		};
> +
> +		usb1_hsphy: phy@c012000 {
> +			compatible = "qcom,msm8998-qusb2-phy";
> +			reg = <0xc012000 0x2a8>;
> +			status = "disabled";
> +			#phy-cells = <0>;
> +
> +			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
> +				 <&gcc GCC_RX1_USB2_CLKREF_CLK>;
> +			clock-names = "cfg_ahb", "ref";
> +
> +			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> +
> +			nvmem-cells = <&qusb2_hstx_trim>;
> +		};
> +
>  		sdhc2: sdhci@c0a4900 {
>  			compatible = "qcom,sdhci-msm-v4";
>  			reg = <0xc0a4900 0x314>, <0xc0a4000 0x800>;
> -- 
> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
