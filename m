Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F322DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CC120866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8CC120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeIJMkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:40:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50717 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726405AbeIJMkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:40:04 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 21783F406161;
        Mon, 10 Sep 2018 15:47:16 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Mon, 10 Sep 2018 15:47:14 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <mawilcox@microsoft.com>, <jlayton@kernel.org>,
        <mgorman@techsingularity.net>, <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] radix-tree: Use DIV_ROUND_UP instead of reimplementing its function
Date:   Mon, 10 Sep 2018 15:35:00 +0800
Message-ID: <1536564900-5944-1-git-send-email-zhongjiang@huawei.com>
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
 include/linux/radix-tree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index 34149e8..2e507c6 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -75,7 +75,7 @@ static inline bool radix_tree_is_internal_node(void *ptr)
 #define RADIX_TREE_MAP_MASK	(RADIX_TREE_MAP_SIZE-1)
 
 #define RADIX_TREE_TAG_LONGS	\
-	((RADIX_TREE_MAP_SIZE + BITS_PER_LONG - 1) / BITS_PER_LONG)
+		DIV_ROUND_UP(RADIX_TREE_MAP_SIZE, BITS_PER_LONG)
 
 #define RADIX_TREE_INDEX_BITS  (8 /* CHAR_BIT */ * sizeof(unsigned long))
 #define RADIX_TREE_MAX_PATH (DIV_ROUND_UP(RADIX_TREE_INDEX_BITS, \
-- 
1.7.12.4

