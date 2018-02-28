Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeB1CZf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 21:25:35 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:61148 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751675AbeB1CZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 21:25:34 -0500
From: Jiang Biao <jiang.biao2@zte.com.cn>
To: richard@nod.at, dedekind1@gmail.com, adrian.hunter@intel.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn
Subject: [PATCH] fs/ubifs: remove useless parameter of lpt_heap_replace
Date: Wed, 28 Feb 2018 10:22:37 +0800
Message-Id: <1519784557-105528-1-git-send-email-jiang.biao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-02-28 10:25:09,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-02-28 10:24:57,
        Serialize complete at 2018-02-28 10:24:57
X-MAIL: mse01.zte.com.cn w1S2P5VD037109
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter *old_lprops* is never used in lpt_heap_replace(),
remove it to avoid compile warning.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 fs/ubifs/lprops.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ubifs/lprops.c b/fs/ubifs/lprops.c
index 6c3a1ab..f5a4684 100644
--- a/fs/ubifs/lprops.c
+++ b/fs/ubifs/lprops.c
@@ -244,7 +244,6 @@ static void remove_from_lpt_heap(struct ubifs_info *c,
 /**
  * lpt_heap_replace - replace lprops in a category heap.
  * @c: UBIFS file-system description object
- * @old_lprops: LEB properties to replace
  * @new_lprops: LEB properties with which to replace
  * @cat: LEB category
  *
@@ -254,7 +253,6 @@ static void remove_from_lpt_heap(struct ubifs_info *c,
  * lprops.  This function does that.
  */
 static void lpt_heap_replace(struct ubifs_info *c,
-			     struct ubifs_lprops *old_lprops,
 			     struct ubifs_lprops *new_lprops, int cat)
 {
 	struct ubifs_lpt_heap *heap;
@@ -362,7 +360,7 @@ void ubifs_replace_cat(struct ubifs_info *c, struct ubifs_lprops *old_lprops,
 	case LPROPS_DIRTY:
 	case LPROPS_DIRTY_IDX:
 	case LPROPS_FREE:
-		lpt_heap_replace(c, old_lprops, new_lprops, cat);
+		lpt_heap_replace(c, new_lprops, cat);
 		break;
 	case LPROPS_UNCAT:
 	case LPROPS_EMPTY:
-- 
2.7.4
