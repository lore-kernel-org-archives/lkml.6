Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752502AbeCTCDb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:03:31 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43277 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752470AbeCTCDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:03:22 -0400
X-Google-Smtp-Source: AG47ELsbYllxPuE+2LYzjnpO1hdehBSgUD1d9xEKhgyCJ3VLWN65OcncXo35elsevYeJ+RC8C6IGxQ==
Subject: Re: [PATCH 06/14] platform/chrome: chromeos_laptop - introduce
 pr_fmt()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org
References: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
 <20180312190907.174301-7-dmitry.torokhov@gmail.com>
From: Benson Leung <bleung@google.com>
Organization: Google
Message-ID: <9d03df01-9a98-e149-65f8-d0f5064e2e0a@google.com>
Date: Mon, 19 Mar 2018 19:03:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312190907.174301-7-dmitry.torokhov@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gAIdBU5mNZwQ4v8U3CrZDjV0Ozg51LwSB"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gAIdBU5mNZwQ4v8U3CrZDjV0Ozg51LwSB
Content-Type: multipart/mixed; boundary="I5r1uHUwWenXTddwodCYnDULylCskHGz7";
 protected-headers="v1"
From: Benson Leung <bleung@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
 linux-kernel@vger.kernel.org
Message-ID: <9d03df01-9a98-e149-65f8-d0f5064e2e0a@google.com>
Subject: Re: [PATCH 06/14] platform/chrome: chromeos_laptop - introduce
 pr_fmt()
References: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
 <20180312190907.174301-7-dmitry.torokhov@gmail.com>
In-Reply-To: <20180312190907.174301-7-dmitry.torokhov@gmail.com>

--I5r1uHUwWenXTddwodCYnDULylCskHGz7
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable



On 03/12/2018 12:08 PM, Dmitry Torokhov wrote:
> Define pr_fmt() to standardize driver messages.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied to my working branch for atmel_mxt_ts + chromeos_laptop.c for
v4.17. Thanks!

> ---
>  drivers/platform/chrome/chromeos_laptop.c | 31 ++++++++++-------------=

>  1 file changed, 14 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platfo=
rm/chrome/chromeos_laptop.c
> index 0a43f1833de3f..08ce7a105e768 100644
> --- a/drivers/platform/chrome/chromeos_laptop.c
> +++ b/drivers/platform/chrome/chromeos_laptop.c
> @@ -4,6 +4,8 @@
>  // Copyright (C) 2012 Google, Inc.
>  // Author: Benson Leung <bleung@chromium.org>
> =20
> +#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
> +
>  #include <linux/dmi.h>
>  #include <linux/i2c.h>
>  #include <linux/platform_data/atmel_mxt_ts.h>
> @@ -139,15 +141,12 @@ static struct i2c_client *__add_probed_i2c_device=
(
>  	if (name) {
>  		dmi_dev =3D dmi_find_device(DMI_DEV_TYPE_DEV_ONBOARD, name, NULL);
>  		if (!dmi_dev) {
> -			pr_err("%s failed to dmi find device %s.\n",
> -			       __func__,
> -			       name);
> +			pr_err("failed to dmi find device %s\n", name);
>  			return NULL;
>  		}
>  		dev_data =3D (struct dmi_dev_onboard *)dmi_dev->device_data;
>  		if (!dev_data) {
> -			pr_err("%s failed to get data from dmi for %s.\n",
> -			       __func__, name);
> +			pr_err("failed to get data from dmi for %s\n", name);
>  			return NULL;
>  		}
>  		info->irq =3D dev_data->instance;
> @@ -155,7 +154,7 @@ static struct i2c_client *__add_probed_i2c_device(
> =20
>  	adapter =3D i2c_get_adapter(bus);
>  	if (!adapter) {
> -		pr_err("%s failed to get i2c adapter %d.\n", __func__, bus);
> +		pr_err("failed to get i2c adapter %d\n", bus);
>  		return NULL;
>  	}
> =20
> @@ -174,19 +173,18 @@ static struct i2c_client *__add_probed_i2c_device=
(
>  		dummy =3D i2c_new_probed_device(adapter, &dummy_info,
>  					      alt_addr_list, NULL);
>  		if (dummy) {
> -			pr_debug("%s %d-%02x is probed at %02x\n",
> -				  __func__, bus, info->addr, dummy->addr);
> +			pr_debug("%d-%02x is probed at %02x\n",
> +				 bus, info->addr, dummy->addr);
>  			i2c_unregister_device(dummy);
>  			client =3D i2c_new_device(adapter, info);
>  		}
>  	}
> =20
>  	if (!client)
> -		pr_notice("%s failed to register device %d-%02x\n",
> -			  __func__, bus, info->addr);
> +		pr_notice("failed to register device %d-%02x\n",
> +			  bus, info->addr);
>  	else
> -		pr_debug("%s added i2c device %d-%02x\n",
> -			 __func__, bus, info->addr);
> +		pr_debug("added i2c device %d-%02x\n", bus, info->addr);
> =20
>  	i2c_put_adapter(adapter);
>  	return client;
> @@ -227,7 +225,7 @@ static int find_i2c_adapter_num(enum i2c_adapter_ty=
pe type)
>  	dev =3D bus_find_device(&i2c_bus_type, NULL, &lookup, __find_i2c_adap=
);
>  	if (!dev) {
>  		/* Adapters may appear later. Deferred probing will retry */
> -		pr_notice("%s: i2c adapter %s not found on system.\n", __func__,
> +		pr_notice("i2c adapter %s not found on system.\n",
>  			  lookup.name);
>  		return -ENODEV;
>  	}
> @@ -349,7 +347,7 @@ static int setup_tsl2563_als(enum i2c_adapter_type =
type)
>  static int __init chromeos_laptop_dmi_matched(const struct dmi_system_=
id *id)
>  {
>  	cros_laptop =3D (void *)id->driver_data;
> -	pr_debug("DMI Matched %s.\n", id->ident);
> +	pr_debug("DMI Matched %s\n", id->ident);
> =20
>  	/* Indicate to dmi_scan that processing is done. */
>  	return 1;
> @@ -392,8 +390,7 @@ static int chromeos_laptop_probe(struct platform_de=
vice *pdev)
>  				ret =3D -EPROBE_DEFER;
>  			} else {
>  				/* Ran out of tries. */
> -				pr_notice("%s: Ran out of tries for device.\n",
> -					  __func__);
> +				pr_notice("ran out of tries for device.\n");
>  				i2c_dev->state =3D TIMEDOUT;
>  			}
>  		} else {
> @@ -600,7 +597,7 @@ static int __init chromeos_laptop_init(void)
>  	int ret;
> =20
>  	if (!dmi_check_system(chromeos_laptop_dmi_table)) {
> -		pr_debug("%s unsupported system.\n", __func__);
> +		pr_debug("unsupported system\n");
>  		return -ENODEV;
>  	}
> =20
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org


--I5r1uHUwWenXTddwodCYnDULylCskHGz7--

--gAIdBU5mNZwQ4v8U3CrZDjV0Ozg51LwSB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlqwa+YACgkQHwn1ewov
5li1yw//fpiFJpzxwwlnYcxyFG8oBdP0ZgwKwS1Idl/RkrIhGZnj+6pRz87YUFnm
fr5p3Gp0+aOI3BDosxlDXHzZCNAhQXV8dh6X+hTmX+72E4JQGukpDtw/5kYyFuQm
+MzRGoJ1idHRzbagzT2GWvsfPwfmbV6fpPmU2un6zyD34Lp+8IHsbUIOi4RCp/kU
ZMtQcMXTvfabWBhRMkDscT67V0tBT3AX+eIRyMbp3aeWzy4HLh322207mehd39Ld
oLQqpiDOzbvBhkiosay429Pt1Sj7fc7WTB+yTCQeBAUY3lh4FY4iUQcONnokZlYz
Ozk4yTrxiNNHcBDW03/WyEMwAwfKOKACezIbODg+zqx/zkJHs/IzNujUT+NpNbf5
mEd3Af9vkFHTIxFKohVQZ+jpCtQU+iAvzxntxCyr/OmK+Tgzohwro5Xn9LnvgKND
hfYEp942sMTFHODPZ+le1Z5RqBSKrWQuTEi0ZNMQCkpHAsAr/UQRJV/2/1bRCgR0
7UfSipulzRfZtv7x+4rPz5aNhPZtg9kHXnEqWqCqJAufznjaAaqWk531NL7t9Q+V
mCBO9Y6d6RPprLd2yMZVcz5D0iGzyLS69t1A19XD82sty52ahT3y9GD3+GOSpqTM
wC0bfu/+Ntm+fzXvi9Vq6LspwOqse+jS3BQORj5Pyd6O6MEd58E=
=Ot7l
-----END PGP SIGNATURE-----

--gAIdBU5mNZwQ4v8U3CrZDjV0Ozg51LwSB--
