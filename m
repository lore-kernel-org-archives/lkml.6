Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ABDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3507217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="BcMlNLOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfBZPCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:02:39 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42581 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfBZPCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:02:37 -0500
Received: by mail-ed1-f65.google.com with SMTP id j89so10963753edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 07:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rok/6r9YhtHH3jGvO+77hSfRRNN4Omveziq6b0sOWa8=;
        b=BcMlNLOJIXjKKAXb1Z291+6in6q13jwz3wqyTXMD324BixGl1is3rFXdMr8I237g1q
         PoPXsA5s7muuioWSiSb4/YwWxIKe/7RfHTj74RNeAwCxft399qAKftmojnw18a4IGXCr
         nAjUazwiqOeWF9p1ufGMtRJMujMUu5ajyh8dyHTCexrUVWRef0nkR8zRnGHVUP0nhd9a
         wrlKHVoMOJ71T7rjyNyBPZ0oZjA00OJMU6N2Cjn43QE7MIAHPISbzaeHrq22i6XB7Zu0
         kBg7Qa0hsGj9V2MRjObPn9AUQaCvFmqUKl0UxoIW4+e/3Qm2xWIw80xpy/mmx55JVtkA
         Xo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rok/6r9YhtHH3jGvO+77hSfRRNN4Omveziq6b0sOWa8=;
        b=Zg3H9S0DDkDEcoejsuWD5eZxa5iwtC2KVTaFEc0Ilm1+GamEy2rwW5UNIIxZmRf4ps
         URimrwJQHctT6Qn7oQKHa8n48aTxD8CBCGE3+mQeRJ0tn3MDQVsXW0AVarBN833V092m
         8OVA5MzjHAa3e2xCyTehjiXOCASsWVT2VaEaMp9+oV2GB4oypOyITMy84sZRjYpb/1Zk
         3VCj2KF8rGjLlADcptAMBiAsFHs2A5i4vfARTQflWHHMoWMfbtLAkCZ5FIEefvMQhAR1
         7sB9i3aN1GwLM3lkPn4YUbiLlJQVhhX+Blgqxp+Ay6H9j1dVuzChfUAbG62Z7Jzb7Gt3
         zBbg==
X-Gm-Message-State: AHQUAuZ3Sz96zD19F4c22l7BoUgUz/EoBq2vzGlqKXQf87XK0Ps9Qb6+
        4tssmj8muej0ibEHuyKse21evg==
X-Google-Smtp-Source: AHgI3IY36Ho6gbMXt1k44eThq/1UZBwIvkSIMGukoWRklBHKKwXjT6jmxdYw+dI6rhoAPI8Q9OfFdQ==
X-Received: by 2002:a17:906:4f12:: with SMTP id t18mr12188001eju.50.1551193355160;
        Tue, 26 Feb 2019 07:02:35 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id x45sm3521308edb.42.2019.02.26.07.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 07:02:34 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH v5 2/2] iio:temperature: Add MAX31856 thermocouple support
Date:   Tue, 26 Feb 2019 16:02:14 +0100
Message-Id: <20190226150214.19467-2-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190226150214.19467-1-patrick.havelange@essensium.com>
References: <20190226150214.19467-1-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>

This patch adds support for Maxim MAX31856 thermocouple
temperature sensor support.

More information can be found in:
https://www.maximintegrated.com/en/ds/MAX31856.pdf

NOTE: Driver support only Comparator Mode.

Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Signed-off-by: Matt Weber <matthew.weber@rockwellcollins.com>
Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
Changes
v1 -> v2
[Peter
	1. Fixed all space & 'return' related comments
	2. Removed 'sysfs_create_group' api  because
	   iio_device_register function is handling sysfs entry
	3. Return -EIO if there is any fault
	4. Added check for 'read_size' before spi read call
	5. Removed license text from the source file
	6. Added .o file in alphabetic order
	7. Used #defines instead of magic bits

v2 -> v3
[Jonathan
	1. Used bool for fault_oc and fault_ovuv
	2. Changed 'max31856_read' function and use byte array to
	   store registers value.
	3. Used 'GENMASK' where required
        4. Changed logic 'max31856_thermocouple_read' function. Used
	   array to read registers value.
	5. Used 'devm_iio_device_register' and removed 'max31856_remove'.
	6. Fixed other cosmetic changes.
	7. Added 'sysfs-bus-iio-temperature-max31856' file and updated
	   'MAINTAINERS' file.

v3 -> v4
[Jonathan
	1. Removed unwanted logic
	2. Updated code to handle return value of max31856_read call
	3. Added devicetree id table
	4. Removed one-shot support from driver as this support was not
	   implemented with correct design.

v4 -> v5
[Patrick
	1. Rename thermocouple type to maxim,thermocouple-type for DT entry
	2. Don't cache values from the Fault Status Register
	3. Simplify a bit max31856_init()
	4. Use IIO_NO_MOD in switch case + default error case
	5. Use dev_*() instead of pr_*()
	6. Fix missing space in comments
	7. Removed iio_info.driver_module assignment as no longer present
	8. Don't keep read/write buffer into the internal driver struct
	9. Updated kernel version, add missing space in documentation
       10. Updated (c) year
       11. Removed linux/init.h #include
       12. More use of BIT() macro
       13. Removed iio_chan_spec.address assignment as not used
       14. In max31856_thermocouple_read(), same switch case order as
	   channels definition
       15. Refactor show_fault_*() functions
       16. Use u8 as register type in max31856_{read,write}()
---
 .../sysfs-bus-iio-temperature-max31856        |  23 ++
 drivers/iio/temperature/Kconfig               |  10 +
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/max31856.c            | 332 ++++++++++++++++++
 4 files changed, 366 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
 create mode 100644 drivers/iio/temperature/max31856.c

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
new file mode 100644
index 000000000000..22659c91262c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
@@ -0,0 +1,23 @@
+What:		/sys/bus/iio/devices/iio:deviceX/fault_oc
+KernelVersion:	5.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Open-circuit fault. The detection of open-circuit faults,
+		such as those caused by broken thermocouple wires.
+		Reading returns either '1' or '0'.
+		'1' = An open circuit such as broken thermocouple wires
+		      has been detected.
+		'0' = No open circuit or broken thermocouple wires are detected
+
+What:		/sys/bus/iio/devices/iio:deviceX/fault_ovuv
+KernelVersion:	5.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Overvoltage or Undervoltage Input Fault. The internal circuitry
+		is protected from excessive voltages applied to the thermocouple
+		cables by integrated MOSFETs at the T+ and T- inputs, and the
+		BIAS output. These MOSFETs turn off when the input voltage is
+		negative or greater than VDD.
+		Reading returns either '1' or '0'.
+		'1' = The input voltage is negative or greater than VDD.
+		'0' = The input voltage is positive and less than VDD (default).
diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 82e4a62745e2..c66eeb23615b 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -97,4 +97,14 @@ config TSYS02D
 	  This driver can also be built as a module. If so, the module will
 	  be called tsys02d.
 
+config MAX31856
+	tristate "MAX31856 thermocouple sensor"
+	depends on SPI
+	help
+	  If you say yes here you get support for MAX31856
+	  thermocouple sensor chip connected via SPI.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called max31856.
+
 endmenu
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index 34a31db0bb63..baca4776ca0d 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
 obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
+obj-$(CONFIG_MAX31856) += max31856.o
 obj-$(CONFIG_MLX90614) += mlx90614.o
 obj-$(CONFIG_MLX90632) += mlx90632.o
 obj-$(CONFIG_TMP006) += tmp006.o
diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
new file mode 100644
index 000000000000..d0e206ff10ba
--- /dev/null
+++ b/drivers/iio/temperature/max31856.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0
+/* max31856.c
+ *
+ * Maxim MAX31856 thermocouple sensor driver
+ *
+ * Copyright (C) 2018-2019 Rockwell Collins
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/spi/spi.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+/*
+ * The MSB of the register value determines whether the following byte will
+ * be written or read. If it is 0, one or more byte reads will follow.
+ */
+#define MAX31856_RD_WR_BIT         BIT(7)
+
+#define MAX31856_CR0_AUTOCONVERT   BIT(7)
+#define MAX31856_CR0_1SHOT         BIT(6)
+#define MAX31856_CR0_OCFAULT       BIT(4)
+#define MAX31856_CR0_OCFAULT_MASK  GENMASK(5, 4)
+#define MAX31856_TC_TYPE_MASK      GENMASK(3, 0)
+#define MAX31856_FAULT_OVUV        BIT(1)
+#define MAX31856_FAULT_OPEN        BIT(0)
+
+/* The MAX31856 registers */
+#define MAX31856_CR0_REG           0x00
+#define MAX31856_CR1_REG           0x01
+#define MAX31856_MASK_REG          0x02
+#define MAX31856_CJHF_REG          0x03
+#define MAX31856_CJLF_REG          0x04
+#define MAX31856_LTHFTH_REG        0x05
+#define MAX31856_LTHFTL_REG        0x06
+#define MAX31856_LTLFTH_REG        0x07
+#define MAX31856_LTLFTL_REG        0x08
+#define MAX31856_CJTO_REG          0x09
+#define MAX31856_CJTH_REG          0x0A
+#define MAX31856_CJTL_REG          0x0B
+#define MAX31856_LTCBH_REG         0x0C
+#define MAX31856_LTCBM_REG         0x0D
+#define MAX31856_LTCBL_REG         0x0E
+#define MAX31856_SR_REG            0x0F
+
+static const struct iio_chan_spec max31856_channels[] = {
+	{	/* Thermocouple Temperature */
+		.type = IIO_TEMP,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{	/* Cold Junction Temperature */
+		.type = IIO_TEMP,
+		.channel2 = IIO_MOD_TEMP_AMBIENT,
+		.modified = 1,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+struct max31856_data {
+	struct spi_device *spi;
+	u32 thermocouple_type;
+};
+
+static int max31856_read(struct max31856_data *data, u8 reg,
+			 u8 val[], unsigned int read_size)
+{
+	return spi_write_then_read(data->spi, &reg, 1, val, read_size);
+}
+
+static int max31856_write(struct max31856_data *data, u8 reg,
+			  unsigned int val)
+{
+	u8 buf[2];
+
+	buf[0] = reg | (MAX31856_RD_WR_BIT);
+	buf[1] = val;
+
+	return spi_write(data->spi, buf, 2);
+}
+
+static int max31856_init(struct max31856_data *data)
+{
+	int ret;
+	u8 reg_cr0_val, reg_cr1_val;
+
+	/* Start by changing to Off mode before making changes as
+	 * some settings are recommended to be set only when the device
+	 * is off
+	 */
+	ret = max31856_read(data, MAX31856_CR0_REG, &reg_cr0_val, 1);
+	if (ret)
+		return ret;
+
+	reg_cr0_val &= ~MAX31856_CR0_AUTOCONVERT;
+	ret = max31856_write(data, MAX31856_CR0_REG, reg_cr0_val);
+	if (ret)
+		return ret;
+
+	/* Set thermocouple type based on dts property */
+	ret = max31856_read(data, MAX31856_CR1_REG, &reg_cr1_val, 1);
+	if (ret)
+		return ret;
+
+	reg_cr1_val &= ~MAX31856_TC_TYPE_MASK;
+	reg_cr1_val |= data->thermocouple_type;
+	ret = max31856_write(data, MAX31856_CR1_REG, reg_cr1_val);
+	if (ret)
+		return ret;
+
+	/*
+	 * Enable Open circuit fault detection
+	 * Read datasheet for more information: Table 4.
+	 * Value 01 means : Enabled (Once every 16 conversions)
+	 */
+	reg_cr0_val &= ~MAX31856_CR0_OCFAULT_MASK;
+	reg_cr0_val |= MAX31856_CR0_OCFAULT;
+
+	/* Set Auto Conversion Mode */
+	reg_cr0_val &= ~MAX31856_CR0_1SHOT;
+	reg_cr0_val |= MAX31856_CR0_AUTOCONVERT;
+
+	return max31856_write(data, MAX31856_CR0_REG, reg_cr0_val);
+}
+
+static int max31856_thermocouple_read(struct max31856_data *data,
+				      struct iio_chan_spec const *chan,
+				      int *val)
+{
+	int ret, offset_cjto;
+	u8 reg_val[3];
+
+	switch (chan->channel2) {
+	case IIO_NO_MOD:
+		/*
+		 * Multibyte Read
+		 * MAX31856_LTCBH_REG, MAX31856_LTCBM_REG, MAX31856_LTCBL_REG
+		 */
+		ret = max31856_read(data, MAX31856_LTCBH_REG, reg_val, 3);
+		if (ret)
+			return ret;
+		/* Skip last 5 dead bits of LTCBL */
+		*val = (reg_val[0] << 16 | reg_val[1] << 8 | reg_val[2]) >> 5;
+		/* Check 7th bit of LTCBH reg. value for sign*/
+		if (reg_val[0] & 0x80)
+			*val -= 0x80000;
+		break;
+
+	case IIO_MOD_TEMP_AMBIENT:
+		/*
+		 * Multibyte Read
+		 * MAX31856_CJTO_REG, MAX31856_CJTH_REG, MAX31856_CJTL_REG
+		 */
+		ret = max31856_read(data, MAX31856_CJTO_REG, reg_val, 3);
+		if (ret)
+			return ret;
+		/* Get Cold Junction Temp. offset register value */
+		offset_cjto = reg_val[0];
+		/* Get CJTH and CJTL value and skip last 2 dead bits of CJTL */
+		*val = (reg_val[1] << 8 | reg_val[2]) >> 2;
+		/* As per datasheet add offset into CJTH and CJTL */
+		*val += offset_cjto;
+		/* Check 7th bit of CJTH reg. value for sign */
+		if (reg_val[1] & 0x80)
+			*val -= 0x4000;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	ret = max31856_read(data, MAX31856_SR_REG, reg_val, 1);
+	if (ret)
+		return ret;
+	/* Check for over/under voltage or open circuit fault */
+	if (reg_val[0] & (MAX31856_FAULT_OVUV | MAX31856_FAULT_OPEN))
+		return -EIO;
+
+	return ret;
+}
+
+static int max31856_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct max31856_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = max31856_thermocouple_read(data, chan, val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->channel2) {
+		case IIO_MOD_TEMP_AMBIENT:
+			/* Cold junction Temp. Data resolution is 0.015625 */
+			*val = 15;
+			*val2 = 625000; /* 1000 * 0.015625 */
+			ret = IIO_VAL_INT_PLUS_MICRO;
+			break;
+		default:
+			/* Thermocouple Temp. Data resolution is 0.0078125 */
+			*val = 7;
+			*val2 = 812500; /* 1000 * 0.0078125) */
+			return IIO_VAL_INT_PLUS_MICRO;
+		}
+		break;
+	}
+
+	return ret;
+}
+
+static ssize_t show_fault(struct device *dev, u8 faultbit, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct max31856_data *data = iio_priv(indio_dev);
+	u8 reg_val;
+	int ret;
+	bool fault;
+
+	ret = max31856_read(data, MAX31856_SR_REG, &reg_val, 1);
+	if (ret)
+		return ret;
+
+	fault = reg_val & faultbit;
+
+	return sprintf(buf, "%d\n", fault);
+}
+
+static ssize_t show_fault_ovuv(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	return show_fault(dev, MAX31856_FAULT_OVUV, buf);
+}
+
+static ssize_t show_fault_oc(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	return show_fault(dev, MAX31856_FAULT_OPEN, buf);
+}
+
+static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
+static IIO_DEVICE_ATTR(fault_oc, 0444, show_fault_oc, NULL, 0);
+
+static struct attribute *max31856_attributes[] = {
+	&iio_dev_attr_fault_ovuv.dev_attr.attr,
+	&iio_dev_attr_fault_oc.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group max31856_group = {
+	.attrs = max31856_attributes,
+};
+
+static const struct iio_info max31856_info = {
+	.read_raw = max31856_read_raw,
+	.attrs = &max31856_group,
+};
+
+static int max31856_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct iio_dev *indio_dev;
+	struct max31856_data *data;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->spi = spi;
+
+	spi_set_drvdata(spi, indio_dev);
+
+	indio_dev->info = &max31856_info;
+	indio_dev->name = id->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = max31856_channels;
+	indio_dev->num_channels = ARRAY_SIZE(max31856_channels);
+
+	ret = of_property_read_u32(spi->dev.of_node, "maxim,thermocouple-type",
+				   &data->thermocouple_type);
+
+	if (ret) {
+		dev_info(&spi->dev,
+			 "Could not read thermocouple type DT property, configuring as a K-Type\n");
+		data->thermocouple_type = 0x03; /* K-Type */
+	}
+
+	ret = max31856_init(data);
+	if (ret) {
+		dev_err(&spi->dev, "error: Failed to configure max31856\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id max31856_id[] = {
+	{ "max31856", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, max31856_id);
+
+static const struct of_device_id max31856_of_match[] = {
+	{ .compatible = "maxim,max31856" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max31856_of_match);
+
+static struct spi_driver max31856_driver = {
+	.driver = {
+		.name = "max31856",
+		.of_match_table = max31856_of_match,
+	},
+	.probe = max31856_probe,
+	.id_table = max31856_id,
+};
+module_spi_driver(max31856_driver);
+
+MODULE_AUTHOR("Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>");
+MODULE_AUTHOR("Patrick Havelange <patrick.havelange@essensium.com>");
+MODULE_DESCRIPTION("Maxim MAX31856 thermocouple sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.19.1

