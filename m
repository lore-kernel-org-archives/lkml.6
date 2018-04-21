Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-364443-1524328650-2-11233171065435512475
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524328649; b=geKC0xnlSluqfavcYAYtvpuklgCp2ID3qIzF6Bsmk4tJTQe5Vn
    h0tH2MTJ6tJZ3rhk+IT2sYi94QYvT/Nfpg6bJrkzbV1q4cDMHk6Kq16tlYXD5RE3
    5aDlHKRXBn3dM464tGgTitkEjNv/dgtcUsClkIMSDSv9OvJkXlfjdFLkgT/B+V9p
    lq0LpYgUh0fg9/PC3Up9SXABVeWVv2iZBIr9tuZ2ziD/mZ1nurdp08h36yCuX+jU
    f27tzo9yoge0xt+6ROn2MLRNHhiZ05qJJSO3VGcXhoBiGkafXYNPCl8SEeVnVr1d
    DAMHXQusVj3n/oWENwT02LqF/5nYUft/F7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524328649; bh=f98s2
    O1QBP+wtC+aB+qwdsi7JvmD6/0pLLkBpmF0qoA=; b=BFvHqsBfg2WE1jme6M87a
    Hjwn9BdFMm6SZlh35yiA1opUBUfHvrtjV+fczP4cCJWjDgYWfAAlh+o7K2X3rsWX
    6GDZ6HzX78fXsPrBcaafrzWYIvQ6ufmauYfOo/ZnH0nTUAkbnGZ5Pk8PTjzxnQ0a
    jrXIod/KA1Ujveedp8OBKA7hiZCGtYO/iSk+CI3/LTLln4DmUBOckMA5Bet5EtCO
    h3jbiU3tHxH9zcdOyTmI0nDieW0hgMMP9obbMCdrvEe/GQ2pu5GPF52fUI9V7TfH
    N8uAsxjsw7idGFOUqXJiNCWJiajSZrRyBe81oMhG/a0489ZrQSrqUY+qYmcI0uaY
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLEIeubP2h/BpiWZHrudF/zGHQBGkP+3Wje9NBZh1WbIt5Zw34fkfbTSkmtwrHEn+ohTUSyAP/wXDKkHFLx4ljbEw43UhLdQoUX3eL37Q37HF1/xMaO1
    kh1/ROJs9mfrbN95czyx8jED8W6hy1QB0E4GhBjl3c+TfHNbUIAZbfGcA2f/UGnUMWBiOEX//JbJr/Xg4ALITcs+ltYkR7sL/GSTOjH4OJEIvNljT7lSOVFD
    EEtGakqsINCFyDubS0uU9A==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=MYk5M7uxGa9hUetTriQA:9 a=KJe6pt6vhHgVvSjS:21 a=EJ_Pgm2TGRiO9YAW:21
    a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EED521742
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 17:37:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 12/13] staging: iio: tsl2x7x: various comment cleanups
Message-ID: <20180421173712.1b81affc@archlinux>
In-Reply-To: <20180421004153.19073-13-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
 <20180421004153.19073-13-masneyb@onstation.org>
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

On Fri, 20 Apr 2018 20:41:52 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch removes several unnecessary comments, changes some comments
> so that the use as much of the allowable 80 characters as possible, adds
> the proper whitespace, removes some structure members from the kernel
> docs that are no longer present, and improves the existing kernel doc
> information for some existing structure members.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Looks sensible

Applied,

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 59 +++++++++++++++++--------------------
>  drivers/staging/iio/light/tsl2x7x.h | 48 +++++++++++++++---------------
>  2 files changed, 51 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 293810ff11b9..05c0f3d5fac0 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1,6 +1,6 @@
>  /*
> - * Device driver for monitoring ambient light intensity in (lux)
> - * and proximity detection (prox) within the TAOS TSL2X7X family of devices.
> + * Device driver for monitoring ambient light intensity in (lux) and proximity
> + * detection (prox) within the TAOS TSL2X7X family of devices.
>   *
>   * Copyright (c) 2012, TAOS Corporation.
>   * Copyright (c) 2017-2018 Brian Masney <masneyb@onstation.org>
> @@ -21,7 +21,7 @@
>  #include <linux/iio/sysfs.h>
>  #include "tsl2x7x.h"
>  
> -/* Cal defs*/
> +/* Cal defs */
>  #define PROX_STAT_CAL			0
>  #define PROX_STAT_SAMP			1
>  #define MAX_SAMPLES_CAL			200
> @@ -34,10 +34,11 @@
>  /* Lux calculation constants */
>  #define TSL2X7X_LUX_CALC_OVER_FLOW	65535
>  
> -/* TAOS Register definitions - note:
> - * depending on device, some of these register are not used and the
> - * register address is benign.
> +/*
> + * TAOS Register definitions - Note: depending on device, some of these register
> + * are not used and the register address is benign.
>   */
> +
>  /* 2X7X register offsets */
>  #define TSL2X7X_MAX_CONFIG_REG		16
>  
> @@ -342,15 +343,14 @@ static int tsl2x7x_read_autoinc_regs(struct tsl2X7X_chip *chip, int lower_reg,
>   * @indio_dev:	pointer to IIO device
>   *
>   * The raw ch0 and ch1 values of the ambient light sensed in the last
> - * integration cycle are read from the device.
> - * Time scale factor array values are adjusted based on the integration time.
> - * The raw values are multiplied by a scale factor, and device gain is obtained
> - * using gain index. Limit checks are done next, then the ratio of a multiple
> - * of ch1 value, to the ch0 value, is calculated. Array tsl2x7x_device_lux[]
> - * is then scanned to find the first ratio value that is just above the ratio
> - * we just calculated. The ch0 and ch1 multiplier constants in the array are
> - * then used along with the time scale factor array values, to calculate the
> - * lux.
> + * integration cycle are read from the device. Time scale factor array values
> + * are adjusted based on the integration time. The raw values are multiplied
> + * by a scale factor, and device gain is obtained using gain index. Limit
> + * checks are done next, then the ratio of a multiple of ch1 value, to the
> + * ch0 value, is calculated. Array tsl2x7x_device_lux[] is then scanned to
> + * find the first ratio value that is just above the ratio we just calculated.
> + * The ch0 and ch1 multiplier constants in the array are then used along with
> + * the time scale factor array values, to calculate the lux.
>   */
>  static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  {
> @@ -363,7 +363,6 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  	mutex_lock(&chip->als_mutex);
>  
>  	if (chip->tsl2x7x_chip_status != TSL2X7X_CHIP_WORKING) {
> -		/* device is not enabled */
>  		dev_err(&chip->client->dev, "%s: device is not enabled\n",
>  			__func__);
>  		ret = -EBUSY;
> @@ -374,7 +373,6 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  	if (ret < 0)
>  		goto out_unlock;
>  
> -	/* is data new & valid */
>  	if (!(ret & TSL2X7X_STA_ADC_VALID)) {
>  		dev_err(&chip->client->dev,
>  			"%s: data not valid yet\n", __func__);
> @@ -430,12 +428,12 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  		lux = (lux + (chip->als_time_scale >> 1)) /
>  			chip->als_time_scale;
>  
> -	/* adjust for active gain scale
> -	 * The tsl2x7x_device_lux tables have a factor of 256 built-in.
> -	 * User-specified gain provides a multiplier.
> +	/*
> +	 * adjust for active gain scale. The tsl2x7x_device_lux tables have a
> +	 * factor of 256 built-in. User-specified gain provides a multiplier.
>  	 * Apply user-specified gain before shifting right to retain precision.
> -	 * Use 64 bits to avoid overflow on multiplication.
> -	 * Then go back to 32 bits before division to avoid using div_u64().
> +	 * Use 64 bits to avoid overflow on multiplication. Then go back to
> +	 * 32 bits before division to avoid using div_u64().
>  	 */
>  
>  	lux64 = lux;
> @@ -713,14 +711,13 @@ static int tsl2x7x_chip_off(struct iio_dev *indio_dev)
>  }
>  
>  /**
> - * tsl2x7x_invoke_change
> + * tsl2x7x_invoke_change - power cycle the device to implement the user
> + *                         parameters
>   * @indio_dev:	pointer to IIO device
>   *
> - * Obtain and lock both ALS and PROX resources,
> - * determine and save device state (On/Off),
> - * cycle device to implement updated parameter,
> - * put device back into proper state, and unlock
> - * resource.
> + * Obtain and lock both ALS and PROX resources, determine and save device state
> + * (On/Off), cycle device to implement updated parameter, put device back into
> + * proper state, and unlock resource.
>   */
>  static int tsl2x7x_invoke_change(struct iio_dev *indio_dev)
>  {
> @@ -895,7 +892,8 @@ static ssize_t in_illuminance0_lux_table_store(struct device *dev,
>  
>  	get_options(buf, ARRAY_SIZE(value), value);
>  
> -	/* We now have an array of ints starting at value[1], and
> +	/*
> +	 * We now have an array of ints starting at value[1], and
>  	 * enumerated by value[0].
>  	 * We expect each group of three ints is one table entry,
>  	 * and the last table entry is all 0.
> @@ -1643,9 +1641,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  		}
>  	}
>  
> -	/* Load up the defaults */
>  	tsl2x7x_defaults(chip);
> -	/* Make sure the chip is on */
>  	tsl2x7x_chip_on(indio_dev);
>  
>  	ret = iio_device_register(indio_dev);
> @@ -1719,7 +1715,6 @@ static const struct dev_pm_ops tsl2x7x_pm_ops = {
>  	.resume  = tsl2x7x_resume,
>  };
>  
> -/* Driver definition */
>  static struct i2c_driver tsl2x7x_driver = {
>  	.driver = {
>  		.name = "tsl2x7x",
> diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> index 408e5a89edb1..85d8fe7a94c8 100644
> --- a/drivers/staging/iio/light/tsl2x7x.h
> +++ b/drivers/staging/iio/light/tsl2x7x.h
> @@ -36,32 +36,35 @@ struct tsl2x7x_lux {
>  #define TSL2X7X_MAX_TIMER_CNT           0xFF
>  
>  /**
> - * struct tsl2x7x_default_settings - power on defaults unless
> - *                                   overridden by platform data.
> - *  @als_time:              ALS Integration time - multiple of 50mS
> - *  @als_gain:              Index into the ALS gain table.
> - *  @als_gain_trim:         default gain trim to account for
> - *                          aperture effects.
> - *  @wait_time:             Time between PRX and ALS cycles
> - *                          in 2.7 periods
> - *  @prox_time:             5.2ms prox integration time -
> - *                          decrease in 2.7ms periods
> - *  @prox_gain:             Proximity gain index
> + * struct tsl2x7x_settings - Settings for the tsl2x7x driver
> + *  @als_time:              Integration time of the ALS channel ADCs in 2.73 ms
> + *                          increments. Total integration time is
> + *                          (256 - als_time) * 2.73.
> + *  @als_gain:              Index into the tsl2x7x_als_gain array.
> + *  @als_gain_trim:         Default gain trim to account for aperture effects.
> + *  @wait_time:             Time between proximity and ALS cycles in 2.73
> + *                          periods.
> + *  @prox_time:             Integration time of the proximity ADC in 2.73 ms
> + *                          increments. Total integration time is
> + *                          (256 - prx_time) * 2.73.
> + *  @prox_gain:             Index into the tsl2x7x_prx_gain array.
>   *  @prox_config:           Prox configuration filters.
> - *  @als_cal_target:        Known external ALS reading for
> - *                          calibration.
> - *  @als_persistence:       H/W Filters, Number of 'out of limits'
> - *                          ALS readings.
> + *  @als_cal_target:        Known external ALS reading for calibration.
> + *  @als_persistence:       H/W Filters, Number of 'out of limits' ALS readings.
>   *  @als_interrupt_en:      Enable/Disable ALS interrupts
>   *  @als_thresh_low:        CH0 'low' count to trigger interrupt.
>   *  @als_thresh_high:       CH0 'high' count to trigger interrupt.
> - *  @prox_persistence:      H/W Filters, Number of 'out of limits'
> - *                          proximity readings.
> - *  @prox_interrupt_en:     Enable/Disable proximity interrupts
> + *  @prox_persistence:      H/W Filters, Number of 'out of limits' proximity
> + *                          readings.
> + *  @prox_interrupt_en:     Enable/Disable proximity interrupts.
>   *  @prox_thres_low:        Low threshold proximity detection.
> - *  @prox_thres_high:       High threshold proximity detection
> - *  @prox_pulse_count:      Number if proximity emitter pulses
> - *  @prox_max_samples_cal:  Used for prox cal.
> + *  @prox_thres_high:       High threshold proximity detection.
> + *  @prox_pulse_count:      Number if proximity emitter pulses.
> + *  @prox_max_samples_cal:  The number of samples that are taken when performing
> + *                          a proximity calibration.
> + *  @prox_diode             Which diode(s) to use for driving the external
> + *                          LED(s) for proximity sensing.
> + *  @prox_power             The amount of power to use for the external LED(s).
>   */
>  struct tsl2x7x_settings {
>  	int als_time;
> @@ -88,9 +91,6 @@ struct tsl2x7x_settings {
>  
>  /**
>   * struct tsl2X7X_platform_data - Platform callback, glass and defaults
> - * @platform_power:            Suspend/resume platform callback
> - * @power_on:                  Power on callback
> - * @power_off:                 Power off callback
>   * @platform_lux_table:        Device specific glass coefficents
>   * @platform_default_settings: Device specific power on defaults
>   *

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
