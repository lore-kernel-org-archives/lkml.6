Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810D0C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 19:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B46D20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 19:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B46D20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeKDEZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 00:25:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42920 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeKDEZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 00:25:58 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id BDD6080938; Sat,  3 Nov 2018 20:13:44 +0100 (CET)
Date:   Sat, 3 Nov 2018 20:13:46 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: pxa2xx: Remove the shutdown callback
Message-ID: <20181103191346.GF31179@amd>
References: <20180917121124.21305-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="R6sEYoIZpp9JErk7"
Content-Disposition: inline
In-Reply-To: <20180917121124.21305-1-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-09-17 14:11:24, Lubomir Rintel wrote:
> It makes no sense to remove the device on shutdown. And it break things
> when the hardware crucial for shutdown (such as the embedded controller)
> is attached to the SPI bus.

Again, are you sure?

On some hardware (sharp zaurus, phones) it is good idea to shut down
hardware before poweroff, as they don't have embedded controller that
would cut the power.

Will this increase power consumption while "off" on such platforms?
									Pavel

> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/spi/spi-pxa2xx.c | 9 ---------
>  1 file changed, 9 deletions(-)
>=20
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 14f4ea59caff..b06f37fb29f6 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1764,14 +1764,6 @@ static int pxa2xx_spi_remove(struct platform_devic=
e *pdev)
>  	return 0;
>  }
> =20
> -static void pxa2xx_spi_shutdown(struct platform_device *pdev)
> -{
> -	int status =3D 0;
> -
> -	if ((status =3D pxa2xx_spi_remove(pdev)) !=3D 0)
> -		dev_err(&pdev->dev, "shutdown failed with %d\n", status);
> -}
> -
>  #ifdef CONFIG_PM_SLEEP
>  static int pxa2xx_spi_suspend(struct device *dev)
>  {
> @@ -1851,7 +1843,6 @@ static struct platform_driver driver =3D {
>  	},
>  	.probe =3D pxa2xx_spi_probe,
>  	.remove =3D pxa2xx_spi_remove,
> -	.shutdown =3D pxa2xx_spi_shutdown,
>  };
> =20
>  static int __init pxa2xx_spi_init(void)

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvd82oACgkQMOfwapXb+vLaUwCfenRFkDxK+3sEu/J9yVsj+7QM
0pYAoKXD1uEnyLqJmfXI360WRKKZGlmk
=UbcJ
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--
