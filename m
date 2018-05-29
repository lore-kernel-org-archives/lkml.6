Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937004AbeE2SHE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:07:04 -0400
Received: from sauhun.de ([88.99.104.3]:56874 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936880AbeE2SHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:07:02 -0400
Date: Tue, 29 May 2018 20:06:59 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Shardar Shariff Md <smohammed@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i2c: tegra: Remove suspend-resume
Message-ID: <20180529180659.f5s56nstykztvykr@ninjato>
References: <20180513211347.7187-1-digetx@gmail.com>
 <20180514115933.GH18312@ulmo>
 <d83fc1f7-d5e5-4211-1cd8-babcabdd9c4b@nvidia.com>
 <5949e650-8ab5-b4bb-196d-5a0705383141@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yhskpz7hnuvbrtlc"
Content-Disposition: inline
In-Reply-To: <5949e650-8ab5-b4bb-196d-5a0705383141@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yhskpz7hnuvbrtlc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Our I2C driver is based on the interrupt. So we have converted the
> > suspend/resume to suspend_noirq and reseume_noirq so that we will not a=
llow the
> > transfer when system interrupt disabled in downstream.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SET_NOIRQ_SYSTEM=
_SLEEP_PM_OPS(tegra_i2c_suspend, tegra_i2c_resume)
> >=20
> > In shutdown path, where interrupt disabled and still need i2c, we use t=
he
> > bit-bang method via GPIO for i2c transfer.
> In the current upstream kernel suspend/resume can't be simply moved to the
> 'noirq' stage because resume invokes tegra_i2c_init() which uses runtime =
PM and
> that doesn't work with the IRQ's being disabled. But things do not work e=
ven
> with the tegra_i2c_init() changed to work with the disabled IRQ's, like I=
 wrote
> above the I2C transfer fails (due to timeout) and a "fix" for that failur=
e was
> to remove reset_control_assert/deassert from the tegra_i2c_init(). So I'd=
 go for
> a complete suspend/resume removal for now as it is causes problem.

Laxman, are you convinced or do you have still objections?


--yhskpz7hnuvbrtlc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsNlsMACgkQFA3kzBSg
KbZnxg//b/JEKpMaCPyKEn1ejp1JJJfDrCgpngPA+xDdGprQTefGkNCtFZ8e1xG8
SumlReMYABex7myrnkNl8p7xo5BYpn2/PnSRg3VieneKXJMfsB6IvX4Q0u6+MixO
WeHJwFtDBbhbOligybufr5s03VQ58F0lW16CscBZioHa+epYtWshVbrsyhJ3V4wN
P9LeR9sj7JYQlEvOWa5jhhJREUq2P8Dl2/si17rDzGiYqPi3PO84Dhc5kfT2qhxC
UtSTf7NXxqMe2el9TKgMmWVe//LizZ4+e+JJfKgjuL7UKhxr3Rd8fScCGPp7FEiN
IKZAnnSAhD2/VKJFdWA2JDzH6+nkpNNWfcrfLU4XvHXToC2IXxkYkD2wxaJx0tb9
0+BfU/dxfQCmPTc8A8NnsP+vV0qWrBLGqPeJA+Jv6rEOvDWwe7V57wPZujXVruPA
/BCvjFM5s8uM+gzls15WfgdDzOLEOGKUfIPj0Xf0nWSfTE8MUdPyGBXHq1mBZ/XI
pMmmtJFpPO7Fr/P8drVPm4fNz6tSUgAFYuWtelYlO5PE7l4d75jy20S08zYTzFi7
3W/dREtSIU3TM0TV18e0URJfLyGk/Utzj8IK16bYFZVX7LycCb2pOQgiFF9xozpU
ocr0N2OXZwm91J9T96QtGFs10dF9UYcesXb3xNYvFJpCJWyV7hI=
=luMx
-----END PGP SIGNATURE-----

--yhskpz7hnuvbrtlc--
