Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886210-1522227302-2-14308600774103152126
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
    t=1522227301; b=J1oUmmfbRPCMsvdRoQ62+wu0pJqsH9FfN76CaHCA4zZhpw4
    LO6FukXL+ExJFRYTsirwLVOLyhp1tJZSPU3lj2qfErMLZPKDZhXmMnW+8q0AjXfW
    0VXXxVJsYBa/AgovRA2Y9mMILidUZS3XbJsyWjN53wee+FF7Fn85Y43CR8H5BD8b
    WOjFrz3rHTc0UeIcRHJWmhoBQuouTdMG5q/bxMNYbKM4Lc04ZT127SYRjDO1TEMY
    TbuXeWFfdV5d/X5cRin/OoWkqOYSxDN1JNMRYTDCJGgcRYnHGm30AIZUm6M6jVwk
    /m/MWXFU46OV8MYPS3LexghZwgYv8DD2OwtGGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1522227301; bh=ebAzNwrytD/Jm7ibYCp6FMNSY8
    kjl93ZhULkyuofghg=; b=N4Q1C1u0L5Rpe9NxK9qCxxmS8sO+Aogp58zZN3oifK
    9kbJM2GQsK9P/TA4CeyTj6MP35l2iz7h6FLuE2jqnArWwKcKfhGDiVWSqxtbcQlv
    b9Bj+njo4/BsbW/DbWbPJ/UfiFHw4q++AXyjlHft+dQpuqzLIbmOn8sPRdVakQI5
    Vw7G9T4sk2XKAz0XUBMrPqhdr5qe4hEBzmssQ+Cc10tUGVvHXUcMa6t91q7/rYcS
    nqfWaOY1e1jA9tPBnzX9/WNuJPxyp2aMfBPT2hSWninNPp5uiWNttS4j+bHNxlMP
    0IJP+cn9sD7kBWg0uanRVpogZMPEavNNkuCsAafCL7hQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HsxEq2zX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hZRf74Z0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HsxEq2zX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hZRf74Z0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJnEyVBwjfQy4LjvV/iHz8zaajqM7Mwt59EDyghEsuTwydOCrvyhgxEYWHLszMxM4zGABWVsk/EEAlYYQpZoMotvtx6CetFpdHpYoX/xsE/wNNmtwZ04
    x28gquNBhu6YpWkZF6ik43aC9fDz714aTwPTTHXQvtHmeEcpPjHgoUGM/9oYzhrD4B/3qhHB7aAQWMaIqQdCGqtzdPKE2oRo8zbORAAc4bekhf0hDdi5Hwdn
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=1_nJWWfMPkEA:10
    a=v2DPQv5-lfwA:10 a=Ikd4Dj_1AAAA:8 a=YK21wPc2RTuw9_-bKx4A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbeC1Iyn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 04:54:43 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39962 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeC1Iyl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 04:54:41 -0400
X-Google-Smtp-Source: AIpwx4+tLKuSXSpb0BMm6POz4rNtTFvVYPWUcdXlVILuJGxzJtktzRwX+e+DU6yxSrdatgjfudR68w==
From: Aniruddha Banerjee <aniruddha.nitd@gmail.com>
To: marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc: aniruddhab@nvidia.com, stable@vger.kernel.org, vipink@nvidia.com,
        strasi@nvidia.com, swarren@nvidia.com, jonathanh@nvidia.com,
        talho@nvidia.com, treding@nvidia.com,
        Aniruddha Banerjee <aniruddha.nitd@gmail.com>
Subject: [PATCHv3] irqchip: arm-gic: take gic_lock when updating irq type
Date: Wed, 28 Mar 2018 14:24:30 +0530
Message-Id: <20180328085430.3401-1-aniruddha.nitd@gmail.com>
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

Signed-off-by: Aniruddha Banerjee <aniruddhab@nvidia.com>
---
Changes from V1:

* Moved the spinlock from irq-gic to irq-gic common, so that the fix
is valid for GIC v1/v2/v3.

Change from V2:

* Fixup the Signed-off-by line.

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
