Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838E0C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBC921763
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lw7Ht7wo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBC921763
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbeHCPxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:53:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40913 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbeHCPxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:53:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id x5-v6so2887979pgp.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 06:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PHQ7yNxJ6lPuxXq+MoW2dOPy5UfXv/j+KgXZyeUmOmw=;
        b=Lw7Ht7woMOzFlk9UmvcPOelSfsT0i/sCey5NmHUUS6LdfxgMyu96WlfqbEFL5EimlS
         0T6KckVbnKo1jbK0lFrhP0vVKwTBXcH+vBptoWQkzpI+DQ4VBDM13DR7yULgmw9uMGp2
         zQtRVwydGWpxmFKvp/ehquOcbFEEwI52MsXmKtGvaIOn1w9WDGEgsVJpA6jmTH9rXLQh
         iCIijOQIIepHTzaQ15QHs4JhIrFMdhjqSXc+Lz7G3jlCcAY4+NMlRayxEYfknr/OSm1z
         PJ8rtX8+yHZdqzFXVWl+KrD8IuVPbXobwkLy6DF2AL99ZdhVlekbTJSA6mYOdnwLEwXT
         qAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PHQ7yNxJ6lPuxXq+MoW2dOPy5UfXv/j+KgXZyeUmOmw=;
        b=B8Y0REyb+RSiAZUHq5j//5Jc0CFt2/7Vn0hFVMT04wsMLhen3RSQHeBTzC0dSvhm/c
         nGYBve+o9Lp59dVLaA5SOGBDJ57SG/G3FIZzFd2YAnWoI5Plz38QZzuqDKyKiFmITqLG
         U7+0aLEYdd+vwDVPnjm23Gtq0JzzusPzpxLnzp4QXuCrgwp3KNhio5i0z7zWl8M0pOyG
         SMgRFZFwj96pnyd2heXVaGj1TGgNseuceXUuMGRyXIFykUDmZE1JQx5NNXKYXOhaRj2i
         h3QpXG1+36ycGxrvAyKI4KJdUt4QEmeFI5OUehdZOKJzEmAVsu7OKSigCilTnXx1pacF
         2hPA==
X-Gm-Message-State: AOUpUlG/JdGqnTn2gDsWQEZ/Hdr3vjxMTc7VY6jiGU93v3ij/oINzU9F
        qvYNIvP59e1hxgtHAEZFMq0=
X-Google-Smtp-Source: AAOMgpdeZDJHu4jeJyjXtqS1nyARExkvhRant+yCzXmzL0jt5lZPZG28HYvAyjL4VFwseqWUXczwdA==
X-Received: by 2002:a63:5c52:: with SMTP id n18-v6mr3902511pgm.360.1533304638128;
        Fri, 03 Aug 2018 06:57:18 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id p5-v6sm6755173pfn.57.2018.08.03.06.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 06:57:17 -0700 (PDT)
From:   Jia He <hejianet@gmail.com>
X-Google-Original-From: Jia He <jia.he@hxt-semitech.com>
To:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Jia He <hejianet@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Jia He <jia.he@hxt-semitech.com>
Subject: [PATCH 1/2] KVM: arm/arm64: vgic: move DEBUG_SPINLOCK_BUG_ON to vgic.h
Date:   Fri,  3 Aug 2018 21:57:03 +0800
Message-Id: <1533304624-43250-1-git-send-email-jia.he@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to let DEBUG_SPINLOCK_BUG_ON be commonly used in vgic-v2 and
vgic-v3.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 virt/kvm/arm/vgic/vgic.c | 6 ------
 virt/kvm/arm/vgic/vgic.h | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 33c8325..c22cea6 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -28,12 +28,6 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define DEBUG_SPINLOCK_BUG_ON(p) BUG_ON(p)
-#else
-#define DEBUG_SPINLOCK_BUG_ON(p)
-#endif
-
 struct vgic_global kvm_vgic_global_state __ro_after_init = {
 	.gicv3_cpuif = STATIC_KEY_FALSE_INIT,
 };
diff --git a/virt/kvm/arm/vgic/vgic.h b/virt/kvm/arm/vgic/vgic.h
index ead00b2..ea51fcc 100644
--- a/virt/kvm/arm/vgic/vgic.h
+++ b/virt/kvm/arm/vgic/vgic.h
@@ -103,6 +103,12 @@
 #define KVM_VGIC_V3_RDIST_COUNT_MASK	GENMASK_ULL(63, 52)
 #define KVM_VGIC_V3_RDIST_COUNT_SHIFT	52
 
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define DEBUG_SPINLOCK_BUG_ON(p) BUG_ON(p)
+#else
+#define DEBUG_SPINLOCK_BUG_ON(p)
+#endif
+
 /* Requires the irq_lock to be held by the caller. */
 static inline bool irq_is_pending(struct vgic_irq *irq)
 {
-- 
1.8.3.1

