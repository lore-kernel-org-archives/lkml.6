Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E1CC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6C520866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="IyEC1xxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6C520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeILTmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:42:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41195 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeILTmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:42:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id s15-v6so1166393pgv.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=y0P6O8v7rThGQSl1OcgYGkbGNCqDY4v92y928eGZHWE=;
        b=IyEC1xxB9SDq7DDAdhQlsSpsIb1xnlJWM8R1ZMoYU+E2UsXf3XIOvkkuMOe6Uyqyck
         0fLqMzsUu2SA5ulC0+Mi4dFLFYk2CnWBeB9HQG4iJTcFFg1EBKCNwoiROLd2PW4sm2RO
         nBZVrfbboZUZiZUGdU3tHr3waRAPKqnBh7xbw0cwA2A+4UlcGcuhxkHAhbvWR9xfeOrg
         5t3YOyA86N204sYMEXuH4h8UkdhnUy5dubE87Kzj/k5tz1qNHJXsM5Xg2Cnlbwa8dqmr
         E2Ef/9VVUkRgHraIO5uDMgIDeRYKqB8f2ODnBoN4Uwe0Bj/OzUsunPTYdXK0i33LYmkl
         oP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y0P6O8v7rThGQSl1OcgYGkbGNCqDY4v92y928eGZHWE=;
        b=Qc7/DtuhkSphXiVlS+BqJ5+s/U+R0Y5pPG3t6JeH5+oVFVFQPSbuJdEhieMAJk96Z0
         oYRgh7b3RqCpfZ6teTOVnMh9ABHZtPj1zNqK98bU8E29YQubM2l+cL4nwLBqCo6XP/K+
         fPHeRAx0dKeMiWFLzWP9mQRlYXSYIHeRKfT852VOY0BJEslZan30oneJ05kCt+8s4BNU
         B1VUZjK7fteRc9VQxvj+lXxv+i6qNN6ZatRc0IV02I6MNagbVZYkWKriNJthf84VQYSf
         prCSqeDhQ3rPBtV2vagDJAeMUJoLIMGiJ4qxBdpja0bH09s/EXFu71IO3AWrHvfbpza+
         52Vg==
X-Gm-Message-State: APzg51DgM8Maapkz3qds5ZZnF2DYapvZp3Q36DxnLx5yPGuvrbjY1GML
        gm3mFvzxZDIjsqlYbRBB6M8Nuw==
X-Google-Smtp-Source: ANB0VdYBXt1+1kaYBcrAzPk2rhJ6ZgSEwQAOwccBBhCunRaUJj1UDJ3sfcWlspjaE8bh0WRLO5xH7g==
X-Received: by 2002:a65:5581:: with SMTP id j1-v6mr2619698pgs.203.1536763070655;
        Wed, 12 Sep 2018 07:37:50 -0700 (PDT)
Received: from anup-ubuntu64.dlink.router ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id u9-v6sm2161116pfi.104.2018.09.12.07.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 07:37:49 -0700 (PDT)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v2] RISC-V: Show IPI stats
Date:   Wed, 12 Sep 2018 20:07:34 +0530
Message-Id: <20180912143734.21205-1-anup@brainfault.org>
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

Changes since v1:
 - Add stub inline show_ipi_stats() function for !CONFIG_SMP
 - Make ipi_names[] dynamically sized at compile time
 - Minor beautification of ipi_names[] using tabs

 arch/riscv/include/asm/smp.h |  9 +++++++++
 arch/riscv/kernel/irq.c      |  8 ++++++++
 arch/riscv/kernel/smp.c      | 30 ++++++++++++++++++++++++++++--
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 8145b8657d20..37e909c04f47 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -36,6 +36,8 @@ static inline bool can_hotplug_cpu(void)
 static inline void arch_send_call_wakeup_ipi(int cpu) { }
 #endif
 
+struct seq_file;
+
 #ifdef CONFIG_SMP
 
 enum ipi_message_type {
@@ -48,6 +50,9 @@ enum ipi_message_type {
 void send_ipi_message(const struct cpumask *to_whom,
 		      enum ipi_message_type operation);
 
+/* print IPI stats */
+void show_ipi_stats(struct seq_file *p, int prec);
+
 /* SMP initialization hook for setup_arch */
 void __init setup_smp(void);
 
@@ -75,6 +80,10 @@ void boot_sec_cpu(void);
 
 #else
 
+static inline void show_ipi_stats(struct seq_file *p, int prec)
+{
+}
+
 static inline int riscv_hartid_to_cpuid(int hartid)
 {
 	return 0;
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 7e14b0d9a71d..96202139ade5 100644
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
 asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long cause)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 629456bb6122..70fd1351d6d9 100644
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
 
+static const char *ipi_names[] = {
+	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
+	[IPI_CALL_FUNC]		= "Function call interrupts",
+	[IPI_CALL_WAKEUP]	= "CPU wake-up interrupts",
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

