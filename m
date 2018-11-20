Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197C3C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B770C2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B770C2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeKUGpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:45:55 -0500
Received: from mout.gmx.net ([212.227.15.19]:60301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbeKUGpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 01:45:55 -0500
Received: from ovpn-124-218.rdu2.redhat.com ([98.118.28.103]) by mail.gmx.com
 (mrgmx003 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0Lh7PL-1fceJW38i7-00oaEV; Tue, 20 Nov 2018 21:14:38 +0100
From:   Qian Cai <cai@gmx.us>
To:     akpm@linux-foundation.org, tglx@linutronix.de
Cc:     longman@redhat.com, yang.shi@linux.alibaba.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
Subject: [PATCH v2] debugobjects: scale the static pool size
Date:   Tue, 20 Nov 2018 15:14:32 -0500
Message-Id: <20181120201432.2163-1-cai@gmx.us>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-Provags-ID: V03:K1:WkL3VU7Oioe2DgshJPRc93y/cqD0hGNQc5Dj8iB4mL/utOdCGZ5
 d0WmHwRpXc+7C34KsTv1AbgOjs/iCQu6nQ5oLNFW+DrvvVrpopPiUK85OcNVyAp4rBKWfBC
 5huLtIQw2qtXGkzUE6P+4uCuLC9oCv/YJtrVPtS05zoaDNWfAWl8LgHdgpDjxKaBAVikHvV
 02WBDDYXrUXQPaBZ3MQHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l1wLNeHu4YU=:n6cFBt0ENRoIIZu0CqFf+E
 pzyPopdqxrCAYxZdZH3YkZPxzLxsyWiEBd3zOHKJe5TDztQsqC1iucrKg4nQL4ooDJv6SkK7Q
 Km+ZPJ54/b9F5M9KNTaztAuHS1R3Si/o309pMB869NJTfojHH6PajCFrRSczXHiiSeiKsGQne
 70kThis/SzIbOOxssyHTRxFF6jNH6jSg0gyKFblhaBxg5PtZ1y9DTqeuUFPgmAyniiWVbU2OZ
 68RcOY6OPilNBkphalbX3Gtu2fmz6HP+1xFbwEVQBIX6vxvEV8WUxOgG/R6YGcucm/05ROPAF
 UtajR02kjqxPGvrg4AejJ0ZrN3bXZyXFZZYGkvNWtwvZd71sKnnNrkoc4st6+OSAizpYccej4
 2SmjVKk6O71fxQkPvBVw+KpOw/d2N4pNhHKZjK16U2Dwos2ADXzIl8qvnWpvL/6pf+MOz5I6T
 iDHYDKDgpxNVW4Yl75RvBgpnXmmyYPYfh/l9+UgiBkzQKdB4stkXYNGn2IQwVmujkOtN5Pwyk
 i/ypWEKx/cD1SO+/dmdeQslQQlNtbovyt1/R5TP4i3Apck01DXbxQAGrURwaJJzhp8NO21BVF
 ywQPCS9SvJwsu9Lfz67wmBoYjrn8YaFdXb3x4Bwz+iDaVon36ZYe/ksaNtBBuwGKjbeEXmaU2
 ORjqiX6vwojjHCyIFIzhJdIbe/KMft8b2vL8A0zmyVJ7eR1lDlYjUY6Y8sD5vKechrWNopja6
 1ezu6YRHvR13E3esKOF3vg2bPwr77W+Tot7dw6bDpq+eyH+iXk5oIUVQVIPypDHe9LgvagFgM
 7EYvaAluAbEfvADn07o1FxF/bBUCef6OKFCex6xFQPwMFZCoWhOl+ekLVUwUxP85fWF5pBu5c
 gXo4L+kvb7945I5mPJSeqPPdFygrP3ziraKZZ+Lgc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current value of the early boot static pool size is not big enough
for systems with large number of CPUs with timer or/and workqueue
objects selected. As the results, systems have 60+ CPUs with both timer
and workqueue objects enabled could trigger "ODEBUG: Out of memory.
ODEBUG disabled". Hence, fixed it by computing it according to
CONFIG_NR_CPUS and CONFIG_DEBUG_OBJECTS_* options.

Signed-off-by: Qian Cai <cai@gmx.us>
---

Changes since v1:
* Removed the CONFIG_NR_CPUS check since it is always defined.
* Introduced a minimal default pool size to start with. Otherwise, the pool
  size would be too low for systems only with a small number of CPUs.
* Adjusted the scale factors according to data.

 lib/debugobjects.c | 81 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 70935ed91125..a79f02c29617 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -23,9 +23,81 @@
 #define ODEBUG_HASH_BITS	14
 #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
 
-#define ODEBUG_POOL_SIZE	1024
+#define ODEBUG_DEFAULT_POOL	512
 #define ODEBUG_POOL_MIN_LEVEL	256
 
+/*
+ * Some debug objects are allocated during the early boot. Enabling some
+ * options like timers or workqueue objects may increase the size required
+ * significantly with large number of CPUs. For example (as today, 20 Nov.
+ * 2018),
+ *
+ * No. CPUs x 2 (worker pool) objects:
+ *
+ * start_kernel
+ *   workqueue_init_early
+ *     init_worker_pool
+ *       init_timer_key
+ *         debug_object_init
+ *
+ * No. CPUs objects (CONFIG_HIGH_RES_TIMERS):
+ *
+ * sched_init
+ *   hrtick_rq_init
+ *     hrtimer_init
+ *
+ * CONFIG_DEBUG_OBJECTS_WORK:
+ * No. CPUs x 6 (workqueue) objects:
+ *
+ * workqueue_init_early
+ *   alloc_workqueue
+ *     __alloc_workqueue_key
+ *       alloc_and_link_pwqs
+ *         init_pwq
+ *
+ * Also, plus No. CPUs objects:
+ *
+ * perf_event_init
+ *    __init_srcu_struct
+ *      init_srcu_struct_fields
+ *        init_srcu_struct_nodes
+ *          __init_work
+ *
+ * Increase the number a bit more in case the implmentatins are changed in
+ * the future, as it is better to avoid OOM than spending a bit more kernel
+ * memory that will/can be freed.
+ */
+#if defined(CONFIG_DEBUG_OBJECTS_TIMERS) && \
+!defined(CONFIG_DEBUG_OBJECTS_WORK)
+/*
+ * With all debug objects config options selected except workqueue, kernel
+ * reports,
+ * 64-CPU:  ODEBUG: 466 of 466 active objects replaced
+ * 256-CPU: ODEBUG: 1810 of 1810 active objects replaced
+ */
+#define ODEBUG_POOL_SIZE	(ODEBUG_DEFAULT_POOL + CONFIG_NR_CPUS * 10)
+
+#elif defined(CONFIG_DEBUG_OBJECTS_WORK) && \
+!defined(CONFIG_DEBUG_OBJECTS_TIMERS)
+/*
+ * all the options except the timers:
+ * 64-CPU:  ODEBUG: 652 of 652 active objects replaced
+ * 256-CPU: ODEBUG: 2572 of 2572 active objects replaced
+ */
+#define ODEBUG_POOL_SIZE	(ODEBUG_DEFAULT_POOL + CONFIG_NR_CPUS * 10)
+
+#elif defined(CONFIG_DEBUG_OBJECTS_WORK) && \
+defined(CONFIG_DEBUG_OBJECTS_TIMERS)
+/*
+ * all the options:
+ * 64-CPU:  ODEBUG: 1114 of 1114 active objects replaced
+ * 256-CPU: ODEBUG: 4378 of 4378 active objects replaced
+ */
+#define ODEBUG_POOL_SIZE	(ODEBUG_DEFAULT_POOL + CONFIG_NR_CPUS * 20)
+#else
+#define ODEBUG_POOL_SIZE	ODEBUG_DEFAULT_POOL
+#endif
+
 #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
 #define ODEBUG_CHUNK_SIZE	(1 << ODEBUG_CHUNK_SHIFT)
 #define ODEBUG_CHUNK_MASK	(~(ODEBUG_CHUNK_SIZE - 1))
@@ -58,8 +130,13 @@ static int			debug_objects_fixups __read_mostly;
 static int			debug_objects_warnings __read_mostly;
 static int			debug_objects_enabled __read_mostly
 				= CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
+/*
+ * This is only used after replaced static objects, so no need to scale it
+ * to use the early boot static pool size and it has already been scaled
+ * according to actual No. CPUs in the box within debug_objects_mem_init().
+ */
 static int			debug_objects_pool_size __read_mostly
-				= ODEBUG_POOL_SIZE;
+				= ODEBUG_DEFAULT_POOL;
 static int			debug_objects_pool_min_level __read_mostly
 				= ODEBUG_POOL_MIN_LEVEL;
 static struct debug_obj_descr	*descr_test  __read_mostly;
-- 
2.17.2 (Apple Git-113)

