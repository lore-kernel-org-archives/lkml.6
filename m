Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbeDQHwh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 03:52:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49062 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbeDQHwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 03:52:35 -0400
Date: Tue, 17 Apr 2018 09:52:33 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, horms@verge.net.au,
        geert@linux-m68k.org, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/11] ARM: sun9i: smp: Add is_sun8i field
Message-ID: <20180417075233.f2z6wxcazwqheoib@flea>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
 <20180416215032.5023-9-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pwy6pi3nx75zjbfe"
Content-Disposition: inline
In-Reply-To: <20180416215032.5023-9-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pwy6pi3nx75zjbfe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 16, 2018 at 11:50:29PM +0200, Myl=E8ne Josserand wrote:
> To prepare the support of sun8i-a83t, add a field in the smp_data
> structure to know if we are on sun9i-a80 or sun8i-a83t.
>=20
> Add also a global variable to retrieve which architecture we are
> having.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>
> ---
>  arch/arm/mach-sunxi/mc_smp.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
> index 03f021d0c73e..9d57ea27dacc 100644
> --- a/arch/arm/mach-sunxi/mc_smp.c
> +++ b/arch/arm/mach-sunxi/mc_smp.c
> @@ -74,6 +74,7 @@ static void __iomem *sram_b_smp_base;
> =20
>  extern void sunxi_mc_smp_secondary_startup(void);
>  extern void sunxi_mc_smp_resume(void);
> +static int is_sun8i;
> =20
>  static bool sunxi_core_is_cortex_a15(unsigned int core, unsigned int clu=
ster)
>  {
> @@ -624,6 +625,7 @@ struct sunxi_mc_smp_nodes {
>  struct sunxi_mc_smp_data {
>  	const char *enable_method;
>  	int (*get_smp_nodes)(struct sunxi_mc_smp_nodes *nodes);
> +	int is_sun8i;
>  };
> =20
>  static void __init sunxi_mc_smp_put_nodes(struct sunxi_mc_smp_nodes *nod=
es)
> @@ -664,6 +666,7 @@ static const struct sunxi_mc_smp_data sunxi_mc_smp_da=
ta[] __initconst =3D {
>  	{
>  		.enable_method	=3D "allwinner,sun9i-a80-smp",
>  		.get_smp_nodes	=3D sun9i_a80_get_smp_nodes,
> +		.is_sun8i	=3D false,

I'm still not convinced about the name of that flag. sun8i doesn't
mean anything, really. What you want to discriminate against it what
you're writing in your commit log: if it is an A80 or an A83t. The
A33, H3, A23, you name it are also part of the sun8i family, yet they
are completely irrelevant to this file.

Also, false is the default value, you can leave it out.

>  	},
>  };
> =20
> @@ -697,6 +700,8 @@ static int __init sunxi_mc_smp_init(void)
>  			break;
>  	}
> =20
> +	is_sun8i =3D sunxi_mc_smp_data[i].is_sun8i;
> +

Do we really need to cache it? Can't we just have a pointer to the SMP
data structure and use that instead?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--pwy6pi3nx75zjbfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrVp8AACgkQ0rTAlCFN
r3Rifw/9Gl4bEy8NdYh8PZltDYtIne5lOveP6B50wOPrqnnhzqHmGT4daHqI4Hkd
G/MHWDA4CY1al4AJ/tgdSAmO9G+akVAqb2PQzZf5WuTbt94QuFh2FXYeArfETlmC
H+wom1lAe1Ub1OxMJWttTphLiwKMeeP1bmskhClWsmQl2/FK/xf6JD9SgyUgoUtE
ad2fd+6lwEg4XGg5HjWoj0+T/fNI7CuyFFogaHF6CrKE5hzDdDZ2ap4TJPtQoBbJ
m85VlCALsy7wMUZDFiLcd+qF9Ro7pyGgk4D615sWyJ3G54z5O8as1SimFnYE+bCM
A1o2h7hOzsn/7I2L0ZcNg93R34GqyZVtty5FhRrPptMOlFZ6YKyNhN/8UJjN9xWy
WJ4qVofdhZKyD2NtLYxAR883guagxQeO817sTr7EDbBDEa0BdSeUeCxYUwg6v7Ve
eNITpT0miJk+xmp+9zd+/LyJvl3+nDE8OejlWPf7z6horVXDVypcU8+CF4cmPxPJ
bFjOx1IPsPSoolwnruIgbxk4dbytQVHHTrgqss0mBdYcrwVs8iaQ126d8mmArqGv
76PaNfSFaT4LYnnMm5c0gr3sjfI/RivAaLmWPmaJM+X3MIlvunBuMmunZKJK5Y9G
kYtYQYQGI+eoltx2LCWBb1ZCup8S3STC1Sskp+gqCdovrp9+sVM=
=PVeK
-----END PGP SIGNATURE-----

--pwy6pi3nx75zjbfe--
