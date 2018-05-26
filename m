Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031662AbeEZKCr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 06:02:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39874 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031487AbeEZKCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 06:02:46 -0400
Date: Sat, 26 May 2018 11:02:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 10/19 v3] regulator: s2mps11: Pass descriptor instead of
 GPIO number
Message-ID: <20180526100243.GA1564@sirena.org.uk>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
 <20180514080640.12515-11-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20180514080640.12515-11-linus.walleij@linaro.org>
X-Cookie: Adapt.  Enjoy.  Survive.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 10:06:31AM +0200, Linus Walleij wrote:
> Instead of passing a global GPIO number for the enable GPIO, pass
> a descriptor looked up with the standard devm_gpiod_get_optional()
> call.
>=20
> This regulator supports passing platform data, but enable/sleep
> regulators are looked up from the device tree exclusively, so
> we can need not touch other files.

This seems to have broken the boot on Odroid XU3 so I'm going to revert
it:

https://storage.kernelci.org/next/master/v4.17-rc6-9523-g47b9cef0672d/arm/m=
ulti_v7_defconfig/lab-baylibre-seattle/boot-exynos5422-odroidxu3.html

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsJMMIACgkQJNaLcl1U
h9ArKQf/aW630c4kG7yzTjeA537pwxTsJwzggWNWOH8FWhKSvPsTU2uLLvhzOZdb
rv3Q0KhCFVE0Py21hEhUiHub9yyiyDR6iD8slmM1kyM12WZr7uUg40P0FIfQ3Swz
sBHGULbV4qngAyKlLsBVHh6sC9wbN8QvfBagGS4IaK2yMuIRmj8uISUZkBTLRyuX
eco2nwpu59onV+Cw9We3PBGVe76hZwqplPgRD0w9qdDobRoUdvrRZpX4XbCpTMDE
NfjbfL7rYSfx6jVTZt/g6Y68IrNg/2ej3Hxm2bBDJ9Gvr9oVQ6cmFQb5rOp3ali2
Kp24C9j6XF4mWStc785KrUfgWQEAqw==
=pjAA
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
