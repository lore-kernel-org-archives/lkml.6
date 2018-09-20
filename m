Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADCAECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A8720877
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A8720877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbeITLBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 07:01:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41533 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725725AbeITLBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 07:01:10 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 517183E0235FD;
        Thu, 20 Sep 2018 13:19:34 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Thu, 20 Sep 2018 13:19:32 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <haver@linux.vnet.ibm.com>, <gpiccoli@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] misc: genwqe: remove duplicated include file
Date:   Thu, 20 Sep 2018 13:07:11 +0800
Message-ID: <1537420031-30405-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module.h has duplicated include. hence just remove
redundant include file.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/misc/genwqe/card_base.c | 1 -
 drivers/misc/genwqe/card_ddcb.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
index c7cd367..d137d0fa 100644
--- a/drivers/misc/genwqe/card_base.c
+++ b/drivers/misc/genwqe/card_base.c
@@ -24,7 +24,6 @@
  * controlled from here.
  */
 
-#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/err.h>
diff --git a/drivers/misc/genwqe/card_ddcb.c b/drivers/misc/genwqe/card_ddcb.c
index 656449c..9a65bd9 100644
--- a/drivers/misc/genwqe/card_ddcb.c
+++ b/drivers/misc/genwqe/card_ddcb.c
@@ -27,7 +27,6 @@
  */
 
 #include <linux/types.h>
-#include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/pci.h>
-- 
1.7.12.4

