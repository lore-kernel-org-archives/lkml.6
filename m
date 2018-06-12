Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 662E7C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F80C2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F80C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933315AbeFLL3q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:29:46 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:54329 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932711AbeFLL3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:29:42 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 414njG3WpZz1qvP2;
        Tue, 12 Jun 2018 13:29:38 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 414njG2Dz2z1qql8;
        Tue, 12 Jun 2018 13:29:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id BaR5OWbIpDIV; Tue, 12 Jun 2018 13:29:35 +0200 (CEST)
X-Auth-Info: MtfNiodOdgEu4TWEoA8o7DQNBW3so7dU13Cc7pTzeCM=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 12 Jun 2018 13:29:35 +0200 (CEST)
Date:   Tue, 12 Jun 2018 13:28:09 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ARM: DTS: imx53: Add support for imx53 HSC/DDC
 boards from K+P
Message-ID: <20180612132809.03234c7d@jawa>
In-Reply-To: <20180611051357.GA16091@dragon>
References: <20180509153428.1440-1-lukma@denx.de>
        <20180519121506.32344-1-lukma@denx.de>
        <20180611051357.GA16091@dragon>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LBm94ZtV.5QfxqQaGW3nOfC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LBm94ZtV.5QfxqQaGW3nOfC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

Thanks for you review.

> On Sat, May 19, 2018 at 02:15:06PM +0200, Lukasz Majewski wrote:
> > This commit provides support for HSC and DDC boards from
> > Kieback&Peter GmbH vendor.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> > Changes for v2:
> >=20
> > - Remove not needed #address-cells and #size-cells in
> >   the gpio_buttons node to pass make W=3D1
> > - Rename button@{12} to button_{kalt|pwr} nodes to pass make W=3D1
> > - Include #include <dt-bindings/input/input.h> to use KEY_F6|F7
> > directly
> >=20
> > ---
> >  arch/arm/boot/dts/Makefile         |   2 +
> >  arch/arm/boot/dts/imx53-kp-ddc.dts | 146
> > ++++++++++++++++++++++++++++ arch/arm/boot/dts/imx53-kp-hsc.dts |
> > 51 ++++++++++ arch/arm/boot/dts/imx53-kp.dtsi    | 190
> > +++++++++++++++++++++++++++++++++++++ 4 files changed, 389
> > insertions(+) create mode 100644 arch/arm/boot/dts/imx53-kp-ddc.dts
> >  create mode 100644 arch/arm/boot/dts/imx53-kp-hsc.dts
> >  create mode 100644 arch/arm/boot/dts/imx53-kp.dtsi
> >=20
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index fbc04b0db781..00854a5b6ac4 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -360,6 +360,8 @@ dtb-$(CONFIG_SOC_IMX51) +=3D \
> >  dtb-$(CONFIG_SOC_IMX53) +=3D \
> >  	imx53-ard.dtb \
> >  	imx53-cx9020.dtb \
> > +	imx53-kp-ddc.dtb \
> > +	imx53-kp-hsc.dtb \
> >  	imx53-m53evk.dtb \
> >  	imx53-mba53.dtb \
> >  	imx53-ppd.dtb \
> > diff --git a/arch/arm/boot/dts/imx53-kp-ddc.dts
> > b/arch/arm/boot/dts/imx53-kp-ddc.dts new file mode 100644
> > index 000000000000..acaf477a52c5
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx53-kp-ddc.dts
> > @@ -0,0 +1,146 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2018
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + */
> > +
> > +/dts-v1/;
> > +#include "imx53-kp.dtsi"
> > +
> > +/ {
> > +	model =3D "K+P imx53 DDC";
> > +	compatible =3D "kiebackpeter,imx53-ddc", "fsl,imx53";
> > +
> > +	backlight_lcd: backlight {
> > +		compatible =3D "pwm-backlight";
> > +		pwms =3D <&pwm2 0 50000>;
> > +		power-supply =3D <&reg_backlight>;
> > +		brightness-levels =3D <0 24 28 32 36
> > +				     40 44 48 52 56
> > +				     60 64 68 72 76
> > +				     80 84 88 92 96 100>;
> > +		default-brightness-level =3D <20>;
> > +	};
> > +
> > +	lcd_display: disp1 { =20
>=20
> display for node node.

I assume that I shall change disp1 -> display ?

>=20
> > +		compatible =3D "fsl,imx-parallel-display";
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +		interface-pix-fmt =3D "rgb24";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&pinctrl_disp>;
> > +
> > +		port@0 {
> > +			reg =3D <0>;
> > +
> > +			display1_in: endpoint {
> > +				remote-endpoint =3D <&ipu_di1_disp1>;
> > +			};
> > +		};
> > +
> > +		port@1 {
> > +			reg =3D <1>;
> > +
> > +			lcd_display_out: endpoint {
> > +				remote-endpoint =3D <&lcd_panel_in>;
> > +			};
> > +		};
> > +	};
> > +
> > +	lcd_panel: lcd-panel {
> > +		compatible =3D "koe,tx14d24vm1bpa"; =20
>=20
> Undefined compatible?

The display's in question "koe,tx14d24vm1bpa" compatible has been
ack'ed by Rob Herring and Thierry promised to apply it to his tree:

https://patchwork.kernel.org/patch/10391589/


The v2 of this patch:
https://patchwork.kernel.org/patch/10436007/

>=20
> > +		backlight =3D <&backlight_lcd>;
> > +		power-supply =3D <&reg_3v3>;
> > +
> > +		port {
> > +			lcd_panel_in: endpoint {
> > +				remote-endpoint =3D
> > <&lcd_display_out>;
> > +			};
> > +		};
> > +	};
> > +
> > +	reg_backlight: regulator-backlight {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "backlight-supply";
> > +		regulator-min-microvolt =3D <15000000>;
> > +		regulator-max-microvolt =3D <15000000>;
> > +		regulator-always-on;
> > +	};
> > +};
> > +
> > +&i2c3 {
> > +	adc@48 {
> > +		compatible =3D "ti,ads1015";
> > +		reg =3D <0x48>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		channel@4 {
> > +			reg =3D <4>;
> > +			ti,gain =3D <2>;
> > +			ti,datarate =3D <4>;
> > +		};
> > +
> > +		channel@6 {
> > +			reg =3D <6>;
> > +			ti,gain =3D <2>;
> > +			ti,datarate =3D <4>;
> > +		};
> > +	};
> > +
> > +	gpio_expander2@21 { =20
>=20
> Use hyphen instead of underscore in node name.

Ok. I will change this globally. And send v3.

>=20
> > +		compatible =3D "nxp,pcf8574";
> > +		reg =3D <0x21>;
> > +		interrupts =3D <109>;
> > +		#gpio-cells =3D <2>;
> > +		gpio-controller;
> > +	};
> > +};
> > +
> > +&iomuxc {
> > +	imx53-kp-ddc {
> > +		pinctrl_disp: dispgrp {
> > +			fsl,pins =3D <
> > +
> > MX53_PAD_EIM_A16__IPU_DI1_DISP_CLK      0x4
> > +
> > MX53_PAD_EIM_DA10__IPU_DI1_PIN15        0x4
> > +
> > MX53_PAD_EIM_DA9__IPU_DISP1_DAT_0       0x4
> > +
> > MX53_PAD_EIM_DA8__IPU_DISP1_DAT_1       0x4
> > +
> > MX53_PAD_EIM_DA7__IPU_DISP1_DAT_2       0x4
> > +
> > MX53_PAD_EIM_DA6__IPU_DISP1_DAT_3       0x4
> > +
> > MX53_PAD_EIM_DA5__IPU_DISP1_DAT_4       0x4
> > +
> > MX53_PAD_EIM_DA4__IPU_DISP1_DAT_5       0x4
> > +
> > MX53_PAD_EIM_DA3__IPU_DISP1_DAT_6       0x4
> > +
> > MX53_PAD_EIM_DA2__IPU_DISP1_DAT_7       0x4
> > +
> > MX53_PAD_EIM_DA1__IPU_DISP1_DAT_8       0x4
> > +
> > MX53_PAD_EIM_DA0__IPU_DISP1_DAT_9       0x4
> > +
> > MX53_PAD_EIM_EB1__IPU_DISP1_DAT_10      0x4
> > +
> > MX53_PAD_EIM_EB0__IPU_DISP1_DAT_11      0x4
> > +
> > MX53_PAD_EIM_A17__IPU_DISP1_DAT_12      0x4
> > +
> > MX53_PAD_EIM_A18__IPU_DISP1_DAT_13      0x4
> > +
> > MX53_PAD_EIM_A19__IPU_DISP1_DAT_14      0x4
> > +
> > MX53_PAD_EIM_A20__IPU_DISP1_DAT_15      0x4
> > +
> > MX53_PAD_EIM_A21__IPU_DISP1_DAT_16      0x4
> > +
> > MX53_PAD_EIM_A22__IPU_DISP1_DAT_17      0x4
> > +
> > MX53_PAD_EIM_A23__IPU_DISP1_DAT_18      0x4
> > +
> > MX53_PAD_EIM_A24__IPU_DISP1_DAT_19      0x4
> > +
> > MX53_PAD_EIM_D31__IPU_DISP1_DAT_20      0x4
> > +
> > MX53_PAD_EIM_D30__IPU_DISP1_DAT_21      0x4
> > +
> > MX53_PAD_EIM_D26__IPU_DISP1_DAT_22      0x4
> > +
> > MX53_PAD_EIM_D27__IPU_DISP1_DAT_23      0x4
> > +				MX53_PAD_GPIO_1__PWM2_PWMO 0x4
> > +			>;
> > +		};
> > +	};
> > +};
> > +
> > +&ipu_di1_disp1 {
> > +	remote-endpoint =3D <&display1_in>;
> > +};
> > +
> > +&fec {
> > +	status =3D "okay";
> > +}; =20
>=20
> Sort the labeled nodes alphabetically in label name.
>=20
> > +
> > +&pmic {
> > +	fsl,mc13xxx-uses-touch;
> > +};
> > diff --git a/arch/arm/boot/dts/imx53-kp-hsc.dts
> > b/arch/arm/boot/dts/imx53-kp-hsc.dts new file mode 100644
> > index 000000000000..d68cdd5da819
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx53-kp-hsc.dts
> > @@ -0,0 +1,51 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2018
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + */
> > +
> > +/dts-v1/;
> > +#include "imx53-kp.dtsi"
> > +
> > +/ {
> > +	model =3D "K+P imx53 HSC";
> > +	compatible =3D "kiebackpeter,imx53-hsc", "fsl,imx53";
> > +};
> > +
> > +&fec {
> > +	status =3D "okay"; =20
>=20
> Have a newline between property list and child node.
>=20
> > +	fixed-link { /* RMII fixed link to LAN9303 */
> > +		speed =3D <100>;
> > +		full-duplex;
> > +	};
> > +};
> > +
> > +&i2c3 {
> > +	switch: switch@a {
> > +		compatible =3D "smsc,lan9303-i2c";
> > +		reg =3D <0xa>;
> > +		reset-gpios =3D <&gpio7 6 GPIO_ACTIVE_LOW>;
> > +		reset-duration =3D <400>;
> > +
> > +		ports {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +
> > +			port@0 { /* RMII fixed link to master */
> > +				reg =3D <0>;
> > +				label =3D "cpu";
> > +				ethernet =3D <&fec>;
> > +			};
> > +
> > +			port@1 { /* external port 1 */
> > +				reg =3D <1>;
> > +				label =3D "lan1";
> > +			};
> > +
> > +			port@2 { /* external port 2 */
> > +				reg =3D <2>;
> > +				label =3D "lan2";
> > +			};
> > +		};
> > +	};
> > +};
> > diff --git a/arch/arm/boot/dts/imx53-kp.dtsi
> > b/arch/arm/boot/dts/imx53-kp.dtsi new file mode 100644
> > index 000000000000..f87266843842
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx53-kp.dtsi
> > @@ -0,0 +1,190 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2018
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + */
> > +
> > +/dts-v1/;
> > +#include "imx53-tqma53.dtsi"
> > +#include <dt-bindings/input/input.h>
> > +
> > +/ {
> > +	buzzer {
> > +		compatible =3D "pwm-beeper";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&pinctrl_buzzer>;
> > + =20
>=20
> Drop this newline.
>=20
> > +		pwms =3D <&pwm1 0 500000>;
> > +	};
> > +
> > +	gpio_buttons { =20
>=20
> Use hyphen.
>=20
> > +		compatible =3D "gpio-keys";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&pinctrl_gpiobuttons>;
> > +
> > +		button_kalt { =20
>=20
> Ditto
>=20
> > +			label =3D "Kaltstart";
> > +			linux,code =3D <KEY_F6>;
> > +			gpios =3D <&gpio2 26 GPIO_ACTIVE_HIGH>;
> > +		};
> > +
> > +		button_pwr { =20
>=20
> Ditto
>=20
> > +			label =3D "PowerFailInterrupt";
> > +			linux,code =3D <KEY_F7>;
> > +			gpios =3D <&gpio3 22 GPIO_ACTIVE_HIGH>;
> > +		};
> > +	};
> > +
> > +	leds {
> > +		compatible =3D "gpio-leds";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&pinctrl_leds>;
> > +
> > +		led_bus { =20
>=20
> Ditto
>=20
> > +			label =3D "bus";
> > +			gpios =3D <&gpio2 30 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger =3D "gpio";
> > +			default-state =3D "off";
> > +		};
> > +
> > +		led_error { =20
>=20
> Ditto
>=20
> > +			label =3D "error";
> > +			gpios =3D <&gpio3 28 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger =3D "gpio";
> > +			default-state =3D "off";
> > +		};
> > +
> > +		led_flash { =20
>=20
> Ditto
>=20
> > +			label =3D "flash";
> > +			gpios =3D <&gpio5 0 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger =3D "heartbeat";
> > +		};
> > +	};
> > +
> > +	reg_3v3: regulator-3v3 {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "3V3";
> > +		regulator-min-microvolt =3D <3300000>;
> > +		regulator-max-microvolt =3D <3300000>;
> > +		regulator-always-on;
> > +	};
> > +};
> > +
> > +&can1 {
> > +	status =3D "okay";
> > +};
> > +
> > +&can2 {
> > +	status =3D "okay";
> > +};
> > +
> > +&i2c3 {
> > +	status =3D "okay";
> > +
> > +	gpio_expander1@22 { =20
>=20
> Ditto
>=20
> Shawn
>=20
> > +		compatible =3D "nxp,pcf8574";
> > +		reg =3D <0x22>;
> > +		interrupts =3D <109>;
> > +		#gpio-cells =3D <2>;
> > +		gpio-controller;
> > +	};
> > +
> > +	rtc@51 {
> > +		compatible =3D "nxp,pcf8563";
> > +		reg =3D <0x51>;
> > +	};
> > +};
> > +
> > +&iomuxc {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_kp_common>;
> > +
> > +	imx53-kp-common {
> > +		pinctrl_buzzer: buzzergrp {
> > +			fsl,pins =3D <
> > +				MX53_PAD_SD1_DATA3__PWM1_PWMO 0x1e4
> > +			>;
> > +		};
> > +
> > +		pinctrl_gpiobuttons: gpiobuttonsgrp {
> > +			fsl,pins =3D <
> > +				MX53_PAD_EIM_RW__GPIO2_26 0x1e4
> > +				MX53_PAD_EIM_D22__GPIO3_22 0x1e4
> > +			>;
> > +		};
> > +
> > +		pinctrl_kp_common: kpcommongrp {
> > +			fsl,pins =3D <
> > +				MX53_PAD_EIM_CS0__GPIO2_23 0x1e4
> > +				MX53_PAD_GPIO_19__GPIO4_5  0x1e4
> > +				MX53_PAD_PATA_DATA6__GPIO2_6 0x1e4
> > +				MX53_PAD_PATA_DATA7__GPIO2_7 0xe0
> > +				MX53_PAD_CSI0_DAT14__GPIO6_0 0x1e4
> > +				MX53_PAD_CSI0_DAT16__GPIO6_2 0x1e4
> > +				MX53_PAD_CSI0_DAT18__GPIO6_4 0x1e4
> > +				MX53_PAD_EIM_D17__GPIO3_17 0x1e4
> > +				MX53_PAD_EIM_D18__GPIO3_18 0x1e4
> > +				MX53_PAD_EIM_D21__GPIO3_21 0x1e4
> > +				MX53_PAD_EIM_D29__GPIO3_29 0x1e4
> > +				MX53_PAD_EIM_DA11__GPIO3_11 0x1e4
> > +				MX53_PAD_EIM_DA13__GPIO3_13 0x1e4
> > +				MX53_PAD_EIM_DA14__GPIO3_14 0x1e4
> > +				MX53_PAD_SD1_DATA0__GPIO1_16 0x1e4
> > +				MX53_PAD_SD1_CMD__GPIO1_18 0x1e4
> > +				MX53_PAD_SD1_CLK__GPIO1_20 0x1e4
> > +			>;
> > +		};
> > +
> > +		pinctrl_leds: ledgrp {
> > +			fsl,pins =3D <
> > +				MX53_PAD_EIM_EB2__GPIO2_30 0x1d4
> > +				MX53_PAD_EIM_D28__GPIO3_28 0x1d4
> > +				MX53_PAD_EIM_WAIT__GPIO5_0 0x1d4
> > +			>;
> > +		};
> > +
> > +		pinctrl_uart4: uart4grp {
> > +			fsl,pins =3D <
> > +				MX53_PAD_CSI0_DAT12__UART4_TXD_MUX
> > 0x1e4
> > +				MX53_PAD_CSI0_DAT13__UART4_RXD_MUX
> > 0x1e4
> > +			>;
> > +		};
> > +	};
> > +};
> > +
> > +&pinctrl_uart1 {
> > +	fsl,pins =3D <
> > +		MX53_PAD_EIM_D23__GPIO3_23 0x1e4
> > +		MX53_PAD_EIM_EB3__GPIO2_31 0x1e4
> > +		MX53_PAD_EIM_D24__GPIO3_24 0x1e4
> > +		MX53_PAD_EIM_D25__GPIO3_25 0x1e4
> > +		MX53_PAD_EIM_D19__GPIO3_19 0x1e4
> > +		MX53_PAD_EIM_D20__GPIO3_20 0x1e4
> > +	>;
> > +};
> > +
> > +&uart1 {
> > +	status =3D "okay";
> > +};
> > +
> > +&uart2 {
> > +	status =3D "okay";
> > +};
> > +
> > +&uart3 {
> > +	status =3D "okay";
> > +};
> > +
> > +&uart4 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_uart4>;
> > +	status =3D "okay";
> > +};
> > +
> > +&usbh1 {
> > +	status =3D "okay";
> > +};
> > +
> > +&usbphy0 {
> > +	status =3D "disabled";
> > +};
> > --=20
> > 2.11.0
> >  =20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/LBm94ZtV.5QfxqQaGW3nOfC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlsfrkkACgkQAR8vZIA0
zr22pAgAuUDnodR569siVph07sJVwy70lE3vPZtmSFPZ8Dh4HTtWkd/R4WIyd+9Q
KsMbLtsFeIQk7Yg7iyx6JHYiOIemoHqNLDQC7DUwnJZcesBktrv2rDT8y2XRvtQB
EZg2OAsDr2wPMKZ0tp/TeFAnwu93pz0Azzv+DAe9GI4hYNAsxr/6VBa0sVqe8puq
p2KV3lEpbPu3C2n3V7XA2qZ4RyMyYfQ5/MvBuQvkRWokG/ayilTJdvoB4kt6zl+H
Phl2mqZND42X3Pzbwc5FtoYJOtFPEdbX606AgfPGaLbILfu+zdBDcSWAQrQJ9woC
h5Xp2+qSS9wrjD9Jp4as5MMaXARNrw==
=62ik
-----END PGP SIGNATURE-----

--Sig_/LBm94ZtV.5QfxqQaGW3nOfC--
