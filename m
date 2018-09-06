Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A99BC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4462077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="OfFfcOw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4462077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeIFRMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:12:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36570 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbeIFRMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:12:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id e11-v6so4929554plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 05:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jd+1QGXPir1x1xm+cG8i3W+xNSHg5NK20nmL8ZfKS5Q=;
        b=OfFfcOw1ouODgl5dnimKD8oZWcXAkMrfnPZoEIN0S6Zx05k2KiAzELooapCXIiiFmN
         6JZAH3iM+EpZFGEI7Xi0S0EIJ5kn94HbunW3H2YqIYW5JQ0tDAhYnDkfzevzl9wXXkGy
         PFtSjZWBgA7ZLp3zGZ4UMU4CDcNO+ykDjyqADaG0VCX+LtUy6/HDeexwtXtxk+ezry5C
         n7sHHTKK+hKuTQm7i3QC7MI8wXhrS0KebsHX0M5MNHPX+t807sam78/y82D6OEY1QneM
         SNhXgdVrQdtSX7EQADiM8dw8W4rLVnagKPN6cqpy6ermaMCQ90rB/2PS0tO0IAlrYiXy
         OQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jd+1QGXPir1x1xm+cG8i3W+xNSHg5NK20nmL8ZfKS5Q=;
        b=C68UcTM3DI1SaIu0EBC7VBSDlkOMHoVrCs0ZBy5l8+Te3mvvRfUp9rplHPbmR8I4/J
         JfYHJWn6PXiERWwz9Qv046QqPjKIUb/FjiAxHURyGLBH2d11pUgNpO2AZKy+XPb83muw
         iJth7OU56XWm/UVCzzjsUhVmnkmuHVDDyjoOXWb3j/ouqD5OluYBDdAd1TOpyuJUhN5/
         AU6MYXn4pw0IOjyjwHgVgRX0H+vFbG/Vurb+bDYzVpfUQvI9wBgOK8zXHRxbBmO4A+8X
         nlxBkyyLs45Tvm5MHrPlqd276Kw+L9FIED29mVAvOGeq80ydddjT/4rzo38pLuuasg3s
         hjrg==
X-Gm-Message-State: APzg51DI9U/nB2kCmSarzJHMQt3EiRRybpkyXnKnA/FAwxCthfy9e20y
        et8AaB1klibQDiVbmltQyjRhpwQcL9c=
X-Google-Smtp-Source: ANB0VdZJ/WPRCVVxZAMF9fMcLh0R4WJVpo3FaXrsdpzs1RGxhYw5mMqjMkxqL7A+0Ysxrgn/pHJTbQ==
X-Received: by 2002:a17:902:8a92:: with SMTP id p18-v6mr2413878plo.148.1536237434655;
        Thu, 06 Sep 2018 05:37:14 -0700 (PDT)
Received: from anup-ubuntu64.wlan.qualcomm.com ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id 193-v6sm11446165pgh.47.2018.09.06.05.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 05:37:13 -0700 (PDT)
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
Subject: [PATCH v2 1/5] RISC-V: self-contained IPI handling routine
Date:   Thu,  6 Sep 2018 18:06:47 +0530
Message-Id: <20180906123651.28500-2-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180906123651.28500-1-anup@brainfault.org>
References: <20180906123651.28500-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the IPI handling routine riscv_software_interrupt() does
not take any argument and also does not perform irq_enter()/irq_exit().

This patch makes IPI handling routine more self-contained by:
1. Passing "pt_regs *" argument
2. Explicitly doing irq_enter()/irq_exit()
3. Explicitly save/restore "pt_regs *" using set_irq_regs()

With above changes, IPI handling routine does not depend on caller
function to perform irq_enter()/irq_exit() and save/restore of
"pt_regs *" hence its more self-contained. This also enables us
to call IPI handling routine from IRQCHIP drivers.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/irq.h |  1 -
 arch/riscv/include/asm/smp.h |  3 +++
 arch/riscv/kernel/irq.c      | 16 ++++++++++------
 arch/riscv/kernel/smp.c      | 11 +++++++++--
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index a873a72d0f00..8d5d1a9f7fae 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -18,7 +18,6 @@
 #define NR_IRQS         0
 
 void riscv_timer_interrupt(void);
-void riscv_software_interrupt(void);
 void wait_for_software_interrupt(void);
 
 #include <asm-generic/irq.h>
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 8145b8657d20..d7c3da05f200 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -51,6 +51,9 @@ void send_ipi_message(const struct cpumask *to_whom,
 /* SMP initialization hook for setup_arch */
 void __init setup_smp(void);
 
+/* Called from C code, this handles an IPI. */
+void handle_IPI(struct pt_regs *regs);
+
 /* Hook for the generic smp_call_function_many() routine. */
 void arch_send_call_function_ipi_mask(struct cpumask *mask);
 
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 7e14b0d9a71d..f5073dcbc560 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -26,12 +26,15 @@
 
 asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long cause)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
+	struct pt_regs *old_regs;
 
-	irq_enter();
 	switch (cause & ~INTERRUPT_CAUSE_FLAG) {
 	case INTERRUPT_CAUSE_TIMER:
+		old_regs = set_irq_regs(regs);
+		irq_enter();
 		riscv_timer_interrupt();
+		irq_exit();
+		set_irq_regs(old_regs);
 		break;
 #ifdef CONFIG_SMP
 	case INTERRUPT_CAUSE_SOFTWARE:
@@ -39,18 +42,19 @@ asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long cause)
 		 * We only use software interrupts to pass IPIs, so if a non-SMP
 		 * system gets one, then we don't know what to do.
 		 */
-		riscv_software_interrupt();
+		handle_IPI(regs);
 		break;
 #endif
 	case INTERRUPT_CAUSE_EXTERNAL:
+		old_regs = set_irq_regs(regs);
+		irq_enter();
 		handle_arch_irq(regs);
+		irq_exit();
+		set_irq_regs(old_regs);
 		break;
 	default:
 		panic("unexpected interrupt cause");
 	}
-	irq_exit();
-
-	set_irq_regs(old_regs);
 }
 
 /*
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 629456bb6122..9e7bcf705946 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -58,10 +58,13 @@ int setup_profiling_timer(unsigned int multiplier)
 	return -EINVAL;
 }
 
-void riscv_software_interrupt(void)
+void handle_IPI(struct pt_regs *regs)
 {
+	struct pt_regs *old_regs = set_irq_regs(regs);
 	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
 
+	irq_enter();
+
 	/* Clear pending IPI */
 	csr_clear(sip, SIE_SSIE);
 
@@ -73,7 +76,7 @@ void riscv_software_interrupt(void)
 
 		ops = xchg(pending_ipis, 0);
 		if (ops == 0)
-			return;
+			goto done;
 
 		if (ops & (1 << IPI_RESCHEDULE))
 			scheduler_ipi();
@@ -86,6 +89,10 @@ void riscv_software_interrupt(void)
 		/* Order data access and bit testing. */
 		mb();
 	}
+
+done:
+	irq_exit();
+	set_irq_regs(old_regs);
 }
 
 void
-- 
2.17.1

