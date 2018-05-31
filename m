Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751012AbeEaVDp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:03:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:52934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750941AbeEaVDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:03:42 -0400
From: NeilBrown <neil@brown.name>
To: Sankalp Negi <sankalpnegi2310@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 01 Jun 2018 07:03:33 +1000
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Sankalp Negi <sankalpnegi2310@gmail.com>
Subject: Re: [PATCH] staging: mt7621-spi: Fix Coding style issues reported by checkpatch.pl.
In-Reply-To: <20180531185542.phhu2rkdoq2czkav@localhost>
References: <20180531185542.phhu2rkdoq2czkav@localhost>
Message-ID: <87d0xbtu56.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01 2018, Sankalp Negi wrote:

> This patch fixes following checkpatch.pl issues:
>
> WARNING : line over 80 characters
> ERROR   : code indent should use tabs where possible
> WARNING : no spaces at the start of a line
> ERROR   : switch and case should be at the same indent
> ERROR   : space required before the open parenthesis
> WARNING : braces {} are not necessary for single statement blocks
>
> Signed-off-by: Sankalp Negi <sankalpnegi2310@gmail.com>
> ---
>  drivers/staging/mt7621-spi/spi-mt7621.c | 32 ++++++++++++++++-----------=
-----
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt=
7621-spi/spi-mt7621.c
> index 37f299080410..cd94f5f569df 100644
> --- a/drivers/staging/mt7621-spi/spi-mt7621.c
> +++ b/drivers/staging/mt7621-spi/spi-mt7621.c
> @@ -55,7 +55,8 @@
>  #define MT7621_CPOL		BIT(4)
>  #define MT7621_LSB_FIRST	BIT(3)
>=20=20
> -#define RT2880_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_=
CS_HIGH)
> +#define RT2880_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA |		\
> +				SPI_LSB_FIRST | SPI_CS_HIGH)
>

Thanks for this.  It all looks good except that above.  I'm a bit picky
about indentation, and more picky about making the code easy to read.
The above breaks an indentation rule and (I think) hurts readability.
It was only just over 80 columns so it wasn't all that bad as it was -
let's be sure to make it better.
Some options:

#define RT2880_SPI_MODE_BITS (SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_CS_=
HIGH)

i.e. replace the tab with a space.  Now it doesn't line up with the
previous lines, but I'm not sure that matters much.

#define RT2880_SPI_MODE_BITS	\
	(SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_CS_HIGH)

This keeps all the content together on one line.

#define RT2880_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA |		\
				 SPI_LSB_FIRST | SPI_CS_HIGH)

This is close to what you had, but doesn't break the indenting rule:
everything inside brackets must be to the right of the opening bracket
unless that opening bracket is at the end of a line.

Any of these would be acceptable - my personal preference is the second
one.

Thanks,
NeilBrown


>  struct mt7621_spi;
>=20=20
> @@ -104,7 +105,7 @@ static void mt7621_spi_set_cs(struct spi_device *spi,=
 int enable)
>  	int cs =3D spi->chip_select;
>  	u32 polar =3D 0;
>=20=20
> -        mt7621_spi_reset(rs, cs);
> +	mt7621_spi_reset(rs, cs);
>  	if (enable)
>  		polar =3D BIT(cs);
>  	mt7621_spi_write(rs, MT7621_SPI_POLAR, polar);
> @@ -137,18 +138,18 @@ static int mt7621_spi_prepare(struct spi_device *sp=
i, unsigned int speed)
>  		reg |=3D MT7621_LSB_FIRST;
>=20=20
>  	reg &=3D ~(MT7621_CPHA | MT7621_CPOL);
> -	switch(spi->mode & (SPI_CPOL | SPI_CPHA)) {
> -		case SPI_MODE_0:
> -			break;
> -		case SPI_MODE_1:
> -			reg |=3D MT7621_CPHA;
> -			break;
> -		case SPI_MODE_2:
> -			reg |=3D MT7621_CPOL;
> -			break;
> -		case SPI_MODE_3:
> -			reg |=3D MT7621_CPOL | MT7621_CPHA;
> -			break;
> +	switch (spi->mode & (SPI_CPOL | SPI_CPHA)) {
> +	case SPI_MODE_0:
> +		break;
> +	case SPI_MODE_1:
> +		reg |=3D MT7621_CPHA;
> +		break;
> +	case SPI_MODE_2:
> +		reg |=3D MT7621_CPOL;
> +		break;
> +	case SPI_MODE_3:
> +		reg |=3D MT7621_CPOL | MT7621_CPHA;
> +		break;
>  	}
>  	mt7621_spi_write(rs, MT7621_SPI_MASTER, reg);
>=20=20
> @@ -164,9 +165,8 @@ static inline int mt7621_spi_wait_till_ready(struct s=
pi_device *spi)
>  		u32 status;
>=20=20
>  		status =3D mt7621_spi_read(rs, MT7621_SPI_TRANS);
> -		if ((status & SPITRANS_BUSY) =3D=3D 0) {
> +		if ((status & SPITRANS_BUSY) =3D=3D 0)
>  			return 0;
> -		}
>  		cpu_relax();
>  		udelay(1);
>  	}
> --=20
> 2.11.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsQYyUACgkQOeye3VZi
gbnLpw//TyfpJ4hsrPCKB84XU9wNNrAY62ZKoeTE95+I9llZwwpyFyESTrKu1t8z
+W37tPWJq1V0eB521EJzAj/aQWIWDAIFPO8U28RbeW52HlcCuPlEco/99LTLS5Ud
I9TIjV6P2fTvGaXj7wRRFqJRhql5HPzae94ofw1r7VtzQ31LbD5Vpyh9uYlY4VHA
0LQC9sqWHJd0ErQPqUKEuVyX+liCPzw+ktIZOQoteZnfE6dyUKIWYRTbArKm8p2m
8JQwZBcRV+rpLeobv6O864FBCV6xRTe45Nn5NrPRpdipe3QbOb7gXy4e3TUK4Mte
nBkruYe4lafhJn/o+DhLKb1BniJaO6HQXCfaEJRVUf+Da7R9Z9EcCK87qXyKrzst
1KUTeID2W9GFe+BcCZtqYjNdBuB10nq3anK6h4Oz5+L1tYv2hnEet4md1ZGn4jgr
FXRz1w9oRcfC3QkJOJsbS8edXfMGLGQQhruVbzdBvyNDVY9h2iN/JBAGaWVQtInY
w7BVltG4sRutQprpJWCwxoR3Cdh/6Ps2HdZ7meED/XduYN5LDFNLlXYQBKVzWTVl
eoPnIRfTo5Y8JwOH6FA55RFh8gOVzPfmNNd2mp0npc9ld9h0GO4OtGtp7zJm3giL
MUrQC4XEnV/1eyTHOogy5Om7ThNdnAciW2UaRS3cBQqVm3WE7vY=
=daog
-----END PGP SIGNATURE-----
--=-=-=--
