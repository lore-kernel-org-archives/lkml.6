Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DDAC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888552075D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfBLMBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:01:20 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35527 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfBLMBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:01:20 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id BDD1880298; Tue, 12 Feb 2019 13:01:10 +0100 (CET)
Date:   Tue, 12 Feb 2019 13:01:17 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v3 06/11] mfd: max77650: new core mfd driver
Message-ID: <20190212120116.GB24296@amd>
References: <20190201094736.32057-1-brgl@bgdev.pl>
 <20190201094736.32057-7-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <20190201094736.32057-7-brgl@bgdev.pl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-02-01 10:47:31, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> Add the core mfd driver for max77650 PMIC. We define five sub-devices
> for which the drivers will be added in subsequent patches.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/mfd/Kconfig          |  11 ++
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/max77650.c       | 342 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max77650.h |  59 ++++++
>  4 files changed, 413 insertions(+)
>  create mode 100644 drivers/mfd/max77650.c
>  create mode 100644 include/linux/mfd/max77650.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index f461460a2aeb..828fd193b4ee 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -734,6 +734,17 @@ config MFD_MAX77620
>  	  provides common support for accessing the device; additional drivers
>  	  must be enabled in order to use the functionality of the device.
> =20
> +config MFD_MAX77650
> +	tristate "Maxim MAX77650/77651 PMIC Support"
> +	depends on I2C
> +	depends on OF || COMPILE_TEST
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  Say yes here to add support for Maxim Semiconductor MAX77650 and

"Say Y" would be more common and consistent with your ther patch.

> +	  MAX77651 Power Management ICs. This is the core multifunction
> +	  driver for interacting with the device.

Mention modular build and module name here?

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxitYwACgkQMOfwapXb+vKoiwCeM+Orm+nLxPPfa5F1l9dfrVbe
/UIAnimLGMXovjzDdbWKFGj1wMwQFAXU
=fAsK
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
