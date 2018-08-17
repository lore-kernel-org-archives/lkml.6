Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB30C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A76E21523
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A76E21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbeHQGiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 02:38:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34975 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbeHQGiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 02:38:21 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4D8D353391917;
        Fri, 17 Aug 2018 11:36:35 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.399.0; Fri, 17 Aug 2018 11:36:36 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <cpw@sgi.com>, <robinmholt@gmail.com>
CC:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] misc: remove meanless null check before kfree
Date:   Fri, 17 Aug 2018 11:24:45 +0800
Message-ID: <1534476285-13097-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree has taken null pointer into account. so check the null pointer
before kfree is meanless.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/misc/sgi-xp/xpc_partition.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/sgi-xp/xpc_partition.c b/drivers/misc/sgi-xp/xpc_partition.c
index 0c3ef6f..3eba1c4 100644
--- a/drivers/misc/sgi-xp/xpc_partition.c
+++ b/drivers/misc/sgi-xp/xpc_partition.c
@@ -98,8 +98,7 @@
 			len = L1_CACHE_ALIGN(len);
 
 		if (len > buf_len) {
-			if (buf_base != NULL)
-				kfree(buf_base);
+			kfree(buf_base);
 			buf_len = L1_CACHE_ALIGN(len);
 			buf = xpc_kmalloc_cacheline_aligned(buf_len, GFP_KERNEL,
 							    &buf_base);
-- 
1.7.12.4

