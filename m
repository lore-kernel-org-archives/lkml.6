Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FF6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 04:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2352D20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 04:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2352D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408111AbeKWPPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 10:15:47 -0500
Received: from mout.gmx.net ([212.227.17.20]:34241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408098AbeKWPPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 10:15:47 -0500
Received: from ovpn-120-115.rdu2.redhat.com ([98.118.28.103]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0Le69A-1fegAs15qO-00ps1s; Fri, 23 Nov 2018 05:32:06 +0100
From:   Qian Cai <cai@gmx.us>
To:     akpm@linux-foundation.org, tglx@linutronix.de
Cc:     longman@redhat.com, yang.shi@linux.alibaba.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
Subject: [PATCH] debugobjects: call debug_objects_mem_init eariler
Date:   Thu, 22 Nov 2018 23:31:17 -0500
Message-Id: <20181123043117.992-1-cai@gmx.us>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <alpine.DEB.2.21.1811222238270.1665@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1811222238270.1665@nanos.tec.linutronix.de>
X-Provags-ID: V03:K1:97D6UMF4SK1zOYYcu1s5MuZmo99JJhw17VJKV1+S5Lqbo4X1dcB
 O7xfVNnQ9/v9nzZjZE9jB9Unkwxaa6Z96szUtOvQSvix1nDUrzp9yxTenwAjM/cqvgL1MME
 w7aPcYu5OG0WgWqYImToC4Fe5Sh6FOigriI6L6ac9ov0PBcSNUmLlL107gsoNynf5du/Wfv
 uaGHVcfoDGPdVU1PN2S6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9ua/C7gP87Q=:4a6Pd3gYSS4rckr6POZkQU
 cmpw6XGO6q7wzzsmscHT7vcrkrZjFcSBruYUdtG+X7amXyq25QCOJWGEqCusBTq2XNquZ8k2T
 Hdyu1Kv67o6I3Ki7dcuQAIOQro9xlV2SsQaIpddxEKyXgqPj+xmJ+VzOspF3XujE/w9nZ1Do/
 cLJLWkU0ZFGjwvhmWEM/XbOOtfcWxOXlFLMW0+D/qeqhRtFcE4joAa/Z8Xj0KuNfxW+mZP0z0
 lSxoRzRNvPg53E+7T2uSA2S6JY633uAOW2HwqsxmMhvSFWlCfKVqxgdrVtlaaI4ccLJnj4T/M
 4aYx0pyxj4xOMb8FhRFdpaWJLgUzehdC7GjrBs50hvJ/PRNgdsw9UpSHNkTsrPLSs19pZbjKl
 O63niBpCm6rRf5SCOPUs0GPrXSXx5l1eOAijIh0V+lksyy6SAtRGHntgds526UTohQkoKBbpm
 n5gxttZmfe9Qa/Xbt69XGTF+RpRfvdTUlOJiRsxoXk/AhKBgk3rnELNbDk1jBK8HLhpf50/r2
 CBhTzTPwov2B9ZXtXK9fRVduGVq78MarD17b51O/NkOPel+grKWJnyisaDMc1+ZIc+igMHH1k
 EdY+irGoZmlZpDcdMixo08pBVgea0vzAW6sWXwu/hfJOPqxjEpClGddu60L5P9vj78K15+fPr
 l7IImnosfhNsCPX4nhQ9Evq/qn6y3dBi181fRuih3rRSaWhoXbArG8X5zlCnT/zt9UoX5KmNt
 rxBLINg1H5+13Az2kF2xIBaeaTmvpD/UXpydRBoI+DQIGC4mbT7y2rafH0pkVlhAagFH0iQHZ
 0kpJZQ15dDyfusbRLkSBZ3rDQqR4xHMKMidH+PWqsbA2tdLnMZZVTDguN+ctLq2Y23iUHPR0Y
 E2r10LvolDdKdpFROPkpDaw76YbBhwEPmHuu21DsU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current value of the early boot static pool size, 1024 is not big
enough for systems with large number of CPUs with timer or/and workqueue
objects selected. As the results, systems have 60+ CPUs with both timer
and workqueue objects enabled could trigger "ODEBUG: Out of memory.
ODEBUG disabled".

Some debug objects are allocated during the early boot. Enabling some
options like timers or workqueue objects may increase the size required
significantly with large number of CPUs. For example,

CONFIG_DEBUG_OBJECTS_TIMERS:
No. CPUs x 2 (worker pool) objects:
start_kernel
  workqueue_init_early
    init_worker_pool
      init_timer_key
        debug_object_init

No. CPUs objects (CONFIG_HIGH_RES_TIMERS):
sched_init
  hrtick_rq_init
    hrtimer_init

CONFIG_DEBUG_OBJECTS_WORK:
No. CPUs x 6 (workqueue) objects:
workqueue_init_early
  alloc_workqueue
    __alloc_workqueue_key
      alloc_and_link_pwqs
        init_pwq

Also, plus No. CPUs objects:
perf_event_init
  __init_srcu_struct
    init_srcu_struct_fields
      init_srcu_struct_nodes
        __init_work

However, none of the things are actually used or required beofre
debug_objects_mem_init() is invoked.

According to tglx,
"the reason why the call is at this place in start_kernel() is
historical. It's because back in the days when debugobjects were added
the memory allocator was enabled way later than today. So we can just
move the debug_objects_mem_init() call right before sched_init()."

Afterwards, when calling debug_objects_mem_init(), interrupts have
already been disabled and lockdep_init() will only be called later, so
no need to worry about interrupts in
debug_objects_replace_static_objects().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Qian Cai <cai@gmx.us>
---
 init/main.c        | 3 ++-
 lib/debugobjects.c | 8 --------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/init/main.c b/init/main.c
index ee147103ba1b..f2c35dc50851 100644
--- a/init/main.c
+++ b/init/main.c
@@ -600,6 +600,8 @@ asmlinkage __visible void __init start_kernel(void)
 	/* trace_printk can be enabled here */
 	early_trace_init();
 
+	debug_objects_mem_init();
+
 	/*
 	 * Set up the scheduler prior starting any interrupts (such as the
 	 * timer interrupt). Full topology setup happens at smp_init()
@@ -697,7 +699,6 @@ asmlinkage __visible void __init start_kernel(void)
 #endif
 	page_ext_init();
 	kmemleak_init();
-	debug_objects_mem_init();
 	setup_per_cpu_pageset();
 	numa_policy_init();
 	acpi_early_init();
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 70935ed91125..cc5818ced652 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1132,13 +1132,6 @@ static int __init debug_objects_replace_static_objects(void)
 		hlist_add_head(&obj->node, &objects);
 	}
 
-	/*
-	 * When debug_objects_mem_init() is called we know that only
-	 * one CPU is up, so disabling interrupts is enough
-	 * protection. This avoids the lockdep hell of lock ordering.
-	 */
-	local_irq_disable();
-
 	/* Remove the statically allocated objects from the pool */
 	hlist_for_each_entry_safe(obj, tmp, &obj_pool, node)
 		hlist_del(&obj->node);
@@ -1158,7 +1151,6 @@ static int __init debug_objects_replace_static_objects(void)
 			cnt++;
 		}
 	}
-	local_irq_enable();
 
 	pr_debug("%d of %d active objects replaced\n",
 		 cnt, obj_pool_used);
-- 
2.17.2 (Apple Git-113)

