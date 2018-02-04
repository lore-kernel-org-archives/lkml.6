Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3277975-1517742634-2-12786365016869635475
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517742633; b=kUGzWFvFV3+xB2DNra8yLKJaiPf171yFkCY3z83HbvlD0MC
    YFfz2wfZnT7ugnGEUkSfue9bLtR8AIhYL0e/n2Zvg75+KODxDzXvnong6xq7Po7v
    V2LGhJ0XcDBFaNqJqfiyM3bqcBB/YWzdksCf6YGXL0yia6zpmZQHXbVS6KsfOCt+
    QflD3GEAZ7o61azbb4Sly84lC8MJryKOPTjzVsNMi7wCS0loTNaVoS+n1/cOYcvH
    ayiGOoCEsSg1TekUbyCrDLCy0j67cS69G3z4lz9/kv5QEuWKKAIBPqiPlSFh6vkZ
    zim4ll1Il3XZGs6Fk0YAyibZWNYo504jyrjGpIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517742633; bh=0
    An1HG2kdJW0mII2mPZMACoiQOBTMDR41ije8ON5REY=; b=HVxLOBSCTx6qhrn4x
    g7qhB77/z/lMLc6psnrJZOsNyZFqR6oNHmeBVIOkt3CTSlXsmLNZ+1YBJstO8QK8
    cZHltFYoCBXtqylU5XjqLMZouF2f9Q0boqMeq94nu8HtKUi12sSKXe0GJETUhLjZ
    nBTyndYNYKunGk5mbgebyAo0D0eC7gwFmVwMzWbfa7/OuDEjnhfJJMrUP+FJdAZV
    gqxU0ojYSSUzKyS141U+AUtf0NVLkLf4OW8HObAI3UWeC+lZvXPfe1b01v+Ytlzu
    LososuN4tqSVmb5fNC5GzBaXxSlTqyjo3fYABbwuySn7r0I64RX5lXkPnKsyvXYz
    0YGdg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0582F20CA9
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 4 Feb 2018 11:10:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: Re: [PATCH v4] Staging: iio: ade7758: Expand buf_lock to cover both
 buffer and state protection
Message-ID: <20180204111022.0e6d08f6@archlinux>
In-Reply-To: <1517671892-4045-1-git-send-email-shreeya.patel23498@gmail.com>
References: <1517671892-4045-1-git-send-email-shreeya.patel23498@gmail.com>
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat,  3 Feb 2018 21:01:32 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> iio_dev->mlock is to be used only by the IIO core for protecting
> device mode changes between INDIO_DIRECT and INDIO_BUFFER.
> 
> This patch replaces the use of mlock with the already established
> buf_lock mutex.
> 
> Introducing 'unlocked' forms of read and write registers. The
> read/write frequency functions now require buf_lock to be held.
> That's not obvious so avoid this but moving the locking inside
> the functions where it is then clear that they are taking the
> unlocked forms of the register read/write.
> 
> It isn't readily apparent that write frequency function requires
> the locks to be taken, so move it inside the function to where it
> is required to protect.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Hi Shreeya,

Unfortunately this introduces a new bug - you end up unlocking
a mutex that you never locked in one of the error paths.
See inline.

We are also still taking the mlock around the read of the
frequency which doesn't make any sense given there is
no reason to protect that against state changes.
Arguably fixing that could be a separate patch as it never
made much sense, but it should probably be in this same series
at least.  I would have no real problem with it being in it this
same patch as long as the description above mentions it.

Thanks,

Jonathan

> ---
> 
> Changes in v2
>   -Add static keyword to newly introduced functions and remove some
> added comments which are not required.
> 
> Changes in v3
>   -Remove some useless mlocks and send it as another patch.
> Also make the necessary change in the current patch associated with 
> the new patch with commit id 88eba33. Make commit message more 
> appropriate.
> 
> Changes in v4
>   -Write frequency function do not require lock so move it inside
> the function to where it is required to protect.
> 
> 
>  drivers/staging/iio/meter/ade7758.h      |  2 +-
>  drivers/staging/iio/meter/ade7758_core.c | 49 ++++++++++++++++++++++++--------
>  2 files changed, 38 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7758.h b/drivers/staging/iio/meter/ade7758.h
> index 6ae78d8..2de81b5 100644
> --- a/drivers/staging/iio/meter/ade7758.h
> +++ b/drivers/staging/iio/meter/ade7758.h
> @@ -111,7 +111,7 @@
>   * @trig:		data ready trigger registered with iio
>   * @tx:			transmit buffer
>   * @rx:			receive buffer
> - * @buf_lock:		mutex to protect tx and rx
> + * @buf_lock:		mutex to protect tx, rx, read and write frequency
>   **/
>  struct ade7758_state {
>  	struct spi_device	*us;
> diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
> index 227dbfc..ff19d46 100644
> --- a/drivers/staging/iio/meter/ade7758_core.c
> +++ b/drivers/staging/iio/meter/ade7758_core.c
> @@ -24,17 +24,25 @@
>  #include "meter.h"
>  #include "ade7758.h"
>  
> -int ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
> +static int __ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
>  {
> -	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7758_state *st = iio_priv(indio_dev);
>  
> -	mutex_lock(&st->buf_lock);
>  	st->tx[0] = ADE7758_WRITE_REG(reg_address);
>  	st->tx[1] = val;
>  
> -	ret = spi_write(st->us, st->tx, 2);
> +	return spi_write(st->us, st->tx, 2);
> +}
> +
> +int ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ade7758_state *st = iio_priv(indio_dev);
> +
> +	mutex_lock(&st->buf_lock);
> +	ret = __ade7758_spi_write_reg_8(dev, reg_address, val);
>  	mutex_unlock(&st->buf_lock);
>  
>  	return ret;
> @@ -91,7 +99,7 @@ static int ade7758_spi_write_reg_24(struct device *dev, u8 reg_address,
>  	return ret;
>  }
>  
> -int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
> +static int __ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7758_state *st = iio_priv(indio_dev);
> @@ -111,7 +119,6 @@ int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
>  		},
>  	};
>  
> -	mutex_lock(&st->buf_lock);
>  	st->tx[0] = ADE7758_READ_REG(reg_address);
>  	st->tx[1] = 0;
>  
> @@ -124,7 +131,19 @@ int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
>  	*val = st->rx[0];
>  
>  error_ret:
> +	return ret;
> +}
> +
> +int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ade7758_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->buf_lock);
> +	ret = __ade7758_spi_read_reg_8(dev, reg_address, val);
>  	mutex_unlock(&st->buf_lock);
> +
>  	return ret;
>  }
>  
> @@ -480,10 +499,12 @@ static int ade7758_read_samp_freq(struct device *dev, int *val)
>  	return 0;
>  }
>  
> -static int ade7758_write_samp_freq(struct device *dev, int val)
> +static int ade7758_write_samp_freq(struct iio_dev *indio_dev, int val)
>  {
>  	int ret;
>  	u8 reg, t;
> +	struct ade7758_state *st = iio_priv(indio_dev);
> +	struct device *dev = &indio_dev->dev;
>  
>  	switch (val) {
>  	case 26040:
> @@ -503,16 +524,20 @@ static int ade7758_write_samp_freq(struct device *dev, int val)
>  		goto out;

This goto out results in an unlock but the lock hasn't been locked
for a few more lines...

Change this to a direct return here rather than a goto to fix this.
return -EINVAL;

>  	}
>  
> -	ret = ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE, &reg);
> +	mutex_lock(&st->buf_lock);
> +
> +	ret = __ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE, &reg);
>  	if (ret)
>  		goto out;
>  
>  	reg &= ~(5 << 3);
>  	reg |= t << 5;
>  
> -	ret = ade7758_spi_write_reg_8(dev, ADE7758_WAVMODE, reg);
> +	ret = __ade7758_spi_write_reg_8(dev, ADE7758_WAVMODE, reg);
>  
>  out:
> +	mutex_unlock(&st->buf_lock);
> +
>  	return ret;
>  }
>  
> @@ -545,9 +570,9 @@ static int ade7758_write_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (val2)
>  			return -EINVAL;
> -		mutex_lock(&indio_dev->mlock);
> -		ret = ade7758_write_samp_freq(&indio_dev->dev, val);
> -		mutex_unlock(&indio_dev->mlock);
> +
> +		ret = ade7758_write_samp_freq(indio_dev, val);
> +
>  		return ret;
>  	default:
>  		return -EINVAL;

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
