Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1574763-1521159946-2-7172257824110472259
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521159945; b=X6lzH2DkG1HEICK+EnSQOW3mWoGtg/mVu4x/DEU/e+qbtd9
    Xlw4QCMfCOpcyr4mFjJ76vzdiGcDW91TLe/ba/+yTAEqFp3xLBgnwzzR36Ik8gIN
    Yg0krd3mmcmmlADkDLc0wQ0NJe9ZYRwhJcD12OUUaLzYirFSLs2a3nxXtFOM6z9Y
    XPS7crGEtI7yHGzGquQGXJ0kQ2I/OBu8meMg4CrFuJYtMQUQWDdE0RldzqpqMTgb
    v0n2T/SlG48rCWgC8cHRo1mac4iTkBDVy+14S8oc+ibU/w6zkxQv0Prq8uFaJ+tQ
    i9a3MT9CKp7tr+zJ7BhkAcclFkJzEgvN+Li8Z2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521159945; bh=o
    ZC03EeBrYZjSqyo7bNlHNoLQfF46h3uEEFWVbQcXlo=; b=rNIHhh0aNM8shMTr9
    pAvpS49DLsB6SR6LxoPxRCVl1+NA3fhPgaMte+tM/4aX7b660Jb5AZlSsZphzyRq
    qwbDcjjM4Ke+bCmOTyBSQ9xecaHRbuKwQfH3ZF9//t2A4zi0eZ0pWnzE3idO/kan
    pu6XnDwb0pWBMgOVyxCS/hSYyx/NmUXXgvvLPmt8jj/BkhrWx8l//dUs+tg+yAlM
    ccBCf5VzHDl7AyAgpcF1+j/C5lwjqYLE2gxcHbQ/kjzqK2UC8y4NPK0gB+1EG9cb
    KhPtFnSgcrSVOWpvLjFgIx40bQ0EeaHOvLaLdBvafWepLgac1NlKdnkigBF/z1Xz
    OaHAg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DS7wl2Ow x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=grq1cGWS;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DS7wl2Ow x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=grq1cGWS;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsbWU/+OLtUpbTSL2ftt3ayZ3poxKKxd0fD0JcyG7/AeDigUaUIzJT53F3j9nPqJ4u+merjdA==
Date: Thu, 15 Mar 2018 21:25:29 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/7] staging:iio:ade7854: Rework I2C write function
Message-ID: <20180316002529.fsief4aifq5qulag@smtp.gmail.com>
References: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
 <98c74382f0ea9c5d33f7ea9c9697d87889c1baa2.1521037060.git.rodrigosiqueiramelo@gmail.com>
 <20180315120607.cjp42wpii3soni6d@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180315120607.cjp42wpii3soni6d@mwanda>
User-Agent: NeoMutt/20180223
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
 daniel.baluta@nxp.com, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

I will fixes all of these things here and in the other patches and send a
v2.

Thanks for the review.

On 03/15, Dan Carpenter wrote:
> On Wed, Mar 14, 2018 at 03:10:18PM -0300, Rodrigo Siqueira wrote:
> > The write operation using I2C has many code duplications and four
> > different interfaces per data size. This patch introduces a single
> > function that centralizes the main tasks.
> > 
> > The central function inserted by this patch can easily replace all the
> > four functions related to the data size. However, this patch does not
> > remove any code signature for keeping the meter module work and make
> > easier to review this patch.
> > 
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > ---
> >  drivers/staging/iio/meter/ade7854-i2c.c | 89 +++++++++++++++++++--------------
> >  drivers/staging/iio/meter/ade7854.h     |  7 +++
> >  2 files changed, 58 insertions(+), 38 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> > index 317e4f0d8176..03133a05eae4 100644
> > --- a/drivers/staging/iio/meter/ade7854-i2c.c
> > +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> > @@ -15,41 +15,74 @@
> >  #include <linux/iio/iio.h>
> >  #include "ade7854.h"
> >  
> > -static int ade7854_i2c_write_reg_8(struct device *dev,
> > -				   u16 reg_address,
> > -				   u8 val)
> > +static int ade7854_i2c_write_reg(struct device *dev,
> > +				 u16 reg_address,
> > +				 u32 val,
> > +				 enum data_size type)
> 
> 
> The data size should just be the number of bytes and not an enum.
> 1 means 1 byte / 8 bits.
> 2 means 2 bytes / 16 bits.
> 3 means 3 bytes / 24 bits.
> etc.
> 
> >  {
> >  	int ret;
> > +	int count;
> >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >  	struct ade7854_state *st = iio_priv(indio_dev);
> >  
> >  	mutex_lock(&st->buf_lock);
> >  	st->tx[0] = (reg_address >> 8) & 0xFF;
> >  	st->tx[1] = reg_address & 0xFF;
> > -	st->tx[2] = val;
> >  
> > -	ret = i2c_master_send(st->i2c, st->tx, 3);
> > +	switch (type) {
> > +	case DATA_SIZE_8_BITS:
> > +		st->tx[2] = val & 0xFF;
> > +		count = 3;
> > +		break;
> > +	case DATA_SIZE_16_BITS:
> > +		st->tx[2] = (val >> 8) & 0xFF;
> > +		st->tx[3] = val & 0xFF;
> > +		count = 4;
> > +		break;
> > +	case DATA_SIZE_24_BITS:
> > +		st->tx[2] = (val >> 16) & 0xFF;
> > +		st->tx[3] = (val >> 8) & 0xFF;
> > +		st->tx[4] = val & 0xFF;
> > +		count = 5;
> > +		break;
> > +	case DATA_SIZE_32_BITS:
> > +		st->tx[2] = (val >> 24) & 0xFF;
> > +		st->tx[3] = (val >> 16) & 0xFF;
> > +		st->tx[4] = (val >> 8) & 0xFF;
> > +		st->tx[5] = val & 0xFF;
> > +		count = 6;
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +		goto error_i2c_write_unlock;
> > +	}
> > +
> > +	ret = i2c_master_send(st->i2c, st->tx, count);
> > +
> > +error_i2c_write_unlock:
> 
> These labels are sort of long.  And what does the "i2c_write" really
> mean?  It should be obvious that we're not jumping to a different
> function.
> 
> Just "unlock:" is OK as a label name.
> 
> >  	mutex_unlock(&st->buf_lock);
> >  
> >  	return ret;
> >  }
> >  
> > +static int ade7854_i2c_write_reg_8(struct device *dev,
> > +				   u16 reg_address,
> > +				   u8 val)
> > +{
> > +	int ret;
> > +
> > +	ret = ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_8_BITS);
> > +
> > +	return ret;
> > +}
> 
> Just do it like this:
> 
> static int ade7854_i2c_write_reg_8(struct device *dev, u16 reg_address, u8 val)
> {
> 	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_8_BITS);
> }
> 
> 
> 
> > +
> >  static int ade7854_i2c_write_reg_16(struct device *dev,
> >  				    u16 reg_address,
> >  				    u16 val)
> >  {
> >  	int ret;
> > -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -	struct ade7854_state *st = iio_priv(indio_dev);
> >  
> > -	mutex_lock(&st->buf_lock);
> > -	st->tx[0] = (reg_address >> 8) & 0xFF;
> > -	st->tx[1] = reg_address & 0xFF;
> > -	st->tx[2] = (val >> 8) & 0xFF;
> > -	st->tx[3] = val & 0xFF;
> > -
> > -	ret = i2c_master_send(st->i2c, st->tx, 4);
> > -	mutex_unlock(&st->buf_lock);
> > +	ret = ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_16_BITS);
> >  
> >  	return ret;
> 
> Again:
> 
> 	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_16_BITS);
> 
> 
> 
> >  }
> > @@ -59,18 +92,8 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
> >  				    u32 val)
> >  {
> >  	int ret;
> > -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -	struct ade7854_state *st = iio_priv(indio_dev);
> >  
> > -	mutex_lock(&st->buf_lock);
> > -	st->tx[0] = (reg_address >> 8) & 0xFF;
> > -	st->tx[1] = reg_address & 0xFF;
> > -	st->tx[2] = (val >> 16) & 0xFF;
> > -	st->tx[3] = (val >> 8) & 0xFF;
> > -	st->tx[4] = val & 0xFF;
> > -
> > -	ret = i2c_master_send(st->i2c, st->tx, 5);
> > -	mutex_unlock(&st->buf_lock);
> > +	ret = ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_24_BITS);
> >  
> >  	return ret;
> 
> Same.
> 
> >  }
> > @@ -80,23 +103,13 @@ static int ade7854_i2c_write_reg_32(struct device *dev,
> >  				    u32 val)
> >  {
> >  	int ret;
> > -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -	struct ade7854_state *st = iio_priv(indio_dev);
> > -
> > -	mutex_lock(&st->buf_lock);
> > -	st->tx[0] = (reg_address >> 8) & 0xFF;
> > -	st->tx[1] = reg_address & 0xFF;
> > -	st->tx[2] = (val >> 24) & 0xFF;
> > -	st->tx[3] = (val >> 16) & 0xFF;
> > -	st->tx[4] = (val >> 8) & 0xFF;
> > -	st->tx[5] = val & 0xFF;
> >  
> > -	ret = i2c_master_send(st->i2c, st->tx, 6);
> > -	mutex_unlock(&st->buf_lock);
> > +	ret = ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_32_BITS);
> >  
> >  	return ret;
> 
> Same.
> 
> >  }
> >  
> > +
> 
> Checkpatch.pl will complain about this second blank line.
> 
> regards,
> dan carpenter
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
