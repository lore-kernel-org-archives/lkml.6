Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbeEBLty (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:49:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48008 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751276AbeEBLtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:49:36 -0400
Date: Wed, 2 May 2018 13:49:24 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Chen-Yu Tsai <wens@csie.org>,
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
Subject: Re: [linux-sunxi] Re: [PATCH 02/21] arm64: dts: allwinner: a64: Add
 DE2 CCU
Message-ID: <20180502114924.pq5k5p33svedgca4@flea>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-3-jagan@amarulasolutions.com>
 <20180502113250.5i2eyzv237t5oyl6@flea>
 <DF02AB5F-D4A5-4198-B455-FEE880CF83CE@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tlzwoke5jer4kmrx"
Content-Disposition: inline
In-Reply-To: <DF02AB5F-D4A5-4198-B455-FEE880CF83CE@aosc.io>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tlzwoke5jer4kmrx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2018 at 07:34:21PM +0800, Icenowy Zheng wrote:
>=20
>=20
> =E4=BA=8E 2018=E5=B9=B45=E6=9C=882=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=887=
:32:50, Maxime Ripard <maxime.ripard@bootlin.com> =E5=86=99=E5=88=B0:
> >On Mon, Apr 30, 2018 at 05:10:39PM +0530, Jagan Teki wrote:
> >> DE2 in A64 has clock control unit and behavior is
> >> same like H3/H5, so reuse the same in A64.
> >>=20
> >> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >> ---
> >>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 15 +++++++++++++++
> >>  1 file changed, 15 insertions(+)
> >>=20
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> index 1b2ef28c42bd..67b80bbe5bf5 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> @@ -43,9 +43,11 @@
> >>   */
> >> =20
> >>  #include <dt-bindings/clock/sun50i-a64-ccu.h>
> >> +#include <dt-bindings/clock/sun8i-de2.h>
> >>  #include <dt-bindings/clock/sun8i-r-ccu.h>
> >>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >>  #include <dt-bindings/reset/sun50i-a64-ccu.h>
> >> +#include <dt-bindings/reset/sun8i-de2.h>
> >> =20
> >>  / {
> >>  	interrupt-parent =3D <&gic>;
> >> @@ -168,6 +170,19 @@
> >>  		#size-cells =3D <1>;
> >>  		ranges;
> >> =20
> >> +		display_clocks: clock@1000000 {
> >> +			compatible =3D "allwinner,sun50i-a64-de2-clk",
> >> +				     "allwinner,sun50i-h5-de2-clk";
> >
> >The A64 was released before the H5, so that should be the other way
> >around.
> >
> >> +			reg =3D <0x01000000 0x100000>;
> >> +			clocks =3D <&ccu CLK_DE>,
> >> +				 <&ccu CLK_BUS_DE>;
> >> +			clock-names =3D "mod",
> >> +				      "bus";
> >> +			resets =3D <&ccu RST_BUS_DE>;
> >> +			#clock-cells =3D <1>;
> >> +			#reset-cells =3D <1>;
> >> +		};
> >> +
> >
> >So it turns out we don't need the SRAM to access the CCU driver?
>=20
> As now U-Boot claims SRAM, people may forget thus :-(

This is definitely not ok. We should have that described in the DT as
well.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--tlzwoke5jer4kmrx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrppcMACgkQ0rTAlCFN
r3TS6g//carLuWzIy6gha+84NR2oYZHnfTrCZDzIfkV9OoHOlG3v+7nyfdYl0O4G
dTibYK/6m7OV1lbOtAyT3Kg04jwoRTnHZiRD5GIvIIPAm0H/xP8R93AsDlMRfW4y
rGQc2yLAUzJQd9K5BnqcZnxaxG2brl56JYs36r9H9cCslnu2K6gRblQjRt9kExT3
lRvL7hGdSMk6K60xc1BHe5WQjcxqpo7vXuhaAjGfXvU3NfXOS2eZzLzRZGsH3Pk3
YAr3aEBkKnx65nvx9OsAAEWk3CkTozRKqiN1EQwU86LsCNohF27rpFa34QOeprLw
0gBUacVvfDXFiiU4uh7JqUR+IlwMA8DQaAWhyn6thMpU5vIzhTodapEQlPgWhcDT
QlEJNeDgTy/418H+IFmq+hfZ+jtUu1rYj0SeFdji3d/5m+cY02P5dE4Dy/dbGUER
/lo6z4tQ+ibn0hfpvZglqS2rlnfUU0UJ/igzXaq6MLRZcrayUGqG+dWOLpwIM8jb
G8QHhAqcltvHqU2PM5PabUm1jQYXXjYAtNelryvBTRxoR22NqSqPz2lzY8nAkM6y
bXtIZ1iqiJ8eYVNGOu0NLx/6S1YJEBm1Doq46igyah23oBUe2Z8TfEJhkvDfUUV2
Cl1PfMcz+wdhXZdCIJVSeMc/FXYoQdSsXueyCp1PefbxhfSr3q8=
=b0Cy
-----END PGP SIGNATURE-----

--tlzwoke5jer4kmrx--
