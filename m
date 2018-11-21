Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7A1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 02:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D48D213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 02:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D48D213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeKUMor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 07:44:47 -0500
Received: from mout.gmx.net ([212.227.15.19]:49863 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbeKUMor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 07:44:47 -0500
Received: from ovpn-124-218.rdu2.redhat.com ([98.118.28.103]) by mail.gmx.com
 (mrgmx003 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0LmbZb-1fqmGC2rRr-00aEe2; Wed, 21 Nov 2018 03:12:16 +0100
From:   Qian Cai <cai@gmx.us>
To:     akpm@linux-foundation.org, tglx@linutronix.de
Cc:     longman@redhat.com, yang.shi@linux.alibaba.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
Subject: [PATCH v4] debugobjects: scale the static pool size
Date:   Tue, 20 Nov 2018 21:11:57 -0500
Message-Id: <20181121021157.3061-1-cai@gmx.us>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20181120232810.2503-1-cai@gmx.us>
References: <20181120232810.2503-1-cai@gmx.us>
X-Provags-ID: V03:K1:LHELuvoYZ2TrgLTOI13I0EQp94ZVQGBu/Ak0seTPX6A7TFBwEkl
 T4R92PKgbtAW7uSBzHjHbTPpyNH/nRRvctj7+GL7ezFq19l06M4uSDg1sgomhaXCyLBFmF9
 1zzLthU9iotssjFWFSLPmdL87UXCmG7YnzEx+WwpSHGeMnwahLUHc+Asy7mLAD4HlPap0CL
 EPaH18tc2yI/Lnh3RqLPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AMfjaao8D2s=:RtS+OePKKjvkCdcSyzAlDs
 SXi3rj12sg7jEeIAjHBCKZEVpeEnOK84FCKPUlGeRoNwR1dIq1xqFV/4SJILwVTz9dpqgPj0X
 n0QpmCMkiA0hqt/g+YtNHfJA69/3dhP//AbxigtNkziUSoNxXP0CvTtqLUmOvxj2Zi+sxo8hq
 GxxrsWAyWmHSE67BJZUIhhrgCQQwbqTlCLY6OI4ERGA/FDwE5WqVUa58c4S2Lc/PWuOYG9B+D
 vW6DyM/4cHn6uW4UhBXX9T6mOCf9E/Ikvj2qu8Ve56FkKh4zonqM3xmE/Hwb8hhilpSdiFSl9
 Ws4jiI8mDh+BaVlOD8KjSY6R5Vff85bxA1hgHwVcP+D65su7RrTwh3pMPS0gdR6mjlIhDFEjO
 565v8/hBABWzgt4NXoVAl0/yPohFY2Mv92xDCH3jJAWOUxgQx370Fda6jkX+AeIrJJCBCi/Yi
 Xx8Kk2x8Q3ZLSlVBLQXkOQ1iWvZYP4VnxV1hkOtB8xRdyUnJ9t8rKwchxSKgsImEo9iQDaGlS
 XD3ezc16NysxvkdUeF7HcO9fob+xpD9xkoWgp9qmO3oG7aMiEt1l0tE9OE+55CbBsG0DvmhLa
 dxnUvAb/aHyJ3VyhMO6UK9DOi5WM5JMRUI2OCSFk7H0gERMzdZEaWOkjU7BaMtENT7SLqchs/
 J8yLzj8b8KIYNnWcI0PgNcXqfsniY1wl2lMpHZk1c+SbxqW8QHanmzFM4/rGcBNqKY7ZfxEy3
 wThbNK5wc+Kc0t+VI3ZWLUFAyfD4BS+xFn2JBTbYamhJzY602f8av/1LwfM0VkXPP1bPHdjP+
 LaKfZfRMfPCELOk1ySHmtnMvsBhWI8g437kSLixnEC3+zVDHUexxj1qFFshb1C3AW4S/nS/SG
 VSss6WlRiyYnefG2bu3AlYCK84kVyDnYE71czC4qE=
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

Changes since v3:
* style fixes

Changes since v2:
* Made the calculation easier to read suggested by longman@redhat.com.

Changes since v1:
* Removed the CONFIG_NR_CPUS check since it is always defined.
* Introduced a minimal default pool size to start with. Otherwise, the pool
  size would be too low for systems only with a small number of CPUs.
* Adjusted the scale factors according to data.

 lib/debugobjects.c | 81 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 70935ed91125..140571aa483c 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -23,9 +23,81 @@
 #define ODEBUG_HASH_BITS	14
 #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
 
-#define ODEBUG_POOL_SIZE	1024
+#define ODEBUG_DEFAULT_POOL	512
 #define ODEBUG_POOL_MIN_LEVEL	256
 
+/*
+ * Some debug objects are allocated during the early boot. Enabling some options
+ * like timers or workqueue objects may increase the size required significantly
+ * with large number of CPUs. For example (as today, 20 Nov. 2018),
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
+ * Increase the number a bit more in case the implmentatins are changed in the
+ * future, as it is better to avoid OOM than spending a bit more kernel memory
+ * that will/can be freed.
+ *
+ * With all debug objects config options selected except the workqueue and the
+ * timers, kernel reports,
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
+				(ODEBUG_TIMERS_PCPU_CNT + ODEBUG_WORK_PCPU_CNT))
+
 #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
 #define ODEBUG_CHUNK_SIZE	(1 << ODEBUG_CHUNK_SHIFT)
 #define ODEBUG_CHUNK_MASK	(~(ODEBUG_CHUNK_SIZE - 1))
@@ -58,8 +130,13 @@ static int			debug_objects_fixups __read_mostly;
 static int			debug_objects_warnings __read_mostly;
 static int			debug_objects_enabled __read_mostly
 				= CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
+/*
+ * This is only used after replaced static objects, so no need to scale it to
+ * use the early boot static pool size and it has already been scaled according
+ * to actual No. CPUs in the box within debug_objects_mem_init().
+ */
 static int			debug_objects_pool_size __read_mostly
-				= ODEBUG_POOL_SIZE;
+				= ODEBUG_DEFAULT_POOL;
 static int			debug_objects_pool_min_level __read_mostly
 				= ODEBUG_POOL_MIN_LEVEL;
 static struct debug_obj_descr	*descr_test  __read_mostly;
-- 
2.17.2 (Apple Git-113)

