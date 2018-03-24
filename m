Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3952077-1521898778-2-5389859929372878195
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521898776; b=ZGiqIF6tDnvv3XboTxk1VzIhWe6drsFNic6T7D4+i3geP63
    Z6bbyBLVKXRj/NMPehjyRzBJp+UJzUlkKwAMuq8ZvEDp1cxw7M/Xk2wbZUMbDg/V
    BzM0p6pvzcsLn4yEONFKidB8foKghLAMoXZuVzsgRCZB2EBBQdXwq5Siq0cLGUhY
    Rb+seQA1/PKgJIt/yF/WwrDIBO1Z0MtlPgVr6m5mMdK42xQL3tVs3iDVsN9+N9wF
    Cw/KnVo/lUpge7fMRqrcByLohEgt/T8MPrFrc524TKuKbkFpcHzFWGoP4T40wSLq
    Rle82hHLQRrJDKa5baMsZI+ANHxLdgWvaQODhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521898776; bh=P
    dFJyK0rrk52DxuiPdpRcrp3QO9++dTxbUa0NyIZzlc=; b=sTgezFN11ZNHQs48L
    SU0pKoPetdrGurrqp0evejNLmcOonNsvvW2gKU6UnmGxS/aTLz1TmF/3tzWV3NHI
    mFmIx5OX6CKa89xS03eHfWHVTfNOjgk/XEP9Qkbe6Vq0bNJvFNGxn6T5socrRBAM
    hRLhWUIDViUKX4vmUJMrLf+zydi56U7449/i+ldaXx5ayxjkbQUu/RhMJAIzbWcv
    9HBQFUoSlhAogEs3DUAlEqWfXBGpriyyUVxCLItEsWvkbTtRNFdULsORmBrP5mJZ
    2R0DLidOAsPNn+P9svXlB3URBm+DkLMI+BrqR8z7syiIptp8TtGm6nNfXxivNOlf
    9JERw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3901C21772
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 13:39:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 06/11] staging: iio: tsl2x7x: make logging consistent
 and correct newlines
Message-ID: <20180324133925.283afb93@archlinux>
In-Reply-To: <20180321102912.5130-7-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
 <20180321102912.5130-7-masneyb@onstation.org>
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Jon.Brenner@ams.com,
 pmeerw@pmeerw.net, knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 21 Mar 2018 06:29:07 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch updates all of the logging commands so that they are
> consistent with the other messages, includes __func__ in the message,
> and all of the messages include newlines. This patch also removes some
> debug log messages.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Hmm. This is definitely an improvement, but at somepoint we may want
to drop all of the __func__ usage as the dynamic debug system can
provide back traces which obviously include this info.

So might need a follow up, though perhaps not pre moving out of staging
as this really isn't important.

Hence, applied.

Thanks,

Jonathan

> ---
> Changes since v1:
> - Remove some debug messages and every log message doesn't have to have
>   the function name.
> - Earlier patches in this current series dropped some of the debug
>   messages that were in v1.
> 
>  drivers/staging/iio/light/tsl2x7x.c | 42 ++++++++++++++-----------------------
>  1 file changed, 16 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index f7e7fcc17059..07ce3076a05d 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -374,7 +374,8 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  		ret = i2c_smbus_read_byte_data(chip->client, reg);
>  		if (ret < 0) {
>  			dev_err(&chip->client->dev,
> -				"failed to read. err=%x\n", ret);
> +				"%s: failed to read from register %x: %d\n",
> +				__func__, reg, ret);
>  			goto out_unlock;
>  		}
>  
> @@ -416,7 +417,9 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  
>  	/* note: lux is 31 bit max at this point */
>  	if (ch1lux > ch0lux) {
> -		dev_dbg(&chip->client->dev, "ch1lux > ch0lux-return last value\n");
> +		dev_dbg(&chip->client->dev,
> +			"%s: ch1lux > ch0lux; returning last value\n",
> +			__func__);
>  		ret = chip->als_cur_info.lux;
>  		goto out_unlock;
>  	}
> @@ -591,8 +594,6 @@ static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
>  		return -ERANGE;
>  
>  	chip->settings.als_gain_trim = ret;
> -	dev_info(&chip->client->dev,
> -		 "%s als_calibrate completed\n", chip->client->name);
>  
>  	return ret;
>  }
> @@ -674,12 +675,14 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  	 */
>  	for (i = 0, dev_reg = chip->tsl2x7x_config;
>  			i < TSL2X7X_MAX_CONFIG_REG; i++) {
> -		ret = i2c_smbus_write_byte_data(chip->client,
> -						TSL2X7X_CMD_REG + i,
> +		int reg = TSL2X7X_CMD_REG + i;
> +
> +		ret = i2c_smbus_write_byte_data(chip->client, reg,
>  						*dev_reg++);
>  		if (ret < 0) {
>  			dev_err(&chip->client->dev,
> -				"failed on write to reg %d.\n", i);
> +				"%s: failed to write to register %x: %d\n",
> +				__func__, reg, ret);
>  			return ret;
>  		}
>  	}
> @@ -907,15 +910,11 @@ static ssize_t in_illuminance0_lux_table_store(struct device *dev,
>  	 */
>  	n = value[0];
>  	if ((n % 3) || n < 6 ||
> -	    n > ((ARRAY_SIZE(chip->tsl2x7x_device_lux) - 1) * 3)) {
> -		dev_info(dev, "LUX TABLE INPUT ERROR 1 Value[0]=%d\n", n);
> +	    n > ((ARRAY_SIZE(chip->tsl2x7x_device_lux) - 1) * 3))
>  		return -EINVAL;
> -	}
>  
> -	if ((value[(n - 2)] | value[(n - 1)] | value[n]) != 0) {
> -		dev_info(dev, "LUX TABLE INPUT ERROR 2 Value[0]=%d\n", n);
> +	if ((value[(n - 2)] | value[(n - 1)] | value[n]) != 0)
>  		return -EINVAL;
> -	}
>  
>  	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
>  		ret = tsl2x7x_chip_off(indio_dev);
> @@ -1048,15 +1047,10 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
>  			chip->settings.persistence &= 0xF0;
>  			chip->settings.persistence |=
>  				(filter_delay & 0x0F);
> -			dev_info(&chip->client->dev, "%s: ALS persistence = %d",
> -				 __func__, filter_delay);
>  		} else {
>  			chip->settings.persistence &= 0x0F;
>  			chip->settings.persistence |=
>  				((filter_delay << 4) & 0xF0);
> -			dev_info(&chip->client->dev,
> -				 "%s: Proximity persistence = %d",
> -				 __func__, filter_delay);
>  		}
>  		ret = 0;
>  		break;
> @@ -1269,9 +1263,6 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_INT_TIME:
>  		chip->settings.als_time =
>  			TSL2X7X_MAX_TIMER_CNT - (val2 / TSL2X7X_MIN_ITIME);
> -
> -		dev_info(&chip->client->dev, "%s: als time = %d",
> -			 __func__, chip->settings.als_time);
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -1633,8 +1624,9 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  
>  	ret = i2c_smbus_write_byte(clientp, TSL2X7X_CMD_REG | TSL2X7X_CNTRL);
>  	if (ret < 0) {
> -		dev_err(&clientp->dev, "write to cmd reg failed. err = %d\n",
> -			ret);
> +		dev_err(&clientp->dev,
> +			"%s: Failed to write to CMD register: %d\n",
> +			__func__, ret);
>  		return ret;
>  	}
>  
> @@ -1664,7 +1656,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  						indio_dev);
>  		if (ret) {
>  			dev_err(&clientp->dev,
> -				"%s: irq request failed", __func__);
> +				"%s: irq request failed\n", __func__);
>  			return ret;
>  		}
>  	}
> @@ -1681,8 +1673,6 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  		return ret;
>  	}
>  
> -	dev_info(&clientp->dev, "%s Light sensor found.\n", id->name);
> -
>  	return 0;
>  }
>  

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
