Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FED2C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 16:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0912084D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 16:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=elementarea-net.20150623.gappssmtp.com header.i=@elementarea-net.20150623.gappssmtp.com header.b="oeDEJGv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbeLPQiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:38:24 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35858 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730609AbeLPQiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 11:38:23 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so8788860edb.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 08:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elementarea-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fLzJy+WnoKyr3eadR8Yc749lPAZgcZoxK3ejp8fC38o=;
        b=oeDEJGv4gXRUnSnDUOocOOWL3cAnKswR8fwuW2JB2kMUiWOyYKqcB9y5VWGv0kG9KV
         ECOu7Lcx9FIYJx0FMV4c8CBJCtbAx1vquzcUmv2olNTCV2TbIR69arUzCoA4ILV0X0MI
         gC3/3Yyk0UFb/u9sN3UBi3sRB+XsWPi6cyySk9/dNhH+jvBoGpCzZMnW/yYz6zSOrx+O
         VclhQw4Bx6Ugh8yxVB3bZzPWK+UY/TYeSjREVkXehEsq4SoARQYsO8MhU97BXVvq4LmV
         vt+2SkCur5A+U0yPipTWaSPeHjKeO55IOZzVnyfphAYvWH1EZYgrPAUIWvU3uWwUzwHb
         Q6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fLzJy+WnoKyr3eadR8Yc749lPAZgcZoxK3ejp8fC38o=;
        b=sipkkfkHnZTlcLfXLhkmSxcOP5h1ESVtos3vrhcQEuDZ+OaIXNs098nZ5hSiBKDr/F
         6skU0cVzpUsUxH4+q6E3/0M4zVkKcfDT/5ENxQKtzLFYV+m4nUztjUcct3XJ5UkCgrxs
         wDECfmaD4hNbIbD5BYAfZfKoznhkTN7vu+4c8HE2oUsltFcQVllTiWez8+QbebRw3hAV
         v8kKqPAxSNxBAUylevCPW/XFtZhBZnWr/SqqaNXx2pKIdiSFl8hwDP2rpHv9vCE4lZxP
         Q7a5uxTB0MmErmUqVbdQL3uU7SZKqCVoLKU9qQVfx/xfhQqfcSM1zQ5JIODX7E3iGbRl
         lg6A==
X-Gm-Message-State: AA+aEWZ0RlfQ3ESeHEZzORZt4g2hlPCd7TDQ9pXxPMzdj+68mx0NWgmB
        PYvt6dG0xufWo44An8Bad2VhUotfPsQmpQ==
X-Google-Smtp-Source: AFSGD/W0EEoLNGNan1XXsZBfvBTl9eFN7dFYE9uhb2NadFeJP6YL5KKhIscA+PElfaXcwgcEih1kcg==
X-Received: by 2002:a50:b36f:: with SMTP id r44mr10013327edd.284.1544978300601;
        Sun, 16 Dec 2018 08:38:20 -0800 (PST)
Received: from ch-sta-l-li0012 (84-74-221-84.dclient.hispeed.ch. [84.74.221.84])
        by smtp.gmail.com with ESMTPSA id v20-v6sm575681eju.37.2018.12.16.08.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 08:38:19 -0800 (PST)
Message-ID: <45293ab40a362b4ad909c3fed2d2376a8fe1dee2.camel@elementarea.net>
Subject: Re: [PATCH v3 2/3] iio: chemical: sgp30: Support Sensirion
 SGP30/SGPC3 sensors
From:   Andreas Brauchli <a.brauchli@elementarea.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Date:   Sun, 16 Dec 2018 17:38:18 +0100
In-Reply-To: <20181216133444.3c4bbb16@archlinux>
References: <20181213144323.24820-3-andreas.brauchli@sensirion.com>
         <20181216133444.3c4bbb16@archlinux>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-12-16 at 13:34 +0000, Jonathan Cameron wrote:
> On Thu, 13 Dec 2018 15:43:23 +0100
> Andreas Brauchli <a.brauchli@elementarea.net> wrote:
> 
> > Support Sensirion SGP30 and SGPC3 multi-pixel I2C gas sensors
> > 
> > Supported Features:
> > 
> > * Indoor Air Quality (IAQ) concentrations for
> >   - tVOC (in_concentration_voc_input)
> >   - CO2eq (in_concentration_co2_input) - SGP30 only
> > 
> >   IAQ concentrations are periodically read out by a background
> > thread
> >   to allow the sensor to maintain its internal baseline.
> > 
> > * Gas concentration signals
> >   - Ethanol (in_concentration_ethanol_raw)
> >   - H2 (in_concentration_h2_raw) - SGP30 only
> > 
> > https://www.sensirion.com/file/datasheet_sgp30
> > https://www.sensirion.com/file/datasheet_sgpc3
> > 
> > Signed-off-by: Andreas Brauchli <andreas.brauchli@sensirion.com>
> 
> Why do we provide endianness info given we don't provide the buffered
> interface?  It's only used when we do.

Makes sense but I wasn't aware of it. The initial submission came with
buffering, so it probably wasn't spotted in v2.

> 
> Some over the top line wrapping as well.  However as that's it
> I'll just clean up whilst applying.  If I've missed something odd
> around the endian thing shout!

No that's it, thanks a lot.

> 
> Jonathan
> 
> > ---
> >  drivers/iio/chemical/Kconfig  |  13 +
> >  drivers/iio/chemical/Makefile |   1 +
> >  drivers/iio/chemical/sgp30.c  | 603
> > ++++++++++++++++++++++++++++++++++
> >  3 files changed, 617 insertions(+)
> >  create mode 100644 drivers/iio/chemical/sgp30.c
> > 
> > diff --git a/drivers/iio/chemical/Kconfig
> > b/drivers/iio/chemical/Kconfig
> > index b8e005be4f87..b0c912be94a9 100644
> > --- a/drivers/iio/chemical/Kconfig
> > +++ b/drivers/iio/chemical/Kconfig
> > @@ -61,6 +61,19 @@ config IAQCORE
> >  	  iAQ-Core Continuous/Pulsed VOC (Volatile Organic Compounds)
> >  	  sensors
> >  
> > +config SENSIRION_SGP30

I noticed that in Tomasz's SPS30 patch it's just SPS30, so for
consistency's sake I'm fine with dropping the branding. Up to you.

> > +	tristate "Sensirion SGPxx gas sensors"
> > +	depends on I2C
> > +	select CRC8
> > +	help
> > +	  Say Y here to build I2C interface support for the following
> > +	  Sensirion SGP gas sensors:
> > +	    * SGP30 gas sensor
> > +	    * SGPC3 low power gas sensor
> > +
> > +	  To compile this driver as module, choose M here: the
> > +	  module will be called sgp30.
> > +
> >  config VZ89X
> >  	tristate "SGX Sensortech MiCS VZ89X VOC sensor"
> >  	depends on I2C
> > diff --git a/drivers/iio/chemical/Makefile
> > b/drivers/iio/chemical/Makefile
> > index 2f4c4ba4d781..61e83944db1a 100644
> > --- a/drivers/iio/chemical/Makefile
> > +++ b/drivers/iio/chemical/Makefile
> > @@ -9,4 +9,5 @@ obj-$(CONFIG_BME680_I2C) += bme680_i2c.o
> >  obj-$(CONFIG_BME680_SPI) += bme680_spi.o
> >  obj-$(CONFIG_CCS811)		+= ccs811.o
> >  obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
> > +obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
> >  obj-$(CONFIG_VZ89X)		+= vz89x.o
> > diff --git a/drivers/iio/chemical/sgp30.c
> > b/drivers/iio/chemical/sgp30.c
> > new file mode 100644
> > index 000000000000..90eb4cbb18cf
> > --- /dev/null
> > +++ b/drivers/iio/chemical/sgp30.c
> > @@ -0,0 +1,603 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * sgp30.c - Support for Sensirion SGP Gas Sensors
> > + *
> > + * Copyright (C) 2018 Andreas Brauchli <
> > andreas.brauchli@sensirion.com>
> > + *
> > + * I2C slave address: 0x58
> > + *
> > + * Datasheets:
> > + * https://www.sensirion.com/file/datasheet_sgp30
> > + * https://www.sensirion.com/file/datasheet_sgpc3
> > + *
> > + * TODO:
> > + * - baseline support
> > + * - humidity compensation
> > + * - power mode switching (SGPC3)
> > + */
> > +
> > +#include <linux/crc8.h>
> > +#include <linux/delay.h>
> > +#include <linux/kthread.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/i2c.h>
> > +#include <linux/of_device.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +#define SGP_WORD_LEN				2
> > +#define SGP_CRC8_POLYNOMIAL			0x31
> > +#define SGP_CRC8_INIT				0xff
> > +#define SGP_CRC8_LEN				1
> > +#define SGP_CMD(cmd_word)			cpu_to_be16(cmd_word)
> > +#define SGP_CMD_DURATION_US			12000
> > +#define SGP_MEASUREMENT_DURATION_US		50000
> > +#define SGP_CMD_LEN				SGP_WORD_LEN
> > +#define SGP_CMD_MAX_BUF_SIZE			(SGP_CMD_LEN +
> > 2 * SGP_WORD_LEN)
> > +#define SGP_MEASUREMENT_LEN			2
> > +#define SGP30_MEASURE_INTERVAL_HZ		1
> > +#define SGPC3_MEASURE_INTERVAL_HZ		2
> > +#define SGP_VERS_PRODUCT(data)	((((data)->feature_set) &
> > 0xf000) >> 12)
> > +#define SGP_VERS_RESERVED(data)	((((data)->feature_set) &
> > 0x0800) >> 11)
> > +#define SGP_VERS_GEN(data)	((((data)->feature_set) & 0x0600) >> 9)
> > +#define SGP_VERS_ENG_BIT(data)	((((data)->feature_set) &
> > 0x0100) >> 8)
> > +#define SGP_VERS_MAJOR(data)	((((data)->feature_set) &
> > 0x00e0) >> 5)
> > +#define SGP_VERS_MINOR(data)	(((data)->feature_set) &
> > 0x001f)
> > +
> > +DECLARE_CRC8_TABLE(sgp_crc8_table);
> > +
> > +enum sgp_product_id {
> > +	SGP30 = 0,
> > +	SGPC3,
> > +};
> > +
> > +enum sgp30_channel_idx {
> > +	SGP30_IAQ_TVOC_IDX = 0,
> > +	SGP30_IAQ_CO2EQ_IDX,
> > +	SGP30_SIG_ETOH_IDX,
> > +	SGP30_SIG_H2_IDX,
> > +};
> > +
> > +enum sgpc3_channel_idx {
> > +	SGPC3_IAQ_TVOC_IDX = 10,
> > +	SGPC3_SIG_ETOH_IDX,
> > +};
> > +
> > +enum sgp_cmd {
> > +	SGP_CMD_IAQ_INIT			= SGP_CMD(0x2003),
> > +	SGP_CMD_IAQ_MEASURE			= SGP_CMD(0x2008),
> > +	SGP_CMD_GET_FEATURE_SET			= SGP_CMD(0x202f),
> > +	SGP_CMD_GET_SERIAL_ID			= SGP_CMD(0x3682),
> > +
> > +	SGP30_CMD_MEASURE_SIGNAL		= SGP_CMD(0x2050),
> > +
> > +	SGPC3_CMD_MEASURE_RAW			= SGP_CMD(0x2046),
> > +};
> > +
> > +struct sgp_version {
> > +	u8 major;
> > +	u8 minor;
> > +};
> > +
> > +struct sgp_crc_word {
> > +	__be16 value;
> > +	u8 crc8;
> > +} __attribute__((__packed__));
> > +
> > +union sgp_reading {
> > +	u8 start;
> > +	struct sgp_crc_word raw_words[4];
> > +};
> > +
> > +enum _iaq_buffer_state {
> > +	IAQ_BUFFER_EMPTY = 0,
> > +	IAQ_BUFFER_DEFAULT_VALS,
> > +	IAQ_BUFFER_VALID,
> > +};
> > +
> > +struct sgp_data {
> > +	struct i2c_client *client;
> > +	struct task_struct *iaq_thread;
> > +	struct mutex data_lock;
> > +	unsigned long iaq_init_start_jiffies;
> > +	unsigned long iaq_defval_skip_jiffies;
> > +	u16 product_id;
> > +	u16 feature_set;
> > +	unsigned long measure_interval_jiffies;
> > +	enum sgp_cmd iaq_init_cmd;
> > +	enum sgp_cmd measure_iaq_cmd;
> > +	enum sgp_cmd measure_gas_signals_cmd;
> > +	union sgp_reading buffer;
> > +	union sgp_reading iaq_buffer;
> > +	enum _iaq_buffer_state iaq_buffer_state;
> > +};
> > +
> > +struct sgp_device {
> > +	const struct iio_chan_spec *channels;
> > +	int num_channels;
> > +};
> > +
> > +static const struct sgp_version supported_versions_sgp30[] = {
> > +	{
> > +		.major = 1,
> > +		.minor = 0,
> > +	},
> > +};
> > +
> > +static const struct sgp_version supported_versions_sgpc3[] = {
> > +	{
> > +		.major = 0,
> > +		.minor = 4,
> > +	},
> > +};
> > +
> > +static const struct iio_chan_spec sgp30_channels[] = {
> > +	{
> > +		.type = IIO_CONCENTRATION,
> > +		.channel2 = IIO_MOD_VOC,
> > +		.modified = 1,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> > +		.address = SGP30_IAQ_TVOC_IDX,
> > +	},
> > +	{
> > +		.type = IIO_CONCENTRATION,
> > +		.channel2 = IIO_MOD_CO2,
> > +		.modified = 1,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> > +		.address = SGP30_IAQ_CO2EQ_IDX,
> > +	},
> > +	{
> > +		.type = IIO_CONCENTRATION,
> > +		.channel2 = IIO_MOD_ETHANOL,
> > +		.modified = 1,
> > +		.info_mask_separate =
> > +			BIT(IIO_CHAN_INFO_RAW),
> 
> Definitely looks like it'll fit in under 80 chars.
> 
> > +		.address = SGP30_SIG_ETOH_IDX,
> > +		.scan_type = {
> > +			.endianness = IIO_BE,
> > +		},
> > +	},
> > +	{
> > +		.type = IIO_CONCENTRATION,
> > +		.channel2 = IIO_MOD_H2,
> > +		.modified = 1,
> > +		.info_mask_separate =
> > +			BIT(IIO_CHAN_INFO_RAW),
> 
> Same here on length.
> 
> > +		.address = SGP30_SIG_H2_IDX,
> > +		.scan_type = {
> > +			.endianness = IIO_BE,
> > +		},
> > +	},
> > +};
> > +
> > +static const struct iio_chan_spec sgpc3_channels[] = {
> > +	{
> > +		.type = IIO_CONCENTRATION,
> > +		.channel2 = IIO_MOD_VOC,
> > +		.modified = 1,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> > +		.address = SGPC3_IAQ_TVOC_IDX,
> > +	},
> > +	{
> > +		.type = IIO_CONCENTRATION,
> > +		.channel2 = IIO_MOD_ETHANOL,
> > +		.modified = 1,
> > +		.info_mask_separate =
> > +			BIT(IIO_CHAN_INFO_RAW),
> 
> And another on length.
> > +		.address = SGPC3_SIG_ETOH_IDX,
> > +		.scan_type = {
> > +			.endianness = IIO_BE,
> > +		},
> > +	},
> > +};
> > +
> > +static const struct sgp_device sgp_devices[] = {
> > +	[SGP30] = {
> > +		.channels = sgp30_channels,
> > +		.num_channels = ARRAY_SIZE(sgp30_channels),
> > +	},
> > +	[SGPC3] = {
> > +		.channels = sgpc3_channels,
> > +		.num_channels = ARRAY_SIZE(sgpc3_channels),
> > +	},
> > +};
> > +
> > +/**
> > + * sgp_verify_buffer() - verify the checksums of the data buffer
> > words
> > + *
> > + * @data:       SGP data
> > + * @buf:        Raw data buffer
> > + * @word_count: Num data words stored in the buffer, excluding CRC
> > bytes
> > + *
> > + * Return:      0 on success, negative error otherwise.
> > + */
> > +static int sgp_verify_buffer(const struct sgp_data *data,
> > +			     union sgp_reading *buf, size_t word_count)
> > +{
> > +	size_t size = word_count * (SGP_WORD_LEN + SGP_CRC8_LEN);
> > +	int i;
> > +	u8 crc;
> > +	u8 *data_buf = &buf->start;
> > +
> > +	for (i = 0; i < size; i += SGP_WORD_LEN + SGP_CRC8_LEN) {
> > +		crc = crc8(sgp_crc8_table, &data_buf[i], SGP_WORD_LEN,
> > +			   SGP_CRC8_INIT);
> > +		if (crc != data_buf[i + SGP_WORD_LEN]) {
> > +			dev_err(&data->client->dev, "CRC error\n");
> > +			return -EIO;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * sgp_read_cmd() - reads data from sensor after issuing a command
> > + * The caller must hold data->data_lock for the duration of the
> > call.
> > + * @data:        SGP data
> > + * @cmd:         SGP Command to issue
> > + * @buf:         Raw data buffer to use
> > + * @word_count:  Num words to read, excluding CRC bytes
> > + *
> > + * Return:       0 on success, negative error otherwise.
> > + */
> > +static int sgp_read_cmd(struct sgp_data *data, enum sgp_cmd cmd,
> > +			union sgp_reading *buf, size_t word_count,
> > +			unsigned long duration_us)
> > +{
> > +	int ret;
> > +	struct i2c_client *client = data->client;
> > +	size_t size = word_count * (SGP_WORD_LEN + SGP_CRC8_LEN);
> > +	u8 *data_buf;
> > +
> > +	ret = i2c_master_send(client, (const char *)&cmd, SGP_CMD_LEN);
> > +	if (ret != SGP_CMD_LEN)
> > +		return -EIO;
> > +	usleep_range(duration_us, duration_us + 1000);
> > +
> > +	if (word_count == 0)
> > +		return 0;
> > +
> > +	data_buf = &buf->start;
> > +	ret = i2c_master_recv(client, data_buf, size);
> > +	if (ret < 0)
> > +		return ret;
> > +	if (ret != size)
> > +		return -EIO;
> > +
> > +	return sgp_verify_buffer(data, buf, word_count);
> > +}
> > +
> > +/**
> > + * sgp_measure_iaq() - measure and retrieve IAQ values from sensor
> > + * The caller must hold data->data_lock for the duration of the
> > call.
> > + * @data:       SGP data
> > + *
> > + * Return:      0 on success, -EBUSY on default values, negative
> > error
> > + *              otherwise.
> > + */
> > +
> > +static int sgp_measure_iaq(struct sgp_data *data)
> > +{
> > +	int ret;
> > +	/* data contains default values */
> > +	bool default_vals = !time_after(jiffies, data-
> > >iaq_init_start_jiffies +
> > +						 data-
> > >iaq_defval_skip_jiffies);
> > +
> > +	ret = sgp_read_cmd(data, data->measure_iaq_cmd, &data-
> > >iaq_buffer,
> > +			   SGP_MEASUREMENT_LEN,
> > SGP_MEASUREMENT_DURATION_US);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	data->iaq_buffer_state = IAQ_BUFFER_DEFAULT_VALS;
> > +
> > +	if (default_vals)
> > +		return -EBUSY;
> > +
> > +	data->iaq_buffer_state = IAQ_BUFFER_VALID;
> > +
> > +	return 0;
> > +}
> > +
> > +static void sgp_iaq_thread_sleep_until(const struct sgp_data
> > *data,
> > +				       unsigned long sleep_jiffies)
> > +{
> > +	const long IAQ_POLL = 50000;
> > +
> > +	while (!time_after(jiffies, sleep_jiffies)) {
> > +		usleep_range(IAQ_POLL, IAQ_POLL + 10000);
> > +		if (kthread_should_stop() || data-
> > >iaq_init_start_jiffies == 0)
> > +			return;
> > +	}
> > +}
> > +
> > +static int sgp_iaq_threadfn(void *p)
> > +{
> > +	struct sgp_data *data = (struct sgp_data *)p;
> > +	unsigned long next_update_jiffies;
> > +	int ret;
> > +
> > +	while (!kthread_should_stop()) {
> > +		mutex_lock(&data->data_lock);
> > +		if (data->iaq_init_start_jiffies == 0) {
> > +			ret = sgp_read_cmd(data, data->iaq_init_cmd,
> > NULL, 0,
> > +					   SGP_CMD_DURATION_US);
> > +			if (ret < 0)
> > +				goto unlock_sleep_continue;
> > +			data->iaq_init_start_jiffies = jiffies;
> > +		}
> > +
> > +		ret = sgp_measure_iaq(data);
> > +		if (ret && ret != -EBUSY) {
> > +			dev_warn(&data->client->dev,
> > +				 "IAQ measurement error [%d]\n", ret);
> > +		}
> > +unlock_sleep_continue:
> > +		next_update_jiffies = jiffies + data-
> > >measure_interval_jiffies;
> > +		mutex_unlock(&data->data_lock);
> > +		sgp_iaq_thread_sleep_until(data, next_update_jiffies);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int sgp_read_raw(struct iio_dev *indio_dev,
> > +			struct iio_chan_spec const *chan, int *val,
> > +			int *val2, long mask)
> > +{
> > +	struct sgp_data *data = iio_priv(indio_dev);
> > +	struct sgp_crc_word *words;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_PROCESSED:
> > +		mutex_lock(&data->data_lock);
> > +		if (data->iaq_buffer_state != IAQ_BUFFER_VALID) {
> > +			mutex_unlock(&data->data_lock);
> > +			return -EBUSY;
> > +		}
> > +		words = data->iaq_buffer.raw_words;
> > +		switch (chan->address) {
> > +		case SGP30_IAQ_TVOC_IDX:
> > +		case SGPC3_IAQ_TVOC_IDX:
> > +			*val = 0;
> > +			*val2 = be16_to_cpu(words[1].value);
> > +			ret = IIO_VAL_INT_PLUS_NANO;
> > +			break;
> > +		case SGP30_IAQ_CO2EQ_IDX:
> > +			*val = 0;
> > +			*val2 = be16_to_cpu(words[0].value);
> > +			ret = IIO_VAL_INT_PLUS_MICRO;
> > +			break;
> > +		default:
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> > +		mutex_unlock(&data->data_lock);
> > +		break;
> > +	case IIO_CHAN_INFO_RAW:
> > +		mutex_lock(&data->data_lock);
> > +		if (chan->address == SGPC3_SIG_ETOH_IDX) {
> > +			if (data->iaq_buffer_state == IAQ_BUFFER_EMPTY)
> > +				ret = -EBUSY;
> > +			else
> > +				ret = 0;
> > +			words = data->iaq_buffer.raw_words;
> > +		} else {
> > +			ret = sgp_read_cmd(data, data-
> > >measure_gas_signals_cmd,
> > +					   &data->buffer,
> > SGP_MEASUREMENT_LEN,
> > +					   SGP_MEASUREMENT_DURATION_US)
> > ;
> > +			words = data->buffer.raw_words;
> > +		}
> > +		if (ret) {
> > +			mutex_unlock(&data->data_lock);
> > +			return ret;
> > +		}
> > +
> > +		switch (chan->address) {
> > +		case SGP30_SIG_ETOH_IDX:
> > +			*val = be16_to_cpu(words[1].value);
> > +			ret = IIO_VAL_INT;
> > +			break;
> > +		case SGPC3_SIG_ETOH_IDX:
> > +		case SGP30_SIG_H2_IDX:
> > +			*val = be16_to_cpu(words[0].value);
> > +			ret = IIO_VAL_INT;
> > +			break;
> > +		default:
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> > +		mutex_unlock(&data->data_lock);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int sgp_check_compat(struct sgp_data *data,
> > +			    unsigned int product_id)
> > +{
> > +	const struct sgp_version *supported_versions;
> > +	u16 ix, num_fs;
> > +	u16 product, generation, major, minor;
> > +
> > +	/* driver does not match product */
> > +	generation = SGP_VERS_GEN(data);
> > +	if (generation != 0) {
> > +		dev_err(&data->client->dev,
> > +			"incompatible product generation %d != 0",
> > generation);
> > +		return -ENODEV;
> > +	}
> > +
> > +	product = SGP_VERS_PRODUCT(data);
> > +	if (product != product_id) {
> > +		dev_err(&data->client->dev,
> > +			"sensor reports a different product:
> > 0x%04hx\n",
> > +			product);
> > +		return -ENODEV;
> > +	}
> > +
> > +	if (SGP_VERS_RESERVED(data))
> > +		dev_warn(&data->client->dev, "reserved bit is set\n");
> > +
> > +	/* engineering samples are not supported: no interface
> > guarantees */
> > +	if (SGP_VERS_ENG_BIT(data))
> > +		return -ENODEV;
> > +
> > +	switch (product) {
> > +	case SGP30:
> > +		supported_versions = supported_versions_sgp30;
> > +		num_fs = ARRAY_SIZE(supported_versions_sgp30);
> > +		break;
> > +	case SGPC3:
> > +		supported_versions = supported_versions_sgpc3;
> > +		num_fs = ARRAY_SIZE(supported_versions_sgpc3);
> > +		break;
> > +	default:
> > +		return -ENODEV;
> > +	}
> > +
> > +	major = SGP_VERS_MAJOR(data);
> > +	minor = SGP_VERS_MINOR(data);
> > +	for (ix = 0; ix < num_fs; ix++) {
> > +		if (major == supported_versions[ix].major &&
> > +		    minor >= supported_versions[ix].minor)
> > +			return 0;
> > +	}
> > +	dev_err(&data->client->dev, "unsupported sgp version: %d.%d\n",
> > +		major, minor);
> > +
> > +	return -ENODEV;
> > +}
> > +
> > +static void sgp_init(struct sgp_data *data)
> > +{
> > +	data->iaq_init_cmd = SGP_CMD_IAQ_INIT;
> > +	data->iaq_init_start_jiffies = 0;
> > +	data->iaq_buffer_state = IAQ_BUFFER_EMPTY;
> > +	switch (SGP_VERS_PRODUCT(data)) {
> > +	case SGP30:
> > +		data->measure_interval_jiffies =
> > SGP30_MEASURE_INTERVAL_HZ * HZ;
> > +		data->measure_iaq_cmd = SGP_CMD_IAQ_MEASURE;
> > +		data->measure_gas_signals_cmd =
> > SGP30_CMD_MEASURE_SIGNAL;
> > +		data->product_id = SGP30;
> > +		data->iaq_defval_skip_jiffies = 15 * HZ;
> > +		break;
> > +	case SGPC3:
> > +		data->measure_interval_jiffies =
> > SGPC3_MEASURE_INTERVAL_HZ * HZ;
> > +		data->measure_iaq_cmd = SGPC3_CMD_MEASURE_RAW;
> > +		data->measure_gas_signals_cmd = SGPC3_CMD_MEASURE_RAW;
> > +		data->product_id = SGPC3;
> > +		data->iaq_defval_skip_jiffies =
> > +			43 * data->measure_interval_jiffies;
> > +		break;
> > +	};
> > +}
> > +
> > +static const struct iio_info sgp_info = {
> > +	.read_raw	= sgp_read_raw,
> > +};
> > +
> > +static const struct of_device_id sgp_dt_ids[] = {
> > +	{ .compatible = "sensirion,sgp30", .data = (void *)SGP30 },
> > +	{ .compatible = "sensirion,sgpc3", .data = (void *)SGPC3 },
> > +	{ }
> > +};
> > +
> > +static int sgp_probe(struct i2c_client *client,
> > +		     const struct i2c_device_id *id)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct sgp_data *data;
> > +	const struct of_device_id *of_id;
> > +	unsigned long product_id;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	of_id = of_match_device(sgp_dt_ids, &client->dev);
> > +	if (of_id)
> > +		product_id = (unsigned long)of_id->data;
> > +	else
> > +		product_id = id->driver_data;
> > +
> > +	data = iio_priv(indio_dev);
> > +	i2c_set_clientdata(client, indio_dev);
> > +	data->client = client;
> > +	crc8_populate_msb(sgp_crc8_table, SGP_CRC8_POLYNOMIAL);
> > +	mutex_init(&data->data_lock);
> > +
> > +	/* get feature set version and write it to client data */
> > +	ret = sgp_read_cmd(data, SGP_CMD_GET_FEATURE_SET, &data-
> > >buffer, 1,
> > +			   SGP_CMD_DURATION_US);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	data->feature_set = be16_to_cpu(data-
> > >buffer.raw_words[0].value);
> > +
> > +	ret = sgp_check_compat(data, product_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	indio_dev->dev.parent = &client->dev;
> > +	indio_dev->info = &sgp_info;
> > +	indio_dev->name = id->name;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->channels = sgp_devices[product_id].channels;
> > +	indio_dev->num_channels = sgp_devices[product_id].num_channels;
> > +
> > +	sgp_init(data);
> > +
> > +	ret = devm_iio_device_register(&client->dev, indio_dev);
> > +	if (ret) {
> > +		dev_err(&client->dev, "failed to register iio
> > device\n");
> > +		return ret;
> > +	}
> > +
> > +	data->iaq_thread = kthread_run(sgp_iaq_threadfn, data,
> > +				       "%s-iaq", data->client->name);
> > +
> > +	return 0;
> > +}
> > +
> > +static int sgp_remove(struct i2c_client *client)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > +	struct sgp_data *data = iio_priv(indio_dev);
> > +
> > +	if (data->iaq_thread)
> > +		kthread_stop(data->iaq_thread);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct i2c_device_id sgp_id[] = {
> > +	{ "sgp30", SGP30 },
> > +	{ "sgpc3", SGPC3 },
> > +	{ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, sgp_id);
> > +MODULE_DEVICE_TABLE(of, sgp_dt_ids);
> > +
> > +static struct i2c_driver sgp_driver = {
> > +	.driver = {
> > +		.name = "sgp30",
> > +		.of_match_table = of_match_ptr(sgp_dt_ids),
> > +	},
> > +	.probe = sgp_probe,
> > +	.remove = sgp_remove,
> > +	.id_table = sgp_id,
> > +};
> > +module_i2c_driver(sgp_driver);
> > +
> > +MODULE_AUTHOR("Andreas Brauchli <andreas.brauchli@sensirion.com>")
> > ;
> > +MODULE_AUTHOR("Pascal Sachs <pascal.sachs@sensirion.com>");
> > +MODULE_DESCRIPTION("Sensirion SGP gas sensors");
> > +MODULE_LICENSE("GPL v2");
> 
> 

