Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbeBZUGn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 15:06:43 -0500
Received: from sauhun.de ([88.99.104.3]:38347 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750762AbeBZUGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 15:06:41 -0500
Date: Mon, 26 Feb 2018 21:06:39 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Colin King <colin.king@canonical.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c-stm32f4: remove redundant initialization of pointer
 reg
Message-ID: <20180226200639.tfll2y4efepm2sos@ninjato>
References: <20180116174404.19464-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gaftrawcsqg2fuwf"
Content-Disposition: inline
In-Reply-To: <20180116174404.19464-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gaftrawcsqg2fuwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 05:44:04PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The pointer reg is assigned a value that is never read, it is later
> overwritten with a new value, hence the redundant initialization can
> be removed.
>=20
> Cleans up clang warning:
> drivers/i2c/busses/i2c-stm32f4.c:352:16: warning: Value stored to 'reg'
> during its initialization is never read
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Maxime? Alexandre? Are you OK with this patch?

> ---
>  drivers/i2c/busses/i2c-stm32f4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-st=
m32f4.c
> index 47c8d00de53f..ba600d77a3f8 100644
> --- a/drivers/i2c/busses/i2c-stm32f4.c
> +++ b/drivers/i2c/busses/i2c-stm32f4.c
> @@ -349,7 +349,7 @@ static void stm32f4_i2c_read_msg(struct stm32f4_i2c_d=
ev *i2c_dev)
>  static void stm32f4_i2c_terminate_xfer(struct stm32f4_i2c_dev *i2c_dev)
>  {
>  	struct stm32f4_i2c_msg *msg =3D &i2c_dev->msg;
> -	void __iomem *reg =3D i2c_dev->base + STM32F4_I2C_CR2;
> +	void __iomem *reg;
> =20
>  	stm32f4_i2c_disable_irq(i2c_dev);
> =20
> --=20
> 2.15.1
>=20

--gaftrawcsqg2fuwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqUaM8ACgkQFA3kzBSg
KbY3Jw//QM2G4a6D4QNOxRGDhRKPIh9hajC5jWNaWm+Kf0UdcCVQsO2QMWE2A1AM
N1rVUqoVXXnI9pxXfylMIER68eNwuZ/LskzJqKhv5DRjIZS5ctYGWt20e/GzslWB
Ox2gchqdtgVsEWglDKE4/eEAurUD7QHUfrl4RjSjGUJLCwYiUzEz7BNik20iFcDQ
XxadpIWmtt+rp9wCwVKucX6mYV3uIi/VpPVpjuU0tThGx27M3/IRh+FklGX5sKBd
pNoIGyrJggnC+1hnz8eXdbH2kQpmu3oLxNnjc2K0kR1P3PeR4njw0ESLs/WUmsib
qfLWhYRapUdgFs8NLjYtxHJ7T6aZwRM7bMSD+FOX7NrnxelwR+YA37a4qZJqxgyf
MvwLaTTJUJbquOgPG+xLEO5AyAcneJGb8cflSZw6WccmoC76xYX4Alxsr5YFeguJ
UA28r2/UR/Vch3ve/JWiazfQLGpKX4b3qxyMF3bQaJPPdxQ1LraMSI8ZcmIedIiJ
NJm8aewhUQNCIFUzhKgnmrnBjY6p/NmpoboZTkiNNfCOBzBee+8M7kyxuilzmUbr
qJFoMlr2LlCvET0/3NyOjbhxX5r0sD0+onjcm8r0MuMYBxdzw7YJ3bLVI7eJNyzM
bTZz6sJshSqlhkGc3sfC8MNpZwH9SlrVIDO0pivViimnI9V9pRg=
=7mwh
-----END PGP SIGNATURE-----

--gaftrawcsqg2fuwf--
