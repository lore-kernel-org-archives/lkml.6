Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4A3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E870F2087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E870F2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389821AbeHPLEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:04:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47521 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725749AbeHPLEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:04:44 -0400
X-UUID: bee019e1bbb74cd28b212e7eb78a3d66-20180816
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 828814701; Thu, 16 Aug 2018 16:07:53 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 16 Aug 2018 16:07:46 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 16 Aug 2018 16:07:46 +0800
Message-ID: <1534406866.31978.47.camel@mtkswgap22>
Subject: Re: [PATCH 3/5] arm64: dts: mt7622: fix ram size for rfb1
From:   Sean Wang <sean.wang@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 16 Aug 2018 16:07:46 +0800
In-Reply-To: <3be2ef51a1dffed93538d256273bdecfc59cdea5.1534130854.git.ryder.lee@mediatek.com>
References: <68c4ca0158518d6bf50f2f7becfcb87ff3ce158a.1534130854.git.ryder.lee@mediatek.com>
         <3be2ef51a1dffed93538d256273bdecfc59cdea5.1534130854.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-15 at 13:18 +0800, Ryder Lee wrote:
> Fix ram size and sort nodes in alphabetical order.
> 

The size of the ram should be selective range from 512 megabytes to 2
gigabytes depending on what the specific application is being run on the
Soc and I actually thought 512 megabytes should be the better value for
the base of rfb1, so 

Acked-by: Sean Wang <sean.wang@mediatek.com>

> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 196 +++++++++++++--------------
>  1 file changed, 98 insertions(+), 98 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> index b783764..033d7d1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> @@ -51,7 +51,7 @@
>  	};
>  
>  	memory {
> -		reg = <0 0x40000000 0 0x3F000000>;
> +		reg = <0 0x40000000 0 0x20000000>;
>  	};
>  
>  	reg_1p8v: regulator-1p8v {
> @@ -81,6 +81,103 @@
>  	};
>  };
>  
> +&bch {
> +	status = "disabled";
> +};
> +
> +&btif {
> +	status = "okay";
> +};
> +
> +&cir {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&irrx_pins>;
> +	status = "okay";
> +};
> +
> +&eth {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&eth_pins>;
> +	status = "okay";
> +
> +	gmac1: mac@1 {
> +		compatible = "mediatek,eth-mac";
> +		reg = <1>;
> +		phy-handle = <&phy5>;
> +	};
> +
> +	mdio-bus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		phy5: ethernet-phy@5 {
> +			reg = <5>;
> +			phy-mode = "sgmii";
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins>;
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&emmc_pins_default>;
> +	pinctrl-1 = <&emmc_pins_uhs>;
> +	status = "okay";
> +	bus-width = <8>;
> +	max-frequency = <50000000>;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	vmmc-supply = <&reg_3p3v>;
> +	vqmmc-supply = <&reg_1p8v>;
> +	assigned-clocks = <&topckgen CLK_TOP_MSDC30_0_SEL>;
> +	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
> +	non-removable;
> +};
> +
> +&mmc1 {
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&sd0_pins_default>;
> +	pinctrl-1 = <&sd0_pins_uhs>;
> +	status = "okay";
> +	bus-width = <4>;
> +	max-frequency = <50000000>;
> +	cap-sd-highspeed;
> +	r_smpl = <1>;
> +	cd-gpios = <&pio 81 GPIO_ACTIVE_LOW>;
> +	vmmc-supply = <&reg_3p3v>;
> +	vqmmc-supply = <&reg_3p3v>;
> +	assigned-clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>;
> +	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
> +};
> +
> +&nandc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&parallel_nand_pins>;
> +	status = "disabled";
> +};
> +
> +&nor_flash {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi_nor_pins>;
> +	status = "disabled";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +	};
> +};
> +
>  &pcie {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pcie0_pins>;
> @@ -344,103 +441,6 @@
>  	};
>  };
>  
> -&bch {
> -	status = "disabled";
> -};
> -
> -&btif {
> -	status = "okay";
> -};
> -
> -&cir {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&irrx_pins>;
> -	status = "okay";
> -};
> -
> -&eth {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&eth_pins>;
> -	status = "okay";
> -
> -	gmac1: mac@1 {
> -		compatible = "mediatek,eth-mac";
> -		reg = <1>;
> -		phy-handle = <&phy5>;
> -	};
> -
> -	mdio-bus {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		phy5: ethernet-phy@5 {
> -			reg = <5>;
> -			phy-mode = "sgmii";
> -		};
> -	};
> -};
> -
> -&i2c1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c1_pins>;
> -	status = "okay";
> -};
> -
> -&i2c2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c2_pins>;
> -	status = "okay";
> -};
> -
> -&mmc0 {
> -	pinctrl-names = "default", "state_uhs";
> -	pinctrl-0 = <&emmc_pins_default>;
> -	pinctrl-1 = <&emmc_pins_uhs>;
> -	status = "okay";
> -	bus-width = <8>;
> -	max-frequency = <50000000>;
> -	cap-mmc-highspeed;
> -	mmc-hs200-1_8v;
> -	vmmc-supply = <&reg_3p3v>;
> -	vqmmc-supply = <&reg_1p8v>;
> -	assigned-clocks = <&topckgen CLK_TOP_MSDC30_0_SEL>;
> -	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
> -	non-removable;
> -};
> -
> -&mmc1 {
> -	pinctrl-names = "default", "state_uhs";
> -	pinctrl-0 = <&sd0_pins_default>;
> -	pinctrl-1 = <&sd0_pins_uhs>;
> -	status = "okay";
> -	bus-width = <4>;
> -	max-frequency = <50000000>;
> -	cap-sd-highspeed;
> -	r_smpl = <1>;
> -	cd-gpios = <&pio 81 GPIO_ACTIVE_LOW>;
> -	vmmc-supply = <&reg_3p3v>;
> -	vqmmc-supply = <&reg_3p3v>;
> -	assigned-clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>;
> -	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
> -};
> -
> -&nandc {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&parallel_nand_pins>;
> -	status = "disabled";
> -};
> -
> -&nor_flash {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi_nor_pins>;
> -	status = "disabled";
> -
> -	flash@0 {
> -		compatible = "jedec,spi-nor";
> -		reg = <0>;
> -	};
> -};
> -
>  &pwm {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pwm7_pins>;


