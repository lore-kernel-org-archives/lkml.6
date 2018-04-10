Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753960AbeDJOI6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:08:58 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:57512 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753256AbeDJOI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:08:56 -0400
X-Auth-Info: /R5ZlowpKHx8Bv9l5QjLrsO6ArvFt03CzieZFssUAaU=
Date: Tue, 10 Apr 2018 16:08:40 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ARM: dts: tpc: Device tree description of the iMX6Q
 TPC board
Message-ID: <20180410160840.72c4e65e@jawa>
In-Reply-To: <20180410134558.fzilfgqvavbdiget@rob-hp-laptop>
References: <20180403165945.3981-1-lukma@denx.de>
        <20180410134558.fzilfgqvavbdiget@rob-hp-laptop>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kDkFP1rrHh_3En2Gd3mCONT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kDkFP1rrHh_3En2Gd3mCONT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

> On Tue, Apr 03, 2018 at 06:59:45PM +0200, Lukasz Majewski wrote:
> > This commit adds device tree description of Kieback & Peter GmbH
> > iMX6Q TPC board.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> >=20
> > ---
> > Changes for v2:
> > - SDPX license identifiers used
> > - Separate regulators
> > - Proper beeper driver
> > - Use of the lcd panel (with compatible) instead of timings
> > provided in device tree
> > - Add IRQ types (like IRQ_TYPE_EDGE_FALLING) and GPIO active levels
> > (like GPIO_ACTIVE_HIGH)
> > - Remove not needed nodes
> > - Make W=3D1 dtbs compilation with no errors
> > ---
> >  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
> >  arch/arm/boot/dts/Makefile                         |   1 +
> >  arch/arm/boot/dts/imx6q-kp-tpc.dts                 |  23 ++
> >  arch/arm/boot/dts/imx6q-kp.dtsi                    | 460
> > +++++++++++++++++++++ 4 files changed, 485 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/imx6q-kp-tpc.dts
> >  create mode 100644 arch/arm/boot/dts/imx6q-kp.dtsi
> >=20
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > b/Documentation/devicetree/bindings/vendor-prefixes.txt index
> > ae850d6c0ad3..8ff7eadc8bef 100644 ---
> > a/Documentation/devicetree/bindings/vendor-prefixes.txt +++
> > b/Documentation/devicetree/bindings/vendor-prefixes.txt @@ -181,6
> > +181,7 @@ karo	Ka-Ro electronics GmbH keithkoep	Keith
> > & Koep GmbH keymile	Keymile GmbH
> >  khadas	Khadas
> > +kiebackpeter    Kieback & Peter GmbH
> >  kinetic Kinetic Technologies
> >  kingnovel	Kingnovel Technology Co., Ltd.
> >  kosagi	Sutajio Ko-Usagi PTE Ltd.
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index ade7a38543dc..c148c4cf28f2 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -459,6 +459,7 @@ dtb-$(CONFIG_SOC_IMX6Q) +=3D \
> >  	imx6q-icore-ofcap10.dtb \
> >  	imx6q-icore-ofcap12.dtb \
> >  	imx6q-icore-rqs.dtb \
> > +	imx6q-kp-tpc.dtb \
> >  	imx6q-marsboard.dtb \
> >  	imx6q-mccmon6.dtb \
> >  	imx6q-nitrogen6x.dtb \
> > diff --git a/arch/arm/boot/dts/imx6q-kp-tpc.dts
> > b/arch/arm/boot/dts/imx6q-kp-tpc.dts new file mode 100644
> > index 000000000000..b5646040b516
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6q-kp-tpc.dts
> > @@ -0,0 +1,23 @@
> > +/*
> > + * Copyright 2018
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + *
> > + * SPDX-License-Identifier: (GPL-2.0+ OR MIT) =20
>=20
> This goes on the first line. checkpatch.pl will tell you this.

I've today sent the v4 of this patch. It was fixed in this version.

>=20
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "imx6q-kp.dtsi"
> > +
> > +/ {
> > +	model =3D "Freescale i.MX6 Qwuad K+P TPC Board";
> > +	compatible =3D "kiebackpeter,imx6q-tpc", "fsl,imx6q";
> > +
> > +	memory: memory@10000000 {
> > +		reg =3D <0x10000000 0x40000000>;
> > +	};
> > +};
> > +
> > +&ipu1_di0_disp0 {
> > +	remote-endpoint =3D <&lcd_display_in>;
> > +};
> > diff --git a/arch/arm/boot/dts/imx6q-kp.dtsi
> > b/arch/arm/boot/dts/imx6q-kp.dtsi new file mode 100644
> > index 000000000000..acf6d40ca227
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6q-kp.dtsi
> > @@ -0,0 +1,460 @@
> > +/*
> > + * Copyright 2018
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + *
> > + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "imx6q.dtsi"
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/pwm/pwm.h>
> > +#include <dt-bindings/sound/fsl-imx-audmux.h>
> > +
> > +/ {
> > +	backlight_lcd: backlight-lcd {
> > +		compatible =3D "pwm-backlight";
> > +		pwms =3D <&pwm1 0 5000000>;
> > +		brightness-levels =3D <  0   1   2   3   4   5   6
> > 7   8   9 =20
>=20
> There's a property now so you don't have to list every single value
> and can just say "<0 255>". It's not landed yet though. See
> "dt-bindings: pwm-backlight: add a num-interpolation-steps property".=20

According to the patch:
https://patchwork.kernel.org/patch/10205247/

This should be:

	brightness-levels =3D <0 255>;
	num-interpolation-steps =3D <255>;
=09

>=20
> > +				      10  11  12  13  14  15  16
> > 17  18  19
> > +				      20  21  22  23  24  25  26
> > 27  28  29
> > +				      30  31  32  33  34  35  36
> > 37  38  39
> > +				      40  41  42  43  44  45  46
> > 47  48  49
> > +				      50  51  52  53  54  55  56
> > 57  58  59
> > +				      60  61  62  63  64  65  66
> > 67  68  69
> > +				      70  71  72  73  74  75  76
> > 77  78  79
> > +				      80  81  82  83  84  85  86
> > 87  88  89
> > +				      90  91  92  93  94  95  96
> > 97  98  99
> > +				     100 101 102 103 104 105 106
> > 107 108 109
> > +				     110 111 112 113 114 115 116
> > 117 118 119
> > +				     120 121 122 123 124 125 126
> > 127 128 129
> > +				     130 131 132 133 134 135 136
> > 137 138 139
> > +				     140 141 142 143 144 145 146
> > 147 148 149
> > +				     150 151 152 153 154 155 156
> > 157 158 159
> > +				     160 161 162 163 164 165 166
> > 167 168 169
> > +				     170 171 172 173 174 175 176
> > 177 178 179
> > +				     180 181 182 183 184 185 186
> > 187 188 189
> > +				     190 191 192 193 194 195 196
> > 197 198 199
> > +				     200 201 202 203 204 205 206
> > 207 208 209
> > +				     210 211 212 213 214 215 216
> > 217 218 219
> > +				     220 221 222 223 224 225 226
> > 227 228 229
> > +				     230 231 232 233 234 235 236
> > 237 238 239
> > +				     240 241 242 243 244 245 246
> > 247 248 249
> > +				     250 251 252 253 254 255>;
> > +		default-brightness-level =3D <250>;
> > +		status =3D "okay"; =20
>=20
> This isn't an existing node, so you don't need to override status.

Right. Non existent status equals to "okay".

>=20
> > +	};
> > +
> > +	beeper {
> > +		compatible =3D "pwm-beeper";
> > +		pwms =3D <&pwm2 0 500000>; //2kHz
> > +	};
> > +
> > +	lcd_display: disp0 {
> > +		compatible =3D "fsl,imx-parallel-display";
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +		interface-pix-fmt =3D "rgb24";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&pinctrl_ipu1>;
> > +		status =3D "okay"; =20
>=20
> Necessary?

I think that this can be removed.

>=20
> > +
> > +		port@0 {
> > +			reg =3D <0>;
> > +
> > +			lcd_display_in: endpoint {
> > +				remote-endpoint =3D
> > <&ipu1_di0_disp0>;
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
> > +		compatible =3D "auo,g070vvn01";
> > +		backlight =3D <&backlight_lcd>;
> > +		bus-format-override =3D "rgb565"; =20
>=20
> This is not documented.

I've removed it in v4 of this patch. It is indeed not documented and
not needed.

>=20
> > +		power-supply =3D <&reg_display>;
> > +
> > +		port {
> > +			lcd_panel_in: endpoint {
> > +				remote-endpoint =3D
> > <&lcd_display_out>;
> > +			};
> > +		};
> > +	};
> > +
> > +	leds {
> > +		compatible =3D "gpio-leds";
> > +
> > +		green {
> > +			label =3D "led1";
> > +			gpios =3D <&gpio3 16 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger =3D "gpio";
> > +			default-state =3D "off";
> > +		};
> > +
> > +		red {
> > +			label =3D "led0";
> > +			gpios =3D <&gpio3 23 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger =3D "gpio";
> > +			default-state =3D "off";
> > +		};
> > +	};
> > +
> > +	reg_3p3v: regulator-3p3v {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "3P3V";
> > +		regulator-min-microvolt =3D <3300000>;
> > +		regulator-max-microvolt =3D <3300000>;
> > +		regulator-always-on;
> > +	};
> > +
> > +	reg_audio: regulator-audio {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "sgtl5000-supply";
> > +		gpio =3D <&gpio6 31 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +		regulator-always-on;
> > +	};
> > +
> > +	reg_display: regulator-display {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "display-supply";
> > +		regulator-min-microvolt =3D <3300000>;
> > +		regulator-max-microvolt =3D <3300000>;
> > +		regulator-always-on;
> > +	};
> > +
> > +	reg_usb_h1_vbus: regulator-usb_h1_vbus {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "usb_h1_vbus";
> > +		regulator-min-microvolt =3D <5000000>;
> > +		regulator-max-microvolt =3D <5000000>;
> > +		enable-active-high;
> > +	};
> > +
> > +	sound {
> > +		compatible =3D "simple-audio-card";
> > +		simple-audio-card,name =3D "imx6q-sgtl5000-audio";
> > +		simple-audio-card,format =3D "i2s";
> > +		simple-audio-card,bitclock-master =3D <&codec_dai>;
> > +		simple-audio-card,frame-master =3D <&codec_dai>;
> > +
> > +		cpu_dai: simple-audio-card,cpu {
> > +			sound-dai =3D <&ssi1>;
> > +		};
> > +
> > +		codec_dai: simple-audio-card,codec {
> > +			sound-dai =3D <&codec>;
> > +		};
> > +	};
> > +};
> > +
> > +&audmux {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_audmux>;
> > +	status =3D "okay";
> > +
> > +	ssi1 {
> > +		fsl,audmux-port =3D <0>;
> > +		fsl,port-config =3D <
> > +			(IMX_AUDMUX_V2_PTCR_SYN |
> > +			IMX_AUDMUX_V2_PTCR_TFSEL(2) |
> > +			IMX_AUDMUX_V2_PTCR_TCSEL(2) |
> > +			IMX_AUDMUX_V2_PTCR_TFSDIR |
> > +			IMX_AUDMUX_V2_PTCR_TCLKDIR)
> > +			IMX_AUDMUX_V2_PDCR_RXDSEL(2)
> > +		>;
> > +	};
> > +
> > +	aud3 {
> > +		fsl,audmux-port =3D <2>;
> > +		fsl,port-config =3D <
> > +			IMX_AUDMUX_V2_PTCR_SYN
> > +			IMX_AUDMUX_V2_PDCR_RXDSEL(0)
> > +		>;
> > +	};
> > +};
> > +
> > +&fec {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_enet>;
> > +	phy-mode =3D "rgmii";
> > +	fsl,magic-packet;
> > +	status =3D "okay";
> > +};
> > +
> > +&i2c1 {
> > +	clock-frequency =3D <400000>;
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_i2c1>;
> > +	status =3D "okay";
> > +
> > +	goodix_ts@5d { =20
>=20
> touchscreen@5d

Ok.

>=20
> > +		compatible =3D "goodix,gt911";
> > +		reg =3D <0x5d>;
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&pinctrl_ts>;
> > +		interrupt-parent =3D <&gpio1>;
> > +		interrupts =3D <9 IRQ_TYPE_EDGE_FALLING>;
> > +		irq-gpios =3D <&gpio1 9 GPIO_ACTIVE_HIGH>;
> > +		reset-gpios =3D <&gpio5 2 GPIO_ACTIVE_HIGH>;
> > +	};
> > +
> > +	rx8025@32 {
> > +		compatible =3D "dallas,rx8025";
> > +		reg =3D <0x32>;
> > +	};
> > +};
> > +
> > +&i2c2 {
> > +	clock-frequency =3D <400000>;
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_i2c2>;
> > +	status =3D "okay";
> > +
> > +	codec: sgtl5000@a { =20
>=20
> audio-codec@a

Ok.

>=20
> > +		compatible =3D "fsl,sgtl5000";
> > +		#sound-dai-cells =3D <0>;
> > +		reg =3D <0x0a>;
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&pinctrl_codec>;
> > +		clocks =3D <&clks IMX6QDL_CLK_CKO>;
> > +		VDDA-supply =3D <&reg_3p3v>;
> > +		VDDIO-supply =3D <&reg_3p3v>;
> > +	};
> > +};
> > +
> > +&iomuxc {
> > +	pinctrl_audmux: audmuxgrp {
> > +		fsl,pins =3D <
> > +
> > MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
> > +
> > MX6QDL_PAD_CSI0_DAT4__AUD3_TXC		0x130b0
> > +
> > MX6QDL_PAD_CSI0_DAT5__AUD3_TXD		0x110b0
> > +			MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS
> > 0x130b0
> > +		>;
> > +	};
> > +
> > +	pinctrl_codec: codecgrp {
> > +		fsl,pins =3D <
> > +			MX6QDL_PAD_EIM_BCLK__GPIO6_IO31   0x1b0b0
> > +			/* sgtl5000 sys_mclk clock routed to CLKO1
> > */
> > +			MX6QDL_PAD_GPIO_0__CCM_CLKO1      0x000b0
> > +		>;
> > +	};
> > +
> > +	pinctrl_enet: enetgrp {
> > +		fsl,pins =3D <
> > +			MX6QDL_PAD_ENET_MDIO__ENET_MDIO
> > 0x1b0b0
> > +
> > MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
> > +			MX6QDL_PAD_RGMII_TXC__RGMII_TXC
> > 0x1b0b0
> > +			MX6QDL_PAD_RGMII_TD0__RGMII_TD0
> > 0x1b0b0
> > +			MX6QDL_PAD_RGMII_TD1__RGMII_TD1
> > 0x1b0b0
> > +			MX6QDL_PAD_RGMII_TD2__RGMII_TD2
> > 0x1b0b0
> > +			MX6QDL_PAD_RGMII_TD3__RGMII_TD3
> > 0x1b0b0
> > +
> > MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b0b0
> > +
> > MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
> > +			MX6QDL_PAD_RGMII_RXC__RGMII_RXC
> > 0x1b0b0
> > +			MX6QDL_PAD_RGMII_RD0__RGMII_RD0
> > 0x1b0b0
> > +			MX6QDL_PAD_RGMII_RD1__RGMII_RD1
> > 0x1b0b0
> > +			MX6QDL_PAD_RGMII_RD2__RGMII_RD2
> > 0x1b0b0
> > +			MX6QDL_PAD_RGMII_RD3__RGMII_RD3
> > 0x1b0b0
> > +
> > MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
> > +			MX6QDL_PAD_GPIO_16__ENET_REF_CLK 0x4001b0a8
> > +		>;
> > +	};
> > +
> > +	pinctrl_flexcan1: can1grp {
> > +		fsl,pins =3D <
> > +			MX6QDL_PAD_GPIO_7__FLEXCAN1_TX
> > 0x1b0b0
> > +			MX6QDL_PAD_GPIO_8__FLEXCAN1_RX
> > 0x1b0b0
> > +		>;
> > +	};
> > +
> > +	pinctrl_flexcan2: can2grp {
> > +		fsl,pins =3D <
> > +			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX
> > 0x1b0b0
> > +			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX
> > 0x1b0b0
> > +		>;
> > +	};
> > +
> > +	pinctrl_i2c1: i2c1grp {
> > +		fsl,pins =3D <
> > +			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA
> > 0x4001b8b1
> > +			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL
> > 0x4001b8b1
> > +		>;
> > +	};
> > +
> > +	pinctrl_i2c2: i2c2grp {
> > +		fsl,pins =3D <
> > +			MX6QDL_PAD_KEY_COL3__I2C2_SCL
> > 0x4001b8b1
> > +			MX6QDL_PAD_KEY_ROW3__I2C2_SDA
> > 0x4001b8b1
> > +		 >;
> > +	};
> > +
> > +	pinctrl_ipu1: ipu1grp {
> > +		fsl,pins =3D <
> > +			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK
> > 0x10
> > +			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15
> > 0x10
> > +			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02
> > 0x10
> > +			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22
> > 0x10
> > +			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23
> > 0x10
> > +		>;
> > +	};
> > +
> > +	pinctrl_pwm1: pwm1grp {
> > +		fsl,pins =3D <
> > +
> > MX6QDL_PAD_SD1_DAT3__PWM1_OUT		0x1b0b1
> > +		>;
> > +	};
> > +
> > +	pinctrl_pwm2: pwm2grp {
> > +		fsl,pins =3D <
> > +
> > MX6QDL_PAD_SD1_DAT2__PWM2_OUT		0x1b0b1
> > +		>;
> > +	};
> > +
> > +	pinctrl_ts: tsgrp {
> > +		fsl,pins =3D <
> > +			MX6QDL_PAD_GPIO_9__GPIO1_IO09 0x1b0b0
> > +			MX6QDL_PAD_EIM_A25__GPIO5_IO02 0x1b0b0
> > +		>;
> > +	};
> > +
> > +	pinctrl_uart1: uart1grp {
> > +		fsl,pins =3D <
> > +			MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA
> > 0x1b0b1
> > +			MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA
> > 0x1b0b1
> > +		>;
> > +	};
> > +
> > +	pinctrl_uart2: uart2grp {
> > +		fsl,pins =3D <
> > +			MX6QDL_PAD_EIM_D26__UART2_TX_DATA
> > 0x1b0b1
> > +			MX6QDL_PAD_EIM_D27__UART2_RX_DATA
> > 0x1b0b1
> > +			MX6QDL_PAD_EIM_D28__UART2_CTS_B
> > 0x1b0b1
> > +			MX6QDL_PAD_EIM_D29__UART2_RTS_B
> > 0x1b0b1
> > +		>;
> > +	};
> > +
> > +	pinctrl_usdhc2: usdhc2grp {
> > +		fsl,pins =3D <
> > +			MX6QDL_PAD_SD2_CMD__SD2_CMD
> > 0x17059
> > +			MX6QDL_PAD_SD2_CLK__SD2_CLK
> > 0x10059
> > +
> > MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17059
> > +
> > MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
> > +
> > MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
> > +
> > MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
> > +		>;
> > +	};
> > +
> > +	pinctrl_usdhc4: usdhc4grp {
> > +		fsl,pins =3D <
> > +			MX6QDL_PAD_SD4_CMD__SD4_CMD
> > 0x17059
> > +			MX6QDL_PAD_SD4_CLK__SD4_CLK
> > 0x10059
> > +
> > MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x17059
> > +
> > MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x17059
> > +
> > MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x17059
> > +
> > MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x17059
> > +
> > MX6QDL_PAD_SD4_DAT4__SD4_DATA4		0x17059
> > +
> > MX6QDL_PAD_SD4_DAT5__SD4_DATA5		0x17059
> > +
> > MX6QDL_PAD_SD4_DAT6__SD4_DATA6		0x17059
> > +
> > MX6QDL_PAD_SD4_DAT7__SD4_DATA7		0x17059
> > +		>;
> > +	};
> > +};
> > +
> > +&can1 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_flexcan1>;
> > +};
> > +
> > +&can2 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_flexcan2>;
> > +};
> > +
> > +&pwm1 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_pwm1>;
> > +	status =3D "okay";
> > +};
> > +
> > +&pwm2 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_pwm2>;
> > +	status =3D "okay";
> > +};
> > +
> > +&ssi1 {
> > +	status =3D "okay";
> > +};
> > +
> > +&uart1 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_uart1>;
> > +	status =3D "okay";
> > +};
> > +
> > +&uart2 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_uart2>;
> > +	uart-has-rtscts;
> > +};
> > +
> > +&usbh1 {
> > +	status =3D "okay";
> > +};
> > +
> > +&usdhc2 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_usdhc2>;
> > +	bus-width =3D <4>;
> > +	cd-gpios =3D <&gpio1 4 GPIO_ACTIVE_LOW>;
> > +	status =3D "okay";
> > +};
> > +
> > +&usdhc4 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_usdhc4>;
> > +	bus-width =3D <8>;
> > +	non-removable;
> > +	no-1-8-v;
> > +	keep-power-in-suspend;
> > +	status =3D "okay";
> > +};
> > +
> > +&wdog1 {
> > +	status =3D "okay";
> > +};
> > --=20
> > 2.11.0
> >  =20

Thanks for your review.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/kDkFP1rrHh_3En2Gd3mCONT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlrMxWgACgkQAR8vZIA0
zr3TEwf8DET7er070vCi+zrMwZxQ/odbtyX1MZ58LP/Wzq9QL0GSFYqLpYV2tl2o
bsMoAILf9h/QQdu380toyC13qc9ynQqoQyjDBwfRYPp3mLzMFNay8/zZ94aZ9sXZ
XjECjq0ZMBgCzXEwLe2SHwvksjEZm1KFZJYaHuzKcEr05YrigXgp/MZETYKRV028
EqhRj5W1+wrGN2StzMWqg+E1Me6hIs9NYo/njlpFxqfYmxHMZs17V3RiOZ0dfv1z
Ij3iIb13c2LW1943B85xHgQDaCWXh/kwUr9Lm3qMjcyQkcam/Jdo2F9SHQxaQvho
zZn5KRrFFQXA9bjDUEatvgUE1AE6sA==
=Uxzx
-----END PGP SIGNATURE-----

--Sig_/kDkFP1rrHh_3En2Gd3mCONT--
