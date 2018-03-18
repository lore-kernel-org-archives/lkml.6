Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3678177-1521367560-2-14118858264972645794
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521367559; b=GJw6LjIFlxPXz/316BXitdU1c1akYqVO6QkLRyt3ZTtHzyx
    fijnqGF7MnXp9e5w3+2p3G5rIBVvxPwv9bkbHVw9Sj5NXV2mrVvfvg+GJHV/VS6D
    g1V3rxs5GBzp4USsK/m1GcjcVpTeY3xVSlP0l69cd9OfmRt00vbB2LXSBvtVun0X
    yE9qkpMO6ExE83e4VB+/sSo5RMcvU0ETRSiJVH7wv7GZQL230ksF4HxXoB98iSNZ
    +tCQRiJm9wBZhO078flbJB7kFTNIsnGmmC0gU5bToNJYAqe3kIHvKvm2sPSiHdFO
    usDDlvrJlNxhIRe8xyXza9bYwEkPHkQ1rNT/3jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521367559; bh=6
    w4yu3XNd9Laqrfnc6St7m/ydf4gX32M1nnfU1KpU3Q=; b=M7bH0HBYeD0krkyny
    DD6nukwlAH8/aMpS7MPZZqUCfsVl1QsqBisp4TMnrBmE9/CHKbh9CC2xyFQad5BN
    JmRhOU8n+2bESY5VciE6SDKZKPUEhnrDPKYHiZ67qKiGtLY0240YDEb0OvQ/VX9g
    tGjfTdB9AwhSUJoRgn7x1iphFn0q1ikYhNG4buGLLFfCxzPCWDKePYunEyvJ8fgD
    kC7OibjONH4ZJzC6YUonkKQxjPAJwiFfONtr4Sz9sPN9EU0NJwXM4MRA/aSx7lNT
    tMMsj1tjeb5K/JPnwFE/tfSb5tu3BjDkC6l67uJ6N0/gYJDXw0U2ImDcyPPSuuiM
    tppkQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E85420685
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 18 Mar 2018 10:05:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH v2 8/8] staging:iio:ade7854: Remove read_reg_* duplications
Message-ID: <20180318100547.11d52bd4@archlinux>
In-Reply-To: <dce9761d7477287e8b4d043695c064c97859ec58.1521239766.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
 <dce9761d7477287e8b4d043695c064c97859ec58.1521239766.git.rodrigosiqueiramelo@gmail.com>
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

On Fri, 16 Mar 2018 19:50:29 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The original code had a read function per data size; after updates, all
> read functions tasks were centralized in a single function, but the old
> signature was kept to maintain the module working without problems. This
> patch removes a set of duplications associated with read_reg_*, and
> update the areas that calling the old interface by the new one. During
> the update for use a single function, some errors handlings were updated
> based on the John Syne patches.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Signed-off-by: John Syne <john3909@gmail.com>
The meaning of John's signed-off-by here needs clarifying..

Also fix up the common on error handling as I believe you now do that in
an earlier patch.

Thanks and looking forward to v3.  This is a nice little bit of cleanup.
These weird devices with variable register sizes are always somewhat of
a pain to deal with.

Jonathan

> ---
>  drivers/staging/iio/meter/ade7854-i2c.c | 37 +------------------------------
>  drivers/staging/iio/meter/ade7854-spi.c | 39 ++-------------------------------
>  drivers/staging/iio/meter/ade7854.c     | 18 +++++++--------
>  drivers/staging/iio/meter/ade7854.h     |  7 +++---
>  4 files changed, 15 insertions(+), 86 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index 20db8eedb84a..162c171a8851 100644
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> @@ -110,38 +110,6 @@ static int ade7854_i2c_read_reg(struct device *dev,
>  	return ret;
>  }
>  
> -static int ade7854_i2c_read_reg_8(struct device *dev,
> -				  u16 reg_address,
> -				  u8 *val)
> -{
> -	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
> -				    DATA_SIZE_8_BITS);
> -}
> -
> -static int ade7854_i2c_read_reg_16(struct device *dev,
> -				   u16 reg_address,
> -				   u16 *val)
> -{
> -	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
> -				    DATA_SIZE_16_BITS);
> -}
> -
> -static int ade7854_i2c_read_reg_24(struct device *dev,
> -				   u16 reg_address,
> -				   u32 *val)
> -{
> -	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
> -				    DATA_SIZE_24_BITS);
> -}
> -
> -static int ade7854_i2c_read_reg_32(struct device *dev,
> -				   u16 reg_address,
> -				   u32 *val)
> -{
> -	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
> -				    DATA_SIZE_32_BITS);
> -}
> -
>  static int ade7854_i2c_probe(struct i2c_client *client,
>  			     const struct i2c_device_id *id)
>  {
> @@ -153,10 +121,7 @@ static int ade7854_i2c_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  	st = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
> -	st->read_reg_8 = ade7854_i2c_read_reg_8;
> -	st->read_reg_16 = ade7854_i2c_read_reg_16;
> -	st->read_reg_24 = ade7854_i2c_read_reg_24;
> -	st->read_reg_32 = ade7854_i2c_read_reg_32;
> +	st->read_reg = ade7854_i2c_read_reg;
>  	st->write_reg = ade7854_i2c_write_reg;
>  	st->i2c = client;
>  	st->irq = client->irq;
> diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
> index 964d6c6e76d1..66b8a8767a26 100644
> --- a/drivers/staging/iio/meter/ade7854-spi.c
> +++ b/drivers/staging/iio/meter/ade7854-spi.c
> @@ -94,7 +94,7 @@ static int ade7854_spi_read_reg(struct device *dev,
>  	st->tx[2] = reg_address & 0xFF;
>  
>  	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> -	if (ret) {
> +	if (ret < 0) {
>  		dev_err(&st->spi->dev, "problem when reading register 0x%02X",
>  			reg_address);
>  		goto unlock;
> @@ -120,38 +120,6 @@ static int ade7854_spi_read_reg(struct device *dev,
>  	return ret;
>  }
>  
> -static int ade7854_spi_read_reg_8(struct device *dev,
> -				  u16 reg_address,
> -				  u8 *val)
> -{
> -	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val,
> -				    DATA_SIZE_8_BITS);
> -}
> -
> -static int ade7854_spi_read_reg_16(struct device *dev,
> -				   u16 reg_address,
> -				   u16 *val)
> -{
> -	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val,
> -				    DATA_SIZE_16_BITS);
> -}
> -
> -static int ade7854_spi_read_reg_24(struct device *dev,
> -				   u16 reg_address,
> -				   u32 *val)
> -{
> -	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val,
> -				    DATA_SIZE_24_BITS);
> -}
> -
> -static int ade7854_spi_read_reg_32(struct device *dev,
> -				   u16 reg_address,
> -				   u32 *val)
> -{
> -	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val,
> -				    DATA_SIZE_32_BITS);
> -}
> -
>  static int ade7854_spi_probe(struct spi_device *spi)
>  {
>  	struct ade7854_state *st;
> @@ -162,10 +130,7 @@ static int ade7854_spi_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  	st = iio_priv(indio_dev);
>  	spi_set_drvdata(spi, indio_dev);
> -	st->read_reg_8 = ade7854_spi_read_reg_8;
> -	st->read_reg_16 = ade7854_spi_read_reg_16;
> -	st->read_reg_24 = ade7854_spi_read_reg_24;
> -	st->read_reg_32 = ade7854_spi_read_reg_32;
> +	st->read_reg = ade7854_spi_read_reg;
>  	st->write_reg = ade7854_spi_write_reg;
>  	st->irq = spi->irq;
>  	st->spi = spi;
> diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> index 4aa7c6ce0016..09fd8c067738 100644
> --- a/drivers/staging/iio/meter/ade7854.c
> +++ b/drivers/staging/iio/meter/ade7854.c
> @@ -27,12 +27,12 @@ static ssize_t ade7854_read_8bit(struct device *dev,
>  				 char *buf)
>  {
>  	int ret;
> -	u8 val = 0;
> +	u32 val = 0;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  
> -	ret = st->read_reg_8(dev, this_attr->address, &val);
> +	ret = st->read_reg(dev, this_attr->address, &val, DATA_SIZE_8_BITS);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -44,12 +44,12 @@ static ssize_t ade7854_read_16bit(struct device *dev,
>  				  char *buf)
>  {
>  	int ret;
> -	u16 val = 0;
> +	u32 val = 0;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  
> -	ret = st->read_reg_16(dev, this_attr->address, &val);
> +	ret = st->read_reg(dev, this_attr->address, &val, DATA_SIZE_16_BITS);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -66,7 +66,7 @@ static ssize_t ade7854_read_24bit(struct device *dev,
>  	struct ade7854_state *st = iio_priv(indio_dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  
> -	ret = st->read_reg_24(dev, this_attr->address, &val);
> +	ret = st->read_reg(dev, this_attr->address, &val, DATA_SIZE_24_BITS);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -83,7 +83,7 @@ static ssize_t ade7854_read_32bit(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
>  
> -	ret = st->read_reg_32(dev, this_attr->address, &val);
> +	ret = st->read_reg(dev, this_attr->address, &val, DATA_SIZE_32_BITS);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -178,9 +178,9 @@ static int ade7854_reset(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
> -	u16 val;
> +	u32 val;
>  
> -	st->read_reg_16(dev, ADE7854_CONFIG, &val);
> +	st->read_reg(dev, ADE7854_CONFIG, &val, DATA_SIZE_16_BITS);
>  	val |= BIT(7); /* Software Chip Reset */
>  
>  	return st->write_reg(dev, ADE7854_CONFIG, val, DATA_SIZE_16_BITS);
> @@ -415,7 +415,7 @@ static int ade7854_set_irq(struct device *dev, bool enable)
>  	int ret;
>  	u32 irqen;
>  
> -	ret = st->read_reg_32(dev, ADE7854_MASK0, &irqen);
> +	ret = st->read_reg(dev, ADE7854_MASK0, &irqen, DATA_SIZE_32_BITS);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
> index aa29faf7c91f..78584f01d052 100644
> --- a/drivers/staging/iio/meter/ade7854.h
> +++ b/drivers/staging/iio/meter/ade7854.h
> @@ -153,6 +153,7 @@ enum data_size {
>  /**
>   * struct ade7854_state - device instance specific data
>   * @spi:		actual spi_device
> + * @read_reg		Wrapper function for I2C and SPI read
>   * @write_reg		Wrapper function for I2C and SPI write
>   * @indio_dev:		industrial I/O device structure
>   * @buf_lock:		mutex to protect tx and rx
> @@ -162,10 +163,8 @@ enum data_size {
>  struct ade7854_state {
>  	struct spi_device *spi;
>  	struct i2c_client *i2c;
> -	int (*read_reg_8)(struct device *dev, u16 reg_address, u8 *val);
> -	int (*read_reg_16)(struct device *dev, u16 reg_address, u16 *val);
> -	int (*read_reg_24)(struct device *dev, u16 reg_address, u32 *val);
> -	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
> +	int (*read_reg)(struct device *dev, u16 reg_address, u32 *val,
> +			int type);
>  	int (*write_reg)(struct device *dev, u16 reg_address, u32 val,
>  			 int type);
>  	int irq;

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
