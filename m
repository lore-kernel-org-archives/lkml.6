Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3875657-1521895279-2-16466551216542826672
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roenda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521895278; b=hm4zhUri7/DZenPQc2WdWADqgIIRBTzQKMZdprDcWPG+IqI
    SXzf0UMG3RuAeZTjFaWIHV5Wb2YEssEUHlCdJY2IhBnu4HAWd05VMX8UrM1oARkf
    Yus3J4O/FM4ZsXPL4zdwAxq0W1sLDHu2hQ7GRqKR6OitLhlujWDJe7Wb3fmhh+0H
    xe76n0PNOUm3NQqYqR8WPeBzZWpK1Qfga42cHEDos5Oeo8b6dpVFvKpiYgEBm8Qb
    NvJjsBVT8lVzkNHENwWNM8reC/TxLh9sEaBrOM4r4HUDRyGeaM4opwgsPBkNQUhL
    gOnqCR9d8Ky8e7aWonY5Z0I2QlAz41wWLsfch/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521895278; bh=i
    ZFIw+2WZBPtDin8e4DBL3pIY0a/fdWkiHrtPryhl0w=; b=MMy+OjegyGEZ65fK1
    50MSO2T6IcimgwhGg34NNr8XjXLkjx+O3hkoxUO6bVDJUHfH4mA6DT0eqEcPtbKw
    hx7Wf42RK0EQGckO9tMDj1FpuPD3POQvkKvXeyNQYBQOE9xcR/e+4/F+aW44QVMG
    1+/KYKO6ViIesPXuE1v8NdU32Q/edQ00YWF6zEA2mdciw9VrdWpZEzizQ8vb0rDh
    1l5nWt/r5YdGFuPQCzqO2gjjSeCqfXIM20o65mTVo1iVdk+cxe98BTUC7dPnQB6N
    h7KzeBDDOcIxaT8FRLFfwoCK18OQKIdGGtl1RfakfGjq0g1GJoL8m9GSEjIDi287
    tIC0g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B899E21716
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 12:41:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: John Syne <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH v3 1/8] staging:iio:ade7854: Fix error handling on
 read/write
Message-ID: <20180324124106.61e636be@archlinux>
In-Reply-To: <a3f1f7cd5da77e13ee381b5c41d9a2956335a4b2.1521813782.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
 <a3f1f7cd5da77e13ee381b5c41d9a2956335a4b2.1521813782.git.rodrigosiqueiramelo@gmail.com>
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

On Fri, 23 Mar 2018 11:22:10 -0300
John Syne <rodrigosiqueiramelo@gmail.com> wrote:

> Fixes: correctly handle errors on the read and write operation for I2C
Please look at the Submitting patches documentation.  This is not
what a fixes tag is about!  I'll fix it up this time but please
look at it.
> 
> The original code does not correctly handle the error related to I2C
> read and write. This patch fixes the error handling related to all
> read/write functions for I2C.
> 
> Signed-off-by: John Syne <john3909@gmail.com>
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Given this has been broken a long time I'm not going to push
this for stable.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v3:
>  - Clarify authorship
>  - Add Fixes tag in the commit message
> 
>  drivers/staging/iio/meter/ade7854-i2c.c | 24 ++++++++++++------------
>  drivers/staging/iio/meter/ade7854.c     | 10 +++++-----
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index 317e4f0d8176..4437f1e33261 100644
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> @@ -31,7 +31,7 @@ static int ade7854_i2c_write_reg_8(struct device *dev,
>  	ret = i2c_master_send(st->i2c, st->tx, 3);
>  	mutex_unlock(&st->buf_lock);
>  
> -	return ret;
> +	return ret < 0 ? ret : 0;
>  }
>  
>  static int ade7854_i2c_write_reg_16(struct device *dev,
> @@ -51,7 +51,7 @@ static int ade7854_i2c_write_reg_16(struct device *dev,
>  	ret = i2c_master_send(st->i2c, st->tx, 4);
>  	mutex_unlock(&st->buf_lock);
>  
> -	return ret;
> +	return ret < 0 ? ret : 0;
>  }
>  
>  static int ade7854_i2c_write_reg_24(struct device *dev,
> @@ -72,7 +72,7 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
>  	ret = i2c_master_send(st->i2c, st->tx, 5);
>  	mutex_unlock(&st->buf_lock);
>  
> -	return ret;
> +	return ret < 0 ? ret : 0;
>  }
>  
>  static int ade7854_i2c_write_reg_32(struct device *dev,
> @@ -94,7 +94,7 @@ static int ade7854_i2c_write_reg_32(struct device *dev,
>  	ret = i2c_master_send(st->i2c, st->tx, 6);
>  	mutex_unlock(&st->buf_lock);
>  
> -	return ret;
> +	return ret < 0 ? ret : 0;
>  }
>  
>  static int ade7854_i2c_read_reg_8(struct device *dev,
> @@ -110,11 +110,11 @@ static int ade7854_i2c_read_reg_8(struct device *dev,
>  	st->tx[1] = reg_address & 0xFF;
>  
>  	ret = i2c_master_send(st->i2c, st->tx, 2);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	ret = i2c_master_recv(st->i2c, st->rx, 1);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	*val = st->rx[0];
> @@ -136,11 +136,11 @@ static int ade7854_i2c_read_reg_16(struct device *dev,
>  	st->tx[1] = reg_address & 0xFF;
>  
>  	ret = i2c_master_send(st->i2c, st->tx, 2);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	ret = i2c_master_recv(st->i2c, st->rx, 2);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	*val = (st->rx[0] << 8) | st->rx[1];
> @@ -162,11 +162,11 @@ static int ade7854_i2c_read_reg_24(struct device *dev,
>  	st->tx[1] = reg_address & 0xFF;
>  
>  	ret = i2c_master_send(st->i2c, st->tx, 2);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	ret = i2c_master_recv(st->i2c, st->rx, 3);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
> @@ -188,11 +188,11 @@ static int ade7854_i2c_read_reg_32(struct device *dev,
>  	st->tx[1] = reg_address & 0xFF;
>  
>  	ret = i2c_master_send(st->i2c, st->tx, 2);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	ret = i2c_master_recv(st->i2c, st->rx, 3);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	*val = (st->rx[0] << 24) | (st->rx[1] << 16) |
> diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> index 90d07cdca4b8..0193ae3aae29 100644
> --- a/drivers/staging/iio/meter/ade7854.c
> +++ b/drivers/staging/iio/meter/ade7854.c
> @@ -33,7 +33,7 @@ static ssize_t ade7854_read_8bit(struct device *dev,
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  
>  	ret = st->read_reg_8(dev, this_attr->address, &val);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	return sprintf(buf, "%u\n", val);
> @@ -50,7 +50,7 @@ static ssize_t ade7854_read_16bit(struct device *dev,
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  
>  	ret = st->read_reg_16(dev, this_attr->address, &val);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	return sprintf(buf, "%u\n", val);
> @@ -67,7 +67,7 @@ static ssize_t ade7854_read_24bit(struct device *dev,
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  
>  	ret = st->read_reg_24(dev, this_attr->address, &val);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	return sprintf(buf, "%u\n", val);
> @@ -84,7 +84,7 @@ static ssize_t ade7854_read_32bit(struct device *dev,
>  	struct ade7854_state *st = iio_priv(indio_dev);
>  
>  	ret = st->read_reg_32(dev, this_attr->address, &val);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	return sprintf(buf, "%u\n", val);
> @@ -416,7 +416,7 @@ static int ade7854_set_irq(struct device *dev, bool enable)
>  	u32 irqen;
>  
>  	ret = st->read_reg_32(dev, ADE7854_MASK0, &irqen);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	if (enable)

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
