Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301EBC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65B820652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="xsgnA0zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65B820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbeIFRNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:13:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45735 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbeIFRNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:13:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id x26-v6so5160424pge.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 05:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5dC5MkcLBlwXZcIQ9w9cv0hXXu3tn7yMycSWCbmjdsc=;
        b=xsgnA0zq70y4wpmWZ/7WewrGDXcvhJmY/ZgiiA+QkDk3c+upTPpRUvhp1O1cd4FhjB
         DaCVODNZfEgWn8hsV1eTsMTr8o2i9eWpL7sqo1VjlMa2/2f0gubQ3Yae3OswqGPxXmUc
         cDJdsxmZ+EjPEwHAxxfZR+fu2jcc7hIOhPqrrto5F6vp74ywZg40AVCktl0z1W4G8U+s
         8FaXmyMwUsbPRFE209VBA59q5TB80Vp+Fw+43mQlnfFzGGlg/3SCQoN6VFF4h750lZ78
         5rzFcVEg4pCFeHOAcMKaZOHqczSsZfu1spiYVjwdJtyj3KP70T48sAYOs1fTb4Ighsm1
         6kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5dC5MkcLBlwXZcIQ9w9cv0hXXu3tn7yMycSWCbmjdsc=;
        b=pBY52DAXJNzZbPV+V/HhCzrBYm0MUB0pTfmgK+0dzmgmQL4cORk0jwc2JMDTqboWwo
         ZlQoG93oriXw5U0xgo/kTV4/qWuwyl8wPvjjy4v7ieBe75WkTUQvG4PMvuegahpcCSqD
         fsP3kxVOQ91X8AZYz74tVshKJMTesTtspgq4GWOVrI+fGgPr/pc26zH+mRwHOU4tjL9q
         2BSEZt/a8iOuYcvfbGOXMdqo8LQkk7BTvceP6bybfyjTMIH/J+B03NSJZPhOEHwWqMGL
         PKxTmg6uN7Oser5UsLYQWAmLHMwCe0bFTxG3B10iIAtjK7Hi/LRj+41heYqMVRoEtug+
         Owrg==
X-Gm-Message-State: APzg51DtEFJ2CQdaXik8Zv3wNKsJgN87RijaXY/+E+RtCaFD4iJLBcmi
        fjE4/Wez7dvDDJ1oT27G1koOFzrhKP0=
X-Google-Smtp-Source: ANB0VdYrAXvYWBvPbb0ceKeiMfprYdXSq28IyIiMrGPT93a5tV0eYdCu3ItcbtpQGUEC89dIhlNw+A==
X-Received: by 2002:a63:d54e:: with SMTP id v14-v6mr2556270pgi.264.1536237466569;
        Thu, 06 Sep 2018 05:37:46 -0700 (PDT)
Received: from anup-ubuntu64.wlan.qualcomm.com ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id 193-v6sm11446165pgh.47.2018.09.06.05.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 05:37:45 -0700 (PDT)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v2 5/5] RISC-V: Remove do_IRQ() function
Date:   Thu,  6 Sep 2018 18:06:51 +0530
Message-Id: <20180906123651.28500-6-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180906123651.28500-1-anup@brainfault.org>
References: <20180906123651.28500-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only thing do_IRQ() does is call handle_arch_irq function
pointer. We can very well call handle_arch_irq function pointer
directly from assembly and remove do_IRQ() function hence this
patch.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kernel/entry.S | 4 +++-
 arch/riscv/kernel/irq.c   | 6 ------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 6eaacfa5b63d..69fbe9dd9e0c 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -168,7 +168,9 @@ ENTRY(handle_exception)
 
 	/* Handle interrupts */
 	move a0, sp /* pt_regs */
-	tail do_IRQ
+	la a1, handle_arch_irq
+	REG_L a1, (a1)
+	jr a1
 1:
 	/* Exceptions run with interrupts enabled */
 	csrs sstatus, SR_SIE
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 9ced284da30b..695e241d0402 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -8,12 +8,6 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 
-asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs)
-{
-	if (handle_arch_irq)
-		handle_arch_irq(regs);
-}
-
 /*
  * This function doesn't return until a software interrupt is sent via IPI.
  * Obviously, all the interrupts except software interrupt should be disabled
-- 
2.17.1

