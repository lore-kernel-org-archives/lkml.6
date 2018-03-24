Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3952077-1521897986-2-11828921270344844599
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roenca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521897985; b=X8nrSM934tTRVSBUImUQOGeLlvH/kK6daor97ukxCd8gN3c
    JEHH/svvunfxckBDF/yScaafHzbwZeIBTu0dZ84+Bv1KIZtcLB/CxJzB1vgsp5Hf
    6ySCNqziKrdq8PZKreQhNTgj1wpKo01yLpryt5N6Wq/ecSTNWxfJBpJGL3nIeghV
    27bBdjGR+wjaqwwfq4LhYTK/iWZohHneCktkhsmWlpn+7H1KbnSs7K1EP0QglB76
    CzTJM+FkMPCNxM4261b0SzJb0Ia4kadqKT9ttn/WSjkuxEivj5tiTA4Tb9gk5lwy
    zgQ/Cm14vCiOQyCYjZveQLr5X5AI1tjydXkD2Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521897985; bh=M
    iLnqWMcF9CHQdwxG8QGd3qIODMfKxslyiOVyvzKvrM=; b=EzF1kyRMhrdX5IGo8
    q60YiQRJgy2v5FfNFH+vaMHf63g/IQDGXuf3yOlI0fB4IZ83vqFOVJ09COAmqCV2
    G2Tdovrdc47NmuDyf1rp9KzjkpXr7bicHsdnmolI6vbpGGRFtZr6rb8OJWVVmSpI
    U/gfkehP3GePvX1cYJTaxfHCqqejYeHdRYAzFLlHVUmBk42/5c/ZYcHaDsHsXtWJ
    LrCOAjDqz94j3TPSApBCIiF1aXgSb3ettoOZS63D3eOq5mp4SEBemW108l9cQPBr
    UtSDME0VRbKBQFsqIKnrVDrRDGpJNy24z3EDeIBntN/bexFONs81pH9QZLm5KtZH
    b3xNg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EFC21716
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 13:26:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH v3 5/8] staging:iio:ade7854: Remove write_reg_*
 duplications
Message-ID: <20180324132614.4bbbb419@archlinux>
In-Reply-To: <f653606d784c5b4dd1b502030a4b0ce43df8e913.1521813782.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
 <f653606d784c5b4dd1b502030a4b0ce43df8e913.1521813782.git.rodrigosiqueiramelo@gmail.com>
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

On Fri, 23 Mar 2018 11:26:41 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> This patch removes code duplications related to the write_reg_*
> functions and centralizes them in a single function. Also, it eliminates
> the legacy functions and replaces them by a unique signature that is
> used by SPI and I2C.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Applied, thanks.

Jonathan

> ---
> Changes in v3:
>  - Update commit message
> 
>  drivers/staging/iio/meter/ade7854-i2c.c | 33 +--------------------------------
>  drivers/staging/iio/meter/ade7854-spi.c | 33 +--------------------------------
>  drivers/staging/iio/meter/ade7854.c     | 12 ++++++------
>  drivers/staging/iio/meter/ade7854.h     |  9 ++++-----
>  4 files changed, 12 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index c9f46d26b752..29e959fdb932 100644
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> @@ -65,34 +65,6 @@ static int ade7854_i2c_write_reg(struct device *dev,
>  	return ret < 0 ? ret : 0;
>  }
>  
> -static int ade7854_i2c_write_reg_8(struct device *dev,
> -				   u16 reg_address,
> -				   u8 val)
> -{
> -	return ade7854_i2c_write_reg(dev, reg_address, val, 8);
> -}
> -
> -static int ade7854_i2c_write_reg_16(struct device *dev,
> -				    u16 reg_address,
> -				    u16 val)
> -{
> -	return ade7854_i2c_write_reg(dev, reg_address, val, 16);
> -}
> -
> -static int ade7854_i2c_write_reg_24(struct device *dev,
> -				    u16 reg_address,
> -				    u32 val)
> -{
> -	return ade7854_i2c_write_reg(dev, reg_address, val, 24);
> -}
> -
> -static int ade7854_i2c_write_reg_32(struct device *dev,
> -				    u16 reg_address,
> -				    u32 val)
> -{
> -	return ade7854_i2c_write_reg(dev, reg_address, val, 32);
> -}
> -
>  static int ade7854_i2c_read_reg_8(struct device *dev,
>  				  u16 reg_address,
>  				  u8 *val)
> @@ -213,10 +185,7 @@ static int ade7854_i2c_probe(struct i2c_client *client,
>  	st->read_reg_16 = ade7854_i2c_read_reg_16;
>  	st->read_reg_24 = ade7854_i2c_read_reg_24;
>  	st->read_reg_32 = ade7854_i2c_read_reg_32;
> -	st->write_reg_8 = ade7854_i2c_write_reg_8;
> -	st->write_reg_16 = ade7854_i2c_write_reg_16;
> -	st->write_reg_24 = ade7854_i2c_write_reg_24;
> -	st->write_reg_32 = ade7854_i2c_write_reg_32;
> +	st->write_reg = ade7854_i2c_write_reg;
>  	st->i2c = client;
>  	st->irq = client->irq;
>  
> diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
> index 9c5c16c4d6e0..be7397042850 100644
> --- a/drivers/staging/iio/meter/ade7854-spi.c
> +++ b/drivers/staging/iio/meter/ade7854-spi.c
> @@ -67,34 +67,6 @@ static int ade7854_spi_write_reg(struct device *dev,
>  	return ret;
>  }
>  
> -static int ade7854_spi_write_reg_8(struct device *dev,
> -				   u16 reg_address,
> -				   u8 val)
> -{
> -	return ade7854_spi_write_reg(dev, reg_address, val, 8);
> -}
> -
> -static int ade7854_spi_write_reg_16(struct device *dev,
> -				    u16 reg_address,
> -				    u16 val)
> -{
> -	return ade7854_spi_write_reg(dev, reg_address, val, 16);
> -}
> -
> -static int ade7854_spi_write_reg_24(struct device *dev,
> -				    u16 reg_address,
> -				    u32 val)
> -{
> -	return ade7854_spi_write_reg(dev, reg_address, val, 24);
> -}
> -
> -static int ade7854_spi_write_reg_32(struct device *dev,
> -				    u16 reg_address,
> -				    u32 val)
> -{
> -	return ade7854_spi_write_reg(dev, reg_address, val, 32);
> -}
> -
>  static int ade7854_spi_read_reg_8(struct device *dev,
>  				  u16 reg_address,
>  				  u8 *val)
> @@ -260,10 +232,7 @@ static int ade7854_spi_probe(struct spi_device *spi)
>  	st->read_reg_16 = ade7854_spi_read_reg_16;
>  	st->read_reg_24 = ade7854_spi_read_reg_24;
>  	st->read_reg_32 = ade7854_spi_read_reg_32;
> -	st->write_reg_8 = ade7854_spi_write_reg_8;
> -	st->write_reg_16 = ade7854_spi_write_reg_16;
> -	st->write_reg_24 = ade7854_spi_write_reg_24;
> -	st->write_reg_32 = ade7854_spi_write_reg_32;
> +	st->write_reg = ade7854_spi_write_reg;
>  	st->irq = spi->irq;
>  	st->spi = spi;
>  
> diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> index 0193ae3aae29..45984b9a2bee 100644
> --- a/drivers/staging/iio/meter/ade7854.c
> +++ b/drivers/staging/iio/meter/ade7854.c
> @@ -105,7 +105,7 @@ static ssize_t ade7854_write_8bit(struct device *dev,
>  	ret = kstrtou8(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
> -	ret = st->write_reg_8(dev, this_attr->address, val);
> +	ret = st->write_reg(dev, this_attr->address, val, 8);
>  
>  error_ret:
>  	return ret ? ret : len;
> @@ -126,7 +126,7 @@ static ssize_t ade7854_write_16bit(struct device *dev,
>  	ret = kstrtou16(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
> -	ret = st->write_reg_16(dev, this_attr->address, val);
> +	ret = st->write_reg(dev, this_attr->address, val, 16);
>  
>  error_ret:
>  	return ret ? ret : len;
> @@ -147,7 +147,7 @@ static ssize_t ade7854_write_24bit(struct device *dev,
>  	ret = kstrtou32(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
> -	ret = st->write_reg_24(dev, this_attr->address, val);
> +	ret = st->write_reg(dev, this_attr->address, val, 24);
>  
>  error_ret:
>  	return ret ? ret : len;
> @@ -168,7 +168,7 @@ static ssize_t ade7854_write_32bit(struct device *dev,
>  	ret = kstrtou32(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
> -	ret = st->write_reg_32(dev, this_attr->address, val);
> +	ret = st->write_reg(dev, this_attr->address, val, 32);
>  
>  error_ret:
>  	return ret ? ret : len;
> @@ -183,7 +183,7 @@ static int ade7854_reset(struct device *dev)
>  	st->read_reg_16(dev, ADE7854_CONFIG, &val);
>  	val |= BIT(7); /* Software Chip Reset */
>  
> -	return st->write_reg_16(dev, ADE7854_CONFIG, val);
> +	return st->write_reg(dev, ADE7854_CONFIG, val, 16);
>  }
>  
>  static IIO_DEV_ATTR_AIGAIN(0644,
> @@ -426,7 +426,7 @@ static int ade7854_set_irq(struct device *dev, bool enable)
>  	else
>  		irqen &= ~BIT(17);
>  
> -	return st->write_reg_32(dev, ADE7854_MASK0, irqen);
> +	return st->write_reg(dev, ADE7854_MASK0, irqen, 32);
>  }
>  
>  static int ade7854_initial_setup(struct iio_dev *indio_dev)
> diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
> index a82d38224cbd..290adbf56951 100644
> --- a/drivers/staging/iio/meter/ade7854.h
> +++ b/drivers/staging/iio/meter/ade7854.h
> @@ -145,7 +145,8 @@
>  
>  /**
>   * struct ade7854_state - device instance specific data
> - * @spi:			actual spi_device
> + * @spi:		actual spi_device
> + * @write_reg		Wrapper function for I2C and SPI write
>   * @indio_dev:		industrial I/O device structure
>   * @buf_lock:		mutex to protect tx and rx
>   * @tx:			transmit buffer
> @@ -158,10 +159,8 @@ struct ade7854_state {
>  	int (*read_reg_16)(struct device *dev, u16 reg_address, u16 *val);
>  	int (*read_reg_24)(struct device *dev, u16 reg_address, u32 *val);
>  	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
> -	int (*write_reg_8)(struct device *dev, u16 reg_address, u8 val);
> -	int (*write_reg_16)(struct device *dev, u16 reg_address, u16 val);
> -	int (*write_reg_24)(struct device *dev, u16 reg_address, u32 val);
> -	int (*write_reg_32)(struct device *dev, u16 reg_address, u32 val);
> +	int (*write_reg)(struct device *dev, u16 reg_address, u32 val,
> +			 int bits);
>  	int irq;
>  	struct mutex buf_lock;
>  	u8 tx[ADE7854_MAX_TX] ____cacheline_aligned;

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
