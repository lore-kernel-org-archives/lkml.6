Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F59FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEF2222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437624AbfBNIuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:50:22 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388475AbfBNIuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:50:21 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 22AB49E78E57849AC027;
        Thu, 14 Feb 2019 16:50:18 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Thu, 14 Feb 2019 16:50:07 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH v2 -next] swiotlb: drop pointless static qualifier in swiotlb_create_debugfs()
Date:   Thu, 14 Feb 2019 09:04:08 +0000
Message-ID: <20190214090408.76071-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214014147.108653-1-yuehaibing@huawei.com>
References: <20190214014147.108653-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to have the 'struct dentry *d_swiotlb_usage' variable
static since new value always be assigned before use it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: fix patch title
---
 kernel/dma/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index a7b53786db9f..02fa517c47d9 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -689,7 +689,7 @@ swiotlb_dma_supported(struct device *hwdev, u64 mask)
 
 static int __init swiotlb_create_debugfs(void)
 {
-	static struct dentry *d_swiotlb_usage;
+	struct dentry *d_swiotlb_usage;
 	struct dentry *ent;
 
 	d_swiotlb_usage = debugfs_create_dir("swiotlb", NULL);



