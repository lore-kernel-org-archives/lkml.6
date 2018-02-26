Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeBZUW5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 15:22:57 -0500
Received: from sauhun.de ([88.99.104.3]:38408 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752065AbeBZUWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 15:22:50 -0500
Date: Mon, 26 Feb 2018 21:22:48 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: George Cherian <george.cherian@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 4/4] i2c: xlp9xx: Check for Bus state after every transfer
Message-ID: <20180226202248.ej3bt5o7sam6qljv@ninjato>
References: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
 <1516253964-4615-4-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="so6pugmormqou3ys"
Content-Disposition: inline
In-Reply-To: <1516253964-4615-4-git-send-email-george.cherian@cavium.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--so6pugmormqou3ys
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Thu, Jan 18, 2018 at 05:39:24AM +0000, George Cherian wrote:
> I2C bus enters the STOP condition after the DATA_DONE interrupt is raised.
> Essentially the driver should be checking the bus state before sending
> the next transaction.

Yes.

> In case the next transaction is initiated while the
> bus is busy, the prior transactions stop condition is not acheived.

I didn't fully get why you can't check the BUSY bit and wait a little
just before you push out the next message?

> Add the check to make sure the bus is not busy before next transaction.
>=20

--so6pugmormqou3ys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqUbJgACgkQFA3kzBSg
KbbGNQ//WU7ImxeMl2MyWb8KEoDuAo2ntOwhbgLbjqs6SiaVmYywdprday3YZ1+d
vD+qu3eNGpxz4SCOgdbyFaJBFJ5xUUTdouDq6N2qB/nYITnlxfNERBQ6wYd/G/qE
tRMIrztqboUMDwUHWndf55INrVtKkMuN5z3VuO5LYltlCv/PkgnHqp6ZIy1SavdZ
2XJjib4ONXDEEsSM8ZKChZ6wA3RP3z/CwrS04HMFWHvxhdQmTfiE7Y/HsMVGZoJf
vORRGA1+Hv004e5g+yB2QdU3ilZJm4TPTTmLkkvLJS8UKu9dzPW4DPxbbo0F9k6l
VnECUI46eNTPz8EH91K+mZU9mrSSYCurxSpnCeF1WIbEI5K1mprRq4TFMD7AsPoZ
Wn2boV2nBYsRmwsEcziN50Kq2MBFYIjwfGS3pPN5AUMuV1hCErtLQndpW5i+5gSg
wfpCPgFjuI6LFhd0CxLOWCDLjmVhX+vgtgCNGiJ71b7RsRM3esKV0ZS3R9it3QPQ
RFOnAvNZ5s1cv1iDJm0EekXaTGvTDhMlH8JA7NLFbRaA5CFKz0mbOD7GR/tGSqFy
hkzISqaYCro/KqEAlIDnnc/2lvQmTLv9s7hBA3nK9SHz9fKrRAH+DrIRelunYo+M
J38YvmqcH7ke8i7B0KwtfF3Lz5cQrXNiLasockIvqIIsoppIGyc=
=G9ND
-----END PGP SIGNATURE-----

--so6pugmormqou3ys--
