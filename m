Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27EBC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 02:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7D325353
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 02:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4L8PsVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7D325353
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbeGACf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 22:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752030AbeGACf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 22:35:27 -0400
Received: from dragon (unknown [45.56.152.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2C0E25353;
        Sun,  1 Jul 2018 02:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530412527;
        bh=xMkNrZXT+7M7Rj9iJdwkNba9L4evX673HFk0Yd9PwLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j4L8PsVa6qEfQd9ug7XQMIT0ZNZcXj5xKa4fuh+uZxO51tR2gVIlsqMQ1KwBqhxHa
         HpDoZbkDUAWD3YNQGlTNJMukhXy0jbTYeIiFDxD5ykL6xWiIsNh+3e3+fI15mCUCoL
         3HAzkoFFa8Ene1UOqbmiGb0ogU15rq/NPnNVRgmc=
Date:   Sun, 1 Jul 2018 10:35:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alex Gonzalez <alex.gonzalez@digi.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] ARM: dts: imx6ul: Add DTS for ConnectCore 6UL
 System-On-Module (SOM)
Message-ID: <20180701023518.GB4348@dragon>
References: <1529393534-7827-1-git-send-email-alex.gonzalez@digi.com>
 <1529393534-7827-2-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1529393534-7827-2-git-send-email-alex.gonzalez@digi.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 09:32:13AM +0200, Alex Gonzalez wrote:
> The ConnectCore 6UL System-On-Module has the following hardware
> specification:
> 
> * Based on a NXP i.MX6UL SoC
> * Industrial temperature ranges (-40ºC to +85ºC)
> * Up to 1GB DDR3 memory
> * Up to 2GB NAND flash
> * Dual Ethernet
> * On module 802.11 WiFi and Bluetooth 4.2 (QCA6564)
> * On module NXP Kinetis KL03
> * On module Microchip ATECC508A crypto element
> 
> Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
> ---
>  arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi | 199 ++++++++++++++++++++++++++++++
>  1 file changed, 199 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
> 
> diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
> new file mode 100644
> index 000000000000..23484a48f6e0
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Digi International's ConnectCore 6UL System-On-Module device tree source
> + *
> + * Copyright 2018 Digi International, Inc.
> + *
> + */
> +
> +/ {
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			size = <0x4000000>;
> +			linux,cma-default;
> +		};
> +	};
> +};
> +
> +&adc1 {
> +	vref-supply = <&vdda_adc_3v3>;
> +	max-channel = <9>;

Undocumented DT property?

> +};
> +
> +&gpmi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpmi_nand>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pmic: pfuze3000@8 {

Node name should be generic, while label can be specific.

	pfuze3000: pmic@8 {

> +		compatible = "fsl,pfuze3000";
> +		reg = <0x08>;
> +
> +		regulators {
> +			int_3v3: sw1a {
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-boot-on;
> +				regulator-always-on;

Please have a newline between property list and child node.

> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_arm_soc_in: sw1b {
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1475000>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <925000>;
> +				};
> +			};
> +
> +			ext_3v3: sw2 {
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_ddr3: sw3 {
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <1650000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1300000>;
> +				};
> +			};
> +
> +			swbst_reg: swbst {
> +				regulator-min-microvolt = <5000000>;
> +				regulator-max-microvolt = <5150000>;
> +			};
> +
> +			vdd_snvs_3v3: vsnvs {
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vrefddr: vrefddr {
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vdda_adc_3v3: vldo1 {
> +				compatible = "regulator-fixed";
> +				regulator-name = "vref-adc-3v3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo2_ext: vldo2 {
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1550000>;
> +			};
> +
> +			vdda_wlan: vccsd {
> +				regulator-min-microvolt = <2850000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_high_in: v33 {
> +				regulator-min-microvolt = <2850000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3_int: vldo3 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			ldo4_ext: vldo4 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			vcoin_chg: vcoin {
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +		};
> +	};
> +};
> +
> +&iomuxc {
> +	imx6ul-ccimx6ul {

This container node can be dropped.

Shawn

> +		pinctrl_gpmi_nand: gpmigrp {
> +			fsl,pins = <
> +				MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B	0xb0b1
> +				MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B	0xb0b1
> +				MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B	0xb0b1
> +				MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B	0xb0b1
> +				MX6UL_PAD_NAND_ALE__RAWNAND_ALE		0xb0b1
> +				MX6UL_PAD_NAND_CLE__RAWNAND_CLE		0xb0b1
> +				MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0xb0b1
> +				MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01	0xb0b1
> +				MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02	0xb0b1
> +				MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03	0xb0b1
> +				MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04	0xb0b1
> +				MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05	0xb0b1
> +				MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06	0xb0b1
> +				MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0xb0b1
> +				MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0xb0b1
> +			>;
> +		};
> +
> +		pinctrl_i2c1: i2c1grp {
> +			fsl,pins = <
> +				MX6UL_PAD_UART4_TX_DATA__I2C1_SCL 0x4001b8b0
> +				MX6UL_PAD_UART4_RX_DATA__I2C1_SDA 0x4001b8b0
> +			>;
> +		};
> +	};
> +};
> +
> +&reg_arm {
> +	vin-supply = <&vdd_arm_soc_in>;
> +	regulator-allow-bypass;
> +};
> +
> +&reg_soc {
> +	vin-supply = <&vdd_arm_soc_in>;
> +	regulator-allow-bypass;
> +};
> +
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
