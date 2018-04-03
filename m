Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755422AbeDCLkJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 07:40:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45508 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755319AbeDCLkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 07:40:08 -0400
Date: Tue, 3 Apr 2018 13:40:06 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] spi: sun4i: restrict transfer length in PIO-mode
Message-ID: <20180403114006.u7tz2c7lvofsqwtg@flea>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
 <20180329185907.27281-3-ssuloev@orpaltech.com>
 <20180403081041.3ully6bcyfwx2cx6@flea>
 <4390604e-092b-a89d-3581-b57ee9cbb6a1@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aoxpu3mstcyx6fsw"
Content-Disposition: inline
In-Reply-To: <4390604e-092b-a89d-3581-b57ee9cbb6a1@orpaltech.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aoxpu3mstcyx6fsw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 02:08:43PM +0300, Sergey Suloev wrote:
> On 04/03/2018 11:10 AM, Maxime Ripard wrote:
> > On Thu, Mar 29, 2018 at 09:59:03PM +0300, Sergey Suloev wrote:
> > > There is no need to handle 3/4 empty/full interrupts as the maximum
> > > supported transfer length in PIO mode is 64 bytes for sun4i-family
> > > SoCs.
> > That assumes that you'll be able to treat the FIFO full interrupt and
> > drain the FIFO before we have the next byte coming in. This would
> > require a real time system, and we're not in one of them.
>
> AFAIK in SPI protocol we send and receive at the same time.

It depends. The protocol allows it yes, but most devices I've seen can
only operate in half duplex. But it's not really the point.

> As soon as the transfer length is <=3D FIFO depth then it means that
> at the moment we get TC interrupt all data for this transfer
> sent/received already.
>=20
> Is your point here that draining FIFO might be a long operation and we can
> lose next portion of data ?

My point is that, if you get another interrupt(s) right before the
FIFO full interrupt, that interrupt is going to be masked for as long
as it is needed for the previous handler(s) to execute.

If you're having another byte received while the interrupt is masked,
you're losing data.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--aoxpu3mstcyx6fsw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrDaBUACgkQ0rTAlCFN
r3Qhhg/zB/QTUMcmQXwQBQgieWORjF9cUR+JElpDGfLaFLqguHcEU0f0GumhjiRx
BfI1lrebeYs3zdlD8cXpr0kpDLtCpejykddxSaVXp8f6A17/MMSPCc3cxlpBDYxe
L8sjak63UAP79YDcaf3F9dfdoKYkTx9uMgLiSZIMUiPzF9MHcaW79NuH/xgWUvvX
WMjfkZlNz83YY0xtGj/uzP1t2kuxjqaZwBFfzkCdMg8E/QqzURyD6HVbVJBTgrvU
OOsHzM2CvOgnEBAyM+E6VvYlyLDawJiGn6IaLf/5UEGlLL+5VJvRi7axQO5B7ApZ
LupONp8VOWnhBjKTNinuMfGHaOdlq8pf9xH3jOYp9dZ6M3sQUuivJEqzGaus0HP7
j4yaF6LYpbsasJNs7ZjhztKnzXs0hgvC6VO/Rzy1jVJd6N5/7NOLjw53SWdfj1Hh
AB6ig7ap/5JmROs1r4zetqBP3PdG536ADN8ckTbfb1nCcPV3QMAFzz87UrkKAWQO
/EZQTqrTEOATtVAegc89H5LJiK/b9QXhu9wIp2HphPg5pwxhM1mFSNocEgXMUJyr
iCjkolIAKjZ7K77s2KpfarRwSoag4Qpb1qhBFyHkDRZgB93OygBFY/anvgvDEMoy
yB3UBTyKvpfmkdaviqqqY3kaJK7/dOTroqT5AhoeoEYoZYBfIw==
=pVt6
-----END PGP SIGNATURE-----

--aoxpu3mstcyx6fsw--
