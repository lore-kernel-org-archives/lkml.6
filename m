Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19012C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D380D222CF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405881AbfBNGmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:42:07 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:36230 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394037AbfBNGmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 01:42:07 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 754503B389F73D10729B;
        Thu, 14 Feb 2019 14:42:03 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x1E6ftZp051506;
        Thu, 14 Feb 2019 14:41:55 +0800 (GMT-8)
        (envelope-from huang.zijiang@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019021414422509-26036285 ;
          Thu, 14 Feb 2019 14:42:25 +0800 
From:   Huang Zijiang <huang.zijiang@zte.com.cn>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        wang.yi59@zte.com.cn, Huang Zijiang <huang.zijiang@zte.com.cn>
Subject: [PATCH] sched/core: Remove BUG_ON()
Date:   Thu, 14 Feb 2019 14:42:37 +0800
Message-Id: <1550126557-28530-1-git-send-email-huang.zijiang@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-02-14 14:42:25,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-14 14:41:43,
        Serialize complete at 2019-02-14 14:41:43
X-MAIL: mse01.zte.com.cn x1E6ftZp051506
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pick_next_task is never return NULL because idle task
will return when cpu is idle.

Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
---
 kernel/sched/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dbe9a3f..1de1a85 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5624,7 +5624,6 @@ static void migrate_tasks(struct rq *dead_rq, struct rq_flags *rf)
  * 		 * pick_next_task() assumes pinned rq->lock:
  * 		 		 */
 		next = pick_next_task(rq, &fake_task, rf);
-		BUG_ON(!next);
 		put_prev_task(rq, next);
 
 		/*
-- 
1.8.3.1

