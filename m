Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3258100-1518626142-2-17595742886028336878
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518626141; b=tXVjNi3j0m5PV18WLmeczV2BQuX2Kxq9RDFUkqny8NAP/uI
    aTyrfy1ivZgS/zN/TQzP+Rc8X/Yk1/sDcb7SkrLW/hhILhrB6YFiSRqdLvKZbMxf
    KOYdbsyEpysUuL3TOtxDssAiOCPp4uBrU5hPbz75xriWb/dAg2NEprqu87JajTEP
    bexXx8l2/p7aaecEHFei7/8jEfXSVhCH8BSURNAD/rONPqbV63NyretpFIGgRUKc
    nqv0IyhyKQ+q7LcWqLqV8GTja7UbRcNh5y+3bbedA+vfLnuJszjLpTboHHaWXU3P
    tOJoD2zJpYakQHiyHv9oNSr0sB4iLdcXenQliyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518626141; bh=/1vjpODZrdLlQf6GzMg9kVvfX/
    pMgyPeaChDYsR9xZk=; b=LCUKVkIUtAxNAVAOHEtjQO5Dtxzhq+a3PrA2Sj8b1Z
    VxNJgmPywl0jXACBUhzjmWDZnU6y224c+Q4wSNqe2RRc087t1csMXMJxU3Ar7iLm
    OnSbEDquHkoRTRJh6SoCxKAlSbYjWIn7ExpKAYaLqLQ+ooRZxkFZPkz34E+bqPNO
    6Prv6XevB9G2Be4f5PIYHpzNnUh4J/n354BCzJSsEuY8HCnZhN67pJco/5QCZvIF
    ulN6Qt+hhlLTzDj6R8iDVQvMaTwN01kA4HxO4W15s84FJMdH2RMrMr4/EK1nXOyY
    o8Mxncx8Y8DitMGoa8XWeqPwHXJ1KNqOhZVFzR14JLow==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032686AbeBNQf0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 11:35:26 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4275 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032656AbeBNQfE (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Feb 2018 11:35:04 -0500
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 14 Feb 2018 08:35:43 -0800
From: Jon Hunter <jonathanh@nvidia.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC: <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 2/3] usb: xhci: tegra: Add runtime PM support
Date: Wed, 14 Feb 2018 16:34:44 +0000
Message-ID: <1518626085-29102-2-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518626085-29102-1-git-send-email-jonathanh@nvidia.com>
References: <1518626085-29102-1-git-send-email-jonathanh@nvidia.com>
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
 drivers/usb/host/xhci-tegra.c | 80 ++++++++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 02b0b24faa58..42aa67858b53 100644
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
@@ -1067,22 +1068,12 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	 */
 	platform_set_drvdata(pdev, tegra);
 
-	err = tegra_xusb_clk_enable(tegra);
-	if (err) {
-		dev_err(&pdev->dev, "failed to enable clocks: %d\n", err);
-		goto put_usb2;
-	}
-
-	err = regulator_bulk_enable(tegra->soc->num_supplies, tegra->supplies);
-	if (err) {
-		dev_err(&pdev->dev, "failed to enable regulators: %d\n", err);
-		goto disable_clk;
-	}
+	pm_runtime_enable(&pdev->dev);
 
-	err = tegra_xusb_phy_enable(tegra);
+	err = pm_runtime_get_sync(&pdev->dev);
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to enable PHYs: %d\n", err);
-		goto disable_regulator;
+		dev_err(&pdev->dev, "failed to enable device: %d\n", err);
+		goto disable_rpm;
 	}
 
 	tegra_xusb_ipfs_config(tegra, regs);
@@ -1090,7 +1081,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	err = tegra_xusb_load_firmware(tegra);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to load firmware: %d\n", err);
-		goto disable_phy;
+		goto put_rpm;
 	}
 
 	tegra->hcd->regs = tegra->regs;
@@ -1100,7 +1091,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	err = usb_add_hcd(tegra->hcd, tegra->xhci_irq, IRQF_SHARED);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to add USB HCD: %d\n", err);
-		goto disable_phy;
+		goto put_rpm;
 	}
 
 	device_wakeup_enable(tegra->hcd->self.controller);
@@ -1155,13 +1146,10 @@ static int tegra_xusb_probe(struct platform_device *pdev)
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
+	pm_runtime_put_sync(&pdev->dev);
+disable_rpm:
+	pm_runtime_disable(&pdev->dev);
 	usb_put_hcd(tegra->hcd);
 put_padctl:
 	tegra_xusb_padctl_put(tegra->padctl);
@@ -1181,13 +1169,55 @@ static int tegra_xusb_remove(struct platform_device *pdev)
 	dma_free_coherent(&pdev->dev, tegra->fw.size, tegra->fw.virt,
 			  tegra->fw.phys);
 
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	tegra_xusb_padctl_put(tegra->padctl);
+
+	return 0;
+}
+
+static int tegra_xusb_runtime_suspend(struct device *dev)
+{
+	struct tegra_xusb *tegra = dev_get_drvdata(dev);
+
 	tegra_xusb_phy_disable(tegra);
 	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
 	tegra_xusb_clk_disable(tegra);
 
-	tegra_xusb_padctl_put(tegra->padctl);
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
 
 	return 0;
+
+disable_regulator:
+	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
+disable_clk:
+	tegra_xusb_clk_disable(tegra);
+	return err;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1211,6 +1241,8 @@ static int tegra_xusb_resume(struct device *dev)
 #endif
 
 static const struct dev_pm_ops tegra_xusb_pm_ops = {
+	SET_RUNTIME_PM_OPS(tegra_xusb_runtime_suspend,
+			   tegra_xusb_runtime_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(tegra_xusb_suspend, tegra_xusb_resume)
 };
 
-- 
2.7.4

