Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EA2C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B2620841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XS530OL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B2620841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeIACwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:52:10 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:41471 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbeIACwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:52:10 -0400
Received: by mail-qt0-f202.google.com with SMTP id y54-v6so16128284qta.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 15:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bSWtmVHdy6cuRwB7rIChRFaGA6F6tUQK3awO6ib4VPI=;
        b=XS530OL3vf4EYSY01G75QbooLYiWxPdTWpbJklWHmmGchcBtXZ+j5EEjzlUihKLU7T
         8xOQoQlA+IvkIvkSJBRLGzg3DPxIc6PI+wY4aTw5xi9M8GzqwIzXWCmQzWNVBnnEZT7a
         ti2rPfxyCworVLO7u6Cziz5MDawJ7UyPncvVAo0xDeO/w7LSGsNU/vmTIn1O+5l5C9GF
         mYyc5edWgShNtLUKG1JpOwTVY8D2v9TtFXeIu2VmxXy1vJSk1hkmg7QL90L7js4XRs/d
         KIkgMDDxsB82H5CuUUcCkIjxl7fL9C8uuRn+DKSic3N7Z7H4UDmD+iARhAJ2UEmzonhM
         zk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bSWtmVHdy6cuRwB7rIChRFaGA6F6tUQK3awO6ib4VPI=;
        b=oaxUeaU7Wtq0EU8YianAu6kUkGGQ+u3uF+nurJKhKy9cEMkbXNoFgSPkz98b+9j16m
         5udZ9YLafLb2f7WzQUldpmhv2TwtxyWha6K4uCobsGt/eT4fSGe2blPmU7MlX9o2PkDK
         +hxGM6AFKazDvtKMsBeV7NxzK8zNugkoiHXWLM7Yqzfdk6PuvHIldLyqiptBoH+u8Kxv
         0qa+nIeDehAZcAfYOPm6bilJWpIxFX7x45xPB/FhHsuGQm/q5VwUNE275K+LpBblD1B1
         I15T/bVdYc3lidxoxwKJ1cRSZVI9fZAj8CBj8wdoeodUomoX+o8Ft/i8uk3uRKyxFXdc
         vgTw==
X-Gm-Message-State: APzg51AV7xGtZ4KChh+KfzWheRjfs9JdcazyloMTRM7AGGWI4Hw/rhFS
        j5+yiP2VFYnYs33GV0qw6+gwPxITYq10
X-Google-Smtp-Source: ANB0VdZ3VqaYWw/ywG2HNxg1FUPYGPT0OiYcyXYPz8tUTOqiAE1v/UxAID/wgleX3sMjX93GV35dWSVtPfeN
X-Received: by 2002:ac8:2943:: with SMTP id z3-v6mr9929647qtz.1.1535755353713;
 Fri, 31 Aug 2018 15:42:33 -0700 (PDT)
Date:   Fri, 31 Aug 2018 15:42:17 -0700
Message-Id: <20180831224217.169476-1-smuckle@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
Subject: [PATCH] sched/fair: fix vruntime_normalized for remote non-migration wakeup
From:   Steve Muckle <smuckle@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>, Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Miguel de Dios <migueldedios@google.com>,
        John Dias <joaodias@google.com>,
        Steve Muckle <smuckle@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a task which previously ran on a given CPU is remotely queued to
wake up on that same CPU, there is a period where the task's state is
TASK_WAKING and its vruntime is not normalized. This is not accounted
for in vruntime_normalized() which will cause an
error in the task's vruntime if it is switched from the fair class
during this time, for example if it is boosted to RT priority via
rt_mutex_setprio. The rq's min_vruntime will not be subtracted from the
task's vruntime but it will be added again when the task returns to the
fair class. The task's vruntime will have been erroneously doubled and
the effective priority of the task will be reduced.

Note this will also lead to inflation of all vruntimes since the doubled
vruntime value will become the rq's min_vruntime when other tasks leave
the rq. This leads to repeated doubling of the vruntime and priority
penalty.

Fix this by recognizing a WAKING task's vruntime as normalized only if
sched_remote_wakeup is true. This indicates a migration, in which case
the vruntime would have been normalized in migrate_task_rq_fair().

Based on a similar patch from joaodias@google.com.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Steve Muckle <smuckle@google.com>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b39fb596f6c1..b3b62cf37fb6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9638,7 +9638,8 @@ static inline bool vruntime_normalized(struct task_struct *p)
 	 * - A task which has been woken up by try_to_wake_up() and
 	 *   waiting for actually being woken up by sched_ttwu_pending().
 	 */
-	if (!se->sum_exec_runtime || p->state == TASK_WAKING)
+	if (!se->sum_exec_runtime ||
+	    (p->state == TASK_WAKING && p->sched_remote_wakeup))
 		return true;
 
 	return false;
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

