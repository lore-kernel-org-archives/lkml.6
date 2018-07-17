Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77766ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31598204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31598204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbeGQNPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:15:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9633 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731402AbeGQNPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:15:22 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 80382F535D3C1;
        Tue, 17 Jul 2018 20:42:37 +0800 (CST)
Received: from SZV1000284525.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.382.0; Tue, 17 Jul 2018 20:42:33 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5/5] f2fs: clean up ioctl interface naming
Date:   Tue, 17 Jul 2018 20:41:49 +0800
Message-ID: <20180717124149.32523-5-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180717124149.32523-1-yuchao0@huawei.com>
References: <20180717124149.32523-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Romve redundant prefix 'f2fs_' in the middle of f2fs_ioc_f2fs_write_checkpoint().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3a31b4e6d2dc..c6e3c0f751de 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2125,7 +2125,7 @@ static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
 	return ret;
 }
 
-static int f2fs_ioc_f2fs_write_checkpoint(struct file *filp, unsigned long arg)
+static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -2906,7 +2906,7 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_GARBAGE_COLLECT_RANGE:
 		return f2fs_ioc_gc_range(filp, arg);
 	case F2FS_IOC_WRITE_CHECKPOINT:
-		return f2fs_ioc_f2fs_write_checkpoint(filp, arg);
+		return f2fs_ioc_write_checkpoint(filp, arg);
 	case F2FS_IOC_DEFRAGMENT:
 		return f2fs_ioc_defragment(filp, arg);
 	case F2FS_IOC_MOVE_RANGE:
-- 
2.18.0.rc1

