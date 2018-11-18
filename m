Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9820AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 08:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B2A2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 08:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B2A2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeKRSmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 13:42:53 -0500
Received: from mout.gmx.net ([212.227.15.19]:41205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbeKRSmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 13:42:53 -0500
Received: from ovpn-120-93.rdu2.redhat.com ([98.118.28.103]) by mail.gmx.com
 (mrgmx001 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0LoEwL-1fmmkf0XKz-00gJCM; Sun, 18 Nov 2018 09:23:00 +0100
From:   Qian Cai <cai@gmx.us>
To:     akpm@linux-foundation.org
Cc:     tglx@linutronix.de, longman@redhat.com, yang.shi@linux.alibaba.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
Subject: [PATCH] debugobjects: add a new Kconfig for POOL_SIZE
Date:   Sun, 18 Nov 2018 03:22:55 -0500
Message-Id: <20181118082255.1275-1-cai@gmx.us>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-Provags-ID: V03:K1:entIzbCJKtipCqSp76MCp+ZkDu1knC4YDwqk7U4AG7zt/gDs6jE
 /Pe8uBXZaBVRCiRTNgA0WGFmolvvIIP6g2Ce9ES3if2z3JUht+L7chE6w1HAp3U69bIj+eC
 4IP+d/sxfYvsGvKomueON5YuFyHPowqOCtta5cxI8i+YMH0xiRBFK/2j08rkRfFCqvkVZVM
 8vo1ZGSEj8Xg2Vs27RAkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0KqrT+p+W1c=:Z5tXvzdtNHQqizttUv0Mus
 CM7qWgQwMqIFFebo9pknDStEh7AQLJH6zoT0CwwtrSmv6um4NTf6zDBSb8m9s0nYQQE4vrMi6
 XVuIS1/WynzbtwflGu+Tsub0m2KRAlecXRXKo9GNhZ9a4ZsFxeYFU2Xvb8utGI8AUnm3qc1eZ
 od6ZKtM7eGdEljgs4yMhnxbWGiNEaYPtCsakXC0uTHIIVhrwBt6eS7jJb/v7b6gpBX8HeXFj7
 UCrLJq1q+R1R32ohrmAIJO3OfGVcX5IDaevaIkskGqga4Iz564kwGX7B5iVcM/Elpz6Voi4HQ
 lJG3bwQ6EZewmteMp1+6tgq/Rd6ESI6ATNksbZ5qBvjumu0R+2RLqUb/kEEFAqzl3zpOhq5aL
 ug1uolj7IlG7q6zeuyy0H2QMOxEBcCth8t7F5djl7QjmRyHQE2LLxwG8jNw9yYWgdLzqe70l2
 JVlY3zygHqfGP5ndGdF8/5Q6iJmN8rAbYMZkoJrEmFxQLnqXWDwsFKecb05x+hSBUH4sVmV5n
 m72MCslSQmi9vSqR/9nnXdDCM1so1ux0TFzesDVe0XBkl9es+poFjk/rYQH7B3wyzt+JQtrMY
 3GkivT3pL9uxln1+33b63dleuFyIjXiurg9WBwC5nkmmaVU3odAM2yBkr/C5iNM0YbfQcbtxY
 KRTnxeBplNwtJawR+hoaVQXqwimPPgB2tqtyQF6tnQ6G1Vib24MxllfU+3Qp8hwbdXAxwr7W7
 dAuU5coabkRvfdvlGt9QtIZD7JEi6RDwLQc3de7u+4VVVV6imgGLS6Sb1+5gV62R/7s0ei8F5
 JTA3aM3nDeLeY46bcff4drp2v3cVq41Iy+Bfox96qhtj6ql2pyiU8K4ivM5CazJLLlGDplV5V
 jE98DjXt2bUsfLbvFy5PqA1e3D4q0/sH3DwSrc+f8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current value of ODEBUG_POOL_SIZE is not big enough for large memory
systems with timer or/and workqueue objects because during the early
boot, timer objects needs at least the size equals to

No. CPUs x 2 (worker pool)

start_kernel
  workqueue_init_early
    init_worker_pool
      init_timer_key
        debug_object_init

puls, No. CPUs

start_kernel
  sched_init
    hrtimer_init
     debug_object_init

Then, workqueue objects requires even more,

No. CPUs x 2 (worker pool) x 6 (workqueue)

start_kernel
  workqueue_init_early
    __alloc_workqueue_key
      alloc_workqueue
        init_pwq
          debug_object_init

plus, No, CPUs x 2 (worker pool)

start_kernel
  perf_event_init
    __init_srcu_struct
      init_srcu_struct_fields
        __init_work
          debug_object_init

As the results, systems have 60+ CPUs with both timer and workqueue
objects enabled could trigger "ODEBUG: Out of memory. ODEBUG disabled".

Hence, add a new Kconfig option so users could adjust ODEBUG_POOL_SIZE
accordingly if either timer or workqueue objects are selected.

Signed-off-by: Qian Cai <cai@gmx.us>
---
 lib/Kconfig.debug  | 12 ++++++++++++
 lib/debugobjects.c |  7 ++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af29b8224fd..a4af837649df 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -449,6 +449,18 @@ config DEBUG_OBJECTS
 	  kernel to track the life time of various objects and validate
 	  the operations on those objects.
 
+config DEBUG_OBJECTS_POOL_SIZE
+	int "Debug objects pool size"
+	depends on DEBUG_OBJECTS_TIMERS || DEBUG_OBJECTS_WORK
+	default 1024
+	help
+	  Some debug objects are allocated during the early boot. Enable some
+	  config options may requires the sizes below,
+
+	  DEBUG_OBJECTS_TIMERS: No. CPUs x 2 (worker pool) + No. CPUs (hrtimer)
+	  DEBUG_OBJECTS_WORK:   No. CPUs x 2 (worker pool) x 6 (workqueue) +
+				No. CPUs x 2 (worker pool)
+
 config DEBUG_OBJECTS_SELFTEST
 	bool "Debug objects selftest"
 	depends on DEBUG_OBJECTS
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 70935ed91125..eb8158538993 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -23,7 +23,12 @@
 #define ODEBUG_HASH_BITS	14
 #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
 
-#define ODEBUG_POOL_SIZE	1024
+#ifdef CONFIG_DEBUG_OBJECTS_POOL_SIZE
+#define ODEBUG_POOL_SIZE	CONFIG_DEBUG_OBJECTS_POOL_SIZE
+#else
+#define ODEBUG_POOL_SIZE        1024
+#endif
+
 #define ODEBUG_POOL_MIN_LEVEL	256
 
 #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
-- 
2.17.2 (Apple Git-113)

