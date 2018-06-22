Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64929C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2094222CAD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2094222CAD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeFVMZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:25:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56411 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbeFVMZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:25:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MCP2l0066450
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 05:25:02 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MCP03h066439;
        Fri, 22 Jun 2018 05:25:00 -0700
Date:   Fri, 22 Jun 2018 05:25:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Marc Zyngier <tipbot@zytor.com>
Message-ID: <tip-72a8edc2d9134c2895eac2fec5eecf8230a05c96@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        marc.zyngier@arm.com, sumit.garg@linaro.org, mingo@kernel.org,
        yangyingliang@huawei.com, hpa@zytor.com, jason@lakedaemon.net,
        alexandre.belloni@bootlin.com
Reply-To: alexandre.belloni@bootlin.com, jason@lakedaemon.net,
          hpa@zytor.com, yangyingliang@huawei.com, mingo@kernel.org,
          sumit.garg@linaro.org, linux-kernel@vger.kernel.org,
          marc.zyngier@arm.com, tglx@linutronix.de
In-Reply-To: <20180622095254.5906-2-marc.zyngier@arm.com>
References: <20180622095254.5906-2-marc.zyngier@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] genirq/debugfs: Add missing
 IRQCHIP_SUPPORTS_LEVEL_MSI debug
Git-Commit-ID: 72a8edc2d9134c2895eac2fec5eecf8230a05c96
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  72a8edc2d9134c2895eac2fec5eecf8230a05c96
Gitweb:     https://git.kernel.org/tip/72a8edc2d9134c2895eac2fec5eecf8230a05c96
Author:     Marc Zyngier <marc.zyngier@arm.com>
AuthorDate: Fri, 22 Jun 2018 10:52:48 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 14:22:00 +0200

genirq/debugfs: Add missing IRQCHIP_SUPPORTS_LEVEL_MSI debug

Debug is missing the IRQCHIP_SUPPORTS_LEVEL_MSI debug entry, making debugfs
slightly less useful.

Take this opportunity to also add a missing comment in the definition of
IRQCHIP_SUPPORTS_LEVEL_MSI.

Fixes: 6988e0e0d283 ("genirq/msi: Limit level-triggered MSI to platform devices")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Link: https://lkml.kernel.org/r/20180622095254.5906-2-marc.zyngier@arm.com

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
