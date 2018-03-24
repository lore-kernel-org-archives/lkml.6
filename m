Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3936627-1521898125-2-14134464655164417078
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES rocaen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521898124; b=nwuPY2SgmKkrKU3enIV3CSX5S866Ip/Y25m+oE1sOj9zQwI
    B4JKGi0V4EzZjZQ2Wl5PR1ITzX1j5ykJCAA74FysUKOY1+A+r3CtgtYb22fN8AoD
    DB/fN81r25boRUe6eaEVQ6fTVAIKHX+Olwa6PSKPglfPty3XR4wlmixAeodmYTug
    3zPrc1GUv7I6nCkNCLoyiW2itUfrdqSXZotT+BbrrG1uuosXoBeS+zTZ0mS0/boM
    EgXPm8lnqp4QKK/RBjMN2BGfTwc7rSIZLp7Ntivt/Y6AQgnRH1tSMqfWy0Wc7Rp2
    BaEmhqhfm0DwjH1YueIf5bcXtKTpGbYb0v90TAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521898124; bh=C
    /tvDdI7ixY9YzHtddZW4F1BWcY5R6VHbLJ11evXm7w=; b=n+Tu+DIOdejL0o+OS
    hjuTZg6wkJzcGcrArWpKjw7UEBn4uN0UBzROFK9tFro1eDh1gr3+hGDbZROVLUve
    7jntW86BtHpPZq2onVwEzAWjXtn61x/I2zULEX8NHf6nBJa2bcCyr8/ncKeZ6Crb
    wwpMtxuah7QCqjv8UydqnFbl4UekA+1SV4lQODJQoo/R1PIpPyF6zW88Y28HhVBp
    +kgFcBdNvYdbRx36aXc3jtQqceH3HoU3wHa96dffRxAhVcBXlaamLe1ySrtuUjpj
    xqSpg32JM5oB6x+YB6oyCwu351URs9v/Jw+3Qa/3u+BWljJ9kc8L8yGwylnz3cFK
    jmxZA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6097D21716
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 13:28:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH v3 7/8] staging:iio:ade7854: Rework SPI read function
Message-ID: <20180324132832.4de33872@archlinux>
In-Reply-To: <960df20b2a51e6517e9ccef2b5486ee116f35ba4.1521813782.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
 <960df20b2a51e6517e9ccef2b5486ee116f35ba4.1521813782.git.rodrigosiqueiramelo@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Mar 2018 11:27:12 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> Rework read SPI function to reduce the code duplication and centralizes
> all the task in a single function.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v3:
>  - Remove the use of defines that not improve the readability
>  - Replace variable name "bytes" for "bits"
>  - Update commit message
> 
>  drivers/staging/iio/meter/ade7854-spi.c | 136 ++++++++------------------------
>  1 file changed, 33 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
> index be7397042850..ee6e4d166ece 100644
> --- a/drivers/staging/iio/meter/ade7854-spi.c
> +++ b/drivers/staging/iio/meter/ade7854-spi.c
> @@ -67,9 +67,10 @@ static int ade7854_spi_write_reg(struct device *dev,
>  	return ret;
>  }
>  
> -static int ade7854_spi_read_reg_8(struct device *dev,
> -				  u16 reg_address,
> -				  u8 *val)
> +static int ade7854_spi_read_reg(struct device *dev,
> +				u16 reg_address,
> +				u32 *val,
> +				int bits)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
> @@ -82,7 +83,7 @@ static int ade7854_spi_read_reg_8(struct device *dev,
>  		}, {
>  			.rx_buf = st->rx,
>  			.bits_per_word = 8,
> -			.len = 1,
> +			.len = bits,
>  		}
>  	};
>  
> @@ -94,128 +95,57 @@ static int ade7854_spi_read_reg_8(struct device *dev,
>  
>  	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
>  	if (ret) {
> -		dev_err(&st->spi->dev, "problem when reading 8 bit register 0x%02X",
> +		dev_err(&st->spi->dev, "problem when reading register 0x%02X",
>  			reg_address);
> -		goto error_ret;
> +		goto unlock;
> +	}
> +
> +	switch (bits) {
> +	case 8:
> +		*val = st->rx[0];
> +		break;
> +	case 16:
> +		*val = be16_to_cpup((const __be16 *)st->rx);
> +		break;
> +	case 24:
> +		*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
> +		break;
> +	case 32:
> +		*val = be32_to_cpup((const __be32 *)st->rx);
> +		break;
>  	}
> -	*val = st->rx[0];
>  
> -error_ret:
> +unlock:
>  	mutex_unlock(&st->buf_lock);
>  	return ret;
>  }
>  
> +static int ade7854_spi_read_reg_8(struct device *dev,
> +				  u16 reg_address,
> +				  u8 *val)
> +{
> +	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val, 8);
> +}
> +
>  static int ade7854_spi_read_reg_16(struct device *dev,
>  				   u16 reg_address,
>  				   u16 *val)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	int ret;
> -	struct spi_transfer xfers[] = {
> -		{
> -			.tx_buf = st->tx,
> -			.bits_per_word = 8,
> -			.len = 3,
> -		}, {
> -			.rx_buf = st->rx,
> -			.bits_per_word = 8,
> -			.len = 2,
> -		}
> -	};
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = ADE7854_READ_REG;
> -	st->tx[1] = (reg_address >> 8) & 0xFF;
> -	st->tx[2] = reg_address & 0xFF;
> -
> -	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> -	if (ret) {
> -		dev_err(&st->spi->dev, "problem when reading 16 bit register 0x%02X",
> -			reg_address);
> -		goto error_ret;
> -	}
> -	*val = be16_to_cpup((const __be16 *)st->rx);
> -
> -error_ret:
> -	mutex_unlock(&st->buf_lock);
> -	return ret;
> +	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val, 16);
>  }
>  
>  static int ade7854_spi_read_reg_24(struct device *dev,
>  				   u16 reg_address,
>  				   u32 *val)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	int ret;
> -	struct spi_transfer xfers[] = {
> -		{
> -			.tx_buf = st->tx,
> -			.bits_per_word = 8,
> -			.len = 3,
> -		}, {
> -			.rx_buf = st->rx,
> -			.bits_per_word = 8,
> -			.len = 3,
> -		}
> -	};
> -
> -	mutex_lock(&st->buf_lock);
> -
> -	st->tx[0] = ADE7854_READ_REG;
> -	st->tx[1] = (reg_address >> 8) & 0xFF;
> -	st->tx[2] = reg_address & 0xFF;
> -
> -	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> -	if (ret) {
> -		dev_err(&st->spi->dev, "problem when reading 24 bit register 0x%02X",
> -			reg_address);
> -		goto error_ret;
> -	}
> -	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
> -
> -error_ret:
> -	mutex_unlock(&st->buf_lock);
> -	return ret;
> +	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val, 24);
>  }
>  
>  static int ade7854_spi_read_reg_32(struct device *dev,
>  				   u16 reg_address,
>  				   u32 *val)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	int ret;
> -	struct spi_transfer xfers[] = {
> -		{
> -			.tx_buf = st->tx,
> -			.bits_per_word = 8,
> -			.len = 3,
> -		}, {
> -			.rx_buf = st->rx,
> -			.bits_per_word = 8,
> -			.len = 4,
> -		}
> -	};
> -
> -	mutex_lock(&st->buf_lock);
> -
> -	st->tx[0] = ADE7854_READ_REG;
> -	st->tx[1] = (reg_address >> 8) & 0xFF;
> -	st->tx[2] = reg_address & 0xFF;
> -
> -	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> -	if (ret) {
> -		dev_err(&st->spi->dev, "problem when reading 32 bit register 0x%02X",
> -			reg_address);
> -		goto error_ret;
> -	}
> -	*val = be32_to_cpup((const __be32 *)st->rx);
> -
> -error_ret:
> -	mutex_unlock(&st->buf_lock);
> -	return ret;
> +	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val, 32);
>  }
>  
>  static int ade7854_spi_probe(struct spi_device *spi)

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
