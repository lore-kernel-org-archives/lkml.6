Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-272202-1525673508-2-9413865133648179812
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525673508; b=JQKEL9yIG6Dpc12UL6T9jeivuzaLlrnovusdR8ATUgqY2oaqpe
    NzpaO2fh31T1vWTlkwJd+cSvT1Zho5uqm4fqMPI7H5Ju4Z2NMP1DgZzacy4NBj1I
    nQq7e6HPGnHlZU45ahVLmdIK/Ea1aarFocGqsJLROsZ5oIAorkQFS8gY7x7HzxRl
    v5jFyZd3LDDYQY3yU47xT0A3vNG//zAamDX79zQDm3sB4/lQ+dNUle6BEahBnI3B
    jSwhPry+tka81fJPxfJzB/xe1fde50H/nL162ihOZsZXwz5mGTwXBqqbymunr+9b
    sRmX7G8c7UsZRF3jj1YsKMJDGK44WRcnOfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525673508; bh=KCsLvHVlGR2u9D4uVCNYakXZs2C0RE
    MuM4hmx6S4rgg=; b=AIO2J/AFJCuafs6bmnNH9f9m0I4VH0e/uq0X1tWBW0c7qz
    1NcE9MG/3iHAXHWhfAC2P/VkPBZNVnElQYoFfVkxtkiGKGJid2YRexQ+YHu4pOOT
    wKZChLyESB8Ii8dLEbXJvlTZTZQ1h5JY5waScbsL6uDNkuo425AenRZzRWNDUiEr
    2eOWhUQQPpSI+p+osiSIXeHKxpl+7kHEqZ5nLDmlkH2/W6rLfCLrXBSY+7PMzUWP
    fKPh4rL7KYAUr/ei/gUN2ZHJen1AUuZ7UYZMHKpt/htR5Ue14YTJfq6xXY7I5tkU
    VKdx/ErDzeq68kfJwBsje3hLh7HyFGfV01Ju1dfQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=canonical.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=canonical.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEWcHiYytBrvisv1vVSrUH7EzdnmBZjDRmz8WnDzkhVzOuJOXQc3Bet03ApOX3fRYID9y8qYXWkNQ9KJE3xYYevQQFC5KC64DSS/Z3NDalnNytU6R+1x
    eZQH/a0PvkyiLmF0Io4tYu9AMZ2VqMMgLEXMP4fYEmvKW9EZLWJUVQWFDudnWHVcEcu61FeUkQySwthiRS6/Nx819RnT+KnG3Kx63mn77FG0l/qvACeOv/27
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=DfNHnWVPAAAA:8 a=YQl0GWw6Zf5YOcMYI_UA:9 a=AjGcO6oz07-iQ99wixmX:22
    a=rjTVMONInIDnV1a_A2c_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750953AbeEGGLd (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 02:11:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37565 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeEGGLc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 May 2018 02:11:32 -0400
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: bhelgaas@google.com, rafael.j.wysocki@intel.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        stable@vger.kernel.org
Subject: [PATCH v4] PCI / PM: Always check PME wakeup capability for runtime wakeup support
Date: Mon,  7 May 2018 14:11:20 +0800
Message-Id: <20180507061120.3683-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
core: Drop run_wake flag from struct dev_pm_info").

The device in question is not power managed by platform firmware,
furthermore, it only supports PME# from D3cold:
Capabilities: [78] Power Management version 3
       Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
       Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

Before commit de3ef1eb1cd0, the device never gets runtime suspended.
After that commit, the device gets runtime suspended to D3hot, which can
not generate any PME#.

usb_hcd_pci_probe() unconditionally calls device_wakeup_enable(), hence
device_can_wakeup() in pci_dev_run_wake() always returns true.

So pci_dev_run_wake() needs to check PME wakeup capability as its first
condition.

In addition, change wakeup flag passed to pci_target_state() from false
to true, because we want to find the deepest state that the device can
still generate PME#. In this case, it's D0 for the device in question.

Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct dev_pm_info")
Cc: stable@vger.kernel.org # 4.13+
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v4: Correct some errors in commit log.

v3: State the reason why the wakeup flag gets changed.

v2: Explicitly check dev->pme_support.

 drivers/pci/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a04197ce767d..c2616cad3a1d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2138,16 +2138,16 @@ bool pci_dev_run_wake(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
 
-	if (device_can_wakeup(&dev->dev))
-		return true;
-
 	if (!dev->pme_support)
 		return false;
 
 	/* PME-capable in principle, but not from the target power state */
-	if (!pci_pme_capable(dev, pci_target_state(dev, false)))
+	if (!pci_pme_capable(dev, pci_target_state(dev, true)))
 		return false;
 
+	if (device_can_wakeup(&dev->dev))
+		return true;
+
 	while (bus->parent) {
 		struct pci_dev *bridge = bus->self;
 
-- 
2.17.0
