Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CCAC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB5920833
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB5920833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbeIZJ2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:28:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50206 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726250AbeIZJ2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:28:23 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 088CAF89557D1;
        Wed, 26 Sep 2018 11:17:37 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.399.0; Wed, 26 Sep 2018 11:17:36 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <gpiccoli@linux.vnet.ibm.com>, <arnd@arndb.de>,
        <haver@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCHv2] misc: genwqe: remove duplicated include and order header files alphabetically in card_utils.c
Date:   Wed, 26 Sep 2018 11:05:09 +0800
Message-ID: <1537931109-57092-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma-mapping.h and delay.h have included twice. It is unnecessary. Meanwhile,
Arrange header files in alphabetical sequence to improve readability.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/misc/genwqe/card_utils.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/genwqe/card_utils.c b/drivers/misc/genwqe/card_utils.c
index 8679e0b..994e8fa 100644
--- a/drivers/misc/genwqe/card_utils.c
+++ b/drivers/misc/genwqe/card_utils.c
@@ -22,26 +22,24 @@
  * Miscelanous functionality used in the other GenWQE driver parts.
  */
 
-#include <linux/kernel.h>
+#include <asm/pgtable.h>
+#include <linux/ctype.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
-#include <linux/sched.h>
-#include <linux/vmalloc.h>
-#include <linux/page-flags.h>
-#include <linux/scatterlist.h>
 #include <linux/hugetlb.h>
 #include <linux/iommu.h>
-#include <linux/delay.h>
-#include <linux/pci.h>
-#include <linux/dma-mapping.h>
-#include <linux/ctype.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/page-flags.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
-#include <linux/delay.h>
-#include <asm/pgtable.h>
+#include <linux/scatterlist.h>
+#include <linux/sched.h>
+#include <linux/vmalloc.h>
 
-#include "genwqe_driver.h"
 #include "card_base.h"
 #include "card_ddcb.h"
+#include "genwqe_driver.h"
 
 /**
  * __genwqe_writeq() - Write 64-bit register
-- 
1.7.12.4

