Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FA1ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A528214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A528214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeIQMix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 08:38:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12161 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726652AbeIQMix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 08:38:53 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7BD1BC216B429;
        Mon, 17 Sep 2018 15:12:45 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Mon, 17 Sep 2018 15:12:40 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     Dave Kleikamp <shaggy@kernel.org>,
        "open list:JFS FILESYSTEM" <jfs-discussion@lists.sourceforge.net>,
        open list <linux-kernel@vger.kernel.org>
CC:     <chao@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] jfs: remove redundant dquot_initialize() in jfs_evict_inode()
Date:   Mon, 17 Sep 2018 15:12:21 +0800
Message-ID: <20180917071221.13187-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to call dquot_initialize() twice in jfs_evict_inode(),
remove one of them for cleanup.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/jfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 054cc761b426..805ae9e8944a 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -166,7 +166,6 @@ void jfs_evict_inode(struct inode *inode)
 			/*
 			 * Free the inode from the quota allocation.
 			 */
-			dquot_initialize(inode);
 			dquot_free_inode(inode);
 		}
 	} else {
-- 
2.18.0.rc1

