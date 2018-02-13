Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965876AbeBMUf1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:35:27 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39649 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965634AbeBMUcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:32:52 -0500
X-Google-Smtp-Source: AH8x225oZDkGe2lOg354DtDVuXZ5Xg48ciemS4dVQo07AohLOJaT9G+f3WGDG1+a1624h8u4S/5gUw==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: peterz@infradead.org
Cc: lizefan@huawei.com, mingo@redhat.com, rostedt@goodmis.org,
        claudio@evidence.eu.com, bristot@redhat.com,
        tommaso.cucinotta@santannapisa.it, juri.lelli@redhat.com,
        luca.abeni@santannapisa.it, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 01/10] sched/topology: Add check to backup comment about hotplug lock
Date: Tue, 13 Feb 2018 13:32:38 -0700
Message-Id: <1518553967-20656-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518553967-20656-1-git-send-email-mathieu.poirier@linaro.org>
References: <1518553967-20656-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment above function partition_sched_domains() clearly state that
the cpu_hotplug_lock should be held but doesn't mandate one to abide to
it.  Adding an explicit check backs that comment and make it impossible
for anyone to miss the requirement.

Suggested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 kernel/sched/topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8010c2974d30..7c744c7425ec 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1863,6 +1863,7 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 	int i, j, n;
 	int new_topology;
 
+	lockdep_assert_cpus_held();
 	mutex_lock(&sched_domains_mutex);
 
 	/* Always unregister in case we don't destroy any domains: */
-- 
2.7.4
