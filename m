Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2903400-1520937470-2-8982876908528818619
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520937469; b=SZO8S+gV2+1GNc7wndUIOMkRN4hGhelV9afVgogO0sBif43
    MMOHW56iSb7Dqqeg4sYwza4+yjRAtUf5L6840vMhlw1uc4j3m8yhVBhyzfT5+6SA
    nWdNAOMV4qqMSBDV9Njh16Q0zR/5kLGL1CxbUw46BuTND7DBoksNMEBNQ9Oq6N/t
    qT4LkskwahMkYqCR0l8LPCD8FvunNeupPuWdPsJ2gntoD9uKRG47ML2t6PN9qo4v
    2LybfmUzxGxfkbA7+yo3o/G2JCjitKeEo27iitmDFu4vOeiWon57fhhKuI8gQi4e
    6BA5ek87xbJemop9K96A9vdo7A8ka0fNd/XTSFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520937469;
    bh=ZDwupNuyR4HGTOEqI1HvzykEqfdntPxyBwOmmcuVcUw=; b=GHxTftocE907
    w0EP0NAZRp6UmYoPg3/MJK/RdDmUBDOr1+hmQGMc6Z+KNp+0xlY6qVRAUTRSvM+b
    kYiCB3682RC563ikYBeEfkGNxynF+FXCdpzg6XoQ2xY1KfEj+PiKf+EX9+2WSMzc
    WX5zFNrSlCBdXIPEjitIoo8XFgKcgXLisvBx2MkpxC0kCRkjCYlQu5ea1GXFTHD1
    L9T2GVaT69VTGCz1d/deBdQLzf/+1LdV8jNiFz4GJkqEr3WPg/uDeWChCoabLDR7
    cqkYdWM1mGhTri6JycIM/JhlWJtiV5kYyBu74OlZYZAdbdNTELms7Li2wgOCTolM
    qAfw76WyOQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=avc8yCvf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=lQH8WxEO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=avc8yCvf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=lQH8WxEO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932838AbeCMKg0 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 06:36:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43854 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932489AbeCMKgU (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 13 Mar 2018 06:36:20 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CAB156070A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: Felipe Balbi <balbi@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 2/2] usb: dwc3: Add Qualcomm DWC3 glue driver
Date: Tue, 13 Mar 2018 16:06:01 +0530
Message-Id: <1520937362-28777-2-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520937362-28777-1-git-send-email-mgautam@codeaurora.org>
References: <1520937362-28777-1-git-send-email-mgautam@codeaurora.org>
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
 - pwr_events_irq_stat support to ensure USB2 PHY is in L2 state
   before glue driver can turn-off clocks and suspend PHY.
 - Support for wakeup interrupts lines that are asserted whenever
   there is any wakeup event on USB3 or USB2 bus.
 - Support to replace pip3 clock going to DWC3 with utmi clock
   for hardware configuration where SSPHY is not used with DWC3.

Other than above hardware features in Qscratch wrapper there
are some limitations on QCOM SOCs that require special handling
of power management e.g. suspending PHY using GUSB2PHYCFG
register and ensuring PHY enters L2 before turning off clocks etc.

Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
---
 drivers/usb/dwc3/Kconfig          |  11 +
 drivers/usb/dwc3/Makefile         |   1 +
 drivers/usb/dwc3/dwc3-of-simple.c |   1 -
 drivers/usb/dwc3/dwc3-qcom.c      | 635 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 647 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/dwc3/dwc3-qcom.c

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index ab8c0e0..f5bb4f1 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -106,4 +106,15 @@ config USB_DWC3_ST
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
+
+	  Say 'Y' or 'M' if you have one such device.
+
 endif
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index 7ac7250..c3ce697 100644
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
index 0000000..917199e
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -0,0 +1,635 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * Inspired by dwc3-of-simple.c
+ */
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
+#include "io.h"
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
+#define HSPHY_L2_ENTER_TIMEOUT_US		5000
+
+struct dwc3_qcom {
+	struct device		*dev;
+	void __iomem		*qscratch_base;
+	struct platform_device	*dwc3;
+	struct clk		**clks;
+	int			num_clocks;
+	struct reset_control	*resets;
+
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
+	dev_dbg(qcom->dev, "vbus:%ld event received\n", event);
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
+	dev_dbg(qcom->dev, "host:%ld event received\n", event);
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
+	if (IS_ERR(qcom->host_edev)) {
+		qcom->host_edev = NULL;
+		dev_info(dev, "No separate ID/host extcon device\n");
+	}
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
+	/* Update initial VBUS override state from extcon */
+	if (extcon_get_state(qcom->edev, EXTCON_USB) ||
+	    !extcon_get_state(host_edev, EXTCON_USB_HOST))
+		dwc3_qcom_vbus_notifier(&qcom->vbus_nb, true, qcom->edev);
+
+	return 0;
+}
+
+static void dwc3_qcom_suspend_hsphy(struct dwc3_qcom *qcom)
+{
+	struct dwc3	*dwc = platform_get_drvdata(qcom->dwc3);
+	int		ret;
+	u32		val;
+
+	/* Clear previous L2 events */
+	dwc3_qcom_setbits(qcom->qscratch_base, PWR_EVNT_IRQ_STAT_REG,
+			  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
+
+	/* Allow controller to suspend HSPHY */
+	val = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	val |=  DWC3_GUSB2PHYCFG_ENBLSLPM | DWC3_GUSB2PHYCFG_SUSPHY;
+	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), val);
+
+	/* Wait for PHY to go into L2 */
+	ret = readl_poll_timeout(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG,
+				 val, (val & PWR_EVNT_LPM_IN_L2_MASK), 100,
+				 HSPHY_L2_ENTER_TIMEOUT_US);
+	if (ret)
+		dev_err(qcom->dev, "could not transition HS PHY to L2\n");
+
+	/* Clear L2 event bit */
+	dwc3_qcom_setbits(qcom->qscratch_base, PWR_EVNT_IRQ_STAT_REG,
+			  PWR_EVNT_LPM_IN_L2_MASK);
+}
+
+static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
+{
+	struct dwc3	*dwc = platform_get_drvdata(qcom->dwc3);
+	int		 i;
+
+	if (qcom->is_suspended)
+		return 0;
+
+	if (!dwc)
+		return -EBUSY;
+
+	dwc3_qcom_suspend_hsphy(qcom);
+
+	if (dwc->usb2_generic_phy)
+		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
+	if (dwc->usb3_generic_phy)
+		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
+
+	for (i = qcom->num_clocks - 1; i >= 0; i--)
+		clk_disable_unprepare(qcom->clks[i]);
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
+
+	qcom->is_suspended = true;
+	dev_dbg(qcom->dev, "DWC3 in low power mode\n");
+
+	return 0;
+}
+
+static int dwc3_qcom_resume(struct dwc3_qcom *qcom)
+{
+	struct dwc3	*dwc = platform_get_drvdata(qcom->dwc3);
+	int		i, ret;
+	u32		val;
+
+	if (!qcom->is_suspended)
+		return 0;
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
+	if (dwc->usb2_generic_phy)
+		phy_pm_runtime_get_sync(dwc->usb2_generic_phy);
+	if (dwc->usb3_generic_phy)
+		phy_pm_runtime_get_sync(dwc->usb3_generic_phy);
+
+	/* Disable HSPHY auto suspend */
+	val = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	val &= ~(DWC3_GUSB2PHYCFG_ENBLSLPM | DWC3_GUSB2PHYCFG_SUSPHY);
+	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), val);
+
+	qcom->is_suspended = false;
+
+	dev_dbg(qcom->dev, "DWC3 exited from low power mode\n");
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
+	dwc3_qcom_resume(qcom);
+
+	if (dwc->xhci) {
+		dev_dbg(qcom->dev, "%s: resuming xhci\n", __func__);
+		pm_runtime_resume(&dwc->xhci->dev);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void dwc3_qcom_select_utmi_clk(struct dwc3_qcom *qcom)
+{
+	/* Configure mux to use UTMI clock since PIPE clock not present */
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
+	struct dwc3_qcom	*qcom;
+	struct resource		*res;
+	int			irq, ret, i;
+	bool			ignore_pipe_clk;
+
+	qcom = devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
+	if (!qcom)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, qcom);
+	qcom->dev = &pdev->dev;
+
+	qcom->resets = of_reset_control_array_get_optional_exclusive(np);
+	if (IS_ERR(qcom->resets)) {
+		ret = PTR_ERR(qcom->resets);
+		dev_err(&pdev->dev, "failed to get resets, err=%d\n", ret);
+		return ret;
+	}
+
+	ret = reset_control_deassert(qcom->resets);
+	if (ret)
+		goto reset_put;
+
+	ret = dwc3_qcom_clk_init(qcom, of_clk_get_parent_count(np));
+	if (ret) {
+		dev_err(qcom->dev, "failed to get clocks\n");
+		goto reset_assert;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qscratch");
+	qcom->qscratch_base = devm_ioremap_resource(qcom->dev, res);
+	if (IS_ERR(qcom->qscratch_base)) {
+		dev_err(qcom->dev, "failed to map qscratch - %d\n", ret);
+		ret = PTR_ERR(qcom->qscratch_base);
+		goto clk_disable;
+	}
+
+	irq = platform_get_irq_byname(pdev, "hs_phy_irq");
+	if (irq > 0) {
+		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
+					qcom_dwc3_resume_irq,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"qcom_dwc3 HS", qcom);
+		if (ret) {
+			dev_err(qcom->dev, "hs_phy_irq failed: %d\n", ret);
+			goto clk_disable;
+		}
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
+			goto clk_disable;
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
+			goto clk_disable;
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
+			goto clk_disable;
+		}
+		qcom->ss_phy_irq = irq;
+	}
+
+	dwc3_np = of_get_child_by_name(np, "dwc3");
+	if (!dwc3_np) {
+		dev_err(qcom->dev, "failed to find dwc3 core child\n");
+		ret = -ENODEV;
+		goto clk_disable;
+	}
+
+	/*
+	 * Disable pipe_clk requirement if specified. Used when dwc3
+	 * operates without SSPHY and only HS/FS/LS modes are supported.
+	 */
+	ignore_pipe_clk = device_property_read_bool(qcom->dev,
+				"qcom,select-utmi-as-pipe-clk");
+	if (ignore_pipe_clk)
+		dwc3_qcom_select_utmi_clk(qcom);
+
+	ret = of_platform_populate(np, NULL, NULL, qcom->dev);
+	if (ret) {
+		dev_err(qcom->dev, "failed to register dwc3 core - %d\n", ret);
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
+	/* register extcon to override vbus later on mode switch */
+	if (qcom->mode == USB_DR_MODE_OTG) {
+		ret = dwc3_qcom_register_extcon(qcom);
+		if (ret)
+			goto depopulate;
+	} else if (qcom->mode == USB_DR_MODE_PERIPHERAL) {
+		/* enable vbus override for device mode */
+		dwc3_qcom_vbus_overrride_enable(qcom, true);
+	}
+
+	device_init_wakeup(&pdev->dev, 1);
+	qcom->is_suspended = false;
+	pm_runtime_set_active(qcom->dev);
+	pm_runtime_enable(qcom->dev);
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
+reset_put:
+	reset_control_put(qcom->resets);
+
+	return ret;
+}
+
+static int dwc3_qcom_remove(struct platform_device *pdev)
+{
+	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
+	struct device *dev = qcom->dev;
+	int i;
+
+	of_platform_depopulate(&pdev->dev);
+
+	for (i = qcom->num_clocks - 1; i >= 0; i--) {
+		clk_disable_unprepare(qcom->clks[i]);
+		clk_put(qcom->clks[i]);
+	}
+	qcom->num_clocks = 0;
+
+	reset_control_assert(qcom->resets);
+	reset_control_put(qcom->resets);
+
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
+	dev_err(dev, "dwc3-qcom PM suspend\n");
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
+	dev_err(dev, "dwc3-qcom PM resume\n");
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
+	dev_err(dev, "DWC3-qcom runtime suspend\n");
+
+	return dwc3_qcom_suspend(qcom);
+}
+
+static int dwc3_qcom_runtime_resume(struct device *dev)
+{
+	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
+
+	dev_err(dev, "DWC3-qcom runtime resume\n");
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

