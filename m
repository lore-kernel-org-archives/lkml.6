Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx4837jrBn49D757jBPrrpLLSasdIiuuCvsIz8/v4p+qAJZgQzWdYC3B4PZ+/nLYLviR+ehXg
ARC-Seal: i=1; a=rsa-sha256; t=1523804603; cv=none;
        d=google.com; s=arc-20160816;
        b=bGNo0wIH7XQLWfOJDhpc26cjuGSQkISKdn4eH95Y8GpjT9S0v3mkhBrmHK1BgK8g+j
         Y4nsv+qZamwmKFR4vNwrIgMLa/jZRMhj3SQKeNL+X3YTyg+xgUS2EVSe2SimwbTjJl6b
         NBI2oLjeeYaL+YOMUM3ZCT/zu05gjnVwsmKCgzXnzW0Abe6FxQDfyMoQkFByQIWGd5Ox
         gWo/1SVCUxuMD0Un8TYpd8wSwP0EXerlmhHUvtqEt4QmrVgVNfawobusfutdQ/IoCPy3
         k13dikoim9e1z8kYh+nHrJL1vqfNQLM1uN80N6D5mGdavUZVJ2TU9/jLC6h7wMv/sItW
         uYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=ZO1gQugFBDzLa0kLD7VqEtLrSa4dHvuP/4m9n5VkfqQ=;
        b=B9PdpSwFPe31qG2pPcc79wQZzs/VWW1uQ/2O1h69Uc0jTx9ZZg6DQj94BBg6ZUp8wS
         DOuw3EJkXwSPh0rT8288d5ZgmcICZC6xLRy15M514QZz3olbceAbOLeIqpa+5FgeYBIU
         zw+iIYr4n9qXN6LyA7P2bJ8zo3cVcG6ifjM7qtIFz2CoWItuF6iEtMvfbAjLmT20gvJx
         gUrqScZMAz8YI7D9aJUZlzpMNdc+atO8X149XvBJ4MeM0OvgxmFhlpaIsm/rw4PxqyjQ
         /SRwuDZoesLnadWHjoq5h2PvqH9Kq5vxc/LtXcDG/AR7UFsFMd/TTwm2vtFwcaX0zFeW
         /opQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A09C20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 16:03:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] staging: iio: ad7746: Adjust arguments to
 match open parenthesis
Message-ID: <20180415160319.4f0d725c@archlinux>
In-Reply-To: <1523637411-8531-3-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	<1523637411-8531-3-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649684631908375?=
X-GMAIL-MSGID: =?utf-8?q?1597824936575750694?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 13 Apr 2018 13:36:39 -0300
Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Clear a couple more checkpatch.pl CHECKS.
>=20
> Signed-off-by: Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/cdc/ad7746.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/a=
d7746.c
> index 53e28ae..516aa93 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -556,7 +556,8 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  		/* Now read the actual register */
> =20
>  		ret =3D i2c_smbus_read_i2c_block_data(chip->client,
> -			chan->address >> 8, 3, &chip->data.d8[1]);
> +						    chan->address >> 8, 3,
> +						    &chip->data.d8[1]);
> =20
>  		if (ret < 0)
>  			goto out;
> @@ -614,7 +615,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
>  		*val =3D AD7746_CAPDAC_DACP(chip->capdac[chan->channel]
> -			[chan->differential]) * 338646;
> +					  [chan->differential]) * 338646;
> =20
>  		ret =3D IIO_VAL_INT;
>  		break;
