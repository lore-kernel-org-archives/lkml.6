Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946D6C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 10:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A60218AD
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 10:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550398259;
	bh=uhUHU6wtcB3CKsC/RfyxJ0VuH0RvUzOod5LmV4bJfHM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=r64+JmyIzRp0DQNCn9FOYpYRyhMyRv0TMpUNl5AoVku49lM+UccSitlHGXUjWeFvY
	 IJWVddF1jGFte58gVglnEtRbK7EbxiJ0aVIHhFqeNn9GmGVoQHsqvvf+S+Tq2Yokhe
	 16itnghzNailgGdKBE+pESryBu8eDMs3KbXcmQjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfBQKK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 05:10:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50754 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 05:10:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id x7so14278959wmj.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 02:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GKseJT9+/0hfPM0T2qCDBY9Q8xklGgijCcolYSOx0SA=;
        b=HMcpSFemAc0SdpsLhSZ65vkCrt1LsgSa463MOVx+jCxHr735YEeZDqjl1ViuEhXNtY
         Z8+e9uWh5AHUEGEOCSMvLRW5Scy/9FST3TDV31pWXLr3evvhUCLTQQhMeuIq6Rd/L5Xm
         ju+RkX6+x6SdK3vevSQCR95nURcDso8e3apr9cuMsfiwJPb2GNimTHGwHypKVIaI/eF2
         zjL1Sos6/XZqitrYTVNUjUBrRpwPSTMeck1qQW+4tvi+h6vtKzHDRLcWZvnbUm7Cuqal
         9KhwOv0JoaRKSn2ThVAmrlJgiq90ybKyP7jrWqO7CtpHGM+k1YTBxrZ61EMxAupBYnxV
         cqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=GKseJT9+/0hfPM0T2qCDBY9Q8xklGgijCcolYSOx0SA=;
        b=O3/CU46kZ0kcjM7ziRia4ZQ2ymNwdLUHL5O+9ufzb/2mXL8AvpvSgmaebqboVVh24K
         s7FKRzRq+tYYA9vGKs/Jao6UuCoGkd2vgIYAZIB3SBl/Uz2luq62rkj4WRYjvw1lULaN
         Q0sK3Ba+4+QBeGj/0kI5NdokNaCYI1u4igGimifNdIBzpgEieBckf7kbGOtfUrpvqI23
         Tldrr04g2WUziX4kF1timFA5vg6ujk7dUBhyH6m7Vze+oFZl4f1wQtH/sbdHUntqNQTv
         EfyVGjjR1NVqE6DNhYZTxc8ebS932im+h+pDACzHVyRNKG/0u0oo/cTS5FBJBq2TOfWJ
         gj8w==
X-Gm-Message-State: AHQUAuY3grJbfNRDDzN8xxiH3HndxZxHaUw/pUDHwyk9s9UIjNS0mxYN
        w3tLWfGjHuwERIuSSTQ0mTc=
X-Google-Smtp-Source: AHgI3IYnbl1EO+lRlA6SdQcoJRRkExdG8uBY8qhQrfnAvApMBFDqJggRflZsAn8/o3ZqjgpAoNri1A==
X-Received: by 2002:a1c:4301:: with SMTP id q1mr12135060wma.44.1550398254486;
        Sun, 17 Feb 2019 02:10:54 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z6sm1151051wml.40.2019.02.17.02.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 02:10:53 -0800 (PST)
Date:   Sun, 17 Feb 2019 11:10:51 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20190217101051.GA116360@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 528871b456026e6127d95b1b2bd8e3a003dc1614 perf/core: Fix impossible ring-buffer sizes warning

Two fixes on the kernel side: fix an over-eager condition that failed 
larger perf ring-buffer sizes, plus fix crashes in the Intel BTS code for 
a corner case, found by fuzzing.

 Thanks,

	Ingo

------------------>
Ingo Molnar (1):
      perf/core: Fix impossible ring-buffer sizes warning

Jiri Olsa (1):
      perf/x86: Add check_period PMU callback


 arch/x86/events/core.c       | 14 ++++++++++++++
 arch/x86/events/intel/core.c |  9 +++++++++
 arch/x86/events/perf_event.h | 16 ++++++++++++++--
 include/linux/perf_event.h   |  5 +++++
 kernel/events/core.c         | 16 ++++++++++++++++
 kernel/events/ring_buffer.c  |  2 +-
 6 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 374a19712e20..b684f0294f35 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2278,6 +2278,19 @@ void perf_check_microcode(void)
 		x86_pmu.check_microcode();
 }
 
+static int x86_pmu_check_period(struct perf_event *event, u64 value)
+{
+	if (x86_pmu.check_period && x86_pmu.check_period(event, value))
+		return -EINVAL;
+
+	if (value && x86_pmu.limit_period) {
+		if (x86_pmu.limit_period(event, value) > value)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct pmu pmu = {
 	.pmu_enable		= x86_pmu_enable,
 	.pmu_disable		= x86_pmu_disable,
@@ -2302,6 +2315,7 @@ static struct pmu pmu = {
 	.event_idx		= x86_pmu_event_idx,
 	.sched_task		= x86_pmu_sched_task,
 	.task_ctx_size          = sizeof(struct x86_perf_task_context),
+	.check_period		= x86_pmu_check_period,
 };
 
 void arch_perf_update_userpage(struct perf_event *event,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index daafb893449b..730978dff63f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3587,6 +3587,11 @@ static void intel_pmu_sched_task(struct perf_event_context *ctx,
 	intel_pmu_lbr_sched_task(ctx, sched_in);
 }
 
+static int intel_pmu_check_period(struct perf_event *event, u64 value)
+{
+	return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
+}
+
 PMU_FORMAT_ATTR(offcore_rsp, "config1:0-63");
 
 PMU_FORMAT_ATTR(ldlat, "config1:0-15");
@@ -3667,6 +3672,8 @@ static __initconst const struct x86_pmu core_pmu = {
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
 	.cpu_dead		= intel_pmu_cpu_dead,
+
+	.check_period		= intel_pmu_check_period,
 };
 
 static struct attribute *intel_pmu_attrs[];
@@ -3711,6 +3718,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
+
+	.check_period		= intel_pmu_check_period,
 };
 
 static __init void intel_clovertown_quirk(void)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 78d7b7031bfc..d46fd6754d92 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -646,6 +646,11 @@ struct x86_pmu {
 	 * Intel host/guest support (KVM)
 	 */
 	struct perf_guest_switch_msr *(*guest_get_msrs)(int *nr);
+
+	/*
+	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
+	 */
+	int (*check_period) (struct perf_event *event, u64 period);
 };
 
 struct x86_perf_task_context {
@@ -857,7 +862,7 @@ static inline int amd_pmu_init(void)
 
 #ifdef CONFIG_CPU_SUP_INTEL
 
-static inline bool intel_pmu_has_bts(struct perf_event *event)
+static inline bool intel_pmu_has_bts_period(struct perf_event *event, u64 period)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned int hw_event, bts_event;
@@ -868,7 +873,14 @@ static inline bool intel_pmu_has_bts(struct perf_event *event)
 	hw_event = hwc->config & INTEL_ARCH_EVENT_MASK;
 	bts_event = x86_pmu.event_map(PERF_COUNT_HW_BRANCH_INSTRUCTIONS);
 
-	return hw_event == bts_event && hwc->sample_period == 1;
+	return hw_event == bts_event && period == 1;
+}
+
+static inline bool intel_pmu_has_bts(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	return intel_pmu_has_bts_period(event, hwc->sample_period);
 }
 
 int intel_pmu_save_and_restart(struct perf_event *event);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1d5c551a5add..e1a051724f7e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -447,6 +447,11 @@ struct pmu {
 	 * Filter events for PMU-specific reasons.
 	 */
 	int (*filter_match)		(struct perf_event *event); /* optional */
+
+	/*
+	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
+	 */
+	int (*check_period)		(struct perf_event *event, u64 value); /* optional */
 };
 
 enum perf_addr_filter_action_t {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e5ede6918050..26d6edab051a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4963,6 +4963,11 @@ static void __perf_event_period(struct perf_event *event,
 	}
 }
 
+static int perf_event_check_period(struct perf_event *event, u64 value)
+{
+	return event->pmu->check_period(event, value);
+}
+
 static int perf_event_period(struct perf_event *event, u64 __user *arg)
 {
 	u64 value;
@@ -4979,6 +4984,9 @@ static int perf_event_period(struct perf_event *event, u64 __user *arg)
 	if (event->attr.freq && value > sysctl_perf_event_sample_rate)
 		return -EINVAL;
 
+	if (perf_event_check_period(event, value))
+		return -EINVAL;
+
 	event_function_call(event, __perf_event_period, &value);
 
 	return 0;
@@ -9391,6 +9399,11 @@ static int perf_pmu_nop_int(struct pmu *pmu)
 	return 0;
 }
 
+static int perf_event_nop_int(struct perf_event *event, u64 value)
+{
+	return 0;
+}
+
 static DEFINE_PER_CPU(unsigned int, nop_txn_flags);
 
 static void perf_pmu_start_txn(struct pmu *pmu, unsigned int flags)
@@ -9691,6 +9704,9 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		pmu->pmu_disable = perf_pmu_nop_void;
 	}
 
+	if (!pmu->check_period)
+		pmu->check_period = perf_event_nop_int;
+
 	if (!pmu->event_idx)
 		pmu->event_idx = perf_event_idx_default;
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 309ef5a64af5..5ab4fe3b1dcc 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -734,7 +734,7 @@ struct ring_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 	size = sizeof(struct ring_buffer);
 	size += nr_pages * sizeof(void *);
 
-	if (order_base_2(size) >= MAX_ORDER)
+	if (order_base_2(size) >= PAGE_SHIFT+MAX_ORDER)
 		goto fail;
 
 	rb = kzalloc(size, GFP_KERNEL);
