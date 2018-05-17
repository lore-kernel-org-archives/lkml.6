Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeEQNiK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:38:10 -0400
Received: from sauhun.de ([88.99.104.3]:51290 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbeEQNiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:38:09 -0400
Date: Thu, 17 May 2018 15:38:07 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>,
        "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] i2c: core-smbus: fix a potential missing-check bug
Message-ID: <20180517133807.dmlf7rlpavmls6cg@ninjato>
References: <1525525341-10046-1-git-send-email-wang6495@umn.edu>
 <20180510111658.sxf3mvye5q6ihxa7@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vvt4nisdeyjjnky4"
Content-Disposition: inline
In-Reply-To: <20180510111658.sxf3mvye5q6ihxa7@ninjato>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vvt4nisdeyjjnky4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 10, 2018 at 01:16:59PM +0200, Wolfram Sang wrote:
> On Sat, May 05, 2018 at 08:02:21AM -0500, Wenwen Wang wrote:
> > In i2c_smbus_xfer_emulated(), the function i2c_transfer() is invoked to
> > transfer i2c messages. The number of actual transferred messages is
> > returned and saved to 'status'. If 'status' is negative, that means an
> > error occurred during the transfer process. In that case, the value of
> > 'status' is an error code to indicate the reason of the transfer failur=
e.
> > In most cases, i2c_transfer() can transfer 'num' messages with no error.
> > And so 'status' =3D=3D 'num'. However, due to unexpected errors, it is =
probable
> > that only partial messages are transferred by i2c_transfer(). As a resu=
lt,
> > 'status' !=3D 'num'. This special case is not checked after the invocat=
ion of
> > i2c_transfer() and can potentially lead to unexpected issues in the
> > following execution since it is expected that 'status' =3D=3D 'num'.
> >=20
> > This patch checks the return value of i2c_transfer() and returns an err=
or
> > code -EIO if the number of actual transferred messages 'status' is not
> > equal to 'num'.
> >=20
> > Signed-off-by: Wenwen Wang <wang6495@umn.edu>
>=20
> Applied to for-current, thanks!

Reconsidered and applied to for-next, thanks!


--vvt4nisdeyjjnky4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlr9hboACgkQFA3kzBSg
KbYi4g/9GkQOcONR0sLn2iA40fe80fR0lb8WO6fQD4LSskofEiVyuRNgOHzNPg8R
DnAbinrpUjuq1GWFlNZyivbiTQFs7ku9oMbt0XcJ0ZmxvgHNJmAUObj+WpkW2mJ+
oCeJbRKdG3uVuvBtuULe7gbRKwIgdVVWt2hxnXX6X56i/8qZGpJo9v7J0zD/JsRd
zfjBpn0mndG3Mpw/lEOnhnteUduG30h4OtlBTqwTqzaIxfIFBY2ja1P78dbfSotX
sju3EC71m4qmqQoKn9vtquk5QLyCFDXYNDSg46DJ3chfWKges/Ip7iFA5j2BiSAC
Em4uOW4yBBF/0OXcdg5w3dSsmdCdkhVRJOsCXsMYmh5cQS1zDasUWRD+/kZX/ve7
AphPlCOWW6G6OcY5ACaeCzMXcTnEEi1MIaWlOyWa7xnAq+fSdYWESGivQZzF3FYd
F9AZMF+/gg3URbY59NLxXbdXPhZb41OjjRLnt3OOW0FuAWLSUqyeYPIK81rlNfny
n+4igX4ikdq7AgpIoq6NgXRfMYP6RFMgg5idg/bGcb0sp8z/ya1eYIJbblLGLnr6
xzkUtbBYxysLgVUxTcTWJPDOntcTY8G8i+KlS/RjWuJ5yHZBDmYumzP0J5qmjCS/
D70rCqy7rok88MuORmVhaS3UcMRENGK5A5pkwHlATsRNhzuSZzk=
=fN6z
-----END PGP SIGNATURE-----

--vvt4nisdeyjjnky4--
