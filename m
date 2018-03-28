Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2371949-1522244545-2-3272732948263381168
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
    t=1522244544; b=NzOcgTZfXAjvWryG4Y1P8VXIvFQXWOqoqCUxzKG0Bfzt4ND
    OxKn5RoFlocnl7sexshZXdZJRHK3//wWpfJVpDyF2kfcelFphT0EuHTe7asFf1ux
    j3XsYLfgJ5pqiklIKv9+NBa525xCYvwXs+NjUEmXTo0aMZy05aXKT9BU7jZjgW6M
    9K/7eKady76SFbT5BCrvGlBayQc0AHVVSICxKz1obIPCVSGMuqlt851G65Xvi6jj
    KKnjc1LQdj0KdoTtYg/LnmgLdgmJbs8Vpmo5vvXAgflkGVoJVefckl7asZm8Fler
    qR8g3FpP5FCTyQ5IfKivNzYTBSmd5ngnsp/xbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1522244544; bh=lm70r1FMKC5DS32Db5lljDBLJL
    B0IqIjIIerTZFecZo=; b=jO2oVqDy/LWNQvRlBef514YYVINV1vFG4O6oSowlZr
    VbE/UUbg9RkQi0gFIFBXCt/LX6yw8R8yn+w+jLVHJ+y+loW4bLtoS/T0UNZ9Zas8
    fkmDG2QYafQa679Nvhp2dRdfeZWcsNsq6svLgonPBZMdbm8LWR/i33QMlPI6U5S4
    e+CdlilKJpGhJgvI6FadXoDvS3KH5haL+m9Wp36fV6Z3Cjq6/g56GcH3gx+ODfyE
    BrKf23lfI4FZo6edpcgpjJVtScfSjzm0MJxowpD87Wcwjtt7+Qti/K955ZIKnmtw
    3idZi/W3RRCOsRSV+KKDNTdKBs3/R1MJAY8+vXUIPMOw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CAO8T/0J x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dMxaOf0V;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CAO8T/0J x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dMxaOf0V;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBiTUFk0VDsxx+RPKcVhbLK5zSsAiVt7sg+aSt/O/V0KA1zzirD0i5Q3Sz470B2YUbH4DcVgiKn9AH4eiD29f5U5tuAGJhQfiWmJddg7e8pYQmOBcvbH
    eD8rZ3vRXeSveR+wIkx5VjmQ4Ob4Ontu9EbnM2ubzL5y4opiSdbD81k76KBAAuTr8IVycHggNYiSZZh5Tst6rbUtNxr6l1kRCWznR5l5wWqeK0GZA8UvC/GV
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=1_nJWWfMPkEA:10
    a=v2DPQv5-lfwA:10 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=26cpz8QqEJyKJuvEvpMA:9
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753124AbeC1NmX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 09:42:23 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38627 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbeC1NmW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 09:42:22 -0400
X-Google-Smtp-Source: AIpwx49NFdN0zE1c1KkjMygZUPRvcfsOMRYIWIlUdOfyKbnU+Bjt4vqO6AAeQl926UUMac6fE//iqQ==
From: Aniruddha Banerjee <aniruddha.nitd@gmail.com>
To: marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc: aniruddhab@nvidia.com, stable@vger.kernel.org, vipink@nvidia.com,
        strasi@nvidia.com, swarren@nvidia.com, jonathanh@nvidia.com,
        talho@nvidia.com, treding@nvidia.com
Subject: [PATCHv4] irqchip: arm-gic: take gic_lock when updating irq type
Date: Wed, 28 Mar 2018 19:12:00 +0530
Message-Id: <20180328134200.7435-1-aniruddha.nitd@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Aniruddha Banerjee <aniruddhab@nvidia.com>

The kernel documentation states that the locking of the irq-chip
registers should be handled by the irq-chip driver. In the irq-gic,
the accesses to the irqchip are seemingly not protected and multiple
writes to SPIs from different irq descriptors do RMW requests without
taking the irq-chip lock. When multiple irqs call the request_irq at
the same time, there can be a simultaneous write at the gic
distributor, leading to a race. Acquire the gic_lock when the
irq_type is updated.

Cc: stable@vger.kernel.org

Signed-off-by: Aniruddha Banerjee <aniruddhab@nvidia.com>
---

Change from V1:
* Moved the spinlock from irq-gic to irq-gic common, so that the fix
is valid for GIC v1/v2/v3.

Change from V2:
* Fixup the Signed-off-by line.

Change from V3:
* Change raw_spin_lock to raw_spin_lock_irqsave and spin_unlock to
raw_spin_unlock_irqrestore to protect against a potential deadlock
when an interrupt handler changes the trigger type of any interrupt.

 drivers/irqchip/irq-gic-common.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 9ae71804b5dd..1c2ca8d51a70 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -21,6 +21,8 @@
 
 #include "irq-gic-common.h"
 
+static DEFINE_RAW_SPINLOCK(irq_controller_lock);
+
 static const struct gic_kvm_info *gic_kvm_info;
 
 const struct gic_kvm_info *gic_get_kvm_info(void)
@@ -52,11 +54,13 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 	u32 confoff = (irq / 16) * 4;
 	u32 val, oldval;
 	int ret = 0;
+	unsigned long flags;
 
 	/*
 	 * Read current configuration register, and insert the config
 	 * for "irq", depending on "type".
 	 */
+	raw_spin_lock_irqsave(&irq_controller_lock, flags);
 	val = oldval = readl_relaxed(base + GIC_DIST_CONFIG + confoff);
 	if (type & IRQ_TYPE_LEVEL_MASK)
 		val &= ~confmask;
@@ -64,8 +68,10 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 		val |= confmask;
 
 	/* If the current configuration is the same, then we are done */
-	if (val == oldval)
+	if (val == oldval) {
+		raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 		return 0;
+	}
 
 	/*
 	 * Write back the new configuration, and possibly re-enable
@@ -83,6 +89,7 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 			pr_warn("GIC: PPI%d is secure or misconfigured\n",
 				irq - 16);
 	}
+	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 
 	if (sync_access)
 		sync_access();
-- 
2.16.2
