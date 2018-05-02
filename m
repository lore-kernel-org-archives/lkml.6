Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeEBLdE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:33:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47351 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751079AbeEBLdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:33:02 -0400
Date: Wed, 2 May 2018 13:32:50 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 02/21] arm64: dts: allwinner: a64: Add DE2 CCU
Message-ID: <20180502113250.5i2eyzv237t5oyl6@flea>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="urvus633irkg5na3"
Content-Disposition: inline
In-Reply-To: <20180430114058.5061-3-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--urvus633irkg5na3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 05:10:39PM +0530, Jagan Teki wrote:
> DE2 in A64 has clock control unit and behavior is
> same like H3/H5, so reuse the same in A64.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index 1b2ef28c42bd..67b80bbe5bf5 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -43,9 +43,11 @@
>   */
> =20
>  #include <dt-bindings/clock/sun50i-a64-ccu.h>
> +#include <dt-bindings/clock/sun8i-de2.h>
>  #include <dt-bindings/clock/sun8i-r-ccu.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/sun50i-a64-ccu.h>
> +#include <dt-bindings/reset/sun8i-de2.h>
> =20
>  / {
>  	interrupt-parent =3D <&gic>;
> @@ -168,6 +170,19 @@
>  		#size-cells =3D <1>;
>  		ranges;
> =20
> +		display_clocks: clock@1000000 {
> +			compatible =3D "allwinner,sun50i-a64-de2-clk",
> +				     "allwinner,sun50i-h5-de2-clk";

The A64 was released before the H5, so that should be the other way
around.

> +			reg =3D <0x01000000 0x100000>;
> +			clocks =3D <&ccu CLK_DE>,
> +				 <&ccu CLK_BUS_DE>;
> +			clock-names =3D "mod",
> +				      "bus";
> +			resets =3D <&ccu RST_BUS_DE>;
> +			#clock-cells =3D <1>;
> +			#reset-cells =3D <1>;
> +		};
> +

So it turns out we don't need the SRAM to access the CCU driver?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--urvus633irkg5na3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrpodMACgkQ0rTAlCFN
r3T3VQ//S/G55KqTYTfHCm8/2H0AQTqf8MyYhHeliYSAxF551L+shkCg0jmiSk/2
lqE4O8LeeLS/nJe/gocSlW/UcurE1DDLJmqkjkZ8g5sPo1jtnSzAlpbI3oqnzU0A
7dFeoAykbKgIlRpa5U6vg5VkUwd1GXP2asw6z+Qf9YcBcm8bMdgy+5JcbL+JdpEJ
Tu5aZ8Z12wEyMPJAVgxFjANdR77rtWN0GkfamK1SPgnN/ARwZzKWBq6vZcJWHTvr
4iCnJ0WrKi/EJGchARt6zxGn0/36LbP4ZqRKp44Uv4USeVw6veoQgisjgr2HUL9T
P6jcQ7ANmRBnenXPDkl5BvYZPH6RUh13rwyX1lDEpTQ4aFHXig2QilZFmi/i852a
5IG5UxaTdC9jiLrutEyJT0QEwRAm5IhrbH9MVRwqdhNCW2WjPk65SfSvUx7QkIVw
k5XtpOM6Pb1zo5F51tLMu0Ikqv9qLO94XTGgpggXsdV5xy+eK/7OI9aaoKjYmJdB
GIKy4+oFDFCFtNaIt+vmlc067fedOFic19LFNWpFNVVJ2rfc3L0JUZjwjklEtiMl
CWpkrRlD5kK7pUu0vscHOR51FWkT1vjPxwGBuTAWciAkTg4iSRYVhWHDL+T0E92G
jQ9CexZUqPSTonEBiz1+PVH8Ug4VV0kGZmcmHuxeN8+/HGGxdvA=
=bJM5
-----END PGP SIGNATURE-----

--urvus633irkg5na3--
