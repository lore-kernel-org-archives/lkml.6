Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeFDINQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:13:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40757 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751931AbeFDINO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:13:14 -0400
Date: Mon, 4 Jun 2018 10:13:02 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Bob Ham <rah@settrans.net>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm: sun4i: Add support for Pengpod 1000 tablet
Message-ID: <20180604081302.hcn7j36gt6xeyquq@flea>
References: <20180602160313.26763-1-rah@settrans.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3w2cdmutt3rryood"
Content-Disposition: inline
In-Reply-To: <20180602160313.26763-1-rah@settrans.net>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3w2cdmutt3rryood
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 02, 2018 at 05:03:13PM +0100, Bob Ham wrote:
> This is initial support for the Pengpod 1000 tablet.  The display is
> not currently working but the UART, SD card and USB all work fine.
>=20
> Signed-off-by: Bob Ham <rah@settrans.net>
> ---
> Changes since v1:
>=20
> * Added SPDX license identifier
>=20
> arch/arm/boot/dts/Makefile                   |   1 +
>  arch/arm/boot/dts/sun4i-a10-pengpod-1000.dts | 234 +++++++++++++++++++++=
++++++
>  2 files changed, 235 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun4i-a10-pengpod-1000.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ade7a38543dc..e6e93e7ffc8b 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -893,6 +893,7 @@ dtb-$(CONFIG_MACH_SUN4I) +=3D \
>  	sun4i-a10-olinuxino-lime.dtb \
>  	sun4i-a10-pcduino.dtb \
>  	sun4i-a10-pcduino2.dtb \
> +	sun4i-a10-pengpod-1000.dtb \
>  	sun4i-a10-pov-protab2-ips9.dtb
>  dtb-$(CONFIG_MACH_SUN5I) +=3D \
>  	sun5i-a10s-auxtek-t003.dtb \
> diff --git a/arch/arm/boot/dts/sun4i-a10-pengpod-1000.dts b/arch/arm/boot=
/dts/sun4i-a10-pengpod-1000.dts
> new file mode 100644
> index 000000000000..788163a80f3a
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun4i-a10-pengpod-1000.dts
> @@ -0,0 +1,234 @@
> +/*
> + * Copyright 2015 Hans de Goede <hdegoede@redhat.com>
> + * Copyright 2017 Robert Ham <rah@settrans.net>
> + *
> + * SPDX-License-Identifier: (GPL-2.0-or-later or X11)

This should be the very first line.

> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
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

And this is redundant with the SPDX header.

> +/dts-v1/;
> +#include "sun4i-a10.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pwm/pwm.h>
> +
> +/ {
> +	model =3D "PengPod 1000";
> +	compatible =3D "pengpod,1000", "allwinner,sun4i-a10";
> +
> +	aliases {
> +		serial0 =3D &uart0;
> +	};
> +
> +	backlight: backlight {
> +		compatible =3D "pwm-backlight";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&bl_en_pin_pengpod1000>;

These two pinctrl property aren't needed.

> +		pwms =3D <&pwm 0 50000 PWM_POLARITY_INVERTED>;
> +		brightness-levels =3D <0 10 20 30 40 50 60 70 80 90 100>;

Each step should increase the perceived brightness by roughly 1/Nth, N
being the number of steps. Usually PWM backlights don't work like that.

> +&i2c2 {
> +	status =3D "okay";
> +
> +	ft5406ee8: touchscreen@38 {
> +		compatible =3D "edt,edt-ft5406";
> +		reg =3D <0x38>;
> +		interrupt-parent =3D <&pio>;
> +		interrupts =3D <7 21 IRQ_TYPE_EDGE_FALLING>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&touchscreen_pins>;

You can drop these two pinctrl properties as well

> +&pio {
> +	bl_en_pin_pengpod1000: bl_en_pin@0 {
> +		pins =3D "PH7";
> +		function =3D "gpio_out";
> +	};
> +
> +	touchscreen_pins: touchscreen_pins@0 {
> +		pins =3D "PB13";
> +		function =3D "gpio_out";
> +	};
> +
> +	usb0_id_detect_pin: usb0_id_detect_pin@0 {
> +		pins =3D "PH4";
> +		function =3D "gpio_in";
> +		bias-pull-up;
> +	};
> +
> +	usb0_vbus_detect_pin: usb0_vbus_detect_pin@0 {
> +		pins =3D "PH5";
> +		function =3D "gpio_in";
> +		bias-pull-down;
> +	};
> +};

And all these nodes.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--3w2cdmutt3rryood
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsU9I0ACgkQ0rTAlCFN
r3R13RAAl8AFmGmyOLpACXfujdAxr6LBqXxdY+tZuCdSwY8NNykK54mvMXALQFbp
d95NDo7AzfTCpKCRpC/PdrGQYBDzLm4QZp0b3Vqhy4gf/AytzMR26D9CzI/vAlpx
wg5b92osg1HBI9AiVjm1ljG2fXzBZlw4aKBI8BDStM4HfsiWOT4pAAmoHL/9CbGb
QkEsEYdR7sxesId5P77VrlC11GtF6cbTiIJAL1LNHM3Z2oS0rI+zjn7DcasLp3iL
RH1fuWtHxJUQ/FD+REvmj3bTKmUNhxiW1WBtggF56JL4/MRjWDMI2AlKMrUmWBYy
g24SEmcCtXQTSAHhI5LPGEDRsJ02t00yTmMJJgAHVXtr3zjGaNAdV4FTRYYF1p/3
0lHOMn6a80vW9+nfW9paOzhSc02zRyoaHK8kJQco6lDvBISlr2rq6qThzuexUhxC
/nh8xoyTzzqrItvJPjfHn290y4vttc67iGCEBTMYiFgBZVtjYicWKXdazFYNk0hc
lYPJUuPjK6HeSW5FVg17itgng2XSxgUIW2+R3gK5s1L/3IXECrgifiQTyQPQ0nLv
INlIIqDAwhgEMM5ygwBI2bVuAHmvLNsAAIGLF2GOuVbhPSrPMsldHnyCU1eI1+Pl
d3t8yFy3raqfrZ1MS/RCnc9aJILL/cBhqs5qn1JK1IzM0MbkZUc=
=UCaG
-----END PGP SIGNATURE-----

--3w2cdmutt3rryood--
