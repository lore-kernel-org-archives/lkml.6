Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10DEC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B4D2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="vbzeuMqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B4D2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbeIDRKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:10:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40376 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeIDRKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:10:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17-v6so1586109plp.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 05:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tlt1PfC5v5rmilaUoHCS9D827yQ94E64O9HmHE2biq8=;
        b=vbzeuMqCB5v00t1o8KpmC4bZA3sM2+DY+vSSU/Y1QjKcrSAXKfgVrlHSDElwb+SozI
         GWm6dy9PNMFgNpdG6dkNT8F61BGUgdaYhT6PjVh4NuiXDBy+DFYRHUSUZ20Ht0TQRn5g
         gaxAhOPHeyBlRGeyClE9z4qNWpOFmaCNeTH04gEJVGG8GKBd+k5EL02V6ze2Cfp5/Vwu
         XKPH4ySuJ6LoDBlpxARBlstE7a+Iv5wAPKe1fy4srC2auPnhm1wEFGgX0m6jFKHmgmWQ
         DrKR5BizHhCk4DE5hEb5byMFiIxFBmLKzk8zhINGPEX1zDPJhfIN7egHUrW7XK9EKzFs
         AQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tlt1PfC5v5rmilaUoHCS9D827yQ94E64O9HmHE2biq8=;
        b=PTUwvjQxsFnEqvXW8Srpn4CdukWGzJi5OmSMUwjPmrS1M2HAzHwxEQT9nKHj8crgaK
         TeWb+qzz1H+2XocTfDz0GSFqxCoRYSjea6putQR+AzG0Ah8NdNDn78W+IdVG4XXLvEzr
         KAz+Y/DiyfnmnrzdMg2onZHjtAtbHh1bcOtCMhZ5Ayamux7n32AUrTWlr7JN7F4fuaA1
         JrB2l900OgONOtz5c+PE7M2mDQKEdDcANNPTWsyEc1TNLc9WGy/9W4iFFLz/twEjz6vw
         bpsq9LLiWnVQ/UDKV/57RjctIXJXoFZkHLWojh/Dr32g6O8BnseuyKAOM6aiB2z7pihL
         Tz1g==
X-Gm-Message-State: APzg51ArgFMJmjdSK78q/n4z8Y+eucg0GN0AC3YABr4a9ct/3qiC0CIZ
        ipbO0Hx5iJjbziuzqlmb0NvJ2A==
X-Google-Smtp-Source: ANB0VdbihGF/6vTROWcLc4Ohq/BmAg6Dp7Jw8ILTrNIoe95Dwg6vG3Te5vVRUcXzp3xVK02YwPh2tg==
X-Received: by 2002:a17:902:32f:: with SMTP id 44-v6mr33077837pld.15.1536065148172;
        Tue, 04 Sep 2018 05:45:48 -0700 (PDT)
Received: from anup-ubuntu64.wlan.qualcomm.com ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id p11-v6sm31621773pfj.72.2018.09.04.05.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 05:45:47 -0700 (PDT)
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
Subject: [RFC PATCH 1/5] RISC-V: Make IPI triggering flexible
Date:   Tue,  4 Sep 2018 18:15:10 +0530
Message-Id: <20180904124514.6290-2-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180904124514.6290-1-anup@brainfault.org>
References: <20180904124514.6290-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mechanism to trigger IPI is generally part of interrupt-controller
driver for various architectures. On RISC-V, we have an option to trigger
IPI using SBI or SOC vendor can implement RISC-V CPU where IPI will be
triggered using SOC interrupt-controller (e.g. custom PLIC).

This patch makes IPI triggering flexible by providing a mechanism for
interrupt-controller driver to register IPI trigger function using
set_smp_ipi_trigger() function.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/irq.h |  1 -
 arch/riscv/include/asm/smp.h | 10 ++++++++++
 arch/riscv/kernel/irq.c      | 26 +++++++++++++++++++++-----
 arch/riscv/kernel/smp.c      | 23 +++++++++++++++++++----
 4 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 996b6fbe17a6..93eb75eac4ff 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -18,7 +18,6 @@
 #define NR_IRQS         0
 
 void riscv_timer_interrupt(void);
-void riscv_software_interrupt(void);
 
 #include <asm-generic/irq.h>
 
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 36016845461d..72671580e1d4 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -27,6 +27,16 @@
 /* SMP initialization hook for setup_arch */
 void __init setup_smp(void);
 
+/*
+ * Called from C code, this handles an IPI.
+ */
+void handle_IPI(struct pt_regs *regs);
+
+/*
+ * Provide a function to raise an IPI on CPUs in callmap.
+ */
+void __init set_smp_ipi_trigger(void (*fn)(const struct cpumask *));
+
 /* Hook for the generic smp_call_function_many() routine. */
 void arch_send_call_function_ipi_mask(struct cpumask *mask);
 
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 0cfac48a1272..5532e7cedaec 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -9,6 +9,8 @@
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 
+#include <asm/sbi.h>
+
 /*
  * Possible interrupt causes:
  */
@@ -26,12 +28,15 @@
 
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
@@ -39,21 +44,32 @@ asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long cause)
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
+}
 
-	set_irq_regs(old_regs);
+#ifdef CONFIG_SMP
+static void smp_ipi_trigger_sbi(const struct cpumask *to_whom)
+{
+	sbi_send_ipi(cpumask_bits(to_whom));
 }
+#endif
 
 void __init init_IRQ(void)
 {
 	irqchip_init();
+#ifdef CONFIG_SMP
+	set_smp_ipi_trigger(smp_ipi_trigger_sbi);
+#endif
 }
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 906fe21ea21b..04571d77eceb 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -38,17 +38,19 @@ enum ipi_message_type {
 	IPI_MAX
 };
 
-
 /* Unsupported */
 int setup_profiling_timer(unsigned int multiplier)
 {
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
 
@@ -60,7 +62,7 @@ void riscv_software_interrupt(void)
 
 		ops = xchg(pending_ipis, 0);
 		if (ops == 0)
-			return;
+			goto done;
 
 		if (ops & (1 << IPI_RESCHEDULE))
 			scheduler_ipi();
@@ -73,6 +75,17 @@ void riscv_software_interrupt(void)
 		/* Order data access and bit testing. */
 		mb();
 	}
+
+done:
+	irq_exit();
+	set_irq_regs(old_regs);
+}
+
+static void (*__smp_ipi_trigger)(const struct cpumask *);
+
+void __init set_smp_ipi_trigger(void (*fn)(const struct cpumask *))
+{
+	__smp_ipi_trigger = fn;
 }
 
 static void
@@ -85,7 +98,9 @@ send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
 		set_bit(operation, &ipi_data[i].bits);
 
 	mb();
-	sbi_send_ipi(cpumask_bits(to_whom));
+
+	if (__smp_ipi_trigger)
+		__smp_ipi_trigger(to_whom);
 }
 
 void arch_send_call_function_ipi_mask(struct cpumask *mask)
-- 
2.17.1

