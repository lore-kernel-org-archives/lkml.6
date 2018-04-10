Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeDJVfm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 17:35:42 -0400
Received: from 220.107.128.77.rev.sfr.net ([77.128.107.220]:53980 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeDJVfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 17:35:41 -0400
Message-ID: <7e026716a09cc267440cc93d597aefc329486c91.camel@paulk.fr>
Subject: Re: [PATCH 3/3] ARM: dts: sun7i: Add support for the Ainol AW1
 tablet
From: Paul Kocialkowski <contact@paulk.fr>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>
Date: Tue, 10 Apr 2018 23:35:27 +0200
In-Reply-To: <20180410213129.24049-3-contact@paulk.fr>
References: <20180410213129.24049-1-contact@paulk.fr>
         <20180410213129.24049-3-contact@paulk.fr>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-MzJknqR13bY6PyI7Vv4x"
X-Mailer: Evolution 3.28.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MzJknqR13bY6PyI7Vv4x
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 10 avril 2018 =C3=A0 23:31 +0200, Paul Kocialkowski a =C3=A9crit :
> This adds support for the Ainol AW1, an A20-based 7" tablet from
> Ainol.

This version didn't use the dedicated binding for the panel and will be
fixed in v2 and onwards.

> The following board-specific features are supported:
> * LCD panel
> * Backlight
> * USB OTG
> * Buttons
> * Touchscreen (doesn't work without non-free firmware)
> * Accelerometer
> * Battery
>=20
> The following are untested:
> * Audio output
> * Audio speakers
> * USB via SPCI connector
>=20
> The following are not supported:
> * Wi-Fi
> * Bluetooth
> * NAND
> * Audio via SPCI connector
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/boot/dts/Makefile                |   1 +
>  arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts | 358
> ++++++++++++++++++++++++++++++
>  2 files changed, 359 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 9f7133b6fba0..03bfacebfdbd 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -929,6 +929,7 @@ dtb-$(CONFIG_MACH_SUN6I) +=3D \
>  	sun6i-a31s-sinovoip-bpi-m2.dtb \
>  	sun6i-a31s-yones-toptech-bs1078-v2.dtb
>  dtb-$(CONFIG_MACH_SUN7I) +=3D \
> +	sun7i-a20-ainol-aw1.dtb \
>  	sun7i-a20-bananapi.dtb \
>  	sun7i-a20-bananapi-m1-plus.dtb \
>  	sun7i-a20-bananapro.dtb \
> diff --git a/arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
> b/arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
> new file mode 100644
> index 000000000000..697586991aea
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
> @@ -0,0 +1,358 @@
> +/*
> + * Copyright 2018 Paul Kocialkowski <contact@paulk.fr>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of
> the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the
> Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
> WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/dts-v1/;
> +#include "sun7i-a20.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pwm/pwm.h>
> +
> +/ {
> +	model =3D "Ainol AW1";
> +	compatible =3D "ainol,ainol-aw1", "allwinner,sun7i-a20";
> +
> +	aliases {
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	backlight: backlight {
> +		compatible =3D "pwm-backlight";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&backlight_enable_pin>;
> +		pwms =3D <&pwm 0 50000 PWM_POLARITY_INVERTED>;
> +		brightness-levels =3D <0 10 20 30 40 50 60 70 80 90
> 100>;
> +		default-brightness-level =3D <5>;
> +		enable-gpios =3D <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
> +	};
> +
> +	panel: panel {
> +		compatible =3D "innolux,at070tn92";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		power-supply =3D <&panel_power>;
> +		backlight =3D <&backlight>;
> +
> +		port@0 {
> +			reg =3D <0>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			panel_input: endpoint@0 {
> +				reg =3D <0>;
> +				remote-endpoint =3D <&tcon0_out_panel>;
> +			};
> +		};
> +	};
> +
> +	panel_power: panel_power {
> +		compatible =3D "regulator-fixed";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&panel_power_pin>;
> +		regulator-name =3D "panel-power";
> +		regulator-min-microvolt =3D <10400000>;
> +		regulator-max-microvolt =3D <10400000>;
> +		gpio =3D <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
> +		enable-active-high;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&codec {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&codec_pa_pin>;
> +	allwinner,pa-gpios =3D <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15 */
> +	status =3D "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply =3D <&reg_dcdc2>;
> +};
> +
> +&de {
> +	status =3D "okay";
> +};
> +
> +&ehci0 {
> +	status =3D "okay";
> +};
> +
> +&ehci1 {
> +	status =3D "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c0_pins_a>;
> +	status =3D "okay";
> +
> +	axp209: pmic@34 {
> +		reg =3D <0x34>;
> +		interrupt-parent =3D <&nmi_intc>;
> +		interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&i2c1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c1_pins_a>;
> +	status =3D "okay";
> +
> +	lis3dh: accelerometer@18 {
> +		compatible =3D "st,lis3dh-accel";
> +		reg =3D <0x18>;
> +		vdd-supply =3D <&reg_vcc3v3>;
> +		vddio-supply =3D <&reg_vcc3v3>;
> +		st,drdy-int-pin =3D <1>;
> +	};
> +};
> +
> +&i2c2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c2_pins_a>;
> +	status =3D "okay";
> +	clock-frequency =3D <400000>; /* 400 KHz required for GSL1680.
> */
> +
> +	gsl1680: touchscreen@40 {
> +		compatible =3D "silead,gsl1680";
> +		reg =3D <0x40>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&touchscreen_power_pin>;
> +		interrupt-parent =3D <&pio>;
> +		interrupts =3D <7 21 IRQ_TYPE_EDGE_FALLING>; /* EINT21
> (PH21) */
> +		power-gpios =3D <&pio 7 20 GPIO_ACTIVE_HIGH>; /* PH20
> */
> +		firmware-name =3D "gsl1680-ainol-aw1.fw";
> +		touchscreen-size-x =3D <480>;
> +		touchscreen-size-y =3D <800>;
> +		touchscreen-swapped-x-y;
> +		touchscreen-inverted-y;
> +		silead,max-fingers =3D <5>;
> +	};
> +};
> +
> +&lradc {
> +	vref-supply =3D <&reg_vcc3v0>;
> +	status =3D "okay";
> +
> +	button@571 {
> +		label =3D "Volume Up";
> +		linux,code =3D <KEY_VOLUMEUP>;
> +		channel =3D <0>;
> +		voltage =3D <571428>;
> +	};
> +
> +	button@761 {
> +		label =3D "Volume Down";
> +		linux,code =3D <KEY_VOLUMEDOWN>;
> +		channel =3D <0>;
> +		voltage =3D <761904>;
> +	};
> +
> +	button@952 {
> +		label =3D "Home";
> +		linux,code =3D <KEY_HOME>;
> +		channel =3D <0>;
> +		voltage =3D <952380>;
> +	};
> +};
> +
> +&mmc0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mmc0_pins_a>;
> +	vmmc-supply =3D <&reg_vcc3v3>;
> +	bus-width =3D <4>;
> +	cd-gpios =3D <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> +	cd-inverted;
> +	status =3D "okay";
> +};
> +
> +&ohci0 {
> +	status =3D "okay";
> +};
> +
> +&ohci1 {
> +	status =3D "okay";
> +};
> +
> +&otg_sram {
> +	status =3D "okay";
> +};
> +
> +&pio {
> +	panel_power_pin: panel_power_pin@0 {
> +		pins =3D "PH8";
> +		function =3D "gpio_out";
> +	};
> +
> +	backlight_enable_pin: backlight_enable_pin@0 {
> +		pins =3D "PH7";
> +		function =3D "gpio_out";
> +	};
> +
> +	touchscreen_power_pin: touchscreen_power_pin@0 {
> +		pins =3D "PH20";
> +		function =3D "gpio_out";
> +	};
> +
> +	codec_pa_pin: codec_pa_pin@0 {
> +		pins =3D "PH15";
> +		function =3D "gpio_out";
> +	};
> +
> +	usb0_id_detect_pin: usb0_id_detect_pin@0 {
> +		pins =3D "PH4";
> +		function =3D "gpio_in";
> +		bias-pull-up;
> +	};
> +
> +	usb0_vbus_pin: usb0_vbus_pin@0 {
> +		pins =3D "PB9";
> +		function =3D "gpio_out";
> +	};
> +
> +	usb1_vbus_pin: usb1_vbus_pin@0 {
> +		pins =3D "PH6";
> +		function =3D "gpio_out";
> +	};
> +
> +	usb2_vbus_pin: usb2_vbus_pin@0 {
> +		pins =3D "PH3";
> +		function =3D "gpio_out";
> +	};
> +};
> +
> +&pwm {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pwm0_pins_a>;
> +	status =3D "okay";
> +};
> +
> +&tcon0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&lcd_rgb666_pins>;
> +	status =3D "okay";
> +};
> +
> +&tcon0_out {
> +	tcon0_out_panel: endpoint@0 {
> +		reg =3D <0>;
> +		remote-endpoint =3D <&panel_input>;
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart0_pins_a>;
> +	status =3D "okay";
> +};
> +
> +&usb_otg {
> +	dr_mode =3D "otg";
> +	status =3D "okay";
> +};
> +
> +&usbphy {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&usb0_id_detect_pin>;
> +	usb0_id_det-gpio =3D <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
> +	usb0_vbus_power-supply =3D <&usb_power_supply>;
> +	usb0_vbus-supply =3D <&reg_usb0_vbus>;
> +	usb1_vbus-supply =3D <&reg_usb1_vbus>;
> +	usb2_vbus-supply =3D <&reg_usb2_vbus>;
> +	status =3D "okay";
> +};
> +
> +#include "axp209.dtsi"
> +
> +&battery_power_supply {
> +	status =3D "okay";
> +};
> +
> +&reg_dcdc2 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <1000000>;
> +	regulator-max-microvolt =3D <1450000>;
> +	regulator-name =3D "vdd-cpu";
> +};
> +
> +&reg_dcdc3 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <1000000>;
> +	regulator-max-microvolt =3D <1400000>;
> +	regulator-name =3D "vdd-int-dll";
> +};
> +
> +&reg_ldo1 {
> +	regulator-name =3D "vdd-rtc";
> +};
> +
> +&reg_ldo2 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <3000000>;
> +	regulator-max-microvolt =3D <3000000>;
> +	regulator-name =3D "avcc";
> +};
> +
> +&reg_usb0_vbus {
> +	pinctrl-0 =3D <&usb0_vbus_pin>;
> +	status =3D "okay";
> +};
> +
> +&reg_usb1_vbus {
> +	pinctrl-0 =3D <&usb1_vbus_pin>;
> +	status =3D "okay";
> +};
> +
> +&reg_usb2_vbus {
> +	pinctrl-0 =3D <&usb2_vbus_pin>;
> +	status =3D "okay";
> +};
> +
> +&usb_power_supply {
> +	status =3D "okay";
> +};
--=20
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-MzJknqR13bY6PyI7Vv4x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlrNLh8ACgkQhP3B6o/u
lQweRQ//bo7bAKA6eGtnut32N4d5EV7CWFMkOQcR+jnw1mLjjzjUXiVQopFI4hLY
V0xFHTmqa8GrLKMgYuHvT14YdhopeKWfQb53nPSDD7UaBZzk8n3JEZNwI2g6Y0+D
2nw/rvyjgtP1rhQngW8D2bYJpWAFOYOEzbEbY6Tlak8b8es5CjUkXP4Qas55JCEl
qycPzTZylEAWYQMeDVJAZh5wDSLkA7WjasVy4T9JlP3ELNcieYYXT/2w8gJuyF1x
r2IkXYekZJPKL8V6FuXl+TlznZp5DXLOzmvroburMJDniIvBWgHoyq0Epbh9oCYe
PBh4482ENXmmiPGuVkp1vqii2zEOqGBgamVHVltqYjQUg+y4C/SuoAfKVmWfLfOo
imGdvv1BxCYXNNN6spfWBRp7kDsDV2NKKw4NzKOsRtszkR3V+bkTXWjUEeAvNuFx
AEoltScRDfmFmD4ZjFqeqIjfGZIJNN8I6WoXrLu1HLQ5Mmbk/No+b6mrU/Ni2n7G
Hei35N+8/oQsaE4LTi4Mu7i80I0UTpFtaHG1+wy3rPKm6lWS7rIYts+sEutOFa4L
y6srTV9xf54s7kYQLuTIa86AqDNyT2godguSuEpl+KH5DPh3EikH17c1FPbEZZ/Y
e3z0FBEB3zMlxYqVvBtS75oTgpRv2SjlG67xQ1BAhXgh551m+FM=
=XVS0
-----END PGP SIGNATURE-----

--=-MzJknqR13bY6PyI7Vv4x--
