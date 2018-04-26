Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755605AbeDZKhN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:37:13 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42786 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755306AbeDZKhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:37:07 -0400
X-Google-Smtp-Source: AIpwx4/bs3UMIfxDLzAsjppLfO5Re76FpJ+m+IZ6nnzxrCRlzUWNoaYNFhj+Q5fafFQIxHdqThmwEQ==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: use RETRY_TASK in idle_balance
Date: Thu, 26 Apr 2018 12:37:02 +0200
Message-Id: <1524739022-7788-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use RETRY_TASK in idle_balance when we want select_task_rq() function to 
rerun the complete task selection path

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0951d1c..ba49f83 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9862,7 +9862,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 	/* Is there a task of a high priority class? */
 	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
-		pulled_task = -1;
+		pulled_task = RETRY_TASK;
 
 	if (pulled_task)
 		this_rq->idle_stamp = 0;
-- 
2.7.4
