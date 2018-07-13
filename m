Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE1FECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7842520873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="r5NWxaFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7842520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbeGMPEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:04:15 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:54558 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729726AbeGMPEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:04:15 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] irqchip: ingenic: Add support for the JZ4725B SoC
Date:   Fri, 13 Jul 2018 16:49:09 +0200
Message-Id: <20180713144909.10657-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531493356; bh=S58dwyNLxEq59Aup3wqGQpWCjrQRrxyW1AZO19MlwRw=; h=From:To:Cc:Subject:Date:Message-Id; b=r5NWxaFomwa0STJ8PlkTTYKNBKCmzCGaCbiq7HvObc7h2vonFq8r1V6HNEYYScTn7n1CtD6tPQ1QrOBVYEFAEhlrZTlM50YqvzM2hoL2PPFpTghdX0adMka84r7Je8+qHpBnTYYauD2nMfScMeZoQkP+WoKuMciRMT7ca2HBZRQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt controller of the JZ4725B works the same way as the other
JZ SoCs from Ingenic; so we just add a new compatible string.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt | 1 +
 drivers/irqchip/irq-ingenic.c                                           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt
index 5f89fb635a1b..f97fd8ab5e45 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt
@@ -4,6 +4,7 @@ Required properties:
 
 - compatible : should be "ingenic,<socname>-intc". Valid strings are:
     ingenic,jz4740-intc
+    ingenic,jz4725b-intc
     ingenic,jz4770-intc
     ingenic,jz4775-intc
     ingenic,jz4780-intc
diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index fc5953dea509..2ff08986b536 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -165,6 +165,7 @@ static int __init intc_1chip_of_init(struct device_node *node,
 	return ingenic_intc_of_init(node, 1);
 }
 IRQCHIP_DECLARE(jz4740_intc, "ingenic,jz4740-intc", intc_1chip_of_init);
+IRQCHIP_DECLARE(jz4725b_intc, "ingenic,jz4725b-intc", intc_1chip_of_init);
 
 static int __init intc_2chip_of_init(struct device_node *node,
 	struct device_node *parent)
-- 
2.11.0

