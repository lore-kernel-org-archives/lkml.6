Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EFFC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B321208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbfR060B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B321208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeJEQkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:40:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52665 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbeJEQkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:40:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so1242599wmw.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 02:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=t5xp1kYsNTGoSaZvBSASdjLWpns39CtUkHgdFqNw26E=;
        b=CbfR060B2H0hBFr6sqGMRnwCpapyIJEAiES7qujqckQ8kNnZe8JtKgSjvp0ry6zJAm
         J/94/CpyxAVx8up7Y8VmMB7toZggAWKKRsu8KFcKp06o56wN5t4vTBeQqkC9qo6N9Pb8
         l6NtQtCv3tmVl5bwCnsHidB6pVGiaNG6ejU7qrKZHRTOcl1WzRnhUXYal9zhAUzxTSWP
         o+wMnci0/tkR9zGwYGzT8eMVLC1p9EcRxfwIJGgEWZ880iw+3FjMphGBbW6cB5dDyVvs
         tryo3uBWZyH2gHsKntJv6KLurGEMZGN0IBsluPa0LAVC7OGVB9Dow1R30hdIAL7KRI9n
         N1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=t5xp1kYsNTGoSaZvBSASdjLWpns39CtUkHgdFqNw26E=;
        b=mGzwDGgle81C/d6uAEaRGVcvLMz6ah0/GTYvKtXxQIWHI3YYn85QePUGzbeLc6lQC2
         qjzfpCL1ADSne3Y3QaSkBqjnzUTpVXoc5vsT7Jvx1M+2JRjePeGYQKbgeNzZAhUkGdyC
         H5Nkvtswlz89TkcjK0jhH39l+K1/JvbymEQXtP77Kn0FCN2llg8OeuFhZe8WBP/TATa0
         oMjKz/+H3j/glat8lgw5aQlXoUw26EBev4xnRwFYVkOfdcNytaNDZyHmsI2rRU/yZtCH
         eSS+cYQ+9JsAA30zR0czzuLIV04YzwCpi1ir3bWHU47mpjjRTtGTd9xmiTn4rKx31JtJ
         YwTQ==
X-Gm-Message-State: ABuFfohfk1kRTOzW32ZkG1Mi1Ay5lP/pgy/2cV1zGI+1/TljTwpZs0PS
        gfVRVxiBsriZ4hHeYkWdysKkMBjk
X-Google-Smtp-Source: ACcGV63BhG48ET/EUFKlb7sICZrTr2Wh5J3Y/lxlIhJ1OcHfMhoSCHanXwbkeoFsRZBrAdy/m6YYvQ==
X-Received: by 2002:a1c:96c7:: with SMTP id y190-v6mr7548120wmd.36.1538732534383;
        Fri, 05 Oct 2018 02:42:14 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x185-v6sm725534wmg.12.2018.10.05.02.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 02:42:13 -0700 (PDT)
Date:   Fri, 5 Oct 2018 11:42:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20181005094211.GA52891@gmail.com>
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

   # HEAD: d7cbbe49a9304520181fb8c9272d1327deec8453 perf/x86/amd/uncore: Set ThreadMask and SliceMask for L3 Cache perf events

Misc fixes:

 - fix a CPU#0 hot unplug bug and a PCI enumeration bug in the x86 Intel uncore PMU driver
 - fix a CPU event enumeration bug in the x86 AMD PMU driver
 - fix a perf ring-buffer corruption bug when using tracepoints
 - fix a PMU unregister locking bug

 Thanks,

	Ingo

------------------>
Jiri Olsa (1):
      perf/ring_buffer: Prevent concurent ring buffer access

Kan Liang (1):
      perf/x86/intel/uncore: Fix PCI BDF address of M3UPI on SKX

Masayoshi Mizuma (1):
      perf/x86/intel/uncore: Use boot_cpu_data.phys_proc_id instead of hardcorded physical package ID 0

Natarajan, Janakarajan (1):
      perf/x86/amd/uncore: Set ThreadMask and SliceMask for L3 Cache perf events

Peter Zijlstra (1):
      perf/core: Fix perf_pmu_unregister() locking


 arch/x86/events/amd/uncore.c         | 10 ++++++++++
 arch/x86/events/intel/uncore_snbep.c | 14 +++++++-------
 arch/x86/include/asm/perf_event.h    |  8 ++++++++
 kernel/events/core.c                 | 11 ++++-------
 4 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 981ba5e8241b..8671de126eac 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -36,6 +36,7 @@
 
 static int num_counters_llc;
 static int num_counters_nb;
+static bool l3_mask;
 
 static HLIST_HEAD(uncore_unused_list);
 
@@ -209,6 +210,13 @@ static int amd_uncore_event_init(struct perf_event *event)
 	hwc->config = event->attr.config & AMD64_RAW_EVENT_MASK_NB;
 	hwc->idx = -1;
 
+	/*
+	 * SliceMask and ThreadMask need to be set for certain L3 events in
+	 * Family 17h. For other events, the two fields do not affect the count.
+	 */
+	if (l3_mask)
+		hwc->config |= (AMD64_L3_SLICE_MASK | AMD64_L3_THREAD_MASK);
+
 	if (event->cpu < 0)
 		return -EINVAL;
 
@@ -525,6 +533,7 @@ static int __init amd_uncore_init(void)
 		amd_llc_pmu.name	  = "amd_l3";
 		format_attr_event_df.show = &event_show_df;
 		format_attr_event_l3.show = &event_show_l3;
+		l3_mask			  = true;
 	} else {
 		num_counters_nb		  = NUM_COUNTERS_NB;
 		num_counters_llc	  = NUM_COUNTERS_L2;
@@ -532,6 +541,7 @@ static int __init amd_uncore_init(void)
 		amd_llc_pmu.name	  = "amd_l2";
 		format_attr_event_df	  = format_attr_event;
 		format_attr_event_l3	  = format_attr_event;
+		l3_mask			  = false;
 	}
 
 	amd_nb_pmu.attr_groups	= amd_uncore_attr_groups_df;
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 51d7c117e3c7..c07bee31abe8 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3061,7 +3061,7 @@ static struct event_constraint bdx_uncore_pcu_constraints[] = {
 
 void bdx_uncore_cpu_init(void)
 {
-	int pkg = topology_phys_to_logical_pkg(0);
+	int pkg = topology_phys_to_logical_pkg(boot_cpu_data.phys_proc_id);
 
 	if (bdx_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
 		bdx_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
@@ -3931,16 +3931,16 @@ static const struct pci_device_id skx_uncore_pci_ids[] = {
 		.driver_data = UNCORE_PCI_DEV_FULL_DATA(21, 5, SKX_PCI_UNCORE_M2PCIE, 3),
 	},
 	{ /* M3UPI0 Link 0 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204C),
-		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 0, SKX_PCI_UNCORE_M3UPI, 0),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204D),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 1, SKX_PCI_UNCORE_M3UPI, 0),
 	},
 	{ /* M3UPI0 Link 1 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204D),
-		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 1, SKX_PCI_UNCORE_M3UPI, 1),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204E),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 2, SKX_PCI_UNCORE_M3UPI, 1),
 	},
 	{ /* M3UPI1 Link 2 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204C),
-		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 4, SKX_PCI_UNCORE_M3UPI, 2),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204D),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 5, SKX_PCI_UNCORE_M3UPI, 2),
 	},
 	{ /* end: all zeroes */ }
 };
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 12f54082f4c8..78241b736f2a 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -46,6 +46,14 @@
 #define INTEL_ARCH_EVENT_MASK	\
 	(ARCH_PERFMON_EVENTSEL_UMASK | ARCH_PERFMON_EVENTSEL_EVENT)
 
+#define AMD64_L3_SLICE_SHIFT				48
+#define AMD64_L3_SLICE_MASK				\
+	((0xFULL) << AMD64_L3_SLICE_SHIFT)
+
+#define AMD64_L3_THREAD_SHIFT				56
+#define AMD64_L3_THREAD_MASK				\
+	((0xFFULL) << AMD64_L3_THREAD_SHIFT)
+
 #define X86_RAW_EVENT_MASK		\
 	(ARCH_PERFMON_EVENTSEL_EVENT |	\
 	 ARCH_PERFMON_EVENTSEL_UMASK |	\
diff --git a/kernel/events/core.c b/kernel/events/core.c
index dcb093e7b377..5a97f34bc14c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8314,6 +8314,8 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 			goto unlock;
 
 		list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
+			if (event->cpu != smp_processor_id())
+				continue;
 			if (event->attr.type != PERF_TYPE_TRACEPOINT)
 				continue;
 			if (event->attr.config != entry->type)
@@ -9431,9 +9433,7 @@ static void free_pmu_context(struct pmu *pmu)
 	if (pmu->task_ctx_nr > perf_invalid_context)
 		return;
 
-	mutex_lock(&pmus_lock);
 	free_percpu(pmu->pmu_cpu_context);
-	mutex_unlock(&pmus_lock);
 }
 
 /*
@@ -9689,12 +9689,8 @@ EXPORT_SYMBOL_GPL(perf_pmu_register);
 
 void perf_pmu_unregister(struct pmu *pmu)
 {
-	int remove_device;
-
 	mutex_lock(&pmus_lock);
-	remove_device = pmu_bus_running;
 	list_del_rcu(&pmu->entry);
-	mutex_unlock(&pmus_lock);
 
 	/*
 	 * We dereference the pmu list under both SRCU and regular RCU, so
@@ -9706,13 +9702,14 @@ void perf_pmu_unregister(struct pmu *pmu)
 	free_percpu(pmu->pmu_disable_count);
 	if (pmu->type >= PERF_TYPE_MAX)
 		idr_remove(&pmu_idr, pmu->type);
-	if (remove_device) {
+	if (pmu_bus_running) {
 		if (pmu->nr_addr_filters)
 			device_remove_file(pmu->dev, &dev_attr_nr_addr_filters);
 		device_del(pmu->dev);
 		put_device(pmu->dev);
 	}
 	free_pmu_context(pmu);
+	mutex_unlock(&pmus_lock);
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);
 
