Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966497AbeEJPtR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:49:17 -0400
Received: from smtprelay0066.hostedemail.com ([216.40.44.66]:52447 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966172AbeEJPqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:46:25 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:541:800:960:968:973:988:989:1260:1345:1359:1437:1534:1541:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3352:3867:4419:5007:6261:6642:10004:10848:11026:11232:11473:11658:11914:12296:12438:12555:12895:13069:13311:13357:14181:14384:14394:14721:21080:21433:21451:21627:30054,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: sun36_1a8f66336041b
X-Filterd-Recvd-Size: 1922
From: Joe Perches <joe@perches.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/18] blk-mq: Remove pr_fmt duplicate logging prefixes
Date: Thu, 10 May 2018 08:45:33 -0700
Message-Id: <55ec0aec733169ae8cd8eec0a9581c693725de04.1525964385.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1525964381.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converting pr_fmt from a simple define to use KBUILD_MODNAME added
some duplicate logging prefixes to existing uses.

Remove them.

Signed-off-by: Joe Perches <joe@perches.com>
---
 block/blk-mq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9ce9cac16c3f..37e6206e745c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2782,13 +2782,13 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 	} while (set->queue_depth);
 
 	if (!set->queue_depth || err) {
-		pr_err("blk-mq: failed to allocate request map\n");
+		pr_err("failed to allocate request map\n");
 		return -ENOMEM;
 	}
 
 	if (depth != set->queue_depth)
-		pr_info("blk-mq: reduced tag depth (%u -> %u)\n",
-						depth, set->queue_depth);
+		pr_info("reduced tag depth (%u -> %u)\n",
+			depth, set->queue_depth);
 
 	return 0;
 }
@@ -2845,8 +2845,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 		return -EINVAL;
 
 	if (set->queue_depth > BLK_MQ_MAX_DEPTH) {
-		pr_info("blk-mq: reduced tag depth to %u\n",
-			BLK_MQ_MAX_DEPTH);
+		pr_info("reduced tag depth to %u\n", BLK_MQ_MAX_DEPTH);
 		set->queue_depth = BLK_MQ_MAX_DEPTH;
 	}
 
-- 
2.15.0
