Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986BAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFF7208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFF7208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757238AbeFSL4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:56:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48386 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757208AbeFSL4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:56:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 557BC1529;
        Tue, 19 Jun 2018 04:56:08 -0700 (PDT)
Received: from approximate.cambridge.arm.com (approximate.cambridge.arm.com [10.1.206.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4827B3F557;
        Tue, 19 Jun 2018 04:56:07 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 1/6] genirq/debugfs: Add missing IRQCHIP_SUPPORTS_LEVEL_MSI debug
Date:   Tue, 19 Jun 2018 12:55:41 +0100
Message-Id: <20180619115546.12196-2-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619115546.12196-1-marc.zyngier@arm.com>
References: <20180619115546.12196-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're missing the IRQCHIP_SUPPORTS_LEVEL_MSI debug entry, making
debugfs slightly less useful. Take this opportunity to also add
a missing comment in the definition of IRQCHIP_SUPPORTS_LEVEL_MSI.

Fixes: 6988e0e0d283 ("genirq/msi: Limit level-triggered MSI to platform devices")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irq.h  | 1 +
 kernel/irq/debugfs.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 4bd2f34947f4..201de12a9957 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -503,6 +503,7 @@ struct irq_chip {
  * IRQCHIP_SKIP_SET_WAKE:	Skip chip.irq_set_wake(), for this irq chip
  * IRQCHIP_ONESHOT_SAFE:	One shot does not require mask/unmask
  * IRQCHIP_EOI_THREADED:	Chip requires eoi() on unmask in threaded mode
+ * IRQCHIP_SUPPORTS_LEVEL_MSI	Chip can provide two doorbells for Level MSIs
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED		= (1 <<  0),
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 4dadeb3d6666..6f636136cccc 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -55,6 +55,7 @@ static const struct irq_bit_descr irqchip_flags[] = {
 	BIT_MASK_DESCR(IRQCHIP_SKIP_SET_WAKE),
 	BIT_MASK_DESCR(IRQCHIP_ONESHOT_SAFE),
 	BIT_MASK_DESCR(IRQCHIP_EOI_THREADED),
+	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_LEVEL_MSI),
 };
 
 static void
-- 
2.17.1

