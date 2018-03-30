Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx4/QHb1fYG204HtS2dRCw1t7C05foxz7yVw9nX+cniMwm58qmd9cYaQRcD1FYKRqRD8uwtYw
ARC-Seal: i=1; a=rsa-sha256; t=1522410027; cv=none;
        d=google.com; s=arc-20160816;
        b=LJ/jL96GPKYyhUPp3m6BtJeuQwLO8OwY3+rzyRcqUjSlDJvq5BYb5XbImXMDe0iqsL
         IR2SSGAyGDPCVmVTbitjsebhPw1wl6U5pJSe+JMPpgDSofcvcMRgBV1lnx4sD91g63eE
         F4gebwCkk8H4YS0ZgbHZzw+NZc30aCf3A1bBb6r0LqeCyzHi4eJTZTtTXSg5ugh5NY5n
         NIAAPzLVKLvm9VUQ7ed/K4AqV3APN/is9Rxrel4o+Emnq0hzXcjwa1oxK5DAAbPRbzEM
         F7ouF3vDTVb2Ei+SixgX6as2wfiAmwezn6c6iwyWlAZHYe9OjgjBwNdi2/FnQEr3jhA4
         kx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=n5cV/OZ5N4SaIelrhxESwes03Dm7m0agLKfTY/L36Mc=;
        b=NdVY9oGB/UTR5cBFolfI8iDN6ZJ02dBH+dbljlw/gqLyaAo9ZoPaVw1gRO214XE0Sc
         HOvDactYa3JJ6pC8Kf2l9KQKJ1J6rorGi2sAkwKWq5kRkWttiLy7+UohNAiikQiDW/aX
         y3wTvRvHlsgpQpkNXSbMMdQC+5qncO5mPB0tUIGaDEkQu/9xtUKkqybgBRf3ogTJHcSe
         pmk074PSqmr/gPEfbi4oltOZlXBHWaxrRw6wJzLSA/lPgSzuZkgFJZmu50t3iYjkIFDw
         A58tbmo7K17sH7oug2BrhmIfXhEJFNnpcs8mWmNMn876fMQV45vQoUHZzYWZAH4rkMfy
         ZtmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33892175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Fri, 30 Mar 2018 12:40:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, daniel.baluta@gmail.com
Subject: Re: [PATCH v6 5/6] Staging: iio: adis16209: Use GENMASK
Message-ID: <20180330124021.1c6c30ca@archlinux>
In-Reply-To: <5d43c34c95f3b58f5b79254ae67bf7a080f39a92.1522306893.git.shreeya.patel23498@gmail.com>
References: <cover.1522306893.git.shreeya.patel23498@gmail.com>
	<5d43c34c95f3b58f5b79254ae67bf7a080f39a92.1522306893.git.shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596263271575055134?=
X-GMAIL-MSGID: =?utf-8?q?1596362617301523916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 29 Mar 2018 14:51:19 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Use GENMASK to improve readability and remove the local
> variables used to store intermediate data.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
See below.

Fixed up and applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
> Changes in v6
>   -Introduce this new patch in the series.
> 
>  drivers/staging/iio/accel/adis16209.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index ed6d7c7..cc50667 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -112,25 +112,22 @@ static int adis16209_write_raw(struct iio_dev *indio_dev,
>  			       long mask)
>  {
>  	struct adis *st = iio_priv(indio_dev);
> -	int bits;
> -	s16 val16;
> -	u8 addr;
> +	int m;
> +
> +	if (mask != IIO_CHAN_INFO_CALIBBIAS)
> +		return -EINVAL;
>  
> -	switch (mask) {
> -	case IIO_CHAN_INFO_CALIBBIAS:
Looks to me like the indenting is now incorrect.
The next block should be one less tab in.

>  		switch (chan->type) {
>  		case IIO_ACCEL:
>  		case IIO_INCLI:
> -			bits = 14;
> +			m = GENMASK(13, 0);
>  			break;
>  		default:
>  			return -EINVAL;
>  		}
> -		val16 = val & ((1 << bits) - 1);
> -		addr = adis16209_addresses[chan->scan_index][0];
> -		return adis_write_reg_16(st, addr, val16);
> -	}
> -	return -EINVAL;
> +
> +	return adis_write_reg_16(st, adis16209_addresses[chan->scan_index][0],
> +				 val & m);
>  }
>  
>  static int adis16209_read_raw(struct iio_dev *indio_dev,
