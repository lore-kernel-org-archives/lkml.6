Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3343216-1520693572-2-13722217257269161246
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
    t=1520693572; b=W15C+asHPeOkXAxOv5ZWCDLSpnvWuCoeIAu7A0hypFM6IEl
    cKCc1MfycbP1XzlVUlHzAS7HUjymJ+QoEq6QL6w5B+xtsrZqQ/GM6+8rc/usXlEG
    CAcI11KmiQYDVQzDlaIqWBImDoTI5Se5v2u+/iazz6NzO2WpQ24tLqwAyHLj4Rzq
    pmaS7zf8OGUhQF1/h6JEOg2sfrJo9xamPAUquugQXi6QULLDmEmeGThcvX3bvzO6
    sD9Yc9drLXLyLkB3YAQicyCnwfMC4lQZJLGjr8qwo01+s5p2fOZtwVLuepcK0Iv7
    3PafkilpQjgVWPjYcerMavRzDFYRd7JJmCBUjuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520693572; bh=A
    2NWsqU+arNaTuOl14J71vdtETMHaVZQLRb1XHLFR8c=; b=KOfLJOeZ7/dlw1IWp
    TtRyZtvRJ5T89sM/9xHdWzRtp9icOUHWsxdpWcMApyaxPm4x/3pghBopz/bc1qhI
    D8petz0hyW7URyxhMT505fvmnw2tYL4hjx6rFNAwv83oIxDejdDhiXkB8pC6c81X
    qbRvxCT8Gmavw+xh8RDBcLfn8m2XLgY3KfRmN0ANFtWIws+kqWsIRTYSX2TrflGT
    bTVI4OYu+hgmX4DeE8x9JG0u3OvdHNElwN+vcqaztuBrxB2rpgsVLvTO1enJINym
    czyd4Bc5L1mYpD+F232SeIz9uUSjmQCszYgzpODNGpQvc9kESqgDH+KY3zLAV4mw
    IstiQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
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
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB9A20685
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 10 Mar 2018 14:52:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 10/12] staging: iio: tsl2x7x: make logging consistent
 and correct newlines
Message-ID: <20180310145240.40cac123@archlinux>
In-Reply-To: <20180304014942.18727-11-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
 <20180304014942.18727-11-masneyb@onstation.org>
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

On Sat,  3 Mar 2018 20:49:40 -0500
Brian Masney <masneyb@onstation.org> wrote:

> This patch updates all of the logging commands so that they are
> consistent with the other messages, includes __func__ in the message,
> and all of the messages include newlines.
> 
> This patch also removes some debug log messages from tsl2x7x_prox_cal().
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Hmm. I nearly fixed this one up but there are a few too many elements I don't
agree with.

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 58 ++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index da7a4e025083..fb91c46c8747 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -378,7 +378,8 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  		ret = i2c_smbus_read_byte_data(chip->client, reg);
>  		if (ret < 0) {
>  			dev_err(&chip->client->dev,
> -				"failed to read. err=%x\n", ret);
> +				"%s: failed to read from register %x: %d\n",
> +				__func__, reg, ret);
>  			goto out_unlock;
>  		}
>  
> @@ -424,7 +425,9 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
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
> @@ -600,7 +603,8 @@ static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
>  
>  	chip->settings.als_gain_trim = ret;
>  	dev_info(&chip->client->dev,
> -		 "%s als_calibrate completed\n", chip->client->name);
> +		 "%s: %s ALS calibration successfully completed\n",
> +		 __func__, chip->client->name);
I'm happy with having function name in errors, but it's just noise in info
prints.

Mind you this dev_info should go or become dev_dbg - it is superflous
detail to put in the kernel logs.

>  
>  	return ret;
>  }
> @@ -644,7 +648,8 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  	/* and make sure we're not already on */
>  	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
>  		/* if forcing a register update - turn off, then on */
> -		dev_info(&chip->client->dev, "device is already enabled\n");
> +		dev_info(&chip->client->dev, "%s: device is already enabled\n",
> +			 __func__);
Again noise.  dev_dbg or drop entirely as it doesn't need to be logged.
>  		return -EINVAL;
>  	}
>  
> @@ -681,12 +686,14 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
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
> @@ -708,7 +715,8 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_WORKING;
>  
>  	if (chip->settings.interrupts_en != 0) {
> -		dev_info(&chip->client->dev, "Setting Up Interrupt(s)\n");
> +		dev_info(&chip->client->dev, "%s: Setting up interrupt(s)\n",
> +			 __func__);
>  
>  		reg_val = TSL2X7X_CNTL_PWR_ON | TSL2X7X_CNTL_ADC_ENBL;
>  		if (chip->settings.interrupts_en == 0x20 ||
> @@ -819,8 +827,8 @@ static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>  
>  	if (chip->settings.prox_max_samples_cal > MAX_SAMPLES_CAL) {
>  		dev_err(&chip->client->dev,
> -			"max prox samples cal is too big: %d\n",
> -			chip->settings.prox_max_samples_cal);
> +			"%s: prox_max_samples_cal %d is too big\n",
> +			__func__, chip->settings.prox_max_samples_cal);
>  		chip->settings.prox_max_samples_cal = MAX_SAMPLES_CAL;
>  	}
>  
> @@ -845,8 +853,6 @@ static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>  		if (ret < 0)
>  			return ret;
>  		prox_history[i] = chip->prox_data;
> -		dev_info(&chip->client->dev, "2 i=%d prox data= %d\n",
> -			 i, chip->prox_data);
>  	}
>  
>  	ret = tsl2x7x_chip_off(indio_dev);
> @@ -857,12 +863,6 @@ static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>  			       chip->settings.prox_max_samples_cal, cal);
>  	chip->settings.prox_thres_high = (cal->max << 1) - cal->mean;
>  
> -	dev_info(&chip->client->dev, " cal min=%d mean=%d max=%d\n",
> -		 cal->min, cal->mean, cal->max);
> -	dev_info(&chip->client->dev,
> -		 "%s proximity threshold set to %d\n",
> -		 chip->client->name, chip->settings.prox_thres_high);
> -
>  	/* back to the way they were */
>  	chip->settings.interrupts_en = tmp_irq_settings;
>  	if (current_state == TSL2X7X_CHIP_WORKING) {
> @@ -1000,12 +1000,14 @@ static ssize_t in_illuminance0_lux_table_store(struct device *dev,
>  	n = value[0];
>  	if ((n % 3) || n < 6 ||
>  	    n > ((ARRAY_SIZE(chip->tsl2x7x_device_lux) - 1) * 3)) {
> -		dev_info(dev, "LUX TABLE INPUT ERROR 1 Value[0]=%d\n", n);
> +		dev_info(dev, "%s: lux table input error 1. n=%d\n",
> +			 __func__, n);
>  		return -EINVAL;
>  	}
>  
>  	if ((value[(n - 2)] | value[(n - 1)] | value[n]) != 0) {
> -		dev_info(dev, "LUX TABLE INPUT ERROR 2 Value[0]=%d\n", n);
> +		dev_info(dev, "%s: lux table input error 2. n=%d\n",
> +			 __func__, n);
dev_dbg or drop it.

>  		return -EINVAL;
>  	}
>  
> @@ -1150,14 +1152,14 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
>  			chip->settings.persistence &= 0xF0;
>  			chip->settings.persistence |=
>  				(filter_delay & 0x0F);
> -			dev_info(&chip->client->dev, "%s: ALS persistence = %d",
> +			dev_info(&chip->client->dev, "%s: ALS persistence = %d\n",
>  				 __func__, filter_delay);
Again, dev_dbg at the most - or drop it.

>  		} else {
>  			chip->settings.persistence &= 0x0F;
>  			chip->settings.persistence |=
>  				((filter_delay << 4) & 0xF0);
>  			dev_info(&chip->client->dev,
> -				 "%s: Proximity persistence = %d",
> +				 "%s: Proximity persistence = %d\n",
>  				 __func__, filter_delay);
>  		}
>  		ret = 0;
> @@ -1372,7 +1374,7 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  		chip->settings.als_time =
>  			TSL2X7X_MAX_TIMER_CNT - (val2 / TSL2X7X_MIN_ITIME);
>  
> -		dev_info(&chip->client->dev, "%s: als time = %d",
> +		dev_info(&chip->client->dev, "%s: als time = %d\n",
>  			 __func__, chip->settings.als_time);
Drop it.
>  		break;
>  	default:
> @@ -1738,8 +1740,9 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
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
> @@ -1773,7 +1776,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  						indio_dev);
>  		if (ret) {
>  			dev_err(&clientp->dev,
> -				"%s: irq request failed", __func__);
> +				"%s: IRQ request failed\n", __func__);
>  			return ret;
>  		}
>  	}
> @@ -1790,7 +1793,8 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  		return ret;
>  	}
>  
> -	dev_info(&clientp->dev, "%s Light sensor found.\n", id->name);
> +	dev_info(&clientp->dev, "%s: %s Light sensor found.\n", __func__,
> +		 id->name);

Again, unnecessary logging.  Definitely doesn't also want the function name.
People 'might' care about whether the sensor is found, but not which function
it is in.

Jonathan

>  
>  	return 0;
>  }

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
