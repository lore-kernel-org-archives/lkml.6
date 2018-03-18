Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3678177-1521366978-2-18385725205203329557
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521366977; b=gmz5wX/hgW45o9s73I9gfm6XT3BkJ4Biqy9A0hoxFZgZvbr
    16gs1cbBW66xj8l9N2lBeYwqkgMjwLbwopX/N+pQTUVLryAeVKUG5iKnqGPSoFl5
    rMH2hn08tF8pmTDAKYwtTZwlPmseAHd2FjiWXqD2Z7X8tggDMt81GCHH1LC550wf
    fBNs5XW0aqgkdrBSlZ0vrGKfgTNnJGfsFilpTG0tbDxFplF6DyiueN9YbSviCOFx
    nHxmixFpnSC/joHihdUUl5/AnAPw/aFWlKoKY43RTJ0Eatj5Y6eR0rD0j6Uujd+S
    FgBPqSzTGCpBm/q2ClCZkVzATBg7Kn7oYSqkV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521366977; bh=H
    ZjQTvbLPaqvW61SQkKMrOaGhml+A7AnH2vrL7kbUc4=; b=MMOEcTv+liTfMLcBm
    /sSOHivp6foPs3JpVs1k21tPDwX33VePmMzhIq9cDr/FEKT6UanWhOm9xh0WxgCw
    alv12JS2/0vjS8ToPOQA5lOjRPAl9jcB5dvq/Bn8CphPFZydW6xTZHvWpe305O9a
    QkAsm2IAB7aR7Til6TowgxjndDstGeBQhUn7dbWEUCJhatjqTRFFzWahPWYMLTJs
    241cqMp6gujqZSqZ1PsxcjZcV4MTmwmtdaCU2nw1hhW2LRWrr4oLBXbEjHc+g0zc
    a3JotnkvKMDCex3+sRzCOFqHgyrly781UAy4euxA1hKDTch/ytPlWmouCKb5xiPm
    /PYxA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D565B20838
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 18 Mar 2018 09:56:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH v2 3/8] staging:iio:ade7854: Rework I2C write function
Message-ID: <20180318095604.72efed73@archlinux>
In-Reply-To: <d739c0eb2843e7b7d6251d6d805d3874e598cbcc.1521239766.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
 <d739c0eb2843e7b7d6251d6d805d3874e598cbcc.1521239766.git.rodrigosiqueiramelo@gmail.com>
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

On Fri, 16 Mar 2018 19:49:08 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The write operation using I2C has many code duplications and four
> different interfaces per data size. This patch introduces a single
> function that centralizes the main tasks.
> 
> The central function inserted by this patch can easily replace all the
> four functions related to the data size. However, this patch does not
> remove any code signature for keeping the meter module work and make
> easier to review this patch.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
>  drivers/staging/iio/meter/ade7854-i2c.c | 96 ++++++++++++++++-----------------
>  drivers/staging/iio/meter/ade7854.h     |  7 +++
>  2 files changed, 53 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index 37c957482493..1daad42b1e92 100644
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> @@ -15,86 +15,82 @@
>  #include <linux/iio/iio.h>
>  #include "ade7854.h"
>  
> -static int ade7854_i2c_write_reg_8(struct device *dev,
> -				   u16 reg_address,
> -				   u8 val)
> +static int ade7854_i2c_write_reg(struct device *dev,
> +				 u16 reg_address,
> +				 u32 val,
> +				 int bytes)
>  {
>  	int ret;
> +	int count;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
>  
>  	mutex_lock(&st->buf_lock);
>  	st->tx[0] = (reg_address >> 8) & 0xFF;
>  	st->tx[1] = reg_address & 0xFF;
There are a lot of endian conversions in here, but as some aren't
standard sizes (24 bits) and others are unaligned which makes things
messy, perhaps we are better doing it 'long hand' like this.

> -	st->tx[2] = val;
>  
> -	ret = i2c_master_send(st->i2c, st->tx, 3);
> +	switch (bytes) {
> +	case DATA_SIZE_8_BITS:

The defines really don't help here.  These are real numbers
so have them as such.

> +		st->tx[2] = val & 0xFF;
> +		count = 3;
> +		break;
> +	case DATA_SIZE_16_BITS:
> +		st->tx[2] = (val >> 8) & 0xFF;
> +		st->tx[3] = val & 0xFF;
> +		count = 4;
> +		break;
> +	case DATA_SIZE_24_BITS:
> +		st->tx[2] = (val >> 16) & 0xFF;
> +		st->tx[3] = (val >> 8) & 0xFF;
> +		st->tx[4] = val & 0xFF;
> +		count = 5;
> +		break;
> +	case DATA_SIZE_32_BITS:
> +		st->tx[2] = (val >> 24) & 0xFF;
> +		st->tx[3] = (val >> 16) & 0xFF;
> +		st->tx[4] = (val >> 8) & 0xFF;
> +		st->tx[5] = val & 0xFF;
> +		count = 6;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	ret = i2c_master_send(st->i2c, st->tx, count);
> +
> +unlock:
>  	mutex_unlock(&st->buf_lock);
>  
>  	return ret < 0 ? ret : 0;
>  }
>  
> +static int ade7854_i2c_write_reg_8(struct device *dev,
> +				   u16 reg_address,
> +				   u8 val)
> +{
> +	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_8_BITS);
> +}
> +
>  static int ade7854_i2c_write_reg_16(struct device *dev,
>  				    u16 reg_address,
>  				    u16 val)
>  {
> -	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = (reg_address >> 8) & 0xFF;
> -	st->tx[1] = reg_address & 0xFF;
> -	st->tx[2] = (val >> 8) & 0xFF;
> -	st->tx[3] = val & 0xFF;
> -
> -	ret = i2c_master_send(st->i2c, st->tx, 4);
> -	mutex_unlock(&st->buf_lock);
> -
> -	return ret < 0 ? ret : 0;
> +	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_16_BITS);
>  }
>  
>  static int ade7854_i2c_write_reg_24(struct device *dev,
>  				    u16 reg_address,
>  				    u32 val)
>  {
> -	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = (reg_address >> 8) & 0xFF;
> -	st->tx[1] = reg_address & 0xFF;
> -	st->tx[2] = (val >> 16) & 0xFF;
> -	st->tx[3] = (val >> 8) & 0xFF;
> -	st->tx[4] = val & 0xFF;
> -
> -	ret = i2c_master_send(st->i2c, st->tx, 5);
> -	mutex_unlock(&st->buf_lock);
> -
> -	return ret < 0 ? ret : 0;
> +	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_24_BITS);
>  }
>  
>  static int ade7854_i2c_write_reg_32(struct device *dev,
>  				    u16 reg_address,
>  				    u32 val)
>  {
> -	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = (reg_address >> 8) & 0xFF;
> -	st->tx[1] = reg_address & 0xFF;
> -	st->tx[2] = (val >> 24) & 0xFF;
> -	st->tx[3] = (val >> 16) & 0xFF;
> -	st->tx[4] = (val >> 8) & 0xFF;
> -	st->tx[5] = val & 0xFF;
> -
> -	ret = i2c_master_send(st->i2c, st->tx, 6);
> -	mutex_unlock(&st->buf_lock);
> -
> -	return ret < 0 ? ret : 0;
> +	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_32_BITS);
>  }
>  
>  static int ade7854_i2c_read_reg_8(struct device *dev,
> diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
> index a82d38224cbd..71bdd638f348 100644
> --- a/drivers/staging/iio/meter/ade7854.h
> +++ b/drivers/staging/iio/meter/ade7854.h
> @@ -143,6 +143,13 @@
>  #define ADE7854_SPI_BURST	(u32)(1000 * 1000)
>  #define ADE7854_SPI_FAST	(u32)(2000 * 1000)
>  
> +enum data_size {
> +	DATA_SIZE_8_BITS = 1,
> +	DATA_SIZE_16_BITS,
> +	DATA_SIZE_24_BITS,
> +	DATA_SIZE_32_BITS,
> +};
Don't introduce this - these aren't magic numbers so they don't need
'names' to say what they are!

Jonathan
> +
>  /**
>   * struct ade7854_state - device instance specific data
>   * @spi:			actual spi_device

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
