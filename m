Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0744C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1C621718
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1C621718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeHHRIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:08:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41387 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727108AbeHHRIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:08:23 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 74AA6DDB2A10A;
        Wed,  8 Aug 2018 22:48:21 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.399.0; Wed, 8 Aug 2018 22:48:17 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <mark@fasheh.com>, <jlbec@evilplan.org>
CC:     <linux-kernel@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>
Subject: [PATCH] fs/ocfs2/dlmglue: remove unneeded variable "status" in ocfs2_downconvert_thread
Date:   Wed, 8 Aug 2018 22:36:36 +0800
Message-ID: <1533738996-10957-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable "status" is not modified after initialization. So just
remove the unneeded variable.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 fs/ocfs2/dlmglue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 040ddb6..92d5c57 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -4359,7 +4359,6 @@ static int ocfs2_downconvert_thread_should_wake(struct ocfs2_super *osb)
 
 static int ocfs2_downconvert_thread(void *arg)
 {
-	int status = 0;
 	struct ocfs2_super *osb = arg;
 
 	/* only quit once we've been asked to stop and there is no more
@@ -4377,7 +4376,7 @@ static int ocfs2_downconvert_thread(void *arg)
 	}
 
 	osb->dc_task = NULL;
-	return status;
+	return 0;
 }
 
 void ocfs2_wake_downconvert_thread(struct ocfs2_super *osb)
-- 
1.7.12.4

