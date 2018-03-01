Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967200AbeCAJ4o (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:56:44 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36240 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967092AbeCAJ4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:56:42 -0500
Date: Thu, 1 Mar 2018 10:56:28 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/sun4i: increase lvds dclk max divisor
Message-ID: <20180301095628.7wmzahyxwlffptmx@flea>
References: <1519840432-61489-1-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ph5qljsbgxqclj7o"
Content-Disposition: inline
In-Reply-To: <1519840432-61489-1-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ph5qljsbgxqclj7o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2018 at 06:53:51PM +0100, Giulio Benetti wrote:
> At the moment both min and max dclk div are set to 7.
> This doesn't allow to have lower frequencies.
>=20
> Increase dclk_max_div to 18 to achieve 30Mhz.
>=20
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/s=
un4i_tcon.c
> index 029d2ce..bb35f41 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -278,7 +278,7 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tc=
on *tcon,
>  	u32 reg, val =3D 0;
> =20
>  	tcon->dclk_min_div =3D 7;
> -	tcon->dclk_max_div =3D 7;
> +	tcon->dclk_max_div =3D 18;

This needs much more justification.

What panel did you test it on? Why aren't we able to reach 30MHz
already? Why do you care about 30MHz and not any other frequency?

https://github.com/linux-sunxi/linux-sunxi/blob/sunxi-3.4/drivers/video/sun=
xi/disp/disp_clk.c#L686

Why Allwinner is always using 7, just like U-Boot is, and we should
use something different?

Why 18 would be a better choice?

All that should be in your commit log.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ph5qljsbgxqclj7o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqXzksACgkQ0rTAlCFN
r3TOHA/9Gge9Xej0P/efGV4jFS+jozOS0R0zgT/DhE+iXpeAD7XG2gHJGD/1NIqU
m5oQDOQYG/+Bv+w6PJsLZYGi6KvagabN9YTT9wUxJalRybhMY+v5c5/29XgJ+A3V
H6zry2eO0jjAL489RER0wjS7pqSk7+TkCCKHhx6xBlZFUEh/lcC1qU4nb2zPIyDl
ZCt9VnAALlY7GbF1wJ/0yhyDUkBbsQWB2/a8Q0lo4kz6S9RDBE/C2d/kS3/8EfZY
TlOMPmAMoO9LW0pqXS++9GSuPBxMsf/1InSZiWKe7660vz+l6IQHva2hVLauuUya
fD21z0PZRO0ac/y1MOAaS8cbIp7oZy1VTYkQ32CnuUPsX8Id4bl76rYIQOIoQk4H
hYu2XTV9QZECs57p1ZEOPJhLkuICGFm5/l2xq0lcTRgKbcZ6iR1OCXlsYViWivry
wSKnCkFV3c8wFh+v4oiTO80hJeHzeKHNFtwyvuDKT2jPJmu2lfj25Qun1G2SHerB
fiMAnU9JO5UXfJothZ5DAW0gDdR6Wmr3/4cfmxckA9TA9KM1hGd+zETFvtCWwyzn
E7DcK2LgKi04gM1f6FMD1pIGPJSgH8Aadaxjebu0o4Vkr5A/U7Wny/nAWu9hJVSr
qZ8anFUmxTD36K1dyb0SlONfVHHZAhWfUKQT7cGjig6PBka+SW0=
=Bvo0
-----END PGP SIGNATURE-----

--ph5qljsbgxqclj7o--
