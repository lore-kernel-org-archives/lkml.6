Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-334625-1522179757-2-11865235143344850815
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522179756; b=ZGMSSp/TDq6tuR+4NThDOHsxp/a+AJ2S69kjlPitPPhdKgK
    OyJ1wuzaYsaK2mAEhkK0MGPFg1Vkmy1gEpK7dVnwZESmBI4zCVDujm84UvON/bt1
    rzr9VdihzLayFU69++CdyZLmI2WqixMcn5P5SIURQA+tEcIIadpKHnRIPkJXgK0+
    BtIFpTebB06iynhaNH1LnotOMaijvDVxDQJ5HIjiJpuLHmHMbaaYAGc3TzbGL+C3
    wo4GiD84i8WT7Ilc1mx+J4nEBcverHgyAT4YIHnxNrtZH6RYWaCjOYhXTgNbfxhd
    hVK/YXgaly+4ttisJGfw3cNe9Xtcj9uTWtgoEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1522179756; bh=z1/2AZku/8gI6gRBQtKnRNMsqj
    a5iYw0ROr6bkiwhJM=; b=wvBgIj86NdhXzr+W6epU+uktUgoS11yQHz8WKhhYOa
    QCF6/WX0qC68P7rmFfzk4et8YyRE5RsuBrv/Gi42bet2muFtj/0PaNE/D/AW5h2H
    nJWqLavNMbKMEH+cEcF5SpWfYe4gIYPJyhVmZgHfgsOOy7hPOK2tnPwdco43OgPG
    PLkLP59HEY1atPYLnibyrdj2/Z9G7DqB64FYrSW7mRn3nevaXtLhdAXH5O5PvFC9
    35FRic063iuqoGap3Ws1EEWEZ/HW15ecqp0T8cTtlZxv4jwVxvojLVKBE0lkTpVc
    +i1h6Vdj46mclx4WmNAAyCEwCNtQury/ZeXVeJfVmyEw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=oRcB9iEo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fTaULcUz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=oRcB9iEo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fTaULcUz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCGm83S57LdZpQPF9OJu1oil2M15OdvBurgEOhPAmYjTBaeyxx4wePvIecKz82Msp93UrSqAV50SDPkpEQ7AlXbQ9gM8jHklZm83xlr8P0VM/RMo0UvD
    vegZQnFJZ+sdVABaYNsjwE4fNo5ziZtOsbth+ZoNkA0sHAfBbjpcuCEXeoT8S0JrmLXMld26J1jTF6kXepmuaRMZqfP2iWI2nAtIKe5bLKY4v+xmzzBH9nzH
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=1_nJWWfMPkEA:10
    a=v2DPQv5-lfwA:10 a=pGLkceISAAAA:8 a=60Y6rGfBIE3TyaUmvnIA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751088AbeC0TmV (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 15:42:21 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42038 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbeC0TmT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 15:42:19 -0400
X-Google-Smtp-Source: AIpwx48vc9URDXkM6QguWtANtNyC94HLib2P9iHX+wU0Tfh8RvHmwy+6qYHLaOPi6ExVkO1Rd0C6EA==
From: Aniruddha Banerjee <aniruddha.nitd@gmail.com>
To: marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc: aniruddhab@nvidia.com, stable@vger.kernel.org, vipink@nvidia.com,
        strasi@nvidia.com, swarren@nvidia.com, jonathanh@nvidia.com,
        talho@nvidia.com, treding@nvidia.com,
        Aniruddha Banerjee <aniruddha.nitd@gmail.com>
Subject: [PATCHv2] irqchip: arm-gic: take gic_lock when updating irq type
Date: Wed, 28 Mar 2018 01:11:58 +0530
Message-Id: <20180327194158.16127-1-aniruddha.nitd@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The kernel documentation states that the locking of the irq-chip
registers should be handled by the irq-chip driver. In the irq-gic,
the accesses to the irqchip are seemingly not protected and multiple
writes to SPIs from different irq descriptors do RMW requests without
taking the irq-chip lock. When multiple irqs call the request_irq at
the same time, there can be a simultaneous write at the gic
distributor, leading to a race. Acquire the gic_lock when the
irq_type is updated.

Signed-off-by: Aniruddha Banerjee <aniruddha.nitd@gmail.com>
---
 drivers/irqchip/irq-gic-common.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 9ae71804b5dd..73dd39959e6e 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -21,6 +21,8 @@
 
 #include "irq-gic-common.h"
 
+static DEFINE_RAW_SPINLOCK(irq_controller_lock);
+
 static const struct gic_kvm_info *gic_kvm_info;
 
 const struct gic_kvm_info *gic_get_kvm_info(void)
@@ -57,6 +59,7 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 	 * Read current configuration register, and insert the config
 	 * for "irq", depending on "type".
 	 */
+	raw_spin_lock(&irq_controller_lock);
 	val = oldval = readl_relaxed(base + GIC_DIST_CONFIG + confoff);
 	if (type & IRQ_TYPE_LEVEL_MASK)
 		val &= ~confmask;
@@ -64,8 +67,10 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 		val |= confmask;
 
 	/* If the current configuration is the same, then we are done */
-	if (val == oldval)
+	if (val == oldval) {
+		raw_spin_unlock(&irq_controller_lock);
 		return 0;
+	}
 
 	/*
 	 * Write back the new configuration, and possibly re-enable
@@ -83,6 +88,7 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 			pr_warn("GIC: PPI%d is secure or misconfigured\n",
 				irq - 16);
 	}
+	raw_spin_unlock(&irq_controller_lock);
 
 	if (sync_access)
 		sync_access();
-- 
2.16.2
