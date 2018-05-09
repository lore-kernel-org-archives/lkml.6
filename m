Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756138AbeEIGp0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 02:45:26 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:46595 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755434AbeEIGpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 02:45:24 -0400
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From: Byungchul Park <byungchul.park@lge.com>
To: peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org
Cc: tglx@linutronix.de, raistlin@linux.it, linux-kernel@vger.kernel.org,
        juri.lelli@gmail.com, bristot@redhat.com, kernel-team@lge.com
Subject: [RESEND PATCH v11 0/2] Make find_later_rq() choose a closer cpu in topology
Date: Wed,  9 May 2018 15:44:21 +0900
Message-Id: <1525848263-10958-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change from v10
   -. modify a comment a bit as Steven suggested

Change from v9
   -. modify a comment a bit so to be more clear as Juri suggested

Change from v8
   -. add suggested-by Peterz
   -. add several comments

Change from v7
   -. fix a trivial typo
   -. modify commit messages to explain what it does more clearly
   -. simplify code with an existing macro

Change from v6
   -. add a comment about selection of fallback_cpu incase more than one exist
   -. modify a comment explaining what we do wrt PREFER_SIBLING

Change from v5
   -. exclude two patches already picked up by peterz
      (sched/deadline: Make find_later_rq() choose a closer cpu in topology)
      (sched/deadline: Change return value of cpudl_find())
   -. apply what peterz fixed for 'prefer sibling', into deadline and rt

Change from v4
   -. remove a patch that might cause huge lock contention
      (by spin lock(&cpudl.lock) in a hot path of scheduler)

Change from v3
   -. rename closest_cpu to best_cpu so that it align with rt
   -. protect referring cpudl.elements with cpudl.lock
   -. change return value of cpudl_find() to bool

Change from v2
   -. add support for SD_PREFER_SIBLING

Change from v1
   -. clean up the patch

Byungchul Park (2):
  sched/deadline: Add support for SD_PREFER_SIBLING on find_later_rq()
  sched/rt: Add support for SD_PREFER_SIBLING on find_lowest_rq()

 kernel/sched/deadline.c | 82 ++++++++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/rt.c       | 80 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 152 insertions(+), 10 deletions(-)

-- 
1.9.1
