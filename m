Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9055DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEC320672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQO6iO8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FEC320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633087AbeKXDja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:39:30 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44661 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbeKXDj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:39:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id k8so221380pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 08:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WW3J8j9iZqfBD+hZUUX3dXfVR9VrJwd4siyzP2VyQYA=;
        b=hQO6iO8C59nWlhe9pXkXGrxshbku1Fl6s6jjEdYiS+WKFYNXsWkOXf4/6aPBSadsp2
         4XeqPFp35cVQa11Tm+iXbYDXTI6ArHM7w0uEHoT/t1mysKdYyVAWN3f+CphGgUsUChH1
         Y6NlV+1wTUzSh1hIh4Ya/LAiXu0SmW5Y2+A0dWaICWy637G6qtvHTYyke4eCA1FWzcYS
         yBucaBjEfm+RyVSxjclX54wNYCSMvVC5ivnWPYkwk5YhNg5kxlK8GEak+TpXf64ImFuB
         3+8tGOjrMYLJA+BVWmFFDo7r98grPWGlYu7Uf6HePfORYmstOHA89GfnD/dzGXudr0/O
         ofAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WW3J8j9iZqfBD+hZUUX3dXfVR9VrJwd4siyzP2VyQYA=;
        b=AHSMfKD4KT3pVkIqLyCIpu6IK5PhbedYxmAv3D1U6WmAR6KRKBzzZ3/w+z7NYTUWAf
         TXSbQyFuHwonzdeoUc51Vb5FmBsMdLHe62US8tN43/khWD/gBu603XU93PM/lvvYGKaV
         qcqLXen67T5CgSdQrlsiH4tXVY6vIyfDILL17ZuRpjL///UFyo0fAr8y7829Eh1g7eM+
         KgXLU5191Mf5l6ABie+98yfNlmTL6fCTOnr5tvoH2U5SV72zV0VELgGwo//b+2xmqJyw
         u2UafoMsVvfv07iwdGo0Z1jLkeiYQbxeuDYrWQrXNPwaP1e1OGGGiwteCjESk6HhB+uN
         opkA==
X-Gm-Message-State: AA+aEWbaAIvg5c3hJHoEvLasht2WuOJApjGmKZJlKwf7ve9d+yxE8RIU
        38gBh/SfJpGT0uLF3KBeCkQ=
X-Google-Smtp-Source: AFSGD/VIExSGMpleWx80wksg4Ql7daWG6aG+OpJ51gZQCXuzyK532ZIYUIXobaQHjjdSM0yq8ZpwbA==
X-Received: by 2002:a17:902:102b:: with SMTP id b40-v6mr16616767pla.319.1542992068016;
        Fri, 23 Nov 2018 08:54:28 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id v70sm19118326pfa.152.2018.11.23.08.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 08:54:26 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        marc.w.gonzalez@free.fr, mans@mansr.com
Cc:     linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] irqchhip: Convert to using %pOFn instead of device_node.name
Date:   Fri, 23 Nov 2018 11:54:18 -0500
Message-Id: <20181123165418.27745-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/irqchip/irq-mscc-ocelot.c |  6 +++---
 drivers/irqchip/irq-stm32-exti.c  |  6 +++---
 drivers/irqchip/irq-tango.c       | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index b63e40c00a02..88143c0b700c 100644
--- a/drivers/irqchip/irq-mscc-ocelot.c
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -72,7 +72,7 @@ static int __init ocelot_irq_init(struct device_node *node,
 	domain = irq_domain_add_linear(node, OCELOT_NR_IRQ,
 				       &irq_generic_chip_ops, NULL);
 	if (!domain) {
-		pr_err("%s: unable to add irq domain\n", node->name);
+		pr_err("%pOFn: unable to add irq domain\n", node);
 		return -ENOMEM;
 	}
 
@@ -80,14 +80,14 @@ static int __init ocelot_irq_init(struct device_node *node,
 					     "icpu", handle_level_irq,
 					     0, 0, 0);
 	if (ret) {
-		pr_err("%s: unable to alloc irq domain gc\n", node->name);
+		pr_err("%pOFn: unable to alloc irq domain gc\n", node);
 		goto err_domain_remove;
 	}
 
 	gc = irq_get_domain_generic_chip(domain, 0);
 	gc->reg_base = of_iomap(node, 0);
 	if (!gc->reg_base) {
-		pr_err("%s: unable to map resource\n", node->name);
+		pr_err("%pOFn: unable to map resource\n", node);
 		ret = -ENOMEM;
 		goto err_gc_free;
 	}
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 0a2088e12d96..363385750fa7 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -678,8 +678,8 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 	domain = irq_domain_add_linear(node, drv_data->bank_nr * IRQS_PER_BANK,
 				       &irq_exti_domain_ops, NULL);
 	if (!domain) {
-		pr_err("%s: Could not register interrupt domain.\n",
-		       node->name);
+		pr_err("%pOFn: Could not register interrupt domain.\n",
+		       node);
 		ret = -ENOMEM;
 		goto out_unmap;
 	}
@@ -768,7 +768,7 @@ __init stm32_exti_hierarchy_init(const struct stm32_exti_drv_data *drv_data,
 					  host_data);
 
 	if (!domain) {
-		pr_err("%s: Could not register exti domain.\n", node->name);
+		pr_err("%pOFn: Could not register exti domain.\n", node);
 		ret = -ENOMEM;
 		goto out_unmap;
 	}
diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
index 580e2d72b9ba..ae28d8648679 100644
--- a/drivers/irqchip/irq-tango.c
+++ b/drivers/irqchip/irq-tango.c
@@ -184,11 +184,11 @@ static int __init tangox_irq_init(void __iomem *base, struct resource *baseres,
 
 	irq = irq_of_parse_and_map(node, 0);
 	if (!irq)
-		panic("%s: failed to get IRQ", node->name);
+		panic("%pOFn: failed to get IRQ", node);
 
 	err = of_address_to_resource(node, 0, &res);
 	if (err)
-		panic("%s: failed to get address", node->name);
+		panic("%pOFn: failed to get address", node);
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	chip->ctl = res.start - baseres->start;
@@ -196,12 +196,12 @@ static int __init tangox_irq_init(void __iomem *base, struct resource *baseres,
 
 	dom = irq_domain_add_linear(node, 64, &irq_generic_chip_ops, chip);
 	if (!dom)
-		panic("%s: failed to create irqdomain", node->name);
+		panic("%pOFn: failed to create irqdomain", node);
 
 	err = irq_alloc_domain_generic_chips(dom, 32, 2, node->name,
 					     handle_level_irq, 0, 0, 0);
 	if (err)
-		panic("%s: failed to allocate irqchip", node->name);
+		panic("%pOFn: failed to allocate irqchip", node);
 
 	tangox_irq_domain_init(dom);
 
@@ -219,7 +219,7 @@ static int __init tangox_of_irq_init(struct device_node *node,
 
 	base = of_iomap(node, 0);
 	if (!base)
-		panic("%s: of_iomap failed", node->name);
+		panic("%pOFn: of_iomap failed", node);
 
 	of_address_to_resource(node, 0, &res);
 
-- 
2.17.0

