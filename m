Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755725AbeEaRAb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:00:31 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45124 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755556AbeEaRA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:00:28 -0400
X-Google-Smtp-Source: ADUXVKKZAKG4Rx9vPkfdGH11lswPSKPfM2lruBxg/iebukCqH4EThV6bnJBps5xhSVR6waGlyYWPvQ==
Date: Thu, 31 May 2018 10:00:24 -0700
From: Benson Leung <bleung@google.com>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, vpalatin@chromium.org
Subject: Re: [PATCH] mfd: cros_ec_dev: Don't advertise junk features on
 failure
Message-ID: <20180531170024.GA56777@decatoncale.mtv.corp.google.com>
References: <20180531062343.243720-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <20180531062343.243720-1-swboyd@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Wed, May 30, 2018 at 11:23:43PM -0700, Stephen Boyd wrote:
> If the feature query fails during this driver's probe, we memset the
> features bits to 0, but then we continue to overwrite that with whatever
> junk we read back when the feature probing failed. In the case of a SPI
> device, it may be complete junk, causing the caller of this function to
> think certain features are present when they aren't. Don't copy over the
> bad message on failure so we can fail more gracefully.
>=20
> Fixes: e4244ebddae2 ("platform/chrome: Introduce a new function to check =
EC features.")
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Acked-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/mfd/cros_ec_dev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 1d6dc5c7a19d..d37c79426c87 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -113,10 +113,10 @@ static int cros_ec_check_features(struct cros_ec_de=
v *ec, int feature)
>  			dev_warn(ec->dev, "cannot get EC features: %d/%d\n",
>  				 ret, msg->result);
>  			memset(ec->features, 0, sizeof(ec->features));
> +		} else {
> +			memcpy(ec->features, msg->data, sizeof(ec->features));
>  		}
> =20
> -		memcpy(ec->features, msg->data, sizeof(ec->features));
> -
>  		dev_dbg(ec->dev, "EC features %08x %08x\n",
>  			ec->features[0], ec->features[1]);
> =20
> --=20
> Sent by a computer through tubes
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlsQKicACgkQHwn1ewov
5lhBRA/8CXu8Il4l9zXDDpvU8veNobp0ObupKapTz2F6G0str5COww4WUk953teN
J9EYcEkpFA4UWzJPTw05/QYJJpasplE0EEHv2H9uJHD6P8aKAbJvyOLpbeFopjPR
isozUI26MtFrJecdLhlBHF5XhKSoV6nrrl2zBrADWBg64/pqkYPq5SWjQez5+Z4r
07g8mwSfmfrXAQzw0I9v7y9olse/u/dKgBM1QqIZT9ZMh5SDhmDJMl4eiDRH3wll
k1D5e7DTRUpGdde+3U93HpLFtJdCwWh7b0HYp07Bq7/RTDoSh7LnPdyF1JCWlyhp
rS+u+BCm3cMzs+NTInUK4E88f4qQ6lu7ATke6nhnyEpYdH97cz8OJJGjRI8nsvCL
Dkrxteb1jjZ2oFnZVAmMFORLO7q2EPJe79FSq+yoyC/S7PEzRsZQKnFUww2wu/Vd
Vsxx/vNBlVJxY1XyBxaW8JjE9v6BjVCrQjZhiiI3Zjr1W+E9zuWZAJZtvJZI0UUF
877Ytm+UlSeTchy6JJnMb+zvqdIvmyzTVZ+4JGp42B7wDVblctneqgf6EBKpRQ+z
8WVmcbGAfRTmwyUVCccvvLl0+RNFTQMk25NspJ5TFbMdTymbBoVAlnAqiG+2u1qI
hadjPNxqoXkeEBt55yMWTtVQ9aCynKWhyoB1dPMh4d9XYuKGwrM=
=StVa
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
