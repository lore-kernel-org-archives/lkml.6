Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752968AbeDYVLe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751808AbeDYVLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:11:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD12B205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Wed, 25 Apr 2018 23:11:25 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio-poweroff: Use gpiod_set_value_cansleep
Message-ID: <20180425211125.io6oxvezuxcq6pfk@earth.universe>
References: <1524568230-14353-1-git-send-email-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t5rxydob5wq7itzs"
Content-Disposition: inline
In-Reply-To: <1524568230-14353-1-git-send-email-mike.looijmans@topic.nl>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t5rxydob5wq7itzs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Tue, Apr 24, 2018 at 01:10:30PM +0200, Mike Looijmans wrote:
> The power-off call is done in a context that must be able to sleep, so
> use gpiod_set_value_cansleep instead of the atomic gpiod_set_value call.
>=20
> This fixes a kernel warning at shutdown when the gpio is controlled
> through an IO expander for example.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/gpio-poweroff.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gp=
io-poweroff.c
> index 6273ad3..38206c3 100644
> --- a/drivers/power/reset/gpio-poweroff.c
> +++ b/drivers/power/reset/gpio-poweroff.c
> @@ -35,11 +35,11 @@ static void gpio_poweroff_do_poweroff(void)
>  	gpiod_direction_output(reset_gpio, 1);
>  	mdelay(100);
>  	/* drive inactive, also active->inactive edge */
> -	gpiod_set_value(reset_gpio, 0);
> +	gpiod_set_value_cansleep(reset_gpio, 0);
>  	mdelay(100);
> =20
>  	/* drive it active, also inactive->active edge */
> -	gpiod_set_value(reset_gpio, 1);
> +	gpiod_set_value_cansleep(reset_gpio, 1);
> =20
>  	/* give it some time */
>  	mdelay(timeout);
> --=20
> 1.9.1
>=20

--t5rxydob5wq7itzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrg7vQACgkQ2O7X88g7
+prrmA/+OBvI4wJeeiC5ra9UZ6cye7Lw2Sj9/c0KK2QsnLaM8LhHfjkuPmpXhEzD
cTWMIN+mpHi+3tObD6v5mmOIiLRoxYw39wleQ+4TAk6PJdJjBUU9EO51v5amIrFt
L2mIjCoev4t3WglunwqJXd9QJYHPEZwCFG4MxPeb//nR7P0Sy0S5cEtcUkH+FAxe
Cvo8pRy5VeFQJuEdnl+abFPzateV39TakSkj319kdatGfsRwCCHbQ0ie45rfSp/y
KNVeqjbbY4CmkxYKB5dSaJiSaMZ14eOQcAJWxzn4uszm5Uswv4dSxoo/55Kk4lJq
c2uuoL9atcrBI+NiBhAsR4dyNoBxPWG801tjpXxp/op0Mb/QnFl4POgmZY7L5xhE
YiKkj9+m9SmXTJe2MuxDy7nktNRZ1MVrjSfcmgSHXWLSbIlvbNOEN9gnRMxoWVZl
gwW9REMfnn+8NTFLCJTHFD4cvQvSJd+zGMcFgDUAPaEQqSb6XucyDUoQVPPdNVyg
L9gdJIw6F7PeYqZ3WI5KsF1hmBXVxmabKgyaNOQ2N9P/AiASeB+tclTU38sgDs5r
0cfDZkZLxFuqSRWfUSwSQcWgwEniPHNXBnkAdzbstxGz0DXNYrq8d/pkHoLhz0og
6CtgFxvdO0YzNa5Bkz1czqd6Uj5pR9lsDL9o7CcEG215C6WTu2Q=
=LuXy
-----END PGP SIGNATURE-----

--t5rxydob5wq7itzs--
