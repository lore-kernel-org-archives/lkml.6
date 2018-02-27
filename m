Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeB0JEU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:04:20 -0500
Received: from www.zeus03.de ([194.117.254.33]:42490 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752330AbeB0JER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:04:17 -0500
Date: Tue, 27 Feb 2018 10:04:16 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: George Cherian <gcherian@caviumnetworks.com>
Cc: George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 4/4] i2c: xlp9xx: Check for Bus state after every transfer
Message-ID: <20180227090416.gxgof6fyzdeshtmf@katana>
References: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
 <1516253964-4615-4-git-send-email-george.cherian@cavium.com>
 <20180226202248.ej3bt5o7sam6qljv@ninjato>
 <a96c4bb2-fbc5-3e21-f6b5-4da75fac3c01@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="62qsndw2bhkctbqb"
Content-Disposition: inline
In-Reply-To: <a96c4bb2-fbc5-3e21-f6b5-4da75fac3c01@caviumnetworks.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--62qsndw2bhkctbqb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2018 at 10:30:31AM +0530, George Cherian wrote:
> Hi Wolfram,
>=20
> Thanks for the review.
>=20
> On 02/27/2018 01:52 AM, Wolfram Sang wrote:
> >=20
> > On Thu, Jan 18, 2018 at 05:39:24AM +0000, George Cherian wrote:
> > > I2C bus enters the STOP condition after the DATA_DONE interrupt is ra=
ised.
> > > Essentially the driver should be checking the bus state before sending
> > > the next transaction.
> >=20
> > Yes.
> >=20
> > > In case the next transaction is initiated while the
> > > bus is busy, the prior transactions stop condition is not achieved.
> >=20
> > I didn't fully get why you can't check the BUSY bit and wait a little
> > just before you push out the next message?
> Yes, I am checking for the BUSY bit and looping.

Yes, but *after* the STOP, not *before* the next message. I haven't
fully understood why you don't do this before the next message is about
to be sent. That might save you some busy looping, or?


--62qsndw2bhkctbqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqVHw8ACgkQFA3kzBSg
KbZEog//QeyPOdwl0exgfBrWmyynZjc4DbREIDnMQzcQmOTUuWAB3zRdg/pKIXM8
HwJAE4C8yvj7De3PjYiG3Wz0LLTtyZv8SdqYMv+vVKn63yJjotgL1K8DagBJQDg/
EtQfk3Jq7ZsHb8JT8CUe5LPWTm/W80IBUWf4t0xdSsCtO6GsAwWnY/c2Cd1YUjtt
x98Uet3ilkF6jDlb/Kp4307NFZmAzWMJujGhG5ivPcI9H53lQffHxu1GU/BXw/sA
EdqlN9KKTwqDmTTtWZq5amTgoE2E+XoyeLwhXhWnasKYw/Fx7bzRjKuWUEPeCvqN
UW4nRVIo2e0TdJDex6sG1kS+5QYt1VjqDJEH65sckE7gHmyCKLF2yqZcyIjHqLqY
88cHlwroxNszpN7JPEYMjdXK5fBuv5Efd7NJVT3hlvtTpKICwtX66fy2zRmGFK3F
cJ00MvfdfeWrzapZEymuhD6rBlw4eVIB2TCn7uqhPmAk9i7sRTS2bhBEAiH/7Bpu
Ksd4Y7jMqMRxdqpfmz80Y68uMkaVRnb4RzeIPCMegTO4GyP188pbLKnitv9L8kEr
whWNXbtcQFHskg+/SlgkiRciSRa6OKe37NuRsIA54Cwf4Z2qJ3tg6NkqoFEEFYni
jVvup3G9TE64fnrzdwzg1kjZNKnQRwpHk3PPEPrKnQWqkmyDi3U=
=SFGK
-----END PGP SIGNATURE-----

--62qsndw2bhkctbqb--
