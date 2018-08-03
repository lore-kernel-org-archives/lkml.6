Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAA4C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EBE2172F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7EBE2172F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbeHCIVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:21:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49467 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728037AbeHCIVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:21:35 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5EDC9AAE18D85;
        Fri,  3 Aug 2018 14:26:46 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Fri, 3 Aug 2018
 14:26:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linux@armlinux.org.uk>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ARM: dmabounce: remove unnecessary NULL check before dma_pool_destroy
Date:   Fri, 3 Aug 2018 14:26:27 +0800
Message-ID: <20180803062627.22572-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_pool_destroy will do NULL check,thus the check before
the call is not needed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/arm/common/dmabounce.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 9a92de6..dcdd80c 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -569,10 +569,8 @@ void dmabounce_unregister_dev(struct device *dev)
 		BUG();
 	}
 
-	if (device_info->small.pool)
-		dma_pool_destroy(device_info->small.pool);
-	if (device_info->large.pool)
-		dma_pool_destroy(device_info->large.pool);
+	dma_pool_destroy(device_info->small.pool);
+	dma_pool_destroy(device_info->large.pool);
 
 #ifdef STATS
 	if (device_info->attr_res == 0)
-- 
2.7.0


