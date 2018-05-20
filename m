Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751026AbeETHld (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 03:41:33 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36863 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeETHlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 03:41:31 -0400
X-Google-Smtp-Source: AB8JxZq/tb2rbw5Cu2WnzWnkCHbRb/LiXtZqnXu7ntyQRlwYc+ffHvbZ8A4jsd3ySEk9QUweumqXmg==
From: Varsha Rao <rvarsha016@gmail.com>
To: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nicholas Mc Guire <der.herr@hofr.at>
Cc: Varsha Rao <rvarsha016@gmail.com>
Subject: [PATCH] ocfs2: dlm: Remove extra parentheses
Date: Sun, 20 May 2018 13:11:14 +0530
Message-Id: <20180520074114.7760-1-rvarsha016@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses to fix the clang warning of extraneous
parentheses.

Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
---
 fs/ocfs2/dlm/dlmthread.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/dlm/dlmthread.c b/fs/ocfs2/dlm/dlmthread.c
index 838a06d4066a..074d5de17bb2 100644
--- a/fs/ocfs2/dlm/dlmthread.c
+++ b/fs/ocfs2/dlm/dlmthread.c
@@ -531,7 +531,7 @@ void __dlm_dirty_lockres(struct dlm_ctxt *dlm, struct dlm_lock_resource *res)
 	assert_spin_locked(&res->spinlock);
 
 	/* don't shuffle secondary queues */
-	if ((res->owner == dlm->node_num)) {
+	if (res->owner == dlm->node_num) {
 		if (res->state & (DLM_LOCK_RES_MIGRATING |
 				  DLM_LOCK_RES_BLOCK_DIRTY))
 		    return;
-- 
2.17.0
