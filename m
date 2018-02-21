Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932092AbeBUJQi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:16:38 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:54186 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752953AbeBUJQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:16:35 -0500
Date: Wed, 21 Feb 2018 10:16:23 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-gpio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: Keep returning EPROBE_DEFER when we should
Message-ID: <20180221091623.4accxa2qglmo3scl@flea.lan>
References: <20180221081100.17662-1-maxime.ripard@bootlin.com>
 <CACRpkdYkT7TJrhyQoJr=ZK7w8+KY=_fgjrJeaZCsLHA_6WbZbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4prxzbnw74xsag7v"
Content-Disposition: inline
In-Reply-To: <CACRpkdYkT7TJrhyQoJr=ZK7w8+KY=_fgjrJeaZCsLHA_6WbZbg@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4prxzbnw74xsag7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 09:17:15AM +0100, Linus Walleij wrote:
> On Wed, Feb 21, 2018 at 9:11 AM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
>=20
> > Commits c85823390215 ("gpio: of: Support SPI nonstandard GPIO propertie=
s")
> > and 6a537d48461d ("gpio: of: Support regulator nonstandard GPIO
> > properties") have introduced a regression in the way error codes from
> > of_get_named_gpiod_flags are handled.
> >
> > Previously, those errors codes were returned immediately, but the two
> > commits mentioned above are now overwriting the error pointer, meaning =
that
> > whatever value has been returned will be dropped in favor of whatever t=
he
> > two new functions will return.
> >
> > This might not be a big deal except for EPROBE_DEFER, on which GPIOlib
> > customers will depend on, and that will now be returned as an hard error
> > which means that they will not probe anymore, instead of gently deferri=
ng
> > their probe.
> >
> > Since EPROBE_DEFER basically means that we have found a valid property =
but
> > there was no GPIO controller registered to handle it, fix this issues by
> > returning it as soon as we encounter it.
> >
> > Fixes: c85823390215 ("gpio: of: Support SPI nonstandard GPIO properties=
")
> > Fixes: 6a537d48461d ("gpio: of: Support regulator nonstandard GPIO prop=
erties")
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>=20
> Whoops sorry for that, patch applied for fixes.
>=20
> Thanks you for your help!

This is slightly embarrassing, but that patch doesn't actually fix
anything. I tried to be smart and rework it to look nicer, and
obviously failed.

Can you squash
http://code.bulix.org/z1vkt1-286673

in the commit?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--4prxzbnw74xsag7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqNOOMACgkQ0rTAlCFN
r3Tb6g//Q2lFAtKtYeAf/xxqoHMH2QAF60g2uC8D+qiX8wGUAUReqacGolVbmmES
bjWMzyUJI6hnTSnhl4VchvBLoiM7wd/LthXii5gHcVgBJmeah/u/Wx8dkn9JVeQ6
MZRqvMcNPIgLC9b/gdUQmWL0pQqlQ3MQOJpF5eZyaiTHQCcO+IK0LHM9ahOZqu6j
P7Fp15MGxFvAlyGje+yl1ydTXepc/th+ranKMlJ8wec5j8bE5gl1aaF9MYkjBXK5
CYxuXWfkJ8990DpgIKgX/1wh10AH5UqycweyHSXnI3geEqbIxaG2mDb2Wifa3fOW
+54nkKRDhC2xxCKyTtJzF4pwCDqqncImvZcpDUFDjuiypYulE0zX2PZvXcMEpew+
vksqJUsp+IA/F5u2haagg+qiX9mxzC0jjz3HFzEUs5dhmnSyyG2pUZRqM3+bzvYi
8nugwP+LGulxqyOBeCnm2sfqU3i+tCqTy8axWZfOynA3VFbG/g515FSF5L9Vj/FC
jQEONJXnBemvLypxbUILyoX8JXtbxvKP53OKyCvFYNqnL/E9CbR3RF70a7Fnax00
M38qQg65vu93drUrcriJc5JWRXshiz9o/H2RDoyC3yglFDxUHSRlGTEWty4ZyAXi
MtbDjavfeN8CJTzozZWLvXLONOiJ+VKKh1tErr/mh7/yAH8f+tU=
=CqVB
-----END PGP SIGNATURE-----

--4prxzbnw74xsag7v--
