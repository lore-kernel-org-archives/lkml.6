Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbeCOVVN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 17:21:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752619AbeCOVVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 17:21:11 -0400
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, efault@gmx.de, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v5 0/2] cpuset: Enable cpuset controller in default hierarchy
Date: Thu, 15 Mar 2018 17:20:40 -0400
Message-Id: <1521148842-15486-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5:
 - Add patch 2 to provide the cpuset.flags control knob for the
   sched_load_balance flag which should be the only feature that is
   essential as a replacement of the "isolcpus" kernel boot parameter.

v4:
 - Further minimize the feature set by removing the flags control knob.

v3:
 - Further trim the additional features down to just memory_migrate.
 - Update Documentation/cgroup-v2.txt.

The purpose of this patchset is to provide a minimal set of cpuset
features for cgroup v2. That minimal set includes the cpus, mems and
their effective_* counterparts as well as a new flags control knob
that currently supports only the sched_load_balance flag.

This patchset does not exclude the possibility of adding more flags
and features in the future after careful consideration.

Patch 1 enables cpuset in cgroup v2 with cpus, mems and their
effective_* counterparts.

Patch 2 adds flags with support for the sched_load_balance only.

Waiman Long (2):
  cpuset: Enable cpuset controller in default hierarchy
  cpuset: Add cpuset.flags control knob to v2

 Documentation/cgroup-v2.txt | 128 ++++++++++++++++++++++++++++++++++++----
 kernel/cgroup/cpuset.c      | 140 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 256 insertions(+), 12 deletions(-)

-- 
1.8.3.1
