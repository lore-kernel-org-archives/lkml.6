Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeDKXM3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 19:12:29 -0400
Received: from 220.107.128.77.rev.sfr.net ([77.128.107.220]:43232 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbeDKXM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 19:12:28 -0400
Message-ID: <e2c0a2c9442f1563865aaab310e066a18d425793.camel@paulk.fr>
Subject: Re: [PATCH 1/3] drm/panel: Add RGB666 variant of Innolux AT070TN92
From: Paul Kocialkowski <contact@paulk.fr>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>
Date: Thu, 12 Apr 2018 01:12:13 +0200
In-Reply-To: <20180411062835.oqzd34e2szrnv34b@flea>
References: <20180410213129.24049-1-contact@paulk.fr>
         <20180411062835.oqzd34e2szrnv34b@flea>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Rrf1dUj1vrQz5d/Oqhue"
X-Mailer: Evolution 3.28.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Rrf1dUj1vrQz5d/Oqhue
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 11 avril 2018 =C3=A0 08:28 +0200, Maxime Ripard a =C3=A9crit :
> On Tue, Apr 10, 2018 at 11:31:27PM +0200, Paul Kocialkowski wrote:
> > This adds timings for the RGB666 variant of the Innolux AT070TN92
> > panel,
> > as found on the Ainol AW1 tablet.
> >=20
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  drivers/gpu/drm/panel/panel-simple.c | 26
> > ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c
> > b/drivers/gpu/drm/panel/panel-simple.c
> > index 5591984a392b..efeb2f2162bc 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -1063,6 +1063,29 @@ static const struct panel_desc
> > innolux_at070tn92 =3D {
> >  	.bus_format =3D MEDIA_BUS_FMT_RGB888_1X24,
> >  };
> > =20
> > +static const struct drm_display_mode innolux_at070tn92_rgb666_mode
> > =3D {
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
>=20
> I'm not sure why you'd need different timings if the only difference
> is the bus width.

I'll try with the other timings, although it might be desirable to have
a higher clock speed thanks to the reduced number of wires on the bus.

> > +static const struct panel_desc innolux_at070tn92_rgb666 =3D {
> > +	.modes =3D &innolux_at070tn92_rgb666_mode,
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
> > @@ -2105,6 +2128,9 @@ static const struct of_device_id
> > platform_of_match[] =3D {
> >  	}, {
> >  		.compatible =3D "innolux,at070tn92",
> >  		.data =3D &innolux_at070tn92,
> > +	}, {
> > +		.compatible =3D "innolux,at070tn92-rgb666",
> > +		.data =3D &innolux_at070tn92_rgb666,
>=20
> And this isn't a different device, it's just the integration in the
> board that is different, so you shouldn't have a different compatible
> here, but rather something like the bus-width property documented in
> the Documentation/devicetree/bindings/media/video-interfaces.txt file.

I'll take a look at it and try to craft v2 in this direction then.

Thanks for the review!

--=20
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-Rrf1dUj1vrQz5d/Oqhue
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlrOlk0ACgkQhP3B6o/u
lQyr8w//WAJaArvsaQW2UvNJA7txzcUdH79ZKSzuKuB/PDrdX2VnLBr63zRStEcL
sp0brTzcXJb3fpiDjncHAyHinmE4LvaWgQpx0wqHEFvcLX//SsgCZ23lCV/3e/u2
IaWw6PS5qUGVMf5B2iSDWtAAWEU49dkqnN80AUYxh4Qwg0sDV0BBVbw+cTdY+1Di
LX/dCsYZHtebsEVf3/UQSj4lgg2ToVJBnb/u+cQQtnXTnzZ/1I4HIlbC0ioprjhS
hPB99AmfzavwTsBU/D8ixtS8e1WorL+KHQHbqo6ZdMPqwj93KTlaQ29LobRQKl1q
sp6emm/IFK5EI/e2n8zzVUeAs1UtCsMan/LmuuERIl9ee+GpX0hgLPWC7JPV2hwi
I73/qJotvoIuGlRPVL8bmoyjbyGLR2BpGbk7AwLHTQdr5P/jFMQcUbiWAa/wkqh5
dZCsB767Dg+YaRvfo+4bQX2FayklveMODaqzn7uKKpdkp8VmtatWCckhqQWUpVYC
JHdHy7fo6WPui3d853xR/LjMBVGrwxnDO7ByPPpXevv0RC3zkWKcDzrZ4N2bJTp1
u6G0C2hO/7ZWsiE87WGSVBqmEktb/Wmr+af4iG//DBKdEJimzdoht9Zv6omYLUah
wrSjZqhdSh2azmzb/ZNFq8EKiTMRVqimSaXbfp/YV1V2N6UE/o8=
=STx8
-----END PGP SIGNATURE-----

--=-Rrf1dUj1vrQz5d/Oqhue--
