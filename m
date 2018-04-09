Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbeDIJYp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 05:24:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41085 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751673AbeDIJYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 05:24:43 -0400
Date: Mon, 9 Apr 2018 11:24:31 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/13] ARM: sunxi: Add initialization of CNTVOFF
Message-ID: <20180409092431.yfupppnbypnx6ha5@flea>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-9-mylene.josserand@bootlin.com>
 <20180403091218.t6xuq6csjp4uyy5u@flea>
 <20180403220628.19c9acaf@dell-desktop.home>
 <20180404074515.r6nbkpcyy6vfelbr@flea>
 <20180408110932.7ef29ed2@dell-desktop.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wyjsakd6dief2kjg"
Content-Disposition: inline
In-Reply-To: <20180408110932.7ef29ed2@dell-desktop.home>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wyjsakd6dief2kjg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 08, 2018 at 11:09:32AM +0200, Myl=E8ne Josserand wrote:
> Hello Maxime,
>=20
> On Wed, 4 Apr 2018 09:45:15 +0200
> Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>=20
> > On Tue, Apr 03, 2018 at 10:06:28PM +0200, Myl=E8ne Josserand wrote:
> > > Hello,
> > >=20
> > > Thank you for the review.
> > >=20
> > > On Tue, 3 Apr 2018 11:12:18 +0200
> > > Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >  =20
> > > > On Tue, Apr 03, 2018 at 08:18:31AM +0200, Myl=E8ne Josserand wrote:=
 =20
> > > > > Add the initialization of CNTVOFF for sun8i-a83t.
> > > > >=20
> > > > > For boot CPU, Create a new machine that handles this
> > > > > function's call in an "init_early" callback.
> > > > > For secondary CPUs, add this function into secondary_startup
> > > > > assembly entry.
> > > > >=20
> > > > > Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>
> > > > > ---
> > > > >  arch/arm/mach-sunxi/headsmp.S |  1 +
> > > > >  arch/arm/mach-sunxi/sunxi.c   | 18 +++++++++++++++++-
> > > > >  2 files changed, 18 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/=
headsmp.S
> > > > > index 79890fbe5613..b586b7cf803a 100644
> > > > > --- a/arch/arm/mach-sunxi/headsmp.S
> > > > > +++ b/arch/arm/mach-sunxi/headsmp.S
> > > > > @@ -71,6 +71,7 @@ ENDPROC(sunxi_mc_smp_cluster_cache_enable)
> > > > > =20
> > > > >  ENTRY(sunxi_mc_smp_secondary_startup)
> > > > >  	bl	sunxi_mc_smp_cluster_cache_enable
> > > > > +	bl	smp_init_cntvoff
> > > > >  	b	secondary_startup
> > > > >  ENDPROC(sunxi_mc_smp_secondary_startup)
> > > > > =20
> > > > > diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/su=
nxi.c
> > > > > index 5e9602ce1573..090784108c0a 100644
> > > > > --- a/arch/arm/mach-sunxi/sunxi.c
> > > > > +++ b/arch/arm/mach-sunxi/sunxi.c
> > > > > @@ -16,6 +16,7 @@
> > > > >  #include <linux/platform_device.h>
> > > > > =20
> > > > >  #include <asm/mach/arch.h>
> > > > > +#include <asm/smp_cntvoff.h>
> > > > > =20
> > > > >  static const char * const sunxi_board_dt_compat[] =3D {
> > > > >  	"allwinner,sun4i-a10",
> > > > > @@ -62,7 +63,6 @@ MACHINE_END
> > > > >  static const char * const sun8i_board_dt_compat[] =3D {
> > > > >  	"allwinner,sun8i-a23",
> > > > >  	"allwinner,sun8i-a33",
> > > > > -	"allwinner,sun8i-a83t",
> > > > >  	"allwinner,sun8i-h2-plus",
> > > > >  	"allwinner,sun8i-h3",
> > > > >  	"allwinner,sun8i-r40",
> > > > > @@ -75,6 +75,22 @@ DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i Fa=
mily")
> > > > >  	.dt_compat	=3D sun8i_board_dt_compat,
> > > > >  MACHINE_END
> > > > > =20
> > > > > +void __init sun8i_cntvoff_init(void)
> > > > > +{
> > > > > +	smp_init_cntvoff();   =20
> > > >=20
> > > > Can't this be moved to the SMP setup code? =20
> > >=20
> > > I tried to put it in the first lines of "sunxi_mc_smp_init" function
> > > but it did not work. I tried to find some callbacks to have an
> > > early "init" and I only found the "init_early"'s one. There is probab=
ly
> > > another way to handle that so do not hesitate to tell me any ideas. =
=20
> >=20
> > It's hard to say without more context about why it doesn't work. Have
> > you checked the order between early_initcall, the timer initialization
> > function and init_early?
> >=20
>=20
> Yes, I tested it. I wanted to test it again to give more context. Here
> is the boot log: http://code.bulix.org/n1x864-315948?raw
> I added printk in the 3 functions (with "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D>").
>=20
> The "init_early" and "sun6i_timer" are executed before
> "arch_timer_of_init" (which is the function that parses the DT property
> that we used previously "arm,cpu-registers-not-fw-configured").
> The "sunxi_mc_smp_init" function is called later so I guess that is why
> it is not working in that case.

Ok. Make sure to mention that in your commit log.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--wyjsakd6dief2kjg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrLMU4ACgkQ0rTAlCFN
r3Q4Bg//ZB8yanfXYzPCvAbYC2ToGBNpVMGHYkbFoUxfRa7z6cpwxftqHxjTt8Bo
Sr9oT+TpKHlfcMXZneRxjAgms6DNzIbF9NeRrnnfzaPupjBDb6iFWJONRDoW3Qis
aOdxodXMnNdppqR9HbsvnRcwqkYUDYsiEJLUxuZLWVxuzFiUiV0k8EIaVMhH3PIW
2x5zd7QO82z9nK05Dk1P9tSZH5Jnz2JYRqhMTsVx11jVkK1jHQFDwjxFDcoF+ogr
vmBVYrqvFYJso89Fwx31HRiYUMq4OJdoZh1IvFUTY2wKbPRXo9NlVj2FUyJQaTQu
+GLeA4xLQS4RV3cewpGbndeO5xUqk3ugZYHq3UNAK4oUq13FG5VvA/uHn7ON07ZK
xgoYPNXtGuTGDbaNd2tL5RWxqgC2JfqDRojyon9oVTHU+o0GyVn0QDwoOc80aAol
wGHAiE+zXfbDVzrGL7DSXEFZjB4vupRaOYHaxktiQxLrfqtGFNMXUXtoFlb2+2ZJ
Fd5MtYr/DV5LbXT0ePjPODsY9IuYSvWRzOGYBV62YBSVFTT8Cy3tiLKEWCA+nd7X
jqFkkrIQ0Wn2lJJR1eDtKz7gN1Q4cw+WLxhe8ZmjMzGJE9awUdd+8+zlX7h0xx6e
93WKSrccDgAqGfFvQybHARw2Q3CpsvZnIn6KUdJ2mFHnY2IvUsc=
=+YHq
-----END PGP SIGNATURE-----

--wyjsakd6dief2kjg--
