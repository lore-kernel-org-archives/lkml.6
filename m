Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD022C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8637E206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="QlEd/BqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8637E206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeI2Mxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 08:53:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43901 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbeI2Mxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 08:53:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so5691935pfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 23:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=5h3K/CwGxtEaxnGYIL3r+zM9lrlneChfis+IbGckCBo=;
        b=QlEd/BqSCPe63Kxbs1InTTq1oUxmmUPCU3JIqWbL2eNVL+074+zttKjxmllsH5QgUo
         xKV2Ik456yXjjHw1IVoHybpW2nAiRQVxB+zbLjE8V4j4oScJjWomd3FiS1mGsN5ep2gG
         3NmxaR+mkcNdDkqUMsEI9EMU48kkreoTmoBEqIQy4BaOn5ybEBcckmTrPFvnEwtZbv+g
         K/9EAgHkTu4+cBY1ZB52Pi1QWj9YCSaySOkidycf7vYyFTFm+V/PSr2uQasnlO4eYfJG
         neI/nNr60NjSyvNPqlLpIwLPk2uHWuuYqjV/uBlzAz440iAfL29GnylXJHLkFXmqmf9b
         /pRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5h3K/CwGxtEaxnGYIL3r+zM9lrlneChfis+IbGckCBo=;
        b=VhsFMFqxagMjIbV1xk87CPLvGdvBntKLa0ammay7SLOuPWNn51YneihhN0GDY2HIJr
         hRJ9ZIUZRac22+j7Rhy2FK0+Nw5uq6rKbqx2gx4xM69PcPscv/TCBwl/oj7YW4e7FzsJ
         FOFPbX+elvDcz1Zfl+Ftpq/GMlDLOKuLjb2OzCXn74CpFGaAo+ErFOI4z3w0m/vtAxo0
         nqdpVkyZzilYPHKe5RlQWQRRh093Brqw4QodUoKYNmvcLUVAUweSDbsnsMyn5uu2lva2
         mybxpys9nqmHaPu/aH0VQL3KjbgI7Rs1vFzo1XcuccAdNAGHpHy5zdSFl+heowwjiMPg
         sLng==
X-Gm-Message-State: ABuFfojfxANaTzQux+SXX2BlNPPcm3oYisp0yHKlX2F9CbvXgGHPUA5/
        Czct2mOO2mYug8dEFlfrdSiVXw==
X-Google-Smtp-Source: ACcGV61uoMkW92uKVnYbFTxD8gbQf4iK+b3fhyjAqln80oJwZhSXF6qjXnWt5V926v5g8njCSelTXg==
X-Received: by 2002:a17:902:bb90:: with SMTP id m16-v6mr1818229pls.254.1538202382192;
        Fri, 28 Sep 2018 23:26:22 -0700 (PDT)
Received: from anup-ubuntu64.dlink.router ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id e3-v6sm10258859pgc.71.2018.09.28.23.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 23:26:21 -0700 (PDT)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v3] RISC-V: Show IPI stats
Date:   Sat, 29 Sep 2018 11:56:05 +0530
Message-Id: <20180929062605.12888-1-anup@brainfault.org>
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

Signed-off-by: Anup Patel <anup@brainfault.org>

Changes since v2:
 - Remove use of IPI_CALL_WAKEUP because it's being removed

Changes since v1:
 - Add stub inline show_ipi_stats() function for !CONFIG_SMP
 - Make ipi_names[] dynamically sized at compile time
 - Minor beautification of ipi_names[] using tabs

---
 arch/riscv/include/asm/smp.h |  9 +++++++++
 arch/riscv/kernel/irq.c      |  8 ++++++++
 arch/riscv/kernel/smp.c      | 39 +++++++++++++++++++++++++++++-------
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index fce312ce3516..5278ae8f1346 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -25,8 +25,13 @@
 extern unsigned long __cpuid_to_hardid_map[NR_CPUS];
 #define cpuid_to_hardid_map(cpu)    __cpuid_to_hardid_map[cpu]
 
+struct seq_file;
+
 #ifdef CONFIG_SMP
 
+/* print IPI stats */
+void show_ipi_stats(struct seq_file *p, int prec);
+
 /* SMP initialization hook for setup_arch */
 void __init setup_smp(void);
 
@@ -47,6 +52,10 @@ void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
 
 #else
 
+static inline void show_ipi_stats(struct seq_file *p, int prec)
+{
+}
+
 static inline int riscv_hartid_to_cpuid(int hartid)
 {
 	return 0;
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index ca4593317e45..48e6b7db83a1 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -8,6 +8,8 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
+#include <linux/seq_file.h>
+#include <asm/smp.h>
 
 /*
  * Possible interrupt causes:
@@ -24,6 +26,12 @@
  */
 #define INTERRUPT_CAUSE_FLAG	(1UL << (__riscv_xlen - 1))
 
+int arch_show_interrupts(struct seq_file *p, int prec)
+{
+	show_ipi_stats(p, prec);
+	return 0;
+}
+
 asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 89d95866f562..686fa7a427ff 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -22,22 +22,24 @@
 #include <linux/interrupt.h>
 #include <linux/smp.h>
 #include <linux/sched.h>
+#include <linux/seq_file.h>
 
 #include <asm/sbi.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 
-/* A collection of single bit ipi messages.  */
-static struct {
-	unsigned long bits ____cacheline_aligned;
-} ipi_data[NR_CPUS] __cacheline_aligned;
-
 enum ipi_message_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
 	IPI_MAX
 };
 
+/* A collection of single bit ipi messages.  */
+static struct {
+	unsigned long stats[IPI_MAX] ____cacheline_aligned;
+	unsigned long bits ____cacheline_aligned;
+} ipi_data[NR_CPUS] __cacheline_aligned;
+
 int riscv_hartid_to_cpuid(int hartid)
 {
 	int i = -1;
@@ -67,6 +69,7 @@ int setup_profiling_timer(unsigned int multiplier)
 void riscv_software_interrupt(void)
 {
 	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
+	unsigned long *stats = ipi_data[smp_processor_id()].stats;
 
 	/* Clear pending IPI */
 	csr_clear(sip, SIE_SSIE);
@@ -81,11 +84,15 @@ void riscv_software_interrupt(void)
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
 
@@ -111,6 +118,24 @@ send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
 	sbi_send_ipi(cpumask_bits(&hartid_mask));
 }
 
+static const char *ipi_names[] = {
+	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
+	[IPI_CALL_FUNC]		= "Function call interrupts",
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

