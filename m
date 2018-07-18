Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530E8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1542A2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1542A2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeGRQNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:13:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40834 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731087AbeGRQNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:13:51 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7133C8C598C6;
        Wed, 18 Jul 2018 23:35:19 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.382.0; Wed, 18 Jul 2018
 23:35:19 +0800
Subject: Re: [PATCH] arm64: dts: hikey960: Clean up MMC properties and move to
 proper file
To:     Ryan Grachek <ryan@edited.us>
References: <20180618181008.21831-1-ryan@edited.us>
CC:     <john.stultz@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5B4F5E30.1080208@hisilicon.com>
Date:   Wed, 18 Jul 2018 16:35:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180618181008.21831-1-ryan@edited.us>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

On 2018/6/18 19:10, Ryan Grachek wrote:
> Certain properties should be moved to the board file to reflect
> the specific properties of the board, and not the SoC. Move these
> properties to proper location and organize properties in both files.
> 
> Signed-off-by: Ryan Grachek <ryan@edited.us>

Thanks!
Applied to the hisilicon dt tree.

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 27 ++++++++++++++++++-----
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 27 +++++------------------
>  2 files changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index abc991619c75..1c2a9a5d0477 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -602,20 +602,37 @@
>  };
>  
>  &dwmmc1 {
> +	bus-width = <0x4>;
> +	cap-sd-highspeed;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	disable-wp;
> +	cd-inverted;
> +	cd-gpios = <&gpio25 3 0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sd_pmx_func
> +		&sd_clk_cfg_func
> +		&sd_cfg_func>;
>  	vmmc-supply = <&ldo16>;
>  	vqmmc-supply = <&ldo9>;
>  	status = "okay";
>  };
>  
>  &dwmmc2 { /* WIFI */
> -	broken-cd;
> -	/* WL_EN */
> -	vmmc-supply = <&wlan_en>;
> +	bus-width = <0x4>;
>  	non-removable;
> +	broken-cd;
> +	cap-sd-highspeed;
>  	cap-power-off-card;
>  	keep-power-in-suspend;
> -	#address-cells = <0x1>;
> -	#size-cells = <0x0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdio_pmx_func
> +		&sdio_clk_cfg_func
> +		&sdio_cfg_func>;
> +	/* WL_EN */
> +	vmmc-supply = <&wlan_en>;
>  	status = "ok";
>  
>  	wlcore: wlcore@2 {
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 74c0509f99e9..fe4c9f321b70 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -1114,15 +1114,10 @@
>  
>  		/* SD */
>  		dwmmc1: dwmmc1@ff37f000 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			cd-inverted;
>  			compatible = "hisilicon,hi3660-dw-mshc";
> -			bus-width = <0x4>;
> -			disable-wp;
> -			cap-sd-highspeed;
> -			card-detect-delay = <200>;
>  			reg = <0x0 0xff37f000 0x0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
>  			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&crg_ctrl HI3660_CLK_GATE_SD>,
>  				<&crg_ctrl HI3660_HCLK_GATE_SD>;
> @@ -1130,16 +1125,8 @@
>  			clock-frequency = <3200000>;
>  			resets = <&crg_rst 0x94 18>;
>  			reset-names = "reset";
> -			cd-gpios = <&gpio25 3 0>;
>  			hisilicon,peripheral-syscon = <&sctrl>;
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&sd_pmx_func
> -				     &sd_clk_cfg_func
> -				     &sd_cfg_func>;
> -			sd-uhs-sdr12;
> -			sd-uhs-sdr25;
> -			sd-uhs-sdr50;
> -			sd-uhs-sdr104;
> +			card-detect-delay = <200>;
>  			status = "disabled";
>  		};
>  
> @@ -1147,6 +1134,8 @@
>  		dwmmc2: dwmmc2@ff3ff000 {
>  			compatible = "hisilicon,hi3660-dw-mshc";
>  			reg = <0x0 0xff3ff000 0x0 0x1000>;
> +			#address-cells = <0x1>;
> +			#size-cells = <0x0>;
>  			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&crg_ctrl HI3660_CLK_GATE_SDIO0>,
>  				 <&crg_ctrl HI3660_HCLK_GATE_SDIO0>;
> @@ -1154,12 +1143,6 @@
>  			resets = <&crg_rst 0x94 20>;
>  			reset-names = "reset";
>  			card-detect-delay = <200>;
> -			cap-sd-highspeed;
> -			keep-power-in-suspend;
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&sdio_pmx_func
> -				     &sdio_clk_cfg_func
> -				     &sdio_cfg_func>;
>  			status = "disabled";
>  		};
>  
> 

