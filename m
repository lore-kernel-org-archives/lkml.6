Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96B4C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE3020989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hArDA7Lm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE3020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbeLFHb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:31:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37918 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbeLFHbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:31:52 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so11378749plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 23:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/HpNI1L8HsuhwgNUMOu7LqzJncdnpbI+pFBDjt+Ev0s=;
        b=hArDA7Lm4kGvYD1lDfctSAuJsBAoCVyRWdjxivCcrRBeFC9G/Fv+OH7XVQRwxnUJHe
         bRBgvL9Er465ru9Z8rEdtKtSspB5u/0VJivkR3IAsjNHagKvfrFt7s+az3MQPqWxKZ8R
         xs4jQAP2tPx4ciOcIikKXIuBUxgcv0XHUfAn7k18HuEynwESJFx30t9HPmdlIUkUgMCy
         eyiE2rlVEhiqIzzMeqNqruH5izb4Ix3iGw+ZkttCjlCPhObN9f0VSZv2Q6ungWv5/fm5
         ISe47lFiOkGWqRSi2mm3Ro5kNqQvzY6EvKIIF3CCU6kw4Ea3/+GMPx/Cm6x/rLuGSq6Z
         gRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/HpNI1L8HsuhwgNUMOu7LqzJncdnpbI+pFBDjt+Ev0s=;
        b=Z7D4bY5Lkg40j4jRff+sj9m2jFFIEFhItnwHrtpbQufLANEfOUJPrBY86pqyDizJQK
         Ga+2uFO2+56O+zWs8Y6Zi2IPGqKEn+kuVFKY8emnCjlFk8or1Vbu0fWbhOc4BYXTOLRD
         P7fStC+Nd6Rp+oGJjKCFvjv6z6rR6wsX6bu6MiwtZkrpzfBu+S8RRfAUmnR7+KH2+fbT
         vQHQJdXHIs9bij8nKQpMRwCQwEKBCWAsSffAvJuSj39KV+V+e+LTqR6v9sOhQsBJyspw
         p6AAVpyzLzLR/5QNpjr8Q0Uxw5yxZhynnSt1UBT58GRHxjL3Wz60vF72kkyj/SOPqb//
         UoHw==
X-Gm-Message-State: AA+aEWbdEWZvuXDe/AKdfr1gvEimH68kKf3/UWAIDFjJx97DPf4RZhlJ
        8YQk1ofpcfIlahG0+DEbJBg=
X-Google-Smtp-Source: AFSGD/VV6iq1ZcB9YwCOJUFIv/E1CkQz17qBKM6SEi5ohIOv9yca9tM20C7nSbraLkvDQyUC5i7NDA==
X-Received: by 2002:a17:902:968d:: with SMTP id n13mr27800208plp.109.1544081512108;
        Wed, 05 Dec 2018 23:31:52 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o8sm55023141pfa.42.2018.12.05.23.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 23:31:51 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] irqchip/irq-imx-gpcv2: Add support for i.MX8MQ
Date:   Wed,  5 Dec 2018 23:31:25 -0800
Message-Id: <20181206073125.7255-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206073125.7255-1-andrew.smirnov@gmail.com>
References: <20181206073125.7255-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add code needed to support i.MX8MQ.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/irqchip/irq-imx-gpcv2.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index c2b2b3128ddd..17a2dad2d4c2 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -17,6 +17,9 @@
 
 #define GPC_IMR1_CORE0		0x30
 #define GPC_IMR1_CORE1		0x40
+#define GPC_IMR1_CORE2		0x1c0
+#define GPC_IMR1_CORE3		0x1d0
+
 
 struct gpcv2_irqchip_data {
 	struct raw_spinlock	rlock;
@@ -192,11 +195,19 @@ static const struct irq_domain_ops gpcv2_irqchip_data_domain_ops = {
 	.free		= irq_domain_free_irqs_common,
 };
 
+static const struct of_device_id gpcv2_of_match[] = {
+	{ .compatible = "fsl,imx7d-gpc",  .data = (const void *) 2 },
+	{ .compatible = "fsl,imx8mq-gpc", .data = (const void *) 4 },
+	{ /* END */ }
+};
+
 static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 			       struct device_node *parent)
 {
 	struct irq_domain *parent_domain, *domain;
 	struct gpcv2_irqchip_data *cd;
+	const struct of_device_id *id;
+	unsigned long core_num;
 	int i;
 
 	if (!parent) {
@@ -204,6 +215,14 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 		return -ENODEV;
 	}
 
+	id = of_match_node(gpcv2_of_match, node);
+	if (!id) {
+		pr_err("%pOF: unknown compatibility string\n", node);
+		return -ENODEV;
+	}
+
+	core_num = (unsigned long)id->data;
+
 	parent_domain = irq_find_host(parent);
 	if (!parent_domain) {
 		pr_err("%pOF: unable to get parent domain\n", node);
@@ -236,8 +255,16 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 
 	/* Initially mask all interrupts */
 	for (i = 0; i < IMR_NUM; i++) {
-		writel_relaxed(~0, cd->gpc_base + GPC_IMR1_CORE0 + i * 4);
-		writel_relaxed(~0, cd->gpc_base + GPC_IMR1_CORE1 + i * 4);
+		void __iomem *reg = cd->gpc_base + i * 4;
+
+		switch (core_num) {
+		case 4:
+			writel_relaxed(~0, reg + GPC_IMR1_CORE2);
+			writel_relaxed(~0, reg + GPC_IMR1_CORE3);
+		case 2:	      /* FALLTHROUGH */
+			writel_relaxed(~0, reg + GPC_IMR1_CORE0);
+			writel_relaxed(~0, reg + GPC_IMR1_CORE1);
+		}
 		cd->wakeup_sources[i] = ~0;
 	}
 
-- 
2.19.1

