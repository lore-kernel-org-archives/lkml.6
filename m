Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A39BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4902B2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4902B2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeKSIa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 03:30:59 -0500
Received: from mout.gmx.net ([212.227.15.18]:42969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbeKSIa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 03:30:59 -0500
Received: from ovpn-121-0.rdu2.redhat.com ([98.118.28.103]) by mail.gmx.com
 (mrgmx002 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0Lz3rc-1fKHiy1GqW-014Cp0; Sun, 18 Nov 2018 23:09:12 +0100
From:   Qian Cai <cai@gmx.us>
To:     akpm@linux-foundation.org, tglx@linutronix.de
Cc:     longman@redhat.com, yang.shi@linux.alibaba.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
Subject: [PATCH v2] debugobjects: add a new Kconfig for POOL_SIZE
Date:   Sun, 18 Nov 2018 17:08:51 -0500
Message-Id: <20181118220851.942-1-cai@gmx.us>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20181118082255.1275-1-cai@gmx.us>
References: <20181118082255.1275-1-cai@gmx.us>
X-Provags-ID: V03:K1:IEsNTb/xqh9o8ATRLpeMLSaw8nlAnrekxhbRtclqqi0U0T7nqEg
 JSVXex/RpAkzs0hEWPCY8BNItTTgxGoiA6RZiWKoic7tUF+gNANn1BTfALCbTHNuh1m40/d
 zR47J+JT27z7yWFbRe3K8h4f/sZ/YXEDvtdNtZtJQYANlhvKxMns/rf1ny/JHhHyIUVmbhO
 LS2R1dV6zhQ/Mlzrz8Q0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P/vNoDWlh0c=:qt2S8Viq21dV8K2Q4SMemp
 JqJEb1e9kWym0boJ8wVlkEaxi8W+Vz6dm8lYnK81Xwnvq5kd4VUb8+b7ByrN0BI9juPP/2EKB
 slJ6AG6/xPW+SgB8GNCuQduqZwmr19gsJk2z4gK3kvf5KCdzFLbWpn3CHgRdBYjoEBDz7TQtP
 oKsirzbd72uxOnsQ80SyPMjC1fyq9sNMu8djHQDovxb+MwcUL+Xtb7T41FMNMXVBlTTAEP4fP
 CjW1bkYMk/2SfgiKevPmlYzFcSqq7OQPXhKoov/U0q3uQoQsZVgVHnjhpRX6Di43tKL+K8xKG
 ZIBjuEpQfjELtD6YOjanREJHV0je5zKLbpcGCCb/0Bu8xYPsu0U+sSGKcbG63ynMH2ZQ91SVK
 /SUG5qT+C73Wtp3fbOpZ9loZnX7xF+t9xNitSjlmAq6nw+jjNIKX4PSmYg2vEQofHwXlOp1eE
 NuXi6PjOrrCLHPO0l0UwoMAEHlZZo8CosmONv/sSEwPgnFVWJFFgkHMoIYx+vRCa0boko8H0w
 D1p3wLovdVFNqoP0eGRdduExdE4WtfwIU2Otw7QdnC1PF9jxnC2hCPvzsnjDrOzhon4ObIeoO
 Ya6us4Nc0yifd92k2M0FpRzjqAoG9uRzJlwhQ589+o4R/mGlqPvsZ/9ntBn1brGnNx5U9gv7K
 xbtnH30H4zAAQe6MVJECMO4QC/GIP1uRMuX9bkM+Roxa0tfRcMclhQp7RKLz0rGpyHlJXgLOZ
 70Vl4GgLew90lbESsdUgX9LnE5HGnILl7zPdK9eWVRkJGoGI5OHwgBmA19/HfprSI+MBZRnzQ
 MJrryS6LWbCrbRYWw9oSBEQupJTLQ28UrRPJB0avQk1JxvczgFGmvfLy2L2BhHFZ5onWUHmMt
 zLDWrAeWwDc+aPKZZQu+do+r3GZA0mVbEDlNZaABQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current value of ODEBUG_POOL_SIZE is not big enough for systems with
large number of CPUs with timer or/and workqueue objects because during
the early boot, timer objects needs the size equals to

No. CPUs x 2 (worker pool)

start_kernel
  workqueue_init_early
    init_worker_pool
      init_timer_key
        debug_object_init

puls, No. CPUs (if have the hrtimer option)

start_kernel
  sched_init
    hrtick_rq_init
      hrtimer_init
        debug_object_init

Then, workqueue objects requires even more,

No. CPUs x 6 (workqueue)

start_kernel
  workqueue_init_early
    alloc_workqueue
      __alloc_workqueue_key
        alloc_and_link_pwqs
          init_pwq
            debug_object_init

plus, No, CPUs x 2 (worker pool) (if have the perf option)

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

Changes since v1:
* Fixed a few typos.
* Added missing call stacks.
* Removed implementation details from the Kconfig help.

 lib/Kconfig.debug  | 11 +++++++++++
 lib/debugobjects.c |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af29b8224fd..0749dc627eb5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -449,6 +449,17 @@ config DEBUG_OBJECTS
 	  kernel to track the life time of various objects and validate
 	  the operations on those objects.
 
+config DEBUG_OBJECTS_POOL_SIZE
+	int "Debug objects pool size"
+	depends on DEBUG_OBJECTS_TIMERS || DEBUG_OBJECTS_WORK
+	default 1024
+	help
+	  Some debug objects are allocated during the early boot. Enabling some
+	  options below like timers or workqueue objects may increase the size
+	  required significantly with large number of CPUs. If the kernel
+	  reports "ODEBUG: Out of memory. ODEBUG disabled", please increase
+	  this value.
+
 config DEBUG_OBJECTS_SELFTEST
 	bool "Debug objects selftest"
 	depends on DEBUG_OBJECTS
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 70935ed91125..b0e8e90f6ad1 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -23,7 +23,11 @@
 #define ODEBUG_HASH_BITS	14
 #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
 
+#ifdef CONFIG_DEBUG_OBJECTS_POOL_SIZE
+#define ODEBUG_POOL_SIZE	CONFIG_DEBUG_OBJECTS_POOL_SIZE
+#else
 #define ODEBUG_POOL_SIZE	1024
+#endif
 #define ODEBUG_POOL_MIN_LEVEL	256
 
 #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
-- 
2.17.2 (Apple Git-113)

