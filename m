Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeBSIyZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 03:54:25 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:56162 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbeBSIyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 03:54:24 -0500
Date: Mon, 19 Feb 2018 09:54:08 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: wens@csie.org, linux@armlinux.org.uk, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        quentin.schulz@bootlin.com
Subject: Re: [PATCH v3 7/7] ARM: sun8i: smp: Remove the disabling of CPU0
Message-ID: <20180219085408.5to43p7jbtijx4q3@flea.lan>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
 <20180219081837.15482-8-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n3avigllm7j4bwce"
Content-Disposition: inline
In-Reply-To: <20180219081837.15482-8-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n3avigllm7j4bwce
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2018 at 09:18:37AM +0100, Myl=E8ne Josserand wrote:
> On sun8i-a63t, hotplug CPU for CPU0 is currently not working.
> Remove the possibility to disable CPU0 only for sun8i-a83t.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>
> ---
>  arch/arm/mach-sunxi/mc_smp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
> index fec592bf68b4..69d5ae5b3d72 100644
> --- a/arch/arm/mach-sunxi/mc_smp.c
> +++ b/arch/arm/mach-sunxi/mc_smp.c
> @@ -661,8 +661,12 @@ static int sunxi_mc_smp_cpu_kill(unsigned int l_cpu)
>  	return !ret;
>  }
> =20
> -static bool sunxi_mc_smp_cpu_can_disable(unsigned int __unused)
> +static bool sunxi_mc_smp_cpu_can_disable(unsigned int cpu)
>  {
> +	/* CPU0 hotplug handled only for sun9i */
> +	if (of_machine_is_compatible("allwinner,sun8i-a83t"))
> +		if (cpu =3D=3D 0)
> +			return false;

This also means that you have a window in your patch sequence where
you can disable the CPU0 on the A83t. This patch should be earlier.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--n3avigllm7j4bwce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqKkK8ACgkQ0rTAlCFN
r3Txuw//UM3frw2Utw0Qi37IMTm2va2eh/yqzkQaYi1bZE29+XDQiAwxyLNb+066
efCWddCxIvxoFANfZ+95+NoccGYXtU3Csg36+40AV84xpxOLEp3HR8+ueH5GFhL6
oh9mxmrQ/eZMYKVEp97u4Dft7H0TdTpPF8qDppzdqGVmZFpXzjjdxGUTArQrDpik
Z1Hl3rGDubNy20LXlcxvBhXpBamrZhMjO4uk1tjqvNR1tFX5AXDZGI81FFTVBcX0
VYWq+NcGIW0bOTbtgJM6QY8m8aC5O4siQ35VMPU69HqQ2VpMn0w07gMkBYH32YUj
4OGuKFCCHTFThE0TCD0LgooVxwVU/7V8pfIQxKgDIb88TiepCh6fx0IdBYRXbyeH
YvFpy8R/DGnKNuLrDkVHiBsfv3Ia5bvWpoDakMzi7ykSeivuZc+gvsnyWz5zhXcN
iEVi13Sx6HNUYXwcNqGCA8I3MOc3abn+xm2tQGWIJUtVimo2X8hyjVTE0d5YtQnh
xN7eUo5hWmAHFqpKMXK4eHsS7bdm257XArKiANQHt0rOQpwEJ0TiPnE3ffAP9vbI
GW9F0KMPICLEXYhsg8luP1r1F3MHTSzGi7LyP5OFN+X+ILNEPhYes/SfO5bLG8nC
VQm+ds/noz326rlZT/hlUVWbWYiZjWrgBzGjSm4pjo1vRThuwd0=
=eZxo
-----END PGP SIGNATURE-----

--n3avigllm7j4bwce--
