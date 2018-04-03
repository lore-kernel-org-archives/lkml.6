Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754893AbeDCHnJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 03:43:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39115 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbeDCHnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 03:43:07 -0400
X-Google-Smtp-Source: AIpwx4+qY6UMorzBgs8fs6v6fCE2eq9hXEq3GhkQgFKM4h9AaHZeuY4A6fcbAcar8OXAVycznDK1KA==
From: Claudio Scordino <claudio@evidence.eu.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc: Claudio Scordino <claudio@evidence.eu.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH] sched/deadline: add overrun signal and GRUB-PA in the documentation
Date: Tue,  3 Apr 2018 09:42:42 +0200
Message-Id: <1522741362-4542-1-git-send-email-claudio@evidence.eu.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
CC: Juri Lelli <juri.lelli@redhat.com>
CC: Luca Abeni <luca.abeni@santannapisa.it>
CC: linux-kernel@vger.kernel.org
CC: linux-doc@vger.kernel.org
---
 Documentation/scheduler/sched-deadline.txt | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-deadline.txt b/Documentation/scheduler/sched-deadline.txt
index 8ce78f8..b14e03f 100644
--- a/Documentation/scheduler/sched-deadline.txt
+++ b/Documentation/scheduler/sched-deadline.txt
@@ -49,7 +49,7 @@ CONTENTS
 2.1 Main algorithm
 ------------------
 
- SCHED_DEADLINE uses three parameters, named "runtime", "period", and
+ SCHED_DEADLINE [18] uses three parameters, named "runtime", "period", and
  "deadline", to schedule tasks. A SCHED_DEADLINE task should receive
  "runtime" microseconds of execution time every "period" microseconds, and
  these "runtime" microseconds are available within "deadline" microseconds
@@ -117,6 +117,10 @@ CONTENTS
          scheduling deadline = scheduling deadline + period
          remaining runtime = remaining runtime + runtime
 
+ The SCHED_FLAG_DL_OVERRUN flag in sched_attr's sched_flags field allows a task
+ to get informed about runtime overruns through the delivery of SIGXCPU
+ signals.
+
 
 2.2 Bandwidth reclaiming
 ------------------------
@@ -279,6 +283,19 @@ CONTENTS
     running_bw is incremented.
 
 
+2.3 Energy-aware scheduling
+------------------------
+
+ When cpufreq's schedutil governor is selected, SCHED_DEADLINE implements the
+ GRUB-PA [19] algorithm, reducing the CPU operating frequency to the minimum
+ value that still allows to meet the deadlines. This behavior is currently
+ implemented only for ARM architectures.
+
+ A particular care must be taken in case the time needed for changing frequency
+ is of the same order of magnitude of the reservation period. In such cases,
+ setting a fixed CPU frequency results in a lower amount of deadline misses.
+
+
 3. Scheduling Real-Time Tasks
 =============================
 
@@ -505,6 +522,12 @@ CONTENTS
   17 - L. Abeni, G. Lipari, A. Parri, Y. Sun, Multicore CPU reclaiming: parallel
        or sequential?. In Proceedings of the 31st Annual ACM Symposium on Applied
        Computing, 2016.
+  18 - J. Lelli, C. Scordino, L. Abeni, D. Faggioli, Deadline scheduling in the
+       Linux kernel, Software: Practice and Experience, 46(6): 821-839, June
+       2016.
+  19 - C. Scordino, L. Abeni, J. Lelli, Energy-Aware Real-Time Scheduling in
+       the Linux Kernel, 33rd ACM/SIGAPP Symposium On Applied Computing (SAC
+       2018), Pau, France, April 2018.
 
 
 4. Bandwidth management
-- 
2.7.4
