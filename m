Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3678177-1521367265-2-17178833407015702021
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521367264; b=UEv7C0nNPyO6Q2Tb0+RZq0FRzIAMkE77PKHodwVOFrjXsvo
    GkICDb+Ri02o8aRrU61FF/NL6g8vK3HN72g/+JQ4oa6aMktCH5gYUHIWrRYGMNWL
    C55imT6CGxWI6COP1T8L/tAOz5DoihO7bLQp9HkjL4j+i5V7rEn8uZ56APPm2vni
    +iGMltFf7/HvAPUVBCk2b48qYSWFbkNoEy+WXrfYkIJ3IyNa9BvqI4cp8jRDphmF
    XorT+fj85VOrLANawGRPFbh1jrlrc4dI0AW0yeA9VWqaHlHLQyQ6bICjitH1M6Bb
    kGKnzFIgUkX4xCDAlX0E4bRzxE10vYYifcbY2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521367264; bh=U
    Ps1stXUlu7o2GsdSYDLzFiFlLcTqFfLGKsP7W8Z6nQ=; b=Dy5h3l3FdngRGSHXo
    K25kPsE+18XnfGMdIcFy2f3ayiqaRxilaAkiUa5y69LHebkKfp0zbzyfAxvnvyiS
    vTxtyOWtmB6aVnNBuDdR4B3ahD/V+9BP9hm+PJL9qyzSDob3+leeR9Mm1Ga0xNb+
    qHxYG1DbVzkQ7aRK14vLxgKnRgsaEtHIQQg+fmm0wTgq9HyUZfkAqx9HmN6nbbQX
    7G6+9pSTfdw0AHl2A+Q7Smk0NiBq7ozSJBsPeFey0SLy5HIjTbfQJlCFVCjjFcKR
    4PNLAILvatb5GoKPJKV8QWVbKRG7CYKHVLoArTC373euZUgxxTj7SmKfuQP0dnVj
    6ES3g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
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
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C58120685
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 18 Mar 2018 10:00:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH v2 6/8] staging:iio:ade7854: Rework I2C read function
Message-ID: <20180318100052.36b6311b@archlinux>
In-Reply-To: <1d0edf1a515e71b0198cb76ed6ec679f85ba2127.1521239766.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
 <1d0edf1a515e71b0198cb76ed6ec679f85ba2127.1521239766.git.rodrigosiqueiramelo@gmail.com>
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

On Fri, 16 Mar 2018 19:49:59 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The read operation for the I2C function has many duplications that can
> be generalized into a single function. This patch reworks the read
> operation for I2C to centralizes all similar code in a single function.
> Part of the rework includes a proper error handling and a fix on the
> i2c_master_recv for 32 bits as pointed by John Syne patches.
This seems likely to have been covered by the earlier patch. Please update
the description.

Otherwise same define comment but beyond that looks good.

Jonathan

> 
> It is possible to remove all the old interface to use the new one,
> however, for keeping the things simple and working this patch maintain
> legacy interface.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Signed-off-by: John Syne <john3909@gmail.com>
> ---
>  drivers/staging/iio/meter/ade7854-i2c.c | 110 ++++++++++++--------------------
>  1 file changed, 41 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index e95147a1bac1..20db8eedb84a 100644
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> @@ -65,9 +65,10 @@ static int ade7854_i2c_write_reg(struct device *dev,
>  	return ret < 0 ? ret : 0;
>  }
>  
> -static int ade7854_i2c_read_reg_8(struct device *dev,
> -				  u16 reg_address,
> -				  u8 *val)
> +static int ade7854_i2c_read_reg(struct device *dev,
> +				u16 reg_address,
> +				u32 *val,
> +				int bytes)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
> @@ -79,95 +80,66 @@ static int ade7854_i2c_read_reg_8(struct device *dev,
>  
>  	ret = i2c_master_send(st->i2c, st->tx, 2);
>  	if (ret < 0)
> -		goto out;
> +		goto unlock;
>  
> -	ret = i2c_master_recv(st->i2c, st->rx, 1);
> +	ret = i2c_master_recv(st->i2c, st->rx, bytes);
>  	if (ret < 0)
> -		goto out;
> +		goto unlock;
> +
> +	switch (bytes) {
> +	case DATA_SIZE_8_BITS:
> +		*val = st->rx[0];
> +		break;
> +	case DATA_SIZE_16_BITS:
> +		*val = (st->rx[0] << 8) | st->rx[1];
> +		break;
> +	case DATA_SIZE_24_BITS:
> +		*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
> +		break;
> +	case DATA_SIZE_32_BITS:
> +		*val = (st->rx[0] << 24) | (st->rx[1] << 16) |
> +			(st->rx[2] << 8) | st->rx[3];
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
>  
> -	*val = st->rx[0];
> -out:
> +unlock:
>  	mutex_unlock(&st->buf_lock);
>  	return ret;
>  }
>  
> +static int ade7854_i2c_read_reg_8(struct device *dev,
> +				  u16 reg_address,
> +				  u8 *val)
> +{
> +	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
> +				    DATA_SIZE_8_BITS);
> +}
> +
>  static int ade7854_i2c_read_reg_16(struct device *dev,
>  				   u16 reg_address,
>  				   u16 *val)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	int ret;
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = (reg_address >> 8) & 0xFF;
> -	st->tx[1] = reg_address & 0xFF;
> -
> -	ret = i2c_master_send(st->i2c, st->tx, 2);
> -	if (ret < 0)
> -		goto out;
> -
> -	ret = i2c_master_recv(st->i2c, st->rx, 2);
> -	if (ret < 0)
> -		goto out;
> -
> -	*val = (st->rx[0] << 8) | st->rx[1];
> -out:
> -	mutex_unlock(&st->buf_lock);
> -	return ret;
> +	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
> +				    DATA_SIZE_16_BITS);
>  }
>  
>  static int ade7854_i2c_read_reg_24(struct device *dev,
>  				   u16 reg_address,
>  				   u32 *val)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	int ret;
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = (reg_address >> 8) & 0xFF;
> -	st->tx[1] = reg_address & 0xFF;
> -
> -	ret = i2c_master_send(st->i2c, st->tx, 2);
> -	if (ret < 0)
> -		goto out;
> -
> -	ret = i2c_master_recv(st->i2c, st->rx, 3);
> -	if (ret < 0)
> -		goto out;
> -
> -	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
> -out:
> -	mutex_unlock(&st->buf_lock);
> -	return ret;
> +	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
> +				    DATA_SIZE_24_BITS);
>  }
>  
>  static int ade7854_i2c_read_reg_32(struct device *dev,
>  				   u16 reg_address,
>  				   u32 *val)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	int ret;
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = (reg_address >> 8) & 0xFF;
> -	st->tx[1] = reg_address & 0xFF;
> -
> -	ret = i2c_master_send(st->i2c, st->tx, 2);
> -	if (ret < 0)
> -		goto out;
> -
> -	ret = i2c_master_recv(st->i2c, st->rx, 4);
> -	if (ret < 0)
> -		goto out;
> -
> -	*val = (st->rx[0] << 24) | (st->rx[1] << 16) |
> -		(st->rx[2] << 8) | st->rx[3];
> -out:
> -	mutex_unlock(&st->buf_lock);
> -	return ret;
> +	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
> +				    DATA_SIZE_32_BITS);
>  }
>  
>  static int ade7854_i2c_probe(struct i2c_client *client,

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
