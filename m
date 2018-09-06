Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1171C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A75820861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A75820861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbeIFGKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:10:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43493 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725812AbeIFGKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:10:06 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E15B61C86094B;
        Thu,  6 Sep 2018 09:37:11 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Thu, 6 Sep 2018 09:37:03 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
CC:     YueHaibing <yuehaibing@huawei.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ocfs2: remove set but not used variable 'rb'
Date:   Thu, 6 Sep 2018 01:47:23 +0000
Message-ID: <1536198443-113047-1-git-send-email-yuehaibing@huawei.com>
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

fs/ocfs2/refcounttree.c: In function 'ocfs2_create_reflink_node':
fs/ocfs2/refcounttree.c:4138:31: warning:
 variable 'rb' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/ocfs2/refcounttree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 7a5ee14..1114ef0 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -4135,7 +4135,6 @@ static int ocfs2_create_reflink_node(struct inode *s_inode,
 	struct buffer_head *ref_root_bh = NULL;
 	struct ocfs2_cached_dealloc_ctxt dealloc;
 	struct ocfs2_super *osb = OCFS2_SB(s_inode->i_sb);
-	struct ocfs2_refcount_block *rb;
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)s_bh->b_data;
 	struct ocfs2_refcount_tree *ref_tree;
 
@@ -4162,7 +4161,6 @@ static int ocfs2_create_reflink_node(struct inode *s_inode,
 		mlog_errno(ret);
 		goto out;
 	}
-	rb = (struct ocfs2_refcount_block *)ref_root_bh->b_data;
 
 	ret = ocfs2_duplicate_extent_list(s_inode, t_inode, t_bh,
 					  &ref_tree->rf_ci, ref_root_bh,

