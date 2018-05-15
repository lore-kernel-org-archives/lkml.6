Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753464AbeEONfZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 09:35:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33549 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753000AbeEONfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 09:35:23 -0400
Date: Tue, 15 May 2018 15:35:11 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <contact@paulk.fr>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v4 1/3] drm/panel: Add RGB666 variant of Innolux AT070TN90
Message-ID: <20180515133511.ufsoctkhx5fah7q7@flea>
References: <20180507220413.21990-1-contact@paulk.fr>
 <20180509071226.ivh4s3wtczg2u7zw@flea>
 <c8ab5f472881063b90abe9461933baf6ee325dcd.camel@paulk.fr>
 <20180511085938.wjmdsdjfvdxd4shk@flea>
 <abeac1ee792b8f063001c4c280ca7f0167ac59be.camel@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ei3lmr5vhdjqn3p3"
Content-Disposition: inline
In-Reply-To: <abeac1ee792b8f063001c4c280ca7f0167ac59be.camel@paulk.fr>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ei3lmr5vhdjqn3p3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 10:40:15PM +0200, Paul Kocialkowski wrote:
> Le vendredi 11 mai 2018 =E0 10:59 +0200, Maxime Ripard a =E9crit :
> > On Wed, May 09, 2018 at 01:31:23PM +0200, Paul Kocialkowski wrote:
> > > On Wed, 2018-05-09 at 09:12 +0200, Maxime Ripard wrote:
> > > > On Tue, May 08, 2018 at 12:04:11AM +0200, Paul Kocialkowski wrote:
> > > > > This adds timings for the RGB666 variant of the Innolux AT070TN90=
 panel,
> > > > > as found on the Ainol AW1 tablet.
> > > > >=20
> > > > > The panel also supports RGB888 output. When RGB666 mode is used i=
nstead,
> > > > > the two extra lanes per component are grounded.
> > > > >=20
> > > > > In the future, it might become necessary to introduce a dedicated
> > > > > device-tree property to specify the bus format to use instead of =
the
> > > > > default one for the panel. This will allow supporting different b=
us
> > > > > formats for the same panel modes.
> > > > >=20
> > > > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > > > ---
> > > > >  drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++=
++++
> > > > >  1 file changed, 26 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/d=
rm/panel/panel-simple.c
> > > > > index cbf1ab404ee7..32e30d5a8f08 100644
> > > > > --- a/drivers/gpu/drm/panel/panel-simple.c
> > > > > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > > > > @@ -1063,6 +1063,29 @@ static const struct panel_desc innolux_at0=
43tn24 =3D {
> > > > >  	.bus_flags =3D DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSE=
DGE,
> > > > >  };
> > > > > =20
> > > > > +static const struct drm_display_mode innolux_at070tn90_mode =3D {
> > > > > +	.clock =3D 40000,
> > > > > +	.hdisplay =3D 800,
> > > > > +	.hsync_start =3D 800 + 112,
> > > > > +	.hsync_end =3D 800 + 112 + 1,
> > > > > +	.htotal =3D 800 + 112 + 1 + 87,
> > > > > +	.vdisplay =3D 480,
> > > > > +	.vsync_start =3D 480 + 141,
> > > > > +	.vsync_end =3D 480 + 141 + 1,
> > > > > +	.vtotal =3D 480 + 141 + 1 + 38,
> > > > > +	.vrefresh =3D 60,
> > > > > +};
> > > > > +
> > > > > +static const struct panel_desc innolux_at070tn90 =3D {
> > > > > +	.modes =3D &innolux_at070tn90_mode,
> > > > > +	.num_modes =3D 1,
> > > > > +	.size =3D {
> > > > > +		.width =3D 154,
> > > > > +		.height =3D 86,
> > > > > +	},
> > > > > +	.bus_format =3D MEDIA_BUS_FMT_RGB666_1X18,
> > > > > +};
> > > > > +
> > > >=20
> > > > I'm not really convinced this is the right approach. You said it
> > > > yourself, the panel is using a 24-bits interface, and you just happ=
en
> > > > to have a tablet that routed it using a 18-bits interface instead.
> > > >=20
> > > > That doesn't belong in the driver, especially associated to the
> > > > compatible, but where the routing is described: in the device
> > > > tree. And given that the panel interface is a 24 bits panel, if we
> > > > were to have a default, we should have this one, and not the one
> > > > fitting your use case.
> > >=20
> > > I fully agree, this is why I suggested introducing a dedicated dt
> > > property for selecting the bus format (in the commit message). I still
> > > proposed this patch as a temporary solution, but I'm definitely willi=
ng
> > > to craft a proper solution as well.
> > >=20
> > > Here is an initial proposition:
> > > 1. Making bus_format an array in struct panel_desc and listing all the
> > > relevant bus formats that the panel can support there;
> >=20
> > I'm not sure this is needed, the input format is always the same in
> > your case, the panel will always take a 24 bits RGB value. What you
> > want to change is the encoder output format (and I guess you want that
> > to be meaningful to enable or not the dithering).
>=20
> Isn't the panel format supposed to match what the encoder's output
> should be aiming for? In my case, that would be RGB666, so the idea
> would be specifying both MEDIA_BUS_FMT_RGB666_1X18 and
> MEDIA_BUS_FMT_RGB888_1X24 in a list of supported bus formats for the
> panel.

The width your panel has in input is in 24 bits. The width the encoder
outputs in is 16 bits. This is the panel driver, you should expose the
panel capabilities.

> This way, both my setup and RGB888 setups can be supported.

I don't see what prevents you to do that with my suggestion either.

> > > 2. Introducing an optional "bus-format" dt property that indicates wh=
ich
> > > bus format to use, and using the first index of the bus formats array=
 if
> > > the property is not present;
> >=20
> > I guess the width would be enough, and that way we can take the
> > bus-width format that is already defined (but used in the v4l2
> > framework, not in DRM yet).
>=20
> Well, we already have bus-format defines on the DRM side and it feels
> like mapping these directly in device-tree would be more useful as a
> description of the hardware than just having the bus width.

Having the format in the DT doesn't make much sense. A given panel can
support multiple formats, just like a given encoder can.

If you're in that situation, the DT would describe a policy over what
happens in the OS, which isn't what should be stored in the DT. The
bus width, on the other end, is a property of the hardware.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ei3lmr5vhdjqn3p3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr64g4ACgkQ0rTAlCFN
r3ThiA//QnxC7mIXf3qOh6PTiHwsOu+ps5hGzloO8KE/nECs2J+AWCBG6RSSfnnI
SLJxXaBeBrMe46KaoY3vK9sQkYJIA1t0UeuJSKnr3L4hHl6jy5yTfC6UCIFIfcoe
zr0+zEUJyfWfIacqwJ4MiWIAkE+SvSk8oEORs63TyotiXmmshDLz8PxcbcYDYXjZ
8sl3sGOZPbJmQ1p5f7SooompjdEk6HIZ44U+N4dTJ42J3N9gH96kmN4TPeGVFvAA
w9jEMFJWraUl33lWoRXaVvmeEgFZtfaGPX5LwxSa5uANss6D8GkkZXv16x8wrVW6
C0sKw93CRbnfrVhm8NkXOUv5iuUN5ra5q8Da9mLqxSwEJEG79Je0ynfifU6YdONx
flL/nxpAbTUZHtn0+NYBdzfg1vQfgUs767WUZkY3NEWT9MI5Pgzf9BWN0/sGwPKc
iQj3aNXUPQuN7J7kilj2lzu2L2XSg5U2OAi5sh5JGnsk5r/ngcKCR7SySlBs2+rv
qd/ELQnno3hnh6YCdTtsLvPE/ZsHSTDWTf24/iRS4CiiNUeUb6IA+WTZsVHZ+P9a
JVtJdFfkUy/mSu3lCpNxwan6KA6i0YZmvhx8j3Aeek94Chi2c0/9UGaVDWEKijrS
lRrKE6FieRysJkzSzidFpg3MiqrH+mblK7CG6YMN6aiw/wNyVc4=
=Qdp0
-----END PGP SIGNATURE-----

--ei3lmr5vhdjqn3p3--
