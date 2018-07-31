Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4007CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBA220685
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBA220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbeGaRVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:21:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10193 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732013AbeGaRVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:21:17 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 347363E79D678;
        Tue, 31 Jul 2018 23:39:49 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Tue, 31 Jul 2018 23:39:48 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <mathieu.poirier@linaro.org>, <alexander.shishkin@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] driver/hwtracing: use ERR_CAST instead of ERR_PTR
Date:   Tue, 31 Jul 2018 23:28:14 +0800
Message-ID: <1533050894-33214-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ERR_CAT inlined function to replace the ERR_PTR(PTR_ERR). It
make the code more concise.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 2eda5de..1196364 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -536,7 +536,7 @@ static void tmc_etr_sg_table_populate(struct etr_sg_table *etr_table)
 	sg_table = tmc_alloc_sg_table(dev, node, nr_tpages, nr_dpages, pages);
 	if (IS_ERR(sg_table)) {
 		kfree(etr_table);
-		return ERR_PTR(PTR_ERR(sg_table));
+		return ERR_CAST(sg_table);
 	}
 
 	etr_table->sg_table = sg_table;
-- 
1.7.12.4

