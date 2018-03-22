Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbeCVSFN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 14:05:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52748 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751733AbeCVSFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 14:05:11 -0400
Date: Thu, 22 Mar 2018 19:05:08 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/7] ARM: dts: sun7i: Add dts file for the A20-linova1-7
 HMI
Message-ID: <20180322180508.my64gobhh5rc2x2m@flea>
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1521662593-25468-7-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="73ae5pea6q2ieqmp"
Content-Disposition: inline
In-Reply-To: <1521662593-25468-7-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--73ae5pea6q2ieqmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2018 at 09:03:13PM +0100, Giulio Benetti wrote:
> The A20-Linova1-7 HMI, also called Q027_2_F which is printed on production
> label, is an industrial Human Machine Interface.
> It features:
> - 512MB DDR RAM
> - 1 Sd-card >=3D 4GB
> - 1 Usb otg(programmable via software) with A-Usb Connector
> - 1 Usb host
> - 1 Buzzer
> - 1 Input for LiPo
> - 1 Relay to signal absence of power supply
> - 1 External Rtc with 56 bytes of ram + CR2032 battery
> - 1 7" 24-bits Tft 800x480 with PCap on
> - 1 Mono audio 1-watt amplifier
> - 1 RS485 port
> - 1 Power On Line through +12Vdc reaching 57.600baud,
>   from where it can be supplied and placed in a network of 50 units
> - exposed jtag pins
>=20
> HMI is supplied from +12Vdc.
> Ethernet is absent, so for debugging, need to enable rndis on Usb otg
> port through an A-A usb cable.
> It comes in different flavours for connector types and can be found with
> umounted features as requested by customers.

So this is essentially the same board than in patch 6, but with a
different screen?

You should have a single DT then, and handle the two different panels
using DT overlays.

> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  .../devicetree/bindings/arm/micronova.txt          |   4 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/sun7i-a20-linova1-ctp-7i.dts     | 192 +++++++++++++++=
++++++
>  3 files changed, 197 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-linova1-ctp-7i.dts
>=20
> diff --git a/Documentation/devicetree/bindings/arm/micronova.txt b/Docume=
ntation/devicetree/bindings/arm/micronova.txt
> index 35c4127..9f5ac72 100644
> --- a/Documentation/devicetree/bindings/arm/micronova.txt
> +++ b/Documentation/devicetree/bindings/arm/micronova.txt
> @@ -4,3 +4,7 @@ Micronova Device Tree Bindings
>  A20-LiNova1-4_3 HMI
>  Required root node properties:
>      - compatible =3D "micronova,a20-linova1-ctp-4_3i", "allwinner,sun7i-=
a20";
> +
> +A20-LiNova1-7 HMI
> +Required root node properties:
> +    - compatible =3D "micronova,a20-linova1-ctp-7i", "allwinner,sun7i-a2=
0";

These bindings are unnecessary, but the panel-simple bindings should
be sent to the DT maintainers as well.

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index c45a4f25..eafa7cb 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -942,6 +942,7 @@ dtb-$(CONFIG_MACH_SUN7I) +=3D \
>  	sun7i-a20-m3.dtb \
>  	sun7i-a20-mk808c.dtb \
>  	sun7i-a20-linova1-ctp-4_3i.dtb\
> +	sun7i-a20-linova1-ctp-7i.dtb\

You should have a space after dtb, and it should be ordered
alphabetically.

>  	sun7i-a20-olimex-som-evb.dtb \
>  	sun7i-a20-olinuxino-lime.dtb \
>  	sun7i-a20-olinuxino-lime2.dtb \
> diff --git a/arch/arm/boot/dts/sun7i-a20-linova1-ctp-7i.dts b/arch/arm/bo=
ot/dts/sun7i-a20-linova1-ctp-7i.dts
> new file mode 100644
> index 0000000..7fd0d98
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-linova1-ctp-7i.dts
> @@ -0,0 +1,192 @@
> +/*
> + * This is based on sun7i-a20-linova1-ctp-7i.dts
> + *
> + * Copyright 2014 - Hans de Goede <hdegoede@redhat.com>
> + * Copyright (c) 2014 FUKAUMI Naoki <naobsd@gmail.com>
> + * Copyright (c) 2018 Giulio Benetti <giulio.benetti@micronovasrl.com>
> + *
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
> + */

You should use an SPDX license header here.

> +
> +/dts-v1/;
> +#include "sun7i-a20.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	model =3D "Micronova srl LiNova1 CTP 7i";
> +	compatible =3D "micronova,a20-linova1-ctp-7i", "allwinner,sun7i-a20";
> +
> +	aliases {
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	panel: panel {
> +		compatible =3D "cdtech,s070wv95-ct16", "simple-panel";
> +		power-supply =3D <&reg_vcc3v3>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
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
> +		compatible =3D "x-powers,axp209";
> +		reg =3D <0x34>;
> +		interrupt-parent =3D <&nmi_intc>;
> +		interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> +
> +		interrupt-controller;
> +		#interrupt-cells =3D <1>;
> +	};
> +};
> +
> +&i2c2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c2_pins_a>;
> +	status =3D "okay";
> +
> +	ft5x: touchscreen@38 {
> +		compatible =3D "edt,edt-ft5206";
> +		reg =3D <0x38>;
> +		interrupt-parent =3D <&pio>;
> +		interrupts =3D <7 2 IRQ_TYPE_EDGE_FALLING>; /* PH2 */
> +		reset-gpios =3D <&pio 7 3 GPIO_ACTIVE_LOW>; /* PH3 */
> +		touchscreen-size-x =3D <800>;
> +		touchscreen-size-y =3D <480>;
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
> +&reg_usb0_vbus {
> +	status =3D "okay";
> +};
> +
> +&reg_usb1_vbus {
> +	status =3D "okay";
> +};

Ideally you should be defining the regulators here too.

> +&uart0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart0_pins_a>;
> +	status =3D "okay";
> +};
> +
> +&usb_otg {
> +	dr_mode =3D "otg";

You're saying that this is a USB-A connector? Then it's not OTG since
it doesn't have an ID pin, this is an host.

> +	status =3D "okay";
> +};
> +
> +&usbphy {
> +	pinctrl-names =3D "default";
> +	usb0_vbus-supply =3D <&reg_usb0_vbus>;
> +	usb1_vbus-supply =3D <&reg_usb1_vbus>;
> +	status =3D "okay";
> +};
> +
> +&be0 {
> +	status =3D "okay";
> +};
> +
> +&de {
> +	status =3D "okay";
> +};

The nodes should be ordered by alphabetical order.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--73ae5pea6q2ieqmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqz8FMACgkQ0rTAlCFN
r3RaWA/9GGjKC0faP4iwFQlQGG9vOIJpThLu/Mvl24kPywAevg7GRXFzgkSSh436
HUK8L9mhwQVoHSEg3sCqKDas5zAvxotQP62L5Pc9qvW3sfYYEM/kLawkti8A784f
Db7yyVsIlV0oJy0ghZ5NA8aio1eA0j5m825JsBnFJ6M8C38COWYQBK/hgYamccJK
u2NS3oAQ3BpBvn23NFqlG1S9dfvaZJHbbGLcjwXBko2bdk7sAAf2Iig7B3nL8loy
eFI8tHd+5+FknPONWVlZ6KS+KAMj33XB8CT50El+hcHT7U0fIwHjaVm3x0S8nkUi
+9HwHGAx8LlxvLuz2iGy6D9/NYCwDv1nEil4JemsA/9Mud2an6opcICUtUMTb3B3
F0zXfWab/YMJKmseYsU21/5pKoemp9X//tbfvgQGUbLlmyDym/VP7qRdi98vqG99
sCocHdLKnzCpil1ttayQdz3Pto8Gfs8Wd/b2ObFoqmroLq3Bue4291wu5Ctd/jUO
Ob4tipCLNGDnHBCdmd2tdecwut0Amt055ps/I0J3FHWo2mN9ZOATfBrzSgu5y2NK
ieLnT/z2DjflBGzb2sx2zlt4vpjUcyP7jmsjYSiy2bNExHKO26hu+DMr/GW5OXvR
hmoEtyOgWihxu7Op89L7tXnbhWlWG0zHrxJhL9ToSAIahsVb5JM=
=UFHt
-----END PGP SIGNATURE-----

--73ae5pea6q2ieqmp--
