Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA0CC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786A420866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786A420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeILLAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:00:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59567 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbeILLAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:00:13 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 212634229B9E5;
        Wed, 12 Sep 2018 13:57:15 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Wed, 12 Sep 2018 13:57:15 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <axboe@kernel.dk>
CC:     <roger.pau@citrix.com>, <konrad.wilk@oracle.com>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/block/xen-blkback/common.h: use DIV_ROUND_UP instead of reimplementing its function
Date:   Wed, 12 Sep 2018 13:45:00 +0800
Message-ID: <1536731100-56054-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DIV_ROUND_UP has implemented the code-opened function. Therefore, just
replace the implementation with DIV_ROUND_UP.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/block/xen-blkback/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 1d3002d..874613d 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -65,7 +65,7 @@
 	(XEN_PAGES_PER_INDIRECT_FRAME / XEN_PAGES_PER_SEGMENT)
 
 #define MAX_INDIRECT_PAGES \
-	((MAX_INDIRECT_SEGMENTS + SEGS_PER_INDIRECT_FRAME - 1)/SEGS_PER_INDIRECT_FRAME)
+		DIV_ROUND_UP(MAX_INDIRECT_SEGMENTS, SEGS_PER_INDIRECT_FRAME)
 #define INDIRECT_PAGES(_segs) DIV_ROUND_UP(_segs, XEN_PAGES_PER_INDIRECT_FRAME)
 
 /* Not a real protocol.  Used to generate ring structs which contain
-- 
1.7.12.4

