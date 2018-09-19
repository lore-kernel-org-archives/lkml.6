Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8796EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9F3214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9F3214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbeISIEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:04:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51514 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730667AbeISIEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:04:23 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EB8A9A95DB804;
        Wed, 19 Sep 2018 10:28:48 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Wed, 19 Sep 2018 10:28:42 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <gaoxiang25@huawei.com>, <yuchao0@huawei.com>,
        <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: erofs: Fix a unused variable 'arg' warning
Date:   Wed, 19 Sep 2018 10:16:21 +0800
Message-ID: <1537323381-23839-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I find the following warning when compiling the kernel.

drivers/staging/erofs/super.c:195:6: warning: unused variable 'arg' [-Wunused-variable]
  int arg = 0;

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/staging/erofs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 6423592..c04313f 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -192,7 +192,9 @@ static int parse_options(struct super_block *sb, char *options)
 {
 	substring_t args[MAX_OPT_ARGS];
 	char *p;
+#ifdef CONFIG_EROFS_FAULT_INJECTION
 	int arg = 0;
+#endif
 
 	if (!options)
 		return 0;
-- 
1.7.12.4

