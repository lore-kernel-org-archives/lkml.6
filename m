Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeCEPvO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:51:14 -0500
Received: from sauhun.de ([88.99.104.3]:40109 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751144AbeCEPvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:51:13 -0500
Date: Mon, 5 Mar 2018 16:51:11 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Cc: Adrian Fiergolski <adrian.fiergolski@cern.ch>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] i2c: add i2c_get_device_id() to get the standard
 i2c device id
Message-ID: <20180305155111.ihlt4hn4yz3igo3z@ninjato>
References: <20180122113657.32094-1-peda@axentia.se>
 <20180122113657.32094-2-peda@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="76qguvvlfacja55i"
Content-Disposition: inline
In-Reply-To: <20180122113657.32094-2-peda@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--76qguvvlfacja55i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2018 at 12:36:56PM +0100, Peter Rosin wrote:
> Can be used during probe to double check that the probed device is
> what is expected.
>=20
> Loosely based on code from Adrian Fiergolski <adrian.fiergolski@cern.ch>.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

In general, nice! I wanted to have such a function in the core but never
had a device to test it with. So, much appreciated.

Looks mostly good, except...

> +	ret =3D i2c_smbus_xfer(adap, I2C_ADDR_DEVICE_ID, client->flags,

We shouldn't pass the flag of the clients (like PEC) here. I'd think it
could be plain 0 but please double-check.

> +/**
> + * struct i2c_device_identity - i2c client device identification
> + * @manufacturer_id: 0 - 4095, database maintained by NXP
> + * @part_id: 0 - 511, according to manufacturer
> + * @die_revision: 0 - 7, according to manufacturer
> + */

All is nicely documented, very good!

About the upstreaming procedure: Could you just make a seperate
pull-request out of this feature? I'll pull that in to have it in my
tree and you can still collect patches in your usual for-next branch.

When the above is fixed you can add my:

Reviewed-by: Wolfram Sang <wsa@the-dreams.de>


--76qguvvlfacja55i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqdZ28ACgkQFA3kzBSg
KbYp5hAAiiDMCn08MkxFAFb8OR9MNmjNtCJM1vH3kH0rDLf/+wGL/hUk1VQ5rnHY
b1bJA7qTHwT6j/1eVcOdKuGPrNf7KFXdjFWdEmHfv58cC2cRDO3pvG118C0Wlpkx
/0viYHI3HHnApd0xNto7zCcpsTZZbwJ1v5F3yIyh3QGJpzj7f9gXhTnKQV4GGpxG
fv19daq3UYQdpiZYxLR6vGKdEEuVNhbR2byL4BB71uu1FmYpa7aE3gthZ3pPpJcd
kNAcP59i//USpjylLgwRCAW3gAwJKPc3vl+8y8khk51w9ibg4cZ0+d5fNFo6b4lj
+SLxbvFZSpFO6A9nXg/At1L9PxTRfIGCU8MoAxK/HSTEU/rrDesaW33NaqKnaYo9
jyMQ2y5BQj/FtrkFcQ6DHiiK94tcaeq180Mbcn9lfVRMbaWstacxMDJmhhUVY7Ot
RO6iHmAgVDeGoOIbupW1uKdL739ayePTbaoxiNFmFp+FPYqcxiZQCA8x9XKro/GL
yI2wyGD6Zmq/vaTQ9/zgPkiqubLPyRZvWPWlP9Savuwn1d1sVfyC+WW5oYyRtzgQ
yMNn24/E9Zb4T8O1/mdY+X8iMsTLMxEkdoojQ9V8TabLOeKsmay/W8fPaHJlAoY/
rtlKOJcgM0uJNkWRH/8vbzmybGoDLjv5tnOmODquSLg4JAfheYU=
=hWtI
-----END PGP SIGNATURE-----

--76qguvvlfacja55i--
