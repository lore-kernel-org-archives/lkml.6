Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D74C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 18:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B407C217FA
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 18:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMHsxP4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbfBQSxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 13:53:15 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45723 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfBQSxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 13:53:14 -0500
Received: by mail-lf1-f66.google.com with SMTP id h10so10442756lfc.12;
        Sun, 17 Feb 2019 10:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8kX8AIAnFT3O3BUO0QaYTQofr5PTbEY+g0KyvCQQO5o=;
        b=MMHsxP4mmHhRjuue37bGFdgExrNAjiLVX42Djpf8EqjU6mxwwSYuzNCFJDCEpHd21I
         Lm4O70XLKzl1vOqdFiUvd+JU0LQulxGeaNOAaH+zUEAo+nXBr+CwtW89tCBxTxAXKD2C
         NGfifpop/TxdvAooYPmsAyv+YDnWWZishjhQ71VQbKiuDFql3+8u8sEsZcHEjo4udvG6
         gbqLqCeqMQfV5Xir2M4y30Z4MkEBe6O4UQQaUo5Lr7Wqj16smRw/F5k6626wv1PRmftR
         2VshjX1F9F+C7JNXUHHr1cPPFv74o2tkOcJwDQ6x7p46sFdeDpddueO9f02AVnxBDYaB
         UcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=8kX8AIAnFT3O3BUO0QaYTQofr5PTbEY+g0KyvCQQO5o=;
        b=RWb2C7hlGtQGq5Jprqd7dvQx6HxAK7SCLYOtRhYYV6pj4BEeiHqU4qkNr11zmKrWyF
         alBx/z7lCetGOiYV+bFKx+MquoNDqdf+tq+8s3OLp2zrCuBYkjdVthuAoyySOh73X9VN
         s8gHQ3JwFIn+m58sZpuszrExzNq/SOfP6664iQPwrl1Vgx+m32hqownn6J9vq3UG4zQZ
         ZI5d0ci1WGzBLsso/tKKSyvTM7azO4F2memWZtDKBk1doF2er79qTk+baGEo3AAKlMaI
         dfumyrMoWgqVWOBFwIBORuWVjP+anuBh0qssqTNQElNRmUgTaA3/UD2TKh1AAEq0HJIP
         0nzQ==
X-Gm-Message-State: AHQUAubEO3QlJo2v0bjaSqV17F9WkiZlShJL5x0YcBmgGXRsaoL2m6wI
        k/rdWYjNspGRK+mNa3vJR7I=
X-Google-Smtp-Source: AHgI3Ibub30l6/QQlCld7GV+G1hehahZI/A4ctF0ff/b1oZQiHFA/kW0nmYPqHIOwsnlnOqtByvWtQ==
X-Received: by 2002:a19:5504:: with SMTP id n4mr11916295lfe.43.1550429591036;
        Sun, 17 Feb 2019 10:53:11 -0800 (PST)
Received: from localhost.localdomain (6-191-187-93.customer.senator-telecom.com. [93.187.191.6])
        by smtp.googlemail.com with ESMTPSA id e26-v6sm2204527ljl.73.2019.02.17.10.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 10:53:10 -0800 (PST)
From:   Artem Panfilov <panfilov.artyom@gmail.com>
Cc:     Artem Panfilov <panfilov.artyom@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v3 1/2] rtc: add AB-RTCMC-32.768kHz-EOZ9 RTC support
Date:   Sun, 17 Feb 2019 21:52:56 +0300
Message-Id: <20190217185257.2131-1-panfilov.artyom@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for AB-RTCMC-32.768kHz-EOZ9 RTC/Calendar
module with I2C interface.

v3:
- Move validity check before reading time registers
- Add V1F/V2F check before reading the temperature
- Fix missing check of a return value

v2:
- Remove a package denomination in variable names and files
- Fix read/write time registers length
- Replace regmap_update_bits with regmap_write during probing
- Add a check and reset for PON, V2F, V1F registers
- Rename registers according to the datasheet

Signed-off-by: Artem Panfilov <panfilov.artyom@gmail.com>
---
 drivers/rtc/Kconfig       |  10 +
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-ab-eoz9.c | 465 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 476 insertions(+)
 create mode 100644 drivers/rtc/rtc-ab-eoz9.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 225b0b8516f3..ea0780a7f1bf 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -185,6 +185,16 @@ config RTC_DRV_ABB5ZES3
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-ab-b5ze-s3.
 
+config RTC_DRV_ABEOZ9
+	select REGMAP_I2C
+	tristate "Abracon AB-RTCMC-32.768kHz-EOZ9"
+	help
+	  If you say yes here you get support for the Abracon
+	  AB-RTCMC-32.768kHz-EOA9 I2C RTC chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-ab-e0z9.
+
 config RTC_DRV_ABX80X
 	tristate "Abracon ABx80x"
 	select WATCHDOG_CORE if WATCHDOG
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index df022d820bee..974252647087 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_RTC_DRV_88PM860X)	+= rtc-88pm860x.o
 obj-$(CONFIG_RTC_DRV_AB3100)	+= rtc-ab3100.o
 obj-$(CONFIG_RTC_DRV_AB8500)	+= rtc-ab8500.o
 obj-$(CONFIG_RTC_DRV_ABB5ZES3)	+= rtc-ab-b5ze-s3.o
+obj-$(CONFIG_RTC_DRV_ABEOZ9)	+= rtc-ab-eoz9.o
 obj-$(CONFIG_RTC_DRV_ABX80X)	+= rtc-abx80x.o
 obj-$(CONFIG_RTC_DRV_AC100)	+= rtc-ac100.o
 obj-$(CONFIG_RTC_DRV_ARMADA38X)	+= rtc-armada38x.o
diff --git a/drivers/rtc/rtc-ab-eoz9.c b/drivers/rtc/rtc-ab-eoz9.c
new file mode 100644
index 000000000000..e4f6e0061ccf
--- /dev/null
+++ b/drivers/rtc/rtc-ab-eoz9.c
@@ -0,0 +1,465 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Real Time Clock driver for AB-RTCMC-32.768kHz-EOZ9 chip.
+ * Copyright (C) 2019 Orolia
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/rtc.h>
+#include <linux/i2c.h>
+#include <linux/bcd.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+
+#define ABEOZ9_REG_CTRL1		0x00
+#define ABEOZ9_REG_CTRL1_MASK		GENMASK(7, 0)
+#define ABEOZ9_REG_CTRL1_WE		BIT(0)
+#define ABEOZ9_REG_CTRL1_TE		BIT(1)
+#define ABEOZ9_REG_CTRL1_TAR		BIT(2)
+#define ABEOZ9_REG_CTRL1_EERE		BIT(3)
+#define ABEOZ9_REG_CTRL1_SRON		BIT(4)
+#define ABEOZ9_REG_CTRL1_TD0		BIT(5)
+#define ABEOZ9_REG_CTRL1_TD1		BIT(6)
+#define ABEOZ9_REG_CTRL1_CLKINT		BIT(7)
+
+#define ABEOZ9_REG_CTRL_INT		0x01
+#define ABEOZ9_REG_CTRL_INT_AIE		BIT(0)
+#define ABEOZ9_REG_CTRL_INT_TIE		BIT(1)
+#define ABEOZ9_REG_CTRL_INT_V1IE	BIT(2)
+#define ABEOZ9_REG_CTRL_INT_V2IE	BIT(3)
+#define ABEOZ9_REG_CTRL_INT_SRIE	BIT(4)
+
+#define ABEOZ9_REG_CTRL_INT_FLAG	0x02
+#define ABEOZ9_REG_CTRL_INT_FLAG_AF	BIT(0)
+#define ABEOZ9_REG_CTRL_INT_FLAG_TF	BIT(1)
+#define ABEOZ9_REG_CTRL_INT_FLAG_V1IF	BIT(2)
+#define ABEOZ9_REG_CTRL_INT_FLAG_V2IF	BIT(3)
+#define ABEOZ9_REG_CTRL_INT_FLAG_SRF	BIT(4)
+
+#define ABEOZ9_REG_CTRL_STATUS		0x03
+#define ABEOZ9_REG_CTRL_STATUS_V1F	BIT(2)
+#define ABEOZ9_REG_CTRL_STATUS_V2F	BIT(3)
+#define ABEOZ9_REG_CTRL_STATUS_SR	BIT(4)
+#define ABEOZ9_REG_CTRL_STATUS_PON	BIT(5)
+#define ABEOZ9_REG_CTRL_STATUS_EEBUSY	BIT(7)
+
+#define ABEOZ9_REG_SEC			0x08
+#define ABEOZ9_REG_MIN			0x09
+#define ABEOZ9_REG_HOURS		0x0A
+#define ABEOZ9_HOURS_PM			BIT(6)
+#define ABEOZ9_REG_DAYS			0x0B
+#define ABEOZ9_REG_WEEKDAYS		0x0C
+#define ABEOZ9_REG_MONTHS		0x0D
+#define ABEOZ9_REG_YEARS		0x0E
+
+#define ABEOZ9_SEC_LEN			7
+
+#define ABEOZ9_REG_REG_TEMP		0x20
+#define ABEOZ953_TEMP_MAX		120
+#define ABEOZ953_TEMP_MIN		-60
+
+#define ABEOZ9_REG_EEPROM		0x30
+#define ABEOZ9_REG_EEPROM_MASK		GENMASK(8, 0)
+#define ABEOZ9_REG_EEPROM_THP		BIT(0)
+#define ABEOZ9_REG_EEPROM_THE		BIT(1)
+#define ABEOZ9_REG_EEPROM_FD0		BIT(2)
+#define ABEOZ9_REG_EEPROM_FD1		BIT(3)
+#define ABEOZ9_REG_EEPROM_R1K		BIT(4)
+#define ABEOZ9_REG_EEPROM_R5K		BIT(5)
+#define ABEOZ9_REG_EEPROM_R20K		BIT(6)
+#define ABEOZ9_REG_EEPROM_R80K		BIT(7)
+
+struct abeoz9_rtc_data {
+	struct rtc_device *rtc;
+	struct regmap *regmap;
+	struct device *hwmon_dev;
+};
+
+static int abeoz9_check_validity(struct device *dev)
+{
+	struct abeoz9_rtc_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	int ret;
+	int val;
+
+	ret = regmap_read(regmap, ABEOZ9_REG_CTRL_STATUS, &val);
+	if (ret < 0) {
+		dev_err(dev,
+			"unable to get CTRL_STATUS register (%d)\n", ret);
+		return ret;
+	}
+
+	if (val & ABEOZ9_REG_CTRL_STATUS_PON) {
+		dev_warn(dev, "power-on reset detected, date is invalid\n");
+		return -EINVAL;
+	}
+
+	if (val & ABEOZ9_REG_CTRL_STATUS_V1F) {
+		dev_warn(dev,
+			 "voltage drops below VLOW1 threshold, date is invalid\n");
+		return -EINVAL;
+	}
+
+	if ((val & ABEOZ9_REG_CTRL_STATUS_V2F)) {
+		dev_warn(dev,
+			 "voltage drops below VLOW2 threshold, date is invalid\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int abeoz9_reset_validity(struct regmap *regmap)
+{
+	return regmap_update_bits(regmap, ABEOZ9_REG_CTRL_STATUS,
+				  ABEOZ9_REG_CTRL_STATUS_V1F |
+				  ABEOZ9_REG_CTRL_STATUS_V2F |
+				  ABEOZ9_REG_CTRL_STATUS_PON,
+				  0);
+}
+
+static int abeoz9_rtc_get_time(struct device *dev, struct rtc_time *tm)
+{
+	struct abeoz9_rtc_data *data = dev_get_drvdata(dev);
+	u8 regs[ABEOZ9_SEC_LEN];
+	int ret;
+
+	ret = abeoz9_check_validity(dev);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_read(data->regmap, ABEOZ9_REG_SEC,
+			       regs,
+			       sizeof(regs));
+	if (ret) {
+		dev_err(dev, "reading RTC time failed (%d)\n", ret);
+		return ret;
+	}
+
+	tm->tm_sec = bcd2bin(regs[ABEOZ9_REG_SEC - ABEOZ9_REG_SEC] & 0x7F);
+	tm->tm_min = bcd2bin(regs[ABEOZ9_REG_MIN - ABEOZ9_REG_SEC] & 0x7F);
+
+	if (regs[ABEOZ9_REG_HOURS - ABEOZ9_REG_SEC] & ABEOZ9_HOURS_PM) {
+		tm->tm_hour =
+			bcd2bin(regs[ABEOZ9_REG_HOURS - ABEOZ9_REG_SEC] & 0x1f);
+		if (regs[ABEOZ9_REG_HOURS - ABEOZ9_REG_SEC] & ABEOZ9_HOURS_PM)
+			tm->tm_hour += 12;
+	} else {
+		tm->tm_hour = bcd2bin(regs[ABEOZ9_REG_HOURS - ABEOZ9_REG_SEC]);
+	}
+
+	tm->tm_mday = bcd2bin(regs[ABEOZ9_REG_DAYS - ABEOZ9_REG_SEC]);
+	tm->tm_wday = bcd2bin(regs[ABEOZ9_REG_WEEKDAYS - ABEOZ9_REG_SEC]);
+	tm->tm_mon  = bcd2bin(regs[ABEOZ9_REG_MONTHS - ABEOZ9_REG_SEC]) - 1;
+	tm->tm_year = bcd2bin(regs[ABEOZ9_REG_YEARS - ABEOZ9_REG_SEC]) + 100;
+
+	return ret;
+}
+
+static int abeoz9_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct abeoz9_rtc_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	u8 regs[ABEOZ9_SEC_LEN];
+	int ret;
+
+	regs[ABEOZ9_REG_SEC - ABEOZ9_REG_SEC] = bin2bcd(tm->tm_sec);
+	regs[ABEOZ9_REG_MIN - ABEOZ9_REG_SEC] = bin2bcd(tm->tm_min);
+	regs[ABEOZ9_REG_HOURS - ABEOZ9_REG_SEC] = bin2bcd(tm->tm_hour);
+	regs[ABEOZ9_REG_DAYS - ABEOZ9_REG_SEC] = bin2bcd(tm->tm_mday);
+	regs[ABEOZ9_REG_WEEKDAYS - ABEOZ9_REG_SEC] = bin2bcd(tm->tm_wday);
+	regs[ABEOZ9_REG_MONTHS - ABEOZ9_REG_SEC] = bin2bcd(tm->tm_mon + 1);
+	regs[ABEOZ9_REG_YEARS - ABEOZ9_REG_SEC] = bin2bcd(tm->tm_year - 100);
+
+	ret = regmap_bulk_write(data->regmap, ABEOZ9_REG_SEC,
+				regs,
+				sizeof(regs));
+
+	if (ret) {
+		dev_err(dev, "set RTC time failed (%d)\n", ret);
+		return ret;
+	}
+
+	return abeoz9_reset_validity(regmap);
+}
+
+static int abeoz9_trickle_parse_dt(struct device_node *node)
+{
+	u32 ohms = 0;
+
+	if (of_property_read_u32(node, "trickle-resistor-ohms", &ohms))
+		return 0;
+
+	switch (ohms) {
+	case 1000:
+		return ABEOZ9_REG_EEPROM_R1K;
+	case 5000:
+		return ABEOZ9_REG_EEPROM_R5K;
+	case 20000:
+		return ABEOZ9_REG_EEPROM_R20K;
+	case 80000:
+		return ABEOZ9_REG_EEPROM_R80K;
+	default:
+		return 0;
+	}
+}
+
+static int abeoz9_rtc_setup(struct device *dev, struct device_node *node)
+{
+	struct abeoz9_rtc_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	int ret;
+
+	/* Enable Self Recovery, Clock for Watch and EEPROM refresh functions */
+	ret = regmap_update_bits(regmap, ABEOZ9_REG_CTRL1,
+				 ABEOZ9_REG_CTRL1_MASK,
+				 ABEOZ9_REG_CTRL1_WE |
+				 ABEOZ9_REG_CTRL1_EERE |
+				 ABEOZ9_REG_CTRL1_SRON);
+	if (ret < 0) {
+		dev_err(dev, "unable to set CTRL_1 register (%d)\n", ret);
+		return ret;
+	}
+
+	ret = regmap_write(regmap, ABEOZ9_REG_CTRL_INT, 0);
+	if (ret < 0) {
+		dev_err(dev,
+			"unable to set control CTRL_INT register (%d)\n",
+			ret);
+		return ret;
+	}
+
+	ret = regmap_write(regmap, ABEOZ9_REG_CTRL_INT_FLAG, 0);
+	if (ret < 0) {
+		dev_err(dev,
+			"unable to set control CTRL_INT_FLAG register (%d)\n",
+			ret);
+		return ret;
+	}
+
+	ret = abeoz9_trickle_parse_dt(node);
+
+	/* Enable built-in termometer */
+	ret |= ABEOZ9_REG_EEPROM_THE;
+
+	ret = regmap_update_bits(regmap, ABEOZ9_REG_EEPROM,
+				 ABEOZ9_REG_EEPROM_MASK,
+				 ret);
+	if (ret < 0) {
+		dev_err(dev, "unable to set EEPROM register (%d)\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static const struct rtc_class_ops rtc_ops = {
+	.read_time = abeoz9_rtc_get_time,
+	.set_time  = abeoz9_rtc_set_time,
+};
+
+static const struct regmap_config abeoz9_rtc_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+#if IS_REACHABLE(CONFIG_HWMON)
+
+static int abeoz9z3_temp_read(struct device *dev,
+			      enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *temp)
+{
+	struct abeoz9_rtc_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	int ret;
+	unsigned int val;
+
+	ret = regmap_read(regmap, ABEOZ9_REG_CTRL_STATUS, &val);
+	if (ret < 0)
+		return ret;
+
+	if ((val & ABEOZ9_REG_CTRL_STATUS_V1F) ||
+	    (val & ABEOZ9_REG_CTRL_STATUS_V2F)) {
+		dev_err(dev,
+			"thermometer might be disabled due to low voltage\n");
+		return -EINVAL;
+	}
+
+	switch (attr) {
+	case hwmon_temp_input:
+		ret = regmap_read(regmap, ABEOZ9_REG_REG_TEMP, &val);
+		if (ret < 0)
+			return ret;
+		*temp = 1000 * (val + ABEOZ953_TEMP_MIN);
+		return 0;
+	case hwmon_temp_max:
+		*temp = 1000 * ABEOZ953_TEMP_MAX;
+		return 0;
+	case hwmon_temp_min:
+		*temp = 1000 * ABEOZ953_TEMP_MIN;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t abeoz9_is_visible(const void *data,
+				 enum hwmon_sensor_types type,
+				 u32 attr, int channel)
+{
+	switch (attr) {
+	case hwmon_temp_input:
+	case hwmon_temp_max:
+	case hwmon_temp_min:
+		return 0444;
+	default:
+		return 0;
+	}
+}
+
+static const u32 abeoz9_chip_config[] = {
+	HWMON_C_REGISTER_TZ,
+	0
+};
+
+static const struct hwmon_channel_info abeoz9_chip = {
+	.type = hwmon_chip,
+	.config = abeoz9_chip_config,
+};
+
+static const u32 abeoz9_temp_config[] = {
+	HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN,
+	0
+};
+
+static const struct hwmon_channel_info abeoz9_temp = {
+	.type = hwmon_temp,
+	.config = abeoz9_temp_config,
+};
+
+static const struct hwmon_channel_info *abeoz9_info[] = {
+	&abeoz9_chip,
+	&abeoz9_temp,
+	NULL
+};
+
+static const struct hwmon_ops abeoz9_hwmon_ops = {
+	.is_visible = abeoz9_is_visible,
+	.read = abeoz9z3_temp_read,
+};
+
+static const struct hwmon_chip_info abeoz9_chip_info = {
+	.ops = &abeoz9_hwmon_ops,
+	.info = abeoz9_info,
+};
+
+static void abeoz9_hwmon_register(struct device *dev,
+				  struct abeoz9_rtc_data *data)
+{
+	data->hwmon_dev =
+		devm_hwmon_device_register_with_info(dev,
+						     "abeoz9",
+						     data,
+						     &abeoz9_chip_info,
+						     NULL);
+	if (IS_ERR(data->hwmon_dev)) {
+		dev_warn(dev, "unable to register hwmon device %ld\n",
+			 PTR_ERR(data->hwmon_dev));
+	}
+}
+
+#else
+
+static void abeoz9_hwmon_register(struct device *dev,
+				  struct abeoz9_rtc_data *data)
+{
+}
+
+#endif
+
+static int abeoz9_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct abeoz9_rtc_data *data = NULL;
+	struct device *dev = &client->dev;
+	struct regmap *regmap;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
+				     I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_I2C_BLOCK)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	regmap = devm_regmap_init_i2c(client, &abeoz9_rtc_regmap_config);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(dev, "regmap allocation failed: %d\n", ret);
+		goto err;
+	}
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	data->regmap = regmap;
+	dev_set_drvdata(dev, data);
+
+	ret = abeoz9_rtc_setup(dev, client->dev.of_node);
+	if (ret)
+		goto err;
+
+	data->rtc = devm_rtc_allocate_device(dev);
+	ret = PTR_ERR_OR_ZERO(data->rtc);
+	if (ret)
+		goto err;
+
+	data->rtc->ops = &rtc_ops;
+	data->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	data->rtc->range_max = RTC_TIMESTAMP_END_2099;
+
+	ret = rtc_register_device(data->rtc);
+	if (ret)
+		goto err;
+
+	abeoz9_hwmon_register(dev, data);
+	return 0;
+
+err:
+	dev_err(dev, "unable to register RTC device (%d)\n", ret);
+	return ret;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id abeoz9_dt_match[] = {
+	{ .compatible = "abracon,abeoz9" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, abeoz9_dt_match);
+#endif
+
+static const struct i2c_device_id abeoz9_id[] = {
+	{ "abeoz9", 0 },
+	{ }
+};
+
+static struct i2c_driver abeoz9_driver = {
+	.driver = {
+		.name = "rtc-ab-eoz9",
+		.of_match_table = of_match_ptr(abeoz9_dt_match),
+	},
+	.probe	  = abeoz9_probe,
+	.id_table = abeoz9_id,
+};
+
+module_i2c_driver(abeoz9_driver);
+
+MODULE_AUTHOR("Artem Panfilov <panfilov.artyom@gmail.com>");
+MODULE_DESCRIPTION("Abracon AB-RTCMC-32.768kHz-EOZ9 RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.19.1

