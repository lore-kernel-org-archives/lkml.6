Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC384C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E4B2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIyeFp49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbfAaP3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:29:05 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40725 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfAaP3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:29:04 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so1489779pgp.7;
        Thu, 31 Jan 2019 07:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JPsZtb8HMNLizSMLr3v7s54mzw/da1qEIf2CG4q8b0w=;
        b=qIyeFp49hRCPUrPDXbNrofCofhlQhcjJ8OJbn47TIbw2Zv+5Z5Lbi1AWkFOk1nFRFb
         X543RCZOftZpdGKFp0t6y3lUejuxZYLOIeVchmq3KfOpFldbRs7IH0YTrN8LtJo8Id/f
         XYEEZk8dIj17L9WRiBBZEfiasMfG6QPozlV5N7JdoVpPIzSIvKfmEAC37J4LhIRxc/4V
         AxZ5OAsDdJ4DgFJCCy3OzcWo0uY/odCHU0VmvP+NfN5w/KWYHaX/OYgUdJ7GHjj/NNxq
         +2ln14CRfjhSaEHXoSxCG2CWujftbgC06rznQd/JJbTnIqb56YokgfUOqK5GMyA6J1Sg
         GeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JPsZtb8HMNLizSMLr3v7s54mzw/da1qEIf2CG4q8b0w=;
        b=Mj0awuRftKvQQe7b4uh9X0iDzcWbJoOKU9EUkljGPw7FpPMXNwfLnjx0P1/DvsotYS
         25QIZi+B54Sd+2kggRgAHTVB6bHeoCgCisUXGgBqESQtOS1gIDQy5ccPHHhbbWIK3LmC
         Osxfn73AUUJJogHJVYMvP2gv7tu8YdqDaaUAtFBpvJDHuAgsJrnkDSe/zb4qiyNifSr2
         kBxfCzPnIJeTVSsBPL2jfb/Da1eDagKCukGvVlI4pFV0U27E97w0+X48UUOi5f6JDTzH
         zYFC3m7e5NDD8pePItzYnhjkR7Qrn4fI/JNDzgYcA0mXw6HblB6T0WtAQU4lmkwgdnFu
         WVQw==
X-Gm-Message-State: AJcUukck9Pk22PY4cr+685w91dbvCRXtbZx68vz+JupdOBNv9QoJZFh1
        secZTmOTY2hUScPTCqdpLxF8sQkd
X-Google-Smtp-Source: ALg8bN61vkRKs3Jn4pt212hY4g/BUhcVPC5J1n5IfFP8IUyTXNOOacu3Vcxyzg+ceCdlyOzHSfLaiQ==
X-Received: by 2002:a63:e74b:: with SMTP id j11mr32097029pgk.397.1548948543265;
        Thu, 31 Jan 2019 07:29:03 -0800 (PST)
Received: from bobby.localdomain ([2601:1c0:5501:37e2::3977])
        by smtp.gmail.com with ESMTPSA id v2sm6453809pgs.0.2019.01.31.07.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 07:29:02 -0800 (PST)
Date:   Thu, 31 Jan 2019 07:29:01 -0800
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     bobbyeshleman@gmail.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] iio: light: add driver for MAX44009
Message-ID: <01f62d9d67110fd2c2f34e7835973fc6874a9fe8.1548947951.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAX44009 is a low-power ambient light sensor from Maxim
Integrated. It differs from the MAX44000 in that it doesn't have
proximity sensing and that it requires far less current (1 micro-amp
vs 5 micro-amps). The register mapping and feature set between the
two are different enough to require a new driver for the MAX44009.

Developed and tested with a BeagleBone Black and UDOO Neo (i.MX6SX)

Supported features:

* Reading lux (processed value)

* Rising and falling illuminance threshold
  events

* Configuring integration time

https://datasheets.maximintegrated.com/en/ds/MAX44009.pdf

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
Changes to v4:
- Reformat subject line
- Clean up whitespace

Changes to v3:
- Remove unnecessary mask when setting integration time
- Return IRQ_NONE in IRQ handler when interrupt not from this device
- Fix incorrect register usage when reading lux low byte
- Clean up style

Changes to v2:
- Remove unnecessary mutex locking
- Remove unnecessary triggered buffer support
- Remove unnecessary wrapper functions for smbus reads and writes
- Remove scale avail support
- Use constant scale to provide processed values instead of raw
- Remove IRQ_NONE return for non-shared IRQ
- Clean up style

 drivers/iio/light/Kconfig    |  10 +
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/max44009.c | 555 +++++++++++++++++++++++++++++++++++
 3 files changed, 566 insertions(+)
 create mode 100644 drivers/iio/light/max44009.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 36f458433480..5190eacfeb0a 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -299,6 +299,16 @@ config MAX44000
 	 To compile this driver as a module, choose M here:
 	 the module will be called max44000.
 
+config MAX44009
+	tristate "MAX44009 Ambient Light Sensor"
+	depends on I2C
+	help
+	 Say Y here if you want to build support for Maxim Integrated's
+	 MAX44009 ambient light sensor device.
+
+	 To compile this driver as a module, choose M here:
+	 the module will be called max44009.
+
 config OPT3001
 	tristate "Texas Instruments OPT3001 Light Sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 286bf3975372..e40794fbb435 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
 obj-$(CONFIG_LTR501)		+= ltr501.o
 obj-$(CONFIG_LV0104CS)		+= lv0104cs.o
 obj-$(CONFIG_MAX44000)		+= max44000.o
+obj-$(CONFIG_MAX44009)		+= max44009.o
 obj-$(CONFIG_OPT3001)		+= opt3001.o
 obj-$(CONFIG_PA12203001)	+= pa12203001.o
 obj-$(CONFIG_RPR0521)		+= rpr0521.o
diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
new file mode 100644
index 000000000000..00ba15499638
--- /dev/null
+++ b/drivers/iio/light/max44009.c
@@ -0,0 +1,555 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * max44009.c - Support for MAX44009 Ambient Light Sensor
+ *
+ * Copyright (c) 2019 Robert Eshleman <bobbyeshleman@gmail.com>
+ *
+ * Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX44009.pdf
+ *
+ * TODO: Support continuous mode and configuring from manual mode to
+ *	 automatic mode.
+ *
+ * Default I2C address: 0x4a
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/bits.h>
+#include <linux/i2c.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/util_macros.h>
+
+#define MAX44009_DRV_NAME "max44009"
+
+/* Registers in datasheet order */
+#define MAX44009_REG_INT_STATUS 0x0
+#define MAX44009_REG_INT_EN 0x1
+#define MAX44009_REG_CFG 0x2
+#define MAX44009_REG_LUX_HI 0x3
+#define MAX44009_REG_LUX_LO 0x4
+#define MAX44009_REG_UPPER_THR 0x5
+#define MAX44009_REG_LOWER_THR 0x6
+#define MAX44009_REG_THR_TIMER 0x7
+
+#define MAX44009_CFG_TIM_MASK GENMASK(2, 0)
+#define MAX44009_CFG_MAN_MODE_MASK BIT(6)
+
+/* The maximum rising threshold for the max44009 */
+#define MAX44009_MAXIMUM_THRESHOLD 7520256
+
+#define MAX44009_THRESH_EXP_MASK (0xf << 4)
+#define MAX44009_THRESH_EXP_RSHIFT 4
+#define MAX44009_THRESH_MANT_LSHIFT 4
+#define MAX44009_THRESH_MANT_MASK 0xf
+
+#define MAX44009_UPPER_THR_MINIMUM 15
+
+/* The max44009 always scales raw readings by 0.045 and is non-configurable */
+#define MAX44009_SCALE_NUMERATOR 45
+#define MAX44009_SCALE_DENOMINATOR 1000
+
+/* The fixed-point fractional multiplier for de-scaling threshold values */
+#define MAX44009_FRACT_MULT 1000000
+
+static const u32 max44009_int_time_ns_array[] = {
+	800000000,
+	400000000,
+	200000000,
+	100000000,
+	50000000, /* Manual mode only */
+	25000000, /* Manual mode only */
+	12500000, /* Manual mode only */
+	6250000,  /* Manual mode only */
+};
+
+static const char max44009_int_time_str[] =
+	"0.8 "
+	"0.4 "
+	"0.2 "
+	"0.1 "
+	"0.05 "
+	"0.025 "
+	"0.0125 "
+	"0.00625";
+
+struct max44009_data {
+	struct i2c_client *client;
+	struct mutex lock;
+};
+
+static const struct iio_event_spec max44009_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec max44009_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_INT_TIME),
+		.event_spec = max44009_event_spec,
+		.num_event_specs = ARRAY_SIZE(max44009_event_spec),
+	},
+};
+
+static int max44009_read_int_time(struct max44009_data *data)
+{
+
+	int ret = i2c_smbus_read_byte_data(data->client, MAX44009_REG_CFG);
+
+	if (ret < 0)
+		return ret;
+
+	return max44009_int_time_ns_array[ret & MAX44009_CFG_TIM_MASK];
+}
+
+static int max44009_write_int_time(struct max44009_data *data,
+				   int val, int val2)
+{
+	struct i2c_client *client = data->client;
+	int ret, int_time, config;
+	s64 ns;
+
+	ns = val * NSEC_PER_SEC + val2;
+	int_time = find_closest_descending(
+			ns,
+			max44009_int_time_ns_array,
+			ARRAY_SIZE(max44009_int_time_ns_array));
+
+	ret = i2c_smbus_read_byte_data(client, MAX44009_REG_CFG);
+	if (ret < 0)
+		return ret;
+
+	config = ret;
+	config &= int_time;
+
+	/*
+	 * To set the integration time, the device must also be in manual
+	 * mode.
+	 */
+	config |= MAX44009_CFG_MAN_MODE_MASK;
+
+	return i2c_smbus_write_byte_data(client, MAX44009_REG_CFG, config);
+}
+
+static int max44009_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, int val,
+			      int val2, long mask)
+{
+	struct max44009_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (mask == IIO_CHAN_INFO_INT_TIME && chan->type == IIO_LIGHT) {
+		mutex_lock(&data->lock);
+		ret = max44009_write_int_time(data, val, val2);
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+	return -EINVAL;
+}
+
+static int max44009_write_raw_get_fmt(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      long mask)
+{
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int max44009_lux_raw(u8 hi, u8 lo)
+{
+	int mantissa;
+	int exponent;
+
+	/*
+	 * The mantissa consists of the low nibble of the Lux High Byte
+	 * and the low nibble of the Lux Low Byte.
+	 */
+	mantissa = ((hi & 0xf) << 4) | (lo & 0xf);
+
+	/* The exponent byte is just the upper nibble of the Lux High Byte */
+	exponent = (hi >> 4) & 0xf;
+
+	/*
+	 * The exponent value is base 2 to the power of the raw exponent byte.
+	 */
+	exponent = 1 << exponent;
+
+	return exponent * mantissa;
+}
+
+#define MAX44009_READ_LUX_XFER_LEN (4)
+
+static int max44009_read_lux_raw(struct max44009_data *data)
+{
+	int ret;
+	u8 hireg = MAX44009_REG_LUX_HI;
+	u8 loreg = MAX44009_REG_LUX_LO;
+	u8 lo = 0;
+	u8 hi = 0;
+
+	struct i2c_msg msgs[] = {
+		{
+			.addr = data->client->addr,
+			.flags = 0,
+			.len = sizeof(hireg),
+			.buf = &hireg,
+		},
+		{
+			.addr = data->client->addr,
+			.flags = I2C_M_RD,
+			.len = sizeof(hi),
+			.buf = &hi,
+		},
+		{
+			.addr = data->client->addr,
+			.flags = 0,
+			.len = sizeof(loreg),
+			.buf = &loreg,
+		},
+		{
+			.addr = data->client->addr,
+			.flags = I2C_M_RD,
+			.len = sizeof(lo),
+			.buf = &lo,
+		}
+	};
+
+	/*
+	 * Use i2c_transfer instead of smbus read because i2c_transfer
+	 * does NOT use a stop bit between address write and data read.
+	 * Using a stop bit causes disjoint upper/lower byte reads and
+	 * reduces accuracy.
+	 */
+	ret = i2c_transfer(data->client->adapter,
+			   msgs, MAX44009_READ_LUX_XFER_LEN);
+
+	if (ret != MAX44009_READ_LUX_XFER_LEN)
+		return -EIO;
+
+	return max44009_lux_raw(hi, lo);
+}
+
+static int max44009_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int *val,
+			     int *val2, long mask)
+{
+	struct max44009_data *data = iio_priv(indio_dev);
+	int lux_raw;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			ret = max44009_read_lux_raw(data);
+			if (ret < 0)
+				return ret;
+			lux_raw = ret;
+
+			*val = lux_raw * MAX44009_SCALE_NUMERATOR;
+			*val2 = MAX44009_SCALE_DENOMINATOR;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_INT_TIME:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			ret = max44009_read_int_time(data);
+			if (ret < 0)
+				return ret;
+
+			*val2 = ret;
+			*val = 0;
+			return IIO_VAL_INT_PLUS_NANO;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static IIO_CONST_ATTR(illuminance_integration_time_available,
+		      max44009_int_time_str);
+
+static struct attribute *max44009_attributes[] = {
+	&iio_const_attr_illuminance_integration_time_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group max44009_attribute_group = {
+	.attrs = max44009_attributes,
+};
+
+static int max44009_threshold_byte_from_fraction(int integral, int fractional)
+{
+	int mantissa, exp;
+
+	if ((integral <= 0 && fractional <= 0) ||
+	     integral > MAX44009_MAXIMUM_THRESHOLD ||
+	     (integral == MAX44009_MAXIMUM_THRESHOLD && fractional != 0))
+		return -EINVAL;
+
+	/* Reverse scaling of fixed-point integral */
+	mantissa = integral * MAX44009_SCALE_DENOMINATOR;
+	mantissa /= MAX44009_SCALE_NUMERATOR;
+
+	/* Reverse scaling of fixed-point fractional */
+	mantissa += fractional / MAX44009_FRACT_MULT *
+		    (MAX44009_SCALE_DENOMINATOR / MAX44009_SCALE_NUMERATOR);
+
+	for (exp = 0; mantissa > 0xff; exp++)
+		mantissa >>= 1;
+
+	mantissa >>= 4;
+	mantissa &= 0xf;
+	exp <<= 4;
+
+	return exp | mantissa;
+}
+
+static int max44009_get_thr_reg(enum iio_event_direction dir)
+{
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return MAX44009_REG_UPPER_THR;
+	case IIO_EV_DIR_FALLING:
+		return MAX44009_REG_LOWER_THR;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max44009_write_event_value(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      enum iio_event_info info,
+				      int val, int val2)
+{
+	struct max44009_data *data = iio_priv(indio_dev);
+	int reg, threshold;
+
+	if (info != IIO_EV_INFO_VALUE || chan->type != IIO_LIGHT)
+		return -EINVAL;
+
+	threshold = max44009_threshold_byte_from_fraction(val, val2);
+	if (threshold < 0)
+		return threshold;
+
+	reg = max44009_get_thr_reg(dir);
+	if (reg < 0)
+		return reg;
+
+	return i2c_smbus_write_byte_data(data->client, reg, threshold);
+}
+
+static int max44009_read_threshold(struct iio_dev *indio_dev,
+				   enum iio_event_direction dir)
+{
+	struct max44009_data *data = iio_priv(indio_dev);
+	int byte, reg;
+	int mantissa, exponent;
+
+	reg = max44009_get_thr_reg(dir);
+	if (reg < 0)
+		return reg;
+
+	byte = i2c_smbus_read_byte_data(data->client, reg);
+	if (byte < 0)
+		return byte;
+
+	mantissa = byte & MAX44009_THRESH_MANT_MASK;
+	mantissa <<= MAX44009_THRESH_MANT_LSHIFT;
+
+	/*
+	 * To get the upper threshold, always adds the minimum upper threshold
+	 * value to the shifted byte value (see datasheet).
+	 */
+	if (dir == IIO_EV_DIR_RISING)
+		mantissa += MAX44009_UPPER_THR_MINIMUM;
+
+	/*
+	 * Exponent is base 2 to the power of the threshold exponent byte
+	 * value
+	 */
+	exponent = byte & MAX44009_THRESH_EXP_MASK;
+	exponent >>= MAX44009_THRESH_EXP_RSHIFT;
+
+	return (1 << exponent) * mantissa;
+}
+
+static int max44009_read_event_value(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info,
+				     int *val, int *val2)
+{
+	int ret;
+	int threshold;
+
+	if (chan->type != IIO_LIGHT || type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	ret = max44009_read_threshold(indio_dev, dir);
+	if (ret < 0)
+		return ret;
+	threshold = ret;
+
+	*val = threshold * MAX44009_SCALE_NUMERATOR;
+	*val2 = MAX44009_SCALE_DENOMINATOR;
+
+	return IIO_VAL_FRACTIONAL;
+}
+
+static int max44009_write_event_config(struct iio_dev *indio_dev,
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir,
+				       int state)
+{
+	struct max44009_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (chan->type != IIO_LIGHT || type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	ret = i2c_smbus_write_byte_data(data->client,
+					MAX44009_REG_INT_EN, state);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Set device to trigger interrupt immediately upon exceeding
+	 * the threshold limit.
+	 */
+	return i2c_smbus_write_byte_data(data->client,
+					 MAX44009_REG_THR_TIMER, 0);
+}
+
+static int max44009_read_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir)
+{
+	struct max44009_data *data = iio_priv(indio_dev);
+
+	if (chan->type != IIO_LIGHT || type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	return i2c_smbus_read_byte_data(data->client, MAX44009_REG_INT_EN);
+}
+
+static const struct iio_info max44009_info = {
+	.read_raw = max44009_read_raw,
+	.write_raw = max44009_write_raw,
+	.write_raw_get_fmt = max44009_write_raw_get_fmt,
+	.read_event_value = max44009_read_event_value,
+	.read_event_config = max44009_read_event_config,
+	.write_event_value = max44009_write_event_value,
+	.write_event_config = max44009_write_event_config,
+	.attrs = &max44009_attribute_group,
+};
+
+static irqreturn_t max44009_threaded_irq_handler(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct max44009_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, MAX44009_REG_INT_STATUS);
+	if (ret) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_EITHER),
+			       iio_get_time_ns(indio_dev));
+
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int max44009_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct max44009_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &max44009_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = MAX44009_DRV_NAME;
+	indio_dev->channels = max44009_channels;
+	indio_dev->num_channels = ARRAY_SIZE(max44009_channels);
+	mutex_init(&data->lock);
+
+	/* Clear any stale interrupt bit */
+	ret = i2c_smbus_read_byte_data(client, MAX44009_REG_CFG);
+	if (ret < 0)
+		return ret;
+
+	if (client->irq > 0) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL,
+						max44009_threaded_irq_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT | IRQF_SHARED,
+						"max44009_event",
+						indio_dev);
+		if (ret < 0)
+			return ret;
+	}
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id max44009_id[] = {
+	{ "max44009", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max44009_id);
+
+static struct i2c_driver max44009_driver = {
+	.driver = {
+		.name = MAX44009_DRV_NAME,
+	},
+	.probe = max44009_probe,
+	.id_table = max44009_id,
+};
+module_i2c_driver(max44009_driver);
+
+static const struct of_device_id max44009_of_match[] = {
+	{ .compatible = "maxim,max44009" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max44009_of_match);
+
+MODULE_AUTHOR("Robert Eshleman <bobbyeshleman@gmail.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("MAX44009 ambient light sensor driver");
-- 
2.20.1

