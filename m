Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752363AbeCEPt0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:49:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32804 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbeCEPtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:49:24 -0500
Date: Mon, 5 Mar 2018 15:49:10 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com,
        michael@amarulasolutions.com
Subject: Re: [PATCH v2 1/2] ASoC: codecs: Add support for PCM1789
Message-ID: <20180305154910.GJ8588@sirena.org.uk>
References: <20180305124817.7421-1-mylene.josserand@bootlin.com>
 <20180305124817.7421-2-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n8884J15jRwcBTvu"
Content-Disposition: inline
In-Reply-To: <20180305124817.7421-2-mylene.josserand@bootlin.com>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8884J15jRwcBTvu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2018 at 01:48:16PM +0100, Myl=E8ne Josserand wrote:

> --- /dev/null
> +++ b/sound/soc/codecs/pcm1789-i2c.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCM1789 ASoC I2C driver
> + *
> + * Copyright (c) Bootlin 2018
> + *
> + * Myl=E8ne Josserand <mylene.josserand@bootlin.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License

Please don't mix C and C++ style comments in a single comment like this
- it looks unintentional.  Just use the same style for the whole thing.
You also don't need to include all the boilerplate with the SPDX header.

> +static bool pcm1789_accessible_reg(struct device *dev, unsigned int reg)
> +{
> +	return reg >=3D PCM1789_MUTE_CONTROL && reg <=3D PCM1789_DAC_VOL_RIGHT;
> +}
> +
> +static bool pcm1789_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	return pcm1789_accessible_reg(dev, reg);
> +}

> +static void pcm1789_work_queue(struct work_struct *work)
> +{
> +	struct pcm1789_private *priv =3D container_of(work,
> +						    struct pcm1789_private,
> +						    work);
> +
> +	/* Perform a software reset to remove codec from desynchronized state */
> +	if (regmap_update_bits(priv->regmap, PCM1789_MUTE_CONTROL,
> +			       0x3 << PCM1789_MUTE_SRET, 0) < 0)
> +		dev_err(priv->dev, "Error while setting SRET");
> +}

A reset sounds like we'd also need to resync the register map,
presumably this is something else?  The comment could be clearer.

--n8884J15jRwcBTvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqdZvUACgkQJNaLcl1U
h9ArPgf/doY6KKkVX5LZMkHvKd+IQYpFQit1dIzFg1IQEU63IJnFwKu29BMIVMk0
8czRzrLQQkM/S9+vEHqRYLJYUjAVZFA0I1QeVsc504gnIHl9eDLZE0heXbOTWkpu
rN6lTw8+7t8rm9b1wPnp8SXsqWM+3NaF+Kc02T0bvb2xW+gM/gYvYDqfM2oV2Kfm
267+/ekaYiYGolHbFlK6zmyH/2EyawKnDXQw5dTJ9dA9AlyYXMKFFoiigBVzcYFM
GK6R7PRZqCPj44nUBsGirId6WeE7CJU+DI9ZAZRIBugJrcsuS0+oxuafBkhkaUZH
BmjWvGV7wGXis0ecQ3munLn5Bsw/Bg==
=+ja3
-----END PGP SIGNATURE-----

--n8884J15jRwcBTvu--
