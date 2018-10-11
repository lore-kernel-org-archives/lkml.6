Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA52C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 04:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C95A20835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 04:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYYUkkXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C95A20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeJKMAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 08:00:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43160 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbeJKMAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 08:00:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id 30-v6so3551013plb.10;
        Wed, 10 Oct 2018 21:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mfi1nB1xZtuW0/cUlStnS2JW5M9KA/7KZahtMnUqYhM=;
        b=FYYUkkXsdlUeS1di6f1quRB23Sdpm1B1WXnxyiTjpjCbKS0MVovEBFGZblxq5J9nvp
         bRkXepapitt/xbAhpPwn2SNPYqKbwspS1qwd73OFHkXiHTOrj4oqoo7yWhiPWY1Na/mi
         8pX5CkMM0yhTC0ZjzOD1YxK4FueDYcEm6FOtat6O/1+QQaCZ9Y+0lHkzv62wppv2Cu8y
         Y8bDDumnbGyWovKinrIpZicC/Fk8wm1RmsLpDbprz/rGVlYE4bXzdAImVTvEX1lRNGeQ
         NKNsRe5WtKr0GD7iVF7jSFxJEsgzHXUhIcrz9iqPmkitsHQqsCb7kc87QaS8+XCrlQ+v
         8SkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mfi1nB1xZtuW0/cUlStnS2JW5M9KA/7KZahtMnUqYhM=;
        b=DkGrlQ0T/Y3JqSF+3DTfYpPpaeVyDTCcTyH5/E6n00dtzdyCmc1I/aYREf1C3Uprne
         T21QVGYD8YTs9O1HynrDcTMNQLY9jeR6004I2prSc3Y6ppWWFJTf9y1rlwc6r6AEMbNQ
         ODxcw5JqMYWJ8SZfMEPHpmE70LY3EIciFuN52YL+jjcYF8doMX3jZigSE2EsRMP+IFb/
         J9qHo5H8CfNhpGKgd6wJ49RUO51e1R96iJmNlljn3TL3aPXaOlU/zJl1ajkVVmppyEHl
         rD7nDgd1diOwfHWa9nnXIYEo7IBo0d0AaFyWalSOpNPewJCrvzAAMBKF6QoPOyC2hVgg
         WGmw==
X-Gm-Message-State: ABuFfoipsHrYITHC30eI4+euR3tmpDuHznduIMXAm98FoI4morpgAfR1
        nZGNllosl1anZShexwZNZlaeAoNXNa8=
X-Google-Smtp-Source: ACcGV62BziHWash8TV7xPGFfpyA49O5jhv0w4VARPmt54r2FWRrM137kI/rGMVXGtTNndN4NfrfyaQ==
X-Received: by 2002:a17:902:8342:: with SMTP id z2-v6mr2315544pln.147.1539232526791;
        Wed, 10 Oct 2018 21:35:26 -0700 (PDT)
Received: from [127.0.0.1] (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id r76-v6sm21813474pgr.11.2018.10.10.21.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 21:35:26 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] iio: magnetometer: Add driver support for PNI
 RM3100
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
 <20181002143812.3661-1-songqiang1304521@gmail.com>
 <20181002143812.3661-4-songqiang1304521@gmail.com>
 <20181007164429.26335752@archlinux>
From:   Song Qiang <songqiang1304521@gmail.com>
Message-ID: <4ce188a9-c999-6234-2c48-fd80d6518da6@gmail.com>
Date:   Thu, 11 Oct 2018 12:35:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181007164429.26335752@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年10月07日 23:44, Jonathan Cameron wrote:
> On Tue,  2 Oct 2018 22:38:12 +0800
> Song Qiang <songqiang1304521@gmail.com> wrote:
>
>> PNI RM3100 is a high resolution, large signal immunity magnetometer,
>> composed of 3 single sensors and a processing chip with a MagI2C
>> interface.
>>
>> Following functions are available:
>>   - Single-shot measurement from
>>     /sys/bus/iio/devices/iio:deviceX/in_magn_{axis}_raw
>>   - Triggerd buffer measurement.
>>   - Both i2c and spi interface are supported.
>>   - Both interrupt and polling measurement is supported, depends on if
>>     the 'interrupts' in DT is declared.
>>
>> Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> I realise now that I should have read the datasheet properly.
> Sorry about that.
>
> What we have here is a hybrid of polled and continuous measurement.
>
> If you are using the dataready as a trigger it is fine to support
> continuous measurement, but you aren't doing that here.
>
> The single shot measurement should be done with the method
> described in the datasheet where you write a POLL command and then wait
> for the single interrupt.  There is no problem with racing and that
> interrupt is a high level one and can be handled as such.  We should
> not do it by waiting for the next continuous measurement to happen
> after clearing the status register, which is what I think is happening
> here.
>
> If you want to use it in continuous mode, you should provide a trigger.
> That trigger will be fired by the dataready signal and the
> discussion I put in the earlier reply becomes relevant.
>
> Doing both of these options requires the interrupt handler to know
> which mode you are in, but that is straight forward to implement and
> is done in a number of other drivers.
>
> Sorry again that I failed to identify this issue earlier.
>
> Thanks to Phil as his question in the interrupt type got me thinking
> about how you were handing the interrupts.
>
> Jonathan
>

Hi Jonathan,

I learned the way of handling single shot from the driver of hmc5843, 
seems like it needs changing, too.
There was some problems with my computer. Lenovo updates told me to 
update BIOS and it went dead. I didn't write any code the past few days, 
just got it fixed today.

yours,
Song Qiang

>> ---
>>   MAINTAINERS                            |   7 +
>>   drivers/iio/magnetometer/Kconfig       |  29 ++
>>   drivers/iio/magnetometer/Makefile      |   4 +
>>   drivers/iio/magnetometer/rm3100-core.c | 539 +++++++++++++++++++++++++
>>   drivers/iio/magnetometer/rm3100-i2c.c  |  58 +++
>>   drivers/iio/magnetometer/rm3100-spi.c  |  64 +++
>>   drivers/iio/magnetometer/rm3100.h      |  17 +
>>   7 files changed, 718 insertions(+)
>>   create mode 100644 drivers/iio/magnetometer/rm3100-core.c
>>   create mode 100644 drivers/iio/magnetometer/rm3100-i2c.c
>>   create mode 100644 drivers/iio/magnetometer/rm3100-spi.c
>>   create mode 100644 drivers/iio/magnetometer/rm3100.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 967ce8cdd1cc..14eeeb072403 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11393,6 +11393,13 @@ M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>>   S:	Maintained
>>   F:	drivers/pnp/
>>   
>> +PNI RM3100 IIO DRIVER
>> +M:	Song Qiang <songqiang1304521@gmail.com>
>> +L:	linux-iio@vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/iio/magnetometer/rm3100*
>> +F:	Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
>> +
>>   POSIX CLOCKS and TIMERS
>>   M:	Thomas Gleixner <tglx@linutronix.de>
>>   L:	linux-kernel@vger.kernel.org
>> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
>> index ed9d776d01af..8a63cbbca4b7 100644
>> --- a/drivers/iio/magnetometer/Kconfig
>> +++ b/drivers/iio/magnetometer/Kconfig
>> @@ -175,4 +175,33 @@ config SENSORS_HMC5843_SPI
>>   	  - hmc5843_core (core functions)
>>   	  - hmc5843_spi (support for HMC5983)
>>   
>> +config SENSORS_RM3100
>> +	tristate
>> +	select IIO_BUFFER
>> +	select IIO_TRIGGERED_BUFFER
>> +
>> +config SENSORS_RM3100_I2C
>> +	tristate "PNI RM3100 3-Axis Magnetometer (I2C)"
>> +	depends on I2C
>> +	select SENSORS_RM3100
>> +	select REGMAP_I2C
>> +	help
>> +	  Say Y here to add support for the PNI RM3100 3-Axis Magnetometer.
>> +
>> +	  This driver can also be compiled as a module.
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called rm3100-i2c.
>> +
>> +config SENSORS_RM3100_SPI
>> +	tristate "PNI RM3100 3-Axis Magnetometer (SPI)"
>> +	depends on SPI_MASTER
>> +	select SENSORS_RM3100
>> +	select REGMAP_SPI
>> +	help
>> +	  Say Y here to add support for the PNI RM3100 3-Axis Magnetometer.
>> +
>> +	  This driver can also be compiled as a module.
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called rm3100-spi.
>> +
>>   endmenu
>> diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
>> index 664b2f866472..ba1bc34b82fa 100644
>> --- a/drivers/iio/magnetometer/Makefile
>> +++ b/drivers/iio/magnetometer/Makefile
>> @@ -24,3 +24,7 @@ obj-$(CONFIG_IIO_ST_MAGN_SPI_3AXIS) += st_magn_spi.o
>>   obj-$(CONFIG_SENSORS_HMC5843)		+= hmc5843_core.o
>>   obj-$(CONFIG_SENSORS_HMC5843_I2C)	+= hmc5843_i2c.o
>>   obj-$(CONFIG_SENSORS_HMC5843_SPI)	+= hmc5843_spi.o
>> +
>> +obj-$(CONFIG_SENSORS_RM3100)		+= rm3100-core.o
>> +obj-$(CONFIG_SENSORS_RM3100_I2C)	+= rm3100-i2c.o
>> +obj-$(CONFIG_SENSORS_RM3100_SPI)	+= rm3100-spi.o
>> diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
>> new file mode 100644
>> index 000000000000..cacdaee28ae3
>> --- /dev/null
>> +++ b/drivers/iio/magnetometer/rm3100-core.c
>> @@ -0,0 +1,539 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * PNI RM3100 3-axis geomagnetic sensor driver core.
>> + *
>> + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
>> + *
>> + * User Manual available at
>> + * <https://www.pnicorp.com/download/rm3100-user-manual/>
>> + *
>> + * TODO: event generation, pm.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/kfifo_buf.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +
>> +#include "rm3100.h"
>> +
>> +/* Cycle Count Registers. */
>> +#define RM3100_REG_CC_X			0x05
>> +#define RM3100_REG_CC_Y			0x07
>> +#define RM3100_REG_CC_Z			0x09
>> +
>> +/* Continuous Measurement Mode register. */
>> +#define RM3100_REG_CMM			0x01
>> +#define		RM3100_CMM_START	BIT(0)
>> +#define		RM3100_CMM_X		BIT(4)
>> +#define		RM3100_CMM_Y		BIT(5)
>> +#define		RM3100_CMM_Z		BIT(6)
>> +
>> +/* TiMe Rate Configuration register. */
>> +#define RM3100_REG_TMRC			0x0B
>> +#define RM3100_TMRC_OFFSET		0x92
>> +
>> +/* Result Status register. */
>> +#define RM3100_REG_STATUS		0x34
>> +#define		RM3100_STATUS_DRDY	BIT(7)
>> +
>> +/* Measurement result registers. */
>> +#define RM3100_REG_MX2			0x24
>> +#define RM3100_REG_MY2			0x27
>> +#define RM3100_REG_MZ2			0x2a
>> +
>> +#define RM3100_W_REG_START		RM3100_REG_CMM
>> +#define RM3100_W_REG_END		RM3100_REG_STATUS
>> +#define RM3100_R_REG_START		RM3100_REG_CMM
>> +#define RM3100_R_REG_END		RM3100_REG_STATUS
>> +#define RM3100_V_REG_START		RM3100_REG_MX2
>> +#define RM3100_V_REG_END		RM3100_REG_STATUS
>> +
>> +/*
>> + * This is computed by hand, is the sum of channel storage bits and padding
>> + * bits, which is 4+4+4+12=24 in here.
>> + */
>> +#define RM3100_SCAN_BYTES		24
>> +
>> +struct rm3100_data {
>> +	struct regmap *regmap;
>> +	struct completion measuring_done;
>> +	bool use_interrupt;
>> +
>> +	int conversion_time;
>> +	int cycle_count_index;
>> +
>> +	u8 buffer[RM3100_SCAN_BYTES];
>> +
>> +	/*
>> +	 * This lock is for protecting the consistency of series of i2c
>> +	 * operations, that is, to make sure a measurement process will
>> +	 * not be interrupted by a set frequency operation, which should
>> +	 * be taken where a series of i2c operation starts, released where
>> +	 * the operation ends.
>> +	 */
>> +	struct mutex lock;
>> +};
>> +
>> +static const struct regmap_range rm3100_readable_ranges[] = {
>> +	regmap_reg_range(RM3100_W_REG_START, RM3100_W_REG_END),
>> +};
>> +
>> +const struct regmap_access_table rm3100_readable_table = {
>> +	.yes_ranges = rm3100_readable_ranges,
>> +	.n_yes_ranges = ARRAY_SIZE(rm3100_readable_ranges),
>> +};
>> +EXPORT_SYMBOL_GPL(rm3100_readable_table);
>> +
>> +static const struct regmap_range rm3100_writable_ranges[] = {
>> +	regmap_reg_range(RM3100_R_REG_START, RM3100_R_REG_END),
>> +};
>> +
>> +const struct regmap_access_table rm3100_writable_table = {
>> +	.yes_ranges = rm3100_writable_ranges,
>> +	.n_yes_ranges = ARRAY_SIZE(rm3100_writable_ranges),
>> +};
>> +EXPORT_SYMBOL_GPL(rm3100_writable_table);
>> +
>> +static const struct regmap_range rm3100_volatile_ranges[] = {
>> +	regmap_reg_range(RM3100_V_REG_START, RM3100_V_REG_END),
>> +};
>> +
>> +const struct regmap_access_table rm3100_volatile_table = {
>> +	.yes_ranges = rm3100_volatile_ranges,
>> +	.n_yes_ranges = ARRAY_SIZE(rm3100_volatile_ranges),
>> +};
>> +EXPORT_SYMBOL_GPL(rm3100_volatile_table);
>> +
>> +static irqreturn_t rm3100_irq_handler(int irq, void *d)
>> +{
>> +	struct rm3100_data *data = d;
>> +
>> +	complete(&data->measuring_done);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int rm3100_wait_measurement(struct rm3100_data *data)
>> +{
>> +	struct regmap *regmap = data->regmap;
>> +	unsigned int val;
>> +	int tries = 20;
>> +	int ret;
>> +
>> +	/*
>> +	 * A read cycle of 400kbits i2c bus is about 20us, plus the time
>> +	 * used for scheduling, a read cycle of fast mode of this device
>> +	 * can reach 1.7ms, it may be possible for data to arrive just
>> +	 * after we check the RM3100_REG_STATUS. In this case, irq_handler is
>> +	 * called before measuring_done is reinitialized, it will wait
>> +	 * forever for data that has already been ready.
>> +	 * Reinitialize measuring_done before looking up makes sure we
>> +	 * will always capture interrupt no matter when it happens.
>> +	 */
>> +	if (data->use_interrupt)
>> +		reinit_completion(&data->measuring_done);
>> +
>> +	ret = regmap_read(regmap, RM3100_REG_STATUS, &val);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if ((val & RM3100_STATUS_DRDY) != RM3100_STATUS_DRDY) {
>> +		if (data->use_interrupt) {
>> +			ret = wait_for_completion_timeout(&data->measuring_done,
>> +				msecs_to_jiffies(data->conversion_time));
>> +			if (ret < 0)
>> +				return -ETIMEDOUT;
>> +		} else {
>> +			do {
>> +				usleep_range(1000, 5000);
>> +
>> +				ret = regmap_read(regmap, RM3100_REG_STATUS,
>> +						  &val);
>> +				if (ret < 0)
>> +					return ret;
>> +
>> +				if (val & RM3100_STATUS_DRDY)
>> +					break;
>> +			} while (--tries);
>> +			if (!tries)
>> +				return -ETIMEDOUT;
>> +		}
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int rm3100_read_mag(struct rm3100_data *data, int idx, int *val)
>> +{
>> +	struct regmap *regmap = data->regmap;
>> +	u8 buffer[3];
>> +	int ret;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = rm3100_wait_measurement(data);
>> +	if (ret < 0) {
>> +		mutex_unlock(&data->lock);
>> +		return ret;
>> +	}
>> +
>> +	ret = regmap_bulk_read(regmap, RM3100_REG_MX2 + 3 * idx, buffer, 3);
>> +	mutex_unlock(&data->lock);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	*val = sign_extend32((buffer[0] << 16) | (buffer[1] << 8) | buffer[2],
>> +			     23);
>> +
>> +	return IIO_VAL_INT;
>> +}
>> +
>> +#define RM3100_CHANNEL(axis, idx)					\
>> +	{								\
>> +		.type = IIO_MAGN,					\
>> +		.modified = 1,						\
>> +		.channel2 = IIO_MOD_##axis,				\
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
>> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
>> +		.scan_index = idx,					\
>> +		.scan_type = {						\
>> +			.sign = 's',					\
>> +			.realbits = 24,					\
>> +			.storagebits = 32,				\
>> +			.shift = 8,					\
>> +			.endianness = IIO_BE,				\
>> +		},							\
>> +	}
>> +
>> +static const struct iio_chan_spec rm3100_channels[] = {
>> +	RM3100_CHANNEL(X, 0),
>> +	RM3100_CHANNEL(Y, 1),
>> +	RM3100_CHANNEL(Z, 2),
>> +	IIO_CHAN_SOFT_TIMESTAMP(3),
>> +};
>> +
>> +static const unsigned long rm3100_scan_masks[] = {BIT(0) | BIT(1) | BIT(2), 0};
>> +
>> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
>> +	"600 300 150 75 37 18 9 4.5 2.3 1.2 0.6 0.3 0.015 0.075"
>> +);
>> +
>> +static struct attribute *rm3100_attributes[] = {
>> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group rm3100_attribute_group = {
>> +	.attrs = rm3100_attributes,
>> +};
>> +
>> +#define RM3100_SAMP_NUM			14
>> +
>> +/*
>> + * Frequency : rm3100_samp_rates[][0].rm3100_samp_rates[][1]Hz.
>> + * Time between reading: rm3100_sam_rates[][2]ms.
>> + * The first one is actually 1.7ms.
>> + */
>> +static const int rm3100_samp_rates[RM3100_SAMP_NUM][3] = {
>> +	{600, 0, 2}, {300, 0, 3}, {150, 0, 7}, {75, 0, 13}, {37, 0, 27},
>> +	{18, 0, 55}, {9, 0, 110}, {4, 500000, 220}, {2, 300000, 440},
>> +	{1, 200000, 800}, {0, 600000, 1600}, {0, 300000, 3300},
>> +	{0, 15000, 6700},  {0, 75000, 13000}
>> +};
>> +
>> +static int rm3100_get_samp_freq(struct rm3100_data *data, int *val, int *val2)
>> +{
>> +	int ret;
>> +	unsigned int tmp;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
>> +	mutex_unlock(&data->lock);
>> +	if (ret < 0)
>> +		return ret;
>> +	*val = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][0];
>> +	*val2 = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][1];
>> +
>> +	return IIO_VAL_INT_PLUS_MICRO;
>> +}
>> +
>> +static int rm3100_set_cycle_count(struct rm3100_data *data, int val)
>> +{
>> +	int ret;
>> +	u8 i;
>> +
>> +	for (i = 0; i < 3; i++) {
>> +		ret = regmap_write(data->regmap, RM3100_REG_CC_X + 2 * i, val);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>> +	switch (val) {
>> +	case 50:
>> +		data->cycle_count_index = 0;
>> +		break;
>> +	case 100:
>> +		data->cycle_count_index = 1;
>> +		break;
>> +	/*
>> +	 * This function will never be called by users' code, so here we
>> +	 * assume that it will never get a wrong parameter.
>> +	 */
>> +	default:
>> +		data->cycle_count_index = 2;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int rm3100_set_samp_freq(struct rm3100_data *data, int val, int val2)
>> +{
>> +	struct regmap *regmap = data->regmap;
>> +	unsigned int cycle_count;
>> +	int ret;
>> +	int i;
>> +
>> +	mutex_lock(&data->lock);
>> +	/* All cycle count registers use the same value. */
>> +	ret = regmap_read(regmap, RM3100_REG_CC_X, &cycle_count);
>> +	if (ret < 0)
>> +		goto unlock_return;
>> +
>> +	for (i = 0; i < RM3100_SAMP_NUM; i++) {
>> +		if (val == rm3100_samp_rates[i][0] &&
>> +		    val2 == rm3100_samp_rates[i][1])
>> +			break;
>> +	}
>> +	if (i == RM3100_SAMP_NUM) {
>> +		ret = -EINVAL;
>> +		goto unlock_return;
>> +	}
>> +
>> +	ret = regmap_write(regmap, RM3100_REG_TMRC, i + RM3100_TMRC_OFFSET);
>> +	if (ret < 0)
>> +		goto unlock_return;
>> +
>> +	/* Checking if cycle count registers need changing. */
>> +	if (val == 600 && cycle_count == 200) {
>> +		ret = rm3100_set_cycle_count(data, 100);
>> +		if (ret < 0)
>> +			goto unlock_return;
>> +	} else if (val != 600 && cycle_count == 100) {
>> +		ret = rm3100_set_cycle_count(data, 200);
>> +		if (ret < 0)
>> +			goto unlock_return;
>> +	}
>> +
>> +	/* Writing TMRC registers requires CMM reset. */
>> +	ret = regmap_write(regmap, RM3100_REG_CMM, 0);
>> +	if (ret < 0)
>> +		goto unlock_return;
>> +	ret = regmap_write(regmap, RM3100_REG_CMM,
>> +		RM3100_CMM_X | RM3100_CMM_Y | RM3100_CMM_Z | RM3100_CMM_START);
>> +	if (ret < 0)
>> +		goto unlock_return;
>> +	mutex_unlock(&data->lock);
>> +
>> +	data->conversion_time = rm3100_samp_rates[i][2] + 3000;
>> +	return 0;
>> +
>> +unlock_return:
>> +	mutex_unlock(&data->lock);
>> +	return ret;
>> +}
>> +
>> +/*
>> + * The scale of this sensor depends on the cycle count value, these three
>> + * values are corresponding to the cycle count value 50, 100, 200.
>> + * scale = output / gain * 10^4.
>> + */
>> +const static int rm3100_scale[] = {500, 263, 133};
>> +
>> +static int rm3100_read_raw(struct iio_dev *indio_dev,
>> +			   const struct iio_chan_spec *chan,
>> +			   int *val, int *val2, long mask)
>> +{
>> +	struct rm3100_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = iio_device_claim_direct_mode(indio_dev);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		ret = rm3100_read_mag(data, chan->scan_index, val);
>> +		iio_device_release_direct_mode(indio_dev);
>> +
>> +		return ret;
>> +	case IIO_CHAN_INFO_SCALE:
>> +		*val = 0;
>> +		*val2 = rm3100_scale[data->cycle_count_index];
>> +
>> +		return IIO_VAL_INT_PLUS_MICRO;
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		return rm3100_get_samp_freq(data, val, val2);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int rm3100_write_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int val, int val2, long mask)
>> +{
>> +	struct rm3100_data *data = iio_priv(indio_dev);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		return rm3100_set_samp_freq(data, val, val2);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +}
>> +
>> +static const struct iio_info rm3100_info = {
>> +	.attrs = &rm3100_attribute_group,
>> +	.read_raw = rm3100_read_raw,
>> +	.write_raw = rm3100_write_raw,
>> +};
>> +
>> +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct rm3100_data *data = iio_priv(indio_dev);
>> +	struct regmap *regmap = data->regmap;
>> +	int ret;
>> +	int i;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = rm3100_wait_measurement(data);
>> +	if (ret < 0) {
>> +		mutex_unlock(&data->lock);
>> +		goto done;
>> +	}
>> +
>> +	ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
>> +	mutex_unlock(&data->lock);
>> +	if (ret < 0)
>> +		goto done;
>> +
>> +	/* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. x for paddings. */
>> +	for (i = 0; i < 2; i++)
>> +		memcpy(data->buffer + (2 - i) * 4, data->buffer + (2 - i) * 3,
>> +		       3);
>> +
>> +	/*
>> +	 * Always using the same buffer so that we wouldn't need to set the
>> +	 * paddings to 0 in case of leaking any data.
>> +	 */
>> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>> +					   iio_get_time_ns(indio_dev));
>> +
>> +done:
>> +	iio_trigger_notify_done(indio_dev->trig);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static void rm3100_remove(void *pdata)
>> +{
> Given this is no longer the opposite of probe, but rather just an
> action to undo one particular element of probe (be it the only
> one that needs undoing - yeah a subtle distinction ;)...
>
> Can we give it a more meaningful name?
>
> rm3100_stop perhaps? Perhaps even create a little function
> to be rm3100_start as well so that it's easy to see how these
> are paired?
>
>
>> +	struct rm3100_data *data = pdata;
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	int ret;
>> +
>> +	ret = regmap_write(data->regmap, RM3100_REG_CMM, 0x00);
>> +	if (ret < 0)
>> +		dev_err(dev, "failed to stop the device.\n");
>> +}
>> +
>> +int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
>> +{
>> +	struct iio_dev *indio_dev;
>> +	struct rm3100_data *data;
>> +	unsigned int tmp;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(indio_dev);
>> +	data->regmap = regmap;
>> +
>> +	mutex_init(&data->lock);
>> +
>> +	indio_dev->dev.parent = dev;
>> +	indio_dev->name = "rm3100";
>> +	indio_dev->info = &rm3100_info;
>> +	indio_dev->channels = rm3100_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(rm3100_channels);
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->available_scan_masks = rm3100_scan_masks;
>> +
>> +	if (!irq)
>> +		data->use_interrupt = false;
>> +	else {
>> +		data->use_interrupt = true;
>> +		ret = devm_request_irq(dev,
>> +				       irq,
>> +				       rm3100_irq_handler,
>> +				       IRQF_TRIGGER_RISING,
>> +				       indio_dev->name,
>> +				       data);
>> +		if (ret < 0) {
>> +			dev_err(dev, "request irq line failed.\n");
>> +			return ret;
>> +		}
>> +		init_completion(&data->measuring_done);
>> +	}
>> +
>> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
>> +					      rm3100_trigger_handler, NULL);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = regmap_read(regmap, RM3100_REG_TMRC, &tmp);
>> +	if (ret < 0)
>> +		return ret;
>> +	/* Initializing max wait time, 3sec more wait time for conversion. */
>> +	data->conversion_time =
>> +		rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][2] + 3000;
>> +
>> +	/* Cycle count values may not be what we want. */
>> +	ret = regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
>> +	if (ret < 0)
>> +		return ret;
>> +	if ((tmp - RM3100_TMRC_OFFSET) == 0)
>> +		rm3100_set_cycle_count(data, 100);
>> +	else
>> +		rm3100_set_cycle_count(data, 200);
>> +
>> +	/* Starting all channels' conversion. */
>> +	ret = regmap_write(regmap, RM3100_REG_CMM,
>> +		RM3100_CMM_X | RM3100_CMM_Y | RM3100_CMM_Z | RM3100_CMM_START);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = devm_add_action(dev, rm3100_remove, data);
>> +	if (ret < 0) {
>> +		rm3100_remove(data);
>> +		return ret;
>> +	}
>> +
>> +	return devm_iio_device_register(dev, indio_dev);
>> +}
>> +EXPORT_SYMBOL_GPL(rm3100_common_probe);
>> +
>> +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
>> +MODULE_DESCRIPTION("PNI RM3100 3-axis magnetometer i2c driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/iio/magnetometer/rm3100-i2c.c b/drivers/iio/magnetometer/rm3100-i2c.c
>> new file mode 100644
>> index 000000000000..8f02e0366886
>> --- /dev/null
>> +++ b/drivers/iio/magnetometer/rm3100-i2c.c
>> @@ -0,0 +1,58 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Support for PNI RM3100 3-axis geomagnetic sensor on a i2c bus.
>> + *
>> + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
>> + *
>> + * i2c slave address: 0x20 + SA1 << 1 + SA0.
>> + */
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +
>> +#include "rm3100.h"
>> +
>> +static const struct regmap_config rm3100_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +
>> +	.rd_table = &rm3100_readable_table,
>> +	.wr_table = &rm3100_writable_table,
>> +	.volatile_table = &rm3100_volatile_table,
>> +
>> +	.cache_type = REGCACHE_RBTREE,
>> +};
>> +
>> +static int rm3100_probe(struct i2c_client *client)
>> +{
>> +	struct regmap *regmap;
>> +
>> +	if (!i2c_check_functionality(client->adapter,
>> +		I2C_FUNC_SMBUS_READ_I2C_BLOCK | I2C_FUNC_SMBUS_BYTE_DATA))
>> +		return -EOPNOTSUPP;
>> +
>> +	regmap =  devm_regmap_init_i2c(client, &rm3100_regmap_config);
>> +	if (IS_ERR(regmap))
>> +		return PTR_ERR(regmap);
>> +
>> +	return rm3100_common_probe(&client->dev, regmap, client->irq);
>> +}
>> +
>> +static const struct of_device_id rm3100_dt_match[] = {
>> +	{ .compatible = "pni,rm3100", },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, rm3100_dt_match);
>> +
>> +static struct i2c_driver rm3100_driver = {
>> +	.driver = {
>> +		.name = "rm3100-i2c",
>> +		.of_match_table = rm3100_dt_match,
>> +	},
>> +	.probe_new = rm3100_probe,
>> +};
>> +module_i2c_driver(rm3100_driver);
>> +
>> +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
>> +MODULE_DESCRIPTION("PNI RM3100 3-axis magnetometer i2c driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/iio/magnetometer/rm3100-spi.c b/drivers/iio/magnetometer/rm3100-spi.c
>> new file mode 100644
>> index 000000000000..65d5eb9e4f5e
>> --- /dev/null
>> +++ b/drivers/iio/magnetometer/rm3100-spi.c
>> @@ -0,0 +1,64 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Support for PNI RM3100 3-axis geomagnetic sensor on a spi bus.
>> + *
>> + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/spi/spi.h>
>> +
>> +#include "rm3100.h"
>> +
>> +static const struct regmap_config rm3100_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +
>> +	.rd_table = &rm3100_readable_table,
>> +	.wr_table = &rm3100_writable_table,
>> +	.volatile_table = &rm3100_volatile_table,
>> +
>> +	.read_flag_mask = 0x80,
>> +
>> +	.cache_type = REGCACHE_RBTREE,
>> +};
>> +
>> +static int rm3100_probe(struct spi_device *spi)
>> +{
>> +	struct regmap *regmap;
>> +	int ret;
>> +
>> +	/* Actually this device supports both mode 0 and mode 3. */
>> +	spi->mode = SPI_MODE_0;
>> +	/* Data rates cannot exceed 1Mbits. */
>> +	spi->max_speed_hz = 1000000;
>> +	spi->bits_per_word = 8;
>> +	ret = spi_setup(spi);
>> +	if (ret)
>> +		return ret;
>> +
>> +	regmap = devm_regmap_init_spi(spi, &rm3100_regmap_config);
>> +	if (IS_ERR(regmap))
>> +		return PTR_ERR(regmap);
>> +
>> +	return rm3100_common_probe(&spi->dev, regmap, spi->irq);
>> +}
>> +
>> +static const struct of_device_id rm3100_dt_match[] = {
>> +	{ .compatible = "pni,rm3100", },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, rm3100_dt_match);
>> +
>> +static struct spi_driver rm3100_driver = {
>> +	.driver = {
>> +		.name = "rm3100-spi",
>> +		.of_match_table = rm3100_dt_match,
>> +	},
>> +	.probe = rm3100_probe,
>> +};
>> +module_spi_driver(rm3100_driver);
>> +
>> +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
>> +MODULE_DESCRIPTION("PNI RM3100 3-axis magnetometer spi driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/iio/magnetometer/rm3100.h b/drivers/iio/magnetometer/rm3100.h
>> new file mode 100644
>> index 000000000000..c3508218bc77
>> --- /dev/null
>> +++ b/drivers/iio/magnetometer/rm3100.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
>> + */
>> +
>> +#ifndef RM3100_CORE_H
>> +#define RM3100_CORE_H
>> +
>> +#include <linux/regmap.h>
>> +
>> +extern const struct regmap_access_table rm3100_readable_table;
>> +extern const struct regmap_access_table rm3100_writable_table;
>> +extern const struct regmap_access_table rm3100_volatile_table;
>> +
>> +int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq);
>> +
>> +#endif /* RM3100_CORE_H */

