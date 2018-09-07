Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EC0C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083402077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="uD7j8Iw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083402077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbeIGRZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:25:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33857 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeIGRZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:25:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id f6-v6so6575935plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 05:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=rvSwAtIyvaHhcEnYQiN+wPwc3UbGOg7HMEb94Cge+Hk=;
        b=uD7j8Iw57IrDvs0zuxjBHVLsZH2bgHKivCFxyGbay9XKPrU4TgyWAFnNrajTn6Qqr1
         8glVpRRMrAMKeANtOafQwMw1CSDwE0oF+UKHDli3Ln+xL4UXACM6MOTOMbXhet64/jgq
         r43FniSwPqmLgoYYOEDHGYh4S/ixjjVNhgMPXonXaLXCPio4Xf89BYeSmKIV4+hXlrBM
         WP6gjeJbfZ5VmeV0z68p0tTn4UEmp2MYbRbyrAax+N6+F6gCzpUJNlgZlArATVnNHzb4
         AdEoIvrlmpinXJyv8HsmIYufdXc2fRduzM+8JkWiIDwPqZenehcFDpR7uLszTjNfkatZ
         taOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rvSwAtIyvaHhcEnYQiN+wPwc3UbGOg7HMEb94Cge+Hk=;
        b=POIUGll3yRrSGRPu7gFQAj5LslI12+VonKRn1LLbADupUvtBQEWiVPn+yIkyaSOHkU
         hvh6oo1Oo6itPX5wb5exVB0aa13KTrzU3KX4+H6EcMTaKt7X2YZz9k55hQ/mOo1Dw1Vs
         ZTeVJ0+LiX3IUl2AvmJNXqkvSr3qGbSYCCHkVKKgUvUao4OebTNhcgkJLDYzDzLHsSF4
         /Zzp9c5v0CIm4AmLBo3Wf+YWS5kQ6Fi4BMyzYlVHeFvhRVSmGHm+OtM/QfoGYI3j81xz
         7a/73dsEZfQTWAKqlObdQacK0UyZcLgfKot/3G3yfK5BHKDcJAOlUf3VdHYIjDKa/Y4o
         z1Zw==
X-Gm-Message-State: APzg51CuphT1z1LNpqkyCDeW66mdQUlWMhotrgq2eCVBBf0ZgIYtyYkH
        xSf3KkRI3O7D6VoleButv5pi1g==
X-Google-Smtp-Source: ANB0VdYcbMpVhcMlRBotjE1ADhB75jvVV0sOs8VFAVZNRDBmFEjkIb3O1tlj+wOTWaGer7e1D8766A==
X-Received: by 2002:a17:902:988a:: with SMTP id s10-v6mr7584569plp.200.1536324291299;
        Fri, 07 Sep 2018 05:44:51 -0700 (PDT)
Received: from anup-ubuntu64.wlan.qualcomm.com ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id g11-v6sm14387117pgi.90.2018.09.07.05.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 05:44:50 -0700 (PDT)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH] RISC-V: Show IPI stats
Date:   Fri,  7 Sep 2018 18:14:29 +0530
Message-Id: <20180907124429.31407-1-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides arch_show_interrupts() implementation to
show IPI stats via /proc/interrupts.

Now the contents of /proc/interrupts" will look like below:
           CPU0       CPU1       CPU2       CPU3
  8:         17          7          6         14  SiFive PLIC   8  virtio0
 10:         10         10          9         11  SiFive PLIC  10  ttyS0
IPI0:       170        673        251         79  Rescheduling interrupts
IPI1:         1         12         27          1  Function call interrupts
IPI2:         0          0          0          0  CPU wake-up interrupts

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/smp.h |  5 +++++
 arch/riscv/kernel/irq.c      |  9 +++++++++
 arch/riscv/kernel/smp.c      | 30 ++++++++++++++++++++++++++++--
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 8145b8657d20..a87e292becba 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -48,6 +48,11 @@ enum ipi_message_type {
 void send_ipi_message(const struct cpumask *to_whom,
 		      enum ipi_message_type operation);
 
+struct seq_file;
+
+/* print IPI stats */
+void show_ipi_stats(struct seq_file *p, int prec);
+
 /* SMP initialization hook for setup_arch */
 void __init setup_smp(void);
 
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 7e14b0d9a71d..9177552cd76c 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
+#include <linux/seq_file.h>
 
 /*
  * Possible interrupt causes:
@@ -24,6 +25,14 @@
  */
 #define INTERRUPT_CAUSE_FLAG	(1UL << (__riscv_xlen - 1))
 
+int arch_show_interrupts(struct seq_file *p, int prec)
+{
+#ifdef CONFIG_SMP
+	show_ipi_stats(p, prec);
+#endif
+	return 0;
+}
+
 asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long cause)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 629456bb6122..4e67a690edbc 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/smp.h>
 #include <linux/sched.h>
+#include <linux/seq_file.h>
 
 #include <asm/sbi.h>
 #include <asm/tlbflush.h>
@@ -29,6 +30,7 @@
 
 /* A collection of single bit ipi messages.  */
 static struct {
+	unsigned long stats[IPI_MAX] ____cacheline_aligned;
 	unsigned long bits ____cacheline_aligned;
 } ipi_data[NR_CPUS] __cacheline_aligned;
 
@@ -61,6 +63,7 @@ int setup_profiling_timer(unsigned int multiplier)
 void riscv_software_interrupt(void)
 {
 	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
+	unsigned long *stats = ipi_data[smp_processor_id()].stats;
 
 	/* Clear pending IPI */
 	csr_clear(sip, SIE_SSIE);
@@ -75,11 +78,15 @@ void riscv_software_interrupt(void)
 		if (ops == 0)
 			return;
 
-		if (ops & (1 << IPI_RESCHEDULE))
+		if (ops & (1 << IPI_RESCHEDULE)) {
+			stats[IPI_RESCHEDULE]++;
 			scheduler_ipi();
+		}
 
-		if (ops & (1 << IPI_CALL_FUNC))
+		if (ops & (1 << IPI_CALL_FUNC)) {
+			stats[IPI_CALL_FUNC]++;
 			generic_smp_call_function_interrupt();
+		}
 
 		BUG_ON((ops >> IPI_MAX) != 0);
 
@@ -105,6 +112,25 @@ send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
 	sbi_send_ipi(cpumask_bits(&hartid_mask));
 }
 
+static const char *ipi_names[IPI_MAX] = {
+	[IPI_RESCHEDULE] = "Rescheduling interrupts",
+	[IPI_CALL_FUNC] = "Function call interrupts",
+	[IPI_CALL_WAKEUP] = "CPU wake-up interrupts",
+};
+
+void show_ipi_stats(struct seq_file *p, int prec)
+{
+	unsigned int cpu, i;
+
+	for (i = 0; i < IPI_MAX; i++) {
+		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
+			   prec >= 4 ? " " : "");
+		for_each_online_cpu(cpu)
+			seq_printf(p, "%10lu ", ipi_data[cpu].stats[i]);
+		seq_printf(p, " %s\n", ipi_names[i]);
+	}
+}
+
 void arch_send_call_function_ipi_mask(struct cpumask *mask)
 {
 	send_ipi_message(mask, IPI_CALL_FUNC);
-- 
2.17.1

