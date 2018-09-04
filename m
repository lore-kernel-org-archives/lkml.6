Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B342CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4B32082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="xZbGjSlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4B32082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeIDRML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:12:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43698 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeIDRML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:12:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id x6-v6so1582627plv.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 05:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xCtpF/SUSM6i86wme8H/evRhGjGiqPLInmg5oyQMX7A=;
        b=xZbGjSlGLNNIL8DeiHDAOt1/g2On9vMfgzZJr1yRNbGm0pk4jamOQ3xoar13sleK7i
         HlONOepGZEnJPzLYIP3brc/+dxwd0z3gg6XSY4rQSXe4We0idNnBPuw3GJqY7DneXqGk
         BBp22zcHunw+iUkqg96IVdbHuKt4AvNR06xPiOakLAo5r6c+8QqSX3BnIT/YO9rOOwqC
         ry0cb6k5HqVOqT3drfgtD9j8BH8vvXThmqbAOtzjtAjzJx78ynZ2ADxXmWw2RVQDpIF2
         H+Yo2J3AOJ1pVr9y5ZUhD6+doqJJqu5AII97kwyr0epbNNovAYHujrolcMKV/Eof3fdt
         EDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xCtpF/SUSM6i86wme8H/evRhGjGiqPLInmg5oyQMX7A=;
        b=RrI996sth8/wVYj4fiL8nwhGP57Bvq71rKgYeIjai75l2UTiaID1BIcU9Ou2Rk8b4K
         JyIYeJ4OOuQEYLLnSQ3FG0jRzSZLPTf0+JBUoqlWVXyN+EsWEBICp+zMvUTkqSS50nTV
         yWbwQf7uSmuTrp2pTR2yNO5R1eouGmpEYnFCR+tNwkMbpk1NZhUm7MD8f7xII8NynBrR
         dRq2GP84ONLeKePQr6xraFnk21D1k696arCIDAophF7gioDhfIVtARF+qWwybMJkoEPv
         LkUlIIpxlYXwTIvdh/nyX3xbtbxRQploDbavUt8OnblMbNDlZNJmqx42W27sYHRQSdLG
         njOA==
X-Gm-Message-State: APzg51Ar2AQewqkf167D0VzYRkOcLYKPpuC6HTkqnmYDTSzqecF8nbUO
        SmT/2WP8h1fZ9Zo3p0AwLaajyg==
X-Google-Smtp-Source: ANB0VdZRqXJUdPuD3UHXFhjZLTzaWM6ZgAwy299mQnZ4SogpbTRIOowNjx/bZX//3GfdjWpHRUEwsw==
X-Received: by 2002:a17:902:8308:: with SMTP id bd8-v6mr13499181plb.134.1536065231278;
        Tue, 04 Sep 2018 05:47:11 -0700 (PDT)
Received: from anup-ubuntu64.wlan.qualcomm.com ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id p11-v6sm31621773pfj.72.2018.09.04.05.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 05:47:10 -0700 (PDT)
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
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: [RFC PATCH 4/5] irqchip: RISC-V Local Interrupt Controller Driver
Date:   Tue,  4 Sep 2018 18:15:13 +0530
Message-Id: <20180904124514.6290-5-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180904124514.6290-1-anup@brainfault.org>
References: <20180904124514.6290-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V local interrupt controller manages software interrupts,
timer interrupts, external interrupts (which are routed via the
platform level interrupt controller) and per-HART local interrupts.

This patch add a driver for RISC-V local interrupt controller. It's
a major re-write over perviously submitted version.
(Refer, https://www.spinics.net/lists/devicetree/msg241230.html)

Few advantages of this new driver over previous one are:
1. It registers all local interrupts as per-CPU interrupts
2. We can develop drivers for devices with per-CPU local interrupts
without changing arch code or this driver
3. It allows local interrupt controller DT node under each CPU DT node
as well as single system-wide DT node for local interrupt controller.

The RISC-V INTC driver is compliant with RISC-V Hart-Level Interrupt
Controller DT bindings located at:
Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt

Signed-off-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/include/asm/irq.h      |  15 ++-
 arch/riscv/kernel/irq.c           |  59 +----------
 drivers/irqchip/Kconfig           |  15 ++-
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-riscv-intc.c  | 164 ++++++++++++++++++++++++++++++
 drivers/irqchip/irq-sifive-plic.c |  21 +++-
 include/linux/cpuhotplug.h        |   1 +
 7 files changed, 214 insertions(+), 62 deletions(-)
 create mode 100644 drivers/irqchip/irq-riscv-intc.c

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 93eb75eac4ff..fe503d71876a 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -15,7 +15,20 @@
 #ifndef _ASM_RISCV_IRQ_H
 #define _ASM_RISCV_IRQ_H
 
-#define NR_IRQS         0
+/*
+ * Possible interrupt causes:
+ */
+#define INTERRUPT_CAUSE_SOFTWARE    1
+#define INTERRUPT_CAUSE_TIMER       5
+#define INTERRUPT_CAUSE_EXTERNAL    9
+
+/*
+ * The high order bit of the trap cause register is always set for
+ * interrupts, which allows us to differentiate them from exceptions
+ * quickly.  The INTERRUPT_CAUSE_* macros don't contain that bit, so we
+ * need to mask it off.
+ */
+#define INTERRUPT_CAUSE_FLAG	(1UL << (__riscv_xlen - 1))
 
 void riscv_timer_interrupt(void);
 
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index c51c9b402e87..46a311e5f0f6 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -7,69 +7,16 @@
 
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
-#include <linux/irqdomain.h>
-
-#include <asm/sbi.h>
-
-/*
- * Possible interrupt causes:
- */
-#define INTERRUPT_CAUSE_SOFTWARE    1
-#define INTERRUPT_CAUSE_TIMER       5
-#define INTERRUPT_CAUSE_EXTERNAL    9
-
-/*
- * The high order bit of the trap cause register is always set for
- * interrupts, which allows us to differentiate them from exceptions
- * quickly.  The INTERRUPT_CAUSE_* macros don't contain that bit, so we
- * need to mask it off.
- */
-#define INTERRUPT_CAUSE_FLAG	(1UL << (__riscv_xlen - 1))
 
 asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs)
 {
-	struct pt_regs *old_regs;
-
-	switch (regs->scause & ~INTERRUPT_CAUSE_FLAG) {
-	case INTERRUPT_CAUSE_TIMER:
-		old_regs = set_irq_regs(regs);
-		irq_enter();
-		riscv_timer_interrupt();
-		irq_exit();
-		set_irq_regs(old_regs);
-		break;
-#ifdef CONFIG_SMP
-	case INTERRUPT_CAUSE_SOFTWARE:
-		/*
-		 * We only use software interrupts to pass IPIs, so if a non-SMP
-		 * system gets one, then we don't know what to do.
-		 */
-		handle_IPI(regs);
-		break;
-#endif
-	case INTERRUPT_CAUSE_EXTERNAL:
-		old_regs = set_irq_regs(regs);
-		irq_enter();
+	if (handle_arch_irq)
 		handle_arch_irq(regs);
-		irq_exit();
-		set_irq_regs(old_regs);
-		break;
-	default:
-		panic("unexpected interrupt cause");
-	}
-}
-
-#ifdef CONFIG_SMP
-static void smp_ipi_trigger_sbi(const struct cpumask *to_whom)
-{
-	sbi_send_ipi(cpumask_bits(to_whom));
 }
-#endif
 
 void __init init_IRQ(void)
 {
 	irqchip_init();
-#ifdef CONFIG_SMP
-	set_smp_ipi_trigger(smp_ipi_trigger_sbi);
-#endif
+	if (!handle_arch_irq)
+		panic("No interrupt controller found.");
 }
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 383e7b70221d..885e182586f4 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -371,7 +371,18 @@ config QCOM_PDC
 	  Power Domain Controller driver to manage and configure wakeup
 	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
 
-endmenu
+config RISCV_INTC
+	bool "RISC-V Interrupt Controller"
+	depends on RISCV
+	default y
+	help
+	   This enables support for the local interrupt controller found in
+	   standard RISC-V systems.  The local interrupt controller handles
+	   timer interrupts, software interrupts, and hardware interrupts.
+	   Without a local interrupt controller the system will be unable to
+	   handle any interrupts, including those passed via the PLIC.
+
+	   If you don't know what to do here, say Y.
 
 config SIFIVE_PLIC
 	bool "SiFive Platform-Level Interrupt Controller"
@@ -384,3 +395,5 @@ config SIFIVE_PLIC
 	   interrupt sources are subordinate to the PLIC.
 
 	   If you don't know what to do here, say Y.
+
+endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index fbd1ec8070ef..e638ee5c4452 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -87,4 +87,5 @@ obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
 obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
 obj-$(CONFIG_NDS32)			+= irq-ativic32.o
 obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
+obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
new file mode 100644
index 000000000000..c80502a1e12b
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017-2018 SiFive
+ * Copyright (C) 2018 Anup Patel
+ */
+
+#define pr_fmt(fmt) "riscv-intc: " fmt
+#include <linux/atomic.h>
+#include <linux/bits.h>
+#include <linux/cpu.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/smp.h>
+#include <asm/sbi.h>
+
+static struct irq_domain *intc_domain;
+static atomic_t intc_init = ATOMIC_INIT(0);
+
+static void riscv_intc_irq(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs;
+	unsigned long cause = regs->scause & ~INTERRUPT_CAUSE_FLAG;
+
+	if (unlikely(cause >= BITS_PER_LONG))
+		panic("unexpected interrupt cause");
+
+	switch (cause) {
+	case INTERRUPT_CAUSE_TIMER:
+		old_regs = set_irq_regs(regs);
+		irq_enter();
+		riscv_timer_interrupt();
+		irq_exit();
+		set_irq_regs(old_regs);
+		break;
+#ifdef CONFIG_SMP
+	case INTERRUPT_CAUSE_SOFTWARE:
+		/*
+		 * We only use software interrupts to pass IPIs, so if a non-SMP
+		 * system gets one, then we don't know what to do.
+		 */
+		handle_IPI(regs);
+		break;
+#endif
+	default:
+		handle_domain_irq(intc_domain, cause, regs);
+		break;
+	}
+}
+
+/*
+ * On RISC-V systems local interrupts are masked or unmasked by writing the SIE
+ * (Supervisor Interrupt Enable) CSR.  As CSRs can only be written on the local
+ * hart, these functions can only be called on the hart that corresponds to the
+ * IRQ chip.  They are only called internally to this module, so they BUG_ON if
+ * this condition is violated rather than attempting to handle the error by
+ * forwarding to the target hart, as that's already expected to have been done.
+ */
+static void riscv_intc_irq_mask(struct irq_data *d)
+{
+	csr_clear(sie, 1 << (long)d->hwirq);
+}
+
+static void riscv_intc_irq_unmask(struct irq_data *d)
+{
+	csr_set(sie, 1 << (long)d->hwirq);
+}
+
+#ifdef CONFIG_SMP
+static void riscv_intc_ipi_trigger(const struct cpumask *to_whom)
+{
+	sbi_send_ipi(cpumask_bits(to_whom));
+}
+
+static int riscv_intc_cpu_starting(unsigned int cpu)
+{
+	csr_set(sie, 1 << INTERRUPT_CAUSE_SOFTWARE);
+	return 0;
+}
+
+static int riscv_intc_cpu_dying(unsigned int cpu)
+{
+	csr_clear(sie, 1 << INTERRUPT_CAUSE_SOFTWARE);
+	return 0;
+}
+
+static void riscv_intc_smp_init(void)
+{
+	csr_write(sie, 0);
+	csr_write(sip, 0);
+
+	set_smp_ipi_trigger(riscv_intc_ipi_trigger);
+
+	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_STARTING,
+			  "irqchip/riscv/intc:starting",
+			  riscv_intc_cpu_starting,
+			  riscv_intc_cpu_dying);
+
+}
+#else
+static void riscv_intc_smp_init(void)
+{
+	csr_write(sie, 0);
+	csr_write(sip, 0);
+}
+#endif
+
+static struct irq_chip riscv_intc_chip = {
+	.name = "RISC-V INTC",
+	.irq_mask = riscv_intc_irq_mask,
+	.irq_unmask = riscv_intc_irq_unmask,
+};
+
+static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
+				 irq_hw_number_t hwirq)
+{
+	irq_set_percpu_devid(irq);
+	irq_domain_set_info(d, irq, hwirq, &riscv_intc_chip, d->host_data,
+			    handle_percpu_devid_irq, NULL, NULL);
+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
+
+	return 0;
+}
+
+static const struct irq_domain_ops riscv_intc_domain_ops = {
+	.map	= riscv_intc_domain_map,
+	.xlate	= irq_domain_xlate_onecell,
+};
+
+static int __init riscv_intc_init(struct device_node *node,
+				  struct device_node *parent)
+{
+	/*
+	 * RISC-V device trees can have one INTC DT node under
+	 * each CPU DT node so INTC init function will be called
+	 * once for each INTC DT node. We only need to do INTC
+	 * init once for boot CPU so we use atomic counter to
+	 * achieve this.
+	 */
+	if (atomic_inc_return(&intc_init) > 1)
+		return 0;
+
+	intc_domain = irq_domain_add_linear(node, BITS_PER_LONG,
+					    &riscv_intc_domain_ops, NULL);
+	if (!intc_domain)
+		goto error_add_linear;
+
+	set_handle_irq(&riscv_intc_irq);
+
+	riscv_intc_smp_init();
+
+	pr_info("%lu local interrupts mapped\n", (long)BITS_PER_LONG);
+
+	return 0;
+
+error_add_linear:
+	pr_warn("unable to add IRQ domain\n");
+	return -ENXIO;
+}
+
+IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 532e9d68c704..ab9614d5a2b4 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -8,6 +8,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -146,14 +147,17 @@ static struct irq_domain *plic_irqdomain;
  * that source ID back to the same claim register.  This automatically enables
  * and disables the interrupt, so there's nothing else to do.
  */
-static void plic_handle_irq(struct pt_regs *regs)
+static void plic_handle_irq(struct irq_desc *desc)
 {
 	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	void __iomem *claim = plic_hart_offset(handler->ctxid) + CONTEXT_CLAIM;
 	irq_hw_number_t hwirq;
 
 	WARN_ON_ONCE(!handler->present);
 
+	chained_irq_enter(chip, desc);
+
 	csr_clear(sie, SIE_SEIE);
 	while ((hwirq = readl(claim))) {
 		int irq = irq_find_mapping(plic_irqdomain, hwirq);
@@ -166,6 +170,8 @@ static void plic_handle_irq(struct pt_regs *regs)
 		writel(hwirq, claim);
 	}
 	csr_set(sie, SIE_SEIE);
+
+	chained_irq_exit(chip, desc);
 }
 
 /*
@@ -183,7 +189,7 @@ static int plic_find_hart_id(struct device_node *node)
 }
 
 static int __init plic_init(struct device_node *node,
-		struct device_node *parent)
+			    struct device_node *parent)
 {
 	int error = 0, nr_handlers, nr_mapped = 0, i;
 	u32 nr_irqs;
@@ -218,7 +224,7 @@ static int __init plic_init(struct device_node *node,
 		struct of_phandle_args parent;
 		struct plic_handler *handler;
 		irq_hw_number_t hwirq;
-		int cpu;
+		int cpu, parent_irq;
 
 		if (of_irq_parse_one(node, i, &parent)) {
 			pr_err("failed to parse parent for context %d.\n", i);
@@ -229,6 +235,13 @@ static int __init plic_init(struct device_node *node,
 		if (parent.args[0] == -1)
 			continue;
 
+		if (irq_find_host(parent.np)) {
+			parent_irq = irq_of_parse_and_map(node, i);
+			if (parent_irq)
+				irq_set_chained_handler(parent_irq,
+							plic_handle_irq);
+		}
+
 		cpu = plic_find_hart_id(parent.np);
 		if (cpu < 0) {
 			pr_warn("failed to parse hart ID for context %d.\n", i);
@@ -248,7 +261,7 @@ static int __init plic_init(struct device_node *node,
 
 	pr_info("mapped %d interrupts to %d (out of %d) handlers.\n",
 		nr_irqs, nr_mapped, nr_handlers);
-	set_handle_irq(plic_handle_irq);
+
 	return 0;
 
 out_iounmap:
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index caf40ad0bbc6..ca7268a38cef 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -100,6 +100,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_ARMADA_XP_STARTING,
 	CPUHP_AP_IRQ_BCM2836_STARTING,
 	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
+	CPUHP_AP_IRQ_RISCV_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
 	CPUHP_AP_PERF_X86_STARTING,
-- 
2.17.1

