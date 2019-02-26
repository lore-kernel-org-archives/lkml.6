Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AABC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7799420842
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfBZLBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:01:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4737 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbfBZLBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:01:33 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A29E3790E714C782380A;
        Tue, 26 Feb 2019 19:01:31 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Tue, 26 Feb 2019 19:01:22 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: print more parameters in trace_f2fs_map_blocks
Date:   Tue, 26 Feb 2019 19:01:16 +0800
Message-ID: <20190226110116.36759-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190226110116.36759-1-yuchao0@huawei.com>
References: <20190226110116.36759-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for better map_blocks trace.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 include/trace/events/f2fs.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 4683ee10fe61..d4402484faf6 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -544,6 +544,9 @@ TRACE_EVENT(f2fs_map_blocks,
 		__field(block_t,	m_lblk)
 		__field(block_t,	m_pblk)
 		__field(unsigned int,	m_len)
+		__field(unsigned int,	m_flags)
+		__field(int,	m_seg_type)
+		__field(bool,	m_may_create)
 		__field(int,	ret)
 	),
 
@@ -553,15 +556,22 @@ TRACE_EVENT(f2fs_map_blocks,
 		__entry->m_lblk		= map->m_lblk;
 		__entry->m_pblk		= map->m_pblk;
 		__entry->m_len		= map->m_len;
+		__entry->m_flags	= map->m_flags;
+		__entry->m_seg_type	= map->m_seg_type;
+		__entry->m_may_create	= map->m_may_create;
 		__entry->ret		= ret;
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu, file offset = %llu, "
-		"start blkaddr = 0x%llx, len = 0x%llx, err = %d",
+		"start blkaddr = 0x%llx, len = 0x%llx, flags = %u,"
+		"seg_type = %d, may_create = %d, err = %d",
 		show_dev_ino(__entry),
 		(unsigned long long)__entry->m_lblk,
 		(unsigned long long)__entry->m_pblk,
 		(unsigned long long)__entry->m_len,
+		__entry->m_flags,
+		__entry->m_seg_type,
+		__entry->m_may_create,
 		__entry->ret)
 );
 
-- 
2.18.0.rc1

