Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F6AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F4A21104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F4A21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeKZVKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:10:12 -0500
Received: from mout.gmx.net ([212.227.17.21]:59263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbeKZVKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:10:12 -0500
Received: from ovpn-120-189.rdu2.redhat.com ([98.118.28.103]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0Lcjdr-1fjOKX1cbX-00k7a7; Mon, 26 Nov 2018 11:11:18 +0100
From:   Qian Cai <cai@gmx.us>
To:     akpm@linux-foundation.org
Cc:     tglx@linutronix.de, longman@redhat.com, yang.shi@linux.alibaba.com,
        arnd@arndb.de, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
Subject: [PATCH v2] debugobjects: call debug_objects_mem_init eariler
Date:   Mon, 26 Nov 2018 05:10:41 -0500
Message-Id: <20181126101041.1744-1-cai@gmx.us>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-Provags-ID: V03:K1:mPKq4DG3r06iAnJ9wLI0VtJ35pqVEXCxKeMEjC2wh3arpkR71cD
 e2N0XEXwFsRWd+jgnOfX3yNnpe76gEkZrdlwkDWlQREiXF+ValgAlxhoVqeGBc3XXK21vYP
 apoBlG5WMp8gdzIOPmLsSdIUUamhYyswlk+pn4Ypg7jZYNY5TtYcNgp0Sm123GZhNMrhU2h
 kNVDgpTN11ZTSdCcN5arQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7/cAI8CR/9U=:u+Q7/EPolVWIGjELT3ARA5
 74qNITsVsrfWZQFfd8i4k7JaQN/r94lZlbhf5ekYP0SWGNDvwY1H+iOjVipbGAFMK8bv5PEGV
 VukfHp4oQ7ukWkD4bRAbdgFy8JE7APMc1TLuwdihD/fhY7tdseZXYvB6PGVb8uXSCHUDd878D
 6AbRy9b/sxNH8uVtVQOwOrMFcZrkgl6NffaLu1uZN4JqcvJbvYTqSxvCMNr2MEnW0EiKzhUje
 lJzacBzvhmFAJZ8I90ZBnf/zFoAi+z6BzBT2ZIFkl4TUC1KkJsm/wvDnsbuinl6W2cN+6dDoA
 3dTTu30pPZFZZ4mXcTve2XnddI+bTzSLs2/IhigIf2DBUQgOt7kU1b2EaAXc42G76+74LYc0T
 jl2Q1tTtOPIGs1sqcBv723O5bkqzF0JihzPKDyzNYvwSugzs/E7i2nroaNr5spwPjwJAIVIkb
 lDjbLBUeILMb8qX0aCbyIjeX4h6X7K8iaMunCeo/RkmEY/Z0JuQRUpVBhEVmVmmykD6zPs1Ov
 AXa0MzNXS1GECQQz7lO1jY9X+XZtqzaUqLmrgCCKStebJPIxdfF2q2vD8KAcBvzQXD2GEO892
 4UPvjfZdqc9+eUNmAZ7hDsRxQLbILrnGwPAypj5j3GLp+kfZYvQ6Y0BEyYdi+KAM1Gm1uBddn
 Io/vA9u6/pt1jo96GY8Fo9yW3GR+PBShI/Wk0Fq2H+rFunJ+HTNpCcRTWg41Bilbk+jhBt1ZW
 q5LT6Uro9jVLMT/xtSogdxNwnAZaQ4QWcXNTGNAp1EO2b2FfX8wj3M63ZG44xaPB8cW08H9Yv
 krg1ej49FJvZMmGe4JSo36X9MH4NQ8EJRGBHVDrZS4NInIdlDgaF1G2kSBYen1WAA3JGJ+tKe
 kOxx9/+hRx/5dV4it9FGU7mAFUADeTnnRhmcxtil4=
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

plus No. CPUs objects (CONFIG_HIGH_RES_TIMERS):
sched_init
  hrtick_rq_init
    hrtimer_init

CONFIG_DEBUG_OBJECTS_WORK:
No. CPUs objects:
vmalloc_init
  __init_work

plus No. CPUs x 6 (workqueue) objects:
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

However, none of the things are actually used or required before
debug_objects_mem_init() is invoked, so just move the call right
before vmalloc_init().

According to tglx,
"the reason why the call is at this place in start_kernel() is
historical. It's because back in the days when debugobjects were added
the memory allocator was enabled way later than today."

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Qian Cai <cai@gmx.us>
---
Changes since v1:
* Added some comments about interrupts.

 init/main.c        | 2 +-
 lib/debugobjects.c | 9 +++------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/init/main.c b/init/main.c
index ee147103ba1b..2b7b7fe173c9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -521,6 +521,7 @@ static void __init mm_init(void)
 	mem_init();
 	kmem_cache_init();
 	pgtable_init();
+	debug_objects_mem_init();
 	vmalloc_init();
 	ioremap_huge_init();
 	/* Should be run before the first non-init thread is created */
@@ -697,7 +698,6 @@ asmlinkage __visible void __init start_kernel(void)
 #endif
 	page_ext_init();
 	kmemleak_init();
-	debug_objects_mem_init();
 	setup_per_cpu_pageset();
 	numa_policy_init();
 	acpi_early_init();
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 70935ed91125..1e01d0e505db 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1133,11 +1133,10 @@ static int __init debug_objects_replace_static_objects(void)
 	}
 
 	/*
-	 * When debug_objects_mem_init() is called we know that only
-	 * one CPU is up, so disabling interrupts is enough
-	 * protection. This avoids the lockdep hell of lock ordering.
+	 * debug_objects_mem_init() is now called early that only one CPU is up
+	 * and interrupts have been disabled, so it is safe to replace the
+	 * active object references.
 	 */
-	local_irq_disable();
 
 	/* Remove the statically allocated objects from the pool */
 	hlist_for_each_entry_safe(obj, tmp, &obj_pool, node)
@@ -1145,7 +1144,6 @@ static int __init debug_objects_replace_static_objects(void)
 	/* Move the allocated objects to the pool */
 	hlist_move_list(&objects, &obj_pool);
 
-	/* Replace the active object references */
 	for (i = 0; i < ODEBUG_HASH_SIZE; i++, db++) {
 		hlist_move_list(&db->list, &objects);
 
@@ -1158,7 +1156,6 @@ static int __init debug_objects_replace_static_objects(void)
 			cnt++;
 		}
 	}
-	local_irq_enable();
 
 	pr_debug("%d of %d active objects replaced\n",
 		 cnt, obj_pool_used);
-- 
2.17.2 (Apple Git-113)

