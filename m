Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeBSIFO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 03:05:14 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:54197 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbeBSIFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 03:05:12 -0500
Date: Mon, 19 Feb 2018 09:05:11 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: sunxi: Fix multi-cluster SMP support compilation in
 multi v6/v7 configs
Message-ID: <20180219080511.wfzeokrwbyyr5l3r@flea.lan>
References: <20180217050112.14619-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uliexox7evjvie7b"
Content-Disposition: inline
In-Reply-To: <20180217050112.14619-1-wens@csie.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uliexox7evjvie7b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2018 at 01:01:12PM +0800, Chen-Yu Tsai wrote:
> Various parts of the assembly code used in the multi-cluster SMP support
> requires ARMv7-A. If the kernel config also has multi v6 support enabled,
> Kbuild defaults to building for armv6k, which does not support some of
> the instructions we use.
>=20
> Configure the Makefile such that the multi-cluster SMP code is always
> built for ARMv7-A. This is also what mach-exynos does for their MC-SMP
> code.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>=20
> This addresses "[sunxi:sunxi/core-for-4.17 1/4] /tmp/ccSQM2rD.s:438:
> Error: selected processor does not support `isb' in ARM mode"
> reported by the kbuild test robot for arm-allmodconfig.
>=20
> Should we apply it, or squash it in the original patch?

I guess we can squash it. And while you're at it..

> ---
>  arch/arm/mach-sunxi/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
> index 3e741e959c7c..3c2c4384357a 100644
> --- a/arch/arm/mach-sunxi/Makefile
> +++ b/arch/arm/mach-sunxi/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_ARCH_SUNXI) +=3D sunxi.o
>  obj-$(CONFIG_ARCH_SUNXI_MC_SMP) +=3D mc_smp.o
> +CFLAGS_mc_smp.o	+=3D -march=3Darmv7-a

Can you move it to the first line of the file (before the other obj-*)
with a newline after it?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--uliexox7evjvie7b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqKhTYACgkQ0rTAlCFN
r3RSPg//WQ922QD6D+HGRjy/An0+zVZsFf7mX6C8S9Q3tTjwgwqwXVLwROIexo3L
lJHDIwpZyFAzpGriHlJyASwfJL6m+lHBxfKewvzsT+FRH3l3gBi/shktSVSRnWpX
ftgre0wgUX3rUhe1Q29DdpJtx7jAeXnTNefuq3ZGh7GBVze6tbzMUqNHGuoQW8PP
ky/TChf7fp7wC8NagYT16xB09DwIqHQefAWc09i+P5yaSWxUYOiplw0c2XR2JD+s
G+U2CBATdjPJeuSR9p0dKvP8xVjEypQ3D2tAtEcp3+kz5z86OWw44Pd9ujVERwEO
yM8lxmKwkTeFbYsvFEJ0xkIQhiIzzGhViWbFCrX70GzPuA6iBLsCOao86wGUe/r3
HC0NIk2lyttGHtw20XKuQohuhKs1V94gMiQwH+YqbpILy8+1YroGdRpwzl6XawAH
9EdzAXYzkbXCivFkLQWnPPSC/oh71hxQm0/FeMDs34mp5gZSCphbiKDqjJBrnd/R
n8oQt4967efe7eVITroNpVcDVAMVOBAgNm4p8TzgW1wDHwfn9kNjMzn5NRWGqKqq
t+6diPmlq3VLpzOtRYoRZ6s3aLC34lUWCV3Pj7rw7//su9nm3atjFqTGNvlcu4sW
o4pimS56P062B52HxJxgXYyGJhRQDJm8801rkFwffklxsFRCnJ0=
=UIg8
-----END PGP SIGNATURE-----

--uliexox7evjvie7b--
