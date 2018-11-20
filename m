Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BC2C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AEF20870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AEF20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeKUKAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:00:43 -0500
Received: from mout.gmx.net ([212.227.17.20]:42345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbeKUKAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 05:00:42 -0500
Received: from ovpn-124-218.rdu2.redhat.com ([98.118.28.103]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MN604-1gN1SX2CnQ-006ftS; Wed, 21 Nov 2018 00:28:45 +0100
From:   Qian Cai <cai@gmx.us>
To:     akpm@linux-foundation.org, tglx@linutronix.de
Cc:     longman@redhat.com, yang.shi@linux.alibaba.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
Subject: [PATCH v3] debugobjects: scale the static pool size
Date:   Tue, 20 Nov 2018 18:28:10 -0500
Message-Id: <20181120232810.2503-1-cai@gmx.us>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20181120201432.2163-1-cai@gmx.us>
References: <20181120201432.2163-1-cai@gmx.us>
X-Provags-ID: V03:K1:roCpr+APyjDR7Dd8JdM1fpJsJKvpzEImZ5ueOdyLHM46BGzH478
 4Hc4mzwoT36hg18YL9pgHwDhPS5Es594km2PHRAr1pT7PMV5WYyGKDjPi7846cVfFLPQNzO
 EhabfaJpWy+30nxlUFkdRgeKSz20wWvX8FQw9vB9bQtYWquMgfY0eMHAqh7yMz5efa73PDV
 M5OOkqxa9Y8b502mKTR+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fnatsEXU0gs=:qv9L50flhCDzjI27t9RYJJ
 4QM2EDPxxCddv8g3RLWv+FRq272zg1KWkoth5k6bA25DbOVlekFXuxCyeiLguaJ2YLqJglU/u
 kqzs/rSCb0c/SQC/0UxiYYnYcvDrd1DZxAdTbPLV0vB7JXy5UwrWMjEd9rGyiVg6sFs86RvWQ
 xkzbNscSMXI3dKmbMZprqnanMzrp7fpCUr/er+04suZ5v2qbvjco/WZDqyV1iyS2ep7GKN+90
 FSPtKeI6YhH+uMHZl52WjRJYScTQda/4F4DLc+pjq5nvQuuBSdKBgpJCz+2Nz1WTS4ilP/26U
 WcC36YLeHyfj7JSvg8+ZX+ic852s+To/8i86Tt4Myh67ursAuf13j5qnJzUQysslbmE3CVXon
 ogzHWoFRZiiBY1rGeh7b4rGbjVlyFX1TwA/T2BK0ZxarIA718KV2F9NOj0W+G7F6OhTRPyRH6
 hYtq6HzeM6MbMqbFo7gOVJevjT8P3ds8Masi5mUDPNNE5L80y94ktq0NnBgXMUGOTac76gsJH
 DxKnMcx8HRdZ0RUO7vYxpt8rhOx3w5KLbNLxElBJPegxMt1A8uscPIrpRMTVkdG2pjL7QDOnd
 H5fM/5RETwx14kGKHtX427vOD1nHvLFH771UQrha+bn3Q+kbb9jegSgC12oTX5z1imy1lVqD8
 ndZlyYgY5iH8pmauTFAeutZZ5zr9k7p23YyiqH5hRwfIhRHwkiXDKQfv0oKCXWm/kOC+TPLsH
 vzbtatD455yskckKv+mLJKO4N5bA0LFmO0SgiHt491nz3dFm5oX6/2fhNJJhfkouTQyM8wj6h
 JTbmMExBVvs8HFZRW8kMinoNqWQCN0uhcjjtgSps9T0PE6V3kEMOqH9zkzDzmiqcAIEixNRvs
 4PYDFzxcVvVg6iqXoJAN0LANNxF4iglSQ1qdqx6Xg=
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
Changes since v2:
* Made the calculation easier to read suggested by longman@redhat.com.

Changes since v1:
* Removed the CONFIG_NR_CPUS check since it is always defined.
* Introduced a minimal default pool size to start with. Otherwise, the pool
  size would be too low for systems only with a small number of CPUs.
* Adjusted the scale factors according to data.

 lib/debugobjects.c | 82 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 70935ed91125..02456a1e57cb 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -23,9 +23,82 @@
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
+ *
+ * With all debug objects config options selected except the workqueue and
+ * the timers, kernel reports,
+ * 64-CPU:  ODEBUG: 4 of 4 active objects replaced
+ * 256-CPU: ODEBUG: 4 of 4 active objects replaced
+ *
+ * all the options except the workqueue:
+ * 64-CPU:  ODEBUG: 466 of 466 active objects replaced
+ * 256-CPU: ODEBUG: 1810 of 1810 active objects replaced
+ *
+ * all the options except the timers:
+ * 64-CPU:  ODEBUG: 652 of 652 active objects replaced
+ * 256-CPU: ODEBUG: 2572 of 2572 active objects replaced
+ *
+ * all the options:
+ * 64-CPU:  ODEBUG: 1114 of 1114 active objects replaced
+ * 256-CPU: ODEBUG: 4378 of 4378 active objects replaced
+ */
+#ifdef CONFIG_DEBUG_OBJECTS_WORK
+#define ODEBUG_WORK_PCPU_CNT	10
+#else
+#define ODEBUG_WORK_PCPU_CNT	0
+#endif /* CONFIG_DEBUG_OBJECTS_WORK */
+
+#ifdef CONFIG_DEBUG_OBJECTS_TIMERS
+#define ODEBUG_TIMERS_PCPU_CNT	10
+#else
+#define ODEBUG_TIMERS_PCPU_CNT	0
+#endif /* CONFIG_DEBUG_OBJECTS_TIMERS */
+
+#define ODEBUG_POOL_SIZE	(ODEBUG_DEFAULT_POOL + CONFIG_NR_CPUS * \
+(ODEBUG_TIMERS_PCPU_CNT + ODEBUG_WORK_PCPU_CNT))
+
 #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
 #define ODEBUG_CHUNK_SIZE	(1 << ODEBUG_CHUNK_SHIFT)
 #define ODEBUG_CHUNK_MASK	(~(ODEBUG_CHUNK_SIZE - 1))
@@ -58,8 +131,13 @@ static int			debug_objects_fixups __read_mostly;
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

