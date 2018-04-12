Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeDLOpm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:45:42 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:47323 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752870AbeDLOpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:45:40 -0400
X-Auth-Info: qzn3QHLZHQ39jrfkrIuTl37N0o5USIzBUbn1rP8XHmg=
Date: Thu, 12 Apr 2018 16:45:35 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Joe Perches <joe@perches.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/2] input: touchscreen mc13xxx: Add mc34708 support
Message-ID: <20180412164535.324a218a@jawa>
In-Reply-To: <4690e30b3c4b97847123295f1994c6eafe4e0cbb.camel@perches.com>
References: <20180411141340.30939-1-lukma@denx.de>
        <20180411141340.30939-2-lukma@denx.de>
        <4690e30b3c4b97847123295f1994c6eafe4e0cbb.camel@perches.com>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ahDu70l8WIhCE2XFKRzQbVD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ahDu70l8WIhCE2XFKRzQbVD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Apr 2018 09:01:01 -0700
Joe Perches <joe@perches.com> wrote:

> On Wed, 2018-04-11 at 16:13 +0200, Lukasz Majewski wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> >=20
> > The mc34708 has a different bit to enable pen detection. This
> > adds the driver data and devtype necessary to probe the device
> > and to distinguish between the mc13783 and the mc34708. =20
>=20
> style trivia:
>=20
> > diff --git a/drivers/input/touchscreen/mc13783_ts.c
> > b/drivers/input/touchscreen/mc13783_ts.c =20
> []
> > @@ -96,6 +135,10 @@ static void mc13783_ts_report_sample(struct
> > mc13783_ts_priv *priv)=20
> >  	cr0 =3D (cr0 + cr1) / 2;
> > =20
> > +	if (priv->drvdata->type =3D=3D MC13XXX_TYPE_MC34708)
> > +		if (cr0 > 4080)
> > +			cr0 =3D 0; =20
>=20
> For easy of reading, this multiple if block should either
> use braces around the first if like:
>=20
> 	if (foo) {
> 		if (bar)
> 			single_statement;
> 	}
>=20
> or be written
>=20
> 	if (foo && bar)
> 		single_statement;
>=20
> I generally prefer the latter style.
>=20

+1.

I will fix it in v2.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/ahDu70l8WIhCE2XFKRzQbVD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlrPcQ8ACgkQAR8vZIA0
zr0w3wf+LFFcRxd7PeY+xB7Eya/OhCLtq/DwUCVi688nQObrhsUn0yvpfoR93LOo
xyE2WP+08T3dj2Jl/3yhxVATuE92kcf1cXaBbgDnxf7ceiRV1OOPwHRUAHnowKfd
EiO6FsRsEGDyd4dm6/ZF8upyJIj2l6+HsPabJAzpEYpS8NZAjnsilDW9ohH55FNb
Cx6f5VD8Wk8JWfkroyKgBTZZWJVDDGzsaLzLysnRHZWJDHg35xRLV46E5q4vV3hI
2a4TWtltRzz03cf2taTvlBS1S8H7bmx84pNw0PTBIjTHkBT6xOIO8eenMiGkyn4S
Yf/7IlFPi6zvesEKdMmF4v/3bSZEfw==
=xOTR
-----END PGP SIGNATURE-----

--Sig_/ahDu70l8WIhCE2XFKRzQbVD--
