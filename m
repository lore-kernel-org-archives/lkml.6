Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751238AbeEaVXM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:23:12 -0400
Received: from sauhun.de ([88.99.104.3]:44330 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750762AbeEaVXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:23:10 -0400
Date: Thu, 31 May 2018 23:23:07 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Abhishek Sahu <absahu@codeaurora.org>,
        Austin Christ <austinwc@codeaurora.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Bhumika Goyal <bhumirks@gmail.com>, Peter Rosin <peda@axentia.se>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: qup: fix building without CONFIG_ACPI
Message-ID: <20180531212306.zyb2m5hrgkgbuyws@ninjato>
References: <20180530213201.550467-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dkp34kldra22lzdz"
Content-Disposition: inline
In-Reply-To: <20180530213201.550467-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dkp34kldra22lzdz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 30, 2018 at 11:31:49PM +0200, Arnd Bergmann wrote:
> The added Centriq support broke compilation with CONFIG_ACPI disabled:
>=20
> drivers/i2c/busses/i2c-qup.c: In function 'qup_i2c_probe':
> drivers/i2c/busses/i2c-qup.c:1707:25: error: 'qup_i2c_acpi_match' undecla=
red (first use in this function); did you mean 'qup_i2c_recv_data'?
>=20
> This fixes it by removing the extraneous #ifdef. All ACPI specific
> code will be dropped implicitly when that option is disabled, but
> the compiler first needs to see it.
>=20
> Fixes: 902a91a02bdf ("i2c: qup: add probe path for Centriq ACPI devices")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to for-next, thanks!


--dkp34kldra22lzdz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsQZ7YACgkQFA3kzBSg
KbaCLQ/+MRDaCXRbS13cQFIV8ZVlgba5BDD6yTDPXDgVKJemW/LfXWzZiSLhnE/k
YDM4rI7zHURovl0SW5amgRsRqMAGI5llA5pmW82sB8dDpqk6WMlXdg91HL/4ickZ
Zc9ZmA+b/QSEEgHD7jm2jCe1AqN0HyUe+y+TrClBJAu/QvGaHL2VCxV0+kkbVwP6
zHj7Yt4Q8Cbkj74CZ/KOOgQNEgW2CZt8qcdb01n4zJE0pN7rWoulzDpzT0w5ogI9
nKFt4biK7XIi6R/WjXPJy9gksahAlqGRmCCOaOjwbkYJXMUZ+NZqXiA3pnrV3Sql
KfeWaTUdbAngH9UdQRKz7BzRtoELZ+YAEqJa1TIC6QagknABaYciNQ3CBwz/oZvf
U9NTGHW41FLYEv85WE759qb+u459QHvr3QeR7FdNCchkJfmp/cUO4tdTR1uJ8IH9
v1zi9yMuJOdcH3pC2j6UuwT86Pq4IJdnoFpd4/0a9u0tQzgwXNLtMASbdS0cXKXx
oPNrIb1eGB6XlY0p58S4qc3j1CfLhoyZVlSkjLvDouuGJox7MpaEqqOCAONA5ZgA
7uKaOVhUFxrwGdS5mr2vXbcqAaRxddPC/Z8qDrd1X38TcGPbedm/tT0vMMd+nstC
bhgko3Q200xcjjE3rHLtbFNS/UEodI7+hfjrGn6KYtoZltgfpDw=
=bVws
-----END PGP SIGNATURE-----

--dkp34kldra22lzdz--
