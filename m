Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753241AbeDYVQd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753083AbeDYVQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:16:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1418421748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Wed, 25 Apr 2018 23:16:25 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 41/61] power: supply: simplify getting .drvdata
Message-ID: <20180425211625.apqz3aoegibwxpke@earth.universe>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-42-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hdfuevzedlzhdz2e"
Content-Disposition: inline
In-Reply-To: <20180419140641.27926-42-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hdfuevzedlzhdz2e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 19, 2018 at 04:06:11PM +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Thanks, queued.

-- Sebastian

>=20
> Build tested only. buildbot is happy. Please apply individually.
>=20
>  drivers/power/supply/gpio-charger.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/g=
pio-charger.c
> index bd2468ca6b63..c3f2a9479468 100644
> --- a/drivers/power/supply/gpio-charger.c
> +++ b/drivers/power/supply/gpio-charger.c
> @@ -212,8 +212,7 @@ static int gpio_charger_suspend(struct device *dev)
> =20
>  static int gpio_charger_resume(struct device *dev)
>  {
> -	struct platform_device *pdev =3D to_platform_device(dev);
> -	struct gpio_charger *gpio_charger =3D platform_get_drvdata(pdev);
> +	struct gpio_charger *gpio_charger =3D dev_get_drvdata(dev);
> =20
>  	if (device_may_wakeup(dev) && gpio_charger->wakeup_enabled)
>  		disable_irq_wake(gpio_charger->irq);
> --=20
> 2.11.0
>=20

--hdfuevzedlzhdz2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrg8CkACgkQ2O7X88g7
+pos8w/+LPzF0jjgCKRohR1rdnk267wj4AeOG2Ij++r4e4BM2/J8dHfwaUAU6D42
jspj4tqz3y7Fay/ACJ9FgeaSdgh2sLFm2topv2xmU9AMGeU8o6HpgXRNTQLEVye/
gR19HxSYo4q8GNanNIaphxiDjkp5GU9PD11sjX4uobPCD/wG46wEOf2LhVg/C6Ng
ZoSnbmqTBNTzWBXFOfVvfSjyk9MuAlKrOgBkHuEfe3hwsbiIqJwYJyBIhSRjcDOP
l3Gz1oQo91l43COx2Z8klNckBQYRRy/awXbSW6uQHTQLSyJf39BRHwXYj91xYg7K
DxyFYGmaiCUTD6m6mvO9zEwgVE/sIJhdPpkVQek5wQlrrmafv420uaxPXflMP469
zy127NBz+tjl9FA7eGVcTkfEMO4E0RTnqR24Dbb3OIy+wwmWJugkryktBhqHZr1k
gvHLzn5Ky1XN4lz+sAWEl4+N8xzBeFS+encWF/M0eyTKDn+L6EXMrPsx+y4ULkQu
zApGZ0/zoEY98+FAd7R29TIicXONHDGgSOyCUg4fqh9zofRyyw80w3lETabYnaYS
DNoJNamWS/96Xm05c9hyCfRVC1rw+ypcoddg+bvkjwfazAKZPPNOkpQEajCUvhWu
dPu1vgdbyp44WY3PvlXlZFy2jCZe5w7bfkiMr5JhBxbKU5adjL8=
=E8j1
-----END PGP SIGNATURE-----

--hdfuevzedlzhdz2e--
