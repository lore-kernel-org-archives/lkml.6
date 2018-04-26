Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2684841-1524754788-2-6298475830331303985
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524754786; b=CQgJfUdhHXoYDS40F6h2eo7Ik/wfRm3ZsNhp03Qaf3ysTCU+f/
    YngPwZeVpiTAM9OARkXYdYQkEt9kUMv5WklDn1PoauBnISRUlm4RfRbWhgpRLhmd
    9ItK4iDoQ7Tg9Ho6zzdIx9cZjwLGQPrrnferwEr/5wQDA0CtkHfVR0A8cvtKhNv0
    sMkAk0UjUaEP5fdGgZ2kMnzrFPz9yvGAQiIHn4oCL3ggWtLsqc567aExRDDWgjXP
    +9+UVFHOY7HctRPsq1Ypxa8z9YDof6xldr+QY8MifhMYdS+1ZbiX7rA4Oo7esIMv
    kjgfRQnA2mrG6g57zIHx4vOEEBRYZxEJ8ssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1524754786;
    bh=VFD5uh1QZp0EhMcrpQXHq9i7oZvdPkzcQUsEUL7282A=; b=F3jLTG6QEaKa
    +PNOFk4oQcquzctoDwA7JbtSnTQdkSBPFqOsOWs8CDyqboDeVkwPCO3Eb0G1kDAT
    JWYtJwZsli2w5uDLc/KFXmo7Ap0lLKY/gYsrp5gRicojVJeInf2blB5QM/S8Uimr
    igEY5G0w+GPSMerJA11ecI5eNqeB0oPcvgY0uvmERkxLOdCCSgbIpcp9EArluMD5
    6GbEX2YsaMX+H5nTuZh6VZsRgYKrRDJnvj+Ufbn0LswcgodRQyqA7NecAEprhL9Z
    gKwJCCXzegE9aC/UAyZIW2QByXQthVVlLHvhzA5TtuJo/A/VD47oBQCEtezWRiIB
    kikneeZDAQ==
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
X-CM-Envelope: MS4wfHaFUXqN1NUxHFuz/L/7rQ/ABYGouXk3SxK9PpsBEoHNFc59HwohTCI5+9vw0p4spBL5Muj0+EHimbI4n5gXsSahxwxLK6F53A/gPWoWUB1me8ZMo7qS
    WTwC+t/YqZx3J6htN6cYXBCxdtQz0NVdAZaZOEsYNnydOQZVHQSzA8L1dnZrsv/l6IurqXB1oUTKGqJqy0BhD2STjdBDG/hAUfOfTSPBqVE4nzFOm5MMxill
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=Ikd4Dj_1AAAA:8
    a=VwQbUJbxAAAA:8 a=-6V1eyReLdMGPuAhdLEA:9 a=izTRuUMC3c5Q45v9:21
    a=9abNnzZTqCh6LVMi:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756682AbeDZO7Z (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 10:59:25 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13566 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755861AbeDZO7S (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 26 Apr 2018 10:59:18 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 26 Apr 2018 07:59:17 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC: <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 1/3] usb: xhci: tegra: Prepare for adding runtime PM support
Date: Thu, 26 Apr 2018 15:59:08 +0100
Message-ID: <1524754750-3633-1-git-send-email-jonathanh@nvidia.com>
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

Changes since V1:
- None

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

