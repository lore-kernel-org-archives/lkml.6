Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD25C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E43620861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E43620861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeIFNge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:36:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11645 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727629AbeIFNge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:36:34 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 43C2F5ADC801C;
        Thu,  6 Sep 2018 17:02:05 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 6 Sep 2018
 17:02:01 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        <weidu.du@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 1/2 dhowells/mount-api] staging: erofs: rename superblock flags (MS_xyz -> SB_xyz)
Date:   Thu, 6 Sep 2018 17:01:47 +0800
Message-ID: <1536224508-66168-1-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch follows commit 1751e8a6cb93 ("Rename superblock
flags (MS_xyz -> SB_xyz)") and after commit ("vfs: Suppress
MS_* flag defs within the kernel unless explicitly enabled"),
there is no MS_RDONLY and MS_NOATIME at all.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

Once used MS_RDONLY, MS_NOATIME for the compatibility of older kernels,
which are removed in ("vfs: Suppress MS_* flag defs within the kernel
unless explicitly enabled").

 drivers/staging/erofs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 1aec509..2df9768 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -340,7 +340,7 @@ static int erofs_read_super(struct super_block *sb,
 		goto err_sbread;
 
 	sb->s_magic = EROFS_SUPER_MAGIC;
-	sb->s_flags |= MS_RDONLY | MS_NOATIME;
+	sb->s_flags |= SB_RDONLY | SB_NOATIME;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_time_gran = 1;
 
@@ -627,7 +627,7 @@ static int erofs_remount(struct super_block *sb, int *flags, char *data)
 {
 	BUG_ON(!sb_rdonly(sb));
 
-	*flags |= MS_RDONLY;
+	*flags |= SB_RDONLY;
 	return 0;
 }
 
-- 
1.9.1

