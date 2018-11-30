Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68B3C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8212146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4mU5TU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8212146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeK3Rd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:33:26 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51976 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeK3Rd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:33:26 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so4579360wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 22:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BuIYsPC7Rf2LxpbkR7Q5FGIlgGl3uiRfCTfA8hCgWH8=;
        b=c4mU5TU5ExMaB2PsdcxABNt1gmMjdGs/WGNo+3/o9mL5wfiz9syKpvIVm6MRyjx1WL
         Y6scyHNFJ5T3p0/SkswLqAGAT274bqmwLuxli9Uiymza2H8LQudqnfMdg/89mWr3t9gZ
         z8m0CLMB3OPRV8zjs5jK9sNtkCAmuvc0hf9wLVe2y2B1wmjXFb7X8f7Wc+EgroUrNi4C
         501HhQhc8NYii/AV+cA5cPy8WgX7k/HqGyHE0iWo8K41CORCjQu3Y1IX+7v16XG3gnhM
         8pI3QP/Re66k2XQc7Pq2Ckr+Dl4qN62n8rDsG5ctoT8Lnjr5+oToRn2ohiyAKtqfzyDL
         hVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=BuIYsPC7Rf2LxpbkR7Q5FGIlgGl3uiRfCTfA8hCgWH8=;
        b=XF+mdNk1JhFGkhjLe1nCfU04kiD3Alqv5JkzRwpxIu+wFtg2HJnBh5X2clMZTT5nxg
         zm0D3q2N+gJT96IOOHHWwPQe25BC9Ge580O+h7XQUprbOEgWkJS24+l/LLq6U6iaEA62
         XQZ36PG2xdPnomsPiXHupYYKjBYcNJPYIe2afUHtf6MD0YUbZsnyPHndEpLh6Zw6OMZ/
         PIUG4ulmnh1pNISRnyNQOGX++SZObaA4zg8bB35abx55nZQmhVAGMsAY9zWxHUiOLVOQ
         t1H7QS9VdNvkUtlXRoaj887XlubICeP7h4Nyixc+F/hVe6OnUKJN5lJVWNERrPdxQEyN
         WDUw==
X-Gm-Message-State: AA+aEWbGFupU6YVjO3OTgiqTr5ReEGpQ/eDnm/jg37lGWCqjpzb58T3r
        uYWxa4LNVFwY8kgBl8fhKJk=
X-Google-Smtp-Source: AFSGD/Vg/eEQmPTGxUMsF/Nvh4+p4p0JsNHftOTweAknRx4eZ5dVFr8rQy0s1PnTzWKsj/4GL6rM0A==
X-Received: by 2002:a1c:a755:: with SMTP id q82mr4459306wme.6.1543559110593;
        Thu, 29 Nov 2018 22:25:10 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l2sm7826929wma.33.2018.11.29.22.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 22:25:10 -0800 (PST)
Date:   Fri, 30 Nov 2018 07:25:07 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20181130062507.GA77228@gmail.com>
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

   # HEAD: 09d3f015d1e1b4fee7e9bbdcf54201d239393391 uprobes: Fix handle_swbp() vs. unregister() + register() race once more

Misc fixes:

 - a counter freezing related regression fix,
 - an uprobes race fix,
 - an Intel PMU unusual event combination fix,
 - and diverse tooling fixes.

 Thanks,

	Ingo

------------------>
Andrea Parri (1):
      uprobes: Fix handle_swbp() vs. unregister() + register() race once more

Arnaldo Carvalho de Melo (5):
      tools build feature: Check if get_current_dir_name() is available
      tools headers uapi: Synchronize i915_drm.h
      tools arch x86: Update tools's copy of cpufeatures.h
      tools uapi asm-generic: Synchronize ioctls.h
      perf tools beauty ioctl: Support new ISO7816 commands

Jiri Olsa (5):
      perf tools: Fix crash on synthesizing the unit
      perf tools: Restore proper cwd on return from mnt namespace
      perf/x86/intel: Move branch tracing setup to the Intel-specific source file
      perf/x86/intel: Add generic branch tracing check to intel_pmu_has_bts()
      perf/x86/intel: Disallow precise_ip on BTS events

Peter Zijlstra (1):
      perf/x86/intel: Fix regression by default disabling perfmon v4 interrupt handling


 Documentation/admin-guide/kernel-parameters.txt |  3 +-
 arch/x86/events/core.c                          | 20 --------
 arch/x86/events/intel/core.c                    | 68 +++++++++++++++++++------
 arch/x86/events/perf_event.h                    | 13 +++--
 kernel/events/uprobes.c                         | 12 ++++-
 tools/arch/x86/include/asm/cpufeatures.h        |  2 +
 tools/build/Makefile.feature                    |  1 +
 tools/build/feature/Makefile                    |  4 ++
 tools/build/feature/test-all.c                  |  5 ++
 tools/build/feature/test-get_current_dir_name.c | 10 ++++
 tools/include/uapi/asm-generic/ioctls.h         |  2 +
 tools/include/uapi/drm/i915_drm.h               | 22 ++++++++
 tools/perf/Makefile.config                      |  5 ++
 tools/perf/tests/attr/base-record               |  2 +-
 tools/perf/trace/beauty/ioctl.c                 |  1 +
 tools/perf/util/Build                           |  1 +
 tools/perf/util/evsel.c                         |  2 +-
 tools/perf/util/get_current_dir_name.c          | 18 +++++++
 tools/perf/util/namespaces.c                    | 17 ++++++-
 tools/perf/util/namespaces.h                    |  1 +
 tools/perf/util/util.h                          |  4 ++
 21 files changed, 166 insertions(+), 47 deletions(-)
 create mode 100644 tools/build/feature/test-get_current_dir_name.c
 create mode 100644 tools/perf/util/get_current_dir_name.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 81d1d5a74728..5463d5a4d85c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -856,7 +856,8 @@
 			causing system reset or hang due to sending
 			INIT from AP to BSP.
 
-	disable_counter_freezing [HW]
+	perf_v4_pmi=	[X86,INTEL]
+			Format: <bool>
 			Disable Intel PMU counter freezing feature.
 			The feature only exists starting from
 			Arch Perfmon v4 (Skylake and newer).
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 106911b603bd..374a19712e20 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -438,26 +438,6 @@ int x86_setup_perfctr(struct perf_event *event)
 	if (config == -1LL)
 		return -EINVAL;
 
-	/*
-	 * Branch tracing:
-	 */
-	if (attr->config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS &&
-	    !attr->freq && hwc->sample_period == 1) {
-		/* BTS is not supported by this architecture. */
-		if (!x86_pmu.bts_active)
-			return -EOPNOTSUPP;
-
-		/* BTS is currently only allowed for user-mode. */
-		if (!attr->exclude_kernel)
-			return -EOPNOTSUPP;
-
-		/* disallow bts if conflicting events are present */
-		if (x86_add_exclusive(x86_lbr_exclusive_lbr))
-			return -EBUSY;
-
-		event->destroy = hw_perf_lbr_event_destroy;
-	}
-
 	hwc->config |= config;
 
 	return 0;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 273c62e81546..ecc3e34ca955 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2306,14 +2306,18 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	return handled;
 }
 
-static bool disable_counter_freezing;
+static bool disable_counter_freezing = true;
 static int __init intel_perf_counter_freezing_setup(char *s)
 {
-	disable_counter_freezing = true;
-	pr_info("Intel PMU Counter freezing feature disabled\n");
+	bool res;
+
+	if (kstrtobool(s, &res))
+		return -EINVAL;
+
+	disable_counter_freezing = !res;
 	return 1;
 }
-__setup("disable_counter_freezing", intel_perf_counter_freezing_setup);
+__setup("perf_v4_pmi=", intel_perf_counter_freezing_setup);
 
 /*
  * Simplified handler for Arch Perfmon v4:
@@ -2470,16 +2474,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 static struct event_constraint *
 intel_bts_constraints(struct perf_event *event)
 {
-	struct hw_perf_event *hwc = &event->hw;
-	unsigned int hw_event, bts_event;
-
-	if (event->attr.freq)
-		return NULL;
-
-	hw_event = hwc->config & INTEL_ARCH_EVENT_MASK;
-	bts_event = x86_pmu.event_map(PERF_COUNT_HW_BRANCH_INSTRUCTIONS);
-
-	if (unlikely(hw_event == bts_event && hwc->sample_period == 1))
+	if (unlikely(intel_pmu_has_bts(event)))
 		return &bts_constraint;
 
 	return NULL;
@@ -3098,10 +3093,51 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 	return flags;
 }
 
+static int intel_pmu_bts_config(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+
+	if (unlikely(intel_pmu_has_bts(event))) {
+		/* BTS is not supported by this architecture. */
+		if (!x86_pmu.bts_active)
+			return -EOPNOTSUPP;
+
+		/* BTS is currently only allowed for user-mode. */
+		if (!attr->exclude_kernel)
+			return -EOPNOTSUPP;
+
+		/* BTS is not allowed for precise events. */
+		if (attr->precise_ip)
+			return -EOPNOTSUPP;
+
+		/* disallow bts if conflicting events are present */
+		if (x86_add_exclusive(x86_lbr_exclusive_lbr))
+			return -EBUSY;
+
+		event->destroy = hw_perf_lbr_event_destroy;
+	}
+
+	return 0;
+}
+
+static int core_pmu_hw_config(struct perf_event *event)
+{
+	int ret = x86_pmu_hw_config(event);
+
+	if (ret)
+		return ret;
+
+	return intel_pmu_bts_config(event);
+}
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
 
+	if (ret)
+		return ret;
+
+	ret = intel_pmu_bts_config(event);
 	if (ret)
 		return ret;
 
@@ -3127,7 +3163,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		/*
 		 * BTS is set up earlier in this path, so don't account twice
 		 */
-		if (!intel_pmu_has_bts(event)) {
+		if (!unlikely(intel_pmu_has_bts(event))) {
 			/* disallow lbr if conflicting events are present */
 			if (x86_add_exclusive(x86_lbr_exclusive_lbr))
 				return -EBUSY;
@@ -3596,7 +3632,7 @@ static __initconst const struct x86_pmu core_pmu = {
 	.enable_all		= core_pmu_enable_all,
 	.enable			= core_pmu_enable_event,
 	.disable		= x86_pmu_disable_event,
-	.hw_config		= x86_pmu_hw_config,
+	.hw_config		= core_pmu_hw_config,
 	.schedule_events	= x86_schedule_events,
 	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
 	.perfctr		= MSR_ARCH_PERFMON_PERFCTR0,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index adae087cecdd..78d7b7031bfc 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -859,11 +859,16 @@ static inline int amd_pmu_init(void)
 
 static inline bool intel_pmu_has_bts(struct perf_event *event)
 {
-	if (event->attr.config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS &&
-	    !event->attr.freq && event->hw.sample_period == 1)
-		return true;
+	struct hw_perf_event *hwc = &event->hw;
+	unsigned int hw_event, bts_event;
+
+	if (event->attr.freq)
+		return false;
+
+	hw_event = hwc->config & INTEL_ARCH_EVENT_MASK;
+	bts_event = x86_pmu.event_map(PERF_COUNT_HW_BRANCH_INSTRUCTIONS);
 
-	return false;
+	return hw_event == bts_event && hwc->sample_period == 1;
 }
 
 int intel_pmu_save_and_restart(struct perf_event *event);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 96d4bee83489..322e97bbb437 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -829,7 +829,7 @@ static int prepare_uprobe(struct uprobe *uprobe, struct file *file,
 	BUG_ON((uprobe->offset & ~PAGE_MASK) +
 			UPROBE_SWBP_INSN_SIZE > PAGE_SIZE);
 
-	smp_wmb(); /* pairs with rmb() in find_active_uprobe() */
+	smp_wmb(); /* pairs with the smp_rmb() in handle_swbp() */
 	set_bit(UPROBE_COPY_INSN, &uprobe->flags);
 
  out:
@@ -2178,10 +2178,18 @@ static void handle_swbp(struct pt_regs *regs)
 	 * After we hit the bp, _unregister + _register can install the
 	 * new and not-yet-analyzed uprobe at the same address, restart.
 	 */
-	smp_rmb(); /* pairs with wmb() in install_breakpoint() */
 	if (unlikely(!test_bit(UPROBE_COPY_INSN, &uprobe->flags)))
 		goto out;
 
+	/*
+	 * Pairs with the smp_wmb() in prepare_uprobe().
+	 *
+	 * Guarantees that if we see the UPROBE_COPY_INSN bit set, then
+	 * we must also see the stores to &uprobe->arch performed by the
+	 * prepare_uprobe() call.
+	 */
+	smp_rmb();
+
 	/* Tracing handlers use ->utask to communicate with fetch methods */
 	if (!get_utask())
 		goto out;
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 89a048c2faec..28c4a502b419 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -331,6 +331,8 @@
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
 #define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
+#define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
+#define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index f216b2f5c3d7..d74bb9414d7c 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -33,6 +33,7 @@ FEATURE_TESTS_BASIC :=                  \
         dwarf_getlocations              \
         fortify-source                  \
         sync-compare-and-swap           \
+        get_current_dir_name            \
         glibc                           \
         gtk2                            \
         gtk2-infobar                    \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 0516259be70f..304b984f11b9 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -7,6 +7,7 @@ FILES=                                          \
          test-dwarf_getlocations.bin            \
          test-fortify-source.bin                \
          test-sync-compare-and-swap.bin         \
+         test-get_current_dir_name.bin          \
          test-glibc.bin                         \
          test-gtk2.bin                          \
          test-gtk2-infobar.bin                  \
@@ -101,6 +102,9 @@ $(OUTPUT)test-bionic.bin:
 $(OUTPUT)test-libelf.bin:
 	$(BUILD) -lelf
 
+$(OUTPUT)test-get_current_dir_name.bin:
+	$(BUILD)
+
 $(OUTPUT)test-glibc.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 8dc20a61341f..56722bfe6bdd 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -34,6 +34,10 @@
 # include "test-libelf-mmap.c"
 #undef main
 
+#define main main_test_get_current_dir_name
+# include "test-get_current_dir_name.c"
+#undef main
+
 #define main main_test_glibc
 # include "test-glibc.c"
 #undef main
@@ -174,6 +178,7 @@ int main(int argc, char *argv[])
 	main_test_hello();
 	main_test_libelf();
 	main_test_libelf_mmap();
+	main_test_get_current_dir_name();
 	main_test_glibc();
 	main_test_dwarf();
 	main_test_dwarf_getlocations();
diff --git a/tools/build/feature/test-get_current_dir_name.c b/tools/build/feature/test-get_current_dir_name.c
new file mode 100644
index 000000000000..573000f93212
--- /dev/null
+++ b/tools/build/feature/test-get_current_dir_name.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <stdlib.h>
+
+int main(void)
+{
+	free(get_current_dir_name());
+	return 0;
+}
diff --git a/tools/include/uapi/asm-generic/ioctls.h b/tools/include/uapi/asm-generic/ioctls.h
index 040651735662..cdc9f4ca8c27 100644
--- a/tools/include/uapi/asm-generic/ioctls.h
+++ b/tools/include/uapi/asm-generic/ioctls.h
@@ -79,6 +79,8 @@
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
 #define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
+#define TIOCGISO7816	_IOR('T', 0x42, struct serial_iso7816)
+#define TIOCSISO7816	_IOWR('T', 0x43, struct serial_iso7816)
 
 #define FIONCLEX	0x5450
 #define FIOCLEX		0x5451
diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 7f5634ce8e88..a4446f452040 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -529,6 +529,28 @@ typedef struct drm_i915_irq_wait {
  */
 #define I915_PARAM_CS_TIMESTAMP_FREQUENCY 51
 
+/*
+ * Once upon a time we supposed that writes through the GGTT would be
+ * immediately in physical memory (once flushed out of the CPU path). However,
+ * on a few different processors and chipsets, this is not necessarily the case
+ * as the writes appear to be buffered internally. Thus a read of the backing
+ * storage (physical memory) via a different path (with different physical tags
+ * to the indirect write via the GGTT) will see stale values from before
+ * the GGTT write. Inside the kernel, we can for the most part keep track of
+ * the different read/write domains in use (e.g. set-domain), but the assumption
+ * of coherency is baked into the ABI, hence reporting its true state in this
+ * parameter.
+ *
+ * Reports true when writes via mmap_gtt are immediately visible following an
+ * lfence to flush the WCB.
+ *
+ * Reports false when writes via mmap_gtt are indeterminately delayed in an in
+ * internal buffer and are _not_ immediately visible to third parties accessing
+ * directly via mmap_cpu/mmap_wc. Use of mmap_gtt as part of an IPC
+ * communications channel when reporting false is strongly disadvised.
+ */
+#define I915_PARAM_MMAP_GTT_COHERENT	52
+
 typedef struct drm_i915_getparam {
 	__s32 param;
 	/*
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index e30d20fb482d..a0e8c23f9125 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -299,6 +299,11 @@ ifndef NO_BIONIC
   endif
 endif
 
+ifeq ($(feature-get_current_dir_name), 1)
+  CFLAGS += -DHAVE_GET_CURRENT_DIR_NAME
+endif
+
+
 ifdef NO_LIBELF
   NO_DWARF := 1
   NO_DEMANGLE := 1
diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
index 37940665f736..efd0157b9d22 100644
--- a/tools/perf/tests/attr/base-record
+++ b/tools/perf/tests/attr/base-record
@@ -9,7 +9,7 @@ size=112
 config=0
 sample_period=*
 sample_type=263
-read_format=0
+read_format=0|4
 disabled=1
 inherit=1
 pinned=0
diff --git a/tools/perf/trace/beauty/ioctl.c b/tools/perf/trace/beauty/ioctl.c
index 5d2a7fd8d407..eae59ad15ce3 100644
--- a/tools/perf/trace/beauty/ioctl.c
+++ b/tools/perf/trace/beauty/ioctl.c
@@ -31,6 +31,7 @@ static size_t ioctl__scnprintf_tty_cmd(int nr, int dir, char *bf, size_t size)
 	"TCSETSW2", "TCSETSF2", "TIOCGRS48", "TIOCSRS485", "TIOCGPTN", "TIOCSPTLCK",
 	"TIOCGDEV", "TCSETX", "TCSETXF", "TCSETXW", "TIOCSIG", "TIOCVHANGUP", "TIOCGPKT",
 	"TIOCGPTLCK", [_IOC_NR(TIOCGEXCL)] = "TIOCGEXCL", "TIOCGPTPEER",
+	"TIOCGISO7816", "TIOCSISO7816",
 	[_IOC_NR(FIONCLEX)] = "FIONCLEX", "FIOCLEX", "FIOASYNC", "TIOCSERCONFIG",
 	"TIOCSERGWILD", "TIOCSERSWILD", "TIOCGLCKTRMIOS", "TIOCSLCKTRMIOS",
 	"TIOCSERGSTRUCT", "TIOCSERGETLSR", "TIOCSERGETMULTI", "TIOCSERSETMULTI",
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index ecd9f9ceda77..b7bf201fe8a8 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -10,6 +10,7 @@ libperf-y += evlist.o
 libperf-y += evsel.o
 libperf-y += evsel_fprintf.o
 libperf-y += find_bit.o
+libperf-y += get_current_dir_name.o
 libperf-y += kallsyms.o
 libperf-y += levenshtein.o
 libperf-y += llvm-utils.o
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d37bb1566cd9..dbc0466db368 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1092,7 +1092,7 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 		attr->exclude_user   = 1;
 	}
 
-	if (evsel->own_cpus)
+	if (evsel->own_cpus || evsel->unit)
 		evsel->attr.read_format |= PERF_FORMAT_ID;
 
 	/*
diff --git a/tools/perf/util/get_current_dir_name.c b/tools/perf/util/get_current_dir_name.c
new file mode 100644
index 000000000000..267aa609a582
--- /dev/null
+++ b/tools/perf/util/get_current_dir_name.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+//
+#ifndef HAVE_GET_CURRENT_DIR_NAME
+#include "util.h"
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdlib.h>
+
+/* Android's 'bionic' library, for one, doesn't have this */
+
+char *get_current_dir_name(void)
+{
+	char pwd[PATH_MAX];
+
+	return getcwd(pwd, sizeof(pwd)) == NULL ? NULL : strdup(pwd);
+}
+#endif // HAVE_GET_CURRENT_DIR_NAME
diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index cf8bd123cf73..aed170bd4384 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -18,6 +18,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
+#include <asm/bug.h>
 
 struct namespaces *namespaces__new(struct namespaces_event *event)
 {
@@ -186,6 +187,7 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	char curpath[PATH_MAX];
 	int oldns = -1;
 	int newns = -1;
+	char *oldcwd = NULL;
 
 	if (nc == NULL)
 		return;
@@ -199,9 +201,13 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	if (snprintf(curpath, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
 		return;
 
+	oldcwd = get_current_dir_name();
+	if (!oldcwd)
+		return;
+
 	oldns = open(curpath, O_RDONLY);
 	if (oldns < 0)
-		return;
+		goto errout;
 
 	newns = open(nsi->mntns_path, O_RDONLY);
 	if (newns < 0)
@@ -210,11 +216,13 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	if (setns(newns, CLONE_NEWNS) < 0)
 		goto errout;
 
+	nc->oldcwd = oldcwd;
 	nc->oldns = oldns;
 	nc->newns = newns;
 	return;
 
 errout:
+	free(oldcwd);
 	if (oldns > -1)
 		close(oldns);
 	if (newns > -1)
@@ -223,11 +231,16 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 
 void nsinfo__mountns_exit(struct nscookie *nc)
 {
-	if (nc == NULL || nc->oldns == -1 || nc->newns == -1)
+	if (nc == NULL || nc->oldns == -1 || nc->newns == -1 || !nc->oldcwd)
 		return;
 
 	setns(nc->oldns, CLONE_NEWNS);
 
+	if (nc->oldcwd) {
+		WARN_ON_ONCE(chdir(nc->oldcwd));
+		zfree(&nc->oldcwd);
+	}
+
 	if (nc->oldns > -1) {
 		close(nc->oldns);
 		nc->oldns = -1;
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index cae1a9a39722..d5f46c09ea31 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -38,6 +38,7 @@ struct nsinfo {
 struct nscookie {
 	int			oldns;
 	int			newns;
+	char			*oldcwd;
 };
 
 int nsinfo__init(struct nsinfo *nsi);
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 14508ee7707a..ece040b799f6 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -59,6 +59,10 @@ int fetch_kernel_version(unsigned int *puint,
 
 const char *perf_tip(const char *dirpath);
 
+#ifndef HAVE_GET_CURRENT_DIR_NAME
+char *get_current_dir_name(void);
+#endif
+
 #ifndef HAVE_SCHED_GETCPU_SUPPORT
 int sched_getcpu(void);
 #endif
