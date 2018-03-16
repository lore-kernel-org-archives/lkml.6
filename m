Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752842AbeCPNhU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 09:37:20 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45872 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeCPNhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 09:37:17 -0400
X-Google-Smtp-Source: AG47ELupR7a7iqVdOHlxgDZE4eDdI2TwMG4Tf84c0oo3wSFgw29EEuIChwGC6bW2RDuql43QirlYCw==
Date: Fri, 16 Mar 2018 14:37:04 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/7] watchdog: sama5d4: make use of timeout-secs
 provided in devicetree
Message-ID: <20180316133703.GA31029@gmail.com>
References: <20180211200847.25000-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20180211200847.25000-1-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Am I supposed to do something more to make this patchset picked up?

Thanks,
Marcus Folkesson

On Sun, Feb 11, 2018 at 09:08:41PM +0100, Marcus Folkesson wrote:
> watchdog_init_timeout() will allways pick timeout_param since it
> defaults to a valid timeout.
>=20
> Following best practice described in
> Documentation/watchdog/watchdog-kernel-api.txt to make use of
> the parameter logic.
>=20
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>=20
> Notes:
>     v3:
>     	- Use wdd->timeout instead of wdt_timeout when print out
>     	  timout in probe function.
>=20
>  drivers/watchdog/sama5d4_wdt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wd=
t.c
> index 0ae947c3d7bc..255169916dbb 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c
> @@ -33,7 +33,7 @@ struct sama5d4_wdt {
>  	unsigned long		last_ping;
>  };
> =20
> -static int wdt_timeout =3D WDT_DEFAULT_TIMEOUT;
> +static int wdt_timeout;
>  static bool nowayout =3D WATCHDOG_NOWAYOUT;
> =20
>  module_param(wdt_timeout, int, 0);
> @@ -212,7 +212,7 @@ static int sama5d4_wdt_probe(struct platform_device *=
pdev)
>  		return -ENOMEM;
> =20
>  	wdd =3D &wdt->wdd;
> -	wdd->timeout =3D wdt_timeout;
> +	wdd->timeout =3D WDT_DEFAULT_TIMEOUT;
>  	wdd->info =3D &sama5d4_wdt_info;
>  	wdd->ops =3D &sama5d4_wdt_ops;
>  	wdd->min_timeout =3D MIN_WDT_TIMEOUT;
> @@ -273,7 +273,7 @@ static int sama5d4_wdt_probe(struct platform_device *=
pdev)
>  	platform_set_drvdata(pdev, wdt);
> =20
>  	dev_info(&pdev->dev, "initialized (timeout =3D %d sec, nowayout =3D %d)=
\n",
> -		 wdt_timeout, nowayout);
> +		 wdd->timeout, nowayout);
> =20
>  	return 0;
>  }
> --=20
> 2.15.1
>=20

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlqryHoACgkQiIBOb1ld
UjLhTg/+LhuQESSJAa3VADaGhjoJzBzmqIesfKCeDPa08XQ5Il+7UbjNYkuhjBHn
L8axLYGY7jq2GPE500Q6hsf7LcvUIFugyg9KLjPXq5e/PO+CHSVaXBPiJSobva3Y
baTrwtdVhost+9eodoFPBZnOfLgCEayGz4AZEr93uHjJne2W9TVeWaWnLYv4SqfC
qFpn/rOOvlA1tK/YXEIKRSxBUbVmPfxsGd5uRHfpkCzqlmai17Nv/+LQKB032mw9
MwaBl9iqXFmP2XhK4iuy3oAiHwkRBnlIh6K7naiE7B5kqRxKhCQVQNlrqnj5HPFI
/w+isbAoonMS0YFN5cG0DGIeH6MhYNjyy1RPGSbha5QACCej04GnU0+GhLf2A3RT
LIWJFQojyZOMIeZYp2t4GV9BzI9+u8l5+oELwNn8WMJrP4IaQQFeg2gzCMfjGnUv
YJOzP+EVtktm+fG8RDekmD7UZ1CWX+ojosrISXkSx/RvVzqcOnJwzB1zjTMq0Dqt
9PmOsNa0QCnI6vSvZ2z2LDY26U0sejlxO8vNTwH8BHonhdhRvtFwfdpqydqhmqVA
w8+QBbrSrbQaauIS5ZEOXAs94nVyDg372LQMJmhT0MxVV3feCI6RlnDFBkSt/HH4
2lOFSY61e3SBLEUSBrQDFCa2wKLLQeGyBpz1/oFbh6qzO57LmkE=
=gLfP
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
