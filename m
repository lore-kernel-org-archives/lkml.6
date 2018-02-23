Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeBWPUp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:20:45 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:53925 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbeBWPUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:20:41 -0500
Date: Fri, 23 Feb 2018 16:20:38 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 6/7] arm64: allwinner: h6: add the basical Allwinner
 H6 DTSI file
Message-ID: <20180223152038.2bflylwa6vj4gzfj@flea.lan>
References: <20180223123555.64009-6-icenowy@aosc.io>
 <20180223123555.64009-7-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l2fdrnpsmitlpdua"
Content-Disposition: inline
In-Reply-To: <20180223123555.64009-7-icenowy@aosc.io>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l2fdrnpsmitlpdua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 08:35:54PM +0800, Icenowy Zheng wrote:
> Allwinner H6 is a new SoC with Cortex-A53 cores from Allwinner, with its
> memory map fully reworked and some high-speed peripherals (PCIe, USB
> 3.0) introduced.
>=20
> This commit adds the basical DTSI file of it, including the clock
> support and UART support.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Changes in v3:
> - SPDX license identifier fix.
>=20
> Changes in v2:
> - Add APB1 clock as PIO's APB clock.
> - Switched to SPDX license identifier.
>=20
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 177 +++++++++++++++++++++=
++++++
>  1 file changed, 177 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
> new file mode 100644
> index 000000000000..4a6236bd9778
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/sun50i-h6-ccu.h>
> +#include <dt-bindings/reset/sun50i-h6-ccu.h>
> +
> +/ {
> +	interrupt-parent =3D <&gic>;
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible =3D "arm,cortex-a53", "arm,armv8";
> +			device_type =3D "cpu";
> +			reg =3D <0>;
> +			enable-method =3D "psci";
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible =3D "arm,cortex-a53", "arm,armv8";
> +			device_type =3D "cpu";
> +			reg =3D <1>;
> +			enable-method =3D "psci";
> +		};
> +
> +		cpu2: cpu@2 {
> +			compatible =3D "arm,cortex-a53", "arm,armv8";
> +			device_type =3D "cpu";
> +			reg =3D <2>;
> +			enable-method =3D "psci";
> +		};
> +
> +		cpu3: cpu@3 {
> +			compatible =3D "arm,cortex-a53", "arm,armv8";
> +			device_type =3D "cpu";
> +			reg =3D <3>;
> +			enable-method =3D "psci";
> +		};
> +	};
> +
> +	iosc: internal-osc-clk {
> +		#clock-cells =3D <0>;
> +		compatible =3D "fixed-clock";
> +		clock-frequency =3D <16000000>;
> +		clock-accuracy =3D <300000000>;
> +		clock-output-names =3D "iosc";
> +	};

You're not using it anywhere

> +	osc24M: osc24M_clk {
> +		#clock-cells =3D <0>;
> +		compatible =3D "fixed-clock";
> +		clock-frequency =3D <24000000>;
> +		clock-output-names =3D "osc24M";
> +	};
> +
> +	osc32k: osc32k_clk {
> +		#clock-cells =3D <0>;
> +		compatible =3D "fixed-clock";
> +		clock-frequency =3D <32768>;
> +		clock-output-names =3D "osc32k";
> +	};
> +
> +	psci {
> +		compatible =3D "arm,psci-0.2";
> +		method =3D "smc";
> +	};

Is it needed? The bootloader should fill it with whatever version it
has, shouldn't it?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--l2fdrnpsmitlpdua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqQMUUACgkQ0rTAlCFN
r3TVHRAAk/zurzZNX92aYYFuKKrNaIZVtlQ3TjMUrhpHWREtUKOY6Eqww5ymSq/A
lMJMDtBPP4cUMWqGfhJsOevAqzfpEVzta4QoIhUo44TclVAOVegBbDwEFemWsfg7
S1RzpeAXmW2rNvbHdqp519L97tHZQTxZ1aPsyGDGcnMDOyej6moAPjj+im5istOW
+rPlNSqd6Wa5/ZUoEJUJn/5U6R8sKvZNPgxdl3YlXWHlNNkzkJ36KaEu6vykwhV6
6GgHdoVuTcWU/XtnNjIsC3j5GfQxOvGXBtvhKcnZowo1Vxt+p2Gb3bDkHtqjbLUy
tNrFFxUTKZK0F06Ct/+cgm6N6SkFsu8WHlp7Ak4zP6uUvMHS+5FlycRCI49gmp05
HkXbHndRnRJvSc+MKj6qjBhpceFzBtbViD2iUL3SEsQi1j+v75t6mZiHo7nFVbT6
oPLAF/89ZFjO6XyfmMIEc0nVRr1UvEXo6XuOlByvXv2/ttcZQlHK62ruqjuiK1dE
4bHknI2POiMi8/3AJkUwhS+g8h6KGhmTUyUR1cy99CSagRsnbe4Wd/YOsFFDeSAp
LT5mvFcWSPUIrlYSfmxa98NFXi6DH7PL/+5m7IVjUzz1IfXBTR+rZ6zGoR1yko3o
gn2hMHXn/YRQaewgp6zhorbffutDGzM+Wb+nYwMWCmQVe3YC7Og=
=xle5
-----END PGP SIGNATURE-----

--l2fdrnpsmitlpdua--
