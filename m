Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3936627-1521897890-2-1565681839571333966
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521897889; b=vYdoohoADPzXq+Xzw8FCawOY+/90DPcV/rda4VqkE4qCst2
    TTRhFE3tZlFkTDV3hqC0v/dJ/xRn/dI6AA8CDrk45VU87UQbcJ9beNqJGRsoZP7x
    ujsU88FtmgWi5U0FsDGfUe8p5pMn+edN7mjyXJKcwXcGgEszAM8/U2Buo1al60Cb
    7QjoH8lObm4AYGUDBOHePejYf6Qg8Fgvz/3I5QI8Go9XvqtPHCEfdA1LW/3qtcev
    PQI3/SNx+QoJgj7oAHOxoW2SR2/D9gGjx2kIDIOBbaJkynQszsIquyo0Ijhj/tUR
    itgp3mk4oFxFSJSYROuXfoneUIEBHms1Avi7SyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521897889; bh=t
    arJARU+RkmcRgK8VoPGdJHBbWAHeT7WQBCAFGOC/i0=; b=gx8knrghHjlIqUQ/g
    PONvzkmJgRK1iHsLaS7C8VgSxTYcreKxn7/clKs4ZfyDVGVaRizOE3FU7t2VKYWj
    G3vh8vfngrN9/aFVWYaRKw3zMW7nfpAvxh8+jZbzf0snjyGUe7ANGgHZUpGzcnVO
    0ipJQodQyCNYou9rJ+vwZNtIlWvuP24xh2VOSghUoOp4Nu7omoXhm5WdAZCsALah
    2H91pD93u3VYZuNTGPrlJTGZxZpRevjOV9YDYwYuB0gJ1WIdczSq9w6WA3iB0v8u
    kmSB6Rr+yKjZcgPyCq6weonKuzuW64GnYuFNfMtLXGeN+lWzDO4+Gsj8oidGCWEi
    Z2U8g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3475D21716
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 13:24:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH v3 3/8] staging:iio:ade7854: Rework I2C write function
Message-ID: <20180324132438.2589cac2@archlinux>
In-Reply-To: <c87da79c773f417c94b4609476c54f7de085b697.1521813782.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
 <c87da79c773f417c94b4609476c54f7de085b697.1521813782.git.rodrigosiqueiramelo@gmail.com>
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

On Fri, 23 Mar 2018 11:26:06 -0300
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
Applied.

Thanks,

Jonathan

> ---
> Changes in v3:
>  - Remove the use of defines that not improve the readability
>  - Replace variable name "bytes" for "bits"
> 
>  drivers/staging/iio/meter/ade7854-i2c.c | 96 ++++++++++++++++-----------------
>  1 file changed, 46 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index 37c957482493..c9f46d26b752 100644
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
> +				 int bits)
>  {
>  	int ret;
> +	int count;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
>  
>  	mutex_lock(&st->buf_lock);
>  	st->tx[0] = (reg_address >> 8) & 0xFF;
>  	st->tx[1] = reg_address & 0xFF;
> -	st->tx[2] = val;
>  
> -	ret = i2c_master_send(st->i2c, st->tx, 3);
> +	switch (bits) {
> +	case 8:
> +		st->tx[2] = val & 0xFF;
> +		count = 3;
> +		break;
> +	case 16:
> +		st->tx[2] = (val >> 8) & 0xFF;
> +		st->tx[3] = val & 0xFF;
> +		count = 4;
> +		break;
> +	case 24:
> +		st->tx[2] = (val >> 16) & 0xFF;
> +		st->tx[3] = (val >> 8) & 0xFF;
> +		st->tx[4] = val & 0xFF;
> +		count = 5;
> +		break;
> +	case 32:
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
> +	return ade7854_i2c_write_reg(dev, reg_address, val, 8);
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
> +	return ade7854_i2c_write_reg(dev, reg_address, val, 16);
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
> +	return ade7854_i2c_write_reg(dev, reg_address, val, 24);
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
> +	return ade7854_i2c_write_reg(dev, reg_address, val, 32);
>  }
>  
>  static int ade7854_i2c_read_reg_8(struct device *dev,

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
