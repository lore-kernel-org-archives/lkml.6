Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-103608-1521385886-5-2964335980261301399
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521385886; b=dha+QBSGh9dvtbw8IqaPSn/QxCHSJR8Vsz3jZHz1KNDWAiM
    PJyCn1/BqkT5n6Za08D4lNswxx0A3Cltw9kkzGB7PDxnp9YFv+b+DpyExgNBtyoq
    14P9wKqwRPZjQYmS56WwWoGcEdIzJ55bTNVj9IoQNwRXorQN47TTOkZfKn8H9/CF
    GYACCHY5+FjbC3Pj6zZb25+B0Jq0OwKrV3UecqCgYzLL1FBrVDdGEy3N+sMObkGb
    DjitWKcrpqW/JeVb8R9YKwfpdedwBo8bK6+OJVobF9g46XkwpdTfwAflXckTg/8R
    QhqXK2myVL7lJnKf9s7rh6sIDSV1h6aLrxxFNCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521385886; bh=vIV0pkPFhr1j+N5NGBNElwwltx
    uMm703MVYXW28o4UQ=; b=kzRWcML1iq8+YIyZnlDwdMdOB2YjmS/ZatFidq0o07
    lIW2etEySEULN7HWUPV3vq78QhIfML+DX3sMdqGLjmRdHYbZ/8bWPKKrI/AGeiLG
    dg2giVC/5GV7FJ8BSzr3tkR8cQs9Z9R06KRzkca6VaVeYnlo1o/nhD68ZgHtbL+8
    YNh0WPdn7fHlXoJ+V5rb4f4UDohPtDPq8ZzlH/tdxBer6W+jvG998dFU2d/LeK2C
    /dDJ/szy1jF0po9PbMjmIw8g+SBr5GMFHA/gprofcrA0fgdmZJjj23234ENtzVes
    qwmxX+XCmqPgYd5aCC5T2B2c4uVe5Ve4TiiOZoXMEhXw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeCRPLX (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 11:11:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44716 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbeCRPLW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 11:11:22 -0400
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: mathias.nyman@intel.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        stable@vger.kernel.org
Subject: [PATCH] xhci: Fix USB ports for Dell Inspiron 5775
Date: Sun, 18 Mar 2018 23:11:10 +0800
Message-Id: <20180318151110.15308-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.15.1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Dell Inspiron 5775 is a Raven Ridge. The Enable Slot command timed
out when a USB device gets plugged:
[ 212.156326] xhci_hcd 0000:03:00.3: Error while assigning device slot ID
[ 212.156340] xhci_hcd 0000:03:00.3: Max number of devices this xHCI host supports is 64.
[ 212.156348] usb usb2-port3: couldn't allocate usb_device

AMD suggests that a delay before xHC suspends can fix the issue.

I can confirm it fixes the issue, so use the suspend delay quirk for
Raven Ridge's xHC.

Cc: stable@vger.kernel.org
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/host/xhci-pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index d9f831b67e57..93ce34bce7b5 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -126,7 +126,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_AMD && usb_amd_find_chipset_info())
 		xhci->quirks |= XHCI_AMD_PLL_FIX;
 
-	if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x43bb)
+	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
+		(pdev->device == 0x15e0 ||
+		 pdev->device == 0x15e1 ||
+		 pdev->device == 0x43bb))
 		xhci->quirks |= XHCI_SUSPEND_DELAY;
 
 	if (pdev->vendor == PCI_VENDOR_ID_AMD)
-- 
2.15.1
