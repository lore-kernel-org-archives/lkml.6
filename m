Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeA3Ica (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 03:32:30 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:32963 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbeA3IcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 03:32:17 -0500
Date: Tue, 30 Jan 2018 09:32:05 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        davem@davemloft.net, hans.verkuil@cisco.com, mchehab@kernel.org,
        rask@formelder.dk, clabbe.montjoie@gmail.com, sean@mess.org,
        krzk@kernel.org, quentin.schulz@free-electrons.com, icenowy@aosc.io,
        edu.molinas@gmail.com, singhalsimran0@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 10/16] iio: adc: sun4i-gpadc-iio: add support for A83T
 thermal sensor
Message-ID: <20180130083205.j4b2wua7knymkfn6@flea.lan>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-11-embed3d@gmail.com>
 <20180129094803.uiojqkmaeuihbe4p@flea.lan>
 <94bc070d-8675-95fe-2857-188f7cc66071@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ieehdml3djel7reb"
Content-Disposition: inline
In-Reply-To: <94bc070d-8675-95fe-2857-188f7cc66071@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ieehdml3djel7reb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

1;5002;0c
On Mon, Jan 29, 2018 at 12:53:48PM +0100, Philipp Rossak wrote:
>=20
>=20
> On 29.01.2018 10:48, Maxime Ripard wrote:
> > On Mon, Jan 29, 2018 at 12:29:13AM +0100, Philipp Rossak wrote:
> > > This patch adds support for the A83T ths sensor.
> > >=20
> > > The A83T supports interrupts. The interrupt is configured to update t=
he
> > > the sensor values every second.
> > >=20
> > > Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> > > ---
> > >   drivers/iio/adc/sun4i-gpadc-iio.c | 38 ++++++++++++++++++++++++++++=
++++++++++
> > >   include/linux/mfd/sun4i-gpadc.h   | 18 ++++++++++++++++++
> > >   2 files changed, 56 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4=
i-gpadc-iio.c
> > > index 8196203d65fe..9f7895ba1966 100644
> > > --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> > > +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> > > @@ -170,6 +170,40 @@ static const struct gpadc_data sun8i_h3_ths_data=
 =3D {
> > >   		SUN8I_H3_THS_TEMP_PERIOD(0x7),
> > >   };
> > > +static const struct gpadc_data sun8i_a83t_ths_data =3D {
> > > +	.temp_offset =3D -2724,
> > > +	.temp_scale =3D -70,
> > > +	.temp_data =3D {SUN8I_H3_THS_TDATA0,
> > > +		SUN8I_A83T_THS_TDATA1,
> > > +		SUN8I_A83T_THS_TDATA2,
> > > +		0},
> > > +	.sample_start =3D sunxi_ths_sample_start,
> > > +	.sample_end =3D sunxi_ths_sample_end,
> > > +	.sensor_count =3D 3,
> > > +	.supports_nvmem =3D false,
> > > +	.support_irq =3D true,
> > > +	.ctrl0_map =3D SUN4I_GPADC_CTRL0_T_ACQ(0x1f3),
> > > +	.ctrl2_map =3D SUN8I_H3_THS_ACQ1(0x1f3),
> >=20
> > Where are these values coming from?
> >=20
>=20
> These values are calculated with the formulas from the datasheet and also
> tested on hardware. These settings seem ok.

You should at least put a comment explaining how you got to these values.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ieehdml3djel7reb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpwLYQACgkQ0rTAlCFN
r3SNqg/+Pbf081lBp5zcX1ZMV8zn8pRtZyB9qduDiJC8cXiO/KWLWoPQ2h0pZCPE
sdtSCjEIRs5hTrr7Fp1V19zKEjXuUNM2qT9qfVzYJRenJKGVBY38g8VEJ79rEYpB
y3BnXv0C7wji9UefwBgQe8XeTUXfTmJ78B5QGlKBhx6/JEB7TRv+SAljNk63++8l
cEXMrwiHvFBb7S34SYliemw9bY05EwPiNTMY6Dq6ePkzdoUh2cCM4bMbNfJlotNe
eg7/8dOT1UU1ccJtk1x+5MziCT0R96CPFZZ8zXAXJ+irr73VFXCSIFVtCl/Y7e5r
m5Vr0upU0z+qVyee4myEunhtS8BZuG11Cp7XyrzgAheJ1zjg/ncxipCpRPTyeMOA
xfq2rfAEa7XOLhITBPFuNSKY/4zmdN08JbeOf6z2OZU4aubhH9W2xcC6e8+UfCCc
zhs5Xz8kA3gn/uUmDaZEpLtHkVjH79DV6jd/0oNhT4LJpFMzqukdCV4dM02Gj6yV
qsfc+gaALZNZuqyCy0kXjY+aSYcukRZC21Aiczkck7bDMUHsKzUQJm1PvqTow594
gZmzbiZL+7Af+QAZu4ASCGwdS24XapxNxeWxJWaq9D/20mD9iGTBGWO9t8pYCrBB
4rYCpYKjJtOuPVrhK3D30u+5peHU5yPHuuTQOwDmNIfKzJKDd1c=
=S29J
-----END PGP SIGNATURE-----

--ieehdml3djel7reb--
