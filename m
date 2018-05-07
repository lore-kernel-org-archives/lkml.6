Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeEGHJB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 03:09:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43007 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751941AbeEGHI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 03:08:57 -0400
Date: Mon, 7 May 2018 09:08:55 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <contact@paulk.fr>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] drm/panel: Add RGB666 variant of Innolux AT070TN90
Message-ID: <20180507070855.dh47obvpmze577x5@flea>
References: <20180506214901.23429-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zflohqhccy2xls4x"
Content-Disposition: inline
In-Reply-To: <20180506214901.23429-1-contact@paulk.fr>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zflohqhccy2xls4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 06, 2018 at 11:48:59PM +0200, Paul Kocialkowski wrote:
> This adds timings for the RGB666 variant of the Innolux AT070TN90 panel,
> as found on the Ainol AW1 tablet.
>=20
> The panel also supports RGB888 output. When RGB666 mode is used instead,
> the two extra lanes per component are grounded.
>=20
> In the future, it might become necessary to introduce a dedicated
> device-tree property to specify the bus format and maybe specify it in
> the mode description instead of panel description so that the
> appropriate mode can be selected for each bus format.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

A change log would be nice. Also, you mentionned in your first version
that the screen was an AT070TN92, and now you mention that it is an
AT070TN90, which one is it?

Maxime

> ---
>  drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel=
/panel-simple.c
> index cbf1ab404ee7..351742df8ee1 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1086,6 +1086,29 @@ static const struct panel_desc innolux_at070tn92 =
=3D {
>  	.bus_format =3D MEDIA_BUS_FMT_RGB888_1X24,
>  };
> =20
> +static const struct drm_display_mode innolux_at070tn90_mode =3D {
> +	.clock =3D 40000,
> +	.hdisplay =3D 800,
> +	.hsync_start =3D 800 + 112,
> +	.hsync_end =3D 800 + 112 + 1,
> +	.htotal =3D 800 + 112 + 1 + 87,
> +	.vdisplay =3D 480,
> +	.vsync_start =3D 480 + 141,
> +	.vsync_end =3D 480 + 141 + 1,
> +	.vtotal =3D 480 + 141 + 1 + 38,
> +	.vrefresh =3D 60,
> +};
> +
> +static const struct panel_desc innolux_at070tn90 =3D {
> +	.modes =3D &innolux_at070tn90_mode,
> +	.num_modes =3D 1,
> +	.size =3D {
> +		.width =3D 154,
> +		.height =3D 86,
> +	},
> +	.bus_format =3D MEDIA_BUS_FMT_RGB666_1X18,
> +};
> +
>  static const struct display_timing innolux_g101ice_l01_timing =3D {
>  	.pixelclock =3D { 60400000, 71100000, 74700000 },
>  	.hactive =3D { 1280, 1280, 1280 },
> @@ -2154,6 +2177,9 @@ static const struct of_device_id platform_of_match[=
] =3D {
>  	}, {
>  		.compatible =3D "innolux,at070tn92",
>  		.data =3D &innolux_at070tn92,
> +	}, {
> +		.compatible =3D "innolux,at070tn90",
> +		.data =3D &innolux_at070tn90,

This should be ordered alphabetically.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--zflohqhccy2xls4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrv+4YACgkQ0rTAlCFN
r3StJA/+Ivqt5/ogoP/WZe9C4b6EswFcTuzZy1j+RoW+qqHXmtuC+3BrPLvkZa4o
UyVEoFUd8ZF6yienLfFBgS0iAbwlOfwEDJ8lsarWfSxM+7ExTJd40puEqCqEiSXt
4rClJ+zlTwQjUbZ6tDgG5f6LPfPnzmykma0WRftvy9InXXE3JzDp0R8jg+oecodB
BZg7wiLtXYIlkxCxIGc7amvpFpB+aNQyRJ0MfUAw6qziYdU31qfSlSrnxi6YVUkq
eBu4HxOeVTLcsdby2j7aqkY8vF94KjM+it58erhOOT6sFLd1V3zZUFUUvtrNplTy
wXp3CADKVqw4paeSXTtK+mwfho01Tj14wqg4il2r5UMH5RgKtL9GGyipvxFsy6vg
xar5A7MtBXgDeUvrOU9Hoo4lPxxLqNVURz+KrdiKn6y3DQInPHB/FZVtMt0R17YJ
EvMSpbBsL9K+nwUUIIq1GSTx0k3XQl0zME988U6tvfqtaHTEY7ImeL3Vl4h9B8HY
d/DtOJj2R86gL1upY+ZLPSQPJQUfbZOVNI4DjuujYixgJclhAHTmq2W+R51zxMEz
cl8CeGVCwQYXT6OnvAVhgpAFVbqhhaWlbsLjd5d3dbV0B7vVGwnySQujkvUmVi8k
ZZdMAxaYxGQ7BNkzxfFCfleS4zUnyefx1Y/XXwVYyshXJSK/JRw=
=5ukw
-----END PGP SIGNATURE-----

--zflohqhccy2xls4x--
