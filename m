Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970393AbeEXOKh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:10:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45430 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967947AbeEXOKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:10:34 -0400
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
Subject: [PATCH v3 0/2] Improve schedutil integration for FAIR tasks
Date: Thu, 24 May 2018 15:10:21 +0100
Message-Id: <20180524141023.13765-1-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the (hopefully) final update of:

   https://lkml.org/lkml/2018/5/11/319
   20180511131509.16275-1-patrick.bellasi@arm.com

including only the first two patches of the original series, which have been
already reviewed and acked by Viresh and Vincent.

The last patch has been removed from this series since, during the discussion,
we agree that it's not completely fixing the problem it was addressing and we
would like to explore a better and more complete solution. Thus, I'll follow up
on a separated and dedicated series.

Cheers Patrick

Changes in v3:
 - add "Tested-by" and "Acked-by" Vincent tags

Changes in v2:
 - improve comment in enqueue_task_fair() (Peter)
 - add "Fixes" tag
 - add "Acked-by" Viresh tag

Patrick Bellasi (2):
  sched/cpufreq: always consider blocked FAIR utilization
  sched/fair: util_est: update before schedutil

 kernel/sched/cpufreq_schedutil.c | 17 ++++++++---------
 kernel/sched/fair.c              |  9 ++++++++-
 2 files changed, 16 insertions(+), 10 deletions(-)

-- 
2.15.1
