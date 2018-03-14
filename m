Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeCNMKL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:10:11 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54845 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeCNMKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:10:08 -0400
X-Google-Smtp-Source: AG47ELsC+Dmm2iyaC0pIoLvG9MLiDfT8OCLrVBkZ58U2ijuTIWu4q69YOQXvyk+kCenhb8Kld9qvOw==
Date: Wed, 14 Mar 2018 13:10:05 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Cc: linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] i2c: tegra: Fix PM device usage count
Message-ID: <20180314121005.GD8564@ulmo>
References: <20180224224423.hz36gpxnlpex2cqx@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
Content-Disposition: inline
In-Reply-To: <20180224224423.hz36gpxnlpex2cqx@agrajag.zerfleddert.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2018 at 11:44:23PM +0100, Tobias Jordan wrote:
> pm_runtime_get_sync() increases the device's usage count even when
> reporting an error, so add a call to pm_runtime_put_noidle() in the
> related error branches.
>=20
> Fixes: 1f50ad2c86cd ("i2c: tegra: Add runtime power-management support")
> Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
> ---
> This is one of a number of patches for problems found using coccinelle=20
> scripting in the SIL2LinuxMP project. The patch has been compile-tested;
> it's based on linux-next-20180223.
>=20
> For a discussion of the corresponding issue, see
> https://marc.info/?l=3Dlinux-pm&m=3D151904483924999&w=3D2
>=20
>  drivers/i2c/busses/i2c-tegra.c | 2 ++
>  1 file changed, 2 insertions(+)

This seems okay to me, though given the discussion it might be
preferable to just ignore errors rather than fail.

Acked-by: Thierry Reding <treding@nvidia.com>

--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqpERoACgkQ3SOs138+
s6GwLg/8C43j62gUc666BaZPllQ7dl9eSO2C0d3rhaOg2cwdhdPFaVAftH53/emV
VmnD2byfZkeHiDdCqtYBAAGm60rbSKKih0ZAGxHhatK4VO4C2yR+YBAIPg7UdQ7C
3fnM+dkMkjjQ4GyrV951VOjj0D3R7IeoWYv2kjRi6prj17UktwKKAj0B/rTFYEvR
fDsW6kTJ6QFQtcfTsRYeMbQ3ZQihOb4s0oTo6EFwayl0BOn7M6MVjEKl3D0rxZfX
0K+KgZdOzgOP34SXgOBLKFydotjcUI+U2PDVEkknhKRS/J8fw9gaeB4qnS2H0Lrn
GU7DbGF4jVSx6PSI+aP0yDiOpZkq9RGe1XFE0Y97TOVf826iMRqGLB1ayJvJqPKz
LqsDfJkMIPp43vCyYs0xMzjmAk+zPlFPciX+w3NqID8W3Kgq9c34cBKPp5SIwone
j5IMxgx7GaN0t5kuYngdQ+eV0xvNR705bMcXFhXMBGIKI8ArUVj5r2RBmFmBJteK
h3R6LDrjXzpSHp2neQzP/UCbSb0mFozGZFqmIW3AmOgbPckhs3kNv19y63gILENp
tuFI24MURUXSrj+Q4tl42UyKvnZ1ve0Sp0tCLA2fLAsvTB3sWx22ZUqN4fOjyVDC
Q7vaeCl7sly0Y9WxFzQo4bRRW4eOiKsZmaowzzAFNbAOwXAvdOE=
=/vO1
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--
