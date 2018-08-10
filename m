Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC76C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:24:58 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666E2214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nK5B7hbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666E2214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeHJV4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 17:56:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43389 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeHJV4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 17:56:08 -0400
Received: by mail-lf1-f68.google.com with SMTP id f135-v6so7313219lfg.10;
        Fri, 10 Aug 2018 12:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+0a2bpHZiq2SYdJpMWiwGlOjyhLdWhv8a1yKcmBLRXM=;
        b=nK5B7hbtv4iYKBs8A2DjhgEkVNYT+SU4KzREi7uA8J6z4ZEwQ/SbBs7+XXeUkVAQN+
         hvQy2AhJ4te/m4hnxDpY0kr5QlZASQCxijiHBPMQBfo60a73U273OY5mPoB7lNPRKiv4
         FHx1ZBt5sMxO3CcmsNltUgcoP5n3N2w94ZA0DoSrEsb4JzRguZPpjqR6USBo2/fx31TI
         6ZKhqe5kPfEMJ9CyKK1iPTJDSs8i5KeBl/t8ESjWfWyhYe01bcLO/6tPygcWGCSUdAcG
         fPzRTLo8mvSV+zzzoykveCDFaXvOM5OmYLnq0cLJ+3WKQFjpqYp2Il55k0P8C4DA3yZ2
         zEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+0a2bpHZiq2SYdJpMWiwGlOjyhLdWhv8a1yKcmBLRXM=;
        b=kSt/Ern9Q+7pbxWJGtBEsS66eooX2A88LvWjR/Z42D2k28S5Mgot0M6RFg3/X0BSWp
         C032HpiwcDPohbQ723g0XstIF5wNOA7qRIxdvpWtssCmHJnNitGFngVMZqcDyB36X/ET
         9ljaJteKMergmcoP4wAyUgHCdfqjNnuBoXEDkQtMtfojet9PZN3GQ8/5z9nff9HCs28b
         juq7bcxaltn2nQOaH4sS7TDJ/shvDUnSxUse5pv289yqsIErvfsMhw8X6LKZdUwSmjyM
         wbOHaLN+4zHHI64NgLmpZB/i8NdnwfiA6ZWra/B7OgFguBlh6XOgTNwVCSmRtlGiZr7x
         LSjg==
X-Gm-Message-State: AOUpUlE90ETNi4nBhg5nVIIY3KfHJ3Pk4WyW3ZSiw1hTBmnZOj7yMAEK
        ra4r5IvHTXG04cdSIpItQNGY2EEk3PQ=
X-Google-Smtp-Source: AA+uWPwE6z6HXUHEEWKtrkD/QnPioXtwJU3+OPc+RNJ3G54hUJzTL9zdG5S0gA4uPDG7UOEIn2kW5A==
X-Received: by 2002:a19:f70d:: with SMTP id z13-v6mr5091166lfe.33.1533929093596;
        Fri, 10 Aug 2018 12:24:53 -0700 (PDT)
Received: from gmail.com (c-2ec24faa-74736162.cust.telenor.se. [46.194.79.170])
        by smtp.gmail.com with ESMTPSA id 85-v6sm2094714lft.76.2018.08.10.12.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 12:24:52 -0700 (PDT)
Date:   Fri, 10 Aug 2018 21:25:05 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, broonie@kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] iio: adxl372: New driver for Analog Devices
 ADXL372 Accelerometer
Message-ID: <20180810192505.GA2723@gmail.com>
References: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
 <1533557087-10401-2-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <1533557087-10401-2-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stefan,


On Mon, Aug 06, 2018 at 03:04:42PM +0300, Stefan Popa wrote:
> This patch adds basic support for Analog Devices ADXL372 SPI-Bus
> Three-Axis Digital Accelerometer.
>=20
> The device is probed and configured the with some initial default
> values. With this basic driver, it is possible to read raw acceleration
> data.
>=20
> Datasheet:
> http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL37=
2.pdf
>=20
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  MAINTAINERS                 |   6 +
>  drivers/iio/accel/Kconfig   |  11 +
>  drivers/iio/accel/Makefile  |   1 +
>  drivers/iio/accel/adxl372.c | 525 ++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 543 insertions(+)
>  create mode 100644 drivers/iio/accel/adxl372.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 60b1028..2ba47bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -543,6 +543,12 @@ W:	http://ez.analog.com/community/linux-device-drive=
rs
>  S:	Supported
>  F:	drivers/input/misc/adxl34x.c
> =20
> +ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
> +M:	Stefan Popa <stefan.popa@analog.com>
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	drivers/iio/accel/adxl372.c
> +
>  AF9013 MEDIA DRIVER
>  M:	Antti Palosaari <crope@iki.fi>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 62ae7e5..1b496ef 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -60,6 +60,17 @@ config ADXL345_SPI
>  	  will be called adxl345_spi and you will also get adxl345_core
>  	  for the core module.
> =20
> +config ADXL372
> +	tristate "Analog Devices ADXL372 3-Axis Accelerometer Driver"
> +	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to add support for the Analog Devices ADXL372 triaxial
> +	  acceleration sensor.
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called adxl372.
> +
>  config BMA180
>  	tristate "Bosch BMA180/BMA250 3-Axis Accelerometer Driver"
>  	depends on I2C
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 636d4d1..5758ffc 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_ADIS16209) +=3D adis16209.o
>  obj-$(CONFIG_ADXL345) +=3D adxl345_core.o
>  obj-$(CONFIG_ADXL345_I2C) +=3D adxl345_i2c.o
>  obj-$(CONFIG_ADXL345_SPI) +=3D adxl345_spi.o
> +obj-$(CONFIG_ADXL372) +=3D adxl372.o
>  obj-$(CONFIG_BMA180) +=3D bma180.o
>  obj-$(CONFIG_BMA220) +=3D bma220_spi.o
>  obj-$(CONFIG_BMC150_ACCEL) +=3D bmc150-accel-core.o
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> new file mode 100644
> index 0000000..db9ecd2
> --- /dev/null
> +++ b/drivers/iio/accel/adxl372.c
> @@ -0,0 +1,525 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ADXL372 3-Axis Digital Accelerometer SPI driver
> + *
> + * Copyright 2018 Analog Devices Inc.
> + */

Please make the SPDX-identifier and MODULE_LICENCE match here as well.

Either=20
SPDX-License-Identifier: GPL-2.0+
MODULE_LICENSE("GPL")

or

SPDX-License-Identifier: GPL-2.0
MODULE_LICENSE("GPL v2")

Thanks!
Marcus Folkesson

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAltt5o0ACgkQiIBOb1ld
UjKQHQ/+Pgab6MAe9FBMzZA0daGigs/5JetMKzizYOtpj2vhtntcJ5LlgMG6V/Rd
TfYjIiKPEfc8FVqtPua3DPBcvUL/iuVU7LqQYx8LaIkwT1Fp4dg2OQovOeUEUZ0E
nmAFwp3QDMPnZgAvDr5WnrFMua7a24ZhaEcDUXStoXPDndSfXkbvsCfovpAnMGk5
S/fmMoa5gPunEhOWGZR4F8q+LnmlcBUoLeTcNNqHGBpx07TQiXCybtWFKaQ8VtaO
CEznh2nEc040k4yuk2xubBh5XItJSON5fAuuHirP8gEvkmQzMwNuwO/QLkODNfuh
JYRmjBoeVm43b+hfazzQu1ZtvC9cmyj5G8SUZsI1PzI9WRFGZKb/oRMHGKaTYFO0
JtOgTLsmUTnpiP3ArRjoC6Bap5r5mlN8+rC7iELY5prpHHxw5QMiX0SsHnAlR250
msaRMAWMhiCvQ/fVLlP9YLPro4WqK4rTKQnq2zHv4VrFofxp6g/59nMnpUdPeGpS
IzByC+01dwqe8D+ZrvtrlYlELUNec6Ba0WaSUFDqu4QSmi3CaZ+UIJQNPZIa82Y5
0ZPBr7mKqWgN8DRjtB+QABKCWFuFioOWlvHywLAY/wN384etjobzxZfI0XpSY2VX
9G6KfwVHEqMIlqk+PkCjJhzjbsNf2rsEauqUK99P3UIYd0FU2Dw=
=R3xe
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
