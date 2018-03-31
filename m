Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2190098-1522514446-2-14321325241391497048
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522514446; b=ldt24p+2CUlNB3YihnWqfbSyY4am21Z7Jqo7yEDwQaO7qptOXM
    rOUFD5QsooKGjFo6olyaDM8bEBI0UYiwoja2wRqXUpMHEXQvwBLv1oi6K8FMTiDr
    tUK0EaVAwXGYqnl827AlvTOC7xD8JHMqDrZWS1OFrz2UBkSqiOkoZqPOTv2tODzY
    3zielmPSjcZSZGLvnf853OKImmCOjuf9t51VsKgx4NEiCi8U9PwD4uglCNNHXZ+Z
    rzna5hAf41Dky9ls4u22ORRU6/WpdepURaChaDqgxu5tV1BUt5mpAJeRGvHeBio3
    huCPjlXMnZi+lVX/2W8U0NM1o0o88iEsDmqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1522514446; bh=ybtBpxm0oFmJZfYYHqbYLdl/5pdfjJ
    hboZDA/C3qhOc=; b=a/dm7ABooMfs7jKG/E4GTjVdLO//cdpNYuovIcPXqY38Lf
    KmrVAiLjrgfJ+Fw47A8m1dy3abjjnE4UvpYONtPzVw1Mo8AsL8cl8Ayp3jMcegeW
    TTjM95OaqpTOGhtp97cLf5SuUFjvCV5UF1rJe7fN16aJJUv6k8Hmz/xIcR8p1Nic
    eCR4FQ+ZBK100N8L6GcGpQdVwKr7quFkncNN6LHyWUavOvwwR9OchWeMC4dyBHGM
    eQFwimmCXFU2A51tQOBmzPd3uXRteYmroTq4sm3SuOJ592fWgF8k6FK76JVp2Nxe
    8MK+SDudzR510fUhYY6HF6IXPuKTyQ8zO0VB0SDA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO6vKob5n58TEVZ4bAZruTHRiOidbPm/MUlaCV1/Rg7pZZ5/71x3V479fDf2AD2Ot0mFe+BJlgsRizmT5sH/iKDKKqcsweRy0pxRXwgGxCLNFU7Qvy0s
    T9RBXQbWBnQX7f87M1S31VOAGneXJCeZLUPkAuiIS7MN6BQZhdIs44aMe0xoByAcP5nRkbGlamF0i63+Flx1RF64VbYD3U5fPqt49ZHFPoCUaIvGAVNQk3Qa
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=DfNHnWVPAAAA:8 a=YQl0GWw6Zf5YOcMYI_UA:9 a=AjGcO6oz07-iQ99wixmX:22
    a=rjTVMONInIDnV1a_A2c_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbeCaQkc (ORCPT <rfc822;greg@kroah.com>);
        Sat, 31 Mar 2018 12:40:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48746 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbeCaQkb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 31 Mar 2018 12:40:31 -0400
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: bhelgaas@google.com
Cc: rafael.j.wysocki@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        stable@vger.kernel.org
Subject: [PATCH v3] PCI / PM: Always check PME wakeup capability for runtime wakeup support
Date: Sun,  1 Apr 2018 00:40:22 +0800
Message-Id: <20180331164022.24220-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.15.1
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
After that commit, the device gets runtime suspended, so it does not
respond to any PME#.

usb_hcd_pci_probe() mandatorily calls device_wakeup_enable(), hence
device_can_wakeup() in pci_dev_run_wake() always returns true.

So pci_dev_run_wake() needs to check PME wakeup capability as its first
condition.

In addition, change wakeup flag passed to pci_target_state() from false
to true, because we want to find the deepest state that the device can
still generate PME#.

Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct dev_pm_info")
Cc: stable@vger.kernel.org # 4.13+
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3: State the reason why the wakeup flag gets changed.

v2: Explicitly check dev->pme_support.

 drivers/pci/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f6a4dd10d9b0..52821a21fc07 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2125,16 +2125,16 @@ bool pci_dev_run_wake(struct pci_dev *dev)
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
2.15.1
