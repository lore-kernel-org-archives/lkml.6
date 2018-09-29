Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFF1C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4970020879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4970020879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeI2L4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 07:56:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbeI2L4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 07:56:54 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3223130E9DC0D;
        Sat, 29 Sep 2018 13:29:50 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.399.0; Sat, 29 Sep 2018 13:29:47 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <jack@suse.cz>, <viro@zeniv.linux.org.uk>
CC:     <zwisler@kernel.org>, <mawilcox@microsoft.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/dax.c: Use vmf_error() helper
Date:   Sat, 29 Sep 2018 13:17:17 +0800
Message-ID: <1538198237-37466-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These codes can be replaced with new inline vmf_error().

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 fs/dax.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index b68ce48..e732f70 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1311,9 +1311,8 @@ static vm_fault_t dax_fault_return(int error)
 {
 	if (error == 0)
 		return VM_FAULT_NOPAGE;
-	if (error == -ENOMEM)
-		return VM_FAULT_OOM;
-	return VM_FAULT_SIGBUS;
+
+	return vmf_error(error);
 }
 
 /*
-- 
1.7.12.4

