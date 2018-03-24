Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3952077-1521897951-5-6174952613964484337
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521897951; b=cu4AuuTYEakZ493MQrL8jA9DszPGbUIGa1nLEys6Mz/h7Bu
    09/vRPRhTKYecqx+AwVRZ4rUhW8fAZ1+6z2gj5wE+BOD75tba3nChsiW8ZjfbHsV
    N236pnWDpfX098Qtx9mBJl0s/kMVXqUbCiIAxH7TlN5VR90IlxyqCPrZbGVWwQNo
    1NOK/QBaNpvOIJ9XcKaFV6ubv3eS2YK05IsW7w0nlo1L9Taobg82DuBwG37h4bC8
    EdkavXJ8fSMIcwSa/lM1WCqM4f9vMlZi+xiF5wysUfMn6XQ5ICj2P/FFfLMtR+d/
    tsHHhSIjHHL86B4yT0E4C6U/F9pFc9FgEzalRiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521897951; bh=9
    uU2fRMZHlYyFl8AHboUr9oAWG2PyfiN059rwhIkh5s=; b=n8EvkkCtpLLTxSDgc
    oZ9djwPSlxZF9vGEHhfu5W8AfF9+EIvXRM9OSSLrxK3qjSA1QV/nD+tR8Xf6GWR3
    FALjW6m1q2z3Jn3ne3TTavVoQ3IMuCydT+HExpkqeIsEojeZvg4wY8bCSMjN5bII
    FO1JadFQyJzX5tpfO+zEIbuGrZwjfNgI1n2YcK8GWcAWu+LWef8bWoT2P+dcmxIs
    a9bmnsJtwi1Z+eDxrI9O6pu2r9HRzlox16gWXQGjKs/vksBsEWRAUZ81So6Oi25U
    Y0W1DjgCc9uX8GtT+55WqJ2bIJaTW5qvtOYF4pQLGh2+URmQ4w/F5Pi5489ItYTD
    MBU8w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83F321716
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 13:25:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH v3 4/8] staging:iio:ade7854: Rework SPI write function
Message-ID: <20180324132538.0e5cdfeb@archlinux>
In-Reply-To: <23ef49f070426f277ea6883c68c2de94978210f1.1521813782.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
 <23ef49f070426f277ea6883c68c2de94978210f1.1521813782.git.rodrigosiqueiramelo@gmail.com>
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

On Fri, 23 Mar 2018 11:26:25 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The write operation using SPI has a many code duplications (similar to
> I2C) and four different interfaces per data size. This patch introduces
> a single function that centralizes the main task related to SPI.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Applied.

Thanks,

Jonathan

> ---
> Changes in v3:
>  - Remove the use of defines that not improve the readability
>  - Replace variable name "bytes" for "bits"
> 
>  drivers/staging/iio/meter/ade7854-spi.c | 108 ++++++++++++--------------------
>  1 file changed, 41 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
> index 4419b8f06197..9c5c16c4d6e0 100644
> --- a/drivers/staging/iio/meter/ade7854-spi.c
> +++ b/drivers/staging/iio/meter/ade7854-spi.c
> @@ -15,9 +15,10 @@
>  #include <linux/iio/iio.h>
>  #include "ade7854.h"
>  
> -static int ade7854_spi_write_reg_8(struct device *dev,
> -				   u16 reg_address,
> -				   u8 val)
> +static int ade7854_spi_write_reg(struct device *dev,
> +				 u16 reg_address,
> +				 u32 val,
> +				 int bits)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -32,93 +33,66 @@ static int ade7854_spi_write_reg_8(struct device *dev,
>  	st->tx[0] = ADE7854_WRITE_REG;
>  	st->tx[1] = (reg_address >> 8) & 0xFF;
>  	st->tx[2] = reg_address & 0xFF;
> -	st->tx[3] = val & 0xFF;
> +	switch (bits) {
> +	case 8:
> +		st->tx[3] = val & 0xFF;
> +		break;
> +	case 16:
> +		xfer.len = 5;
> +		st->tx[3] = (val >> 8) & 0xFF;
> +		st->tx[4] = val & 0xFF;
> +		break;
> +	case 24:
> +		xfer.len = 6;
> +		st->tx[3] = (val >> 16) & 0xFF;
> +		st->tx[4] = (val >> 8) & 0xFF;
> +		st->tx[5] = val & 0xFF;
> +		break;
> +	case 32:
> +		xfer.len = 7;
> +		st->tx[3] = (val >> 24) & 0xFF;
> +		st->tx[4] = (val >> 16) & 0xFF;
> +		st->tx[5] = (val >> 8) & 0xFF;
> +		st->tx[6] = val & 0xFF;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
>  
>  	ret = spi_sync_transfer(st->spi, &xfer, 1);
> +unlock:
>  	mutex_unlock(&st->buf_lock);
>  
>  	return ret;
>  }
>  
> +static int ade7854_spi_write_reg_8(struct device *dev,
> +				   u16 reg_address,
> +				   u8 val)
> +{
> +	return ade7854_spi_write_reg(dev, reg_address, val, 8);
> +}
> +
>  static int ade7854_spi_write_reg_16(struct device *dev,
>  				    u16 reg_address,
>  				    u16 val)
>  {
> -	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	struct spi_transfer xfer = {
> -		.tx_buf = st->tx,
> -		.bits_per_word = 8,
> -		.len = 5,
> -	};
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = ADE7854_WRITE_REG;
> -	st->tx[1] = (reg_address >> 8) & 0xFF;
> -	st->tx[2] = reg_address & 0xFF;
> -	st->tx[3] = (val >> 8) & 0xFF;
> -	st->tx[4] = val & 0xFF;
> -
> -	ret = spi_sync_transfer(st->spi, &xfer, 1);
> -	mutex_unlock(&st->buf_lock);
> -
> -	return ret;
> +	return ade7854_spi_write_reg(dev, reg_address, val, 16);
>  }
>  
>  static int ade7854_spi_write_reg_24(struct device *dev,
>  				    u16 reg_address,
>  				    u32 val)
>  {
> -	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	struct spi_transfer xfer = {
> -		.tx_buf = st->tx,
> -		.bits_per_word = 8,
> -		.len = 6,
> -	};
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = ADE7854_WRITE_REG;
> -	st->tx[1] = (reg_address >> 8) & 0xFF;
> -	st->tx[2] = reg_address & 0xFF;
> -	st->tx[3] = (val >> 16) & 0xFF;
> -	st->tx[4] = (val >> 8) & 0xFF;
> -	st->tx[5] = val & 0xFF;
> -
> -	ret = spi_sync_transfer(st->spi, &xfer, 1);
> -	mutex_unlock(&st->buf_lock);
> -
> -	return ret;
> +	return ade7854_spi_write_reg(dev, reg_address, val, 24);
>  }
>  
>  static int ade7854_spi_write_reg_32(struct device *dev,
>  				    u16 reg_address,
>  				    u32 val)
>  {
> -	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	struct spi_transfer xfer = {
> -		.tx_buf = st->tx,
> -		.bits_per_word = 8,
> -		.len = 7,
> -	};
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = ADE7854_WRITE_REG;
> -	st->tx[1] = (reg_address >> 8) & 0xFF;
> -	st->tx[2] = reg_address & 0xFF;
> -	st->tx[3] = (val >> 24) & 0xFF;
> -	st->tx[4] = (val >> 16) & 0xFF;
> -	st->tx[5] = (val >> 8) & 0xFF;
> -	st->tx[6] = val & 0xFF;
> -
> -	ret = spi_sync_transfer(st->spi, &xfer, 1);
> -	mutex_unlock(&st->buf_lock);
> -
> -	return ret;
> +	return ade7854_spi_write_reg(dev, reg_address, val, 32);
>  }
>  
>  static int ade7854_spi_read_reg_8(struct device *dev,

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
