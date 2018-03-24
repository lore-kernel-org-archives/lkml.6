Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3936627-1521898033-2-11837321502917641478
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
    t=1521898032; b=bDzkXZKTNe/Oe+gADn2ASjdgWZSpyll2omq4h9k/scO2KSA
    qxzq53nw9xtUBuAHRj2gdhOIQCHbBGMOy/ZO53GwiWzwZohTCZLItg+V4pXnE4y/
    cuVWN1DCk0e2hp0FwHfH8sQJ2zZBSlXN/hYqOBdSP+2VJZX686ZAA6+SVeYJqHgG
    XhC4yyMH1uIgll5QiZtu/M4oOFvlfbpRwWHQcy/UMSYVj2Ck4bRkMWEuerZXGezZ
    JcqYZc43SFI4/F8+3YZ7z2nqHPju89TRoE+1o2BvIykygGX/2l96n/zXHYoiMoEF
    /Mr4U7yQKzNB3kKZ0dKBBZ6heGTw8ozvrC0ebWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521898032; bh=v
    e6wpasmUP2gGVli9vb6ro9yCR7219rVl7IYW2lHf+8=; b=Jw+ZuS4z3y3Sh/43K
    nc+ORYDFwNBU+s20XKL3fSbRtxKNk5OqoBZiUDOODjXbPh9P/y8M0gPLdmK7pJ+e
    2qHMQqz/naJZ0rQXqW+GPIUgfzbUFf6azuDl7HvYnl7Gkaji9lKPJ+1PEXeFaV/A
    SOfxbgbVvbXZ0GJNZEP0FNI5saNuVEl9i537SjfT5TPnI+OLFGgBVNhkBe7ZQNOX
    gaoAs4ZydX8fEWV8aHJNgVDvKlhwSOIlYeaotU2k4RP7GQXCdElhorP2O1rpkw6a
    E1deRvvsY8Vkea+H2OiqXKKMZ2k1pCtiEsT2fmJfARE2E99vaY5Q4UC6YKKHaWvr
    1KJCg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B22B21716
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 13:27:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH v3 6/8] staging:iio:ade7854: Rework I2C read function
Message-ID: <20180324132701.45dfdd33@archlinux>
In-Reply-To: <c7f86bb795b71e693692b228da854939be67cb1d.1521813782.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
 <c7f86bb795b71e693692b228da854939be67cb1d.1521813782.git.rodrigosiqueiramelo@gmail.com>
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

On Fri, 23 Mar 2018 11:26:57 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The read operation for the I2C function has many duplications that can
> be generalized into a single function. This patch reworks the read
> operation for I2C to centralizes all similar code in a single function.
> 
> It is possible to remove all the old interface to use the new one,
> however, for keeping the things simple and working this patch maintain
> legacy interface.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Applied, thanks.

Jonathan

> ---
> Changes in v3:
>  - Remove the use of defines that not improve the readability
>  - Replace variable name "bytes" for "bits"
>  - Update commit message
> 
>  drivers/staging/iio/meter/ade7854-i2c.c | 106 +++++++++++---------------------
>  1 file changed, 37 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index 29e959fdb932..63793f9664c7 100644
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
> +				int bits)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
> @@ -79,95 +80,62 @@ static int ade7854_i2c_read_reg_8(struct device *dev,
>  
>  	ret = i2c_master_send(st->i2c, st->tx, 2);
>  	if (ret < 0)
> -		goto out;
> +		goto unlock;
>  
> -	ret = i2c_master_recv(st->i2c, st->rx, 1);
> +	ret = i2c_master_recv(st->i2c, st->rx, bits);
>  	if (ret < 0)
> -		goto out;
> +		goto unlock;
> +
> +	switch (bits) {
> +	case 8:
> +		*val = st->rx[0];
> +		break;
> +	case 16:
> +		*val = (st->rx[0] << 8) | st->rx[1];
> +		break;
> +	case 24:
> +		*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
> +		break;
> +	case 32:
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
> +	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val, 8);
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
> +	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val, 16);
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
> +	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val, 24);
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
> +	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val, 32);
>  }
>  
>  static int ade7854_i2c_probe(struct i2c_client *client,

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
