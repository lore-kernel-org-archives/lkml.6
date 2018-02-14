Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3258100-1518626152-2-2073031504263934392
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518626152; b=wDqt8D5p4KuHmaiPx62NwL/RokL9+M/pre2QbklhzoOsIoD
    rv/T8WO5Ic/0C3stbWwOBD4KjaLEIQT1kGdMsgLFkNjOSbLBVra2/3a6kkElj288
    yeh9E/FZUCE1L3dIBCoWSON9SMWEYZNsqz8yV92BOLhCOVL+wJVU72OkfvolpFXw
    9yhe8XrMXnONolSTZUctnwcCYfZJnuloncC/ZAbXog/Au7I/nDwMScY8DRSVkcAl
    LMArAYw5bjHM7diD6b2ZiLplraLUYeMmTL6I2mf8nSYhXjM3fWUAuipW0Kkz3skI
    PNyJt2FJjp5rz0eOzoCuWCtKH1QsiSlvXhQUMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1518626152; bh=CICDW8OtaPkPcV6Z3/C1ztQkRcyE5dn+eqIRwjgrHYo=; b=i
    rW2EX15aDqNvIjLwpQ0HR+oewQxl5joS7kf3wXX15mLna24i7rsLOOPVSEuhU+3C
    LOS1rNtrP2HxxMsFEwz7iR1LtDkijkMLzZq6gsUhCo7lPGB7lItcsP5sgdtz+BHa
    1QulrvfBzQOGvUIyRYosjhfJTtWCXQikwFa6trk2LgUV+5KfD103KhLiFes1J9Px
    /Sy9I2mcB1PxghFaR6NPF2J4hqyGPz9Vu6B1kuM1WmME8Nf+0TyjLpfbY1DQ1nHI
    TPUqvo6KabuOaBcx4sX5hqwYYRhm++VDuUFYI4mMf0B/mAf6xSZ7yxxSZollr4/H
    tJVkF0V75aJKEY94cavYg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032654AbeBNQfE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 11:35:04 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4808 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032583AbeBNQfC (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Feb 2018 11:35:02 -0500
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 14 Feb 2018 08:35:41 -0800
From: Jon Hunter <jonathanh@nvidia.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC: <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 1/3] usb: xhci: tegra: Prepare for adding runtime PM support
Date: Wed, 14 Feb 2018 16:34:43 +0000
Message-ID: <1518626085-29102-1-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When adding runtime PM support to the Tegra XHCI driver, it is desirable
to move the function calls to enable the clocks, regulators and PHY from
the tegra_xusb_probe into the runtime PM handlers. Currently, the
clocks, regulators and PHY are all enabled before we call
usb_create_hcd() in tegra_xusb_probe(), however, we cannot call
pm_runtime_get_sync() at this point because the platform device data is
not yet initialised. Fortunately, the function usb_create_hcd() can be
called before we enable the clocks, regulators and PHY and so prepare
for adding runtime PM support, by moving the call to usb_create_hcd()
before we enable the hardware.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/usb/host/xhci-tegra.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 2c076ea80522..02b0b24faa58 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1054,10 +1054,23 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 		}
 	}
 
+	tegra->hcd = usb_create_hcd(&tegra_xhci_hc_driver, &pdev->dev,
+				    dev_name(&pdev->dev));
+	if (!tegra->hcd) {
+		err = -ENOMEM;
+		goto put_padctl;
+	}
+
+	/*
+	 * This must happen after usb_create_hcd(), because usb_create_hcd()
+	 * will overwrite the drvdata of the device with the hcd it creates.
+	 */
+	platform_set_drvdata(pdev, tegra);
+
 	err = tegra_xusb_clk_enable(tegra);
 	if (err) {
 		dev_err(&pdev->dev, "failed to enable clocks: %d\n", err);
-		goto put_padctl;
+		goto put_usb2;
 	}
 
 	err = regulator_bulk_enable(tegra->soc->num_supplies, tegra->supplies);
@@ -1080,19 +1093,6 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 		goto disable_phy;
 	}
 
-	tegra->hcd = usb_create_hcd(&tegra_xhci_hc_driver, &pdev->dev,
-				    dev_name(&pdev->dev));
-	if (!tegra->hcd) {
-		err = -ENOMEM;
-		goto disable_phy;
-	}
-
-	/*
-	 * This must happen after usb_create_hcd(), because usb_create_hcd()
-	 * will overwrite the drvdata of the device with the hcd it creates.
-	 */
-	platform_set_drvdata(pdev, tegra);
-
 	tegra->hcd->regs = tegra->regs;
 	tegra->hcd->rsrc_start = regs->start;
 	tegra->hcd->rsrc_len = resource_size(regs);
@@ -1100,7 +1100,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	err = usb_add_hcd(tegra->hcd, tegra->xhci_irq, IRQF_SHARED);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to add USB HCD: %d\n", err);
-		goto put_usb2;
+		goto disable_phy;
 	}
 
 	device_wakeup_enable(tegra->hcd->self.controller);
@@ -1155,14 +1155,14 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	usb_put_hcd(xhci->shared_hcd);
 remove_usb2:
 	usb_remove_hcd(tegra->hcd);
-put_usb2:
-	usb_put_hcd(tegra->hcd);
 disable_phy:
 	tegra_xusb_phy_disable(tegra);
 disable_regulator:
 	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
 disable_clk:
 	tegra_xusb_clk_disable(tegra);
+put_usb2:
+	usb_put_hcd(tegra->hcd);
 put_padctl:
 	tegra_xusb_padctl_put(tegra->padctl);
 	return err;
-- 
2.7.4

