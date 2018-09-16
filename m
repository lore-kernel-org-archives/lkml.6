Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C81DECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 14:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A632087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 14:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A632087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeIPUH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 16:07:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727808AbeIPUH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 16:07:27 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E955D4F7874BE;
        Sun, 16 Sep 2018 22:44:11 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Sun, 16 Sep 2018 22:44:08 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <georgi.djakov@linaro.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] interconnect: Fix a GCC compiler warning
Date:   Sun, 16 Sep 2018 22:31:50 +0800
Message-ID: <1537108310-2086-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following compile warning:

drivers/interconnect/core.c:26:23: warning: icc_debugfs_dir defined but not used [-Wunused-variable]
 static struct dentry *icc_debugfs_dir;

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/interconnect/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 2740f1a..9ea9959 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -23,7 +23,10 @@
 static DEFINE_IDR(icc_idr);
 static LIST_HEAD(icc_provider_list);
 static DEFINE_MUTEX(icc_lock);
+
+#ifdef CONFIG_DEBUG_FS
 static struct dentry *icc_debugfs_dir;
+#endif
 
 /**
  * struct icc_req - constraints that are attached to each node
-- 
1.7.12.4

