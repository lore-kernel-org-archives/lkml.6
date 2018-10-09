Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DCCECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F241214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CrBrX09d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F241214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeJIXm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:42:57 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40896 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeJIXmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:42:55 -0400
Received: by mail-qt1-f195.google.com with SMTP id b4-v6so2289973qtc.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GTTrzFlD4e7MPFOzmpkTKpYtaYABvBsIdVkj6rIH/N0=;
        b=CrBrX09d4RQMnev9V72y7Y8ckuVLxIQQRvmb32iIlBd9euLYoPsc6uXhRPdKBk4x0C
         ExY4Z+FdNTvTHFUMi1UIqc9ganifwNfL799HHdzTmgxEvXOR9Ly4C3in0znoocJHGJ6F
         0+CoOOFFPvu2Fl6OEK642/Vl4vp1AjF1eLmuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GTTrzFlD4e7MPFOzmpkTKpYtaYABvBsIdVkj6rIH/N0=;
        b=DOJdOS49w/ZyoKUXCkhDJRJG5jIo7u+sio++lbBgMoDfxz20zFlm4ZTTIwse0zLFWG
         Sg57coP3VdgZUDp8kj1Z0MLekpW4MFXULeKpwBTg6T66h6fkcwnhicRKFn8Nc2Zo5e43
         PSypF7o6YL04B9sfTniaL92JtqB17squAfBbQwPJSlikDyppbmllTpDykGTprBQMZm7M
         PWHO6tQkbnqSLL+j/jraQEz8+aR0Ujz+lez3qMiSWq0qls4afv0CYuks9BNh1WpPpfvO
         VLvnTwyPhnbt2N3DahlXTXtDNjRmWwcfPn/NlXyaZxjOTwLM73ttoJf46qG+jiW0ilB5
         1bLQ==
X-Gm-Message-State: ABuFfojPrw4bSmVt21GREezoUVo2UxmXpgsVqUeFh1ZEcQ28R8EX3a0U
        +YTmke8/oVlM+Y3KgJqgNKtI0upWcwVtBg==
X-Google-Smtp-Source: ACcGV62p8nFx6rJ2DinZIlQigg8p/x1aMuwdGxqd4FyRQKrypDoHCUDSRbKvb03INEv7pfUnUpEirA==
X-Received: by 2002:a0c:9466:: with SMTP id i35mr2311932qvi.231.1539102310308;
        Tue, 09 Oct 2018 09:25:10 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id o7-v6sm10441169qkc.67.2018.10.09.09.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 09:25:09 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org
Subject: [RFC PATCH 3/7] sched: Add infrastructure to store and update instantaneous thermal pressure
Date:   Tue,  9 Oct 2018 12:24:58 -0400
Message-Id: <1539102302-9057-4-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal.c and thermal.h files that provides interface
APIs to initialize, update/average, track, accumulate and decay
thermal pressure per cpu basis. A per cpu structure max_capacity_info is
introduced to keep track of instantaneous per cpu thermal pressure.
Thermal pressure the delta between max_capacity and cap_capacity.
API update_periodic_maxcap is called for periodic accumulate and decay
of the thermal pressure. It is to to be called from a periodic tick
function. The API calculates the delta between max_capacity and
cap_capacity and passes on the delta to update_thermal_avg to do the
necessary accumulate, decay and average. update_maxcap_capacity is for
the system to update the thermal pressure by updating cap_capacity.
Considering, update_periodic_maxcap reads cap_capacity and
update_maxcap_capacity writes into cap_capacity, one can argue for
some sort of locking mechanism to avoid a stale value.
But considering update_periodic_maxcap can be called from a system
critical path like scheduler tick function, a locking mechanism is not
ideal. This means that possibly for 1 tick period the value used to
calculate average thermal pressure for a cpu can be stale.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 include/linux/sched.h  | 14 +++++++++++
 kernel/sched/Makefile  |  2 +-
 kernel/sched/thermal.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/thermal.h | 13 ++++++++++
 4 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 kernel/sched/thermal.c
 create mode 100644 kernel/sched/thermal.h

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 977cb57..931b76d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1891,3 +1891,17 @@ static inline void rseq_syscall(struct pt_regs *regs)
 #endif
 
 #endif
+
+#ifdef CONFIG_SMP
+void update_maxcap_capacity(int cpu, u64 capacity);
+
+void populate_max_capacity_info(void);
+#else
+static inline void update_maxcap_capacity(int cpu, u64 capacity)
+{
+}
+
+static inline void populate_max_capacity_info(void)
+{
+}
+#endif
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 7fe1834..232a0cf 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -20,7 +20,7 @@ obj-y += core.o loadavg.o clock.o cputime.o
 obj-y += idle.o fair.o rt.o deadline.o
 obj-y += wait.o wait_bit.o swait.o completion.o
 
-obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o
+obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o thermal.o
 obj-$(CONFIG_SCHED_AUTOGROUP) += autogroup.o
 obj-$(CONFIG_SCHEDSTATS) += stats.o
 obj-$(CONFIG_SCHED_DEBUG) += debug.o
diff --git a/kernel/sched/thermal.c b/kernel/sched/thermal.c
new file mode 100644
index 0000000..dd8300d
--- /dev/null
+++ b/kernel/sched/thermal.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sceduler Thermal Interactions
+ *
+ *  Copyright (C) 2018 Linaro, Inc., Thara Gopinath <thara.gopinath@linaro.org>
+ */
+
+#include <linux/sched.h>
+#include "sched.h"
+#include "pelt.h"
+#include "thermal.h"
+
+struct max_capacity_info {
+	unsigned long max_capacity;
+	unsigned long cap_capacity;
+};
+
+static DEFINE_PER_CPU(struct max_capacity_info, max_cap);
+
+void update_maxcap_capacity(int cpu, u64 capacity)
+{
+	struct max_capacity_info *__max_cap;
+	u64 __capacity;
+
+	__max_cap = (&per_cpu(max_cap, cpu));
+	if (!__max_cap) {
+		pr_err("no max_capacity_info structure for cpu %d\n", cpu);
+		return;
+	}
+
+	/* Normalize the capacity */
+	__capacity = (capacity * arch_scale_cpu_capacity(NULL, cpu)) >>
+							SCHED_CAPACITY_SHIFT;
+	pr_debug("updating cpu%d capped capacity from %ld to %ld\n", cpu, __max_cap->cap_capacity, __capacity);
+
+	__max_cap->cap_capacity = __capacity;
+}
+
+void populate_max_capacity_info(void)
+{
+	struct max_capacity_info *__max_cap;
+	u64 capacity;
+	int cpu;
+
+
+	for_each_possible_cpu(cpu) {
+		__max_cap = (&per_cpu(max_cap, cpu));
+		if (!__max_cap)
+			continue;
+		capacity = arch_scale_cpu_capacity(NULL, cpu);
+		__max_cap->max_capacity = __max_cap->cap_capacity = capacity;
+		pr_debug("cpu %d max capacity set to %ld\n", cpu, __max_cap->max_capacity);
+	}
+}
+
+void update_periodic_maxcap(struct rq *rq)
+{
+	struct max_capacity_info *__max_cap = (&per_cpu(max_cap, cpu_of(rq)));
+	unsigned long delta;
+
+	if (!__max_cap)
+		return;
+
+	delta = __max_cap->max_capacity - __max_cap->cap_capacity;
+	update_thermal_avg(rq_clock_task(rq), rq, delta);
+}
diff --git a/kernel/sched/thermal.h b/kernel/sched/thermal.h
new file mode 100644
index 0000000..20a0270
--- /dev/null
+++ b/kernel/sched/thermal.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Scheduler thermal interaction internal methods.
+ */
+
+#ifdef CONFIG_SMP
+void update_periodic_maxcap(struct rq *rq);
+
+#else
+static inline void update_periodic_maxcap(struct rq *rq)
+{
+}
+#endif
-- 
2.1.4

