Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966129AbeEJPGH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:06:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57298 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965665AbeEJPGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:06:05 -0400
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: [PATCH 0/3] Improve schedutil integration for FAIR tasks
Date: Thu, 10 May 2018 16:05:50 +0100
Message-Id: <20180510150553.28122-1-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up of:

   https://lkml.org/lkml/2018/4/6/935

where the original patch has been split into three to better address the
different issues discussed in the previous posting.

The first two patches of this series are fixes for:
 - FAIR utilization aggregation
   based on blocked utilization decay instead of cfs.h_nr_running
 - Estimated utilization updates
   which needs to be updated before schedutil is at enqueue time

The last patch provides the remaining bits of the original one in a self
contained re-factoring of how we update schedutil for FAIR tasks.

Cheers Patrick

Patrick Bellasi (3):
  sched/cpufreq: always consider blocked FAIR utilization
  sched/fair: util_est: update before schedutil
  sched/fair: schedutil: explicit update only when required

 kernel/sched/cpufreq_schedutil.c | 17 ++++----
 kernel/sched/fair.c              | 83 ++++++++++++++++++----------------------
 2 files changed, 46 insertions(+), 54 deletions(-)

-- 
2.15.1
