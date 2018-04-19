Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbeDSPIC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:08:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41183 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752255AbeDSPIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:08:00 -0400
Date: Thu, 19 Apr 2018 17:07:59 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] drm/sun4i: Add missing frontend compatibles for A10,
 A13, A20 and A31
Message-ID: <20180419150759.ldi676ejnbtmb27z@flea>
References: <20180419125638.11683-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sk4w4ak4ug7fr4in"
Content-Disposition: inline
In-Reply-To: <20180419125638.11683-1-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sk4w4ak4ug7fr4in
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 02:56:38PM +0200, Paul Kocialkowski wrote:
> Although frontend nodes are defined in the device-trees of the
> aforementioned platforms, there are no matching compatibles defined in
> the driver. This makes it impossible to probe the frontend on these
> platforms.
>=20
> Adding the appropriate compatibles to the driver fixes the issue.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_frontend.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun=
4i/sun4i_frontend.c
> index 85f75046712c..c5a3de11817d 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> @@ -658,6 +658,10 @@ static const struct dev_pm_ops sun4i_frontend_pm_ops=
 =3D {
>  };
> =20
>  const struct of_device_id sun4i_frontend_of_table[] =3D {
> +	{ .compatible =3D "allwinner,sun7i-a10-display-frontend" },
> +	{ .compatible =3D "allwinner,sun7i-a13-display-frontend" },
> +	{ .compatible =3D "allwinner,sun7i-a20-display-frontend" },
> +	{ .compatible =3D "allwinner,sun7i-a31-display-frontend" },

Most of these compatibles are wrong, so it won't really work :)

If you only tested it on the A20, just add it. We didn't add all of
them because there's some slight variations between the generations
that are not yet taken into account.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--sk4w4ak4ug7fr4in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrYsM4ACgkQ0rTAlCFN
r3RNaA//bNOeQyYkcMiGcFl0atmmm3fCaTvzu884/wb5chuTULV3gXwU+W0v3LC9
OXsY6rrnRMCA0F3TK+9QJlTfCX8cmer8+N4iBcYLW+3T5SdheCZ8KbUXr37vFL2p
7Gb/eyyIPnmEdQgo+9QglHy+END3KNPxMreyfbXJO5n6JV1tcoJFO8oisRDzFcWL
r6y1h23d7kQJ1lX0V3YUYOkuwM2FsbnX3lzy9w8uNSvrbTrE53GZ7BuTTFoF8iMO
u3ZMUNec9M+3V+dHUfcEgAJM5fcNwukLYGt0QX0LJ+nIf9HZGeleo+tC7llemFJP
NKYvI0XoJ9NXnnSKMTJB/8FfWTLnD6gfkB16FToVQEbOl5epxO+0CDYtuw8q6qOW
WHCprigNVOc0UXeu7zE36kanIOWsRK8gPxLlxJ+ciNobzf4KL3Rl1gJuBPu5il0k
RS2ksUs7fiYNXU94B24S21Z49w9oqNKs46mt1aQu225vbnlWq1pu0WTeVQ7KLrMP
UKbm772BQZR2peLBdi9/d94o4g372yNF1e8zd1uc0uTTXcdWtVpm4zqugy1RzlS9
Nwh5o47V6aNNMKL1yig31E+km39WSu+FU/eGqf3IW0H4W7dAXGlWQiJCllFbwioh
UeznItUpr76GYeZ88BRRSGw2BE67iPhS2bqyuHZut5Fdrl1RfZs=
=PeI3
-----END PGP SIGNATURE-----

--sk4w4ak4ug7fr4in--
