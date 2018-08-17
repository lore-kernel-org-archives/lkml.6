Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEC1C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 00:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A211F20C0D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 00:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="graL/lwJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JtlvU6U7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A211F20C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeHQDH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 23:07:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34970 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbeHQDH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 23:07:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 97B4661E93; Fri, 17 Aug 2018 00:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534464378;
        bh=LCnwf4BCeFB1XELvmTGex4UyqfZ9mYYJLEWyPwluKbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=graL/lwJ+hXK2WPXmu/1JQGF5eHWdd1L6PR3gt+SenjjkL/febhR3m97tL+EwHp25
         6vrAZvgHj57YZdIkI/68r9BZN4sLfRxNaOxqqR8jehjOFOV/XQZiN375Ih4+6rnbGu
         4FkApBTIqQUNyh3+Yos5iosT+Lz996GUKF3dtnBs=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7F38761EB4;
        Fri, 17 Aug 2018 00:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534464377;
        bh=LCnwf4BCeFB1XELvmTGex4UyqfZ9mYYJLEWyPwluKbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtlvU6U7UFcoiLly/y16G9pciPgJibKv42lyNwEWkBMrlMEzUSyirXxX1qdml8zC1
         negmRZF3EWuAchn/GjxyZHI2GDkPtzjrf90LkJoVTGJHt466V6w1cJ99rPjmKUol1b
         giUz8VPHLYnMAdKY54RVC50ge0knrdvxL1kTkhVE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F38761EB4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, bryanh@codeaurora.org,
        psodagud@codeaurora.org, rnayak@codeaurora.org,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Subject: [PATCH v1 2/2] Embedded USB Debugger (EUD) driver
Date:   Thu, 16 Aug 2018 17:05:48 -0700
Message-Id: <1534464348-8227-3-git-send-email-pheragu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534464348-8227-1-git-send-email-pheragu@codeaurora.org>
References: <1534464348-8227-1-git-send-email-pheragu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for control peripheral of EUD (Embedded USB Debugger) to
listen to events such as USB attach/detach, charger enable/disable, pet
EUD to indicate software is functional.

Signed-off-by: Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
---
 drivers/soc/qcom/Kconfig  |  12 ++
 drivers/soc/qcom/Makefile |   1 +
 drivers/soc/qcom/eud.c    | 340 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 353 insertions(+)
 create mode 100644 drivers/soc/qcom/eud.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 5856e79..12669ec 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -136,4 +136,16 @@ config QCOM_APR
           application processor and QDSP6. APR is
           used by audio driver to configure QDSP6
           ASM, ADM and AFE modules.
+
+config QCOM_EUD
+	tristate "QTI Embedded USB Debugger (EUD)"
+	depends on ARCH_QCOM
+	help
+	  The Embedded USB Debugger (EUD) driver is a driver for the
+	  control peripheral which waits on events like USB attach/detach
+	  and charger enable/disable. The control peripheral further helps
+	  support the USB-based debug and trace capabilities.
+	  This module enables support for Qualcomm Technologies, Inc.
+	  Embedded USB Debugger (EUD).
+	  If unsure, say N.
 endmenu
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 19dcf95..dd4701b 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
 obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
 obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
 obj-$(CONFIG_QCOM_APR) += apr.o
+obj-$(CONFIG_QCOM_EUD) += eud.o
diff --git a/drivers/soc/qcom/eud.c b/drivers/soc/qcom/eud.c
new file mode 100644
index 0000000..b4c4235
--- /dev/null
+++ b/drivers/soc/qcom/eud.c
@@ -0,0 +1,340 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/extcon.h>
+#include <linux/delay.h>
+#include <linux/sysfs.h>
+#include <linux/io.h>
+#include <linux/bitops.h>
+#include <linux/workqueue.h>
+#include <linux/power_supply.h>
+
+#define EUD_ENABLE_CMD 1
+#define EUD_DISABLE_CMD 0
+
+#define EUD_REG_INT1_EN_MASK	0x0024
+#define EUD_REG_INT_STATUS_1	0x0044
+#define EUD_REG_CTL_OUT_1	0x0074
+#define EUD_REG_VBUS_INT_CLR	0x0080
+#define EUD_REG_CHGR_INT_CLR	0x0084
+#define EUD_REG_CSR_EUD_EN	0x1014
+#define EUD_REG_SW_ATTACH_DET	0x1018
+
+#define EUD_INT_VBUS		BIT(2)
+#define EUD_INT_CHGR		BIT(3)
+#define EUD_INT_SAFE_MODE	BIT(4)
+
+#define EUD_NR			1
+
+struct eud_chip {
+	struct device			*dev;
+	int				eud_irq;
+	unsigned int			extcon_id;
+	unsigned int			int_status;
+	bool				usb_attach;
+	bool				chgr_enable;
+	void __iomem			*eud_reg_base;
+	struct extcon_dev		*extcon;
+	struct work_struct		eud_work;
+};
+
+static const unsigned int eud_extcon_cable[] = {
+	EXTCON_USB,
+	EXTCON_CHG_USB_SDP,
+	EXTCON_NONE,
+};
+
+/*
+ * On the kernel command line specify eud.enable=1 to enable EUD.
+ * EUD is disabled by default.
+ */
+static int enable;
+static bool eud_ready;
+static struct eud_chip *eud_private;
+
+static void enable_eud(struct eud_chip *priv)
+{
+	struct power_supply *usb_psy = NULL;
+	union power_supply_propval pval = {0};
+	union power_supply_propval tval = {0};
+	int ret;
+
+	usb_psy = power_supply_get_by_name("usb");
+	if (!usb_psy)
+		return;
+
+	ret = power_supply_get_property(usb_psy,
+			POWER_SUPPLY_PROP_PRESENT, &pval);
+	if (ret)
+		return;
+
+	ret = power_supply_get_property(usb_psy,
+			POWER_SUPPLY_PROP_REAL_TYPE, &tval);
+	if (ret)
+		return;
+
+	if (pval.intval && (tval.intval == POWER_SUPPLY_TYPE_USB ||
+	    tval.intval == POWER_SUPPLY_TYPE_USB_CDP)) {
+		/* write into CSR to enable EUD */
+		writel_relaxed(BIT(0), priv->eud_reg_base + EUD_REG_CSR_EUD_EN);
+		/* Enable vbus, chgr & safe mode warning interrupts */
+		writel_relaxed(EUD_INT_VBUS | EUD_INT_CHGR | EUD_INT_SAFE_MODE,
+				priv->eud_reg_base + EUD_REG_INT1_EN_MASK);
+
+		/* Ensure Register Writes Complete */
+		wmb();
+
+		/*
+		 * Set the default cable state to usb connect and charger
+		 * enable
+		 */
+		ret = extcon_set_state_sync(priv->extcon, EXTCON_USB, true);
+		if (ret)
+			return;
+		ret = extcon_set_state_sync(priv->extcon,
+				EXTCON_CHG_USB_SDP, true);
+		if (ret)
+			return;
+	} else {
+		return;
+	}
+
+}
+
+static void disable_eud(struct eud_chip *priv)
+{
+	/* write into CSR to disable EUD */
+	writel_relaxed(0, priv->eud_reg_base + EUD_REG_CSR_EUD_EN);
+}
+
+static int param_eud_set(const char *val, const struct kernel_param *kp)
+{
+	int enable = 0;
+
+	if (sscanf(val, "%du", &enable) != 1)
+		return -EINVAL;
+
+	if (enable != EUD_ENABLE_CMD && enable != EUD_DISABLE_CMD)
+		return -EINVAL;
+
+	*((uint *)kp->arg) = enable;
+	if (!eud_ready)
+		return 0;
+
+	if (enable == EUD_ENABLE_CMD)
+		enable_eud(eud_private);
+	else if (enable == EUD_DISABLE_CMD)
+		disable_eud(eud_private);
+
+	return 0;
+}
+
+static const struct kernel_param_ops eud_param_ops = {
+	.set = param_eud_set,
+	.get = param_get_int,
+};
+
+module_param_cb(enable, &eud_param_ops, &enable, 0644);
+
+static void eud_event_notifier(struct work_struct *eud_work)
+{
+	struct eud_chip *chip = container_of(eud_work, struct eud_chip,
+					eud_work);
+	int ret;
+
+	if (chip->int_status == EUD_INT_VBUS) {
+		ret = extcon_set_state_sync(chip->extcon, chip->extcon_id,
+					chip->usb_attach);
+		if (ret)
+			return;
+	} else if (chip->int_status == EUD_INT_CHGR) {
+		ret = extcon_set_state_sync(chip->extcon, chip->extcon_id,
+					chip->chgr_enable);
+		if (ret)
+			return;
+	}
+}
+
+static void usb_attach_detach(struct eud_chip *chip)
+{
+	u32 reg;
+
+	chip->extcon_id = EXTCON_USB;
+	/* read ctl_out_1[4] to find USB attach or detach event */
+	reg = readl_relaxed(chip->eud_reg_base + EUD_REG_CTL_OUT_1);
+	if (reg & BIT(4))
+		chip->usb_attach = true;
+	else
+		chip->usb_attach = false;
+
+	schedule_work(&chip->eud_work);
+
+	/* set and clear vbus_int_clr[0] to clear interrupt */
+	writel_relaxed(BIT(0), chip->eud_reg_base + EUD_REG_VBUS_INT_CLR);
+	/* Ensure Register Writes Complete */
+	wmb();
+	writel_relaxed(0, chip->eud_reg_base + EUD_REG_VBUS_INT_CLR);
+}
+
+static void chgr_enable_disable(struct eud_chip *chip)
+{
+	u32 reg;
+
+	chip->extcon_id = EXTCON_CHG_USB_SDP;
+	/* read ctl_out_1[6] to find charger enable or disable event */
+	reg = readl_relaxed(chip->eud_reg_base + EUD_REG_CTL_OUT_1);
+	if (reg & BIT(6))
+		chip->chgr_enable = true;
+	else
+		chip->chgr_enable = false;
+
+	schedule_work(&chip->eud_work);
+
+	/* set and clear chgr_int_clr[0] to clear interrupt */
+	writel_relaxed(BIT(0), chip->eud_reg_base + EUD_REG_CHGR_INT_CLR);
+	/* Ensure Register Writes Complete */
+	wmb();
+	writel_relaxed(0, chip->eud_reg_base + EUD_REG_CHGR_INT_CLR);
+}
+
+static void pet_eud(struct eud_chip *chip)
+{
+	u32 reg;
+
+	/* read sw_attach_det[0] to find attach/detach event */
+	reg = readl_relaxed(chip->eud_reg_base + EUD_REG_SW_ATTACH_DET);
+	if (reg & BIT(0)) {
+		/* Detach & Attach pet for EUD */
+		writel_relaxed(0, chip->eud_reg_base + EUD_REG_SW_ATTACH_DET);
+		/* Ensure Register Writes Complete */
+		wmb();
+		/* Delay to make sure detach pet is done before attach pet */
+		udelay(100);
+		writel_relaxed(BIT(0), chip->eud_reg_base +
+					EUD_REG_SW_ATTACH_DET);
+		/* Ensure Register Writes Complete */
+		wmb();
+	} else {
+		/* Attach pet for EUD */
+		writel_relaxed(BIT(0), chip->eud_reg_base +
+					EUD_REG_SW_ATTACH_DET);
+		/* Ensure Register Writes Complete */
+		wmb();
+	}
+}
+
+static irqreturn_t handle_eud_irq(int irq, void *data)
+{
+	struct eud_chip *chip = data;
+	u32 reg;
+
+	/* read status register and find out which interrupt triggered */
+	reg = readl_relaxed(chip->eud_reg_base + EUD_REG_INT_STATUS_1);
+	if (reg & EUD_INT_VBUS) {
+		chip->int_status = EUD_INT_VBUS;
+		usb_attach_detach(chip);
+	} else if (reg & EUD_INT_CHGR) {
+		chip->int_status = EUD_INT_CHGR;
+		chgr_enable_disable(chip);
+	} else if (reg & EUD_INT_SAFE_MODE) {
+		pet_eud(chip);
+	} else {
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int msm_eud_probe(struct platform_device *pdev)
+{
+	struct eud_chip *chip;
+	struct resource *res;
+	int ret;
+
+	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip) {
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, chip);
+
+	chip->extcon = devm_extcon_dev_allocate(&pdev->dev, eud_extcon_cable);
+	if (IS_ERR(chip->extcon))
+		return PTR_ERR(chip->extcon);
+
+	ret = devm_extcon_dev_register(&pdev->dev, chip->extcon);
+	if (ret)
+		return ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	chip->eud_reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(chip->eud_reg_base))
+		return PTR_ERR(chip->eud_reg_base);
+
+	chip->eud_irq = platform_get_irq(pdev, 0);
+
+	ret = devm_request_irq(&pdev->dev, chip->eud_irq, handle_eud_irq,
+				IRQF_TRIGGER_HIGH, NULL, chip);
+	if (ret)
+		return ret;
+
+	device_init_wakeup(&pdev->dev, true);
+	enable_irq_wake(chip->eud_irq);
+
+	INIT_WORK(&chip->eud_work, eud_event_notifier);
+
+	eud_private = chip;
+	eud_ready = true;
+
+	/* Enable EUD */
+	if (enable)
+		enable_eud(eud_private);
+
+	return 0;
+}
+
+static int msm_eud_remove(struct platform_device *pdev)
+{
+	struct eud_chip *chip = platform_get_drvdata(pdev);
+
+	if (enable)
+		disable_eud(eud_private);
+	device_init_wakeup(&pdev->dev, false);
+	disable_irq_wake(chip->eud_irq);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static const struct of_device_id msm_eud_dt_match[] = {
+	{.compatible = "qcom,msm-eud"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, msm_eud_dt_match);
+
+static struct platform_driver msm_eud_driver = {
+	.probe		= msm_eud_probe,
+	.remove		= msm_eud_remove,
+	.driver		= {
+		.name		= "msm-eud",
+		.of_match_table = msm_eud_dt_match,
+	},
+};
+module_platform_driver(msm_eud_driver);
+
+MODULE_DESCRIPTION("QTI EUD driver");
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

