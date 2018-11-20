Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD9EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 06:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E7A2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 06:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E7A2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbeKTRKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:10:44 -0500
Received: from mout.gmx.net ([212.227.17.20]:33623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728703AbeKTRKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:10:43 -0500
Received: from ovpn-120-171.rdu2.redhat.com ([98.118.28.103]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0LsPwa-1fRUCY2sLA-011xDp; Tue, 20 Nov 2018 07:42:59 +0100
From:   Qian Cai <cai@gmx.us>
To:     akpm@linux-foundation.org, tglx@linutronix.de
Cc:     longman@redhat.com, yang.shi@linux.alibaba.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
Subject: [PATCH] debugobjects: scale the static pool size
Date:   Tue, 20 Nov 2018 01:42:54 -0500
Message-Id: <20181120064254.1594-1-cai@gmx.us>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-Provags-ID: V03:K1:75QxpGNcVede9LFmD6Vsxjji8LE4fc3PUFLyCisMMEcCoP3G9n6
 uNpBfHhotmEm3w9tlgPbKc4y028C+bz8drZ+4OKtgZvNIpW896D+zXyvHBoTRVLtPqfi/EQ
 bEDJ+eLoO3oaZbKt0F2q8EvvvaU+dIaJ3if9HHX/AvoO/gamDM1gD7ZRhw0a6072Rv8JjDF
 PxHeZSb0ffvRxqflMOS6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N7NTnXKgWFA=:kSnLfqMLDHBW+OkC/t4Yx/
 053timpTz87m93gEcXlmzv0VGoyQgEd9tlmHIq0YSCjvJvorDPqSZzWm4ixXfGxQmHkKtgUZB
 FjNiDPjxAVtW4zMcwIUHA4jgEirwKWhTqYjAa8s1DA9Tqw6koK3CzHLGVCLEV9w1giBVdbWRn
 tLO+M6BUsMWlsdeD1jn2S4XDikB057ujEC4AdNvYn2BOcVbxJooojvBpT33FJL9TTt/pm2VTw
 HFg9twPkEM2XbIZghwfg+Fd8eMuDt4E5VxYhNirit6FC7uGxG8SFwL6Vmg+BQBUmrQkJpd4FD
 m6kn5e3HylhHK6f5LbI5t7yOsfIqpb6Zaaxu+ouCK91reR0uJcgEq4oBXnmqPHorluNmML5du
 nWYhpxZDh7ewfFJb6SOWM4zOKnZpZQr6YCtyC8cjtUapnpN7bqoCa+KoMv/W7EhzWTWq1s4FJ
 Ry7dCbJ6/T9f/zB4Am6LK6o38JU/XLKwqwjXJ1sCxA7G8LKvhxuQtFnNsfSRnRxIAyHJFzllj
 VPsL75gPl6tvn/DgH39W4/CHXIuFb0/ui0uYxe83vzN+usWdHtHve46P/B47Qr8DNZfhA9oaN
 o+Mxq226A6hXotSNK6gH//fGLi8BHG14hT3vORMBFjP+TH1Lauac8vJHPDka1aXiWugOWyGBp
 1BkUqu6PG8qBtOj2iJYluSNqiYRxU8Q7AascuIpgoyyAkq89oRBfS/3zjeWzBEhS05QxFcDou
 d/WMa1UxX5eq520blcNNHaPgdl9gFcatqrc3AcRTN8+4//M3a3bQFMlTU/zVc8Pw13Ay4RWYS
 DBiBpY6PU8RghJWYi3ffLFU53o1Ww8CZzWTIqSZUNrFKZ4AfC+QkYt2u7WR2FhvbwXcSZ1/pH
 5yn2W6++BSugr6Lrhc0DyEx/Ghq7XCAHH5ErpE37c=
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
 lib/debugobjects.c | 53 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 70935ed91125..372dc34206d5 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -23,7 +23,53 @@
 #define ODEBUG_HASH_BITS	14
 #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
 
+/*
+ * Some debug objects are allocated during the early boot. Enabling some
+ * options like timers or workqueue objects may increase the size required
+ * significantly with large number of CPUs. For example,
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
+ * the future.
+ */
+#if defined(CONFIG_NR_CPUS) && defined(CONFIG_DEBUG_OBJECTS_TIMERS) && \
+!defined(CONFIG_DEBUG_OBJECTS_WORK)
+#define ODEBUG_POOL_SIZE	(CONFIG_NR_CPUS * 10)
+#elif defined(CONFIG_NR_CPUS) && defined(CONFIG_DEBUG_OBJECTS_WORK)
+#define ODEBUG_POOL_SIZE	(CONFIG_NR_CPUS * 30)
+#else
 #define ODEBUG_POOL_SIZE	1024
+#endif /* CONFIG_NR_CPUS */
 #define ODEBUG_POOL_MIN_LEVEL	256
 
 #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
@@ -58,8 +104,13 @@ static int			debug_objects_fixups __read_mostly;
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
+				= 1024;
 static int			debug_objects_pool_min_level __read_mostly
 				= ODEBUG_POOL_MIN_LEVEL;
 static struct debug_obj_descr	*descr_test  __read_mostly;
-- 
2.17.2 (Apple Git-113)

