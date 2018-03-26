Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbeCZO5k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:57:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52332 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbeCZO5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:57:37 -0400
X-Google-Smtp-Source: AIpwx49AARyS6i2VJyY8Gurtg6hpHnE7I22Gj9H0pili0IHcEWwDJ3MNRvKed8w65mTutV6nkUhVew==
Date: Mon, 26 Mar 2018 16:57:34 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Emil Goode <emil.fsw@goode.io>
Cc: Thierry Reding <treding@nvidia.com>, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] gpu: host1x: Fix compiler errors
Message-ID: <20180326145734.GA8016@ulmo>
References: <20180326144314.xeuocqp5fjpfjm3q@lianli>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <20180326144314.xeuocqp5fjpfjm3q@lianli>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2018 at 04:44:14PM +0200, Emil Goode wrote:
> The compiler is complaining with the following errors:
>=20
> drivers/gpu/host1x/cdma.c:94:48: error:
> 	passing argument 3 of =E2=80=98dma_alloc_wc=E2=80=99 from incompatible p=
ointer type
> 	[-Werror=3Dincompatible-pointer-types]
>=20
> drivers/gpu/host1x/cdma.c:113:48: error:
> 	passing argument 3 of =E2=80=98dma_alloc_wc=E2=80=99 from incompatible p=
ointer type
> 	[-Werror=3Dincompatible-pointer-types]
>=20
> The expected pointer type of the third argument to dma_alloc_wc() is
> dma_addr_t but phys_addr_t is passed. Fix this by adding casts to the
> expected pointer type.
>=20
> Signed-off-by: Emil Goode <emil.fsw@goode.io>
> ---
>  drivers/gpu/host1x/cdma.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

What compiler do you use? I do regular builds and check for warnings and
errors, and this one is new to me.

Thierry

>=20
> diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
> index 28541b280739..5e8b321a751e 100644
> --- a/drivers/gpu/host1x/cdma.c
> +++ b/drivers/gpu/host1x/cdma.c
> @@ -91,8 +91,8 @@ static int host1x_pushbuffer_init(struct push_buffer *p=
b)
> =20
>  		size =3D iova_align(&host1x->iova, size);
> =20
> -		pb->mapped =3D dma_alloc_wc(host1x->dev, size, &pb->phys,
> -					  GFP_KERNEL);
> +		pb->mapped =3D dma_alloc_wc(host1x->dev, size,
> +					  (dma_addr_t *)&pb->phys, GFP_KERNEL);
>  		if (!pb->mapped)
>  			return -ENOMEM;
> =20
> @@ -110,8 +110,8 @@ static int host1x_pushbuffer_init(struct push_buffer =
*pb)
>  		if (err)
>  			goto iommu_free_iova;
>  	} else {
> -		pb->mapped =3D dma_alloc_wc(host1x->dev, size, &pb->phys,
> -					  GFP_KERNEL);
> +		pb->mapped =3D dma_alloc_wc(host1x->dev, size,
> +					  (dma_addr_t *)&pb->phys, GFP_KERNEL);
>  		if (!pb->mapped)
>  			return -ENOMEM;
> =20
> --=20
> 2.11.0
>=20

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq5ClsACgkQ3SOs138+
s6EYmRAAtpAzxsh/1a+tjErMDxZSzD5jtDNSIAX8wFlhzA1kfouwtI5K7RVNs2xI
ELPi3T5HWS1YP7FU2lHJ+TutyaNQpYbznzSaYFOdw5PK/3AtrHVW1AVyXVWoylb7
JipgdJ9lPZTP5y5BNWhPnRBlGMkzt6D+W5UPoB0A9lEfHDe3JQ7dNhY0ObUR9obw
5esC2YFojPkEey23cvDelcqqbe8C025babyloB+N1pcvSCevvedCKtcwPvKg9HKp
93ZYae1a7veCDmpiiL8Szcj5Ajas9HS4oh3HMONLhzMJeagtHvqNUvfAMDAIV62K
2ImnSo0RoNAXJJbRX2KZ1/EV6VXuJxltSXjiz8ZNEGIS0E6H9KqzLZStV+eSx0qc
h+xmFO2qORcc887193ibKvf0EblBgg3kk2iFdl70/IDLdT91bwijC1tyZ6FP/EYo
dwZJlx/04McXcr9t1Xshd+XbCXJZ4etp6dmOxltxYUpWlWOmIt1Paquyz7oMfZo3
773TJi1HtV01x+zKHnP/ARCzY3vhLGu4FxsXufWm8r/givhkpnehbLhFl1Lg1+es
ih5cw0V95BYiPSJF8P77p7O2u1UBmRWYvYsbts51C/e+WXYISimGsXuV1gOwb6/4
ab5lySeUbGOtf9meJzFQM44tXQBVKYwHFUGT2KmDaqeywZLaPzQ=
=muEF
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
