Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbeEGSuk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 14:50:40 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:36916 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752676AbeEGSuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 14:50:37 -0400
Message-ID: <8050492b544e5783d16eb74050313bfdddc0fc0d.camel@paulk.fr>
Subject: Re: [PATCH v3 1/3] drm/panel: Add RGB666 variant of Innolux
 AT070TN90
From: Paul Kocialkowski <contact@paulk.fr>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org
Date: Mon, 07 May 2018 20:50:23 +0200
In-Reply-To: <20180507070855.dh47obvpmze577x5@flea>
References: <20180506214901.23429-1-contact@paulk.fr>
         <20180507070855.dh47obvpmze577x5@flea>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-pO4jWJbZQwRC3mFFtFHZ"
X-Mailer: Evolution 3.28.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pO4jWJbZQwRC3mFFtFHZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le lundi 07 mai 2018 =C3=A0 09:08 +0200, Maxime Ripard a =C3=A9crit :
> Hi,
>=20
> On Sun, May 06, 2018 at 11:48:59PM +0200, Paul Kocialkowski wrote:
> > This adds timings for the RGB666 variant of the Innolux AT070TN90
> > panel,
> > as found on the Ainol AW1 tablet.
> >=20
> > The panel also supports RGB888 output. When RGB666 mode is used
> > instead,
> > the two extra lanes per component are grounded.
> >=20
> > In the future, it might become necessary to introduce a dedicated
> > device-tree property to specify the bus format and maybe specify it
> > in
> > the mode description instead of panel description so that the
> > appropriate mode can be selected for each bus format.
> >=20
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>=20
> A change log would be nice. Also, you mentionned in your first version
> that the screen was an AT070TN92, and now you mention that it is an
> AT070TN90, which one is it?

Yes, I should probably have explained why I changed the model here.
I checked on the device yesterday and found that the ribbon cable
indicates AT070TN90. I am not sure why I was initially assuming that the
panel was an AT070TN92.=20

> Maxime
>=20
> > ---
> >  drivers/gpu/drm/panel/panel-simple.c | 26
> > ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c
> > b/drivers/gpu/drm/panel/panel-simple.c
> > index cbf1ab404ee7..351742df8ee1 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -1086,6 +1086,29 @@ static const struct panel_desc
> > innolux_at070tn92 =3D {
> >  	.bus_format =3D MEDIA_BUS_FMT_RGB888_1X24,
> >  };
> > =20
> > +static const struct drm_display_mode innolux_at070tn90_mode =3D {
> > +	.clock =3D 40000,
> > +	.hdisplay =3D 800,
> > +	.hsync_start =3D 800 + 112,
> > +	.hsync_end =3D 800 + 112 + 1,
> > +	.htotal =3D 800 + 112 + 1 + 87,
> > +	.vdisplay =3D 480,
> > +	.vsync_start =3D 480 + 141,
> > +	.vsync_end =3D 480 + 141 + 1,
> > +	.vtotal =3D 480 + 141 + 1 + 38,
> > +	.vrefresh =3D 60,
> > +};
> > +
> > +static const struct panel_desc innolux_at070tn90 =3D {
> > +	.modes =3D &innolux_at070tn90_mode,
> > +	.num_modes =3D 1,
> > +	.size =3D {
> > +		.width =3D 154,
> > +		.height =3D 86,
> > +	},
> > +	.bus_format =3D MEDIA_BUS_FMT_RGB666_1X18,
> > +};
> > +
> >  static const struct display_timing innolux_g101ice_l01_timing =3D {
> >  	.pixelclock =3D { 60400000, 71100000, 74700000 },
> >  	.hactive =3D { 1280, 1280, 1280 },
> > @@ -2154,6 +2177,9 @@ static const struct of_device_id
> > platform_of_match[] =3D {
> >  	}, {
> >  		.compatible =3D "innolux,at070tn92",
> >  		.data =3D &innolux_at070tn92,
> > +	}, {
> > +		.compatible =3D "innolux,at070tn90",
> > +		.data =3D &innolux_at070tn90,
>=20
> This should be ordered alphabetically.

Thanks for the review!

Cheers,

Paul

--=20
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-pO4jWJbZQwRC3mFFtFHZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlrwn+8ACgkQhP3B6o/u
lQxquA//XKzR9OjdCYa5ePJa1UQBRjpdiT1z/xGHn4bRm5XyBKByh5GtQ96yrHKG
bLd5TIig/Cd6AbiX/sb6bS0Hpp5tYdEWb9XiLLn3JpUugBdoHh9qxiYenQt/5tlX
JtdKfmifRkDoTjaBzFzSO/0CVVVmBzHuXSLxuif2Fn2WijdIJz3Ioof+7+feUjTX
nSL85ueAdOzZGSrS2zHuFZb9UXu9yrJ10lvyMu5qBTtGn1lT3C+Q2lr3nkgTWw1r
K/n3hd0T8Z5Zwkt4f7xqTcX7WQr8Jxf7fLYt26nTZYKORUYHNcHLuHcTHDZis1Ov
kC9PI3dOtNMVx1eskKU8t8nDOvHI+ECObArxdMIDu+Zc13/UeqVea3GaLBvAzCOi
gV4xDAtcIvt8c+Kk7tesXana/9uPg/CAl5wSfuOCGr6caFcYURLU8utc/8s5IAYh
BQqZxl5ugV/XUhX/PhPbu7sOKcslFOUUVOMnOyKq6vXODLH7e4LDFs4D5aHnRKW1
8zwreIfRV4ssnAFlROYQSzB6LaaPgjoAXTPEWUggL08VkgF9dF5sAIBa7M98FsNA
KdfweSOmlKbaivRVReKf0+ZNe2FC8VyMuZuGGQ94//j3v1Z/kDnjKY4r0I4qtjbN
4ub8nBqZlA3vHILQo9uBOkiEtb4lapShAkiVcE2sIedldRdvwiw=
=R+uD
-----END PGP SIGNATURE-----

--=-pO4jWJbZQwRC3mFFtFHZ--
