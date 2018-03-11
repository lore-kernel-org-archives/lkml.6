Return-Path: <jic23@jic23.retrosnub.co.uk>
X-Google-Smtp-Source: AG47ELvOuR8PZCLLE+3gMCd+CnKWVDc1DsfaG8D3TVSSCGU+EgJLqRGXVkpWtOlkIaSi2DIacuVh
ARC-Seal: i=1; a=rsa-sha256; t=1520775950; cv=none;
        d=google.com; s=arc-20160816;
        b=X2qTVhnMTlCmjO4VVuURgay5D7E/YpqGlykMFY/6pRt5K3rP0jUrK+LQK7nbVBYdwC
         ah0MpKJ70mJ4dGeVUN/Bz0Pj4HgCLs1Nfg3r4j0VQeIqLiTPAdEtOLC89lNVsFcFEt14
         gFU7MoK2UhfJdIWFhSK69DivAEtBUilCW1ut8x9KfqpoUIyqvGzWubdEBR/1AJKLCUeW
         X6Ya/Yj1j3NXFAcH43y0oRDTrpPeRM0+AloJ1kXVS2ebmQfHpobNMjFPJDfRmJfaXT2L
         vijk5ytGQcXS1uk5+CK2LuB0FdlR8jTfgH3bKO6flyx52Mh+7zUpD9d21MxpoTYZvrpK
         B1FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=JNnovfc8w0y5TfCI+k86JAioyyjF96JQn0Zgt580bUc=;
        b=g8n0SFFf3hASc/9vxrSIzm0RPcVnYJ44x4PLF5Pyz+p05gY0FJWuNi+QphVJ6GunZn
         OwJ4itIw+6BqOonhlU0fRqsSoldDUicTQLxhAYUkaM6dxjHlPIQzwyrNLOXHekYHdEtc
         JdVjNgja2qhrih4FMfVlPkbk4VW3pjFKgeqgkCpiOvbHzkfcUigIlDkF+O328HdcsHmg
         hyVk0tb5Kaj62TMH0N0Y5ow0RH/digZEqhg7Jm0CYhHTgz52U3ZlQpfN4Ix2by+4sin4
         YCr9DMqyaiOTqbMzSy30lPRMSNhTdAv+o8Ug7Ha0/1MYAav7HQbQlFVkILDuaXeBom8a
         A3cw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jic23@jic23.retrosnub.co.uk designates 2a00:1098:86::1:1 as permitted sender) smtp.mailfrom=jic23@jic23.retrosnub.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jic23@jic23.retrosnub.co.uk designates 2a00:1098:86::1:1 as permitted sender) smtp.mailfrom=jic23@jic23.retrosnub.co.uk
Date: Sun, 11 Mar 2018 13:45:47 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
 devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
 pmeerw@pmeerw.net, linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: Re: [PATCH 10/12] staging: iio: tsl2x7x: make logging consistent
 and correct newlines
Message-ID: <20180311134547.05312856@archlinux>
In-Reply-To: <20180310145240.40cac123@archlinux>
References: <20180304014942.18727-1-masneyb@onstation.org>
	<20180304014942.18727-11-masneyb@onstation.org>
	<20180310145240.40cac123@archlinux>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593969942360641174?=
X-GMAIL-MSGID: =?utf-8?q?1594649163340493836?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 10 Mar 2018 14:52:40 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat,  3 Mar 2018 20:49:40 -0500
> Brian Masney <masneyb@onstation.org> wrote:
> 
> > This patch updates all of the logging commands so that they are
> > consistent with the other messages, includes __func__ in the message,
> > and all of the messages include newlines.
> > 
> > This patch also removes some debug log messages from tsl2x7x_prox_cal().
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>  
> Hmm. I nearly fixed this one up but there are a few too many elements I don't
> agree with.

I knew there was something I was forgetting.  There is no point in
putting function names in dynamic debug calls, you can turn that
on if you want it for all of them anyway.

Jonathan
> 
> > ---
> >  drivers/staging/iio/light/tsl2x7x.c | 58 ++++++++++++++++++++-----------------
> >  1 file changed, 31 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> > index da7a4e025083..fb91c46c8747 100644
> > --- a/drivers/staging/iio/light/tsl2x7x.c
> > +++ b/drivers/staging/iio/light/tsl2x7x.c
> > @@ -378,7 +378,8 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
> >  		ret = i2c_smbus_read_byte_data(chip->client, reg);
> >  		if (ret < 0) {
> >  			dev_err(&chip->client->dev,
> > -				"failed to read. err=%x\n", ret);
> > +				"%s: failed to read from register %x: %d\n",
> > +				__func__, reg, ret);
> >  			goto out_unlock;
> >  		}
> >  
> > @@ -424,7 +425,9 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
> >  
> >  	/* note: lux is 31 bit max at this point */
> >  	if (ch1lux > ch0lux) {
> > -		dev_dbg(&chip->client->dev, "ch1lux > ch0lux-return last value\n");
> > +		dev_dbg(&chip->client->dev,
> > +			"%s: ch1lux > ch0lux; returning last value\n",
> > +			__func__);
> >  		ret = chip->als_cur_info.lux;
> >  		goto out_unlock;
> >  	}
> > @@ -600,7 +603,8 @@ static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
> >  
> >  	chip->settings.als_gain_trim = ret;
> >  	dev_info(&chip->client->dev,
> > -		 "%s als_calibrate completed\n", chip->client->name);
> > +		 "%s: %s ALS calibration successfully completed\n",
> > +		 __func__, chip->client->name);  
> I'm happy with having function name in errors, but it's just noise in info
> prints.
> 
> Mind you this dev_info should go or become dev_dbg - it is superflous
> detail to put in the kernel logs.
> 
> >  
> >  	return ret;
> >  }
> > @@ -644,7 +648,8 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
> >  	/* and make sure we're not already on */
> >  	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
> >  		/* if forcing a register update - turn off, then on */
> > -		dev_info(&chip->client->dev, "device is already enabled\n");
> > +		dev_info(&chip->client->dev, "%s: device is already enabled\n",
> > +			 __func__);  
> Again noise.  dev_dbg or drop entirely as it doesn't need to be logged.
> >  		return -EINVAL;
> >  	}
> >  
> > @@ -681,12 +686,14 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
> >  	 */
> >  	for (i = 0, dev_reg = chip->tsl2x7x_config;
> >  			i < TSL2X7X_MAX_CONFIG_REG; i++) {
> > -		ret = i2c_smbus_write_byte_data(chip->client,
> > -						TSL2X7X_CMD_REG + i,
> > +		int reg = TSL2X7X_CMD_REG + i;
> > +
> > +		ret = i2c_smbus_write_byte_data(chip->client, reg,
> >  						*dev_reg++);
> >  		if (ret < 0) {
> >  			dev_err(&chip->client->dev,
> > -				"failed on write to reg %d.\n", i);
> > +				"%s: failed to write to register %x: %d\n",
> > +				__func__, reg, ret);
> >  			return ret;
> >  		}
> >  	}
> > @@ -708,7 +715,8 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
> >  	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_WORKING;
> >  
> >  	if (chip->settings.interrupts_en != 0) {
> > -		dev_info(&chip->client->dev, "Setting Up Interrupt(s)\n");
> > +		dev_info(&chip->client->dev, "%s: Setting up interrupt(s)\n",
> > +			 __func__);
> >  
> >  		reg_val = TSL2X7X_CNTL_PWR_ON | TSL2X7X_CNTL_ADC_ENBL;
> >  		if (chip->settings.interrupts_en == 0x20 ||
> > @@ -819,8 +827,8 @@ static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
> >  
> >  	if (chip->settings.prox_max_samples_cal > MAX_SAMPLES_CAL) {
> >  		dev_err(&chip->client->dev,
> > -			"max prox samples cal is too big: %d\n",
> > -			chip->settings.prox_max_samples_cal);
> > +			"%s: prox_max_samples_cal %d is too big\n",
> > +			__func__, chip->settings.prox_max_samples_cal);
> >  		chip->settings.prox_max_samples_cal = MAX_SAMPLES_CAL;
> >  	}
> >  
> > @@ -845,8 +853,6 @@ static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
> >  		if (ret < 0)
> >  			return ret;
> >  		prox_history[i] = chip->prox_data;
> > -		dev_info(&chip->client->dev, "2 i=%d prox data= %d\n",
> > -			 i, chip->prox_data);
> >  	}
> >  
> >  	ret = tsl2x7x_chip_off(indio_dev);
> > @@ -857,12 +863,6 @@ static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
> >  			       chip->settings.prox_max_samples_cal, cal);
> >  	chip->settings.prox_thres_high = (cal->max << 1) - cal->mean;
> >  
> > -	dev_info(&chip->client->dev, " cal min=%d mean=%d max=%d\n",
> > -		 cal->min, cal->mean, cal->max);
> > -	dev_info(&chip->client->dev,
> > -		 "%s proximity threshold set to %d\n",
> > -		 chip->client->name, chip->settings.prox_thres_high);
> > -
> >  	/* back to the way they were */
> >  	chip->settings.interrupts_en = tmp_irq_settings;
> >  	if (current_state == TSL2X7X_CHIP_WORKING) {
> > @@ -1000,12 +1000,14 @@ static ssize_t in_illuminance0_lux_table_store(struct device *dev,
> >  	n = value[0];
> >  	if ((n % 3) || n < 6 ||
> >  	    n > ((ARRAY_SIZE(chip->tsl2x7x_device_lux) - 1) * 3)) {
> > -		dev_info(dev, "LUX TABLE INPUT ERROR 1 Value[0]=%d\n", n);
> > +		dev_info(dev, "%s: lux table input error 1. n=%d\n",
> > +			 __func__, n);
> >  		return -EINVAL;
> >  	}
> >  
> >  	if ((value[(n - 2)] | value[(n - 1)] | value[n]) != 0) {
> > -		dev_info(dev, "LUX TABLE INPUT ERROR 2 Value[0]=%d\n", n);
> > +		dev_info(dev, "%s: lux table input error 2. n=%d\n",
> > +			 __func__, n);  
> dev_dbg or drop it.
> 
> >  		return -EINVAL;
> >  	}
> >  
> > @@ -1150,14 +1152,14 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
> >  			chip->settings.persistence &= 0xF0;
> >  			chip->settings.persistence |=
> >  				(filter_delay & 0x0F);
> > -			dev_info(&chip->client->dev, "%s: ALS persistence = %d",
> > +			dev_info(&chip->client->dev, "%s: ALS persistence = %d\n",
> >  				 __func__, filter_delay);  
> Again, dev_dbg at the most - or drop it.
> 
> >  		} else {
> >  			chip->settings.persistence &= 0x0F;
> >  			chip->settings.persistence |=
> >  				((filter_delay << 4) & 0xF0);
> >  			dev_info(&chip->client->dev,
> > -				 "%s: Proximity persistence = %d",
> > +				 "%s: Proximity persistence = %d\n",
> >  				 __func__, filter_delay);
> >  		}
> >  		ret = 0;
> > @@ -1372,7 +1374,7 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
> >  		chip->settings.als_time =
> >  			TSL2X7X_MAX_TIMER_CNT - (val2 / TSL2X7X_MIN_ITIME);
> >  
> > -		dev_info(&chip->client->dev, "%s: als time = %d",
> > +		dev_info(&chip->client->dev, "%s: als time = %d\n",
> >  			 __func__, chip->settings.als_time);  
> Drop it.
> >  		break;
> >  	default:
> > @@ -1738,8 +1740,9 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
> >  
> >  	ret = i2c_smbus_write_byte(clientp, TSL2X7X_CMD_REG | TSL2X7X_CNTRL);
> >  	if (ret < 0) {
> > -		dev_err(&clientp->dev, "write to cmd reg failed. err = %d\n",
> > -			ret);
> > +		dev_err(&clientp->dev,
> > +			"%s: Failed to write to CMD register: %d\n",
> > +			__func__, ret);
> >  		return ret;
> >  	}
> >  
> > @@ -1773,7 +1776,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
> >  						indio_dev);
> >  		if (ret) {
> >  			dev_err(&clientp->dev,
> > -				"%s: irq request failed", __func__);
> > +				"%s: IRQ request failed\n", __func__);
> >  			return ret;
> >  		}
> >  	}
> > @@ -1790,7 +1793,8 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
> >  		return ret;
> >  	}
> >  
> > -	dev_info(&clientp->dev, "%s Light sensor found.\n", id->name);
> > +	dev_info(&clientp->dev, "%s: %s Light sensor found.\n", __func__,
> > +		 id->name);  
> 
> Again, unnecessary logging.  Definitely doesn't also want the function name.
> People 'might' care about whether the sensor is found, but not which function
> it is in.
> 
> Jonathan
> 
> >  
> >  	return 0;
> >  }  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
