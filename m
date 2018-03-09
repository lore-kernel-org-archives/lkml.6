Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932201AbeCIQTb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:19:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:51256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbeCIQTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:19:30 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF54C20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Fri, 9 Mar 2018 17:19:26 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, robh+dt@kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v3 2/2] power: reset: gpio-poweroff: Support for timeout
 from device property
Message-ID: <20180309161926.hciaq3ok7st3fc7j@earth.universe>
References: <20180222231714.11843-1-mdf@kernel.org>
 <20180222231714.11843-2-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="osw746qlfqyb3xsn"
Content-Disposition: inline
In-Reply-To: <20180222231714.11843-2-mdf@kernel.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--osw746qlfqyb3xsn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 22, 2018 at 03:17:14PM -0800, Moritz Fischer wrote:
> Add support for reading a timeout value from device property.
> Fall back to previous default of 3s if nothing is specified.
>=20
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---

Thanks, both queued.

-- Sebastian

> Changes from v2:
> - use device_property_read_{bool,u32} instead of of equivalent
>=20
> Changes from v1:
> - of_property_read_u32() overwrites the output only if it succeeds,
>   simplify error handling
> ---
>=20
>  drivers/power/reset/gpio-poweroff.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gp=
io-poweroff.c
> index be3d81ff51cc..6273ad3b411d 100644
> --- a/drivers/power/reset/gpio-poweroff.c
> +++ b/drivers/power/reset/gpio-poweroff.c
> @@ -19,11 +19,13 @@
>  #include <linux/of_platform.h>
>  #include <linux/module.h>
> =20
> +#define DEFAULT_TIMEOUT_MS 3000
>  /*
>   * Hold configuration here, cannot be more than one instance of the driv=
er
>   * since pm_power_off itself is global.
>   */
>  static struct gpio_desc *reset_gpio;
> +static u32 timeout =3D DEFAULT_TIMEOUT_MS;
> =20
>  static void gpio_poweroff_do_poweroff(void)
>  {
> @@ -40,7 +42,7 @@ static void gpio_poweroff_do_poweroff(void)
>  	gpiod_set_value(reset_gpio, 1);
> =20
>  	/* give it some time */
> -	mdelay(3000);
> +	mdelay(timeout);
> =20
>  	WARN_ON(1);
>  }
> @@ -58,12 +60,14 @@ static int gpio_poweroff_probe(struct platform_device=
 *pdev)
>  		return -EBUSY;
>  	}
> =20
> -	input =3D of_property_read_bool(pdev->dev.of_node, "input");
> +	input =3D device_property_read_bool(&pdev->dev, "input");
>  	if (input)
>  		flags =3D GPIOD_IN;
>  	else
>  		flags =3D GPIOD_OUT_LOW;
> =20
> +	device_property_read_u32(&pdev->dev, "timeout-ms", &timeout);
> +
>  	reset_gpio =3D devm_gpiod_get(&pdev->dev, NULL, flags);
>  	if (IS_ERR(reset_gpio))
>  		return PTR_ERR(reset_gpio);
> --=20
> 2.16.1
>=20

--osw746qlfqyb3xsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqitA0ACgkQ2O7X88g7
+ppp2Q//YA8TyfLpPaEgOkkQKccxE4UgfbpfLbW5DjwSv45dQGQ3jeiz5LSUQwk3
JjeOOQTyTZgRbUFtis30DV8x5mqB3QevGexUygVzRDh4Y2QM2CmikCfmbTNqAkYa
emdrLFXtBacZTeP4GNBizU0Edv5N/iWCzyUfp1MClRmvvoKLJRPg5+QEhOdEpnXE
5XDwozK7E8qkCvsOMCdJUEIWNrOpDzxuxtz2GR7MlPPUtLUvs8g58AKanmquuzTX
Sc+wzjLy3bDQSLRw6MGHnc2O5KACsaIkKvO0pzve8iZFo7jBsZQWfFA1icxaFA6c
YZP3i5k8A2Ldr5LKizB+poSDduvCl0bxRxokitgLFd6+Da9uO2EPSsOJZdmstO+E
N/EBRU0ntdjgVXZLShITBqlAB4K/PMVZgZ9XmTamZjRH9jmxcEBatl1zIhM2LKi5
f/mznYvU3LuQOAdb6caw0z+uOYuJxpvuQFe97DJdlEkPwtJcSd5H7aZ8g6WjO37q
uF6HrOOURYFjcnvDADeknR8QF7/fTrz2zm7fG6N0k2ilPFU0K5lsCHdyBATe9jGT
QgGV/zOPM5os0XnWP1apyTBrOf6xjk2l8/utuyzSlG3CTU1PPmQXhHUjJ5022Ofn
XtDDuO8W/f3syBwCOWKfESzXIV/1duTAE0X3n/mRALty1fNoR/o=
=1IEW
-----END PGP SIGNATURE-----

--osw746qlfqyb3xsn--
