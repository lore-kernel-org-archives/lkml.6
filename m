Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FE9C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5182081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5182081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeLEM7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:59:43 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:49777 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeLEM7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:59:43 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-04.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gUWm9-0001lF-Cw from Akash_Gajjar@mentor.com ; Wed, 05 Dec 2018 04:59:37 -0800
Received: from [10.105.2.145] (137.202.0.90) by SVR-IES-MBX-04.mgc.mentorg.com
 (139.181.222.4) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 5 Dec
 2018 12:59:32 +0000
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: rockpro64 fix regulator gpios
To:     Oskari Lemmela <oskari@lemmela.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20181201100817.20688-1-oskari@lemmela.net>
 <20181201100817.20688-2-oskari@lemmela.net>
From:   agajjar <Akash_Gajjar@mentor.com>
Message-ID: <cf83adce-85cf-2251-6e50-3c87c8a01a0c@mentor.com>
Date:   Wed, 5 Dec 2018 18:29:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181201100817.20688-2-oskari@lemmela.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/1/2018 3:38 PM, Oskari Lemmela wrote:
> Rockpro64 is not able boot if GPIO1_C1 pin is pulled high
> before loading linux kernel.
>
> In rockpro64 GPIO1_C1 pin is connected vdd_cpu_b regulator
> VSEL pin. Pin should be pulled down in normal operation and
> pulled high in suspend.
>
> PMIC LDO_REG2 is connected to touch panel connector.
> Rename regulator and set it to correct voltage.
>
> PCIe power is controller by GPIO1_D0.
>
> Schematics can be downloaded from:
> http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Acked-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> ---
>   .../boot/dts/rockchip/rk3399-rockpro64.dts    | 20 +++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> index 1d35f5406b5e..5bd4d69914bd 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> @@ -97,7 +97,7 @@
>   	vcc3v3_pcie: vcc3v3-pcie-regulator {
>   		compatible = "regulator-fixed";
>   		enable-active-high;
> -		gpio = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
> +		gpio = <&gpio1 RK_PD0 GPIO_ACTIVE_HIGH>;
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&pcie_pwr_en>;
>   		regulator-name = "vcc3v3_pcie";
> @@ -293,12 +293,12 @@
>   				};
>   			};
>   
> -			vcc2v8_dvp: LDO_REG2 {
> -				regulator-name = "vcc2v8_dvp";
> +			vcc3v0_touch: LDO_REG2 {
> +				regulator-name = "vcc3v0_touch";
>   				regulator-always-on;
>   				regulator-boot-on;
> -				regulator-min-microvolt = <2800000>;
> -				regulator-max-microvolt = <2800000>;
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
>   				regulator-state-mem {
>   					regulator-off-in-suspend;
>   				};
> @@ -397,7 +397,9 @@
>   	vdd_cpu_b: regulator@40 {
>   		compatible = "silergy,syr827";
>   		reg = <0x40>;
> -		fcs,suspend-voltage-selector = <0>;
> +		fcs,suspend-voltage-selector = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vsel1_gpio>;
>   		regulator-name = "vdd_cpu_b";
>   		regulator-min-microvolt = <712500>;
>   		regulator-max-microvolt = <1500000>;
> @@ -415,6 +417,8 @@
>   		compatible = "silergy,syr828";
>   		reg = <0x41>;
>   		fcs,suspend-voltage-selector = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vsel2_gpio>;
>   		regulator-name = "vdd_gpu";
>   		regulator-min-microvolt = <712500>;
>   		regulator-max-microvolt = <1500000>;
> @@ -519,7 +523,7 @@
>   
>   	pcie {
>   		pcie_pwr_en: pcie-pwr-en {
> -			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> +			rockchip,pins = <1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
>   		};
>   	};
>   
> @@ -529,7 +533,7 @@
>   		};
>   
>   		vsel1_gpio: vsel1-gpio {
> -			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
> +			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
>   		};
>   
>   		vsel2_gpio: vsel2-gpio {
