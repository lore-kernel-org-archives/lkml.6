Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C50C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0AC2156B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0AC2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeGEPPr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:15:47 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53306 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754329AbeGEPOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:14:52 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w65F9PVt022966;
        Thu, 5 Jul 2018 17:14:24 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2k0dnr1ucu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 17:14:24 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8D6C038;
        Thu,  5 Jul 2018 15:14:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4FCE626D4;
        Thu,  5 Jul 2018 15:14:23 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 5 Jul
 2018 17:14:22 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Thu, 5 Jul 2018 17:14:22 +0200
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
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
CC:     Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH 2/8] mfd: stpmu1: add stpmu1 pmic driver
Thread-Topic: [PATCH 2/8] mfd: stpmu1: add stpmu1 pmic driver
Thread-Index: AQHUFHLaKOnksVxEZUKN7td2/IYexg==
Date:   Thu, 5 Jul 2018 15:14:22 +0000
Message-ID: <1530803657-17684-3-git-send-email-p.paillet@st.com>
References: <1530803657-17684-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1530803657-17684-1-git-send-email-p.paillet@st.com>
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
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: pascal paillet <p.paillet@st.com>

stpmu1 is a pmic from STMicroelectronics. The stpmu1 integrates 10
regulators and 3 switches with various capabilities.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
 drivers/mfd/Kconfig                 |  14 ++
 drivers/mfd/Makefile                |   1 +
 drivers/mfd/stpmu1.c                | 490 ++++++++++++++++++++++++++++++++++++
 include/dt-bindings/mfd/st,stpmu1.h |  46 ++++
 include/linux/mfd/stpmu1.h          | 220 ++++++++++++++++
 5 files changed, 771 insertions(+)
 create mode 100644 drivers/mfd/stpmu1.c
 create mode 100644 include/dt-bindings/mfd/st,stpmu1.h
 create mode 100644 include/linux/mfd/stpmu1.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b860eb5..e15140b 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1812,6 +1812,20 @@ config MFD_STM32_TIMERS
 	  for PWM and IIO Timer. This driver allow to share the
 	  registers between the others drivers.
 
+config MFD_STPMU1
+	tristate "Support for STPMU1 PMIC"
+	depends on (I2C=y && OF)
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	select MFD_CORE
+	help
+	  Support for ST Microelectronics STPMU1 PMIC. Stpmu1 mfd driver is
+	  the core driver for stpmu1 component that mainly handles interrupts.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called stpmu1.
+
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index e9fd20d..f1c4be1 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -220,6 +220,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
 obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
 
 obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
+obj-$(CONFIG_MFD_STPMU1)	+= stpmu1.o
 obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
 
 obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
diff --git a/drivers/mfd/stpmu1.c b/drivers/mfd/stpmu1.c
new file mode 100644
index 0000000..a284a3e
--- /dev/null
+++ b/drivers/mfd/stpmu1.c
@@ -0,0 +1,490 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Author: Philippe Peurichard <philippe.peurichard@st.com>,
+ * Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/stpmu1.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/regmap.h>
+#include <dt-bindings/mfd/st,stpmu1.h>
+
+static bool stpmu1_reg_readable(struct device *dev, unsigned int reg);
+static bool stpmu1_reg_writeable(struct device *dev, unsigned int reg);
+static bool stpmu1_reg_volatile(struct device *dev, unsigned int reg);
+
+const struct regmap_config stpmu1_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_RBTREE,
+	.max_register = PMIC_MAX_REGISTER_ADDRESS,
+	.readable_reg = stpmu1_reg_readable,
+	.writeable_reg = stpmu1_reg_writeable,
+	.volatile_reg = stpmu1_reg_volatile,
+};
+
+#define FILL_IRQS(_index) \
+	[(_index)] = { \
+		.reg_offset = ((_index) >> 3), \
+		.mask = (1 << (_index % 8)), \
+	}
+
+static const struct regmap_irq stpmu1_irqs[] = {
+	FILL_IRQS(IT_PONKEY_F),
+	FILL_IRQS(IT_PONKEY_R),
+	FILL_IRQS(IT_WAKEUP_F),
+	FILL_IRQS(IT_WAKEUP_R),
+	FILL_IRQS(IT_VBUS_OTG_F),
+	FILL_IRQS(IT_VBUS_OTG_R),
+	FILL_IRQS(IT_SWOUT_F),
+	FILL_IRQS(IT_SWOUT_R),
+
+	FILL_IRQS(IT_CURLIM_BUCK1),
+	FILL_IRQS(IT_CURLIM_BUCK2),
+	FILL_IRQS(IT_CURLIM_BUCK3),
+	FILL_IRQS(IT_CURLIM_BUCK4),
+	FILL_IRQS(IT_OCP_OTG),
+	FILL_IRQS(IT_OCP_SWOUT),
+	FILL_IRQS(IT_OCP_BOOST),
+	FILL_IRQS(IT_OVP_BOOST),
+
+	FILL_IRQS(IT_CURLIM_LDO1),
+	FILL_IRQS(IT_CURLIM_LDO2),
+	FILL_IRQS(IT_CURLIM_LDO3),
+	FILL_IRQS(IT_CURLIM_LDO4),
+	FILL_IRQS(IT_CURLIM_LDO5),
+	FILL_IRQS(IT_CURLIM_LDO6),
+	FILL_IRQS(IT_SHORT_SWOTG),
+	FILL_IRQS(IT_SHORT_SWOUT),
+
+	FILL_IRQS(IT_TWARN_F),
+	FILL_IRQS(IT_TWARN_R),
+	FILL_IRQS(IT_VINLOW_F),
+	FILL_IRQS(IT_VINLOW_R),
+	FILL_IRQS(IT_SWIN_F),
+	FILL_IRQS(IT_SWIN_R),
+};
+
+static const struct regmap_irq_chip stpmu1_regmap_irq_chip = {
+	.name = "pmic_irq",
+	.status_base = INT_PENDING_R1,
+	.mask_base = INT_CLEAR_MASK_R1,
+	.unmask_base = INT_SET_MASK_R1,
+	.ack_base = INT_CLEAR_R1,
+	.num_regs = STPMU1_PMIC_NUM_IRQ_REGS,
+	.irqs = stpmu1_irqs,
+	.num_irqs = ARRAY_SIZE(stpmu1_irqs),
+};
+
+static bool stpmu1_reg_readable(struct device *dev, unsigned int reg)
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
+static bool stpmu1_reg_writeable(struct device *dev, unsigned int reg)
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
+static bool stpmu1_reg_volatile(struct device *dev, unsigned int reg)
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
+static int stpmu1_configure_from_dt(struct stpmu1_dev *pmic_dev)
+{
+	struct device_node *np = pmic_dev->np;
+	u32 reg = 0;
+	int ret = 0;
+	int irq;
+
+	irq = of_irq_get(np, 0);
+	if (irq <= 0) {
+		dev_err(pmic_dev->dev,
+			"Failed to get irq config: %d\n", irq);
+		return irq ? irq : -ENODEV;
+	}
+	pmic_dev->irq = irq;
+
+	irq = of_irq_get(np, 1);
+	if (irq <= 0) {
+		dev_err(pmic_dev->dev,
+			"Failed to get irq_wake config: %d\n", irq);
+		return irq ? irq : -ENODEV;
+	}
+	pmic_dev->irq_wake = irq;
+
+	device_init_wakeup(pmic_dev->dev, true);
+	ret = dev_pm_set_dedicated_wake_irq(pmic_dev->dev, pmic_dev->irq_wake);
+	if (ret)
+		dev_warn(pmic_dev->dev, "failed to set up wakeup irq");
+
+	if (!of_property_read_u32(np, "st,main_control_register", &reg)) {
+		ret = regmap_update_bits(pmic_dev->regmap,
+					 SWOFF_PWRCTRL_CR,
+					 PWRCTRL_POLARITY_HIGH |
+					 PWRCTRL_PIN_VALID |
+					 RESTART_REQUEST_ENABLED,
+					 reg);
+		if (ret) {
+			dev_err(pmic_dev->dev,
+				"Failed to update main control register: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	if (!of_property_read_u32(np, "st,pads_pull_register", &reg)) {
+		ret = regmap_update_bits(pmic_dev->regmap,
+					 PADS_PULL_CR,
+					 WAKEUP_DETECTOR_DISABLED |
+					 PWRCTRL_PD_ACTIVE |
+					 PWRCTRL_PU_ACTIVE |
+					 WAKEUP_PD_ACTIVE,
+					 reg);
+		if (ret) {
+			dev_err(pmic_dev->dev,
+				"Failed to update pads control register: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	if (!of_property_read_u32(np, "st,vin_control_register", &reg)) {
+		ret = regmap_update_bits(pmic_dev->regmap,
+					 VBUS_DET_VIN_CR,
+					 VINLOW_CTRL_REG_MASK,
+					 reg);
+		if (ret) {
+			dev_err(pmic_dev->dev,
+				"Failed to update vin control register: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	if (!of_property_read_u32(np, "st,usb_control_register", &reg)) {
+		ret = regmap_update_bits(pmic_dev->regmap, BST_SW_CR,
+					 BOOST_OVP_DISABLED |
+					 VBUS_OTG_DETECTION_DISABLED |
+					 SW_OUT_DISCHARGE |
+					 VBUS_OTG_DISCHARGE |
+					 OCP_LIMIT_HIGH,
+					 reg);
+		if (ret) {
+			dev_err(pmic_dev->dev,
+				"Failed to update usb control register: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+int stpmu1_device_init(struct stpmu1_dev *pmic_dev)
+{
+	int ret;
+	unsigned int val;
+
+	pmic_dev->regmap =
+	    devm_regmap_init_i2c(pmic_dev->i2c, &stpmu1_regmap_config);
+
+	if (IS_ERR(pmic_dev->regmap)) {
+		ret = PTR_ERR(pmic_dev->regmap);
+		dev_err(pmic_dev->dev, "Failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = stpmu1_configure_from_dt(pmic_dev);
+	if (ret < 0) {
+		dev_err(pmic_dev->dev,
+			"Unable to configure PMIC from Device Tree: %d\n", ret);
+		return ret;
+	}
+
+	/* Read Version ID */
+	ret = regmap_read(pmic_dev->regmap, VERSION_SR, &val);
+	if (ret < 0) {
+		dev_err(pmic_dev->dev, "Unable to read pmic version\n");
+		return ret;
+	}
+	dev_dbg(pmic_dev->dev, "PMIC Chip Version: 0x%x\n", val);
+
+	/* Initialize PMIC IRQ Chip & IRQ domains associated */
+	ret = devm_regmap_add_irq_chip(pmic_dev->dev, pmic_dev->regmap,
+				       pmic_dev->irq,
+				       IRQF_ONESHOT | IRQF_SHARED,
+				       0, &stpmu1_regmap_irq_chip,
+				       &pmic_dev->irq_data);
+	if (ret < 0) {
+		dev_err(pmic_dev->dev, "IRQ Chip registration failed: %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id stpmu1_dt_match[] = {
+	{.compatible = "st,stpmu1"},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, stpmu1_dt_match);
+
+static int stpmu1_remove(struct i2c_client *i2c)
+{
+	struct stpmu1_dev *pmic_dev = i2c_get_clientdata(i2c);
+
+	of_platform_depopulate(pmic_dev->dev);
+
+	return 0;
+}
+
+static int stpmu1_probe(struct i2c_client *i2c,
+			const struct i2c_device_id *id)
+{
+	struct stpmu1_dev *pmic;
+	struct device *dev = &i2c->dev;
+	int ret = 0;
+
+	pmic = devm_kzalloc(dev, sizeof(struct stpmu1_dev), GFP_KERNEL);
+	if (!pmic)
+		return -ENOMEM;
+
+	pmic->np = dev->of_node;
+
+	dev_set_drvdata(dev, pmic);
+	pmic->dev = dev;
+	pmic->i2c = i2c;
+
+	ret = stpmu1_device_init(pmic);
+	if (ret < 0)
+		goto err;
+
+	ret = of_platform_populate(pmic->np, NULL, NULL, pmic->dev);
+
+	dev_dbg(dev, "stpmu1 driver probed\n");
+err:
+	return ret;
+}
+
+static const struct i2c_device_id stpmu1_id[] = {
+	{"stpmu1", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, stpmu1_id);
+
+#ifdef CONFIG_PM_SLEEP
+static int stpmu1_suspend(struct device *dev)
+{
+	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
+	struct stpmu1_dev *pmic_dev = i2c_get_clientdata(i2c);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(pmic_dev->irq_wake);
+
+	disable_irq(pmic_dev->irq);
+	return 0;
+}
+
+static int stpmu1_resume(struct device *dev)
+{
+	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
+	struct stpmu1_dev *pmic_dev = i2c_get_clientdata(i2c);
+
+	regcache_sync(pmic_dev->regmap);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(pmic_dev->irq_wake);
+
+	enable_irq(pmic_dev->irq);
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(stpmu1_pm, stpmu1_suspend, stpmu1_resume);
+
+static struct i2c_driver stpmu1_driver = {
+	.driver = {
+		   .name = "stpmu1",
+		   .owner = THIS_MODULE,
+		   .pm = &stpmu1_pm,
+		   .of_match_table = of_match_ptr(stpmu1_dt_match),
+		   },
+	.probe = stpmu1_probe,
+	.remove = stpmu1_remove,
+	.id_table = stpmu1_id,
+};
+
+module_i2c_driver(stpmu1_driver);
+
+MODULE_DESCRIPTION("STPMU1 PMIC I2C Client");
+MODULE_AUTHOR("<philippe.peurichard@st.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/dt-bindings/mfd/st,stpmu1.h b/include/dt-bindings/mfd/st,stpmu1.h
new file mode 100644
index 0000000..2d3bdf1
--- /dev/null
+++ b/include/dt-bindings/mfd/st,stpmu1.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Author: Philippe Peurichard <philippe.peurichard@st.com>,
+ * Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
+ */
+
+#ifndef __DT_BINDINGS_STPMU1_H__
+#define __DT_BINDINGS_STPMU1_H__
+
+/* IRQ definitions */
+#define IT_PONKEY_F 0
+#define IT_PONKEY_R 1
+#define IT_WAKEUP_F 2
+#define IT_WAKEUP_R 3
+#define IT_VBUS_OTG_F 4
+#define IT_VBUS_OTG_R 5
+#define IT_SWOUT_F 6
+#define IT_SWOUT_R 7
+
+#define IT_CURLIM_BUCK1 8
+#define IT_CURLIM_BUCK2 9
+#define IT_CURLIM_BUCK3 10
+#define IT_CURLIM_BUCK4 11
+#define IT_OCP_OTG 12
+#define IT_OCP_SWOUT 13
+#define IT_OCP_BOOST 14
+#define IT_OVP_BOOST 15
+
+#define IT_CURLIM_LDO1 16
+#define IT_CURLIM_LDO2 17
+#define IT_CURLIM_LDO3 18
+#define IT_CURLIM_LDO4 19
+#define IT_CURLIM_LDO5 20
+#define IT_CURLIM_LDO6 21
+#define IT_SHORT_SWOTG 22
+#define IT_SHORT_SWOUT 23
+
+#define IT_TWARN_F 24
+#define IT_TWARN_R 25
+#define IT_VINLOW_F 26
+#define IT_VINLOW_R 27
+#define IT_SWIN_F 30
+#define IT_SWIN_R 31
+
+#endif /* __DT_BINDINGS_STPMU1_H__ */
diff --git a/include/linux/mfd/stpmu1.h b/include/linux/mfd/stpmu1.h
new file mode 100644
index 0000000..05fd029
--- /dev/null
+++ b/include/linux/mfd/stpmu1.h
@@ -0,0 +1,220 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Author: Philippe Peurichard <philippe.peurichard@st.com>,
+ * Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
+ */
+
+#ifndef __LINUX_MFD_STPMU1_H
+#define __LINUX_MFD_STPMU1_H
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
+#define STPMU1_PMIC_NUM_IRQ_REGS 4
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
+#define PONKEY_PU_ACTIVE		BIT(0)
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
+ * struct stpmu1_dev - stpmu1 master device for sub-drivers
+ * @dev: master device of the chip (can be used to access platform data)
+ * @i2c: i2c client private data for regulator
+ * @np: device DT node pointer
+ * @irq_base: base IRQ numbers
+ * @irq: generic IRQ number
+ * @irq_wake: wakeup IRQ number
+ * @regmap_irq_chip_data: irq chip data
+ */
+struct stpmu1_dev {
+	struct device *dev;
+	struct i2c_client *i2c;
+	struct regmap *regmap;
+	struct device_node *np;
+	unsigned int irq_base;
+	int irq;
+	int irq_wake;
+	struct regmap_irq_chip_data *irq_data;
+};
+
+#endif /*  __LINUX_MFD_STPMU1_H */
-- 
1.9.1
