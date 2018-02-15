Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032384AbeBOAsY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 19:48:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032264AbeBOAsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 19:48:23 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E2621775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
From: Frederic Weisbecker <frederic@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <kernellwp@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Rik van Riel <riel@redhat.com>
Subject: [PATCH 0/6] isolation: 1Hz residual tick offloading v6
Date: Thu, 15 Feb 2018 01:48:08 +0100
Message-Id: <1518655694-8057-1-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The version addresses the reviews from Ingo on v5:

* Start changelog titles with verbs.
* Improve/reword several comments.
* Improve/reword documentation.
* Various cosmetic changes.
* Use BUG_ON() on boot allocation failure.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	sched/0hz-v6

HEAD: 7011ba38353ad8ec398ade7533c73828d27462ad

Thanks,
	Frederic
---

Frederic Weisbecker (6):
      sched: Rename init_rq_hrtick to hrtick_rq_init
      nohz: Allow to check if remote CPU tick is stopped
      sched/isolation: Isolate workqueues when "nohz_full=" is set
      sched/isolation: Offload residual 1Hz scheduler tick
      sched/nohz: Remove the 1 Hz tick code
      sched/isolation: Update nohz documentation to explain tick offload


 Documentation/admin-guide/kernel-parameters.txt |  11 +++
 include/linux/sched/isolation.h                 |   1 +
 include/linux/sched/nohz.h                      |   4 -
 include/linux/tick.h                            |   2 +
 kernel/sched/core.c                             | 117 ++++++++++++++++++------
 kernel/sched/idle_task.c                        |   1 -
 kernel/sched/isolation.c                        |   7 +-
 kernel/sched/sched.h                            |  13 +--
 kernel/time/tick-sched.c                        |  13 +--
 kernel/workqueue.c                              |   3 +-
 10 files changed, 122 insertions(+), 50 deletions(-)
