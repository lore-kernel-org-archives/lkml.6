Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933229AbeCFTGF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 14:06:05 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:37015 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932313AbeCFTGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 14:06:02 -0500
X-Google-Smtp-Source: AG47ELsnOXI+sY4kcCv4BQfTRL1nTEngOWuizOE7rF2WX9TWJbt5d1GpwT1gNZ7AC0QbvdvVeGd4Tg==
Date: Tue, 6 Mar 2018 11:05:58 -0800
From: Benson Leung <bleung@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>,
        Bhumika Goyal <bhumirks@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "platform/chrome: chromeos_laptop: make
 chromeos_laptop const"
Message-ID: <20180306190558.GA60955@decatoncale.mtv.corp.google.com>
References: <20180306185915.GA93346@dtor-ws>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20180306185915.GA93346@dtor-ws>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 10:59:15AM -0800, Dmitry Torokhov wrote:
> This reverts commit a376cd91606365609d8fbd57247618bd51da1fc6 because
> chromeos_laptop instances should not be marked as "const" (at this
> time), since i2c_peripheral is being modified (we change "state" and
> "tries") when we instantiate devices.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks for the catch, Dmitry.

Applied.

> ---
>  drivers/platform/chrome/chromeos_laptop.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform=
/chrome/chromeos_laptop.c
> index 6dec6ab13300..d8599736a41a 100644
> --- a/drivers/platform/chrome/chromeos_laptop.c
> +++ b/drivers/platform/chrome/chromeos_laptop.c
> @@ -423,7 +423,7 @@ static int chromeos_laptop_probe(struct platform_devi=
ce *pdev)
>  	return ret;
>  }
> =20
> -static const struct chromeos_laptop samsung_series_5_550 =3D {
> +static struct chromeos_laptop samsung_series_5_550 =3D {
>  	.i2c_peripherals =3D {
>  		/* Touchpad. */
>  		{ .add =3D setup_cyapa_tp, I2C_ADAPTER_SMBUS },
> @@ -432,14 +432,14 @@ static const struct chromeos_laptop samsung_series_=
5_550 =3D {
>  	},
>  };
> =20
> -static const struct chromeos_laptop samsung_series_5 =3D {
> +static struct chromeos_laptop samsung_series_5 =3D {
>  	.i2c_peripherals =3D {
>  		/* Light Sensor. */
>  		{ .add =3D setup_tsl2583_als, I2C_ADAPTER_SMBUS },
>  	},
>  };
> =20
> -static const struct chromeos_laptop chromebook_pixel =3D {
> +static struct chromeos_laptop chromebook_pixel =3D {
>  	.i2c_peripherals =3D {
>  		/* Touch Screen. */
>  		{ .add =3D setup_atmel_1664s_ts, I2C_ADAPTER_PANEL },
> @@ -450,14 +450,14 @@ static const struct chromeos_laptop chromebook_pixe=
l =3D {
>  	},
>  };
> =20
> -static const struct chromeos_laptop hp_chromebook_14 =3D {
> +static struct chromeos_laptop hp_chromebook_14 =3D {
>  	.i2c_peripherals =3D {
>  		/* Touchpad. */
>  		{ .add =3D setup_cyapa_tp, I2C_ADAPTER_DESIGNWARE_0 },
>  	},
>  };
> =20
> -static const struct chromeos_laptop dell_chromebook_11 =3D {
> +static struct chromeos_laptop dell_chromebook_11 =3D {
>  	.i2c_peripherals =3D {
>  		/* Touchpad. */
>  		{ .add =3D setup_cyapa_tp, I2C_ADAPTER_DESIGNWARE_0 },
> @@ -466,28 +466,28 @@ static const struct chromeos_laptop dell_chromebook=
_11 =3D {
>  	},
>  };
> =20
> -static const struct chromeos_laptop toshiba_cb35 =3D {
> +static struct chromeos_laptop toshiba_cb35 =3D {
>  	.i2c_peripherals =3D {
>  		/* Touchpad. */
>  		{ .add =3D setup_cyapa_tp, I2C_ADAPTER_DESIGNWARE_0 },
>  	},
>  };
> =20
> -static const struct chromeos_laptop acer_c7_chromebook =3D {
> +static struct chromeos_laptop acer_c7_chromebook =3D {
>  	.i2c_peripherals =3D {
>  		/* Touchpad. */
>  		{ .add =3D setup_cyapa_tp, I2C_ADAPTER_SMBUS },
>  	},
>  };
> =20
> -static const struct chromeos_laptop acer_ac700 =3D {
> +static struct chromeos_laptop acer_ac700 =3D {
>  	.i2c_peripherals =3D {
>  		/* Light Sensor. */
>  		{ .add =3D setup_tsl2563_als, I2C_ADAPTER_SMBUS },
>  	},
>  };
> =20
> -static const struct chromeos_laptop acer_c720 =3D {
> +static struct chromeos_laptop acer_c720 =3D {
>  	.i2c_peripherals =3D {
>  		/* Touchscreen. */
>  		{ .add =3D setup_atmel_1664s_ts, I2C_ADAPTER_DESIGNWARE_1 },
> @@ -500,14 +500,14 @@ static const struct chromeos_laptop acer_c720 =3D {
>  	},
>  };
> =20
> -static const struct chromeos_laptop hp_pavilion_14_chromebook =3D {
> +static struct chromeos_laptop hp_pavilion_14_chromebook =3D {
>  	.i2c_peripherals =3D {
>  		/* Touchpad. */
>  		{ .add =3D setup_cyapa_tp, I2C_ADAPTER_SMBUS },
>  	},
>  };
> =20
> -static const struct chromeos_laptop cr48 =3D {
> +static struct chromeos_laptop cr48 =3D {
>  	.i2c_peripherals =3D {
>  		/* Light Sensor. */
>  		{ .add =3D setup_tsl2563_als, I2C_ADAPTER_SMBUS },
> --=20
> 2.16.2.395.g2e18187dfd-goog
>=20
>=20
> --=20
> Dmitry

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlqe5pMACgkQHwn1ewov
5lhJ2Q/+P++7MZRyATRM75jyuNh3zhQ1CgxE1WkeAdImKRn/PHSiGpi9tuPWlMPT
/6o/ZkPCN4e6G/UxEkB0MbRTLtFNh/4k1EI1yQsdCN/D+WuRejhn3qAWeFwtl24M
lEriqAZWzLJyWLrNpmUNxOPv6XeGlIKWfdc51hqa3GMbt82axsW0LVZ/iqHViDKn
dM0gtwgFTiirPVk+tD5NSlx66X4cKf7JK2YpNkso6K+BJ2nen2qCq1k8yfmaXYC4
omEwsWlpWlSsOPfwF5g0uNkjCUNTTLcALJPNTbN/IaTT4c4pZ+Xp+zW6QkGNtc5Z
wLrCxjrnMVXMCMMnYVhLoB74r8hIx3UJceBTbUACHxXw1N9XpZZrCBwzG/oyDY0D
ex4YEenBpLN6mMd6bVyl0sMjhIqX1vOO+OKyMbxEpdHyT8QzHNa1aseQWnizOXtY
T596V4j03yNdYg6H46mDT2JNlcX5GZF21EGpt/9LqRbit+Aq3WJKx6ychl03Nmhn
HtvWl1UGBdUM78oFUckVPGZa4xgeZDNZysi2WmJ+u6zQwvNLWkm5Q26q2Nxy6VhP
wY9Wc/waw+xCLc6wMYrgrCv0rwdeoDJFCadv/XIrAsgtazVlJy0+DPow6P6a2/2Z
FX6sJVmyyjErK1POaMqtIgsrH3dAAgyAIUr0OSxQF8fD4zPSUII=
=SZPv
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
