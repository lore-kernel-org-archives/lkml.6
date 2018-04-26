Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2678423-1524754794-2-5678225276004698383
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roenca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524754793; b=bqh1cQrV70S76Oag0lm+vnMGejYKZ/tNVKLAkJGeIYwmQpvV+P
    O+AAz8H1N62NuCftkGantSqJgYNdu7GyOfZ/8GUlAl/eI8muE04O5RnpvDbU1f0m
    uppajfrX1Sx482JHiuN684ddxS5G6/cFv+8Pr35JU/SLoxV9VkQ8n9TSy4HzQ03Y
    xgsMp0LX3KK5x9I7DmEI1JKG+qPfoXrri4ko5Tg9rAANAAHWpr+lVi7jC/GrBsPT
    AMwCh941iXcbhbNYaKM7RvG3aI10JD1nDrCSg1mn6BfZVPhplmSXdv0zRkNcKtZg
    +dV6EP7kqyQhQGlVavR9j2ORt+PrQHCan78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524754793; bh=zlIP/l/IjENlVJX6j940uh82kHkrId
    CRPYNOat5jCF0=; b=RwejwCuz7mXTMx6A7drgkiREKL004hrrPq8ePMYncdpk6x
    qUlEaJ5aJVl21gjr9+F2nhYD2oaeYvTzYxcG5Zh9tA1Nz1LRE2HqOM7O4K+9AHZ/
    KP5J0/2GjTEPwKbECZ2BpCV5URY8UXl2aOSGn7I4139AncZ7VWHeaymk28CICYX1
    8oAes/6u40SnDZkT094tJyN0R9ekCavS45FAzY5eOqWWBAHgzpgs9QWJg26w2X2m
    eTfs3VUb7PAfRDaZz03vkADw9sUDPjM3NsbFWDaRkoKapsZ02tSs3ICvG6joMu8l
    hYY9jpureCYzL/K+154QCbpoAsIebn7HEXSnEusw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCWtLoutpa49oYBgiqcAV7omrLaOcfLx9JkNC+wELkvH9eHO3QWllqMe9jwF5ksUd3qDdGtzFPeaMC1PWBjLh8UzcLXlAyQncVA7AyY8O9y5QPkCUol+
    /8f0hMTTVfzUfRorfdNHBsfDohoqU7Bfu3klF+d8UQ/XOf0MDc3PkPjpLy0SMkgUu+LvZ8KQYTUN2rwOoMci4qvnmY2TfdiT9+JUYQmMAQXrwLYGBLFDvUjq
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=Ikd4Dj_1AAAA:8
    a=VwQbUJbxAAAA:8 a=Ch3Ck8TMq-kCToSH7SYA:9 a=XZzrf8N19TPl_mR_:21
    a=TpYoeOA1Iz-gLo8k:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756670AbeDZO7Y (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 10:59:24 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1809 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756613AbeDZO7T (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 26 Apr 2018 10:59:19 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 26 Apr 2018 07:59:19 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC: <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 2/3] usb: xhci: tegra: Add runtime PM support
Date: Thu, 26 Apr 2018 15:59:09 +0100
Message-ID: <1524754750-3633-2-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524754750-3633-1-git-send-email-jonathanh@nvidia.com>
References: <1524754750-3633-1-git-send-email-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add runtime PM support to the Tegra XHCI driver and move the function
calls to enable/disable the clocks, regulators and PHY into the runtime
PM callbacks.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---

Changes since V1:
- Re-worked change to handle case where runtime PM is disabled.

 drivers/usb/host/xhci-tegra.c | 89 ++++++++++++++++++++++++++++++-------------
 1 file changed, 63 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 02b0b24faa58..85f2381883ad 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -18,6 +18,7 @@
 #include <linux/phy/tegra/xusb.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
@@ -761,6 +762,50 @@ static void tegra_xusb_phy_disable(struct tegra_xusb *tegra)
 	}
 }
 
+static int tegra_xusb_runtime_suspend(struct device *dev)
+{
+	struct tegra_xusb *tegra = dev_get_drvdata(dev);
+
+	tegra_xusb_phy_disable(tegra);
+	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
+	tegra_xusb_clk_disable(tegra);
+
+	return 0;
+}
+
+static int tegra_xusb_runtime_resume(struct device *dev)
+{
+	struct tegra_xusb *tegra = dev_get_drvdata(dev);
+	int err;
+
+	err = tegra_xusb_clk_enable(tegra);
+	if (err) {
+		dev_err(dev, "failed to enable clocks: %d\n", err);
+		return err;
+	}
+
+	err = regulator_bulk_enable(tegra->soc->num_supplies, tegra->supplies);
+	if (err) {
+		dev_err(dev, "failed to enable regulators: %d\n", err);
+		goto disable_clk;
+	}
+
+	err = tegra_xusb_phy_enable(tegra);
+	if (err < 0) {
+		dev_err(dev, "failed to enable PHYs: %d\n", err);
+		goto disable_regulator;
+	}
+
+	return 0;
+
+disable_regulator:
+	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
+disable_clk:
+	tegra_xusb_clk_disable(tegra);
+	return err;
+}
+
+
 static int tegra_xusb_load_firmware(struct tegra_xusb *tegra)
 {
 	unsigned int code_tag_blocks, code_size_blocks, code_blocks;
@@ -1067,22 +1112,15 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	 */
 	platform_set_drvdata(pdev, tegra);
 
-	err = tegra_xusb_clk_enable(tegra);
-	if (err) {
-		dev_err(&pdev->dev, "failed to enable clocks: %d\n", err);
-		goto put_usb2;
-	}
+	pm_runtime_enable(&pdev->dev);
+	if (!pm_runtime_enabled(&pdev->dev))
+		err = pm_runtime_get_sync(&pdev->dev);
+	else
+		err = tegra_xusb_runtime_resume(&pdev->dev);
 
-	err = regulator_bulk_enable(tegra->soc->num_supplies, tegra->supplies);
-	if (err) {
-		dev_err(&pdev->dev, "failed to enable regulators: %d\n", err);
-		goto disable_clk;
-	}
-
-	err = tegra_xusb_phy_enable(tegra);
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to enable PHYs: %d\n", err);
-		goto disable_regulator;
+		dev_err(&pdev->dev, "failed to enable device: %d\n", err);
+		goto disable_rpm;
 	}
 
 	tegra_xusb_ipfs_config(tegra, regs);
@@ -1090,7 +1128,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	err = tegra_xusb_load_firmware(tegra);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to load firmware: %d\n", err);
-		goto disable_phy;
+		goto put_rpm;
 	}
 
 	tegra->hcd->regs = tegra->regs;
@@ -1100,7 +1138,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	err = usb_add_hcd(tegra->hcd, tegra->xhci_irq, IRQF_SHARED);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to add USB HCD: %d\n", err);
-		goto disable_phy;
+		goto put_rpm;
 	}
 
 	device_wakeup_enable(tegra->hcd->self.controller);
@@ -1155,13 +1193,11 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	usb_put_hcd(xhci->shared_hcd);
 remove_usb2:
 	usb_remove_hcd(tegra->hcd);
-disable_phy:
-	tegra_xusb_phy_disable(tegra);
-disable_regulator:
-	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
-disable_clk:
-	tegra_xusb_clk_disable(tegra);
-put_usb2:
+put_rpm:
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		tegra_xusb_runtime_suspend(&pdev->dev);
+disable_rpm:
+	pm_runtime_disable(&pdev->dev);
 	usb_put_hcd(tegra->hcd);
 put_padctl:
 	tegra_xusb_padctl_put(tegra->padctl);
@@ -1181,9 +1217,8 @@ static int tegra_xusb_remove(struct platform_device *pdev)
 	dma_free_coherent(&pdev->dev, tegra->fw.size, tegra->fw.virt,
 			  tegra->fw.phys);
 
-	tegra_xusb_phy_disable(tegra);
-	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
-	tegra_xusb_clk_disable(tegra);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	tegra_xusb_padctl_put(tegra->padctl);
 
@@ -1211,6 +1246,8 @@ static int tegra_xusb_resume(struct device *dev)
 #endif
 
 static const struct dev_pm_ops tegra_xusb_pm_ops = {
+	SET_RUNTIME_PM_OPS(tegra_xusb_runtime_suspend,
+			   tegra_xusb_runtime_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(tegra_xusb_suspend, tegra_xusb_resume)
 };
 
-- 
2.7.4

