Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeCMIlM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:41:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37520 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751666AbeCMIlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:41:10 -0400
Date: Tue, 13 Mar 2018 09:41:08 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Harald Geyer <harald@ccbib.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>, info@olimex.com
Subject: Re: [PATCH 5/5] arm64: allwinner: a64: Add support for TERES I laptop
Message-ID: <20180313084108.uh3ui5jwin2knvuu@flea>
References: <20180312161050.7647-1-harald@ccbib.org>
 <20180312161050.7647-6-harald@ccbib.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f6toe62sl3crmfeo"
Content-Disposition: inline
In-Reply-To: <20180312161050.7647-6-harald@ccbib.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f6toe62sl3crmfeo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 12, 2018 at 04:10:50PM +0000, Harald Geyer wrote:
> The TERES I is an open hardware laptop built by Olimex using the
> Allwinner A64 SoC.
>=20
> Add the board specific .dts file, which includes the A64 .dtsi and
> enables the peripherals that we support so far.
>=20
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
>  .../boot/dts/allwinner/sun50i-a64-teres-i.dts      | 308 +++++++++++++++=
++++++
>  2 files changed, 309 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts=
/allwinner/Makefile
> index f505227b0250..5f073f7423b7 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -5,6 +5,7 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-olinuxino.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-orangepi-win.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pine64-plus.dtb sun50i-a64-pine=
64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-sopine-baseboard.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-teres-i.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-pc2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-prime.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-zero-plus2.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/=
arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> new file mode 100644
> index 000000000000..0d42b5111f0f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> @@ -0,0 +1,308 @@
> +/*
> + * Copyright (C) Harald Geyer <harald@ccbib.org>
> + * based on sun50i-a64-olinuxino.dts by Jagan Teki <jteki@openedev.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
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
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */

you should use an SPDX header here to define the license

> +
> +/dts-v1/;
> +
> +#include "sun50i-a64.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/pwm/pwm.h>
> +
> +/ {
> +	model =3D "Olimex Teres I A64";

It's called the Teres-I, there's no need for the A64 here

> +	compatible =3D "olimex,a64-teres-i", "allwinner,sun50i-a64";

Or in the compatible

> +
> +	aliases {
> +		serial0 =3D &uart0;
> +	};
> +
> +	backlight: backlight {
> +		compatible =3D "pwm-backlight";
> +		pwms =3D <&pwm 0 50000 0>;
> +		brightness-levels =3D <0 10 20 30 40 50 60 70 100>;
> +		default-brightness-level =3D <3>;
> +		enable-gpios =3D <&pio 3 23 GPIO_ACTIVE_HIGH>; /* PD23 */
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +
> +		framebuffer-lcd {
> +			eDP25-supply =3D <&reg_dldo2>;
> +			eDP12-supply =3D <&reg_dldo3>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible =3D "gpio-keys";
> +
> +		lid-switch {
> +			label =3D "Lid Switch";
> +			gpios =3D <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 */
> +			linux,input-type =3D <EV_SW>;
> +			linux,code =3D <SW_LID>;
> +		};
> +	};
> +
> +	leds: leds {

Do you need a label?

> +		compatible =3D "gpio-leds";
> +
> +		led_capslock: capslock {

Same thing here

> +			gpios =3D <&pio 2 7 GPIO_ACTIVE_HIGH>; /* PC7 */

Ideally you should have LED labels here, following the scheme
devicename:colour:function

> +		};
> +
> +		led_numlock: numlock {
> +			gpios =3D <&pio 2 4 GPIO_ACTIVE_HIGH>; /* PC4 */
> +		};
> +	};
> +
> +	reg_usb1_vbus: usb1-vbus {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "usb1-vbus";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		enable-active-high;
> +		gpio =3D <&r_pio 0 7 GPIO_ACTIVE_HIGH>; /* PL7 */
> +		status =3D "okay";

I guess this one has a parent regulator too?

> +	};
> +
> +	wifi_pwrseq: wifi_pwrseq {
> +		compatible =3D "mmc-pwrseq-simple";
> +		reset-gpios =3D <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
> +	};
> +};
> +
> +&ehci1 {
> +	status =3D "okay";
> +};
> +
> +&i2c0 {
> +	clock-frequency =3D <100000>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c0_pins>;
> +	status =3D "okay";
> +};

What is this used for?

Looks good otherwise, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--f6toe62sl3crmfeo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqnjqMACgkQ0rTAlCFN
r3Qg+xAAkafyKNaoXAaEEGYQNBm4aIHRHAFugUrR3isrmCKXBSbD7r+T2pL39i2F
IUr27zSZK8yMx9BsTxfPCrTIbyCxagsoZQ4dyjjfUXF1Tu+Vv1fJTso+U1Ns1PKn
1X+G1rpyMYVLCe/z0Rej3NjwPz/QtR8ws524D+7dpFZOpwkiYI+lakt/p7XoUneL
wQd6Dvdu/EHaUK2yGQZEQOKLx0GKKB1Gqirz/C7kBPdQqsccleB4yC3+2c4f8a4h
r+ZMn+TT2MZUiLBLOfMJ5bjeGqYwO9BnFSqAvYiznJ3KpO2W4E7z4Lm4q+QbX6WG
lYhCog2qhbpRIHmSDbLky40kI6DzDkh1UCqp/FtP6V5jVVu6LEMYJh7ClD4lJlWe
QWF6ilsoVkhDLozW3cGnUw7K2ZEoFmMYdMXcHc0WpYN2+CV8RFOe14h1ypeKaWyF
YbxGioO3WAbEGVcKRmhfEfL9ZTHG2SwSzUFNoUtZKQZwoYWmAsiS23iMbY6vZ7PX
EYubnCiItZtEHp7FbFy3GhpQkpGtUbUcBik6bJO/dBF/8It+R8oQldNNOAZb4AAx
3d0T/o1vQHLas/SHemy+4mT3mNtRbS1PovlKarbYr5AzrQL+ZgRLMJnt8nJExkBe
P1yEWBn5JahhrE7lQBwIrxSHpZ4VqaxvHBf0/vEA0J+HEZgfMM0=
=ppE3
-----END PGP SIGNATURE-----

--f6toe62sl3crmfeo--
