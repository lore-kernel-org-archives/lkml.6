Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFC9C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6483F207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6483F207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeJWVp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 17:45:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14106 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726277AbeJWVp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 17:45:57 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 79A1558B06A72;
        Tue, 23 Oct 2018 21:22:23 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Tue, 23 Oct 2018 21:22:18 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <akpm@linux-foundation.org>, <mark@fasheh.com>,
        <jlbec@evilplan.org>
CC:     <jiangqi903@gmail.com>, <dhowells@redhat.com>,
        <piaojun@huawei.com>, <viro@zeniv.linux.org.uk>,
        <ocfs2-devel@oss.oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ocfs2: dlmfs: remove set but not used variable 'status'
Date:   Tue, 23 Oct 2018 21:09:39 +0800
Message-ID: <1540300179-26697-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

status is not used after setting its value. It is safe to remove
the unused variable.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 fs/ocfs2/dlmfs/dlmfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 642e471..b03dd46 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -179,7 +179,7 @@ static int dlmfs_file_open(struct inode *inode,
 static int dlmfs_file_release(struct inode *inode,
 			      struct file *file)
 {
-	int level, status;
+	int level;
 	struct dlmfs_inode_private *ip = DLMFS_I(inode);
 	struct dlmfs_filp_private *fp = file->private_data;
 
@@ -188,7 +188,6 @@ static int dlmfs_file_release(struct inode *inode,
 
 	mlog(0, "close called on inode %lu\n", inode->i_ino);
 
-	status = 0;
 	if (fp) {
 		level = fp->fp_lock_level;
 		if (level != DLM_LOCK_IV)
-- 
1.7.12.4

