Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HhQxHpx1GVtDDgAAmS7hNA
	; Thu, 07 Jun 2018 18:13:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AD7EC6089E; Thu,  7 Jun 2018 18:13:44 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+H5ibKh"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 75E29601C3;
	Thu,  7 Jun 2018 18:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75E29601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936166AbeFGSNl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:13:41 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43864 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933757AbeFGSNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:13:36 -0400
Received: by mail-lf0-f66.google.com with SMTP id n15-v6so16077558lfn.10;
        Thu, 07 Jun 2018 11:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9LvJr3VudZSdhsRqfIFjL74eCmRge6IXDTlDhpTrHKA=;
        b=Y+H5ibKhnI64uo6qiDTXRIijo2VPg/LB/YYtxHHDmar/QhMJSBUt5TmYzTIYyRPYJm
         eFn76/l6NLuFjh7yyYGSLFTXbIEpgRRDygSZoANs5NLLPwiNza5Ssqf2sx8/GSvAYKAm
         uMww24asRdviBDWrtqTI19xDH+D6TEAkBENNPR5ETry6bD4zFjb3wYaobtM4hDSiYROa
         W1Eg2NTrzsOrzIn/d60Yil529sys3rYAQCkekvTuj9CfzCytyE6wSKPScc/wjQzi9Hqn
         X2SDbDtSatQyupfnbv9xx68Xv1E6P7mPz9xFDXXTpzFf3RDE02gvbs4f0dquwEnvXl3U
         QUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9LvJr3VudZSdhsRqfIFjL74eCmRge6IXDTlDhpTrHKA=;
        b=P9McvYYrTwDnBggLghZafG+VpVOI5zE9V/XiAL+7fztEdh7eywHuvQBmml5htuncgD
         Gdd5bYaVn1Rp/My0XLr3kDgQHJGUziOnyfd08NBmXK2LbDrr1hzryIjiytoiGGEtfc2+
         2tF5E6kkRK+q2WHYWYgQ8kd6jTTQ+jIXgQM5wKw9RtYe1ryswGVBfD5kJAVMfd85haEJ
         LmOeAKhDegtM6ONDWUuD8znzZM8wNO2D3d8gcYFcGZfW7Wmo8M/Qvlaqd/SgBvegGwQj
         M+ABiwc/v4RxtgQ8N8EC5bJWkq2OU8e/Z8njLId0e97A+uo61NA287KUGRbXAv1TRyX/
         Lv2g==
X-Gm-Message-State: APt69E36sKvzt+iwznaPjh8QA+eC0Tz+I77Z3TH7lKZeTvfd4Sd1V9mQ
        Wqo3sStutfRztPtSkO3rMA==
X-Google-Smtp-Source: ADUXVKIsReDsKvTXUoRQErO5KhqBWOhpfgJVI3/Hy8hnQDYUZlyORXS20MX8/lRjvLGtLw6WOH1jRQ==
X-Received: by 2002:a2e:82ce:: with SMTP id n14-v6mr2218100ljh.34.1528395214492;
        Thu, 07 Jun 2018 11:13:34 -0700 (PDT)
Received: from localhost.localdomain (host81-131-105-100.range81-131.btcentralplus.com. [81.131.105.100])
        by smtp.googlemail.com with ESMTPSA id w4-v6sm3329722ljh.88.2018.06.07.11.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:13:33 -0700 (PDT)
From: Craig Tatlor <ctatlor97@gmail.com>
Cc: ctatlor97@gmail.com, linux-arm-msm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] power: supply: Add support for the Qualcomm Battery Monitoring System
Date: Thu,  7 Jun 2018 19:12:50 +0100
Message-Id: <20180607181306.9766-2-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180607181306.9766-1-ctatlor97@gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180607181306.9766-1-ctatlor97@gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a driver for the BMS (Battery Monitoring System)
block of the PM8941 PMIC, it uses a lookup table defined in the
device tree to generate a capacity from the BMS supplied OCV, it
then ammends the coulomb counter to that to increase the accuracy
of the estimated capacity.

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---
* Changes from v4:
  Cleaned up percentage interpolation function,
  uses new fixp interpolation helper,
  added some more error cases,
  uses devm_power_supply_register(),
  uses a DIV_ROUND_CLOSEST for division and
  uses micro(volts / amp hours) instead of
  milli (volts / amp hours).

 drivers/power/supply/Kconfig    |   9 +
 drivers/power/supply/Makefile   |   1 +
 drivers/power/supply/qcom_bms.c | 487 ++++++++++++++++++++++++++++++++
 3 files changed, 497 insertions(+)
 create mode 100644 drivers/power/supply/qcom_bms.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 428b426842f4..6c354c37bc55 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -82,6 +82,15 @@ config BATTERY_ACT8945A
 	  Say Y here to enable support for power supply provided by
 	  Active-semi ActivePath ACT8945A charger.
 
+config BATTERY_BMS
+	tristate "Qualcomm Battery Monitoring System driver"
+	depends on MFD_SPMI_PMIC || COMPILE_TEST
+	depends on OF
+	depends on REGMAP_SPMI
+	help
+	  Say Y to include support for the Battery Monitoring hardware
+	  found in some Qualcomm PM series PMICs.
+
 config BATTERY_CPCAP
 	tristate "Motorola CPCAP PMIC battery driver"
 	depends on MFD_CPCAP && IIO
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index e83aa843bcc6..04204174b047 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_BATTERY_88PM860X)	+= 88pm860x_battery.o
 obj-$(CONFIG_BATTERY_ACT8945A)	+= act8945a_charger.o
 obj-$(CONFIG_BATTERY_AXP20X)	+= axp20x_battery.o
 obj-$(CONFIG_CHARGER_AXP20X)	+= axp20x_ac_power.o
+obj-$(CONFIG_BATTERY_BMS)	+= qcom_bms.o
 obj-$(CONFIG_BATTERY_CPCAP)	+= cpcap-battery.o
 obj-$(CONFIG_BATTERY_DS2760)	+= ds2760_battery.o
 obj-$(CONFIG_BATTERY_DS2780)	+= ds2780_battery.o
diff --git a/drivers/power/supply/qcom_bms.c b/drivers/power/supply/qcom_bms.c
new file mode 100644
index 000000000000..e1d6fdbf11d1
--- /dev/null
+++ b/drivers/power/supply/qcom_bms.c
@@ -0,0 +1,487 @@
+// SPDX-License-Identifier: GPL
+
+/*
+ * Qualcomm Battery Monitoring System driver
+ *
+ * Copyright (C) 2018 Craig Tatlor <ctatlor97@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/fixp-arith.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/iio/consumer.h>
+
+#define REG_BMS_OCV_FOR_SOC_DATA0	0x90
+#define REG_BMS_SHDW_CC_DATA0		0xA8
+#define REG_BMS_CC_DATA_CTL		0x42
+#define REG_BMS_CC_CLEAR_CTL		0x4
+
+#define BMS_HOLD_OREG_DATA		BIT(0)
+#define BMS_CLEAR_SHDW_CC		BIT(6)
+
+#define BMS_CC_READING_RESOLUTION_N	542535
+#define BMS_CC_READING_RESOLUTION_D	10000
+#define BMS_CC_READING_TICKS		56
+#define BMS_SLEEP_CLK_HZ		32764
+
+#define SECONDS_PER_HOUR		3600
+#define TEMPERATURE_COLS		5
+#define MAX_CAPACITY_ROWS		50
+
+/* lookup table for ocv -> capacity conversion */
+struct bms_ocv_lut {
+	int rows;
+	s8 temp_legend[TEMPERATURE_COLS];
+	u8 capacity_legend[MAX_CAPACITY_ROWS];
+	u32 lut[MAX_CAPACITY_ROWS][TEMPERATURE_COLS];
+};
+
+/* lookup table for battery temperature -> fcc conversion */
+struct bms_fcc_lut {
+	s8 temp_legend[TEMPERATURE_COLS];
+	u32 lut[TEMPERATURE_COLS];
+};
+
+struct bms_device_info {
+	struct device *dev;
+	struct regmap *regmap;
+	struct bms_ocv_lut ocv_lut;
+	struct power_supply_desc bat_desc;
+	struct bms_fcc_lut fcc_lut;
+	struct iio_channel *adc;
+	struct mutex bms_output_lock;
+	u32 base_addr;
+
+	int ocv_thr_irq;
+	u32 ocv;
+};
+
+static bool between(int left, int right, int val)
+{
+	if (left <= val && val <= right)
+		return true;
+
+	if (left >= val && val >= right)
+		return true;
+
+	return false;
+}
+
+static int interpolate_capacity(int temp, u32 ocv,
+				struct bms_ocv_lut *ocv_lut)
+{
+	int pcj_minus_one = 0, pcj = 0, i2 = 0, i3 = 0, i, j;
+
+	for (j = 0; j < TEMPERATURE_COLS; j++)
+		if (temp <= ocv_lut->temp_legend[j])
+			break;
+
+	if (ocv >= ocv_lut->lut[0][j])
+		return ocv_lut->capacity_legend[0];
+
+	if (ocv <= ocv_lut->lut[ocv_lut->rows-1][j-1])
+		return ocv_lut->capacity_legend[ocv_lut->rows-1];
+
+	for (i = 0; i < ocv_lut->rows-1; i++) {
+		if (between(ocv_lut->lut[i][j],
+			    ocv_lut->lut[i+1][j], ocv))
+			i2 = i;
+
+		if (between(ocv_lut->lut[i][j-1],
+			    ocv_lut->lut[i+1][j-1], ocv))
+			i3 = i;
+	}
+
+	/* interpolate two capacities */
+	pcj = fixp_linear_interpolate(ocv_lut->lut[i2][j],
+				      ocv_lut->capacity_legend[i2],
+				      ocv_lut->lut[i2+1][j],
+				      ocv_lut->capacity_legend[i2+1],
+				      ocv);
+
+	pcj_minus_one = fixp_linear_interpolate(ocv_lut->lut[i3][j-1],
+						ocv_lut->capacity_legend[i3],
+						ocv_lut->lut[i3+1][j-1],
+						ocv_lut->capacity_legend[i3+1],
+						ocv);
+
+	/* interpolate them with the battery temperature */
+	return fixp_linear_interpolate(ocv_lut->temp_legend[j-1],
+				       pcj_minus_one,
+				       ocv_lut->temp_legend[j],
+				       pcj,
+				       temp);
+}
+
+static int interpolate_fcc(int temp, struct bms_fcc_lut *fcc_lut)
+{
+	int i;
+
+	for (i = 0; i < TEMPERATURE_COLS; i++)
+		if (temp <= fcc_lut->temp_legend[i])
+			break;
+
+	return fixp_linear_interpolate(fcc_lut->temp_legend[i-1],
+			     fcc_lut->lut[i-1],
+			     fcc_lut->temp_legend[i],
+			     fcc_lut->lut[i],
+			     temp);
+}
+
+static int bms_lock_output_data(struct bms_device_info *di)
+{
+	int ret;
+
+	ret = regmap_update_bits(di->regmap, di->base_addr +
+				 REG_BMS_CC_DATA_CTL,
+				 BMS_HOLD_OREG_DATA, BMS_HOLD_OREG_DATA);
+	if (ret) {
+		dev_err(di->dev, "failed to lock bms output: %d", ret);
+		return ret;
+	}
+
+	/*
+	 * Sleep for at least 100 microseconds here to make sure
+	 * there has been at least three cycles of the sleep clock
+	 * so that the registers are correctly locked.
+	 */
+	usleep_range(100, 1000);
+
+	return 0;
+}
+
+static int bms_unlock_output_data(struct bms_device_info *di)
+{
+	int ret;
+
+	ret = regmap_update_bits(di->regmap, di->base_addr +
+				 REG_BMS_CC_DATA_CTL,
+				 BMS_HOLD_OREG_DATA, 0);
+	if (ret) {
+		dev_err(di->dev, "failed to unlock bms output: %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int bms_read_ocv(struct bms_device_info *di, u32 *ocv)
+{
+	int ret;
+	u16 read_ocv;
+
+	mutex_lock(&di->bms_output_lock);
+
+	ret = bms_lock_output_data(di);
+	if (ret)
+		goto err_lock;
+
+	ret = regmap_bulk_read(di->regmap, di->base_addr+
+			       REG_BMS_OCV_FOR_SOC_DATA0, &read_ocv, 2);
+	if (ret) {
+		dev_err(di->dev, "open circuit voltage read failed: %d", ret);
+		goto err_read;
+	}
+
+	dev_dbg(di->dev, "read open circuit voltage of: %d mv", read_ocv);
+
+
+	*ocv = read_ocv * 1000;
+
+err_read:
+	bms_unlock_output_data(di);
+
+err_lock:
+	mutex_unlock(&di->bms_output_lock);
+
+	return ret;
+}
+
+static int bms_read_cc(struct bms_device_info *di, s64 *cc_uah)
+{
+	int ret;
+	s64 cc_raw_s36, cc_raw, cc_uv, cc_pvh;
+
+	mutex_lock(&di->bms_output_lock);
+
+	ret = bms_lock_output_data(di);
+	if (ret)
+		goto err_lock;
+
+	ret = regmap_bulk_read(di->regmap, di->base_addr +
+			       REG_BMS_SHDW_CC_DATA0,
+			       &cc_raw_s36, 5);
+	if (ret) {
+		dev_err(di->dev, "coulomb counter read failed: %d", ret);
+		goto err_read;
+	}
+
+	ret = bms_unlock_output_data(di);
+	if (ret)
+		goto err_lock;
+
+	mutex_unlock(&di->bms_output_lock);
+
+	cc_raw = sign_extend32(cc_raw_s36, 28);
+
+	/* convert raw to uv */
+	cc_uv = div_s64(cc_raw * BMS_CC_READING_RESOLUTION_N,
+			BMS_CC_READING_RESOLUTION_D);
+
+	/* convert uv to pvh */
+	cc_pvh = div_s64(cc_uv * BMS_CC_READING_TICKS * 100000,
+			 BMS_SLEEP_CLK_HZ * SECONDS_PER_HOUR);
+
+	/* divide by impedance */
+	*cc_uah = div_s64(cc_pvh, 10000);
+
+	dev_dbg(di->dev, "read coulomb counter value of: %lld uah", *cc_uah);
+
+	return 0;
+
+err_read:
+	bms_unlock_output_data(di);
+
+err_lock:
+	mutex_unlock(&di->bms_output_lock);
+
+	return ret;
+}
+
+static void bms_reset_cc(struct bms_device_info *di)
+{
+	int ret;
+
+	mutex_lock(&di->bms_output_lock);
+
+	ret = regmap_update_bits(di->regmap, di->base_addr +
+				 REG_BMS_CC_CLEAR_CTL,
+				 BMS_CLEAR_SHDW_CC,
+				 BMS_CLEAR_SHDW_CC);
+	if (ret) {
+		dev_err(di->dev, "coulomb counter reset failed: %d", ret);
+		goto err_lock;
+	}
+
+	/* wait at least three sleep cycles for cc to reset */
+	usleep_range(100, 1000);
+
+	ret = regmap_update_bits(di->regmap, di->base_addr +
+				 REG_BMS_CC_CLEAR_CTL,
+				 BMS_CLEAR_SHDW_CC, 0);
+	if (ret)
+		dev_err(di->dev, "coulomb counter re-enable failed: %d", ret);
+
+err_lock:
+	mutex_unlock(&di->bms_output_lock);
+}
+
+static int bms_calculate_capacity(struct bms_device_info *di, int *capacity)
+{
+	unsigned long fcc;
+	int ret, temp, ocv_capacity, temp_degc;
+	s64 cc = 0;
+
+	ret = iio_read_channel_raw(di->adc, &temp);
+	if (ret < 0) {
+		dev_err(di->dev, "failed to read temperature: %d", ret);
+		return ret;
+	}
+
+	temp_degc = DIV_ROUND_CLOSEST(temp, 1000);
+
+	ret = bms_read_cc(di, &cc);
+	if (ret < 0) {
+		dev_err(di->dev, "failed to read coulomb counter: %d", ret);
+		return ret;
+	}
+
+	/* interpolate capacity from open circuit voltage */
+	ocv_capacity = interpolate_capacity(temp_degc, di->ocv,
+					    &di->ocv_lut);
+
+	/* interpolate the full charge capacity from temperature */
+	fcc = interpolate_fcc(temp_degc, &di->fcc_lut);
+
+	/* append coloumb counter to capacity */
+	*capacity = DIV_ROUND_CLOSEST(fcc * ocv_capacity, 100);
+	*capacity = div_s64((*capacity - cc) * 100, fcc);
+
+	return 0;
+}
+
+
+
+/*
+ * Return power_supply property
+ */
+static int bms_get_property(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   union power_supply_propval *val)
+{
+	struct bms_device_info *di = power_supply_get_drvdata(psy);
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CAPACITY:
+		ret = bms_calculate_capacity(di, &val->intval);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (val->intval == INT_MAX || val->intval == INT_MIN)
+		ret = -EINVAL;
+
+	return ret;
+}
+
+static enum power_supply_property bms_props[] = {
+	POWER_SUPPLY_PROP_CAPACITY,
+};
+
+static irqreturn_t bms_ocv_thr_irq_handler(int irq, void *dev_id)
+{
+	struct bms_device_info *di = dev_id;
+
+	if (bms_read_ocv(di, &di->ocv) < 0)
+		return IRQ_HANDLED;
+
+	bms_reset_cc(di);
+	return IRQ_HANDLED;
+}
+
+static int bms_probe(struct platform_device *pdev)
+{
+	struct power_supply_config psy_cfg = {};
+	struct bms_device_info *di;
+	struct power_supply *bat;
+	int ret;
+
+	di = devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
+	if (!di)
+		return -ENOMEM;
+
+	di->dev = &pdev->dev;
+
+	di->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!di->regmap) {
+		dev_err(di->dev, "Unable to get regmap");
+		return -EINVAL;
+	}
+
+	di->adc = devm_iio_channel_get(&pdev->dev, "temp");
+	if (IS_ERR(di->adc))
+		return PTR_ERR(di->adc);
+
+	ret = of_property_read_u32(di->dev->of_node, "reg", &di->base_addr);
+	if (ret < 0)
+		return ret;
+
+	ret = of_property_read_u8_array(di->dev->of_node,
+						 "qcom,ocv-temp-legend-celsius",
+						 (u8 *)di->ocv_lut.temp_legend,
+						 TEMPERATURE_COLS);
+	if (ret < 0) {
+		dev_err(di->dev, "no open circuit voltage temperature legend found");
+		return ret;
+	}
+
+	di->ocv_lut.rows = of_property_read_variable_u8_array(di->dev->of_node,
+						 "qcom,ocv-capacity-legend",
+						 di->ocv_lut.capacity_legend, 0,
+						 MAX_CAPACITY_ROWS);
+	if (di->ocv_lut.rows < 0) {
+		dev_err(di->dev, "no open circuit voltage capacity legend found");
+		return ret;
+	}
+
+	ret = of_property_read_variable_u32_array(di->dev->of_node,
+						  "qcom,ocv-lut-microvolt",
+						  (u32 *)di->ocv_lut.lut,
+						  TEMPERATURE_COLS,
+						  TEMPERATURE_COLS *
+						  MAX_CAPACITY_ROWS);
+	if (ret < 0) {
+		dev_err(di->dev, "no open circuit voltage lut array found");
+		return ret;
+	}
+
+	ret = of_property_read_u8_array(di->dev->of_node,
+						 "qcom,fcc-temp-legend-celsius",
+						 (u8 *)di->fcc_lut.temp_legend,
+						 TEMPERATURE_COLS);
+	if (ret < 0) {
+		dev_err(di->dev, "no full charge capacity temperature legend found");
+		return ret;
+	}
+
+	ret = of_property_read_u32_array(di->dev->of_node,
+						  "qcom,fcc-lut-microamp-hours",
+						  di->fcc_lut.lut,
+						  TEMPERATURE_COLS);
+	if (ret < 0) {
+		dev_err(di->dev, "no full charge capacity lut array found");
+		return ret;
+	}
+
+	ret = bms_read_ocv(di, &di->ocv);
+	if (ret < 0) {
+		dev_err(di->dev, "failed to read initial open circuit voltage: %d",
+			ret);
+		return ret;
+	}
+
+	mutex_init(&di->bms_output_lock);
+
+	di->ocv_thr_irq = platform_get_irq_byname(pdev, "ocv_thr");
+
+	ret = devm_request_threaded_irq(di->dev, di->ocv_thr_irq, NULL,
+					bms_ocv_thr_irq_handler,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					pdev->name, di);
+	if (ret < 0) {
+		dev_err(di->dev, "failed to request handler for open circuit voltage threshold IRQ");
+		return ret;
+	}
+
+
+	di->bat_desc.name = "bms";
+	di->bat_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	di->bat_desc.properties = bms_props;
+	di->bat_desc.num_properties = ARRAY_SIZE(bms_props);
+	di->bat_desc.get_property = bms_get_property;
+
+	psy_cfg.drv_data = di;
+	bat = devm_power_supply_register(di->dev, &di->bat_desc, &psy_cfg);
+
+	return PTR_ERR_OR_ZERO(bat);
+}
+
+static const struct of_device_id bms_of_match[] = {
+	{.compatible = "qcom,pm8941-bms", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bms_of_match);
+
+static struct platform_driver bms_driver = {
+	.probe = bms_probe,
+	.driver = {
+		.name = "qcom-bms",
+		.of_match_table = of_match_ptr(bms_of_match),
+	},
+};
+module_platform_driver(bms_driver);
+
+MODULE_AUTHOR("Craig Tatlor <ctatlor97@gmail.com>");
+MODULE_DESCRIPTION("Qualcomm BMS driver");
+MODULE_LICENSE("GPL");
-- 
2.17.0
