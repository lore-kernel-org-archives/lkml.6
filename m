Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1951C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB0D208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB0D208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeJRRCp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:02:45 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55257 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727363AbeJRRCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:02:43 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9I8xIog027472;
        Thu, 18 Oct 2018 11:02:13 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2n37kfy3pk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 18 Oct 2018 11:02:13 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8EC4538;
        Thu, 18 Oct 2018 09:02:12 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 393F1276E;
        Thu, 18 Oct 2018 09:02:12 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 18 Oct
 2018 11:02:11 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Thu, 18 Oct 2018 11:02:11 +0200
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>
CC:     Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH v4 2/8] mfd: stpmic1: add stpmic1 driver
Thread-Topic: [PATCH v4 2/8] mfd: stpmic1: add stpmic1 driver
Thread-Index: AQHUZsFBM15M3Me6q0+cPmuf3C2tLA==
Date:   Thu, 18 Oct 2018 09:02:11 +0000
Message-ID: <1539853324-29051-3-git-send-email-p.paillet@st.com>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1539853324-29051-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-17_15:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: pascal paillet <p.paillet@st.com>

stpmic1 is a pmic from STMicroelectronics. The STPMIC1 integrates 10
regulators , 3 switches, a watchdog and an input for a power on key.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
changes in v4:
* rename PONKEY_PU_ACTIVE to PONKEY_PU_INACTIVE

 drivers/mfd/Kconfig         |  13 ++
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/stpmic1.c       | 401 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/stpmic1.h | 212 +++++++++++++++++++++++
 4 files changed, 627 insertions(+)
 create mode 100644 drivers/mfd/stpmic1.c
 create mode 100644 include/linux/mfd/stpmic1.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 11841f4..b8dabc7 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1855,6 +1855,19 @@ config MFD_STM32_TIMERS
 	  for PWM and IIO Timer. This driver allow to share the
 	  registers between the others drivers.
 
+config MFD_STPMIC1
+	tristate "Support for STPMIC1 PMIC"
+	depends on (I2C=y && OF)
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	select MFD_CORE
+	help
+	  Support for ST Microelectronics STPMIC1 PMIC. STPMIC1 MFD driver is
+	  the core driver for STPMIC1 component that mainly handles interrupts.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called stpmic1.
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 5856a94..76fff14 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -232,6 +232,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
 obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
 
 obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
+obj-$(CONFIG_MFD_STPMIC1)	+= stpmic1.o
 obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
 
 obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
new file mode 100644
index 0000000..90dfee4
--- /dev/null
+++ b/drivers/mfd/stpmic1.c
@@ -0,0 +1,401 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) STMicroelectronics 2018
+// Author: Pascal Paillet <p.paillet@st.com>
+
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/stpmic1.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/mfd/st,stpmic1.h>
+
+#define STPMIC1_MAIN_IRQ 0
+#define STPMIC1_WAKEUP_IRQ 1
+
+static bool stpmic1_reg_readable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TURN_ON_SR:
+	case TURN_OFF_SR:
+	case ICC_LDO_TURN_OFF_SR:
+	case ICC_BUCK_TURN_OFF_SR:
+	case RREQ_STATE_SR:
+	case VERSION_SR:
+	case SWOFF_PWRCTRL_CR:
+	case PADS_PULL_CR:
+	case BUCKS_PD_CR:
+	case LDO14_PD_CR:
+	case LDO56_VREF_PD_CR:
+	case VBUS_DET_VIN_CR:
+	case PKEY_TURNOFF_CR:
+	case BUCKS_MASK_RANK_CR:
+	case BUCKS_MASK_RESET_CR:
+	case LDOS_MASK_RANK_CR:
+	case LDOS_MASK_RESET_CR:
+	case WCHDG_CR:
+	case WCHDG_TIMER_CR:
+	case BUCKS_ICCTO_CR:
+	case LDOS_ICCTO_CR:
+	case BUCK1_ACTIVE_CR:
+	case BUCK2_ACTIVE_CR:
+	case BUCK3_ACTIVE_CR:
+	case BUCK4_ACTIVE_CR:
+	case VREF_DDR_ACTIVE_CR:
+	case LDO1_ACTIVE_CR:
+	case LDO2_ACTIVE_CR:
+	case LDO3_ACTIVE_CR:
+	case LDO4_ACTIVE_CR:
+	case LDO5_ACTIVE_CR:
+	case LDO6_ACTIVE_CR:
+	case BUCK1_STDBY_CR:
+	case BUCK2_STDBY_CR:
+	case BUCK3_STDBY_CR:
+	case BUCK4_STDBY_CR:
+	case VREF_DDR_STDBY_CR:
+	case LDO1_STDBY_CR:
+	case LDO2_STDBY_CR:
+	case LDO3_STDBY_CR:
+	case LDO4_STDBY_CR:
+	case LDO5_STDBY_CR:
+	case LDO6_STDBY_CR:
+	case BST_SW_CR:
+	case INT_PENDING_R1:
+	case INT_PENDING_R2:
+	case INT_PENDING_R3:
+	case INT_PENDING_R4:
+	case INT_DBG_LATCH_R1:
+	case INT_DBG_LATCH_R2:
+	case INT_DBG_LATCH_R3:
+	case INT_DBG_LATCH_R4:
+	case INT_CLEAR_R1:
+	case INT_CLEAR_R2:
+	case INT_CLEAR_R3:
+	case INT_CLEAR_R4:
+	case INT_MASK_R1:
+	case INT_MASK_R2:
+	case INT_MASK_R3:
+	case INT_MASK_R4:
+	case INT_SET_MASK_R1:
+	case INT_SET_MASK_R2:
+	case INT_SET_MASK_R3:
+	case INT_SET_MASK_R4:
+	case INT_CLEAR_MASK_R1:
+	case INT_CLEAR_MASK_R2:
+	case INT_CLEAR_MASK_R3:
+	case INT_CLEAR_MASK_R4:
+	case INT_SRC_R1:
+	case INT_SRC_R2:
+	case INT_SRC_R3:
+	case INT_SRC_R4:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool stpmic1_reg_writeable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case SWOFF_PWRCTRL_CR:
+	case PADS_PULL_CR:
+	case BUCKS_PD_CR:
+	case LDO14_PD_CR:
+	case LDO56_VREF_PD_CR:
+	case VBUS_DET_VIN_CR:
+	case PKEY_TURNOFF_CR:
+	case BUCKS_MASK_RANK_CR:
+	case BUCKS_MASK_RESET_CR:
+	case LDOS_MASK_RANK_CR:
+	case LDOS_MASK_RESET_CR:
+	case WCHDG_CR:
+	case WCHDG_TIMER_CR:
+	case BUCKS_ICCTO_CR:
+	case LDOS_ICCTO_CR:
+	case BUCK1_ACTIVE_CR:
+	case BUCK2_ACTIVE_CR:
+	case BUCK3_ACTIVE_CR:
+	case BUCK4_ACTIVE_CR:
+	case VREF_DDR_ACTIVE_CR:
+	case LDO1_ACTIVE_CR:
+	case LDO2_ACTIVE_CR:
+	case LDO3_ACTIVE_CR:
+	case LDO4_ACTIVE_CR:
+	case LDO5_ACTIVE_CR:
+	case LDO6_ACTIVE_CR:
+	case BUCK1_STDBY_CR:
+	case BUCK2_STDBY_CR:
+	case BUCK3_STDBY_CR:
+	case BUCK4_STDBY_CR:
+	case VREF_DDR_STDBY_CR:
+	case LDO1_STDBY_CR:
+	case LDO2_STDBY_CR:
+	case LDO3_STDBY_CR:
+	case LDO4_STDBY_CR:
+	case LDO5_STDBY_CR:
+	case LDO6_STDBY_CR:
+	case BST_SW_CR:
+	case INT_DBG_LATCH_R1:
+	case INT_DBG_LATCH_R2:
+	case INT_DBG_LATCH_R3:
+	case INT_DBG_LATCH_R4:
+	case INT_CLEAR_R1:
+	case INT_CLEAR_R2:
+	case INT_CLEAR_R3:
+	case INT_CLEAR_R4:
+	case INT_SET_MASK_R1:
+	case INT_SET_MASK_R2:
+	case INT_SET_MASK_R3:
+	case INT_SET_MASK_R4:
+	case INT_CLEAR_MASK_R1:
+	case INT_CLEAR_MASK_R2:
+	case INT_CLEAR_MASK_R3:
+	case INT_CLEAR_MASK_R4:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool stpmic1_reg_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TURN_ON_SR:
+	case TURN_OFF_SR:
+	case ICC_LDO_TURN_OFF_SR:
+	case ICC_BUCK_TURN_OFF_SR:
+	case RREQ_STATE_SR:
+	case INT_PENDING_R1:
+	case INT_PENDING_R2:
+	case INT_PENDING_R3:
+	case INT_PENDING_R4:
+	case INT_SRC_R1:
+	case INT_SRC_R2:
+	case INT_SRC_R3:
+	case INT_SRC_R4:
+	case WCHDG_CR:
+		return true;
+	default:
+		return false;
+	}
+}
+
+const struct regmap_config stpmic1_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_RBTREE,
+	.max_register = PMIC_MAX_REGISTER_ADDRESS,
+	.readable_reg = stpmic1_reg_readable,
+	.writeable_reg = stpmic1_reg_writeable,
+	.volatile_reg = stpmic1_reg_volatile,
+};
+
+static const struct regmap_irq stpmic1_irqs[] = {
+	[IT_PONKEY_F]		= { .mask = 0x01 },
+	[IT_PONKEY_R]		= { .mask = 0x02 },
+	[IT_WAKEUP_F]		= { .mask = 0x04 },
+	[IT_WAKEUP_R]		= { .mask = 0x08 },
+	[IT_VBUS_OTG_F]		= { .mask = 0x10 },
+	[IT_VBUS_OTG_R]		= { .mask = 0x20 },
+	[IT_SWOUT_F]		= { .mask = 0x40 },
+	[IT_SWOUT_R]		= { .mask = 0x80 },
+
+	[IT_CURLIM_BUCK1]	= { .reg_offset = 1, .mask = 0x01 },
+	[IT_CURLIM_BUCK2]	= { .reg_offset = 1, .mask = 0x02 },
+	[IT_CURLIM_BUCK3]	= { .reg_offset = 1, .mask = 0x04 },
+	[IT_CURLIM_BUCK4]	= { .reg_offset = 1, .mask = 0x08 },
+	[IT_OCP_OTG]		= { .reg_offset = 1, .mask = 0x10 },
+	[IT_OCP_SWOUT]		= { .reg_offset = 1, .mask = 0x20 },
+	[IT_OCP_BOOST]		= { .reg_offset = 1, .mask = 0x40 },
+	[IT_OVP_BOOST]		= { .reg_offset = 1, .mask = 0x80 },
+
+	[IT_CURLIM_LDO1]	= { .reg_offset = 2, .mask = 0x01 },
+	[IT_CURLIM_LDO2]	= { .reg_offset = 2, .mask = 0x02 },
+	[IT_CURLIM_LDO3]	= { .reg_offset = 2, .mask = 0x04 },
+	[IT_CURLIM_LDO4]	= { .reg_offset = 2, .mask = 0x08 },
+	[IT_CURLIM_LDO5]	= { .reg_offset = 2, .mask = 0x10 },
+	[IT_CURLIM_LDO6]	= { .reg_offset = 2, .mask = 0x20 },
+	[IT_SHORT_SWOTG]	= { .reg_offset = 2, .mask = 0x40 },
+	[IT_SHORT_SWOUT]	= { .reg_offset = 2, .mask = 0x80 },
+
+	[IT_TWARN_F]		= { .reg_offset = 3, .mask = 0x01 },
+	[IT_TWARN_R]		= { .reg_offset = 3, .mask = 0x02 },
+	[IT_VINLOW_F]		= { .reg_offset = 3, .mask = 0x04 },
+	[IT_VINLOW_R]		= { .reg_offset = 3, .mask = 0x08 },
+	[IT_SWIN_F]		= { .reg_offset = 3, .mask = 0x40 },
+	[IT_SWIN_R]		= { .reg_offset = 3, .mask = 0x80 },
+};
+
+static const struct regmap_irq_chip stpmic1_regmap_irq_chip = {
+	.name = "pmic_irq",
+	.status_base = INT_PENDING_R1,
+	.mask_base = INT_CLEAR_MASK_R1,
+	.unmask_base = INT_SET_MASK_R1,
+	.ack_base = INT_CLEAR_R1,
+	.num_regs = STPMIC1_PMIC_NUM_IRQ_REGS,
+	.irqs = stpmic1_irqs,
+	.num_irqs = ARRAY_SIZE(stpmic1_irqs),
+};
+
+static int stpmic1_probe(struct i2c_client *i2c,
+			 const struct i2c_device_id *id)
+{
+	struct stpmic1 *ddata;
+	struct device *dev = &i2c->dev;
+	int ret;
+	struct device_node *np = dev->of_node;
+	u32 reg;
+
+	ddata = devm_kzalloc(dev, sizeof(struct stpmic1), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, ddata);
+	ddata->dev = dev;
+
+	ddata->regmap = devm_regmap_init_i2c(i2c, &stpmic1_regmap_config);
+	if (IS_ERR(ddata->regmap))
+		return PTR_ERR(ddata->regmap);
+
+	ddata->irq = of_irq_get(np, STPMIC1_MAIN_IRQ);
+	if (ddata->irq < 0) {
+		dev_err(dev, "Failed to get main IRQ: %d\n", ddata->irq);
+		return ddata->irq;
+	}
+
+	if (!of_property_read_u32(np, "st,main-control-register", &reg)) {
+		ret = regmap_update_bits(ddata->regmap,
+					 SWOFF_PWRCTRL_CR,
+					 PWRCTRL_POLARITY_HIGH |
+					 PWRCTRL_PIN_VALID |
+					 RESTART_REQUEST_ENABLED,
+					 reg);
+		if (ret) {
+			dev_err(dev,
+				"Failed to update main control register: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	/* Read Version ID */
+	ret = regmap_read(ddata->regmap, VERSION_SR, &reg);
+	if (ret) {
+		dev_err(dev, "Unable to read pmic version\n");
+		return ret;
+	}
+	dev_info(dev, "PMIC Chip Version: 0x%x\n", reg);
+
+	if (!of_property_read_u32(np, "st,pads-pull-register", &reg)) {
+		ret = regmap_update_bits(ddata->regmap,
+					 PADS_PULL_CR,
+					 WAKEUP_DETECTOR_DISABLED |
+					 PWRCTRL_PD_ACTIVE |
+					 PWRCTRL_PU_ACTIVE |
+					 WAKEUP_PD_ACTIVE,
+					 reg);
+		if (ret) {
+			dev_err(dev,
+				"Failed to update pads control register: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	if (!of_property_read_u32(np, "st,vin-control-register", &reg)) {
+		ret = regmap_update_bits(ddata->regmap,
+					 VBUS_DET_VIN_CR,
+					 VINLOW_CTRL_REG_MASK,
+					 reg);
+		if (ret) {
+			dev_err(dev,
+				"Failed to update vin control register: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	if (!of_property_read_u32(np, "st,usb-control-register", &reg)) {
+		ret = regmap_update_bits(ddata->regmap, BST_SW_CR,
+					 BOOST_OVP_DISABLED |
+					 VBUS_OTG_DETECTION_DISABLED |
+					 SW_OUT_DISCHARGE |
+					 VBUS_OTG_DISCHARGE |
+					 OCP_LIMIT_HIGH,
+					 reg);
+		if (ret) {
+			dev_err(dev,
+				"Failed to update usb control register: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	/* Initialize PMIC IRQ Chip & IRQ domains associated */
+	ret = devm_regmap_add_irq_chip(dev, ddata->regmap, ddata->irq,
+				       IRQF_ONESHOT | IRQF_SHARED,
+				       0, &stpmic1_regmap_irq_chip,
+				       &ddata->irq_data);
+	if (ret) {
+		dev_err(dev, "IRQ Chip registration failed: %d\n", ret);
+		return ret;
+	}
+
+	return devm_of_platform_populate(dev);
+}
+
+static const struct i2c_device_id stpmic1_id[] = {
+	{ "stpmic1"},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, stpmic1_id);
+
+#ifdef CONFIG_PM_SLEEP
+static int stpmic1_suspend(struct device *dev)
+{
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct stpmic1 *pmic_dev = i2c_get_clientdata(i2c);
+
+	disable_irq(pmic_dev->irq);
+
+	return 0;
+}
+
+static int stpmic1_resume(struct device *dev)
+{
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct stpmic1 *pmic_dev = i2c_get_clientdata(i2c);
+	int ret;
+
+	ret = regcache_sync(pmic_dev->regmap);
+	if (ret)
+		return ret;
+
+	enable_irq(pmic_dev->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(stpmic1_pm, stpmic1_suspend, stpmic1_resume);
+
+static struct i2c_driver stpmic1_driver = {
+	.driver = {
+		.name = "stpmic1",
+		.pm = &stpmic1_pm,
+	},
+	.probe = stpmic1_probe,
+	.id_table = stpmic1_id,
+};
+
+module_i2c_driver(stpmic1_driver);
+
+MODULE_DESCRIPTION("STPMIC1 PMIC Driver");
+MODULE_AUTHOR("Pascal Paillet <p.paillet@st.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/stpmic1.h b/include/linux/mfd/stpmic1.h
new file mode 100644
index 0000000..fa3f99f
--- /dev/null
+++ b/include/linux/mfd/stpmic1.h
@@ -0,0 +1,212 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Author: Philippe Peurichard <philippe.peurichard@st.com>,
+ * Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
+ */
+
+#ifndef __LINUX_MFD_STPMIC1_H
+#define __LINUX_MFD_STPMIC1_H
+
+#define TURN_ON_SR		0x1
+#define TURN_OFF_SR		0x2
+#define ICC_LDO_TURN_OFF_SR	0x3
+#define ICC_BUCK_TURN_OFF_SR	0x4
+#define RREQ_STATE_SR		0x5
+#define VERSION_SR		0x6
+
+#define SWOFF_PWRCTRL_CR	0x10
+#define PADS_PULL_CR		0x11
+#define BUCKS_PD_CR		0x12
+#define LDO14_PD_CR		0x13
+#define LDO56_VREF_PD_CR	0x14
+#define VBUS_DET_VIN_CR		0x15
+#define PKEY_TURNOFF_CR		0x16
+#define BUCKS_MASK_RANK_CR	0x17
+#define BUCKS_MASK_RESET_CR	0x18
+#define LDOS_MASK_RANK_CR	0x19
+#define LDOS_MASK_RESET_CR	0x1A
+#define WCHDG_CR		0x1B
+#define WCHDG_TIMER_CR		0x1C
+#define BUCKS_ICCTO_CR		0x1D
+#define LDOS_ICCTO_CR		0x1E
+
+#define BUCK1_ACTIVE_CR		0x20
+#define BUCK2_ACTIVE_CR		0x21
+#define BUCK3_ACTIVE_CR		0x22
+#define BUCK4_ACTIVE_CR		0x23
+#define VREF_DDR_ACTIVE_CR	0x24
+#define LDO1_ACTIVE_CR		0x25
+#define LDO2_ACTIVE_CR		0x26
+#define LDO3_ACTIVE_CR		0x27
+#define LDO4_ACTIVE_CR		0x28
+#define LDO5_ACTIVE_CR		0x29
+#define LDO6_ACTIVE_CR		0x2A
+
+#define BUCK1_STDBY_CR		0x30
+#define BUCK2_STDBY_CR		0x31
+#define BUCK3_STDBY_CR		0x32
+#define BUCK4_STDBY_CR		0x33
+#define VREF_DDR_STDBY_CR	0x34
+#define LDO1_STDBY_CR		0x35
+#define LDO2_STDBY_CR		0x36
+#define LDO3_STDBY_CR		0x37
+#define LDO4_STDBY_CR		0x38
+#define LDO5_STDBY_CR		0x39
+#define LDO6_STDBY_CR		0x3A
+
+#define BST_SW_CR		0x40
+
+#define INT_PENDING_R1		0x50
+#define INT_PENDING_R2		0x51
+#define INT_PENDING_R3		0x52
+#define INT_PENDING_R4		0x53
+
+#define INT_DBG_LATCH_R1	0x60
+#define INT_DBG_LATCH_R2	0x61
+#define INT_DBG_LATCH_R3	0x62
+#define INT_DBG_LATCH_R4	0x63
+
+#define INT_CLEAR_R1		0x70
+#define INT_CLEAR_R2		0x71
+#define INT_CLEAR_R3		0x72
+#define INT_CLEAR_R4		0x73
+
+#define INT_MASK_R1		0x80
+#define INT_MASK_R2		0x81
+#define INT_MASK_R3		0x82
+#define INT_MASK_R4		0x83
+
+#define INT_SET_MASK_R1		0x90
+#define INT_SET_MASK_R2		0x91
+#define INT_SET_MASK_R3		0x92
+#define INT_SET_MASK_R4		0x93
+
+#define INT_CLEAR_MASK_R1	0xA0
+#define INT_CLEAR_MASK_R2	0xA1
+#define INT_CLEAR_MASK_R3	0xA2
+#define INT_CLEAR_MASK_R4	0xA3
+
+#define INT_SRC_R1		0xB0
+#define INT_SRC_R2		0xB1
+#define INT_SRC_R3		0xB2
+#define INT_SRC_R4		0xB3
+
+#define PMIC_MAX_REGISTER_ADDRESS INT_SRC_R4
+
+#define STPMIC1_PMIC_NUM_IRQ_REGS 4
+
+#define TURN_OFF_SR_ICC_EVENT	0x08
+
+#define LDO_VOLTAGE_MASK		GENMASK(6, 2)
+#define BUCK_VOLTAGE_MASK		GENMASK(7, 2)
+#define LDO_BUCK_VOLTAGE_SHIFT		2
+
+#define LDO_ENABLE_MASK			BIT(0)
+#define BUCK_ENABLE_MASK		BIT(0)
+
+#define BUCK_HPLP_ENABLE_MASK		BIT(1)
+#define BUCK_HPLP_SHIFT			1
+
+#define STDBY_ENABLE_MASK  BIT(0)
+
+#define BUCKS_PD_CR_REG_MASK	GENMASK(7, 0)
+#define BUCK_MASK_RANK_REGISTER_MASK	GENMASK(3, 0)
+#define BUCK_MASK_RESET_REGISTER_MASK	GENMASK(3, 0)
+#define LDO1234_PULL_DOWN_REGISTER_MASK	GENMASK(7, 0)
+#define LDO56_VREF_PD_CR_REG_MASK	GENMASK(5, 0)
+#define LDO_MASK_RANK_REGISTER_MASK	GENMASK(5, 0)
+#define LDO_MASK_RESET_REGISTER_MASK	GENMASK(5, 0)
+
+#define BUCK1_PULL_DOWN_REG		BUCKS_PD_CR
+#define BUCK1_PULL_DOWN_MASK		BIT(0)
+#define BUCK2_PULL_DOWN_REG		BUCKS_PD_CR
+#define BUCK2_PULL_DOWN_MASK		BIT(2)
+#define BUCK3_PULL_DOWN_REG		BUCKS_PD_CR
+#define BUCK3_PULL_DOWN_MASK		BIT(4)
+#define BUCK4_PULL_DOWN_REG		BUCKS_PD_CR
+#define BUCK4_PULL_DOWN_MASK		BIT(6)
+
+#define LDO1_PULL_DOWN_REG		LDO14_PD_CR
+#define LDO1_PULL_DOWN_MASK		BIT(0)
+#define LDO2_PULL_DOWN_REG		LDO14_PD_CR
+#define LDO2_PULL_DOWN_MASK		BIT(2)
+#define LDO3_PULL_DOWN_REG		LDO14_PD_CR
+#define LDO3_PULL_DOWN_MASK		BIT(4)
+#define LDO4_PULL_DOWN_REG		LDO14_PD_CR
+#define LDO4_PULL_DOWN_MASK		BIT(6)
+#define LDO5_PULL_DOWN_REG		LDO56_VREF_PD_CR
+#define LDO5_PULL_DOWN_MASK		BIT(0)
+#define LDO6_PULL_DOWN_REG		LDO56_VREF_PD_CR
+#define LDO6_PULL_DOWN_MASK		BIT(2)
+#define VREF_DDR_PULL_DOWN_REG		LDO56_VREF_PD_CR
+#define VREF_DDR_PULL_DOWN_MASK		BIT(4)
+
+#define BUCKS_ICCTO_CR_REG_MASK	GENMASK(6, 0)
+#define LDOS_ICCTO_CR_REG_MASK	GENMASK(5, 0)
+
+#define LDO_BYPASS_MASK			BIT(7)
+
+/* Main PMIC Control Register
+ * SWOFF_PWRCTRL_CR
+ * Address : 0x10
+ */
+#define ICC_EVENT_ENABLED		BIT(4)
+#define PWRCTRL_POLARITY_HIGH		BIT(3)
+#define PWRCTRL_PIN_VALID		BIT(2)
+#define RESTART_REQUEST_ENABLED		BIT(1)
+#define SOFTWARE_SWITCH_OFF_ENABLED	BIT(0)
+
+/* Main PMIC PADS Control Register
+ * PADS_PULL_CR
+ * Address : 0x11
+ */
+#define WAKEUP_DETECTOR_DISABLED	BIT(4)
+#define PWRCTRL_PD_ACTIVE		BIT(3)
+#define PWRCTRL_PU_ACTIVE		BIT(2)
+#define WAKEUP_PD_ACTIVE		BIT(1)
+#define PONKEY_PU_INACTIVE		BIT(0)
+
+/* Main PMIC VINLOW Control Register
+ * VBUS_DET_VIN_CRC DMSC
+ * Address : 0x15
+ */
+#define SWIN_DETECTOR_ENABLED		BIT(7)
+#define SWOUT_DETECTOR_ENABLED		BIT(6)
+#define VINLOW_ENABLED			BIT(0)
+#define VINLOW_CTRL_REG_MASK		GENMASK(7, 0)
+
+/* USB Control Register
+ * Address : 0x40
+ */
+#define BOOST_OVP_DISABLED		BIT(7)
+#define VBUS_OTG_DETECTION_DISABLED	BIT(6)
+#define SW_OUT_DISCHARGE		BIT(5)
+#define VBUS_OTG_DISCHARGE		BIT(4)
+#define OCP_LIMIT_HIGH			BIT(3)
+#define SWIN_SWOUT_ENABLED		BIT(2)
+#define USBSW_OTG_SWITCH_ENABLED	BIT(1)
+#define BOOST_ENABLED			BIT(0)
+
+/* PKEY_TURNOFF_CR
+ * Address : 0x16
+ */
+#define PONKEY_PWR_OFF			BIT(7)
+#define PONKEY_CC_FLAG_CLEAR		BIT(6)
+#define PONKEY_TURNOFF_TIMER_MASK	GENMASK(3, 0)
+#define PONKEY_TURNOFF_MASK		GENMASK(7, 0)
+
+/*
+ * struct stpmic1 - stpmic1 master device for sub-drivers
+ * @dev: master device of the chip (can be used to access platform data)
+ * @irq: main IRQ number
+ * @regmap_irq_chip_data: irq chip data
+ */
+struct stpmic1 {
+	struct device *dev;
+	struct regmap *regmap;
+	int irq;
+	struct regmap_irq_chip_data *irq_data;
+};
+
+#endif /*  __LINUX_MFD_STPMIC1_H */
-- 
1.9.1
