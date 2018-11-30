Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE003C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F6E2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="w/ILh2VV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F6E2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeK3TLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:11:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33496 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeK3TLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:11:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so2172357pgu.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y8woPMXFiJ/bqS4NqZSMmewmTRycAL+/cf63Vbbt8Og=;
        b=w/ILh2VVjIvb0OZr5mEthR5pDNyfJ4RqF0CC5updn9x+yUZ5JCQFeH9LK0n2Jlw+nG
         lavR/ssF/qZdGeBR53w55ygWWcx0zKOrmofHnjani0VuFFUKM3DYIqp/bqxUqbHK69OH
         XOWfF6MQK7mHVSn6PWLUOtpkUcCZy8GLQEdEvuAfbvDJCArAc8oYbFNdi9AOA8CbiRqf
         6mVLYfVaUamIN6W+8xoqF3W+y4c4cY30gjd5fn0ARl0NK5Y9dJ7/vbHy/BdJ80/ZlJt/
         Q79Rt96aih642QXCNkGIMgxFeKUsm6t5FM5vW3B3GiU0g9XPfwZMH2XSkeR16JskCWm2
         Sk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y8woPMXFiJ/bqS4NqZSMmewmTRycAL+/cf63Vbbt8Og=;
        b=mrLpq5DNKEGS7SYBqc+kCaJz/yYY9gRUC3L6eXxMROcZ2IdLo2C5GMhtsiN5vOO8Ba
         +y6BJmibYkKyZ9XChQdab/WgWous3kTLJZaKtDc1wpDgZhM/8x6xLw/O4jgu1TcsDy3o
         7QTlS9M6LnLz3+XiSlD/9EEX99u/odQxMtqnOktxM3TLLTfVCP4CWHKsy+aoRVMdHxoI
         xohx7U8Dm15chgwyK/UiGexh/ognE44PrgO9KqEYbUcVv/fS1XGhLOOgbRSi1+vUm0If
         hg0HPWlXC0OL3hI4nGIVEjHSQK8Lv3q4gNeFmFoUfbV2jT0uwYGB0uDp9MC0n/TGPJb6
         jANQ==
X-Gm-Message-State: AA+aEWbvHY8MUfzwdDyO0JE2McFcGZ3QKIuyWq0aoHEToNXRHQo1guKR
        QofIyjjrJglqEBvXcxY4FTFNsw==
X-Google-Smtp-Source: AFSGD/X4AHzSy9NqZFPoML2SPGN1tycQC1cBP094GX+P9vrmXoBVGeYoFWgsJk4IhYubWnVVYh6CNA==
X-Received: by 2002:a62:5486:: with SMTP id i128mr4533509pfb.215.1543564961520;
        Fri, 30 Nov 2018 00:02:41 -0800 (PST)
Received: from anup-ubuntu64.qualcomm.com ([49.207.52.208])
        by smtp.googlemail.com with ESMTPSA id q187sm19218333pfq.128.2018.11.30.00.02.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 00:02:40 -0800 (PST)
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
Subject: [PATCH v3 5/6] irqchip: sifive-plic: Differentiate between PLIC handler and context
Date:   Fri, 30 Nov 2018 13:32:06 +0530
Message-Id: <20181130080207.20505-6-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130080207.20505-1-anup@brainfault.org>
References: <20181130080207.20505-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We explicitly differentiate between PLIC handler and context because
PLIC context is for given mode of HART whereas PLIC handler is per-CPU
software construct meant for handling interrupts from a particular
PLIC context.

To achieve this differentiation, we rename "nr_handlers" to "nr_contexts"
and "nr_mapped" to "nr_handlers" in struct plic_hw.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 drivers/irqchip/irq-sifive-plic.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 3d4f205f8abe..17269622be21 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -70,8 +70,8 @@ static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
 struct plic_hw {
 	u32			nr_irqs;
+	u32			nr_contexts;
 	u32			nr_handlers;
-	u32			nr_mapped;
 	void __iomem		*regs;
 	struct irq_domain	*irqdomain;
 };
@@ -199,10 +199,10 @@ static int __init plic_init(struct device_node *node,
 	if (WARN_ON(!plic.nr_irqs))
 		goto out_iounmap;
 
-	plic.nr_handlers = of_irq_count(node);
-	if (WARN_ON(!plic.nr_handlers))
+	plic.nr_contexts = of_irq_count(node);
+	if (WARN_ON(!plic.nr_contexts))
 		goto out_iounmap;
-	if (WARN_ON(plic.nr_handlers < num_possible_cpus()))
+	if (WARN_ON(plic.nr_contexts < num_possible_cpus()))
 		goto out_iounmap;
 
 	error = -ENOMEM;
@@ -211,7 +211,7 @@ static int __init plic_init(struct device_node *node,
 	if (WARN_ON(!plic.irqdomain))
 		goto out_iounmap;
 
-	for (i = 0; i < plic.nr_handlers; i++) {
+	for (i = 0; i < plic.nr_contexts; i++) {
 		struct of_phandle_args parent;
 		struct plic_handler *handler;
 		irq_hw_number_t hwirq;
@@ -251,11 +251,11 @@ static int __init plic_init(struct device_node *node,
 		for (hwirq = 1; hwirq <= plic.nr_irqs; hwirq++)
 			plic_toggle(handler, hwirq, 0);
 
-		plic.nr_mapped++;
+		plic.nr_handlers++;
 	}
 
-	pr_info("mapped %d interrupts to %d (out of %d) handlers.\n",
-		plic.nr_irqs, plic.nr_mapped, plic.nr_handlers);
+	pr_info("mapped %d interrupts with %d handlers for %d contexts.\n",
+		plic.nr_irqs, plic.nr_handlers, plic.nr_contexts);
 	set_handle_irq(plic_handle_irq);
 	return 0;
 
-- 
2.17.1

