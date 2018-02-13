Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934914AbeBMMAB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:00:01 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52631 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934231AbeBML76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:59:58 -0500
X-Google-Smtp-Source: AH8x224zJhNvl1nrvta7eK8iQmQ6jTC0CB4Rm5LYJ5LUpGphP5XgbQ7icz3/yyVvZE6wST+sSAZiNA==
Date: Tue, 13 Feb 2018 12:59:53 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Sangwon Hong <qpakzk@gmail.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>, William Cohen <wcohen@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH] tools/headers: Synchronize kernel ABI headers, v4.16-rc1
Message-ID: <20180213115953.ofveezu2tlcxjrnh@gmail.com>
References: <20180206165350.2570-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206165350.2570-1-acme@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 33ea4b24277b06dbc55d7f5772a46f029600255e:
> 
>   perf/core: Implement the 'perf_uprobe' PMU (2018-02-06 11:29:28 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.17-20180206
> 
> for you to fetch changes up to 52a37001d51a320c1019269fb3ba473a1363650d:
> 
>   perf test: Fix test trace+probe_libc_inet_pton.sh for s390x (2018-02-06 10:46:58 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - perf_mmap overwrite mode overhaul, prep work to get 'perf top'
>   using it, making it bearable to use it in large core count systems
>   such as Knights Landing/Mill Intel systems (Kan Liang)
> 
> - Add perf vendor JSON metrics for ARM Cortex-A53 Processor (William Cohen)
> 
> - Use strtoull() instead of home grown function (Andy Shevchenko)
> 
> - Document missing 'perf data --force' option (Sangwon Hong)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andy Shevchenko (1):
>       perf tools: Substitute yet another strtoull()
> 
> Arnaldo Carvalho de Melo (1):
>       perf evsel: Expose the perf_missing_features struct
> 
> Kan Liang (16):
>       perf evlist: Remove stale mmap read for backward
>       perf mmap: Recalculate size for overwrite mode
>       perf mmap: Cleanup perf_mmap__push()
>       perf mmap: Introduce perf_mmap__read_init()
>       perf mmap: Add new return value logic for perf_mmap__read_init()
>       perf mmap: Discard 'prev' in perf_mmap__read()
>       perf mmap: Introduce perf_mmap__read_done()
>       perf mmap: Introduce perf_mmap__read_event()
>       perf test: Update mmap read functions for backward-ring-buffer test
>       perf mmap: Discard legacy interface for mmap read
>       perf top: Check per-event overwrite term
>       perf top: Add overwrite fall back
>       perf hists browser: Add parameter to disable lost event warning
>       perf top: Remove lost events checking
>       perf top: Switch default mode to overwrite mode
>       perf top: Check the latency of perf_top__mmap_read()
> 
> Sangwon Hong (1):
>       perf data: Document missing --force option
> 
> Thomas Richter (1):
>       perf test: Fix test trace+probe_libc_inet_pton.sh for s390x
> 
> William Cohen (1):
>       perf vendor events aarch64: Add JSON metrics for ARM Cortex-A53 Processor
> 
>  tools/perf/Documentation/perf-data.txt             |   4 +
>  tools/perf/builtin-c2c.c                           |   4 +-
>  tools/perf/builtin-report.c                        |   3 +-
>  tools/perf/builtin-top.c                           | 150 ++++++++++++++++++++-
>  .../pmu-events/arch/arm64/cortex-a53/branch.json   |  27 ++++
>  .../perf/pmu-events/arch/arm64/cortex-a53/bus.json |  22 +++
>  .../pmu-events/arch/arm64/cortex-a53/cache.json    |  27 ++++
>  .../pmu-events/arch/arm64/cortex-a53/memory.json   |  22 +++
>  .../pmu-events/arch/arm64/cortex-a53/other.json    |  32 +++++
>  .../pmu-events/arch/arm64/cortex-a53/pipeline.json |  52 +++++++
>  tools/perf/pmu-events/arch/arm64/mapfile.csv       |   1 +
>  tools/perf/tests/backward-ring-buffer.c            |   7 +-
>  .../perf/tests/shell/trace+probe_libc_inet_pton.sh |  23 +++-
>  tools/perf/ui/browsers/hists.c                     |  38 ++++--
>  tools/perf/ui/browsers/hists.h                     |   3 +-
>  tools/perf/util/evlist.c                           |  17 ---
>  tools/perf/util/evlist.h                           |   4 -
>  tools/perf/util/evsel.c                            |  12 +-
>  tools/perf/util/evsel.h                            |  14 ++
>  tools/perf/util/hist.h                             |   6 +-
>  tools/perf/util/mmap.c                             | 141 ++++++++++---------
>  tools/perf/util/mmap.h                             |  10 +-
>  tools/perf/util/util.c                             |  24 +---
>  23 files changed, 492 insertions(+), 151 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/other.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/pipeline.json

Pulled into tip:perf/urgent, thanks a lot Arnaldo!

Note, I also performed a header sync with v4.16-rc1, see the patch below.

The only exception is:

  Warning: Kernel ABI header at 'tools/arch/s390/include/uapi/asm/unistd.h' differs  from latest version at 'arch/s390/include/uapi/asm/unistd.h'

... which I'm unsure how to resolve: the new upstream header includes unistd_64.h, 
but neither s390 nor asm-generic has no such a file.

Thanks,

	Ingo

===================>
>From a408361b6aa182d9defc0ffed71936b9bc41f0db Mon Sep 17 00:00:00 2001
From: Ingo Molnar <mingo@kernel.org>
Date: Tue, 13 Feb 2018 12:54:58 +0100
Subject: [PATCH] tools/headers: Synchronize kernel ABI headers, v4.16-rc1

Sync the following tooling headers with the latest kernel version:

  tools/arch/powerpc/include/uapi/asm/kvm.h
  tools/arch/x86/include/asm/cpufeatures.h
  tools/include/uapi/drm/i915_drm.h
  tools/include/uapi/linux/if_link.h
  tools/include/uapi/linux/kvm.h

All the changes are new ABI additions which don't impact their use
in existing tooling.

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/arch/powerpc/include/uapi/asm/kvm.h |  2 +
 tools/arch/x86/include/asm/cpufeatures.h  |  1 +
 tools/include/uapi/drm/i915_drm.h         | 77 ++++++++++++++++++++++++++
 tools/include/uapi/linux/if_link.h        |  1 +
 tools/include/uapi/linux/kvm.h            | 90 +++++++++++++++++++++++++++++++
 5 files changed, 171 insertions(+)

diff --git a/tools/arch/powerpc/include/uapi/asm/kvm.h b/tools/arch/powerpc/include/uapi/asm/kvm.h
index 637b7263cb86..833ed9a16adf 100644
--- a/tools/arch/powerpc/include/uapi/asm/kvm.h
+++ b/tools/arch/powerpc/include/uapi/asm/kvm.h
@@ -632,6 +632,8 @@ struct kvm_ppc_cpu_char {
 #define KVM_REG_PPC_TIDR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbc)
 #define KVM_REG_PPC_PSSCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbd)
 
+#define KVM_REG_PPC_DEC_EXPIRY	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbe)
+
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
  */
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 1d9199e1c2ad..0dfe4d3f74e2 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -210,6 +210,7 @@
 
 #define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
 #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context switches */
+#define X86_FEATURE_SEV			( 7*32+20) /* AMD Secure Encrypted Virtualization */
 
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 
diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index ac3c6503ca27..536ee4febd74 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -86,6 +86,62 @@ enum i915_mocs_table_index {
 	I915_MOCS_CACHED,
 };
 
+/*
+ * Different engines serve different roles, and there may be more than one
+ * engine serving each role. enum drm_i915_gem_engine_class provides a
+ * classification of the role of the engine, which may be used when requesting
+ * operations to be performed on a certain subset of engines, or for providing
+ * information about that group.
+ */
+enum drm_i915_gem_engine_class {
+	I915_ENGINE_CLASS_RENDER	= 0,
+	I915_ENGINE_CLASS_COPY		= 1,
+	I915_ENGINE_CLASS_VIDEO		= 2,
+	I915_ENGINE_CLASS_VIDEO_ENHANCE	= 3,
+
+	I915_ENGINE_CLASS_INVALID	= -1
+};
+
+/**
+ * DOC: perf_events exposed by i915 through /sys/bus/event_sources/drivers/i915
+ *
+ */
+
+enum drm_i915_pmu_engine_sample {
+	I915_SAMPLE_BUSY = 0,
+	I915_SAMPLE_WAIT = 1,
+	I915_SAMPLE_SEMA = 2
+};
+
+#define I915_PMU_SAMPLE_BITS (4)
+#define I915_PMU_SAMPLE_MASK (0xf)
+#define I915_PMU_SAMPLE_INSTANCE_BITS (8)
+#define I915_PMU_CLASS_SHIFT \
+	(I915_PMU_SAMPLE_BITS + I915_PMU_SAMPLE_INSTANCE_BITS)
+
+#define __I915_PMU_ENGINE(class, instance, sample) \
+	((class) << I915_PMU_CLASS_SHIFT | \
+	(instance) << I915_PMU_SAMPLE_BITS | \
+	(sample))
+
+#define I915_PMU_ENGINE_BUSY(class, instance) \
+	__I915_PMU_ENGINE(class, instance, I915_SAMPLE_BUSY)
+
+#define I915_PMU_ENGINE_WAIT(class, instance) \
+	__I915_PMU_ENGINE(class, instance, I915_SAMPLE_WAIT)
+
+#define I915_PMU_ENGINE_SEMA(class, instance) \
+	__I915_PMU_ENGINE(class, instance, I915_SAMPLE_SEMA)
+
+#define __I915_PMU_OTHER(x) (__I915_PMU_ENGINE(0xff, 0xff, 0xf) + 1 + (x))
+
+#define I915_PMU_ACTUAL_FREQUENCY	__I915_PMU_OTHER(0)
+#define I915_PMU_REQUESTED_FREQUENCY	__I915_PMU_OTHER(1)
+#define I915_PMU_INTERRUPTS		__I915_PMU_OTHER(2)
+#define I915_PMU_RC6_RESIDENCY		__I915_PMU_OTHER(3)
+
+#define I915_PMU_LAST I915_PMU_RC6_RESIDENCY
+
 /* Each region is a minimum of 16k, and there are at most 255 of them.
  */
 #define I915_NR_TEX_REGIONS 255	/* table size 2k - maximum due to use
@@ -450,6 +506,27 @@ typedef struct drm_i915_irq_wait {
  */
 #define I915_PARAM_HAS_EXEC_FENCE_ARRAY  49
 
+/*
+ * Query whether every context (both per-file default and user created) is
+ * isolated (insofar as HW supports). If this parameter is not true, then
+ * freshly created contexts may inherit values from an existing context,
+ * rather than default HW values. If true, it also ensures (insofar as HW
+ * supports) that all state set by this context will not leak to any other
+ * context.
+ *
+ * As not every engine across every gen support contexts, the returned
+ * value reports the support of context isolation for individual engines by
+ * returning a bitmask of each engine class set to true if that class supports
+ * isolation.
+ */
+#define I915_PARAM_HAS_CONTEXT_ISOLATION 50
+
+/* Frequency of the command streamer timestamps given by the *_TIMESTAMP
+ * registers. This used to be fixed per platform but from CNL onwards, this
+ * might vary depending on the parts.
+ */
+#define I915_PARAM_CS_TIMESTAMP_FREQUENCY 51
+
 typedef struct drm_i915_getparam {
 	__s32 param;
 	/*
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 8616131e2c61..6d9447700e18 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -163,6 +163,7 @@ enum {
 	IFLA_IF_NETNSID,
 	IFLA_CARRIER_UP_COUNT,
 	IFLA_CARRIER_DOWN_COUNT,
+	IFLA_NEW_IFINDEX,
 	__IFLA_MAX
 };
 
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 8fb90a0819c3..0fb5ef939732 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1362,6 +1362,96 @@ struct kvm_s390_ucas_mapping {
 /* Available with KVM_CAP_S390_CMMA_MIGRATION */
 #define KVM_S390_GET_CMMA_BITS      _IOWR(KVMIO, 0xb8, struct kvm_s390_cmma_log)
 #define KVM_S390_SET_CMMA_BITS      _IOW(KVMIO, 0xb9, struct kvm_s390_cmma_log)
+/* Memory Encryption Commands */
+#define KVM_MEMORY_ENCRYPT_OP      _IOWR(KVMIO, 0xba, unsigned long)
+
+struct kvm_enc_region {
+	__u64 addr;
+	__u64 size;
+};
+
+#define KVM_MEMORY_ENCRYPT_REG_REGION    _IOR(KVMIO, 0xbb, struct kvm_enc_region)
+#define KVM_MEMORY_ENCRYPT_UNREG_REGION  _IOR(KVMIO, 0xbc, struct kvm_enc_region)
+
+/* Secure Encrypted Virtualization command */
+enum sev_cmd_id {
+	/* Guest initialization commands */
+	KVM_SEV_INIT = 0,
+	KVM_SEV_ES_INIT,
+	/* Guest launch commands */
+	KVM_SEV_LAUNCH_START,
+	KVM_SEV_LAUNCH_UPDATE_DATA,
+	KVM_SEV_LAUNCH_UPDATE_VMSA,
+	KVM_SEV_LAUNCH_SECRET,
+	KVM_SEV_LAUNCH_MEASURE,
+	KVM_SEV_LAUNCH_FINISH,
+	/* Guest migration commands (outgoing) */
+	KVM_SEV_SEND_START,
+	KVM_SEV_SEND_UPDATE_DATA,
+	KVM_SEV_SEND_UPDATE_VMSA,
+	KVM_SEV_SEND_FINISH,
+	/* Guest migration commands (incoming) */
+	KVM_SEV_RECEIVE_START,
+	KVM_SEV_RECEIVE_UPDATE_DATA,
+	KVM_SEV_RECEIVE_UPDATE_VMSA,
+	KVM_SEV_RECEIVE_FINISH,
+	/* Guest status and debug commands */
+	KVM_SEV_GUEST_STATUS,
+	KVM_SEV_DBG_DECRYPT,
+	KVM_SEV_DBG_ENCRYPT,
+	/* Guest certificates commands */
+	KVM_SEV_CERT_EXPORT,
+
+	KVM_SEV_NR_MAX,
+};
+
+struct kvm_sev_cmd {
+	__u32 id;
+	__u64 data;
+	__u32 error;
+	__u32 sev_fd;
+};
+
+struct kvm_sev_launch_start {
+	__u32 handle;
+	__u32 policy;
+	__u64 dh_uaddr;
+	__u32 dh_len;
+	__u64 session_uaddr;
+	__u32 session_len;
+};
+
+struct kvm_sev_launch_update_data {
+	__u64 uaddr;
+	__u32 len;
+};
+
+
+struct kvm_sev_launch_secret {
+	__u64 hdr_uaddr;
+	__u32 hdr_len;
+	__u64 guest_uaddr;
+	__u32 guest_len;
+	__u64 trans_uaddr;
+	__u32 trans_len;
+};
+
+struct kvm_sev_launch_measure {
+	__u64 uaddr;
+	__u32 len;
+};
+
+struct kvm_sev_guest_status {
+	__u32 handle;
+	__u32 policy;
+	__u32 state;
+};
+
+struct kvm_sev_dbg {
+	__u64 src_uaddr;
+	__u64 dst_uaddr;
+	__u32 len;
+};
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
