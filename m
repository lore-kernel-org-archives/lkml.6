Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbeBAKcZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:32:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751766AbeBAKcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:32:21 -0500
From: Daniel Bristot de Oliveira <bristot@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/scheduler/sched-rt-group: Update SCHED DEADLINE references
Date: Thu,  1 Feb 2018 11:31:59 +0100
Message-Id: <61a3d8b77457f71452294d0aba371674e4ec7693.1517480458.git.bristot@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation was mentioning the "future SCHED EDF" as the
solution for fine-grained control of deadline/period. This patch
updates this citing the (now) existing SCHED_DEADLINE.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Cc: Claudio Scordino <claudio@evidence.eu.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
 Documentation/scheduler/sched-rt-group.txt | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/Documentation/scheduler/sched-rt-group.txt b/Documentation/scheduler/sched-rt-group.txt
index d8fce3e78457..ed763c243914 100644
--- a/Documentation/scheduler/sched-rt-group.txt
+++ b/Documentation/scheduler/sched-rt-group.txt
@@ -153,7 +153,7 @@ There is work in progress to make the scheduling period for each group
 
 The constraint on the period is that a subgroup must have a smaller or
 equal period to its parent. But realistically its not very useful _yet_
-as its prone to starvation without deadline scheduling.
+as its prone to starvation.
 
 Consider two sibling groups A and B; both have 50% bandwidth, but A's
 period is twice the length of B's.
@@ -168,16 +168,7 @@ This means that currently a while (1) loop in A will run for the full period of
 B and can starve B's tasks (assuming they are of lower priority) for a whole
 period.
 
-The next project will be SCHED_EDF (Earliest Deadline First scheduling) to bring
-full deadline scheduling to the linux kernel. Deadline scheduling the above
-groups and treating end of the period as a deadline will ensure that they both
-get their allocated time.
-
-Implementing SCHED_EDF might take a while to complete. Priority Inheritance is
-the biggest challenge as the current linux PI infrastructure is geared towards
-the limited static priority levels 0-99. With deadline scheduling you need to
-do deadline inheritance (since priority is inversely proportional to the
-deadline delta (deadline - now)).
-
-This means the whole PI machinery will have to be reworked - and that is one of
-the most complex pieces of code we have.
+Nowadays it is possible to use the deadline scheduler (SCHED_DEADLINE) to
+allocate runtime/period for tasks. The deadline scheduler does not suffer the
+side effects explained above. For more information about the deadline
+scheduler, you should read Documentation/scheduler/sched-deadline.txt.
-- 
2.14.3
