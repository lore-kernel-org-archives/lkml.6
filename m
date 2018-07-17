Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6854CECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF20204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF20204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbeGQNP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:15:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9634 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731358AbeGQNPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:15:25 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C5328E2535D8F;
        Tue, 17 Jul 2018 20:42:37 +0800 (CST)
Received: from SZV1000284525.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.382.0; Tue, 17 Jul 2018 20:42:32 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/5] f2fs: clean up with f2fs_is_{atomic,volatile}_file()
Date:   Tue, 17 Jul 2018 20:41:48 +0800
Message-ID: <20180717124149.32523-4-yuchao0@huawei.com>
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

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0adab2ec5c5e..92b1bedfe85e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2766,8 +2766,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 			return CURSEG_COLD_DATA;
 		if (file_is_hot(inode) ||
 				is_inode_flag_set(inode, FI_HOT_DATA) ||
-				is_inode_flag_set(inode, FI_ATOMIC_FILE) ||
-				is_inode_flag_set(inode, FI_VOLATILE_FILE))
+				f2fs_is_atomic_file(inode) ||
+				f2fs_is_volatile_file(inode))
 			return CURSEG_HOT_DATA;
 		return f2fs_rw_hint_to_seg_type(inode->i_write_hint);
 	} else {
-- 
2.18.0.rc1

