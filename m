Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx4/Un3FoFDapvX1ZQcrUCNdgdqp7ba5S1EA7kFNtFg6P4NHpmEsM2E5KACWCdJzGckW7vOXF
ARC-Seal: i=1; a=rsa-sha256; t=1523806526; cv=none;
        d=google.com; s=arc-20160816;
        b=TBvk7ojc2rjlfnELy+gyKe1tqD0fsTi5ea1grt+Y+St48qD3OHKBSyw1xSUvIG1+x3
         RfX9N69rIKfZU2ofo5qYj7kt57nGKUpFpX0OcQOAGIMYtb//eGlRx26JjFsjpVBLWeQZ
         HYiS0vQy+qi1+wAh2fPruvtdTqZKX+fX7w5KDi2gEDKH1z7qxolprRPN0WTqKRAh9FWl
         jvPCR77SnIvArRSyWtpI2Y3qgDdA2RIRc7sUNZ7uazgvNuHetFWPqp945CGSCjEx0Jov
         KECax/ROYxVRnS6mSCn4B6MZERnhDYF2ciDIigZrU7tmzabFIPfQT5ayZZwM0Oy/i1db
         AxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=DETklFswqjG2OknRmsVATeTkxUv+Q13NnRq8GU7YBMs=;
        b=ZKJy5OMdUUqVCMjyNAhOgDQ4oJucowJzM6lYWjRLWtQZUcMAjb7mszmK9Lc8hAbluy
         38uar0c3f+u3GCNLp2rMtpIQqwaLuvOWEkBmJZfr0GaytSyz38PlezELkyk+jI/z96ew
         K3t0Y3zU+ole4Cx4oSy58hD/vpKylh9+1Nv7P2WPJLvd5K5OOzSGKAq4M2UGWJFtV10w
         Zip35ei0rOT1UHUxBMw5yuyOLDsoLPmIiM/P07EUF9Wkfq23DBAWQeo5tlMeIS4O8Dia
         z6Bu2GIO1pftGzokvO/KayMqXoPpDlHNe+1CtErhTDpDgyuPa1rwLBSIE4mPUHtqscLr
         TUJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC2D2176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 16:35:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/14] staging: iio: ad7746: Add comments
Message-ID: <20180415163520.3480439f@archlinux>
In-Reply-To: <1523637411-8531-11-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	<1523637411-8531-11-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649736240015580?=
X-GMAIL-MSGID: =?utf-8?q?1597826952135500417?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 13 Apr 2018 13:36:47 -0300
Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Add comments to clarify some of the calculations made, specially when
> reading or writing values.
>=20
Mostly good, but a few minor comments.

Jonathan

> Signed-off-by: Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar>
> ---
>  drivers/staging/iio/cdc/ad7746.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/a=
d7746.c
> index 05506bf9..ef0ebb5 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -429,6 +429,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
>  			goto out;
>  		}
> =20
> +		/* 2^16 in micro */
I'm not seeing the connection...  what is 2^16?

>  		val =3D (val2 * 1024) / 15625;
> =20
>  		switch (chan->type) {
> @@ -554,6 +555,13 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			goto out;
> =20
> +		/*
> +		 * Either for Capacitance, Voltage or Temperature,
> +		 * the 0x000000 code represents negative full scale,
> +		 * the 0x800000 code represents zero scale, and
> +		 * the 0xFFFFFF code represents positive full scale.
> +		 */
> +
>  		*val =3D (be32_to_cpu(chip->data.d32) & 0xFFFFFF) - 0x800000;
> =20
>  		switch (chan->type) {
> @@ -565,7 +573,13 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  			*val =3D (*val * 125) / 256;
>  			break;
>  		case IIO_VOLTAGE:
> -			if (chan->channel =3D=3D 1) /* supply_raw*/
> +
> +			/*
> +			 * The voltage from the VDD pin is internally
> +			 * attenuated by 6.
> +			 */
> +
> +			if (chan->channel =3D=3D 1) /* supply_raw */
>  				*val =3D *val * 6;
>  			break;
>  		default:
> @@ -606,6 +620,13 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  		ret =3D IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
> +
> +		/*
> +		 * CAPDAC Scale =3D 21pF_typ / 127
> +		 * CIN Scale =3D 8.192pF / 2^24
> +		 * Offset Scale =3D CAPDAC Scale / CIN Scale =3D 338646
> +		 */
I don't think the following blank line does much other than make
it less clear what the comment is about.

Same in other locations. Allow the absence of a blank line on one
side of the comment to indicate it's association.


> +
>  		*val =3D AD7746_CAPDAC_DACP(chip->capdac[chan->channel]
>  					  [chan->differential]) * 338646;
> =20
> @@ -614,13 +635,13 @@ static int ad7746_read_raw(struct iio_dev *indio_de=
v,
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_CAPACITANCE:
> -			/* 8.192pf / 2^24 */
> +			/* CIN Scale: 8.192pf / 2^24 */
>  			*val =3D  0;
>  			*val2 =3D 488;
>  			ret =3D IIO_VAL_INT_PLUS_NANO;
>  			break;
>  		case IIO_VOLTAGE:
> -			/* 1170mV / 2^23 */
> +			/* VIN Scale: 1170mV / 2^23 */
>  			*val =3D 1170;
>  			*val2 =3D 23;
>  			ret =3D IIO_VAL_FRACTIONAL_LOG2;
> @@ -674,7 +695,8 @@ static struct ad7746_platform_data *ad7746_parse_dt(s=
truct device *dev)
>  	unsigned int tmp;
>  	int ret;
> =20
> -	/* The default excitation outputs are not inverted, it should be stated
> +	/*
> +	 * The default excitation outputs are not inverted, it should be stated
>  	 * in the dt if needed.
>  	 */
> =20
> @@ -685,7 +707,7 @@ static struct ad7746_platform_data *ad7746_parse_dt(s=
truct device *dev)
>  	ret =3D of_property_read_u32(np, "adi,exclvl", &tmp);
>  	if (ret || tmp > 3) {
>  		dev_warn(dev, "Wrong exclvl value, using default\n");
> -		pdata->exclvl =3D 3; /* default value */
> +		pdata->exclvl =3D 3;
>  	} else {
>  		pdata->exclvl =3D tmp;
>  	}
