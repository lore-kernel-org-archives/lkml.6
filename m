Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35F0C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A044F2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A044F2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbeHOUC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:02:59 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:62974 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbeHOUC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:02:59 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 4C151812E76D8D0C6DD9;
        Thu, 16 Aug 2018 01:09:58 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w7FH9qwe056136;
        Thu, 16 Aug 2018 01:09:52 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018081601095965-4606858 ;
          Thu, 16 Aug 2018 01:09:59 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, wang.yi59@zte.com.cn,
        zhong.weidong@zte.com.cn
Subject: [PATCH] sched/deadline: Fix indent in pick_next_task_dl()
Date:   Thu, 16 Aug 2018 01:09:26 +0800
Message-Id: <1534352966-46407-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-08-16 01:09:59,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-08-16 01:09:44,
        Serialize complete at 2018-08-16 01:09:44
X-MAIL: mse01.zte.com.cn w7FH9qwe056136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Substitute spaces with tab before the call of function
dequeue_pushable_dl_task().

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 997ea7b..aa9038f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1753,7 +1753,7 @@ static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
 	p->se.exec_start = rq_clock_task(rq);
 
 	/* Running task will never be pushed. */
-       dequeue_pushable_dl_task(rq, p);
+	dequeue_pushable_dl_task(rq, p);
 
 	if (hrtick_enabled(rq))
 		start_hrtick_dl(rq, p);
-- 
1.8.3.1

