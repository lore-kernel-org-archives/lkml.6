Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032336AbeCSV1z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:27:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50411 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933624AbeCSV1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:27:18 -0400
Date: Mon, 19 Mar 2018 22:27:05 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/2] arm64: allwinner: h6: temporarily drop the usage of
 CCU headers in DTSI
Message-ID: <20180319212705.7u5yqz4mk644aomk@flea>
References: <20180319081108.23496-1-icenowy@aosc.io>
 <20180319081108.23496-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ixzervdxjrzxhrrb"
Content-Disposition: inline
In-Reply-To: <20180319081108.23496-2-icenowy@aosc.io>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ixzervdxjrzxhrrb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 19, 2018 at 04:11:08PM +0800, Icenowy Zheng wrote:
> As the CCU driver will be merged in different tree with the device tree,
> temporarily drop the usage of CCU headers in the DTSI file, and replace
> macros with the corresponding numbers.
>=20
> After they are both merged into Linus' tree, it can be switched back to
> use the CCU headers.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
> index 4debc3962830..56563150d61a 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -4,8 +4,6 @@
>   */
> =20
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/clock/sun50i-h6-ccu.h>
> -#include <dt-bindings/reset/sun50i-h6-ccu.h>
> =20
>  / {
>  	interrupt-parent =3D <&gic>;
> @@ -117,7 +115,7 @@
>  				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks =3D <&ccu CLK_APB1>, <&osc24M>, <&osc32k>;
> +			clocks =3D <&ccu 26>, <&osc24M>, <&osc32k>;
>  			clock-names =3D "apb", "hosc", "losc";
>  			gpio-controller;
>  			#gpio-cells =3D <3>;
> @@ -136,8 +134,8 @@
>  			interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift =3D <2>;
>  			reg-io-width =3D <4>;
> -			clocks =3D <&ccu CLK_BUS_UART0>;
> -			resets =3D <&ccu RST_BUS_UART0>;
> +			clocks =3D <&ccu 70>;
> +			resets =3D <&ccu 21>;
>  			status =3D "disabled";
>  		};
> =20
> @@ -147,8 +145,8 @@
>  			interrupts =3D <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift =3D <2>;
>  			reg-io-width =3D <4>;
> -			clocks =3D <&ccu CLK_BUS_UART1>;
> -			resets =3D <&ccu RST_BUS_UART1>;
> +			clocks =3D <&ccu 71>;
> +			resets =3D <&ccu 22>;
>  			status =3D "disabled";
>  		};
> =20
> @@ -158,8 +156,8 @@
>  			interrupts =3D <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift =3D <2>;
>  			reg-io-width =3D <4>;
> -			clocks =3D <&ccu CLK_BUS_UART2>;
> -			resets =3D <&ccu RST_BUS_UART2>;
> +			clocks =3D <&ccu 72>;
> +			resets =3D <&ccu 23>;
>  			status =3D "disabled";
>  		};
> =20
> @@ -169,8 +167,8 @@
>  			interrupts =3D <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift =3D <2>;
>  			reg-io-width =3D <4>;
> -			clocks =3D <&ccu CLK_BUS_UART3>;
> -			resets =3D <&ccu RST_BUS_UART3>;
> +			clocks =3D <&ccu 73>;
> +			resets =3D <&ccu 24>;

Thanks, I squashed a similar patch earlier.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ixzervdxjrzxhrrb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqwKygACgkQ0rTAlCFN
r3TPPQ//RSwwnM/8GD7a/ZyxYWTs39sHi0mhis9WFxbsiF4BDR55pX0Xis8GTlz8
fUk9giwlt3bUbIRUAVzEIjR408xhnlMMO8dr0MZ+4wix8Ua8oHrSIOszzcFOQlYD
CcyT0mBmCN19dbzF+ZDqGz6Mj7Ds7uURCru8hVFk+VzuhkoShQJdfxkYQqSSStOr
Igr28omXfPva4ahhh3RBHXhc7hP5yu0vfVpFkfRiceujUQb7aTyRoJEp/fdyMfDU
vs3aioWeq05QoMKvSps7Wq+1V7rRryEBWIeO+aaa6NAn4LOrDsJ787Nu+CcChUAm
djxQ6KlM68ENOD2mHbqbg+PQZDDMXpvUkKSNsRraCCyxnRLt5iKoS5MAIuvUF0wf
tD2wRaepfQJx0qf7kTt+QE7EilNQWjDvonUZTSToQvKZzMes/ZhyuKyFflGuzNEa
zXyYmEXxAoV/AAs2amemLEdAeDs5BZlPxcB17VXBOSIazsaEmjNpeDjeElHMGu/J
GrYDuO1kQhMSg7gtDtPfoslKFfl/GBorCPdcJCrLJNAqMYtTvIih64yli5qJEBfN
psIvcMSQC2LckBGPz2AKzVORPy4M4WIcrNjH8+plhZtC0u7VnL61QvQjnql68EIn
ABgJM7rz23OzcYKrVrZgE3lmhOO8HarS9ifIk3lSHZgp1dXsDbc=
=Gbo1
-----END PGP SIGNATURE-----

--ixzervdxjrzxhrrb--
