Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753012AbeEGUQA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:16:00 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:39540 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752850AbeEGUP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:15:59 -0400
Message-ID: <d8de7d2237a74388ac8c8152eded3477e7fd56a4.camel@paulk.fr>
Subject: Re: [PATCH v3 3/3] ARM: dts: sun7i: Add support for the Ainol AW1
 tablet
From: Paul Kocialkowski <contact@paulk.fr>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org
Date: Mon, 07 May 2018 22:15:46 +0200
In-Reply-To: <20180507071931.tebv45yxrojxxkeb@flea>
References: <20180506214901.23429-1-contact@paulk.fr>
         <20180506214901.23429-3-contact@paulk.fr>
         <20180507071931.tebv45yxrojxxkeb@flea>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-LZASvdTavrcasiQJxSbY"
X-Mailer: Evolution 3.28.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LZASvdTavrcasiQJxSbY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le lundi 07 mai 2018 =C3=A0 09:19 +0200, Maxime Ripard a =C3=A9crit :
> Hi,
>=20
> On Sun, May 06, 2018 at 11:49:01PM +0200, Paul Kocialkowski wrote:
> > This adds support for the Ainol AW1, an A20-based 7" tablet from Ainol.
> >=20
> > The following board-specific features are supported:
> > * LCD panel
> > * Backlight
> > * USB OTG
> > * Buttons
> > * Touchscreen (doesn't work without non-free firmware)
> > * Accelerometer
> > * Battery
> >=20
> > The following are untested:
> > * Audio output
> > * Audio speakers
> > * USB via SPCI connector
> >=20
> > The following are not supported:
> > * Wi-Fi
> > * Bluetooth
> > * NAND
> > * Audio via SPCI connector
> > * Audio via Bluetooth I2S
> >=20
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  arch/arm/boot/dts/Makefile                |   1 +
> >  arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts | 275 ++++++++++++++++++++++
> >  2 files changed, 276 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
> >=20
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 7e2424957809..4a80971f2bc9 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -946,6 +946,7 @@ dtb-$(CONFIG_MACH_SUN6I) +=3D \
> >  	sun6i-a31s-sinovoip-bpi-m2.dtb \
> >  	sun6i-a31s-yones-toptech-bs1078-v2.dtb
> >  dtb-$(CONFIG_MACH_SUN7I) +=3D \
> > +	sun7i-a20-ainol-aw1.dtb \
> >  	sun7i-a20-bananapi.dtb \
> >  	sun7i-a20-bananapi-m1-plus.dtb \
> >  	sun7i-a20-bananapro.dtb \
> > diff --git a/arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts b/arch/arm/boot/=
dts/sun7i-a20-ainol-aw1.dts
> > new file mode 100644
> > index 000000000000..9a1d54a9f9a0
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
> > @@ -0,0 +1,275 @@
> > +/*
> > + * Copyright (C) 2018 Paul Kocialkowski <contact@paulk.fr>
> > + *
> > + * SPDX-License-Identifier: GPL-2.0+
>=20
> This should be your first line.

Alright then. For reference, I based this off sun8i-h3-libretech-all-h3-
cc.dts, that has the copyright first.

> Also, we usually license our DT under
> a dual license (GPL and MIT) so that other projects (like FreeBSD) can
> use them as well, instead of duplicating them. It would be great if
> you'd consider it.

Ah, I didn't think of BSD-licensed systems like FreeBSD off-hand.

Since they are apparently working on ARM support, it's probably worth
publishing this under a non-copyleft license.

> > + */
> > +
> > +/dts-v1/;
> > +#include "sun7i-a20.dtsi"
> > +#include "sunxi-common-regulators.dtsi"
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/pwm/pwm.h>
> > +
> > +/ {
> > +	model =3D "Ainol AW1";
> > +	compatible =3D "ainol,ainol-aw1", "allwinner,sun7i-a20";
> > +
> > +	aliases {
> > +		serial0 =3D &uart0;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path =3D "serial0:115200n8";
> > +	};
> > +
> > +	backlight: backlight {
> > +		compatible =3D "pwm-backlight";
> > +		pwms =3D <&pwm 0 50000 PWM_POLARITY_INVERTED>;
> > +		brightness-levels =3D <0 10 20 30 40 50 60 70 80 90 100>;
>=20
> The increase in perceived brightness should be linear. Usually, for
> PWMs backed backlight, an exponential list is a much better
> approximation.

Thanks for the hint, it never occurred to me that pwm duty cycle was not
linear with brightness, but that makes sense. I'll give that a try (on
255 values instead of 10 to keep some level of precision in low
brightness). The way to go here is probably use a base-255 logarithm
such as: duty cycle =3D range * log(i+1)/log(255) with i the linear
brightness value (0 to 255) and range the amplitude of our values (that
gets divided by the maximum brightness, so it's really up to hardware
precision at this point). I'll go with a range of 255 as well.

> > +		default-brightness-level =3D <5>;
> > +		enable-gpios =3D <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
> > +	};
> > +
> > +	panel: panel {
> > +		compatible =3D "innolux,at070tn90";
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +		power-supply =3D <&panel_power>;
> > +		backlight =3D <&backlight>;
> > +
> > +		port@0 {
> > +			reg =3D <0>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +
> > +			panel_input: endpoint@0 {
> > +				reg =3D <0>;
> > +				remote-endpoint =3D <&tcon0_out_panel>;
> > +			};
> > +		};
> > +	};
> > +
> > +	panel_power: panel_power {
> > +		compatible =3D "regulator-fixed";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&panel_power_pin>;
> > +		regulator-name =3D "panel-power";
> > +		regulator-min-microvolt =3D <10400000>;
> > +		regulator-max-microvolt =3D <10400000>;
> > +		gpio =3D <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
> > +		enable-active-high;
> > +		regulator-boot-on;
> > +	};
> > +};
> > +
> > +&codec {
> > +	allwinner,pa-gpios =3D <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15 */
> > +	status =3D "okay";
> > +};
> > +
> > +&cpu0 {
> > +	cpu-supply =3D <&reg_dcdc2>;
> > +};
> > +
> > +&de {
> > +	status =3D "okay";
> > +};
> > +
> > +&ehci0 {
> > +	status =3D "okay";
> > +};
> > +
> > +&ehci1 {
> > +	status =3D "okay";
> > +};
> > +
> > +&i2c0 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&i2c0_pins_a>;
> > +	status =3D "okay";
> > +
> > +	axp209: pmic@34 {
> > +		reg =3D <0x34>;
> > +		interrupt-parent =3D <&nmi_intc>;
> > +		interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> > +	};
> > +};
> > +
> > +&i2c1 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&i2c1_pins_a>;
> > +	status =3D "okay";
> > +
> > +	lis3dh: accelerometer@18 {
> > +		compatible =3D "st,lis3dh-accel";
> > +		reg =3D <0x18>;
> > +		vdd-supply =3D <&reg_vcc3v3>;
> > +		vddio-supply =3D <&reg_vcc3v3>;
> > +		st,drdy-int-pin =3D <1>;
> > +	};
> > +};
> > +
> > +&i2c2 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&i2c2_pins_a>;
> > +	status =3D "okay";
> > +	clock-frequency =3D <400000>;
> > +
> > +	gsl1680: touchscreen@40 {
> > +		compatible =3D "silead,gsl1680";
> > +		reg =3D <0x40>;
> > +		interrupt-parent =3D <&pio>;
> > +		interrupts =3D <7 21 IRQ_TYPE_EDGE_FALLING>; /* EINT21 (PH21) */
> > +		power-gpios =3D <&pio 7 20 GPIO_ACTIVE_HIGH>; /* PH20 */
> > +		firmware-name =3D "gsl1680-ainol-aw1.fw";
> > +		touchscreen-size-x =3D <480>;
> > +		touchscreen-size-y =3D <800>;
> > +		touchscreen-swapped-x-y;
> > +		touchscreen-inverted-y;
> > +		silead,max-fingers =3D <5>;
> > +	};
> > +};
> > +
> > +&lradc {
> > +	vref-supply =3D <&reg_ldo2>;
> > +	status =3D "okay";
> > +
> > +	button@571 {
> > +		label =3D "Volume Up";
> > +		linux,code =3D <KEY_VOLUMEUP>;
> > +		channel =3D <0>;
> > +		voltage =3D <571428>;
> > +	};
> > +
> > +	button@761 {
> > +		label =3D "Volume Down";
> > +		linux,code =3D <KEY_VOLUMEDOWN>;
> > +		channel =3D <0>;
> > +		voltage =3D <761904>;
> > +	};
> > +
> > +	button@952 {
> > +		label =3D "Home";
> > +		linux,code =3D <KEY_HOME>;
> > +		channel =3D <0>;
> > +		voltage =3D <952380>;
> > +	};
> > +};
> > +
> > +&mmc0 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&mmc0_pins_a>;
> > +	vmmc-supply =3D <&reg_vcc3v3>;
>=20
> You have the regulators described in your DT, you'd better use them
> instead of the one coming from sunxi-common-regulators.dtsi.

Well, according to the reference A20 design, the mmc pins and the card
are powered by the 3.3V power rail, that comes from a regular step-down
regulator sourcing from IPSOUT, so I don't see what regulator I should
better use. Do you have a suggestion?

> > +	bus-width =3D <4>;
> > +	cd-gpios =3D <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> > +	cd-inverted;
> > +	status =3D "okay";
> > +};
> > +
> > +&ohci0 {
> > +	status =3D "okay";
> > +};
> > +
> > +&ohci1 {
> > +	status =3D "okay";
> > +};
> > +
> > +&otg_sram {
> > +	status =3D "okay";
> > +};
> > +
> > +&pio {
> > +	panel_power_pin: panel_power_pin@0 {
> > +		pins =3D "PH8";
> > +		function =3D "gpio_out";
> > +	};
> > +};
>=20
> You don't need that pinctrl node.

I'll get rid of it then. You mentioned that regulator-simple uses the
old GPIO API, so I assumed it meant that a pinctrl node is still needed.
For reference, it uses of_get_named_gpio (not the devm-managed fashion).

Cheers,

Paul

--=20
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-LZASvdTavrcasiQJxSbY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlrws/IACgkQhP3B6o/u
lQy2zg/9GKAlXfphJOX4YKvn88ABtNZmHfRpRdHbNoLIoTavi1ULbDb/NdcJ2H3M
JoAvp3+ur1VuJD3fwo3W+k5hqWGOmVHguqtH2gjDxWLkPN1H5zSIgFtqBErBZDtT
TevBRzHRp69hDG37pYODs9nwPNvH+16kMSOL5id+E1GGDHblNWnxAl5EHc11A0rD
UBNKgcaU71LnWA6uX0oOCIeJQMlU5wV4uAYPpzaA1MZmTSIe4xhvR7XeATIXSfDU
o74z9Af8S7TgBoDo77T0ez68qSHkeFiKOIYeQvqIq7zORIOl1HhdD37yh+QPOFiW
ArHkN1ijyTz372Y5SNIQ/GjdKZ5+drDtgIU9IS5wFEE1RcO9lG5KfXNT8XiJoKIO
k0+JmsnC6mJeEN3D/rUKGBPmNhVLB7wqui6FO2p80/8E2xAAQpU/8CaNeaCVSKF4
rYURAL5KNL/RavvTdeayaJzX9QCTNmFj0rmDI9UIDduJncSUsQpgQH0Bl11zAaxt
B848mQB5CAcCy+shMUBcZRXqA6MA7dGqYg2Pa9YrGN1YQFgWsJd6aXw6ITB1D40E
EKeGj2jbdPo+dY4E8WrYDD8hG5Nkt7yx+B1iBw6WlQl5SsamBoVlASJ4EhNgf+Kj
Hr4bnxW1u+7TwOX/1JxHfVuh0UfTcRDka+1X+mMaOGZGQQ4QRU8=
=WVgK
-----END PGP SIGNATURE-----

--=-LZASvdTavrcasiQJxSbY--
