Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C0EC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D143622449
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3EokXJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D143622449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeHJUwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:52:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47076 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbeHJUwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:52:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so7837639ljj.13;
        Fri, 10 Aug 2018 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sa0GEbC3TUSFJvVlxpArGiuuzLmoFSsh92Vsdt62Hu4=;
        b=m3EokXJpbASJxhKbLF8UIheU8m6f5UcYA2qcIphWwrX6d0nODC83W4pLwiA844L7Eg
         X2MaX5o/uW6lP3i8g3IHN3xNmxn+RtDNrTLsJqbxBAzxAmfyYUZPjXnSalpkudM/luY3
         5gJAOW6U4ZV+S5o7+O3yorfktj0bo1Vw5kUtsdTE/eO04BgoWvOlluL9qWD93IEkWncv
         r7exiOLwl3jXUiCQHprmPHAz+x16mZAgx/dwtsrJNc4CP8ba1+YcYJehw+UZacSdUfmS
         /uqLBkCp8uza9wx0VocZC7gaZ9dw+6Hk4e9UoCs/54Z6JzFaoeHbFO9XYBu7oavAtKoO
         FVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sa0GEbC3TUSFJvVlxpArGiuuzLmoFSsh92Vsdt62Hu4=;
        b=fh8XMjQPS3dFdlJdr7bDmT2tNWcNkeiEaSWX0fxrvAHnDLeY0CXCYL1nQdnfJ0tetv
         awJU2EB59PgyojoJJbUbngJ4RFCN56MjfAXtOkxa/uKgsjznk74H2RksLPoM4SjT73WS
         KxbA9GGOCgH85/mD1tHseMmnbv7ZOAD+BstPyofF0G/iZE7m+yYgUWySD/OUPkYGGX2z
         rpRomR5zSvZPI/p2jpx3juWAWBc5N0Xg7kmVZszePncyED6EyrHrxFjRtZU+rjwo9F2J
         dQ0STtCjn37P7GNjtUGXj52TYDGNyo6B5jLoS0aUJ+Cn8e0wHax/cEjWXXOpCmylaLq9
         FNvQ==
X-Gm-Message-State: AOUpUlE+OihJRuryst3X7l4v7FihWRQKcNJoXeOzirCRjvkZtO9XSni7
        VTzDYmuw8VBEboKuaIuFX7Q=
X-Google-Smtp-Source: AA+uWPxZwGxDrxAt3am+Emd7yBYVbTMDRckNW1byaJOtlJUZ/Wsh3fBcKkx6um39ZTZQ57Hp/B+PsQ==
X-Received: by 2002:a2e:6d0a:: with SMTP id i10-v6mr5703558ljc.145.1533925282846;
        Fri, 10 Aug 2018 11:21:22 -0700 (PDT)
Received: from gmail.com (c-2ec24faa-74736162.cust.telenor.se. [46.194.79.170])
        by smtp.gmail.com with ESMTPSA id r1-v6sm1744297ljr.81.2018.08.10.11.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 11:21:20 -0700 (PDT)
Date:   Fri, 10 Aug 2018 20:21:35 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, broonie@kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/6] iio: adxl372: New driver for Analog Devices
 ADXL372 Accelerometer
Message-ID: <20180810182135.GA717@gmail.com>
References: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
 <1533890783-13456-2-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <1533890783-13456-2-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Fri, Aug 10, 2018 at 11:46:18AM +0300, Stefan Popa wrote:
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

The SPDX identifier "GPL-2.0+" is "GPL v2 or later", and the MODULE_LICENSE
"GPL v2" is "GPL v2 only"

See include/linux/module.h ::

 *	"GPL"				[GNU Public License v2 or later]
 *	"GPL v2"			[GNU Public License v2]


Please make them match :-)

[snip]

> +MODULE_LICENSE("GPL v2");
> --=20
> 2.7.4
>=20

Best regards
Marcus Folkesson

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAltt16kACgkQiIBOb1ld
UjLvdw//RuXizom2vss5WQp9bKoizuxPCG3xFJDXBQKgkIuRhCXEWfafC1eMe6Yp
u6IpuO50LS98lU/qAL5xNRmjPIr761zvoMbB+EZFCxlmBzqw6mpntZNyX28JYM/D
i6k8pA7Gg/TJOSF6pvbblugUYJQMZgRnao4trzqS4CRNntV5yyW007FmaniwcSBE
Kx5NNZ1wjBEFWVirl1MFQM93JfrVn4ieSL1hqYL3lcCMU3DOeWMuKzcLFv/rNspL
3+5zkL3g0ALwrGGkC9uaeORb8rMMhRqGffxQq4Qtw7qeqwS3J3oH6ZuGOlhP2Bdj
jyjkdCFjmmZi58OBYu8wRFFhdhZN7a0Xyt3PaOeHECUsJlnIArFCrENyGCFa10Vg
mbzAuCk6CfFbf1W09IRLH91nlhrygJxNPqbWgEHxo04o+U8aXc5tUaYz8Ov6DQ0C
tINWV06TEpKoj9AFG3qCc71FTJapkukXY8XMtgTFo+MhGgd6oDYXu735/Opf7DZj
Ru6Eh3hZ6Hryy6wxJ48Ufjoy4SBMH/F+e2kf4z8C9xXOrRqXanyIXJyqjNAlOwGV
kYBHeR8MCIfrqCtGQdePYFymymivCZDcAhFMC6CPjzqd07VlBCJHuQUB2lo0wu0r
8RkwRwIVd84BA5vNFaj1X56mY5PusDWjAFqKEs0VbHBNG9eqYME=
=KjBl
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
