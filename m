Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-774305-1521400354-2-15788393223830207693
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
    t=1521400354; b=tYyne2GGIr3FjAlHszD91Fg37Hj144bc8LbZlEdhr7uohxp
    RAJ+xpnCr8Dl3aOmaV8PBSqRHTnFQv4N4ilgLghn913giLInSG+FHHBoyaFirNpe
    IdmkYboOqTohfExR4p1jgBEe3SSn3AcvXxLywectX90MBr6d+4cWXjlGJRU204Tw
    NDpPjIjh6adsWGfE9WF3xkmuimXqAoTU12wf//DZBR/vjShRA5PKWpffnHGfN7GK
    V+ow8RlOTHm+/s+BSRuOqHJjEtjLG0jzJ7MvtNbeaLL2xG3L+XbdH2ljdIam7h9l
    0yDjLl5xpiSVYi5RI6MDIq791g/icxG0NyMoFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521400354; bh=c/r7SDE/QAHFJk6TQVQ7Ihe4C9
    AgkVnBW09jPhiG6PY=; b=IebRgssNHsTKo0l3L7n0ybNWPAl80n7CHA4zJdWw4Y
    GK4S0gFor4j/IETu0bEkXaaIQzb8ykgbAazj8BQakwlkBDVK4W2hgBggBpd8E8Uk
    M/23sSVqdyCzNHVq+v1+2fRfKJtsKTFB6RTdDBW0S7u5mjIJyi+LUIS7Rw1WHuQL
    XjREhfHMX+wQv9vkqrNTOlCeTM1m0auVMYKhCrPlkQORsbDoU+g9V1D3SK/nsdX/
    75qvi6kvNRSL4WP1xJxt4I5whpAqK/hvZIPy4cfOysSG55K6zUgYCRPwglnTGw9U
    ughW6EA9sivxyvYeqanhdbq9OWWa/tZeLVJjZhETKLow==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
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
        id S1754369AbeCRTM2 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 15:12:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46511 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754448AbeCRTMZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 15:12:25 -0400
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: bhelgaas@google.com
Cc: rafael.j.wysocki@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        stable@vger.kernel.org
Subject: [PATCH] PCI / PM: Always check PME wakeup capability for runtime wakeup support
Date: Mon, 19 Mar 2018 03:12:15 +0800
Message-Id: <20180318191215.10005-1-kai.heng.feng@canonical.com>
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

Before the commit, the device never gets runtime suspended. After the
commit, the device gets runtime suspended, so it does not respond to any
PME#.

usb_hcd_pci_probe() mandatorily calls device_wakeup_enable(), hence
device_can_wakeup() in pci_dev_run_wake() always returns true.

So pci_dev_run_wake() needs to check PME wakeup capability as its first
condition.

Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct dev_pm_info")
Cc: stable@vger.kernel.org # 4.13+
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pci.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f6a4dd10d9b0..e026d8f313ec 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2125,16 +2125,13 @@ bool pci_dev_run_wake(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
 
-	if (device_can_wakeup(&dev->dev))
-		return true;
-
-	if (!dev->pme_support)
-		return false;
-
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
