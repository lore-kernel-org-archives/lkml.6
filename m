Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeBVUlD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 15:41:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751165AbeBVUlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 15:41:01 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149FF21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Thu, 22 Feb 2018 21:40:55 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Pierre Bourdon <delroth@google.com>
Cc: Andre Heider <a.heider@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] max17042: propagate of_node to power supply device
Message-ID: <20180222204055.wvnhlkzdxujriap4@earth.universe>
References: <20180220150318.138827-1-delroth@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tdw2b2sbipcr5uis"
Content-Disposition: inline
In-Reply-To: <20180220150318.138827-1-delroth@google.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tdw2b2sbipcr5uis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 20, 2018 at 04:03:18PM +0100, Pierre Bourdon wrote:
> max17042_get_status uses the core power_supply_am_i_supplied. That
> function relies on DT properties to figure out the power supply
> topology, and will error out without DT.
>=20
> Fixes max17042 battery status being reported as "unknown".
>=20
> Signed-off-by: Andre Heider <a.heider@gmail.com>
> ---

Thanks, queued to power-supply's fixes branch.

-- Sebastian

>  drivers/power/supply/max17042_battery.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supp=
ly/max17042_battery.c
> index 35dde81b1c9b..1a568df383db 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -1053,6 +1053,7 @@ static int max17042_probe(struct i2c_client *client,
> =20
>  	i2c_set_clientdata(client, chip);
>  	psy_cfg.drv_data =3D chip;
> +	psy_cfg.of_node =3D dev->of_node;
> =20
>  	/* When current is not measured,
>  	 * CURRENT_NOW and CURRENT_AVG properties should be invisible. */
> --=20
> 2.16.1.291.g4437f3f132-goog
>=20

--tdw2b2sbipcr5uis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqPKtcACgkQ2O7X88g7
+prELQ/8C5LDN3ZPRBpPzIyRW3Un64WUpZvmb774d/rM7HlEGYMS43w2eGW/N8uh
e2rM577ib3gEqxFBNBjhkWEQTusk8iaUIqYdqbjG/Z0cp+8HJZVjU0n7QujRJkZn
7O2JWJv33XtWzS7mw8fFbD1H0HAqAzTBSoV2Uv6bzisqtY1jO4cpVzJqxTEuySIH
ARfZRcwp+GeJFYFg2BunWSiKUfbyTiKK6TNSI02xzgE1K/GoT+7bi7ThdX1ipXbq
bP31r1GDm2uGU81564jth8nmBhLc6vLFBbelnoTAn+5C7hN5GcUwo7+LnUyRd2g+
VY4arbm/6NGhz7UaXYNi4EQi2hkiQuMM0nFGuDbiKqz9EFQJo+bPmI+f2mHFu9Ik
pCxjhdvEtvZf5lvPcKZPeOuQZNSE3Iv89v76WOB0a7HuoAGYO4att5NSjity7kFa
dZ2G/e3B3lEkQ/Vb3y1t/HGi/jihe9vZJHUz/BfRtVKPWEZ2czo1jvQbAzpfBzfu
Cv651IXE+xhmzCdfLH7Q4lRAV/6T3Sku2xr907Iyu+3mIuOl83nbvaKc7D+SPH1V
uCe/IwPw0hjBl/RVDjCME2uw9ybyg6QnDo3M/W4V7S0mkBNGVf9g0z16hJsZTrKK
5WeKZYzU/bzEoRFc0YG2XCg+uWQasVeJ0LJ1pyW/tAX+TzLAgl8=
=maq0
-----END PGP SIGNATURE-----

--tdw2b2sbipcr5uis--
