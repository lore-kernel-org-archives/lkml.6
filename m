Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeDPQSt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:18:49 -0400
Received: from sauhun.de ([88.99.104.3]:49266 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbeDPQSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:18:48 -0400
Date: Mon, 16 Apr 2018 18:18:45 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Cc: Nicholas Mc Guire <der.herr@hofr.at>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [SIL2review] [PATCH] i2c: img-scb: fix PM device usage count
Message-ID: <20180416161845.hxizpjituo6mpvbm@ninjato>
References: <20180224224303.3mpwhal2axcr6aos@agrajag.zerfleddert.de>
 <20180225132014.GA8844@osadl.at>
 <20180225172730.2b443978@denkmatte>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oa5a7cavjqb53muk"
Content-Disposition: inline
In-Reply-To: <20180225172730.2b443978@denkmatte>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oa5a7cavjqb53muk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> As far as I've understood the idea is that most "error" return values
> actually are a result of disabled runtime PM, and that should be
> transparent to the caller. Looking at the code, that's what the vast
> majority of callers do - they just ignore the return value of
> pm_runtime_get_sync, and somewhere later have an
> unconditional pm_runtime_put_... call.
>=20
> So the only issue are callers that don't ignore the pm_runtime_get_sync
> return value, probably because they're having some kind of special
> requirements for error handling. For those, they need to ensure that a
> proper _put_ is done somewhere in the error path.

Is it easily recognizable if the drivers check the error code because
there is a reason or if they do it "out of habit"? For the latter, I
agree that the better fix would be to remove the error check altogether.
Otherwise the code becomes more complex for no reason and even less
people are then brave enough to simplify it later.


--oa5a7cavjqb53muk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrUzOUACgkQFA3kzBSg
KbZZQg//ViwCEDxliCtxLvHWNN1uGRydGEKWymuZTgzvED+kjbWXFWJA1swsaRHZ
zPTPHYg3FnPQLCVfhj+PMoNbHX8PZYc6zo+vtS6mfIEtq4OyLkQmW78wtyeW1uOL
n5SUfqWh6havgHoa6+E16M2dzrQXTz4Th4IzBid2IDbcp61rvq39SEhZmybxiA7A
D6SqG7g+Jo5IwD9S4sa3QXDfeHPvja6Ld3Z2nc0KUlyRPW7m6ds+OQpYklWbhnIC
HilN+Sk6AbPSbVuBfXxLV4xaKBVTLmm7kniUHJAEScfOZsPbX8LXYvv/yaFalbJP
VnRB/Uapfc3DqSZ2dBOXSsgFBGxPmTsrgN3oerVVx/yh4VCeVR2TKt1XxRmlRQ0m
ldGcxE+8FaW9UQRP4PkHD3tekiUiJGQRbhEPULpkLtjswck5TetXE3lvIB6RTvxc
btUtQTCv3/NmDVzORYFGKpWSP9MM3MYuN/mkkW4e3g3zr3nB4zMi/41ZXxeJFxPr
nmN3/JTKM7GaAnEHnESLb/1/pViOTMqjF38RXXFy9QqiufpE3hri2EwC+zruXDLv
kDsCvkhRMa0f4ABRbmh2jAg40p1zIacK1NvUKTgzhVYpU1Gbyfpp5Ym1Xl1hrLyq
uQsF0+iBQ+Yl7y6rpycKzba45CIwHKd5LywzxvxU+2MHa3DDpCg=
=SvGp
-----END PGP SIGNATURE-----

--oa5a7cavjqb53muk--
