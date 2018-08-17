Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CF0C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F622185B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F622185B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbeHQGrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 02:47:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11126 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725766AbeHQGrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 02:47:10 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BE82EB0F22271;
        Fri, 17 Aug 2018 11:45:21 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.399.0; Fri, 17 Aug 2018 11:45:18 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <dvhart@infradead.org>, <andy@infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers: intel_ips: remove the unneeded null pointer check before debugfs_remove_recursive
Date:   Fri, 17 Aug 2018 11:33:28 +0800
Message-ID: <1534476808-13574-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_remove_recursive has taken the null pointer into account.
just remove the null check before debugfs_remove_recursive.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/platform/x86/intel_ips.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
index c5ece7e..1c3127c 100644
--- a/drivers/platform/x86/intel_ips.c
+++ b/drivers/platform/x86/intel_ips.c
@@ -1311,8 +1311,7 @@ static int ips_debugfs_open(struct inode *inode, struct file *file)
 
 static void ips_debugfs_cleanup(struct ips_driver *ips)
 {
-	if (ips->debug_root)
-		debugfs_remove_recursive(ips->debug_root);
+	debugfs_remove_recursive(ips->debug_root);
 	return;
 }
 
-- 
1.7.12.4

