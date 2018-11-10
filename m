Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8D5C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 07:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AE320840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 07:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48AE320840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeKJQ4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 11:56:09 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36334 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728644AbeKJQ4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 11:56:08 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2BE01CBCED3B9;
        Sat, 10 Nov 2018 15:12:08 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Sat, 10 Nov 2018 15:12:02 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
CC:     YueHaibing <yuehaibing@huawei.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ocfs2: remove set but not used variable 'end'
Date:   Sat, 10 Nov 2018 07:21:40 +0000
Message-ID: <1541834500-56185-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

fs/ocfs2/file.c: In function 'ocfs2_prepare_inode_for_write':
fs/ocfs2/file.c:2143:9: warning:
 variable 'end' set but not used [-Wunused-but-set-variable]

It not used any more after commit
f1f973ffce96 ("ocfs2: code clean up for direct io")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/ocfs2/file.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index d640c5f..1905ead 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2140,7 +2140,6 @@ static int ocfs2_prepare_inode_for_write(struct file *file,
 	struct dentry *dentry = file->f_path.dentry;
 	struct inode *inode = d_inode(dentry);
 	struct buffer_head *di_bh = NULL;
-	loff_t end;
 
 	/*
 	 * We start with a read level meta lock and only jump to an ex
@@ -2204,8 +2203,6 @@ static int ocfs2_prepare_inode_for_write(struct file *file,
 			}
 		}
 
-		end = pos + count;
-
 		ret = ocfs2_check_range_for_refcount(inode, pos, count);
 		if (ret == 1) {
 			ocfs2_inode_unlock(inode, meta_level);



