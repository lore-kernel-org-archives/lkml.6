Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9089AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497592085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlTsRpMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfAOLC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 06:02:28 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43272 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbfAOLC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 06:02:27 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so1674586lff.10;
        Tue, 15 Jan 2019 03:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yrA+rd4GjrUUiBEcKL8jSz8rOoucIOZexJ3Bz729SJA=;
        b=LlTsRpMjn3qRqQNpWrrVwLBJ4EmH6N88g9VkRH15/g7eGnoNdrxlgIsv+ElD1Yal3e
         NqfxgXLfoIQAYYoxTVZo97r1cyAKr1zQfaZUELPAFZETZ5l/TcBiJYEhZ8WFDAiRnK4g
         SpAYOlHi43Psj2Hi82T2ffBDgU9WrXKvvecWRX/8b5e4LK9QkuR3HfV2Nf00XU+FCRkN
         kMJN6Ea/Y3RobVJuk+x3AI3S038HJNMkErAmwzXmrZOH6PPI10ufwixXKuJ2xxUs8DgH
         0du9Y5/8PCU+tjt4u7MJ3c7xP0iTy1D7bY8Dj7JRYj2s7v2dgpyBf1c44E7jPnQTRQPC
         KHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yrA+rd4GjrUUiBEcKL8jSz8rOoucIOZexJ3Bz729SJA=;
        b=DfFHAajsIWAa2rxXeODtmkGiVfBQL/bmGG6TjDi1mHrzjTZa4rQsHcstc+BZmshTPG
         uPv5P1sBGQwd68Zqypby4h3oGmMY3xiNv0Xs1nd3RMj+f19TBISH7d0Fd6JCrzqEfk0G
         CngK9GYG0DTCu4r/nEiejccxK8d0nyuPjP24K0QMURk+mB6NPX6/J5rU9BPmVrQ/Gmv3
         mZZhKH0gJcmOM8Bjiw9amZ76XlA1uasIG4WSanhWaz053dySffhQAUTzUJezchnoKJHh
         GbOhoA0cTRfXhefafs/CrKSnqIPKkE4o+RUCkQ9PE9XVet8d39YhLLvdMubPEfIPYGaL
         8whA==
X-Gm-Message-State: AJcUukeRiv3hVbQqKmKq7SDGDYGwa5Ms7P73fsTgs4DVo6YWM4YvhDoJ
        vH9V817TQ+H4wQJ4t2MoBs7MnE+nMuITIUDb
X-Google-Smtp-Source: ALg8bN5F/J7nrWiNZnLJjk6nPyIAaJ6ffg7Oz1VxqUaPG+Hn6m6YPOlaQXOUC88GqMcHK3bHNPV3Ng==
X-Received: by 2002:ac2:4215:: with SMTP id y21mr2384242lfh.6.1547550144301;
        Tue, 15 Jan 2019 03:02:24 -0800 (PST)
Received: from localhost.localdomain (6-191-187-93.customer.senator-telecom.com. [93.187.191.6])
        by smtp.googlemail.com with ESMTPSA id m4-v6sm504278ljb.58.2019.01.15.03.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 03:02:23 -0800 (PST)
From:   Artem Panfilov <panfilovartyom@gmail.com>
X-Google-Original-From: Artem Panfilov <panfilov.artyom@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH 1/1] rtc: add AB-RTCMC-32.768kHz-EOZ9-S3 RTC support
Date:   Tue, 15 Jan 2019 14:01:45 +0300
Message-Id: <20190115110146.21180-1-panfilov.artyom@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for AB-RTCMC-32.768kHz-EOZ9-S3
RTC/Calendar module w/ I2C interface.

Signed-off-by: Artem Panfilov <panfilov.artyom@gmail.com>
---
 drivers/rtc/Kconfig          |  10 +
 drivers/rtc/Makefile         |   1 +
 drivers/rtc/rtc-ab-eoz9-s3.c | 412 +++++++++++++++++++++++++++++++++++
 3 files changed, 423 insertions(+)
 create mode 100644 drivers/rtc/rtc-ab-eoz9-s3.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 225b0b8516f3..a5536b206666 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -185,6 +185,16 @@ config RTC_DRV_ABB5ZES3
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-ab-b5ze-s3.
 
+config RTC_DRV_ABEOZ9S3
+	select REGMAP_I2C
+	tristate "Abracon AB-RTCMC-32.768kHz-EOZ9-S3"
+	help
+	  If you say yes here you get support for the Abracon
+	  AB-RTCMC-32.768kHz-EOA9-S3 I2C RTC chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-ab-e0z9-s3.
+
 config RTC_DRV_ABX80X
 	tristate "Abracon ABx80x"
 	select WATCHDOG_CORE if WATCHDOG
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index df022d820bee..b73e2307ace2 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_RTC_DRV_88PM860X)	+= rtc-88pm860x.o
 obj-$(CONFIG_RTC_DRV_AB3100)	+= rtc-ab3100.o
 obj-$(CONFIG_RTC_DRV_AB8500)	+= rtc-ab8500.o
 obj-$(CONFIG_RTC_DRV_ABB5ZES3)	+= rtc-ab-b5ze-s3.o
+obj-$(CONFIG_RTC_DRV_ABEOZ9S3)	+= rtc-ab-eoz9-s3.o
 obj-$(CONFIG_RTC_DRV_ABX80X)	+= rtc-abx80x.o
 obj-$(CONFIG_RTC_DRV_AC100)	+= rtc-ac100.o
 obj-$(CONFIG_RTC_DRV_ARMADA38X)	+= rtc-armada38x.o
diff --git a/drivers/rtc/rtc-ab-eoz9-s3.c b/drivers/rtc/rtc-ab-eoz9-s3.c
new file mode 100644
index 000000000000..07a0fec7c80a
--- /dev/null
+++ b/drivers/rtc/rtc-ab-eoz9-s3.c
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Real Time Clock driver for AB-RTCMC-32.768kHz-EOZ9-S3 chip.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/rtc.h>
+#include <linux/i2c.h>
+#include <linux/bcd.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+
+#define ABEOZ9S3_REG_CTRL1		0x00
+#define ABEOZ9S3_REG_CTRL1_MASK		GENMASK(7, 0)
+#define ABEOZ9S3_REG_CTRL1_WE		BIT(0)
+#define ABEOZ9S3_REG_CTRL1_TE		BIT(1)
+#define ABEOZ9S3_REG_CTRL1_TAR		BIT(2)
+#define ABEOZ9S3_REG_CTRL1_EERE		BIT(3)
+#define ABEOZ9S3_REG_CTRL1_SRON		BIT(4)
+#define ABEOZ9S3_REG_CTRL1_TD0		BIT(5)
+#define ABEOZ9S3_REG_CTRL1_TD1		BIT(6)
+#define ABEOZ9S3_REG_CTRL1_CLKINT	BIT(7)
+
+#define ABEOZ9S3_REG_CTRL2		0x01
+#define ABEOZ9S3_REG_CTRL2_MASK		GENMASK(4, 0)
+#define ABEOZ9S3_REG_CTRL2_AIE		BIT(0)
+#define ABEOZ9S3_REG_CTRL2_TIE		BIT(1)
+#define ABEOZ9S3_REG_CTRL2_V1IE		BIT(2)
+#define ABEOZ9S3_REG_CTRL2_V2IE		BIT(3)
+#define ABEOZ9S3_REG_CTRL2_SRIE		BIT(4)
+
+#define ABEOZ9S3_REG_CTRL3		0x02
+#define ABEOZ9S3_REG_CTRL3_MASK		GENMASK(4, 0)
+#define ABEOZ9S3_REG_CTRL3_AF		BIT(0)
+#define ABEOZ9S3_REG_CTRL3_TF		BIT(1)
+#define ABEOZ9S3_REG_CTRL3_V1IF		BIT(2)
+#define ABEOZ9S3_REG_CTRL3_V2IF		BIT(3)
+#define ABEOZ9S3_REG_CTRL3_SRF		BIT(4)
+
+#define ABEOZ9S3_REG_CTRL4		0x03
+#define ABEOZ9S3_REG_CTRL4_MASK		(BIT(7) | GENMASK(5, 0))
+#define ABEOZ9S3_REG_CTRL4_V1F		BIT(2)
+#define ABEOZ9S3_REG_CTRL4_V2F		BIT(3)
+#define ABEOZ9S3_REG_CTRL4_SR		BIT(4)
+#define ABEOZ9S3_REG_CTRL4_PON		BIT(5)
+#define ABEOZ9S3_REG_CTRL4_EEBUSY	BIT(7)
+
+#define ABEOZ9S3_REG_SECONDS		0x08
+#define ABEOZ9S3_REG_MINUTES		0x09
+#define ABEOZ9S3_REG_HOURS		0x0A
+#define ABEOZ9S3_HOURS_PM		BIT(6)
+#define ABEOZ9S3_REG_DAYS		0x0B
+#define ABEOZ9S3_REG_WEEKDAYS		0x0C
+#define ABEOZ9S3_REG_MONTHS		0x0D
+#define ABEOZ9S3_REG_YEARS		0x0E
+
+#define ABEOZ9S3_SECONDS_LEN		7
+
+#define ABEOZ9S3_REG_REG_TEMP		0x20
+#define ABEOZ953_TEMP_MAX		120
+#define ABEOZ953_TEMP_MIN		-60
+
+#define ABEOZ9S3_REG_EEPROM		0x30
+#define ABEOZ9S3_REG_EEPROM_MASK	GENMASK(8, 0)
+#define ABEOZ9S3_REG_EEPROM_THP		BIT(0)
+#define ABEOZ9S3_REG_EEPROM_THE		BIT(1)
+#define ABEOZ9S3_REG_EEPROM_FD0		BIT(2)
+#define ABEOZ9S3_REG_EEPROM_FD1		BIT(3)
+#define ABEOZ9S3_REG_EEPROM_R1K		BIT(4)
+#define ABEOZ9S3_REG_EEPROM_R5K		BIT(5)
+#define ABEOZ9S3_REG_EEPROM_R20K	BIT(6)
+#define ABEOZ9S3_REG_EEPROM_R80K	BIT(7)
+
+struct abeoz9s3_rtc_data {
+	struct rtc_device *rtc;
+	struct regmap *regmap;
+	struct mutex lock;
+	struct device *hwmon_dev;
+};
+
+static int abeoz9s3_rtc_get_time(struct device *dev, struct rtc_time *tm)
+{
+	struct abeoz9s3_rtc_data *data = dev_get_drvdata(dev);
+	u8 regs[ABEOZ9S3_REG_SECONDS + ABEOZ9S3_SECONDS_LEN];
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, ABEOZ9S3_REG_SECONDS,
+			       regs, sizeof(regs));
+
+	if (ret) {
+		dev_err(dev, "reading RTC time failed (%d)\n", ret);
+		goto err;
+	}
+
+	tm->tm_sec  = bcd2bin(regs[ABEOZ9S3_REG_SECONDS] & 0x7F);
+	tm->tm_min  = bcd2bin(regs[ABEOZ9S3_REG_MINUTES] & 0x7F);
+
+	if (regs[ABEOZ9S3_REG_CTRL1] & ABEOZ9S3_HOURS_PM) {
+		tm->tm_hour = bcd2bin(regs[ABEOZ9S3_REG_HOURS] & 0x1f);
+		if (regs[ABEOZ9S3_REG_HOURS] & ABEOZ9S3_HOURS_PM)
+			tm->tm_hour += 12;
+	} else {
+		tm->tm_hour = bcd2bin(regs[ABEOZ9S3_REG_HOURS]);
+	}
+
+	tm->tm_mday = bcd2bin(regs[ABEOZ9S3_REG_DAYS]);
+	tm->tm_wday = bcd2bin(regs[ABEOZ9S3_REG_WEEKDAYS]);
+	tm->tm_mon  = bcd2bin(regs[ABEOZ9S3_REG_MONTHS]) - 1;
+	tm->tm_year = bcd2bin(regs[ABEOZ9S3_REG_YEARS]) + 100;
+err:
+	return ret;
+}
+
+static int abeoz9s3_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct abeoz9s3_rtc_data *data = dev_get_drvdata(dev);
+	u8 regs[ABEOZ9S3_REG_SECONDS + ABEOZ9S3_SECONDS_LEN];
+	int ret;
+
+	regs[ABEOZ9S3_REG_SECONDS]  = bin2bcd(tm->tm_sec);
+	regs[ABEOZ9S3_REG_MINUTES]  = bin2bcd(tm->tm_min);
+	regs[ABEOZ9S3_REG_HOURS]    = bin2bcd(tm->tm_hour);
+	regs[ABEOZ9S3_REG_DAYS]     = bin2bcd(tm->tm_mday);
+	regs[ABEOZ9S3_REG_WEEKDAYS] = bin2bcd(tm->tm_wday);
+	regs[ABEOZ9S3_REG_MONTHS]   = bin2bcd(tm->tm_mon + 1);
+	regs[ABEOZ9S3_REG_YEARS]    = bin2bcd(tm->tm_year - 100);
+
+	mutex_lock(&data->lock);
+	ret = regmap_bulk_write(data->regmap, ABEOZ9S3_REG_SECONDS,
+				regs + ABEOZ9S3_REG_SECONDS,
+				ABEOZ9S3_SECONDS_LEN);
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int abeoz9s3_trickle_parse_dt(struct device_node *node)
+{
+	u32 ohms = 0;
+
+	if (of_property_read_u32(node, "trickle-resistor-ohms", &ohms))
+		return 0;
+
+	switch (ohms) {
+	case 1000:
+		return ABEOZ9S3_REG_EEPROM_R1K;
+	case 5000:
+		return ABEOZ9S3_REG_EEPROM_R5K;
+	case 20000:
+		return ABEOZ9S3_REG_EEPROM_R20K;
+	case 80000:
+		return ABEOZ9S3_REG_EEPROM_R80K;
+	default:
+		return 0;
+	}
+}
+
+static int abeoz9s3_rtc_setup(struct device *dev, struct device_node *node)
+{
+	struct abeoz9s3_rtc_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+
+	int ret;
+
+	/* Enable Self Recovery, Clock for Watch and EEPROM refresh functions*/
+	ret = regmap_update_bits(regmap, ABEOZ9S3_REG_CTRL1,
+				 ABEOZ9S3_REG_CTRL1_MASK,
+				 ABEOZ9S3_REG_CTRL1_WE |
+				 ABEOZ9S3_REG_CTRL1_EERE |
+				 ABEOZ9S3_REG_CTRL1_SRON);
+	if (ret < 0) {
+		dev_err(dev, "unable to set control 1 register (%d)\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(regmap, ABEOZ9S3_REG_CTRL2,
+				 ABEOZ9S3_REG_CTRL2_MASK, 0);
+	if (ret < 0) {
+		dev_err(dev, "unable to set control 2 register (%d)\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(regmap, ABEOZ9S3_REG_CTRL3,
+				 ABEOZ9S3_REG_CTRL3_MASK, 0);
+	if (ret < 0) {
+		dev_err(dev, "unable to set control 3 register (%d)\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(regmap, ABEOZ9S3_REG_CTRL4,
+				 ABEOZ9S3_REG_CTRL4_MASK, 0);
+	if (ret < 0) {
+		dev_err(dev, "unable to set control 4 register (%d)\n", ret);
+		return ret;
+	}
+
+	ret = abeoz9s3_trickle_parse_dt(node);
+
+	/* Enable built-in termometer */
+	ret |= ABEOZ9S3_REG_EEPROM_THE;
+
+	ret = regmap_update_bits(regmap, ABEOZ9S3_REG_EEPROM,
+				 ABEOZ9S3_REG_EEPROM_MASK,
+				 ret);
+	if (ret < 0) {
+		dev_err(dev, "unable to set eeprom register (%d)\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static const struct rtc_class_ops rtc_ops = {
+	.read_time = abeoz9s3_rtc_get_time,
+	.set_time  = abeoz9s3_rtc_set_time,
+};
+
+static const struct regmap_config abeoz9s3_rtc_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+#if IS_REACHABLE(CONFIG_HWMON)
+
+static int abeoz9z3_temp_read(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *temp)
+{
+	struct abeoz9s3_rtc_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	int ret;
+	unsigned int regval = 37;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		ret = regmap_read(regmap, ABEOZ9S3_REG_REG_TEMP, &regval);
+		if (ret < 0)
+			return ret;
+		*temp = 1000 * (regval + ABEOZ953_TEMP_MIN);
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
+static umode_t abeoz9s3_is_visible(const void *data,
+				   enum hwmon_sensor_types type,
+				   u32 attr, int channel)
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
+static const u32 abeoz9s3_chip_config[] = {
+	HWMON_C_REGISTER_TZ,
+	0
+};
+
+static const struct hwmon_channel_info abeoz9s3_chip = {
+	.type = hwmon_chip,
+	.config = abeoz9s3_chip_config,
+};
+
+static const u32 abeoz9s3_temp_config[] = {
+	HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN,
+	0
+};
+
+static const struct hwmon_channel_info abeoz9s3_temp = {
+	.type = hwmon_temp,
+	.config = abeoz9s3_temp_config,
+};
+
+static const struct hwmon_channel_info *abeoz9s3_info[] = {
+	&abeoz9s3_chip,
+	&abeoz9s3_temp,
+	NULL
+};
+
+static const struct hwmon_ops abeoz9s3_hwmon_ops = {
+	.is_visible = abeoz9s3_is_visible,
+	.read = abeoz9z3_temp_read,
+};
+
+static const struct hwmon_chip_info abeoz9s3_chip_info = {
+	.ops = &abeoz9s3_hwmon_ops,
+	.info = abeoz9s3_info,
+};
+
+static void abeoz9s3_hwmon_register(struct device *dev,
+				    struct abeoz9s3_rtc_data *data)
+{
+	data->hwmon_dev =
+		devm_hwmon_device_register_with_info(dev,
+						     "abeoz9s3",
+						     data,
+						     &abeoz9s3_chip_info,
+						     NULL);
+	if (IS_ERR(data->hwmon_dev)) {
+		dev_warn(dev, "unable to register hwmon device %ld\n",
+			 PTR_ERR(data->hwmon_dev));
+	}
+}
+
+#else
+
+static void abeoz9s3_hwmon_register(struct device *dev,
+				    struct abeoz9s3_rtc_data *data)
+{
+}
+
+#endif /* CONFIG_RTC_DRV_ABEOZ9S3_HWMON */
+
+static int abeoz9s3_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct abeoz9s3_rtc_data *data = NULL;
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
+	regmap = devm_regmap_init_i2c(client, &abeoz9s3_rtc_regmap_config);
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
+	mutex_init(&data->lock);
+	data->regmap = regmap;
+	dev_set_drvdata(dev, data);
+
+	ret = abeoz9s3_rtc_setup(dev, client->dev.of_node);
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
+	abeoz9s3_hwmon_register(dev, data);
+	return 0;
+err:
+	dev_err(dev, "unable to register RTC device (%d)\n", ret);
+	return ret;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id abeoz9s3_dt_match[] = {
+	{ .compatible = "abracon,abeoz9s3" },
+	{ },
+};
+#endif
+
+MODULE_DEVICE_TABLE(of, abeoz9s3_dt_match);
+
+static const struct i2c_device_id abeoz9s3_id[] = {
+	{ "abeoz9s3", 0 },
+	{ }
+};
+
+static struct i2c_driver abeoz9s3_driver = {
+	.driver = {
+		.name = "rtc-ab-eoz9-s3",
+		.of_match_table = of_match_ptr(abeoz9s3_dt_match),
+	},
+	.probe	  = abeoz9s3_probe,
+	.id_table = abeoz9s3_id,
+};
+
+module_i2c_driver(abeoz9s3_driver);
+
+MODULE_AUTHOR("Artem Panfilov panfilov.artyom@gmail.com");
+MODULE_DESCRIPTION("Abracon AB-RTCMC-32.768kHz-EOZ9-S3 RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

