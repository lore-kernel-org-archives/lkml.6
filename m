Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982B5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6464A20989
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6464A20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbeKZVSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:18:23 -0500
Received: from mout.gmx.net ([212.227.17.22]:52965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbeKZVSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:18:22 -0500
Received: from ovpn-120-189.rdu2.redhat.com ([98.118.28.103]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MIzGn-1gOk1a330L-002ac8; Mon, 26 Nov 2018 11:24:20 +0100
From:   Qian Cai <cai@gmx.us>
To:     akpm@linux-foundation.org
Cc:     tglx@linutronix.de, longman@redhat.com, yang.shi@linux.alibaba.com,
        arnd@arndb.de, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
Subject: [PATCH v3] debugobjects: call debug_objects_mem_init eariler
Date:   Mon, 26 Nov 2018 05:24:07 -0500
Message-Id: <20181126102407.1836-1-cai@gmx.us>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-Provags-ID: V03:K1:1Tz2/svqotgATA3XXTiui+Z/aE9UcYytPz7FLUf/G+6sGa6CBPw
 XU0Lj8ebc6Akq/WmyrRz2BFC36b4VFg0TH5J26ld4we6Ctn1HajHWLFIER7hWJrZHxnlmEy
 55Whqjv1toFFsYxQ/QaSdaT7wn9ZdEi0DuMZuM+PLpAthYPqiv7ADnZXeGwVJQ0UqkR1RkL
 WA44XAD20ZsMHkqtOpHWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YQW+ekJPbCg=:cqUlUjpNKI1NLHSEX3IIVN
 vV55i2S7itO2IzyZ9zXCxZ45L2Ke9pcyo9Cvw+3hgcmrgdSDdSVn7m3h5IwUbVYl/NTJeymfl
 Roe9uTvxEAUUiTN2/pFx3JKrC+QqUAuqOXygJMUsdIPfQT9WkhGxnq4ncRmOwJ6U/vcikn6g8
 e/HWKs7yFTCdm69/TQPJOZh4UoDsiMmADPuNP1WsloPRUt0LsnyznFT5GePedDPpCMaegYONM
 zAHF9H6FTc8SDKuUFAsuNdSRjTTliUFRuzmGEcwEWDlpeI1k3J3k0CuX4LzBE+l8S1ncv0nc4
 c5sKyB26TFCNbanxKXIFp47tyJorgzBG2zRFPQDh2Bja9BcrnxGUKBLiHJYCfEQOR3mw8nG8l
 HHfaOewRLWnN2uTabBnPNssAFKuBQQc8c20fzNzw2ypZUOCb6vhk//8jSqFG0RFurdYF/LNSF
 dpX1V38zsQL7YWg2gL5dhDFaThSuIydwvKAiIam2wJ78pEVL4A0H/CcVe7KPeeJfV+7trZb6Y
 EtE9NNphBra2JP5XrM/W2mKZldrIbsx0yWl/oKuC732jz4dYhOsZd9cbzqA3MybFYyHv3Zhu/
 UTypcjWLBx2XqInzuKBrRHXpT4DDy3aDrWkwEWUvp9Mf4AwGklt8LodQGCItr9M2RzyTVdQtz
 CrRN6GtWCwlYw0ftAhAa3Vy2eXxXGel1NI02P/6NQtuDXTA7RB2YU//aW9NmxlrJ14ROmsZS2
 AvlfEzPf5KwyV4kXgC27cvW9qEvSevZ4PkKWCmQshds5TP7EbzDTmT835w/0YVkC99bS3k3bW
 jpWnXXb6ombDkadr6naCiMS4D5uYJp9avh5yNWmdcQsUfvhG5DloTnMl04xtLroRZvo1Az3nb
 c3KYiIRrxSI+14CmEus4QykfWQvTph6s4M5faeIp4=
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

Changes since v2:
* Restored an accidentally deleted comment.

since v1:
* Added some comments about interrupts.

 init/main.c        | 2 +-
 lib/debugobjects.c | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

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
index 70935ed91125..eab7727b46ed 100644
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
@@ -1158,7 +1157,6 @@ static int __init debug_objects_replace_static_objects(void)
 			cnt++;
 		}
 	}
-	local_irq_enable();
 
 	pr_debug("%d of %d active objects replaced\n",
 		 cnt, obj_pool_used);
-- 
2.17.2 (Apple Git-113)

