Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17F0C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F22217C8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F22217C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbeHMJJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 05:09:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10707 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727959AbeHMJJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 05:09:56 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 42E519C14608C;
        Mon, 13 Aug 2018 14:29:04 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Mon, 13 Aug 2018 14:28:56 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] Revert "f2fs: use printk_ratelimited for f2fs_msg"
Date:   Mon, 13 Aug 2018 14:28:45 +0800
Message-ID: <20180813062845.25394-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't limit printing log, so that we will not miss any key messages.

This reverts commit a36c106dffb616250117efb1cab271c19a8f94ff.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bf4c919fe418..3d89d94191e7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -209,7 +209,7 @@ void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...)
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
-	printk_ratelimited("%sF2FS-fs (%s): %pV\n", level, sb->s_id, &vaf);
+	printk("%sF2FS-fs (%s): %pV\n", level, sb->s_id, &vaf);
 	va_end(args);
 }
 
-- 
2.18.0.rc1

