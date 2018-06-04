Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeFDMM0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:12:26 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:50978 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbeFDMMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:12:24 -0400
X-Google-Smtp-Source: ADUXVKI0yEoyqYs0uKVChRlgqcpPe5aEVgYVVt5Y+Oj415KwbEzTlbcIgrKqyxJRFWg7MX8+GOJ6pw==
Date: Mon, 4 Jun 2018 14:12:20 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler changes for v4.18
Message-ID: <20180604121220.GA31206@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus

   # HEAD: 2539fc82aa9b07d968cf9ba1ffeec3e0416ac721 sched/fair: Update util_est before updating schedutil

The main changes in this cycle were:

 - power-aware scheduling improvements (Patrick Bellasi)

 - NUMA balancing improvements (Mel Gorman)

 - vCPU scheduling fixes (Rohit Jain)

 Thanks,

	Ingo

------------------>
Claudio Scordino (1):
      sched/deadline/Documentation: Add overrun signal and GRUB-PA documentation

Mel Gorman (1):
      sched/numa: Stagger NUMA balancing scan periods for new threads

Patrick Bellasi (2):
      sched/cpufreq: Modify aggregate utilization to always include blocked FAIR utilization
      sched/fair: Update util_est before updating schedutil

Rohit Jain (2):
      sched/core: Don't schedule threads on pre-empted vCPUs
      sched/core: Distinguish between idle_cpu() calls based on desired effect, introduce available_idle_cpu()

Sebastian Andrzej Siewior (1):
      sched/wait: Include <linux/wait.h> in <linux/swait.h>

Viresh Kumar (2):
      sched/fair: Rearrange select_task_rq_fair() to optimize it
      sched/fair: Avoid calling sync_entity_load_avg() unnecessarily


 Documentation/scheduler/sched-deadline.txt |  25 +++++-
 include/linux/sched.h                      |   1 +
 include/linux/swait.h                      |   1 +
 kernel/sched/core.c                        |  39 +++++-----
 kernel/sched/cpufreq_schedutil.c           |  17 ++---
 kernel/sched/fair.c                        | 117 +++++++++++++++++++----------
 kernel/sched/sched.h                       |   6 ++
 7 files changed, 137 insertions(+), 69 deletions(-)
