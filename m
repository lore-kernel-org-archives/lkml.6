Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2C4C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D78C20894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="WXvGmsNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D78C20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeH1VQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:16:07 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44419 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbeH1VQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:16:07 -0400
Received: by mail-yw1-f66.google.com with SMTP id l9-v6so876705ywc.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8QpVWc+T0o4AoowMcuXkIsCB4Tg1PG7pOnkiVXdsCB8=;
        b=WXvGmsNsQW+tu3R06QMjVFUXUSjeh4QQVywmK/96rOggdOqu0xDxk5zOr0p/7yb3Xl
         mJMhGrjs43wcQRGGuMS5Pm4GaCdPg3iCCBfORS4nupG4/X9M3STdwi64UYXAJJvaFBSh
         uxTeEO7gT84J69qhUJk1LGEH8wXj4Myh9RtFe5w3vLal/JabzwFt57Z9v/mj2wxlQVxX
         a0W52JiJ3pimWlPUk72tPMzruc47joJpk/v8u2G+mnXxGYVoZCwViiYNYpQJTrNcNMe3
         u6iInnuQLyl6Gfh6pjPY3oCfb1Ciuk81BkY+VH4PlEPxyNZSEb6kwcR5i6hIAj7Ez4kU
         jI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8QpVWc+T0o4AoowMcuXkIsCB4Tg1PG7pOnkiVXdsCB8=;
        b=ttTaVV1us0cF5/Jk7sMpw1BtfVhbGD03GMJ+bD9P+Wpjz07Ygt1DbnBLC5fHe2q8gv
         UA3A0DWK1sddeqLQ9I5svhW4R1dfN96WLxIhxH2n3kjDNKsnN16TRh+VWbKI6ox8fP75
         kFOzeeASifehQRdM22/4zeanWx21XjV5Loy22NVSFneEf+XGutjWu4FK0F/PcvEpNUee
         NJUIHjopW2m+OQtVXKETfGAUsjTw9mkBT9rf+klmZ/SGjYbz2uhoowvGY3xwA4ys4Wj9
         jughEOkxuVMyc588Z6Pffgt28LBHXGA5VnOV51Va6gGJBeoTiVkP29pJ3v7/j0uhGMep
         2pgA==
X-Gm-Message-State: APzg51CX/h0pa6WyGuZoBiwfedDDJvfZRs8t7csJg2HOcRHcce6neAV1
        +UM5PExvuYnurvH3ygSi+RibQgPu6fI=
X-Google-Smtp-Source: ANB0VdbdCfLmTatvdN7aKlDqbukasjcQeDodU0Px5oOYJjk64rf40mw7WrL+FnhFT3cadlkff9U/VQ==
X-Received: by 2002:a81:7852:: with SMTP id t79-v6mr1374450ywc.329.1535477007278;
        Tue, 28 Aug 2018 10:23:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:de86])
        by smtp.gmail.com with ESMTPSA id f5-v6sm587873ywd.53.2018.08.28.10.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 10:23:26 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 4/9] sched: loadavg: consolidate LOAD_INT, LOAD_FRAC, CALC_LOAD
Date:   Tue, 28 Aug 2018 13:22:53 -0400
Message-Id: <20180828172258.3185-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828172258.3185-1-hannes@cmpxchg.org>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several definitions of those functions/macros in places that
mess with fixed-point load averages. Provide an official version.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 .../platforms/cell/cpufreq_spudemand.c        |  2 +-
 arch/powerpc/platforms/cell/spufs/sched.c     |  9 +++-----
 arch/s390/appldata/appldata_os.c              |  4 ----
 drivers/cpuidle/governors/menu.c              |  4 ----
 fs/proc/loadavg.c                             |  3 ---
 include/linux/sched/loadavg.h                 | 21 +++++++++++++++----
 kernel/debug/kdb/kdb_main.c                   |  7 +------
 kernel/sched/loadavg.c                        | 15 -------------
 8 files changed, 22 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/platforms/cell/cpufreq_spudemand.c b/arch/powerpc/platforms/cell/cpufreq_spudemand.c
index 882944c36ef5..5d8e8b6bb1cc 100644
--- a/arch/powerpc/platforms/cell/cpufreq_spudemand.c
+++ b/arch/powerpc/platforms/cell/cpufreq_spudemand.c
@@ -49,7 +49,7 @@ static int calc_freq(struct spu_gov_info_struct *info)
 	cpu = info->policy->cpu;
 	busy_spus = atomic_read(&cbe_spu_info[cpu_to_node(cpu)].busy_spus);
 
-	CALC_LOAD(info->busy_spus, EXP, busy_spus * FIXED_1);
+	info->busy_spus = calc_load(info->busy_spus, EXP, busy_spus * FIXED_1);
 	pr_debug("cpu %d: busy_spus=%d, info->busy_spus=%ld\n",
 			cpu, busy_spus, info->busy_spus);
 
diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index c9ef3c532169..9fcccb4490b9 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -987,9 +987,9 @@ static void spu_calc_load(void)
 	unsigned long active_tasks; /* fixed-point */
 
 	active_tasks = count_active_contexts() * FIXED_1;
-	CALC_LOAD(spu_avenrun[0], EXP_1, active_tasks);
-	CALC_LOAD(spu_avenrun[1], EXP_5, active_tasks);
-	CALC_LOAD(spu_avenrun[2], EXP_15, active_tasks);
+	spu_avenrun[0] = calc_load(spu_avenrun[0], EXP_1, active_tasks);
+	spu_avenrun[1] = calc_load(spu_avenrun[1], EXP_5, active_tasks);
+	spu_avenrun[2] = calc_load(spu_avenrun[2], EXP_15, active_tasks);
 }
 
 static void spusched_wake(struct timer_list *unused)
@@ -1071,9 +1071,6 @@ void spuctx_switch_state(struct spu_context *ctx,
 	}
 }
 
-#define LOAD_INT(x) ((x) >> FSHIFT)
-#define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
-
 static int show_spu_loadavg(struct seq_file *s, void *private)
 {
 	int a, b, c;
diff --git a/arch/s390/appldata/appldata_os.c b/arch/s390/appldata/appldata_os.c
index 433a994b1a89..54f375627532 100644
--- a/arch/s390/appldata/appldata_os.c
+++ b/arch/s390/appldata/appldata_os.c
@@ -25,10 +25,6 @@
 
 #include "appldata.h"
 
-
-#define LOAD_INT(x) ((x) >> FSHIFT)
-#define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
-
 /*
  * OS data
  *
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 1aef60d160eb..e508d08b7ccb 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -131,10 +131,6 @@ struct menu_device {
 	int		interval_ptr;
 };
 
-
-#define LOAD_INT(x) ((x) >> FSHIFT)
-#define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
-
 static inline int get_loadavg(unsigned long load)
 {
 	return LOAD_INT(load) * 10 + LOAD_FRAC(load) / 10;
diff --git a/fs/proc/loadavg.c b/fs/proc/loadavg.c
index d06694757201..8468baee951d 100644
--- a/fs/proc/loadavg.c
+++ b/fs/proc/loadavg.c
@@ -10,9 +10,6 @@
 #include <linux/seqlock.h>
 #include <linux/time.h>
 
-#define LOAD_INT(x) ((x) >> FSHIFT)
-#define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
-
 static int loadavg_proc_show(struct seq_file *m, void *v)
 {
 	unsigned long avnrun[3];
diff --git a/include/linux/sched/loadavg.h b/include/linux/sched/loadavg.h
index 80bc84ba5d2a..cc9cc62bb1f8 100644
--- a/include/linux/sched/loadavg.h
+++ b/include/linux/sched/loadavg.h
@@ -22,10 +22,23 @@ extern void get_avenrun(unsigned long *loads, unsigned long offset, int shift);
 #define EXP_5		2014		/* 1/exp(5sec/5min) */
 #define EXP_15		2037		/* 1/exp(5sec/15min) */
 
-#define CALC_LOAD(load,exp,n) \
-	load *= exp; \
-	load += n*(FIXED_1-exp); \
-	load >>= FSHIFT;
+/*
+ * a1 = a0 * e + a * (1 - e)
+ */
+static inline unsigned long
+calc_load(unsigned long load, unsigned long exp, unsigned long active)
+{
+	unsigned long newload;
+
+	newload = load * exp + active * (FIXED_1 - exp);
+	if (active >= load)
+		newload += FIXED_1-1;
+
+	return newload / FIXED_1;
+}
+
+#define LOAD_INT(x) ((x) >> FSHIFT)
+#define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
 
 extern void calc_global_load(unsigned long ticks);
 
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 2ddfce8f1e8f..bb4fe4e1a601 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2556,16 +2556,11 @@ static int kdb_summary(int argc, const char **argv)
 	}
 	kdb_printf("%02ld:%02ld\n", val.uptime/(60*60), (val.uptime/60)%60);
 
-	/* lifted from fs/proc/proc_misc.c::loadavg_read_proc() */
-
-#define LOAD_INT(x) ((x) >> FSHIFT)
-#define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
 	kdb_printf("load avg   %ld.%02ld %ld.%02ld %ld.%02ld\n",
 		LOAD_INT(val.loads[0]), LOAD_FRAC(val.loads[0]),
 		LOAD_INT(val.loads[1]), LOAD_FRAC(val.loads[1]),
 		LOAD_INT(val.loads[2]), LOAD_FRAC(val.loads[2]));
-#undef LOAD_INT
-#undef LOAD_FRAC
+
 	/* Display in kilobytes */
 #define K(x) ((x) << (PAGE_SHIFT - 10))
 	kdb_printf("\nMemTotal:       %8lu kB\nMemFree:        %8lu kB\n"
diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index a171c1258109..54fbdfb2d86c 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -91,21 +91,6 @@ long calc_load_fold_active(struct rq *this_rq, long adjust)
 	return delta;
 }
 
-/*
- * a1 = a0 * e + a * (1 - e)
- */
-static unsigned long
-calc_load(unsigned long load, unsigned long exp, unsigned long active)
-{
-	unsigned long newload;
-
-	newload = load * exp + active * (FIXED_1 - exp);
-	if (active >= load)
-		newload += FIXED_1-1;
-
-	return newload / FIXED_1;
-}
-
 #ifdef CONFIG_NO_HZ_COMMON
 /*
  * Handle NO_HZ for the global load-average.
-- 
2.18.0

