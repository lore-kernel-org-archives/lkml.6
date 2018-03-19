Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2953273-1521468564-2-10737120118226292780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521468563; b=IX+NpTpr11WapW6u4IUpI18HXFAkToRjn/hzJOvmwhJq9VE
    Ab9o6Efm5Ip2DUcXUlNNeOAQ11ud8fP5YT4tWWcSrIt6wlWoHVvKSPMPTBMBatai
    BRlhtItOZGwUzK1xy5JQOYJ10yiZKtQRd4GP6oKefDWlVE0qgay9eircbY3VhJaa
    0MYD0lmXmCha9WgHZqq58dmk3MMb8fj+5d3OlRYqgD4fxXVB05xqEwLsuY5T+jgx
    GlJXWOMQ3/spHXx5ORpskA9QwcBid/QWB/FeYUx1HTPphIC6839f6zObGLl9Hg6P
    1ySRl5trRDah7iM/nkpsHLAFECZagZyZpwpRqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521468563; bh=6WEnr7M7TcRIiYQktYlHJgsP9g
    GPnTAp7LBxD6Pkl+M=; b=rrpfFgEyLNt9/WQfmPUv3l6WIwVGLZJMvi3LnRy1Rz
    2SatejJXjUl3KLdHdsOqWjDnvtTWb5XlVWof8n9fvTGDREF+kJPyDV6BP9CBMBjB
    cKGrq1VgO6lzissbUh1hIj3AfCnISHk72pjUA5Rh4RhXaYXfmUe8XKUuXOnHKUZR
    KdQ9lWZvH/sIa427G3M1PjZvsdvzijUQ1vD5Da17jM3h0U3xzLMFxFgw7itwmVSo
    3ma+bThaz+5eoAdgejBsQxjN31aJzdywEkeXXtH9SxOTlT6G69vpXzvcnoG6zTw1
    wtOBaZoINCjxBuyy5rX9dtc1Zwbj4bs/ls2su2Q/huKw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdehkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofhsphejsedttdertdertddtnecuhfhrohhmpefmrghiqdfjvghnghcuhfgvnhhguceokhgrihdrhhgvnhhgrdhfvghnghestggrnhhonhhitggrlhdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedpuddugedrfedvrddutdekrdduudejnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfeduheejnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdehkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofhsphejsedttdertdertddtnecuhfhrohhmpefmrghiqdfjvghnghcuhfgvnhhguceokhgrihdrhhgvnhhgrdhfvghnghestggrnhhonhhitggrlhdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedpuddugedrfedvrddutdekrdduudejnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfeduheejnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754380AbeCSOJU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 10:09:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60447 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754216AbeCSOJT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 10:09:19 -0400
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: bhelgaas@google.com
Cc: rafael.j.wysocki@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] PCI / PM: Always check PME wakeup capability for runtime wakeup support
Date: Mon, 19 Mar 2018 22:09:10 +0800
Message-Id: <20180319140910.26496-1-kai.heng.feng@canonical.com>
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

Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct dev_pm_info")
Cc: stable@vger.kernel.org # 4.13+
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
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
