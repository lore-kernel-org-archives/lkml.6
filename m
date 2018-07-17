Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054CEECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBBA204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBBA204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbeGQNPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:15:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9635 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731390AbeGQNPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:15:25 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B75A8DA121994;
        Tue, 17 Jul 2018 20:42:37 +0800 (CST)
Received: from SZV1000284525.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.382.0; Tue, 17 Jul 2018 20:42:30 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/5] f2fs: kill EXT_TREE_VEC_SIZE
Date:   Tue, 17 Jul 2018 20:41:45 +0800
Message-ID: <20180717124149.32523-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 201ef5e080c9 ("f2fs: improve shrink performance of extent nodes"),
there is no user of EXT_TREE_VEC_SIZE, just kill it for cleanup.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 806006ed0d0a..ff3b80da32f3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -524,9 +524,6 @@ enum {
 
 #define MAX_DIR_RA_PAGES	4	/* maximum ra pages of dir */
 
-/* vector size for gang look-up from extent cache that consists of radix tree */
-#define EXT_TREE_VEC_SIZE	64
-
 /* for in-memory extent cache entry */
 #define F2FS_MIN_EXTENT_LEN	64	/* minimum extent length */
 
-- 
2.18.0.rc1

