Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-799430-1519067204-2-14439609892847729363
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
    t=1519067204; b=eSGHldve++NszoBeelIFzo1j+seYwYRuKOD8f+2L+9YYqUi
    6TshY5N6PouciwItv3Ai7pRp2JJ4n4XVB7vf9vg1R+JxglTIeVDOFz7ELDxUTk0X
    /c4zf/ItofVSKTRYcep/sSfbcCsQae9/ll0bQVImyrizSOPjgh+baxce3kJ5wJ50
    L8c1AFOb5PyaGeqNUAND7R2FScn7CieG5uzEbr4vbNM5M7BiG4AePL9NxZAxbN3b
    8ZJgRY+ilrLyi3HeKOCzCawQ7/SOh0iEDy/GzZF0S1KZ14iIXhZ+al5bvDW3G0Qi
    sB2EIH+FyUY0sEflflqpSRzjc617Ks9s1egygMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519067204; bh=Kl66i3f4oYmHJ20SAN14tZULui
    VNyvnbMgLkM3Osz9k=; b=KwmfulTDi7WRYZHfcpFzQmTO8YV05qr4QT7eK2G5xQ
    ZBoYt9SnWhYPkbJv6JwWL7G+MD10urJ6MYPhzwP3LhVKMPul6uN2MQpHHyzL3v5C
    W/isZiDXxB+pCJZ9hFti2oIRkzIrUu4OvItrs8ODeRPA/NUhBjGdG0+BdPzcDGKn
    ieXayTw8LxTOprZWa7v6b0wlApHMhGhdGl2PBi4qalJXEmZd9hFKPx9IAw6gmkVc
    3S5lrCUdRx/m6BB2tdTWPSynIe0jdl4r0i1dIwdkWGFSTstsbgOHNTU+i9q2ScBe
    wWq+ZqiwgyDUX7heMEBXY8L/2HNLuqFjIFppC8d/T4Xw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753512AbeBSTG3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 14:06:29 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44893 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753452AbeBSTG3 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 19 Feb 2018 14:06:29 -0500
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: mathias.nyman@intel.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2] xhci: Fix front USB ports on ASUS PRIME B350M-A
Date: Tue, 20 Feb 2018 03:06:21 +0800
Message-Id: <20180219190621.6632-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When a USB device gets plugged on ASUS PRIME B350M-A's front ports, the
xHC stops working:
[  549.114587] xhci_hcd 0000:02:00.0: WARN: xHC CMD_RUN timeout
[  549.114608] suspend_common(): xhci_pci_suspend+0x0/0xc0 returns -110
[  549.114638] xhci_hcd 0000:02:00.0: can't suspend (hcd_pci_runtime_suspend returned -110)

Delay before running xHC command CMD_RUN can workaround the issue.

Use a new quirk to make the delay only targets to the affected xHC.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2: Instead of doing xHC reset and disabling D3cold, a simple delay can
workaround the issue. Now both high-speed and super-speed devices work
fine with the v2 quirk.

 drivers/usb/host/xhci-pci.c | 3 +++
 drivers/usb/host/xhci.c     | 3 +++
 drivers/usb/host/xhci.h     | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 6c79037876db..9a820b3cae56 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -122,6 +122,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_AMD && usb_amd_find_chipset_info())
 		xhci->quirks |= XHCI_AMD_PLL_FIX;
 
+	if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x43bb)
+		xhci->quirks |= XHCI_SUSPEND_DELAY;
+
 	if (pdev->vendor == PCI_VENDOR_ID_AMD)
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 1eeb3396300f..d554bbd694d3 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -878,6 +878,9 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
 	clear_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
 	del_timer_sync(&xhci->shared_hcd->rh_timer);
 
+	if (xhci->quirks & XHCI_SUSPEND_DELAY)
+		usleep_range(1000, 1500);
+
 	spin_lock_irq(&xhci->lock);
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &xhci->shared_hcd->flags);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 96099a245c69..6f1f52f3cb40 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1825,6 +1825,7 @@ struct xhci_hcd {
 /* Reserved. It was XHCI_U2_DISABLE_WAKE */
 #define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	(1 << 28)
 #define XHCI_HW_LPM_DISABLE	(1 << 29)
+#define XHCI_SUSPEND_DELAY	(1 << 30)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.15.1

