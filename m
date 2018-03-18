Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3678177-1521367038-2-3026945913873399588
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES rocask.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521367037; b=Sfi5G+8E91WHOBqjy+m/8/zyvtKYBAoCneek4S/q2Q+u+3B
    XNnZ+n7H4us5RPjYjF3LiogcbKsCMibdyLkcpYP1wy4c/AFGbLffZIlp2ikcu6ni
    mMhdFqf2W3XbPZr/+Ll6HTZTMJ8fCJ4Je5N0rIzGL+nCt0I/xeQF054vGu1fLJFy
    37/wAnOn0nrsThjdsOsZ+xfo5/LX0Np+oSNCcCY5CFIBXbg5kgIuEQr0TOJ/XfSb
    bIPmmlEooLT2BWC5k/ZUNrh8FB4qdFgEt1J8cs3FOmj1WvXzRh9BSsdoOxFwn+bq
    jmuxoLCxMUW69J+DvYzEwtIArUpO0Up1GpkqQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521367037; bh=9
    Sgg+cIIkKnzXgW8+cFiUvwJnE5MA8gu/InClQbxhX0=; b=htN7pzQUJTKbG8/8R
    MjCVRZsEJFhjS0PkQV2CP5DuPmJn3cxcAFp76Sv1RgFYaYcZ1gNL6Pdp14fupMYU
    OVemJvPLUw2W244YhJ+icmBIFp0gaU/ysJEvhMpcBbMYIugbsCwHt58rCR7RlEvC
    H6ucDxqulgC2UqxuiTtRzJOy3IjjQW1lqO9TYfbtfxKXXUS8S96il2CW4minSXC3
    cbvm/JegdX+3oUBJxLrwGmUkz4SLoVH1h49z6G9Qur9t5uX72S7WspKWdkQKMZOO
    085PCD5TVNHBA7VdDgcR9zb3eMUAcbeOSgiq5jbpPkxCcxV0gqj8zXOFydf7exWq
    peBUA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567C420838
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 18 Mar 2018 09:57:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH v2 4/8] staging:iio:ade7854: Rework SPI write function
Message-ID: <20180318095704.60e93288@archlinux>
In-Reply-To: <66ce9378178c994eb64d19ba3cccc5dbfc64e0ef.1521239766.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
 <66ce9378178c994eb64d19ba3cccc5dbfc64e0ef.1521239766.git.rodrigosiqueiramelo@gmail.com>
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

On Fri, 16 Mar 2018 19:49:24 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The write operation using SPI has a many code duplications (similar to
> I2C) and four different interfaces per data size. This patch introduces
> a single function that centralizes the main task related to SPI.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
A good change, but same comment on the defines as for the i2c case.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/meter/ade7854-spi.c | 108 ++++++++++++--------------------
>  1 file changed, 41 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
> index 4419b8f06197..f21dc24194fb 100644
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
> +				 int bytes)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -32,93 +33,66 @@ static int ade7854_spi_write_reg_8(struct device *dev,
>  	st->tx[0] = ADE7854_WRITE_REG;
>  	st->tx[1] = (reg_address >> 8) & 0xFF;
>  	st->tx[2] = reg_address & 0xFF;
> -	st->tx[3] = val & 0xFF;
> +	switch (bytes) {
> +	case DATA_SIZE_8_BITS:
> +		st->tx[3] = val & 0xFF;
> +		break;
> +	case DATA_SIZE_16_BITS:
> +		xfer.len = 5;
> +		st->tx[3] = (val >> 8) & 0xFF;
> +		st->tx[4] = val & 0xFF;
> +		break;
> +	case DATA_SIZE_24_BITS:
> +		xfer.len = 6;
> +		st->tx[3] = (val >> 16) & 0xFF;
> +		st->tx[4] = (val >> 8) & 0xFF;
> +		st->tx[5] = val & 0xFF;
> +		break;
> +	case DATA_SIZE_32_BITS:
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
> +	return ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_8_BITS);
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
> +	return ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_16_BITS);
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
> +	return ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_24_BITS);
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
> +	return ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_32_BITS);
>  }
>  
>  static int ade7854_spi_read_reg_8(struct device *dev,

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
