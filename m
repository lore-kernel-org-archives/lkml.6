Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3678177-1521367148-2-7589830425871659611
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roenca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521367147; b=WPgJrRCOnARrD1XPz+q7N69UOUscqmSAO7/4d3deHPcNvKj
    /x6sTjLUBHagf2u0DfHe8I9l5ElpX0wsyFZPBY1QXfC9CVCGp9oC4E6CIdTp/SX5
    0yXo8K3iP2opesdTk6V6B3hVTXMQGTpaGJAUnHa2G9xQU3/W2VwZkOD6qIV6pRxG
    CFIUVqF0A7Lr2fIZ5YKDDX8UU+lV2mfSG+SnR7Ykr2otwGFYYXAAyovEqTl35POt
    Ms/ljFSwpOrP48toIVDMGhxCaHQJa0KoRvgKj76mTAxuDtfaiEhiZigiYaWqkJST
    imOo+f4ZgLjs30Nrj8tifEDlAYBnG9jJHJEEjmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521367147; bh=r
    AUy7FX9e38sapjnOMD5n+Qana08DxmgyFnJXd7/pFE=; b=V9pKHV0cm+TvpoWAG
    6ZeoneBwpmScYIVd1xxW1BG3ffRaDZUpKgFY++kzJ2LqphadV5WGAkAsDP5RAwTa
    W1Q9qxNaqtPt2tSNSC7pF0KZZUuaOUKHaNn8pNmMbGbXInEp+vmFsW/PD7d8d4f+
    6Cn9Ra3tqzcRf7eEqv1EGrg+4kr6Ad8o3OCqOnBm2fRtg63e3FELX1bVzj7gtlsB
    U/NaZZkqCV0h7gKqncfzzRQ/sYJZYXu/i9iOnuCTnXTp67Vcg6NLWkXX7AdqvVoB
    lXJa7jbZrzd8SuCfhldb+9R7tVh77a6vIwNwHVtHamod9Dkg9ahY3AXqTcEhJavO
    9Wawg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
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
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B09C20838
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 18 Mar 2018 09:58:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH v2 5/8] staging:iio:ade7854: Replace many functions for
 one function
Message-ID: <20180318095854.00e67d31@archlinux>
In-Reply-To: <518e40bdf740819b7ca0e5d8dc5a5756337a3bd8.1521239766.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
 <518e40bdf740819b7ca0e5d8dc5a5756337a3bd8.1521239766.git.rodrigosiqueiramelo@gmail.com>
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

On Fri, 16 Mar 2018 19:49:40 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> This patch removes code duplications related to the write_reg_*
> functions and centralizes them in a single function. Also, it eliminates
> the legacy functions and replaces them by a unique signature that is
> used by SPI and I2C.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Makes sense and a nice reduction in lines of code.

Will pick up once the precursors are ready.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/meter/ade7854-i2c.c | 33 +--------------------------------
>  drivers/staging/iio/meter/ade7854-spi.c | 33 +--------------------------------
>  drivers/staging/iio/meter/ade7854.c     | 12 ++++++------
>  drivers/staging/iio/meter/ade7854.h     |  9 ++++-----
>  4 files changed, 12 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index 1daad42b1e92..e95147a1bac1 100644
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
> -	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_8_BITS);
> -}
> -
> -static int ade7854_i2c_write_reg_16(struct device *dev,
> -				    u16 reg_address,
> -				    u16 val)
> -{
> -	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_16_BITS);
> -}
> -
> -static int ade7854_i2c_write_reg_24(struct device *dev,
> -				    u16 reg_address,
> -				    u32 val)
> -{
> -	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_24_BITS);
> -}
> -
> -static int ade7854_i2c_write_reg_32(struct device *dev,
> -				    u16 reg_address,
> -				    u32 val)
> -{
> -	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_32_BITS);
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
> index f21dc24194fb..1eba3044b86f 100644
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
> -	return ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_8_BITS);
> -}
> -
> -static int ade7854_spi_write_reg_16(struct device *dev,
> -				    u16 reg_address,
> -				    u16 val)
> -{
> -	return ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_16_BITS);
> -}
> -
> -static int ade7854_spi_write_reg_24(struct device *dev,
> -				    u16 reg_address,
> -				    u32 val)
> -{
> -	return ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_24_BITS);
> -}
> -
> -static int ade7854_spi_write_reg_32(struct device *dev,
> -				    u16 reg_address,
> -				    u32 val)
> -{
> -	return ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_32_BITS);
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
> index 0193ae3aae29..4aa7c6ce0016 100644
> --- a/drivers/staging/iio/meter/ade7854.c
> +++ b/drivers/staging/iio/meter/ade7854.c
> @@ -105,7 +105,7 @@ static ssize_t ade7854_write_8bit(struct device *dev,
>  	ret = kstrtou8(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
> -	ret = st->write_reg_8(dev, this_attr->address, val);
> +	ret = st->write_reg(dev, this_attr->address, val, DATA_SIZE_8_BITS);
>  
>  error_ret:
>  	return ret ? ret : len;
> @@ -126,7 +126,7 @@ static ssize_t ade7854_write_16bit(struct device *dev,
>  	ret = kstrtou16(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
> -	ret = st->write_reg_16(dev, this_attr->address, val);
> +	ret = st->write_reg(dev, this_attr->address, val, DATA_SIZE_16_BITS);
>  
>  error_ret:
>  	return ret ? ret : len;
> @@ -147,7 +147,7 @@ static ssize_t ade7854_write_24bit(struct device *dev,
>  	ret = kstrtou32(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
> -	ret = st->write_reg_24(dev, this_attr->address, val);
> +	ret = st->write_reg(dev, this_attr->address, val, DATA_SIZE_24_BITS);
>  
>  error_ret:
>  	return ret ? ret : len;
> @@ -168,7 +168,7 @@ static ssize_t ade7854_write_32bit(struct device *dev,
>  	ret = kstrtou32(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
> -	ret = st->write_reg_32(dev, this_attr->address, val);
> +	ret = st->write_reg(dev, this_attr->address, val, DATA_SIZE_32_BITS);
>  
>  error_ret:
>  	return ret ? ret : len;
> @@ -183,7 +183,7 @@ static int ade7854_reset(struct device *dev)
>  	st->read_reg_16(dev, ADE7854_CONFIG, &val);
>  	val |= BIT(7); /* Software Chip Reset */
>  
> -	return st->write_reg_16(dev, ADE7854_CONFIG, val);
> +	return st->write_reg(dev, ADE7854_CONFIG, val, DATA_SIZE_16_BITS);
>  }
>  
>  static IIO_DEV_ATTR_AIGAIN(0644,
> @@ -426,7 +426,7 @@ static int ade7854_set_irq(struct device *dev, bool enable)
>  	else
>  		irqen &= ~BIT(17);
>  
> -	return st->write_reg_32(dev, ADE7854_MASK0, irqen);
> +	return st->write_reg(dev, ADE7854_MASK0, irqen, DATA_SIZE_32_BITS);
>  }
>  
>  static int ade7854_initial_setup(struct iio_dev *indio_dev)
> diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
> index 71bdd638f348..aa29faf7c91f 100644
> --- a/drivers/staging/iio/meter/ade7854.h
> +++ b/drivers/staging/iio/meter/ade7854.h
> @@ -152,7 +152,8 @@ enum data_size {
>  
>  /**
>   * struct ade7854_state - device instance specific data
> - * @spi:			actual spi_device
> + * @spi:		actual spi_device
> + * @write_reg		Wrapper function for I2C and SPI write
>   * @indio_dev:		industrial I/O device structure
>   * @buf_lock:		mutex to protect tx and rx
>   * @tx:			transmit buffer
> @@ -165,10 +166,8 @@ struct ade7854_state {
>  	int (*read_reg_16)(struct device *dev, u16 reg_address, u16 *val);
>  	int (*read_reg_24)(struct device *dev, u16 reg_address, u32 *val);
>  	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
> -	int (*write_reg_8)(struct device *dev, u16 reg_address, u8 val);
> -	int (*write_reg_16)(struct device *dev, u16 reg_address, u16 val);
> -	int (*write_reg_24)(struct device *dev, u16 reg_address, u32 val);
> -	int (*write_reg_32)(struct device *dev, u16 reg_address, u32 val);
> +	int (*write_reg)(struct device *dev, u16 reg_address, u32 val,
> +			 int type);
>  	int irq;
>  	struct mutex buf_lock;
>  	u8 tx[ADE7854_MAX_TX] ____cacheline_aligned;

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
