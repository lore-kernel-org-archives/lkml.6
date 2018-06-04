Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbeFDILg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:11:36 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:45283 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751097AbeFDILe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:11:34 -0400
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From: Byungchul Park <byungchul.park@lge.com>
To: peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org
Cc: tglx@linutronix.de, raistlin@linux.it, linux-kernel@vger.kernel.org,
        juri.lelli@gmail.com, bristot@redhat.com, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: [PATCH v12 0/2] Make find_later_rq() choose a closer cpu in topology
Date: Mon,  4 Jun 2018 17:10:04 +0900
Message-Id: <1528099806-30632-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change from v11
   -. Rebase onto the latest tip/sched/core
   -. make the word 'cpu' in comments be upper case as Ingo did
      in the commit 97fb7a0a89
   -. Avoid a compile warning caused by mismatching bwt const and
      non-const 'struct sched_domain' in find_cpu()

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

*** BLURB HERE ***

Byungchul Park (2):
  sched/deadline: Add support for SD_PREFER_SIBLING on find_later_rq()
  sched/rt: Add support for SD_PREFER_SIBLING on find_lowest_rq()

 kernel/sched/deadline.c | 80 ++++++++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/rt.c       | 78 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 148 insertions(+), 10 deletions(-)

-- 
1.9.1
