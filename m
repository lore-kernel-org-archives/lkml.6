Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752925AbeDLOvv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:51:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56917 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752763AbeDLOvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:51:48 -0400
Date: Thu, 12 Apr 2018 16:51:36 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <contact@paulk.fr>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH 3/3] ARM: dts: sun7i: Add support for the Ainol AW1 tablet
Message-ID: <20180412145136.zp2i7u76oinphiiz@flea>
References: <20180410213129.24049-1-contact@paulk.fr>
 <20180410213129.24049-3-contact@paulk.fr>
 <20180411070657.kw6uckqtmwb7p5hf@flea>
 <7f6d6a6a5a0cc2d37ebba046509d4f25d3bfa600.camel@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kzof2any5a4z6n2z"
Content-Disposition: inline
In-Reply-To: <7f6d6a6a5a0cc2d37ebba046509d4f25d3bfa600.camel@paulk.fr>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kzof2any5a4z6n2z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2018 at 01:08:51AM +0200, Paul Kocialkowski wrote:
> > > +	backlight: backlight {
> > > +		compatible =3D "pwm-backlight";
> > > +		pinctrl-names =3D "default";
> > > +		pinctrl-0 =3D <&backlight_enable_pin>;
> >=20
> > You don't need any of the pinctrl nodes for the GPIOs
>=20
> I tried without the pinctrl nodes and got issues on various controllers
> (e.g. i2c for the touchscreen) because of the missing pinctrl nodes on
> 4.16. Maybe I'm missing some patches here?

You don't need any patches. What was the error exactly?

> > > +&cpu0 {
> > > +	cpu-supply =3D <&reg_dcdc2>;
> > > +};
> >=20
> > How was CPUfreq tested?
>=20
> In fact, I haven't tried it at all, but I can definitely do that with
> e.g. ssvb's stress test for various cpufreq functioning points.

That would be great yes.

> > > +&i2c2 {
> > > +	pinctrl-names =3D "default";
> > > +	pinctrl-0 =3D <&i2c2_pins_a>;
> > > +	status =3D "okay";
> > > +	clock-frequency =3D <400000>; /* 400 KHz required for
> > > GSL1680. */
> >=20
> > I'm not sure that comment is worth it. The only device there is the
> > touchscreen, so it's kind of obvious that it's the device that needs
> > that frequency.
>=20
> Well, I found a similar comment in the other dts using the same
> touchscreen controller. Since the information was rather valuable (it
> made it clear that I needed the same clock frequency for that specific
> touchscreen),

You can have the same kind of comment for pretty much all DT
lines. you could for example have on the pinctrl property just above
the comment that the I2C2 on that boards are tied to those pins. But
that's just redundant, and the SNR would be pretty bad if we were to
do it everywhere.

> it might help others in the future (even if only when grepping for
> gsl1680).
>=20
> > > +
> > > +	gsl1680: touchscreen@40 {
> > > +		compatible =3D "silead,gsl1680";

You have the gsl1680 two times here, so grep would find it either way.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--kzof2any5a4z6n2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrPcncACgkQ0rTAlCFN
r3Qe5Q/+OuvoFK4/P/KP9WZXdYNoZ+D1ZxAmSi7Go4LQRT2cyDY2xbKzgFkOkRZM
4UR2fi6pWq2hAmo/wIJEqWyM6G+ap7gQqYqnx+xy/0L7/Gvh9HI9N5gOsaumOHQh
yAouc24BkYAeDawDYI94CK4DdNeIR2IxUD3Eusv8FObMbdIbMjxzR33GzzPs5ZBI
tLNpbmBoTdDgDB9ZACW1qNUo5ldq4fWjr7DG8RIcbcm01LPxZVkvkZRIznzn+aA9
kZqfYAQR1tKSXMib1QUq7r7HrhTVee/xWcSTEeBx88iE6O/WPKv+r9NMEs0UrrtR
d6avThX/eM7iwVMx+WrecIStlm4xRjoYQ4CijeSPu97S5bWqSbcN5pW4Oq8ifrIs
JuZc2xTstoo6ckxlTnw/IFvxPyR2sOp+XtW+mPX3JPH1OtExZ5ICuDhmKxziXO06
a1FOkIpyMyvNrJ1SpK45gAyRZII97fSR7dV1GXAdtXw71ow3I3SQqoz4R8hChjK4
EP0GivTGTIlxv6xxieYSeSFQSacR7tprkmuPqofcLzUFOSas7JRi0eAWbLCXD9mT
a5HVrfPqUxcfseruAr92UBSk5TY8HqHxmhrQPuq3brMaK1pN7u8ziCdX71+VTDwC
XrSGFn8hQItdWwx1GYVHAkg7eznR5019blrGRSSt+cs+2v8UfYg=
=iwU/
-----END PGP SIGNATURE-----

--kzof2any5a4z6n2z--
