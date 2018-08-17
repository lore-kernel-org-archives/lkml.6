Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91429C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FD4208FA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OY9yepES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FD4208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeHQVco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:32:44 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:47183 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeHQVcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:32:43 -0400
Received: by mail-oi0-f73.google.com with SMTP id w128-v6so7921537oiw.14
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 11:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/3Uu972U/RgSEz+2T2FBIwg2AdeaO7TwqX4vV6NphQE=;
        b=OY9yepES1Myt+VRCqTO9fTea8yyJU9xfjFzGQsidzzQibbHwfcSASPgH5s44PSxdk6
         SutDjO5LT/jNXaKNVF+5NqfwB0PqJRLQ0qW3FKMLx+gXRdJc/G58TnMKlzACFM0Pk+rq
         wnbO4uaDT/KU/fCajw49OS0PI5zexzlVsdiOkw/LvEQmrtjN3Wu6EsGrs6HuwjwHIUye
         P07ADrzqgIBvyn/DFu807kIXIQmBTiG0C6PF+E3HkC5jiVhu8ky2+p7tUKwo4ShxGhT5
         76lA90VYZJRC4EYvn4JUcPA8ro4RkSg0QuIaCFpo6IaDpUART084cih4h+zrFdzX0x0a
         Sz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/3Uu972U/RgSEz+2T2FBIwg2AdeaO7TwqX4vV6NphQE=;
        b=pa4CukHHI5n5UmnParpm+URNBUvWN/ORBjSEbm6xAOcH2jL8aFzEOCEJ0gEafc5AdJ
         MSKnTSa6p5SGpm5NzDy03ESmdLmAb9MB1TMh8HyvLJBTNRzfSWkaZyXkaMEUUmGvQul3
         RVbhuwW1VOquFejp00uL613/scaKCpfmhVtKVxRUOFKZBklReFOxbCbTbzdb3gkKhiei
         lFX+4pvl9grjIZQ5nC7cKHfIBN1SXDtHGR9IaPooX28cTYtwXN9APAP+ErRtym+6Moez
         tfAQSbtI09eB3pJcb1IK8oRlOXPdpgsunpq+4bS8pMeDrr79eA3Q/pXxvLF51Uav7LBQ
         SJhw==
X-Gm-Message-State: AOUpUlHm5mnPK9MuTO2E6PKv8hFY0NI3ArZyORtlHo+v2f9nOKQJpWi/
        Kbtg/leBznLN5pVWzeqciVzaNV5XfHEp
X-Google-Smtp-Source: AA+uWPx33hXgSD11XtEZw0bPkPerMWPKCjt4i9XWJj9WdFj9PVBH7geLh7rcDw7KS3Bt/cxGD0JUDUxHHonu
X-Received: by 2002:aca:bcd5:: with SMTP id m204-v6mr22473825oif.101.1534530499179;
 Fri, 17 Aug 2018 11:28:19 -0700 (PDT)
Date:   Fri, 17 Aug 2018 11:27:28 -0700
Message-Id: <20180817182728.76129-1-smuckle@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH] sched/fair: vruntime should normalize when switching from fair
From:   Steve Muckle <smuckle@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>, Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>,
        Steve Muckle <smuckle@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Dias <joaodias@google.com>

When rt_mutex_setprio changes a task's scheduling class to RT,
we're seeing cases where the task's vruntime is not updated
correctly upon return to the fair class.
Specifically, the following is being observed:
- task is deactivated while still in the fair class
- task is boosted to RT via rt_mutex_setprio, which changes
  the task to RT and calls check_class_changed.
- check_class_changed leads to detach_task_cfs_rq, at which point
  the vruntime_normalized check sees that the task's state is TASK_WAKING,
  which results in skipping the subtraction of the rq's min_vruntime
  from the task's vruntime
- later, when the prio is deboosted and the task is moved back
  to the fair class, the fair rq's min_vruntime is added to
  the task's vruntime, even though it wasn't subtracted earlier.
The immediate result is inflation of the task's vruntime, giving
it lower priority (starving it if there's enough available work).
The longer-term effect is inflation of all vruntimes because the
task's vruntime becomes the rq's min_vruntime when the higher
priority tasks go idle. That leads to a vicious cycle, where
the vruntime inflation repeatedly doubled.

The change here is to detect when vruntime_normalized is being
called when the task is waking but is waking in another class,
and to conclude that this is a case where vruntime has not
been normalized.

Signed-off-by: John Dias <joaodias@google.com>
Signed-off-by: Steve Muckle <smuckle@google.com>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b39fb596f6c1..14011d7929d8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9638,7 +9638,8 @@ static inline bool vruntime_normalized(struct task_struct *p)
 	 * - A task which has been woken up by try_to_wake_up() and
 	 *   waiting for actually being woken up by sched_ttwu_pending().
 	 */
-	if (!se->sum_exec_runtime || p->state == TASK_WAKING)
+	if (!se->sum_exec_runtime ||
+	    (p->state == TASK_WAKING && p->sched_class == &fair_sched_class))
 		return true;
 
 	return false;
-- 
2.18.0.865.gffc8e1a3cd6-goog

