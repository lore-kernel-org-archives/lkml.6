Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B9FC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDEC2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAllNThr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDEC2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbeJARHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:07:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53339 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbeJARH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:07:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id b19-v6so8205267wme.3;
        Mon, 01 Oct 2018 03:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lv5fgwVngiSUCZ65IESqPJcG9y3aI8hBjWgPOfOBa3o=;
        b=WAllNThrKjrHE3iAEPkzNM6UZAHVYcLBnVNrDRjbtMLthkl0ftZ7/UxSP67oR4eLvb
         TSlsnjw5xrmVMEjhOJYpP5Ga9VNdyq5nNiM3JtS3au56l9UisEJMFnbIAJhlye0qmYDD
         otwOp0qiAUZJDsqRAFG8xBcVhkvygzcCA1AErF9Eu0DM1dmTO9nXNp7P5UIe/ETFcV0Y
         yQLp5WEhWNa0qUBfN7eRCKUaGRiJi5aAtyiJZjmY6QlwBEwx/tf3AbJuUDEiEqz6CBLB
         cwRomLgPGF0iafpnszpGt3dRB4OPuqsugbYLNFiR0UIqZLR06codfuCy3IL7eRq+0Djf
         cvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lv5fgwVngiSUCZ65IESqPJcG9y3aI8hBjWgPOfOBa3o=;
        b=S10/cD9yruuFzkdEAu/dWxmmgKtR9Gs25zvfpJ4uacveKhL9Ex/wei+E18CLFtIdRJ
         Mw1NtaUAZTptQ1IX58Ouoyu/GcAcAdYOEcvTqKIaH91EhYQqWVJjFV5wiEaO8I1VcJuM
         /QuCQjPEkXeWsgJzjmMW1Y/5Pfl5AaCleoazEjKSUu1Z3jR6nSgSTKTKEMe0JntMoDKq
         ouleM7Vqq4eU1/xmoZJtm/QGHd1yZykLh1u7anVOxa5eBCvIxYwFY1PaetSei9jwET1B
         HNho+1YAhnwWkXD5CiHIRKhqFrAWWFpjHmjlgtPaT1TrKU9CTm4YJL+r/6qrqyW/z8V+
         4ATQ==
X-Gm-Message-State: ABuFfoiY08VwPhQjZ31AwyBNPJGo7JqTPDtWxTdcy5DLO0akb24yMW+0
        JVpciPO5JgtTzFcH7ALR/cg=
X-Google-Smtp-Source: ACcGV617gxDpdT9e+aAeQLFvWcMl+0rX0Iw9v9tF1rhgXMs3g+iSea78C/GLDyMZDNhwOJBNmKyW/Q==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26-v6mr8806025wmh.61.1538389820465;
        Mon, 01 Oct 2018 03:30:20 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id g8-v6sm2461169wmf.45.2018.10.01.03.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 03:30:19 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 3/7] irqchip/rtl8186: Add RTL8186 interrupt controller driver
Date:   Mon,  1 Oct 2018 13:29:48 +0300
Message-Id: <20181001102952.7913-4-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001102952.7913-1-yasha.che3@gmail.com>
References: <20181001102952.7913-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Realtek RTL8186 SoC is a MIPS based SoC
used in some home routers [1][2].

This adds a driver to handle the interrupt controller
on this SoC.

[1] https://www.linux-mips.org/wiki/Realtek_SOC#Realtek_RTL8186
[2] https://wikidevi.com/wiki/Realtek_RTL8186

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/irqchip/Kconfig       |   5 ++
 drivers/irqchip/Makefile      |   1 +
 drivers/irqchip/irq-rtl8186.c | 107 ++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 drivers/irqchip/irq-rtl8186.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e9233db16e03..83099905a871 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -371,4 +371,9 @@ config QCOM_PDC
 	  Power Domain Controller driver to manage and configure wakeup
 	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
 
+config RTL8186_IRQ
+	bool
+	depends on MACH_RTL8186
+	select IRQ_DOMAIN
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 15f268f646bf..2e0bb859a8f4 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -87,3 +87,4 @@ obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
 obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
 obj-$(CONFIG_NDS32)			+= irq-ativic32.o
 obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
+obj-$(CONFIG_RTL8186_IRQ)		+= irq-rtl8186.o
diff --git a/drivers/irqchip/irq-rtl8186.c b/drivers/irqchip/irq-rtl8186.c
new file mode 100644
index 000000000000..3eb6b947d5a0
--- /dev/null
+++ b/drivers/irqchip/irq-rtl8186.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Realtek RTL8186 SoC interrupt controller driver.
+ *
+ * Copyright (C) 2018 Yasha Cherikovsky
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#define RTL8186_NR_IRQS 11
+
+#define GIMR 0x00
+#define GISR 0x04
+
+static struct {
+	void __iomem *base;
+	struct irq_domain *domain;
+} intc;
+
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	u32 hwirq, virq;
+	u32 gimr = readl(intc.base + GIMR);
+	u32 gisr = readl(intc.base + GISR);
+	u32 pending = gimr & gisr & ((1 << RTL8186_NR_IRQS) - 1);
+
+	if (!pending) {
+		spurious_interrupt();
+		return;
+	}
+
+	while (pending) {
+		hwirq = fls(pending) - 1;
+		virq = irq_linear_revmap(intc.domain, hwirq);
+		do_IRQ(virq);
+		pending &= ~BIT(hwirq);
+	}
+}
+
+static void rtl8186_irq_mask(struct irq_data *data)
+{
+	unsigned long irq = data->hwirq;
+
+	writel(readl(intc.base + GIMR) & (~(BIT(irq))), intc.base + GIMR);
+}
+
+static void rtl8186_irq_unmask(struct irq_data *data)
+{
+	unsigned long irq = data->hwirq;
+
+	writel((readl(intc.base + GIMR) | (BIT(irq))), intc.base + GIMR);
+}
+
+static struct irq_chip rtl8186_irq_chip = {
+	.name = "RTL8186",
+	.irq_mask = rtl8186_irq_mask,
+	.irq_unmask = rtl8186_irq_unmask,
+};
+
+static int rtl8186_intc_irq_domain_map(struct irq_domain *d, unsigned int virq,
+				       irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(virq, &rtl8186_irq_chip, handle_level_irq);
+	return 0;
+}
+
+static const struct irq_domain_ops rtl8186_irq_ops = {
+	.map = rtl8186_intc_irq_domain_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static int __init rtl8186_intc_of_init(struct device_node *node,
+				       struct device_node *parent)
+{
+	intc.base = of_io_request_and_map(node, 0, of_node_full_name(node));
+
+	if (IS_ERR(intc.base))
+		panic("%pOF: unable to map resource", node);
+
+	intc.domain = irq_domain_add_linear(node, RTL8186_NR_IRQS,
+					    &rtl8186_irq_ops, NULL);
+
+	if (!intc.domain)
+		panic("%pOF: unable to create IRQ domain\n", node);
+
+	/* Start with all interrupts disabled */
+	writel(0, intc.base + GIMR);
+
+	/*
+	 * Enable all hardware interrupts in CP0 status register.
+	 * Software interrupts are disabled.
+	 */
+	set_c0_status(ST0_IM);
+	clear_c0_status(STATUSF_IP0 | STATUSF_IP1);
+	clear_c0_cause(CAUSEF_IP);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(rtl8186_intc, "realtek,rtl8186-intc", rtl8186_intc_of_init);
-- 
2.19.0

