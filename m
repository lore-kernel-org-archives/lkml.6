Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754086AbeDTHfD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:35:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55622 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753922AbeDTHfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:35:01 -0400
Message-ID: <f89313a67594665f4ddf88e76947ba642b554358.camel@bootlin.com>
Subject: Re: [PATCH] drm/sun4i: Add missing frontend compatibles for A10,
 A13, A20 and A31
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chen-Yu Tsai <wens@csie.org>
Date: Fri, 20 Apr 2018 09:33:36 +0200
In-Reply-To: <20180419150759.ldi676ejnbtmb27z@flea>
References: <20180419125638.11683-1-paul.kocialkowski@bootlin.com>
         <20180419150759.ldi676ejnbtmb27z@flea>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-OjTcU76JSgIL/4bxs5lp"
X-Mailer: Evolution 3.28.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OjTcU76JSgIL/4bxs5lp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2018-04-19 at 17:07 +0200, Maxime Ripard wrote:
> On Thu, Apr 19, 2018 at 02:56:38PM +0200, Paul Kocialkowski wrote:
> > Although frontend nodes are defined in the device-trees of the
> > aforementioned platforms, there are no matching compatibles defined
> > in
> > the driver. This makes it impossible to probe the frontend on these
> > platforms.
> >=20
> > Adding the appropriate compatibles to the driver fixes the issue.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_frontend.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> > b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> > index 85f75046712c..c5a3de11817d 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> > @@ -658,6 +658,10 @@ static const struct dev_pm_ops
> > sun4i_frontend_pm_ops =3D {
> >  };
> > =20
> >  const struct of_device_id sun4i_frontend_of_table[] =3D {
> > +	{ .compatible =3D "allwinner,sun7i-a10-display-frontend" },
> > +	{ .compatible =3D "allwinner,sun7i-a13-display-frontend" },
> > +	{ .compatible =3D "allwinner,sun7i-a20-display-frontend" },
> > +	{ .compatible =3D "allwinner,sun7i-a31-display-frontend" },
>=20
> Most of these compatibles are wrong, so it won't really work :)

Sorry for screwing up so bad...

> If you only tested it on the A20, just add it. We didn't add all of
> them because there's some slight variations between the generations
> that are not yet taken into account.

That makes sense. I will thus send v2 with A20 only and send follow-up
patches for other platforms when tested and properly working.

Thanks!

--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
--=-OjTcU76JSgIL/4bxs5lp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlrZl9AACgkQ3cLmz3+f
v9ELDgf9HL+ZeLe1filKlSe7fbY14l+VseOn8D+mIsAgd+YEDKvUUxEQ9WSrV+tN
U7P/z/UCP3taLOM3oEIqFVAudAjmKo4/yXKQ6bG+bvqTezymwCxtaCzWUboX6tbN
3CfB+2zK0kwV3+IdPrZ2ADRrFNDkPw5VCs85QARB79UZE5r22vtGbDF5K7jj+ooo
QrCWSWApj/2GmSq78I8obxKkrZaFuCnX/v73hfhhsxMNexBaFoCl8WnrwFo/YDAo
HpotmgVdwQReo1OGLDr5d8H3Knka63oyjPZB+Nu5hmWCZHTGnbcRTQd+nP4135kc
0KxHwWUa273r5Tq5fEKV43VWKfFpvQ==
=K7Nc
-----END PGP SIGNATURE-----

--=-OjTcU76JSgIL/4bxs5lp--
