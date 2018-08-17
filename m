Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7131FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2506F2185B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2506F2185B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeHQGvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 02:51:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47534 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725766AbeHQGvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 02:51:05 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 338264FE991B5;
        Fri, 17 Aug 2018 11:49:18 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Fri, 17 Aug 2018 11:49:17 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <laurent.pinchart@ideasonboard.com>, <mchehab@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] media: NULL check is meaningless before debugfs_remove_recursive
Date:   Fri, 17 Aug 2018 11:37:26 +0800
Message-ID: <1534477046-13795-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_remove_recursive has taken null pointer into account. so
remove the unneeded check.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/media/usb/uvc/uvc_debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_debugfs.c b/drivers/media/usb/uvc/uvc_debugfs.c
index 368f8f8..6995aeb 100644
--- a/drivers/media/usb/uvc/uvc_debugfs.c
+++ b/drivers/media/usb/uvc/uvc_debugfs.c
@@ -128,6 +128,5 @@ void uvc_debugfs_init(void)
 
 void uvc_debugfs_cleanup(void)
 {
-	if (uvc_debugfs_root_dir != NULL)
-		debugfs_remove_recursive(uvc_debugfs_root_dir);
+	debugfs_remove_recursive(uvc_debugfs_root_dir);
 }
-- 
1.7.12.4

