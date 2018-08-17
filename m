Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172C7C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99BB21890
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99BB21890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeHQSsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:48:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41443 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727529AbeHQSsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:48:00 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6D30F9C5D33BD;
        Fri, 17 Aug 2018 23:44:03 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.399.0; Fri, 17 Aug 2018 23:43:55 +0800
From:   John Garry <john.garry@huawei.com>
To:     <will.deacon@arm.com>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH] iommu/arm-smmu-v3: Fix a couple of minor comment typos
Date:   Fri, 17 Aug 2018 23:42:22 +0800
Message-ID: <1534520542-92851-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some comment typos spotted.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 5059d09..feef122 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -708,7 +708,7 @@ static void queue_inc_prod(struct arm_smmu_queue *q)
 }
 
 /*
- * Wait for the SMMU to consume items. If drain is true, wait until the queue
+ * Wait for the SMMU to consume items. If sync is true, wait until the queue
  * is empty. Otherwise, wait until there is at least one free slot.
  */
 static int queue_poll_cons(struct arm_smmu_queue *q, bool sync, bool wfe)
@@ -2353,8 +2353,8 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	irq = smmu->combined_irq;
 	if (irq) {
 		/*
-		 * Cavium ThunderX2 implementation doesn't not support unique
-		 * irq lines. Use single irq line for all the SMMUv3 interrupts.
+		 * Cavium ThunderX2 implementation doesn't support unique irq
+		 * lines. Use a single irq line for all the SMMUv3 interrupts.
 		 */
 		ret = devm_request_threaded_irq(smmu->dev, irq,
 					arm_smmu_combined_irq_handler,
-- 
1.9.1

