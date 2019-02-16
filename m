Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EADAC10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 11:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9D1222A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 11:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R40csO1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfBPL1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 06:27:34 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44663 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfBPL1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 06:27:33 -0500
Received: by mail-pg1-f196.google.com with SMTP id y1so6063337pgk.11;
        Sat, 16 Feb 2019 03:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BG7fU3dG7jT27JKy53QKZo/I4tJVLY9J5qRkRXSsDYk=;
        b=R40csO1KnhJhugOczK/xVGHjVYMaQtJdc3TifEXV0BQet+2pM6+LYNgkznfLtj4vqs
         79+MH1+Ci6pg240LVoDo54YI37UpvYIg/ZUpfskXvalYXYVXbpMaqJybFxa9liQWEe0q
         YwhIIFrqV08GNP3XxDHmvKsnFy4VaWav2m7WkG6//NYISDGyTZVxEtsE0y0eWrAfBuhO
         CdyNzF/wVvIWPN4wk/FJR84hD3cAFbivpUZvgRLa7I5VXABcD74jDuD2aEDTUizvL3r1
         9zVynJnsuzGOvX3+qMwKFB7+9iPcNoBQiAcVSYti/dDHiuKXTg1IhSCFMgmcp+ROIAuE
         +Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BG7fU3dG7jT27JKy53QKZo/I4tJVLY9J5qRkRXSsDYk=;
        b=YdujxuydU7hWe8NfbT232KQCFHMxcMcLphWgAfloEzYfk0SeCXbEbni6Mjmpd+vFKS
         SSngb6VXZKynHaLUj23VMKSNRPnD/4KtwNroCF731t8MnlgYdLO8gol6VT8N0HwWdUGW
         yZtm4lV9tknHpzPHb5D5opXstSvzgE+iPHPh8shINXJzIOt5jcIGQ3HDQbGjMbCMvc2k
         2YxN6SlnnWgDbQUxzZoCBHeku9YnrC8ld9RP1x32vYGsLqWekXxQk+g76XQ3eH9DKSNZ
         iO8iUuFfz7ydkWmdZJbWJJeUAYq9xNHymCtrD+fk3a7AnVogmWKxWOCScxmLseTCA1QD
         rEhg==
X-Gm-Message-State: AHQUAubNKRlsYoVq1U1g0uDUtGm8BODOyAxnX5Bzbxq/LUuxH22VbVC4
        sTwq/6JU1TgzBWmQcX9COQ4=
X-Google-Smtp-Source: AHgI3IZL7921KaYzeFBllCxZOpXvh/bIGyX+wfA8wfIiLZFhDGk7C880ZwkyLd+7ssuSC0l2INYEfQ==
X-Received: by 2002:a62:b286:: with SMTP id z6mr14406482pfl.106.1550316452333;
        Sat, 16 Feb 2019 03:27:32 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.77.42.124])
        by smtp.gmail.com with ESMTPSA id e21sm35450843pfh.45.2019.02.16.03.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 03:27:31 -0800 (PST)
Date:   Sat, 16 Feb 2019 16:57:22 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, dpfrey@gmail.com, colin.king@canonical.com
Subject: Re: [PATCH] iio/chemical/bme680: Fix SPI read interface
Message-ID: <20190216112722.GA28619@himanshu-Vostro-3559>
References: <1550238475-25698-1-git-send-email-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1550238475-25698-1-git-send-email-mike.looijmans@topic.nl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike,

On Fri, Feb 15, 2019 at 02:47:55PM +0100, Mike Looijmans wrote:
> The SPI interface implementation was completely broken.

My apologies!

SPI interface caused me a lot of trouble in my project timeline. I tried
many different ways to try playing with acpi dsl, printks etc. One
of the problem was also that we don't have any facility such `i2cdetect`
or instantiate a `new_device` from userspace.

Are there any methods that one should try to debug SPIs ?
 -- excluding the use of Oscilloscope

With all these problems, I referred other drivers from the Bosch family,
particularly BME280 which has exactly the same behavior and decided to
do the same. I believed that it would also work cleanly for BME680 and
now I see the page selection fuzz was the main problem.

I tried to test it on Beaglebone but everytime something new pops-up
with beagle setup such as they moved from capemgr -> uboot overlays.
Lack of latest documentation on "What new in this release?" troubled me
+ most of blogs on setup are outdated.

> When using the SPI interface, there are only 7 address bits, the upper bit
> is controlled by a page select register.

Isn't it that upper bit is controlled R/W ?

And one question that I have in mind:

Initially after poweron we are in page 0, and hence we can't access
Page 1 which actually has the `spi_mem_page` bit. So, how can we switch
to Page 1 eventually since Page 1 covers all the relevant data/config 
registers ?

I assume if you're in Page 0, then you can't access Page 1 registers or
simply put those registers are not visible.

Some inconsistency in datasheet:

Page 24/50:

"After power-on, spi_mem_page is in its reset state and page 0 (0x80 to 0xFF)
will be active. Page 1 (0x00 to 0x7F) will be
active on setting spi_mem_page to 1."

OTOH,

Page 26/50:

"5.3.1.4 SPI memory map page selection – spi_mem_page

In SPI mode complete memory page is accessed using page 0 & page 1.
Register spi_mem_page is used for page selection.
After power-on, spi_mem_page is in its reset state and 
page 0(0x00 to 0x7F) will be active."


That's contradicting!

	page 0 (0x80 to 0xFF) Vs page 0(0x00 to 0x7F) ?

> The core needs access to both
> ranges, so implement register read/write for both regions. The regmap
> paging functionality didn't agree with a register that needs to be read
> and modified, so I implemented a custom paging algorithm.
> 
> This fixes that the device wouldn't even probe in SPI mode.

Most importantly: Does it now work for you ?

As I tried you patch and it is not working for me in my QEMU setup.

	/sys/bus/iio/devices # lsmod
	Module                  Size  Used by    Tainted: G
	bme680_spi             16384  0
	bme680_core            24576  1 bme680_spi
	/sys/bus/iio/devices # ls

SPI didn't probe and no logs for any errors/warnings as well.

Maybe I'll give it try again later on a different board or a native
build+boot on the current board.

Anyway, does anyone has any idea/clues for writing a dt-overlay for
am335x-boneblack-wireless.dts to add just a compatible property to
probe bme680_spi driver ?

> The SPI interface then isn't different from I2C, merged them into the core,
> and the I2C/SPI named registers are no longer needed.
> 
> Implemented register value caching for the registers to reduce the I2C/SPI
> data transfers considerably.
> 
> The calibration set reads as all zeroes until some undefined point in time,
> and I couldn't determine what makes it valid. The datasheet mentions these
> registers but does not provide any hints on when they become valid, and they
> aren't even enumerated in the memory map. So check the calibration and
> retry reading it from the device after each measurement until it provides
> something valid.

Hmm. One point I would point out here is that: if calib constants are
invalid then without any doubt readings would wrong/disastrous. But I
never saw this issue when testing I2C interface.

As for missing info from datasheet, I mean Bosch doesn't even care to
reply or involve in the discussions. This driver was also ported to
Zephyr project and Pull request lying stale since November. In the end,
developers from Nordic Semiconductor who majorly work on BLE and some
other stuff took over their work and are now trying to complete it.

Also, look around BSEC(https://www.bosch-sensortec.com/bst/products/all_products/bsecreveals)
for more info that you may want to know. And go ahead reverse engineering[1]
their code to know more OR work around and rely on the heuristics[2] that you
observe while testing.

[1] I saw a code snippet in BSEC which says after measurement is completed in
    FORCED mode and data is ready to read, we need to wait for current
    mode go in SLEEP mode before actually reading the data.

[2] One fellow developer few moths ago explained to play with those calib 
    constants as well:
https://lore.kernel.org/linux-iio/20181215191743.GA1263@himanshu-Vostro-3559/

Then there are many things to rant about. But currently I'm busy with
university exams, so I might not be able to work on this till 10th March.

> Report temperature in millidegrees Celcius instead of degrees.

Jonathan, I didn't know about this but is there any rationale to report
in millidegress ?

I was under the impression that degC is the standard and you would
always want you Fitbit/Smart watch to report in degC. Ofcourse,
userspace program can convert millideg -> degC

> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>  drivers/iio/chemical/bme680.h      |   6 +-
>  drivers/iio/chemical/bme680_core.c |  54 ++++++++++++++---
>  drivers/iio/chemical/bme680_i2c.c  |  21 -------
>  drivers/iio/chemical/bme680_spi.c  | 116 +++++++++++++++++++++++++------------
>  4 files changed, 126 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
> index 0ae89b87..4edc5d21 100644
> --- a/drivers/iio/chemical/bme680.h
> +++ b/drivers/iio/chemical/bme680.h
> @@ -2,11 +2,9 @@
>  #ifndef BME680_H_
>  #define BME680_H_
>  
> -#define BME680_REG_CHIP_I2C_ID			0xD0
> -#define BME680_REG_CHIP_SPI_ID			0x50
> +#define BME680_REG_CHIP_ID			0xD0
>  #define   BME680_CHIP_ID_VAL			0x61
> -#define BME680_REG_SOFT_RESET_I2C		0xE0
> -#define BME680_REG_SOFT_RESET_SPI		0x60
> +#define BME680_REG_SOFT_RESET			0xE0
>  #define   BME680_CMD_SOFTRESET			0xB6
>  #define BME680_REG_STATUS			0x73
>  #define   BME680_SPI_MEM_PAGE_BIT		BIT(4)
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 70c1fe4..ccde4c6 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -63,9 +63,23 @@ struct bme680_data {
>  	s32 t_fine;
>  };
>  
> +static const struct regmap_range bme680_volatile_ranges[] = {
> +	regmap_reg_range(BME680_REG_MEAS_STAT_0, BME680_REG_GAS_R_LSB),
> +	regmap_reg_range(BME680_REG_STATUS, BME680_REG_STATUS),
> +	regmap_reg_range(BME680_T2_LSB_REG, BME680_GH3_REG),
> +};
> +
> +static const struct regmap_access_table bme680_volatile_table = {
> +	.yes_ranges	= bme680_volatile_ranges,
> +	.n_yes_ranges	= ARRAY_SIZE(bme680_volatile_ranges),
> +};
> +
>  const struct regmap_config bme680_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
> +	.max_register = 0xef,

Any reason for 0xEF ?

> +	.volatile_table = &bme680_volatile_table,
> +	.cache_type = REGCACHE_RBTREE,
>  };
>  EXPORT_SYMBOL(bme680_regmap_config);
>  
> @@ -316,6 +330,10 @@ static s16 bme680_compensate_temp(struct bme680_data *data,
>  	s64 var1, var2, var3;
>  	s16 calc_temp;
>  
> +	/* If the calibration is invalid, attempt to reload it */
> +	if (!calib->par_t2)
> +		bme680_read_calib(data, calib);

How did you observe this behavior ? Was the readings not correct before ?

>  	var1 = (adc_temp >> 3) - (calib->par_t1 << 1);
>  	var2 = (var1 * calib->par_t2) >> 11;
>  	var3 = ((var1 >> 1) * (var1 >> 1)) >> 12;
> @@ -583,8 +601,7 @@ static int bme680_gas_config(struct bme680_data *data)
>  	return ret;
>  }
>  
> -static int bme680_read_temp(struct bme680_data *data,
> -			    int *val, int *val2)
> +static int bme680_read_temp(struct bme680_data *data, int *val)
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
> @@ -617,10 +634,9 @@ static int bme680_read_temp(struct bme680_data *data,
>  	 * compensate_press/compensate_humid to get compensated
>  	 * pressure/humidity readings.
>  	 */
> -	if (val && val2) {
> -		*val = comp_temp;
> -		*val2 = 100;
> -		return IIO_VAL_FRACTIONAL;
> +	if (val) {
> +		*val = comp_temp * 10; /* Centidegrees to millidegrees */
> +		return IIO_VAL_INT;
>  	}
>  
>  	return ret;
> @@ -635,7 +651,7 @@ static int bme680_read_press(struct bme680_data *data,
>  	s32 adc_press;
>  
>  	/* Read and compensate temperature to get a reading of t_fine */
> -	ret = bme680_read_temp(data, NULL, NULL);
> +	ret = bme680_read_temp(data, NULL);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -668,7 +684,7 @@ static int bme680_read_humid(struct bme680_data *data,
>  	u32 comp_humidity;
>  
>  	/* Read and compensate temperature to get a reading of t_fine */
> -	ret = bme680_read_temp(data, NULL, NULL);
> +	ret = bme680_read_temp(data, NULL);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -761,7 +777,7 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_PROCESSED:
>  		switch (chan->type) {
>  		case IIO_TEMP:
> -			return bme680_read_temp(data, val, val2);
> +			return bme680_read_temp(data, val);
>  		case IIO_PRESSURE:
>  			return bme680_read_press(data, val, val2);
>  		case IIO_HUMIDITYRELATIVE:
> @@ -867,8 +883,28 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
>  {
>  	struct iio_dev *indio_dev;
>  	struct bme680_data *data;
> +	unsigned int val;
>  	int ret;
>  
> +	ret = regmap_write(regmap, BME680_REG_SOFT_RESET,
> +			   BME680_CMD_SOFTRESET);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to reset chip\n");
> +		return ret;
> +	}

FYI Bosch commented to me earlier:

"It is recommended but not mandatory. The idea behind the soft
 reset is to get the driver in sync with the sensor and the 
 fastest way to do so is via a soft reset."

But its good to keep it, nevermind ..

> +	ret = regmap_read(regmap, BME680_REG_CHIP_ID, &val);
> +	if (ret < 0) {
> +		dev_err(dev, "Error reading chip ID\n");
> +		return ret;
> +	}
> +
> +	if (val != BME680_CHIP_ID_VAL) {
> +		dev_err(dev, "Wrong chip ID, got %x expected %x\n",
> +				val, BME680_CHIP_ID_VAL);
> +		return -ENODEV;
> +	}
> +
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
> diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
> index 06d4be5..cfc4449 100644
> --- a/drivers/iio/chemical/bme680_i2c.c
> +++ b/drivers/iio/chemical/bme680_i2c.c
> @@ -23,8 +23,6 @@ static int bme680_i2c_probe(struct i2c_client *client,
>  {
>  	struct regmap *regmap;
>  	const char *name = NULL;
> -	unsigned int val;
> -	int ret;
>  
>  	regmap = devm_regmap_init_i2c(client, &bme680_regmap_config);
>  	if (IS_ERR(regmap)) {
> @@ -33,25 +31,6 @@ static int bme680_i2c_probe(struct i2c_client *client,
>  		return PTR_ERR(regmap);
>  	}
>  
> -	ret = regmap_write(regmap, BME680_REG_SOFT_RESET_I2C,
> -			   BME680_CMD_SOFTRESET);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "Failed to reset chip\n");
> -		return ret;
> -	}
> -
> -	ret = regmap_read(regmap, BME680_REG_CHIP_I2C_ID, &val);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "Error reading I2C chip ID\n");
> -		return ret;
> -	}
> -
> -	if (val != BME680_CHIP_ID_VAL) {
> -		dev_err(&client->dev, "Wrong chip ID, got %x expected %x\n",
> -				val, BME680_CHIP_ID_VAL);
> -		return -ENODEV;
> -	}
> -
>  	if (id)
>  		name = id->name;
>  
> diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
> index c9fb05e..e130715 100644
> --- a/drivers/iio/chemical/bme680_spi.c
> +++ b/drivers/iio/chemical/bme680_spi.c
> @@ -11,28 +11,94 @@
>  
>  #include "bme680.h"
>  
> +struct bme680_spi_bus_context {
> +	struct spi_device *spi;
> +	u8 current_page;
> +};
> +
> +/*
> + * In SPI mode there are only 7 address bits, a "page" register determines
> + * which part of the 8-bit range is active. This function looks at the address
> + * and writes the page selection bit if needed
> + */
> +static int bme680_regmap_spi_select_page(
> +	struct bme680_spi_bus_context *ctx, u8 reg)
> +{
> +	struct spi_device *spi = ctx->spi;
> +	int ret;
> +	u8 buf[2];
> +	u8 page = (reg & 0x80) ? 0 : 1; /* Page "1" is low range */
> +
> +	if (page == ctx->current_page)
> +		return 0;
> +
> +	/*
> +	 * Data sheet claims we're only allowed to change bit 4, so we must do
> +	 * a read-modify-write on each and every page select
> +	 */
> +	buf[0] = BME680_REG_STATUS;
> +	ret = spi_write_then_read(spi, buf, 1, buf + 1, 1);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "failed to set page %u\n", page);
> +		return ret;
> +	}
> +
> +	buf[0] = BME680_REG_STATUS;
> +	if (page)
> +		buf[1] |= BME680_SPI_MEM_PAGE_BIT;
> +	else
> +		buf[1] &= ~BME680_SPI_MEM_PAGE_BIT;
> +
> +	ret = spi_write(spi, buf, 2);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "failed to set page %u\n", page);
> +		return ret;
> +	}
> +
> +	ctx->current_page = page;
> +
> +	return 0;
> +}

I will take another look at this later as my head is spinning now ...

>  static int bme680_regmap_spi_write(void *context, const void *data,
>  				   size_t count)
>  {
> -	struct spi_device *spi = context;
> +	struct bme680_spi_bus_context *ctx = context;
> +	struct spi_device *spi = ctx->spi;
> +	int ret;
>  	u8 buf[2];
>  
>  	memcpy(buf, data, 2);
> +
> +	ret = bme680_regmap_spi_select_page(ctx, buf[0]);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * The SPI register address (= full register address without bit 7)
>  	 * and the write command (bit7 = RW = '0')
>  	 */
>  	buf[0] &= ~0x80;
>  
> -	return spi_write_then_read(spi, buf, 2, NULL, 0);
> +	return spi_write(spi, buf, 2);
>  }
>  
>  static int bme680_regmap_spi_read(void *context, const void *reg,
>  				  size_t reg_size, void *val, size_t val_size)
>  {
> -	struct spi_device *spi = context;
> +	struct bme680_spi_bus_context *ctx = context;
> +	struct spi_device *spi = ctx->spi;
> +	int ret;
> +	u8 addr = *(const u8 *)reg;
> +	u8 addr7;

Unused variable.

> +	ret = bme680_regmap_spi_select_page(ctx, addr);
> +	if (ret)
> +		return ret;
>  
> -	return spi_write_then_read(spi, reg, reg_size, val, val_size);
> +	addr |= 0x80; /* bit7 = RW = '1' */
> +
> +	return spi_write_then_read(spi, &addr, 1, val, val_size);
>  }
>  
>  static struct regmap_bus bme680_regmap_bus = {
> @@ -45,8 +111,8 @@ static int bme680_regmap_spi_read(void *context, const void *reg,
>  static int bme680_spi_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id = spi_get_device_id(spi);
> +	struct bme680_spi_bus_context *bus_context;
>  	struct regmap *regmap;
> -	unsigned int val;
>  	int ret;
>  
>  	spi->bits_per_word = 8;
> @@ -56,45 +122,21 @@ static int bme680_spi_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> +	bus_context = devm_kzalloc(&spi->dev, sizeof(*bus_context), GFP_KERNEL);
> +	if (!bus_context)
> +		return -ENOMEM;
> +
> +	bus_context->spi = spi;
> +	bus_context->current_page = 0xff; /* Undefined on warm boot */

OK. This is what you observed.

If this patch works as expected then I think a "Fixes:" tag should be
added while marking it for stable ?

Thanks for the patch Mike and apologies again for the whole mess.

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
