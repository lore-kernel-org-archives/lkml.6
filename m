Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AD8C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1DD21571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1DD21571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeI0RGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:06:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13137 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727112AbeI0RGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:06:01 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1E95DBD06695B;
        Thu, 27 Sep 2018 18:48:19 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Thu, 27 Sep 2018 18:48:18 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <haver@linux.vnet.ibm.com>, <gpiccoli@linux.vnet.ibm.com>,
        <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v2] misc: card_utils: remove duplicated include file
Date:   Thu, 27 Sep 2018 18:35:50 +0800
Message-ID: <1538044550-24717-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

delay.h and dma-mapping.h have duplicated include. hence just remove
redundant file.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
v1->v2:
 - modify the subject

 drivers/misc/genwqe/card_utils.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/genwqe/card_utils.c b/drivers/misc/genwqe/card_utils.c
index 8679e0b..61d647a 100644
--- a/drivers/misc/genwqe/card_utils.c
+++ b/drivers/misc/genwqe/card_utils.c
@@ -23,14 +23,12 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/dma-mapping.h>
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
 #include <linux/page-flags.h>
 #include <linux/scatterlist.h>
 #include <linux/hugetlb.h>
 #include <linux/iommu.h>
-#include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/ctype.h>
-- 
1.7.12.4

