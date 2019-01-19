Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F453C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 05:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1E42086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 05:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="f/6EgnVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfASF5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 00:57:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39719 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfASF5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 00:57:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so7051498pgl.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 21:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zz52nPvPtFJqyPj2XZVPMynhhMIZtDAuu6S8fhVpQdc=;
        b=f/6EgnVaPcImxeZ24fW1x3B5RgtHb20eZMqTQ96nYxSVMUllIaqDMVJprUUnRUxpsn
         mKCOlaefUjQF3kfbvkVxg28riYDbStDjlKgTaSm3dQD6JQpCiQKEwsv8OUl8dgawEYPo
         ic5/xhdDU1M0ZhHGZDicrWjpwYif6fPWPpwaDJbC1zxvXFziFUbVGlFi+7lbKOZjMHiE
         RydhpZA+l2O8O9BVWgo5WzkOL83oNG5WbLSb7Nc9J7/W8LDtSANpWGPGD8G5NfkIMgpm
         jpE1L/Hbq8tEco++PE4lo3gXhBwS/RjUyhOp6mhQdRdhG3tDcLesyYVvPTCWNPDMXRRu
         kRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zz52nPvPtFJqyPj2XZVPMynhhMIZtDAuu6S8fhVpQdc=;
        b=PaGtcilzTlP464k86eOGdesvDbOzPigDZQpMTewP4D4/TlaILz7fmpF6v4DOQRNgtZ
         M0g4zaE1+FXmESVpxAkKftiU57+/QB53II+uv0NBvJIhXGvrk9gg/Il9n78b8ySCDA8C
         cZSSPnwQL4D0QBJIYh4POBQTUz9SR1Qn5OIdwoCTJ9c5E173q+uHFW+2oyy2TBJ1krBx
         yQJNiMPKpHxnYrWHbcdNMHl0/ycKOSgX5H8HeZ81Bz7afiBCcQoCcvzioAnc4Ggp9ZK1
         7LjR2F/51/HjezXcjU1dYnwSUvskv2XMh6BH13OOd8LTQajPj0GM/kBNhn0chVzf1PBR
         OSPg==
X-Gm-Message-State: AJcUukfB2z5Y/Q0GoZKE6JDkRoCUQe2BgfLwGs+q4ituMDe2Wjgft17i
        njgUicmBD8XRE7WrvW4u46if0A==
X-Google-Smtp-Source: ALg8bN5yaqJwyxbRwG4IIcWKUrLsn+0tH7+5XWFIVPrlf3zW4l96BtUsxikPVWNhTZZqfJ6OEB+Eiw==
X-Received: by 2002:a63:4e15:: with SMTP id c21mr20644687pgb.50.1547877437499;
        Fri, 18 Jan 2019 21:57:17 -0800 (PST)
Received: from localhost.localdomain ([49.207.51.221])
        by smtp.gmail.com with ESMTPSA id c7sm9295535pfh.18.2019.01.18.21.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 21:57:16 -0800 (PST)
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
Subject: [PATCH v5 4/5] irqchip: sifive-plic: Differentiate between PLIC handler and context
Date:   Sat, 19 Jan 2019 11:26:24 +0530
Message-Id: <20190119055625.100054-5-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190119055625.100054-1-anup@brainfault.org>
References: <20190119055625.100054-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We explicitly differentiate between PLIC handler and context because
PLIC context is for given mode of HART whereas PLIC handler is per-CPU
software construct meant for handling interrupts from a particular
PLIC context.

To achieve this differentiation, we rename "nr_handlers" to "nr_contexts"
and "nr_mapped" to "nr_handlers" in plic_init().

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 drivers/irqchip/irq-sifive-plic.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index b9a0bcefe426..24c906f4be93 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -177,7 +177,7 @@ static int plic_find_hart_id(struct device_node *node)
 static int __init plic_init(struct device_node *node,
 		struct device_node *parent)
 {
-	int error = 0, nr_handlers, nr_mapped = 0, i;
+	int error = 0, nr_contexts, nr_handlers = 0, i;
 	u32 nr_irqs;
 
 	if (plic_regs) {
@@ -194,10 +194,10 @@ static int __init plic_init(struct device_node *node,
 	if (WARN_ON(!nr_irqs))
 		goto out_iounmap;
 
-	nr_handlers = of_irq_count(node);
-	if (WARN_ON(!nr_handlers))
+	nr_contexts = of_irq_count(node);
+	if (WARN_ON(!nr_contexts))
 		goto out_iounmap;
-	if (WARN_ON(nr_handlers < num_possible_cpus()))
+	if (WARN_ON(nr_contexts < num_possible_cpus()))
 		goto out_iounmap;
 
 	error = -ENOMEM;
@@ -206,7 +206,7 @@ static int __init plic_init(struct device_node *node,
 	if (WARN_ON(!plic_irqdomain))
 		goto out_iounmap;
 
-	for (i = 0; i < nr_handlers; i++) {
+	for (i = 0; i < nr_contexts; i++) {
 		struct of_phandle_args parent;
 		struct plic_handler *handler;
 		irq_hw_number_t hwirq;
@@ -245,11 +245,11 @@ static int __init plic_init(struct device_node *node,
 		writel(0, handler->hart_base + CONTEXT_THRESHOLD);
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
 			plic_toggle(handler, hwirq, 0);
-		nr_mapped++;
+		nr_handlers++;
 	}
 
-	pr_info("mapped %d interrupts to %d (out of %d) handlers.\n",
-		nr_irqs, nr_mapped, nr_handlers);
+	pr_info("mapped %d interrupts with %d handlers for %d contexts.\n",
+		nr_irqs, nr_handlers, nr_contexts);
 	set_handle_irq(plic_handle_irq);
 	return 0;
 
-- 
2.17.1

