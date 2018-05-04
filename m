Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-519277-1525459764-2-11313674016286358158
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525459762; b=fXfDDakC4U00j5cNy2GKHNUBBlGOrfjzBRObmeNV+v/BOySChV
    PFHIrDrrNWJY3iHOvYDBYXTjKY4duJuioyfi16Vm356r9m1AcZNsmQu0NhTCnYh+
    5Blz1JDNqN4kRBHJO7UCCskJ2LO1tVRLj4TwBCtSA5rR/RyrA9bJsnxZJtLTcAGe
    9IBGUyvYFP0eGE+fW+4Sy5MqMuCZ9qDbNyLXMWcvqXAMjvQ5Y5gtDGfPEItW4kxv
    XIgQSHPa0xaX/7x1EaFsXoqYhdOnf2ImzGteAZh5CKUjdtXJPbcMOtLoPR/mRFz6
    XUnj+298zuOD+VpdxoE4so9o6SW7i2mX75uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525459762; bh=
    gk9j+Bkrp4BnAf6GLs4xilQXJvTGfvH9Qxn1rfzY4zk=; b=V1iZo7l4wuR5B5+G
    h68/ryOzg2YR4iwsfHvIQxLx61193bnYEcSEIOEo6+eGBcLOY420m67tnjRr6RDq
    dapk1PcSSHljDFHqFNYSG781AIfh47qNW/jqGVVEDUCO4Vn89EZVruSB8iEOSMOr
    fTUTSMCgO2FdUheE4VzRcYB/d/OQ5BHF4tVRFFRu4efSRqcgSaG/vPn7WoO41M4K
    uJ9oBNlmR4Tjx9ChQUDX8MyywVxafN8HqexNATimTjgDKlBZmOI3ppkKzG6A2EyQ
    266o0I5oVecwxeDi9L3FmttXbZ/u5Ysm1RqhzGih/Vltj+Bok9+IUlcQ5jsl667o
    cfV9kw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=UL6JDCAi
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=g61Vdgs0
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codeaurora.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=UL6JDCAi
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=g61Vdgs0
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codeaurora.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIcEvMOtzr3QUlRQtiQu7oGZ0aARzYi1mGQFygRJ+ywwucoOJQOeShltS9jKD2WhDniNo5khZdDHJ+wqSK8bOAoYZKxAbinR2w/nLR2MinNedsK//5Bg
    aabL1E04YOYijJcI/QDpShTEkPMzaKxOVbKjYvk4yqApGXXQzbEGj+VAatyGJmTncBQtCWSPsMEKP3PIqSDIpz/TONMNB9AmWdR1Id4vxmaiajwbVol1ag5n
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=LpQP-O61AAAA:8
    a=VwQbUJbxAAAA:8 a=eibi7D-4tfduduG5grgA:9 a=9bWjMM6-k0WFqFI_:21
    a=UJ88tmKLaQ9BLDF9:21 a=x8gzFH9gYPwA:10 a=pioyyrs4ZptJ924tMmac:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbeEDStF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 14:49:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34782 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbeEDSsd (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 4 May 2018 14:48:33 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47B1D6019F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: balbi@kernel.org, robh@kernel.org, andy.gross@linaro.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 2/3] usb: dwc3: Add Qualcomm DWC3 glue driver
Date: Sat,  5 May 2018 00:18:08 +0530
Message-Id: <1525459689-1358-3-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525459689-1358-1-git-send-email-mgautam@codeaurora.org>
References: <1525459689-1358-1-git-send-email-mgautam@codeaurora.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DWC3 controller on Qualcomm SOCs has a Qscratch wrapper.
Some of its uses are described below resulting in need to
have a separate glue driver instead of using dwc3-of-simple:
 - It exposes register interface to override vbus-override
   and lane0-pwr-present signals going to hardware. These
   must be updated in peripheral mode for DWC3 if vbus lines
   are not connected to hardware block. Otherwise RX termination
   in SS mode or DP pull-up is not applied by device controller.
 - pwr_events_irq_stat support to check if USB2 PHY is in L2 state
   before glue driver proceeds with suspend.
 - Support for wakeup interrupts lines that are asserted whenever
   there is any wakeup event on USB3 or USB2 bus.
 - Support to replace pip3 clock going to DWC3 with utmi clock
   for hardware configuration where SSPHY is not used with DWC3.

Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
---
 drivers/usb/dwc3/Kconfig          |  12 +
 drivers/usb/dwc3/Makefile         |   1 +
 drivers/usb/dwc3/dwc3-of-simple.c |   1 -
 drivers/usb/dwc3/dwc3-qcom.c      | 618 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 631 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/dwc3/dwc3-qcom.c

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index ab8c0e0..451012e 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -106,4 +106,16 @@ config USB_DWC3_ST
 	  inside (i.e. STiH407).
 	  Say 'Y' or 'M' if you have one such device.
 
+config USB_DWC3_QCOM
+	tristate "Qualcomm Platform"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on OF
+	default USB_DWC3
+	help
+	  Some Qualcomm SoCs use DesignWare Core IP for USB2/3
+	  functionality.
+	  This driver also handles Qscratch wrapper which is needed
+	  for peripheral mode support.
+	  Say 'Y' or 'M' if you have one such device.
+
 endif
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index 025bc68..5c07d8f 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -48,3 +48,4 @@ obj-$(CONFIG_USB_DWC3_PCI)		+= dwc3-pci.o
 obj-$(CONFIG_USB_DWC3_KEYSTONE)		+= dwc3-keystone.o
 obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+= dwc3-of-simple.o
 obj-$(CONFIG_USB_DWC3_ST)		+= dwc3-st.o
+obj-$(CONFIG_USB_DWC3_QCOM)		+= dwc3-qcom.o
diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index cb2ee96..0fd0e8e 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -208,7 +208,6 @@ static int dwc3_of_simple_runtime_resume(struct device *dev)
 };
 
 static const struct of_device_id of_dwc3_simple_match[] = {
-	{ .compatible = "qcom,dwc3" },
 	{ .compatible = "rockchip,rk3399-dwc3" },
 	{ .compatible = "xlnx,zynqmp-dwc3" },
 	{ .compatible = "cavium,octeon-7130-usb-uctl" },
diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
new file mode 100644
index 0000000..ecb2218
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -0,0 +1,618 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * Inspired by dwc3-of-simple.c
+ */
+#define DEBUG
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/clk.h>
+#include <linux/irq.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/extcon.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+#include <linux/usb/of.h>
+#include <linux/reset.h>
+#include <linux/iopoll.h>
+
+#include "core.h"
+
+/* USB QSCRATCH Hardware registers */
+#define QSCRATCH_HS_PHY_CTRL			0x10
+#define UTMI_OTG_VBUS_VALID			BIT(20)
+#define SW_SESSVLD_SEL				BIT(28)
+
+#define QSCRATCH_SS_PHY_CTRL			0x30
+#define LANE0_PWR_PRESENT			BIT(24)
+
+#define QSCRATCH_GENERAL_CFG			0x08
+#define PIPE_UTMI_CLK_SEL			BIT(0)
+#define PIPE3_PHYSTATUS_SW			BIT(3)
+#define PIPE_UTMI_CLK_DIS			BIT(8)
+
+#define PWR_EVNT_IRQ_STAT_REG			0x58
+#define PWR_EVNT_LPM_IN_L2_MASK			BIT(4)
+#define PWR_EVNT_LPM_OUT_L2_MASK		BIT(5)
+
+struct dwc3_qcom {
+	struct device		*dev;
+	void __iomem		*qscratch_base;
+	struct platform_device	*dwc3;
+	struct clk		**clks;
+	int			num_clocks;
+	struct reset_control	*resets;
+
+	int			hs_phy_irq;
+	int			dp_hs_phy_irq;
+	int			dm_hs_phy_irq;
+	int			ss_phy_irq;
+
+	struct extcon_dev	*edev;
+	struct extcon_dev	*host_edev;
+	struct notifier_block	vbus_nb;
+	struct notifier_block	host_nb;
+
+	enum usb_dr_mode	mode;
+	bool			is_suspended;
+	bool			pm_suspended;
+};
+
+static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg |= val;
+	writel(reg, base + offset);
+
+	/* ensure that above write is through */
+	readl(base + offset);
+}
+
+static inline void dwc3_qcom_clrbits(void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg &= ~val;
+	writel(reg, base + offset);
+
+	/* ensure that above write is through */
+	readl(base + offset);
+}
+
+static void dwc3_qcom_vbus_overrride_enable(struct dwc3_qcom *qcom, bool enable)
+{
+	if (enable) {
+		dwc3_qcom_setbits(qcom->qscratch_base, QSCRATCH_SS_PHY_CTRL,
+				  LANE0_PWR_PRESENT);
+		dwc3_qcom_setbits(qcom->qscratch_base, QSCRATCH_HS_PHY_CTRL,
+				  UTMI_OTG_VBUS_VALID | SW_SESSVLD_SEL);
+	} else {
+		dwc3_qcom_clrbits(qcom->qscratch_base, QSCRATCH_SS_PHY_CTRL,
+				  LANE0_PWR_PRESENT);
+		dwc3_qcom_clrbits(qcom->qscratch_base, QSCRATCH_HS_PHY_CTRL,
+				  UTMI_OTG_VBUS_VALID | SW_SESSVLD_SEL);
+	}
+}
+
+static int dwc3_qcom_vbus_notifier(struct notifier_block *nb,
+				   unsigned long event, void *ptr)
+{
+	struct dwc3_qcom *qcom = container_of(nb, struct dwc3_qcom, vbus_nb);
+
+	/* enable vbus override for device mode */
+	dwc3_qcom_vbus_overrride_enable(qcom, event);
+	qcom->mode = event ? USB_DR_MODE_PERIPHERAL : USB_DR_MODE_HOST;
+
+	return NOTIFY_DONE;
+}
+
+static int dwc3_qcom_host_notifier(struct notifier_block *nb,
+				   unsigned long event, void *ptr)
+{
+	struct dwc3_qcom *qcom = container_of(nb, struct dwc3_qcom, host_nb);
+
+	/* disable vbus override in host mode */
+	dwc3_qcom_vbus_overrride_enable(qcom, !event);
+	qcom->mode = event ? USB_DR_MODE_HOST : USB_DR_MODE_PERIPHERAL;
+
+	return NOTIFY_DONE;
+}
+
+static int dwc3_qcom_register_extcon(struct dwc3_qcom *qcom)
+{
+	struct device		*dev = qcom->dev;
+	struct extcon_dev	*host_edev;
+	int			ret;
+
+	if (!of_property_read_bool(dev->of_node, "extcon"))
+		return 0;
+
+	qcom->edev = extcon_get_edev_by_phandle(dev, 0);
+	if (IS_ERR(qcom->edev))
+		return PTR_ERR(qcom->edev);
+
+	qcom->vbus_nb.notifier_call = dwc3_qcom_vbus_notifier;
+
+	qcom->host_edev = extcon_get_edev_by_phandle(dev, 1);
+	if (IS_ERR(qcom->host_edev))
+		qcom->host_edev = NULL;
+
+	ret = devm_extcon_register_notifier(dev, qcom->edev, EXTCON_USB,
+					    &qcom->vbus_nb);
+	if (ret < 0) {
+		dev_err(dev, "VBUS notifier register failed\n");
+		return ret;
+	}
+
+	if (qcom->host_edev)
+		host_edev = qcom->host_edev;
+	else
+		host_edev = qcom->edev;
+
+	qcom->host_nb.notifier_call = dwc3_qcom_host_notifier;
+	ret = devm_extcon_register_notifier(dev, host_edev, EXTCON_USB_HOST,
+					    &qcom->host_nb);
+	if (ret < 0) {
+		dev_err(dev, "Host notifier register failed\n");
+		return ret;
+	}
+
+	/* Update initial VBUS override based on extcon state */
+	if (extcon_get_state(qcom->edev, EXTCON_USB) ||
+	    !extcon_get_state(host_edev, EXTCON_USB_HOST))
+		dwc3_qcom_vbus_notifier(&qcom->vbus_nb, true, qcom->edev);
+	else
+		dwc3_qcom_vbus_notifier(&qcom->vbus_nb, false, qcom->edev);
+
+	return 0;
+}
+
+static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
+{
+	if (qcom->hs_phy_irq) {
+		disable_irq_wake(qcom->hs_phy_irq);
+		disable_irq_nosync(qcom->hs_phy_irq);
+	}
+
+	if (qcom->dp_hs_phy_irq) {
+		disable_irq_wake(qcom->dp_hs_phy_irq);
+		disable_irq_nosync(qcom->dp_hs_phy_irq);
+	}
+
+	if (qcom->dm_hs_phy_irq) {
+		disable_irq_wake(qcom->dm_hs_phy_irq);
+		disable_irq_nosync(qcom->dm_hs_phy_irq);
+	}
+
+	if (qcom->ss_phy_irq) {
+		disable_irq_wake(qcom->ss_phy_irq);
+		disable_irq_nosync(qcom->ss_phy_irq);
+	}
+}
+
+static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
+{
+	if (qcom->hs_phy_irq) {
+		enable_irq(qcom->hs_phy_irq);
+		enable_irq_wake(qcom->hs_phy_irq);
+	}
+
+	if (qcom->dp_hs_phy_irq) {
+		enable_irq(qcom->dp_hs_phy_irq);
+		enable_irq_wake(qcom->dp_hs_phy_irq);
+	}
+
+	if (qcom->dm_hs_phy_irq) {
+		enable_irq(qcom->dm_hs_phy_irq);
+		enable_irq_wake(qcom->dm_hs_phy_irq);
+	}
+
+	if (qcom->ss_phy_irq) {
+		enable_irq(qcom->ss_phy_irq);
+		enable_irq_wake(qcom->ss_phy_irq);
+	}
+}
+
+static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
+{
+	u32 val;
+	int i;
+
+	if (qcom->is_suspended)
+		return 0;
+
+	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
+	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
+		dev_err(qcom->dev, "HS-PHY not in L2\n");
+
+	for (i = qcom->num_clocks - 1; i >= 0; i--)
+		clk_disable_unprepare(qcom->clks[i]);
+
+	qcom->is_suspended = true;
+	dwc3_qcom_enable_interrupts(qcom);
+
+	return 0;
+}
+
+static int dwc3_qcom_resume(struct dwc3_qcom *qcom)
+{
+	int ret;
+	int i;
+
+	if (!qcom->is_suspended)
+		return 0;
+
+	dwc3_qcom_disable_interrupts(qcom);
+
+	for (i = 0; i < qcom->num_clocks; i++) {
+		ret = clk_prepare_enable(qcom->clks[i]);
+		if (ret < 0) {
+			while (--i >= 0)
+				clk_disable_unprepare(qcom->clks[i]);
+			return ret;
+		}
+	}
+
+	/* Clear existing events from PHY related to L2 in/out */
+	dwc3_qcom_setbits(qcom->qscratch_base, PWR_EVNT_IRQ_STAT_REG,
+			  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
+
+	qcom->is_suspended = false;
+
+	return 0;
+}
+
+static irqreturn_t qcom_dwc3_resume_irq(int irq, void *data)
+{
+	struct dwc3_qcom *qcom = data;
+	struct dwc3	*dwc = platform_get_drvdata(qcom->dwc3);
+
+	/* If pm_suspended then let pm_resume take care of resuming h/w */
+	if (qcom->pm_suspended)
+		return IRQ_HANDLED;
+
+	if (dwc->xhci)
+		pm_runtime_resume(&dwc->xhci->dev);
+
+	return IRQ_HANDLED;
+}
+
+static void dwc3_qcom_select_utmi_clk(struct dwc3_qcom *qcom)
+{
+	/* Configure dwc3 to use UTMI clock as PIPE clock not present */
+	dwc3_qcom_setbits(qcom->qscratch_base, QSCRATCH_GENERAL_CFG,
+			  PIPE_UTMI_CLK_DIS);
+
+	usleep_range(100, 1000);
+
+	dwc3_qcom_setbits(qcom->qscratch_base, QSCRATCH_GENERAL_CFG,
+			  PIPE_UTMI_CLK_SEL | PIPE3_PHYSTATUS_SW);
+
+	usleep_range(100, 1000);
+
+	dwc3_qcom_clrbits(qcom->qscratch_base, QSCRATCH_GENERAL_CFG,
+			  PIPE_UTMI_CLK_DIS);
+}
+
+static int dwc3_qcom_setup_irq(struct platform_device *pdev)
+{
+	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
+	int irq, ret;
+
+	irq = platform_get_irq_byname(pdev, "hs_phy_irq");
+	if (irq > 0) {
+		/* Keep wakeup interrupts disabled until suspend */
+		irq_set_status_flags(irq, IRQ_NOAUTOEN);
+		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
+					qcom_dwc3_resume_irq,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"qcom_dwc3 HS", qcom);
+		if (ret) {
+			dev_err(qcom->dev, "hs_phy_irq failed: %d\n", ret);
+			return ret;
+		}
+		qcom->hs_phy_irq = irq;
+	}
+
+	irq = platform_get_irq_byname(pdev, "dp_hs_phy_irq");
+	if (irq > 0) {
+		irq_set_status_flags(irq, IRQ_NOAUTOEN);
+		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
+					qcom_dwc3_resume_irq,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"qcom_dwc3 DP_HS", qcom);
+		if (ret) {
+			dev_err(qcom->dev, "dp_hs_phy_irq failed: %d\n", ret);
+			return ret;
+		}
+		qcom->dp_hs_phy_irq = irq;
+	}
+
+	irq = platform_get_irq_byname(pdev, "dm_hs_phy_irq");
+	if (irq > 0) {
+		irq_set_status_flags(irq, IRQ_NOAUTOEN);
+		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
+					qcom_dwc3_resume_irq,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"qcom_dwc3 DM_HS", qcom);
+		if (ret) {
+			dev_err(qcom->dev, "dm_hs_phy_irq failed: %d\n", ret);
+			return ret;
+		}
+		qcom->dm_hs_phy_irq = irq;
+	}
+
+	irq = platform_get_irq_byname(pdev, "ss_phy_irq");
+	if (irq > 0) {
+		irq_set_status_flags(irq, IRQ_NOAUTOEN);
+		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
+					qcom_dwc3_resume_irq,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"qcom_dwc3 SS", qcom);
+		if (ret) {
+			dev_err(qcom->dev, "ss_phy_irq failed: %d\n", ret);
+			return ret;
+		}
+		qcom->ss_phy_irq = irq;
+	}
+
+	return 0;
+}
+
+static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
+{
+	struct device		*dev = qcom->dev;
+	struct device_node	*np = dev->of_node;
+	int			i;
+
+	qcom->num_clocks = count;
+
+	if (!count)
+		return 0;
+
+	qcom->clks = devm_kcalloc(dev, qcom->num_clocks,
+				  sizeof(struct clk *), GFP_KERNEL);
+	if (!qcom->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < qcom->num_clocks; i++) {
+		struct clk	*clk;
+		int		ret;
+
+		clk = of_clk_get(np, i);
+		if (IS_ERR(clk)) {
+			while (--i >= 0)
+				clk_put(qcom->clks[i]);
+			return PTR_ERR(clk);
+		}
+
+		ret = clk_prepare_enable(clk);
+		if (ret < 0) {
+			while (--i >= 0) {
+				clk_disable_unprepare(qcom->clks[i]);
+				clk_put(qcom->clks[i]);
+			}
+			clk_put(clk);
+
+			return ret;
+		}
+
+		qcom->clks[i] = clk;
+	}
+
+	return 0;
+}
+
+static int dwc3_qcom_probe(struct platform_device *pdev)
+{
+	struct device_node	*np = pdev->dev.of_node, *dwc3_np;
+	struct device		*dev = &pdev->dev;
+	struct dwc3_qcom	*qcom;
+	struct resource		*res;
+	int			ret, i;
+	bool			ignore_pipe_clk;
+
+	qcom = devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
+	if (!qcom)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, qcom);
+	qcom->dev = &pdev->dev;
+
+	qcom->resets = devm_reset_control_array_get_optional_exclusive(dev);
+	if (IS_ERR(qcom->resets)) {
+		ret = PTR_ERR(qcom->resets);
+		dev_err(&pdev->dev, "failed to get resets, err=%d\n", ret);
+		return ret;
+	}
+
+	ret = reset_control_assert(qcom->resets);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to assert resets, err=%d\n", ret);
+		return ret;
+	}
+
+	usleep_range(10, 1000);
+
+	ret = reset_control_deassert(qcom->resets);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to deassert resets, err=%d\n", ret);
+		goto reset_assert;
+	}
+
+	ret = dwc3_qcom_clk_init(qcom, of_count_phandle_with_args(np,
+						"clocks", "#clock-cells"));
+	if (ret) {
+		dev_err(dev, "failed to get clocks\n");
+		goto reset_assert;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	qcom->qscratch_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(qcom->qscratch_base)) {
+		dev_err(dev, "failed to map qscratch, err=%d\n", ret);
+		ret = PTR_ERR(qcom->qscratch_base);
+		goto clk_disable;
+	}
+
+	ret = dwc3_qcom_setup_irq(pdev);
+	if (ret)
+		goto clk_disable;
+
+	dwc3_np = of_get_child_by_name(np, "dwc3");
+	if (!dwc3_np) {
+		dev_err(dev, "failed to find dwc3 core child\n");
+		ret = -ENODEV;
+		goto clk_disable;
+	}
+
+	/*
+	 * Disable pipe_clk requirement if specified. Used when dwc3
+	 * operates without SSPHY and only HS/FS/LS modes are supported.
+	 */
+	ignore_pipe_clk = device_property_read_bool(dev,
+				"qcom,select-utmi-as-pipe-clk");
+	if (ignore_pipe_clk)
+		dwc3_qcom_select_utmi_clk(qcom);
+
+	ret = of_platform_populate(np, NULL, NULL, dev);
+	if (ret) {
+		dev_err(dev, "failed to register dwc3 core - %d\n", ret);
+		goto clk_disable;
+	}
+
+	qcom->dwc3 = of_find_device_by_node(dwc3_np);
+	if (!qcom->dwc3) {
+		dev_err(&pdev->dev, "failed to get dwc3 platform device\n");
+		goto depopulate;
+	}
+
+	qcom->mode = usb_get_dr_mode(&qcom->dwc3->dev);
+
+	/* enable vbus override for device mode */
+	if (qcom->mode == USB_DR_MODE_PERIPHERAL)
+		dwc3_qcom_vbus_overrride_enable(qcom, true);
+
+	/* register extcon to override sw_vbus on Vbus change later */
+	ret = dwc3_qcom_register_extcon(qcom);
+	if (ret)
+		goto depopulate;
+
+	device_init_wakeup(&pdev->dev, 1);
+	qcom->is_suspended = false;
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_forbid(dev);
+
+	return 0;
+
+depopulate:
+	of_platform_depopulate(&pdev->dev);
+clk_disable:
+	for (i = qcom->num_clocks - 1; i >= 0; i--) {
+		clk_disable_unprepare(qcom->clks[i]);
+		clk_put(qcom->clks[i]);
+	}
+reset_assert:
+	reset_control_assert(qcom->resets);
+
+	return ret;
+}
+
+static int dwc3_qcom_remove(struct platform_device *pdev)
+{
+	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	int i;
+
+	of_platform_depopulate(dev);
+
+	for (i = qcom->num_clocks - 1; i >= 0; i--) {
+		clk_disable_unprepare(qcom->clks[i]);
+		clk_put(qcom->clks[i]);
+	}
+	qcom->num_clocks = 0;
+
+	reset_control_assert(qcom->resets);
+
+	pm_runtime_allow(dev);
+	pm_runtime_disable(dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int dwc3_qcom_pm_suspend(struct device *dev)
+{
+	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
+	int ret = 0;
+
+	ret = dwc3_qcom_suspend(qcom);
+	if (!ret)
+		qcom->pm_suspended = true;
+
+	return ret;
+}
+
+static int dwc3_qcom_pm_resume(struct device *dev)
+{
+	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
+	int ret;
+
+	ret = dwc3_qcom_resume(qcom);
+	if (!ret)
+		qcom->pm_suspended = false;
+
+	return ret;
+}
+#endif
+
+#ifdef CONFIG_PM
+static int dwc3_qcom_runtime_suspend(struct device *dev)
+{
+	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
+
+	return dwc3_qcom_suspend(qcom);
+}
+
+static int dwc3_qcom_runtime_resume(struct device *dev)
+{
+	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
+
+	return dwc3_qcom_resume(qcom);
+}
+#endif
+
+static const struct dev_pm_ops dwc3_qcom_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(dwc3_qcom_pm_suspend, dwc3_qcom_pm_resume)
+	SET_RUNTIME_PM_OPS(dwc3_qcom_runtime_suspend, dwc3_qcom_runtime_resume,
+			   NULL)
+};
+
+static const struct of_device_id dwc3_qcom_of_match[] = {
+	{ .compatible = "qcom,dwc3" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, dwc3_qcom_of_match);
+
+static struct platform_driver dwc3_qcom_driver = {
+	.probe		= dwc3_qcom_probe,
+	.remove		= dwc3_qcom_remove,
+	.driver		= {
+		.name	= "dwc3-qcom",
+		.pm	= &dwc3_qcom_dev_pm_ops,
+		.of_match_table	= dwc3_qcom_of_match,
+	},
+};
+
+module_platform_driver(dwc3_qcom_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("DesignWare DWC3 QCOM Glue Driver");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

