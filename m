Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeDILgQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:36:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45740 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750759AbeDILgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:36:14 -0400
Date: Mon, 9 Apr 2018 13:36:03 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
Message-ID: <20180409113603.2iexkqvyeqmysp5e@flea>
References: <20180405091913.ky4dnmszoobn2xry@flea>
 <ee4adb1e-caf6-32f6-33d6-d8dd94d232cf@orpaltech.com>
 <20180405131735.GB12349@sirena.org.uk>
 <8159c3a5-af74-9f13-aedb-7ecc708bdff6@orpaltech.com>
 <20180406073441.xesojvzc3deljhoy@flea>
 <204e97cb-2f39-00f0-fd4e-3aa9a51f7cac@orpaltech.com>
 <20180409092730.2moyhl5aaktjwbyn@flea>
 <94a394bd-89bf-9334-c500-4cbadf4c1044@orpaltech.com>
 <20180409105001.GC11532@sirena.org.uk>
 <67c2006b-17f2-2459-e3c9-e91e3c694d8c@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c7ddtt4fgfml6w7z"
Content-Disposition: inline
In-Reply-To: <67c2006b-17f2-2459-e3c9-e91e3c694d8c@orpaltech.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c7ddtt4fgfml6w7z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 02:10:40PM +0300, Sergey Suloev wrote:
> On 04/09/2018 01:50 PM, Mark Brown wrote:
> > On Mon, Apr 09, 2018 at 01:26:23PM +0300, Sergey Suloev wrote:
> > > On 04/09/2018 12:27 PM, Maxime Ripard wrote:
> > > > On Fri, Apr 06, 2018 at 06:48:23PM +0300, Sergey Suloev wrote:
> > > > > On 04/06/2018 10:34 AM, Maxime Ripard wrote:
> > > > > According to what you said the driver must implement
> > > > > "transfer_one_message" instead of "transfer_one"
> > > > I'm not sure what makes you think that I said that.
> > > Because current implementation tries to send more than FIFO-depth of =
data in
> > > a single call to "transfer_one" which is wrong.
> > No, that's absolutely not the case.  All any of these functions has to
> > do is transfer whatever they were asked to, how they do it is not at all
> > important to the framework.
>=20
> I think you don't fully understand the issue. Let's talk about sun4i and=
=A0
> sun6i SPI=A0 drivers separately.
>=20
> sun4i
>=20
> 1)it is correctly declaring max_transfer_size=3DFIFO depth for PIO mode=
=A0 but
> transfer_one() function doesn't follow the declaration allowing PIO
> transfers longer than FIFO depth=A0 by just refilling FIFO using 3/4 FIFO
> empty interrupt. I can definitely state here that long transfers WON'T WO=
RK
> on real hardware.

Surely the original author of the patch allowing to do just that
disagrees with you. And it's not about the hardware itself, it's about
how the driver operates as well.

> I tested it and that's why I can say that.

Then it must be fixed, and not silently reverted.

> But as soon as sun4i SPI driver=A0 is correctly declaring
> max_transfer_size then "smart" clients will work well by limiting a
> single transfer size to FIFO depth. I tested it with real hardware,
> again.

This is really not my point. What would prevent you from doing
multiple transfers in that case, and filling the FIFO entirely,
waiting for it to be done, then resuming until you have sent the right
number of bytes?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--c7ddtt4fgfml6w7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrLUCIACgkQ0rTAlCFN
r3QlohAAmO131yUSwi9hkobfB8OoLlbWtoOp7Lb6szGcm+EKP9CnxnAlRAQuwyC3
9Elfpd9SxVyHw484Das9er0viPndDdz2LJANLiq4q2d7G/Ii2xqtroS6BpmtG480
Jcz8Wpy7fPeaLFMGxyJTzOVKrz8Xmz3fHcVpyDWhU0jtPiHU1uCAn1meUMLWyxse
djJ16DRqeXgGiypfjlTwDba/ml8Y45gM4lV1UT/bdLQJvEGKL4V9NaDeYdeMRnyt
xyeQbKrHc5kLVNPrsOoCteRRS9xQnmWI/gCy/Hi1nWnCkt0Uidv/JgYU1tGChpOV
iLF90KMc9RvzpCwC0lNxUOsdEO4mAPzMJEMjP9ciX7dYuXPfwo5S3QZN0GpQHDVN
pgjGLE8IHth/kI4k8FNCQLnhwqRYGoUlOGC3YJfZXddyJpRAFl6L4fHx676EjEh7
VyyraolTNq6+c9pQhZZQJA7nHqVl12VhhuuOUdD5sMEqWmXuBaweAWHNyUEQFRgs
xOnKITVTVgyXyM0y79qtb3idvRBi2xpKFyiprJes7C+vpisYidgRxJ6Oh1GWJu52
RZaAwnymTFewXTY8/DDRdGiiRblaRK6mYO2mFIt2LZrHhbIUJCxV2V60fLrqR3Po
wJjC7pDoitgT2cKbF0T5ttgYk+E6UL5vdMADfabKBH75ldKQwts=
=hFQP
-----END PGP SIGNATURE-----

--c7ddtt4fgfml6w7z--
