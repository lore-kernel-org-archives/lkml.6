Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9A1C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB465249C1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="H9FwNafX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB465249C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754795AbeFVXVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 19:21:22 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33822 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754646AbeFVXVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 19:21:18 -0400
Received: by mail-pg0-f66.google.com with SMTP id q4-v6so3592162pgr.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 16:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=7F306BW2KRx/vbnJht/X3Eumvy4LvcOZO6dhrR/nS3E=;
        b=H9FwNafXbZfvUr9+zULu+22mlb4oxp2Xz/IYaHM8h3HvY+gkU8h1zMBHKyTmcJ6yk3
         DJgo59Y+cr9qFcNrtvmNlYWgeNtyzrQsdTd44hfddunGyT7XXfZpxl7HkO+jFH+bZt2o
         8Y6VvKDrylXSm10wncz89VpFInX5l7vdZtxGR8tgUieZFCNAMlk+ISZ2ew6raDV+ugBY
         JMuFaBv9FiVIfAtyOHqa7qwgkZKmhFSOaQbyQ9lOKM91IAYwmU64ZL45ZqBNNAiwx2sB
         uD0fps1trv8rGtFrQ6Ky95vjYV49Sgauazd8NEh6GAfvfTiiG24ouEv2+DJEwd2QoYrP
         Idiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=7F306BW2KRx/vbnJht/X3Eumvy4LvcOZO6dhrR/nS3E=;
        b=rgbmk6Fqym1/WPPCtT+KiBWmqwGFVH+DcxCF9bqzfAwjrgfAsBYRPxKysbipyeX04O
         9RXgDTKDdsfEjoZzHoFE1dPChkOLF6rkKerUP1bSat6JO+o0osMingwrBcKjgHttYx1K
         jzgf5KTTWcBYQtp1kpSE3PU4WUt/94nkIt9YvdB/CD4D23FU/zrMc1YU9dlzAhEYPCpc
         PFn/3JqXlAhLLCzfsPAouXSyKv6EZ0l4kHzzVNzc6CmvZ7hi+DI6+VvvDO7cauVr+9bo
         4J/3R0+UhkYS+dG+mFnhlouI5Y/66h/uZH9jxpAUzkPZ4caEwSS6Pm+1+5WgRTaYaHrX
         +Oeg==
X-Gm-Message-State: APt69E1aQzXuEErHdhnVWpwfwfICo3KA45Rq41Hfiy/0xEkdRZGEnP6/
        P/RQ1d3W/Pm+QVWd4WFQYVSI3g==
X-Google-Smtp-Source: ADUXVKI/Spk9d95yiaSxvigUt2ayUsTZjrdHQ1zqOJpD4QOIAYVJAoY+RkPbAKpwwCnSL/CBwK9jpQ==
X-Received: by 2002:a63:a74c:: with SMTP id w12-v6mr3098336pgo.374.1529709677300;
        Fri, 22 Jun 2018 16:21:17 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id u1-v6sm12512807pfn.59.2018.06.22.16.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 16:21:16 -0700 (PDT)
Subject: [PATCH 3/3] irqchip: RISC-V Local Interrupt Controller Driver
Date:   Fri, 22 Jun 2018 16:20:06 -0700
Message-Id: <20180622232006.12158-4-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180622232006.12158-1-palmer@sifive.com>
References: <20180622232006.12158-1-palmer@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        shorne@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Michael Clark <mjc@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@dabbelt.com>

This patch adds a driver that manages the local interrupts on each
RISC-V hart, as specifiec by the RISC-V supervisor level ISA manual.
The local interrupt controller manages software interrupts, timer
interrupts, and hardware interrupts (which are routed via the
platform level interrupt controller).  Per-hart local interrupt
controllers are found on all RISC-V systems.

CC: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 drivers/irqchip/Kconfig          |  13 +++
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-riscv-intc.c | 215 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)
 create mode 100644 drivers/irqchip/irq-riscv-intc.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e9233db16e03..bf7fc86673b1 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -372,3 +372,16 @@ config QCOM_PDC
 	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
 
 endmenu
+
+config RISCV_INTC
+	#bool "RISC-V Interrupt Controller"
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
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 15f268f646bf..74e333cc274c 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -87,3 +87,4 @@ obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
 obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
 obj-$(CONFIG_NDS32)			+= irq-ativic32.o
 obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
+obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
new file mode 100644
index 000000000000..7ca3060e76b4
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -0,0 +1,215 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017-2018 SiFive
+ */
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
+#include <linux/ftrace.h>
+#include <linux/of.h>
+#include <linux/seq_file.h>
+
+#include <asm/ptrace.h>
+#include <asm/sbi.h>
+#include <asm/smp.h>
+
+#define PTR_BITS (8 * sizeof(uintptr_t))
+
+struct riscv_irq_data {
+	struct irq_chip		chip;
+	struct irq_domain	*domain;
+	int			hart;
+	char			name[20];
+};
+DEFINE_PER_CPU(struct riscv_irq_data, riscv_irq_data);
+
+static void riscv_software_interrupt(void)
+{
+#ifdef CONFIG_SMP
+	irqreturn_t ret;
+
+	ret = handle_ipi();
+
+	WARN_ON(ret == IRQ_NONE);
+#else
+	/*
+	 * We currently only use software interrupts to pass inter-processor
+	 * interrupts, so if a non-SMP system gets a software interrupt then we
+	 * don't know what to do.
+	 */
+	pr_warning("Software Interrupt without CONFIG_SMP\n");
+#endif
+}
+
+static void riscv_intc_irq(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+	struct irq_domain *domain;
+	unsigned long cause = csr_read(scause);
+
+	/*
+	 * The high order bit of the trap cause register is always set for
+	 * interrupts, which allows us to differentiate them from exceptions
+	 * quickly.  The INTERRUPT_CAUSE_* macros don't contain that bit, so we
+	 * need to mask it off here.
+	 */
+	WARN_ON((cause & (1UL << (PTR_BITS - 1))) == 0);
+	cause = cause & ~(1UL << (PTR_BITS - 1));
+
+	irq_enter();
+
+	/*
+	 * There are three classes of interrupt: timer, software, and
+	 * external devices.  We dispatch between them here.  External
+	 * device interrupts use the generic IRQ mechanisms.
+	 */
+	switch (cause) {
+	case INTERRUPT_CAUSE_TIMER:
+		riscv_timer_interrupt();
+		break;
+	case INTERRUPT_CAUSE_SOFTWARE:
+		riscv_software_interrupt();
+		break;
+	default:
+		domain = per_cpu(riscv_irq_data, smp_processor_id()).domain;
+		generic_handle_irq(irq_find_mapping(domain, cause));
+		break;
+	}
+
+	irq_exit();
+	set_irq_regs(old_regs);
+}
+
+static int riscv_irqdomain_map(struct irq_domain *d, unsigned int irq,
+			       irq_hw_number_t hwirq)
+{
+	struct riscv_irq_data *data = d->host_data;
+
+	irq_set_chip_and_handler(irq, &data->chip, handle_simple_irq);
+	irq_set_chip_data(irq, data);
+	irq_set_noprobe(irq);
+	irq_set_affinity(irq, cpumask_of(data->hart));
+
+	return 0;
+}
+
+static const struct irq_domain_ops riscv_irqdomain_ops = {
+	.map	= riscv_irqdomain_map,
+	.xlate	= irq_domain_xlate_onecell,
+};
+
+/*
+ * On RISC-V systems local interrupts are masked or unmasked by writing the SIE
+ * (Supervisor Interrupt Enable) CSR.  As CSRs can only be written on the local
+ * hart, these functions can only be called on the hart that corresponds to the
+ * IRQ chip.  They are only called internally to this module, so they BUG_ON if
+ * this condition is violated rather than attempting to handle the error by
+ * forwarding to the target hart, as that's already expected to have been done.
+ */
+static void riscv_irq_mask(struct irq_data *d)
+{
+	struct riscv_irq_data *data = irq_data_get_irq_chip_data(d);
+
+	BUG_ON(smp_processor_id() != data->hart);
+	csr_clear(sie, 1 << (long)d->hwirq);
+}
+
+static void riscv_irq_unmask(struct irq_data *d)
+{
+	struct riscv_irq_data *data = irq_data_get_irq_chip_data(d);
+
+	BUG_ON(smp_processor_id() != data->hart);
+	csr_set(sie, 1 << (long)d->hwirq);
+}
+
+/* Callbacks for twiddling SIE on another hart. */
+static void riscv_irq_enable_helper(void *d)
+{
+	riscv_irq_unmask(d);
+}
+
+static void riscv_irq_disable_helper(void *d)
+{
+	riscv_irq_mask(d);
+}
+
+static void riscv_remote_ctrl(unsigned int cpu, void (*fn)(void *d),
+                              struct irq_data *data)
+{
+	smp_call_function_single(cpu, fn, data, true);
+}
+
+static void riscv_irq_enable(struct irq_data *d)
+{
+	struct riscv_irq_data *data = irq_data_get_irq_chip_data(d);
+
+	/*
+	 * It's only possible to write SIE on the current hart.  This jumps
+	 * over to the target hart if it's not the current one.  It's invalid
+	 * to write SIE on a hart that's not currently running.
+	 */
+	if (data->hart == smp_processor_id())
+		riscv_irq_unmask(d);
+	else if (cpu_online(data->hart))
+		riscv_remote_ctrl(data->hart, riscv_irq_enable_helper, d);
+	else
+		WARN_ON_ONCE(1);
+}
+
+static void riscv_irq_disable(struct irq_data *d)
+{
+	struct riscv_irq_data *data = irq_data_get_irq_chip_data(d);
+
+	/*
+	 * It's only possible to write SIE on the current hart.  This jumps
+	 * over to the target hart if it's not the current one.  It's invalid
+	 * to write SIE on a hart that's not currently running.
+	 */
+	if (data->hart == smp_processor_id())
+		riscv_irq_mask(d);
+	else if (cpu_online(data->hart))
+		riscv_remote_ctrl(data->hart, riscv_irq_disable_helper, d);
+	else
+		WARN_ON_ONCE(1);
+}
+
+static int __init riscv_intc_init(struct device_node *node, struct device_node *parent)
+{
+	int hart;
+	struct riscv_irq_data *data;
+
+	if (parent)
+		return 0;
+
+	hart = riscv_of_processor_hart(node->parent);
+	if (hart < 0)
+		return -EIO;
+
+	data = &per_cpu(riscv_irq_data, hart);
+	snprintf(data->name, sizeof(data->name), "riscv,cpu_intc,%d", hart);
+	data->hart = hart;
+	data->chip.name = data->name;
+	data->chip.irq_mask = riscv_irq_mask;
+	data->chip.irq_unmask = riscv_irq_unmask;
+	data->chip.irq_enable = riscv_irq_enable;
+	data->chip.irq_disable = riscv_irq_disable;
+	data->domain = irq_domain_add_linear(node, PTR_BITS,
+					     &riscv_irqdomain_ops, data);
+	if (!data->domain)
+		goto error_add_linear;
+
+	set_handle_irq(&riscv_intc_irq);
+
+	pr_info("%s: %lu local interrupts mapped\n", data->name, PTR_BITS);
+	return 0;
+
+error_add_linear:
+	pr_warning("%s: unable to add IRQ domain\n",
+		   data->name);
+	return -ENXIO;
+}
+
+IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
-- 
2.16.4

