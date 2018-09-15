Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	FUZZY_XPILL,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2A0ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 13:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DA82086B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 13:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llMDfENo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DA82086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeIOSaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 14:30:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33172 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeIOSaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 14:30:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id v90-v6so13041918wrc.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 06:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=ieXUEq4NqIO1MuZNtyO4ntg+LQ/Fmp8Y0OQwh/C2zBg=;
        b=llMDfENoOhC9PVfHurSkk8tjCtiQbV0xmkTwXG+I9BcnHl66H9AFmGue0Vc6FpYMiY
         zuosXpZGbpenZEfwtdOHsfLopVWpSPH9fr/+X4rzfj85Uj0qOkjFjcj7Pxeu0gvQvd5V
         3zhjabO2Xoi55SVpkvyUBHZKLDZvDlK533wSud8c7M1RqJOOK4LUpPJTuxjz46NyZDdG
         hU0HLZxZDfCt1HsxbEam01wo5eJxxlZG3xla1+gFyXW8g+QON5ZebOktAmTLGK0Ant4W
         g5787zpLYI1Y7Wm+1YVknPJKvbYyvXxl/S4c70aU08Q03grU5HCOc51x3CO24mJVW999
         n4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding
         :user-agent;
        bh=ieXUEq4NqIO1MuZNtyO4ntg+LQ/Fmp8Y0OQwh/C2zBg=;
        b=q4ihJ0XuA5sU/G1YmszXF29VcXD3IQzfb4bgCq12OQIw5R/ax/m9G/oKw2ysS2WTA5
         xXmQO6ILikv7Nvy4TDa7qFWlxmBqyo6gPnWTYRpX4stwGyfW1YwBtAZOgIaTM8TgBZgk
         oDjpEMd4HRaFTKcAmg7w1CgcO/8PKwEiIKyh7rvhPzR+Ulfq58Dt+jKfP0MsQbVlbM9E
         JVhO7Xk72B00RAV0qk9lwtRBpzyEnblfAca4LelEfbpb1Lw2twT4z/tku14tlKn0AsO8
         5UI+I9QPcsxXY6yZRvk7yR/uKSgqTySBhfk32DyuOOEnOBa9xP+fDOFqe4cEovaAaCC/
         tMVA==
X-Gm-Message-State: APzg51BHS2TbP+vdnUqM6Lsn8HI66EhlyGxgdJq7hviWEQMhDvW1FiFs
        uoNshbksFC5vTrBq/JUTLW8=
X-Google-Smtp-Source: ANB0VdbQ8SO5r0ZiOj3olOYCnv+AbvISmE5jgA+udKpgZbixhygQtMwTdQQKlLDm602fIQAI891OBg==
X-Received: by 2002:a5d:6aca:: with SMTP id u10-v6mr13172363wrw.44.1537017070884;
        Sat, 15 Sep 2018 06:11:10 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c9-v6sm7518612wrt.77.2018.09.15.06.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 06:11:10 -0700 (PDT)
Date:   Sat, 15 Sep 2018 15:11:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [GIT PULL] perf fixes
Message-ID: <20180915131108.GA94702@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: cb48b6a26cace226d8b299a48c73e808eb0c4f61 Merge tag 'perf-urgent-for-mingo-4.19-20180912' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

Mostly tooling fixes, but also breakpoint and x86 PMU driver fixes.

 Thanks,

	Ingo

------------------>
Adrian Hunter (1):
      perf tools: Fix maps__find_symbol_by_name()

Arnaldo Carvalho de Melo (7):
      perf tools: Streamline bpf examples and headers installation
      tools headers uapi: Update tools's copy of linux/perf_event.h
      tools headers uapi: Update tools's copy of asm-generic/unistd.h
      tools headers uapi: Update tools's copy of drm/drm.h
      tools headers uapi: Update tools's copies of kvm headers
      tools headers uapi: Update tools's copy of linux/vhost.h
      tools headers uapi: Update tools's copy of linux/if_link.h

Chris Phlipot (2):
      perf util: Fix bad memory access in trace info.
      perf event-parse: Use fixed size string for comms

Hisao Tanabe (1):
      perf evsel: Fix potential null pointer dereference in perf_evsel__new_idx()

Jacek Tomaka (1):
      perf/x86/intel: Add support/quirk for the MISPREDICT bit on Knights Landing CPUs

Jiri Olsa (5):
      perf tests: Add breakpoint modify tests
      perf/hw_breakpoint: Modify breakpoint even if the new attr has disabled set
      perf/hw_breakpoint: Remove superfluous bp->attr.disabled = 0
      perf/hw_breakpoint: Enable breakpoint in modify_user_hw_breakpoint
      perf/hw_breakpoint: Simplify breakpoint enable in perf_event_modify_breakpoint

Kim Phillips (2):
      perf arm64: Fix include path for asm-generic/unistd.h
      perf annotate: Fix parsing aarch64 branch instructions after objdump update

Martin Liška (1):
      perf annotate: Properly interpret indirect call

Peter Zijlstra (1):
      perf/UAPI: Clearly mark __PERF_SAMPLE_CALLCHAIN_EARLY as internal use

Sandipan Das (1):
      perf probe powerpc: Ignore SyS symbols irrespective of endianness

Yabin Cui (1):
      perf/core: Force USER_DS when recording user stack data


 arch/x86/events/intel/lbr.c                       |   4 +
 include/uapi/linux/perf_event.h                   |   2 +-
 kernel/events/core.c                              |  15 +-
 kernel/events/hw_breakpoint.c                     |  13 +-
 tools/arch/arm/include/uapi/asm/kvm.h             |  13 ++
 tools/arch/arm64/include/uapi/asm/kvm.h           |  13 ++
 tools/arch/s390/include/uapi/asm/kvm.h            |   5 +-
 tools/arch/x86/include/uapi/asm/kvm.h             |  37 ++++
 tools/include/uapi/asm-generic/unistd.h           |   4 +-
 tools/include/uapi/drm/drm.h                      |   9 +
 tools/include/uapi/linux/if_link.h                |  17 ++
 tools/include/uapi/linux/kvm.h                    |   6 +
 tools/include/uapi/linux/perf_event.h             |   2 +-
 tools/include/uapi/linux/vhost.h                  |  18 ++
 tools/perf/Makefile.perf                          |  14 +-
 tools/perf/arch/arm64/Makefile                    |   5 +-
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl |   6 +-
 tools/perf/arch/powerpc/util/sym-handling.c       |   4 +-
 tools/perf/arch/x86/include/arch-tests.h          |   1 +
 tools/perf/arch/x86/tests/Build                   |   1 +
 tools/perf/arch/x86/tests/arch-tests.c            |   6 +
 tools/perf/arch/x86/tests/bp-modify.c             | 213 ++++++++++++++++++++++
 tools/perf/util/annotate.c                        |  32 +++-
 tools/perf/util/annotate.h                        |   1 +
 tools/perf/util/evsel.c                           |   5 +-
 tools/perf/util/map.c                             |  11 ++
 tools/perf/util/trace-event-info.c                |   2 +-
 tools/perf/util/trace-event-parse.c               |   7 +-
 28 files changed, 423 insertions(+), 43 deletions(-)
 create mode 100644 tools/perf/arch/x86/tests/bp-modify.c

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index f3e006bed9a7..c88ed39582a1 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1272,4 +1272,8 @@ void intel_pmu_lbr_init_knl(void)
 
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = snb_lbr_sel_map;
+
+	/* Knights Landing does have MISPREDICT bit */
+	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_LIP)
+		x86_pmu.intel_cap.lbr_format = LBR_FORMAT_EIP_FLAGS;
 }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index eeb787b1c53c..f35eb72739c0 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -144,7 +144,7 @@ enum perf_event_sample_format {
 
 	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
 
-	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63,
+	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2a62b96600ad..c80549bf82c6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2867,16 +2867,11 @@ static int perf_event_modify_breakpoint(struct perf_event *bp,
 	_perf_event_disable(bp);
 
 	err = modify_user_hw_breakpoint_check(bp, attr, true);
-	if (err) {
-		if (!bp->attr.disabled)
-			_perf_event_enable(bp);
 
-		return err;
-	}
-
-	if (!attr->disabled)
+	if (!bp->attr.disabled)
 		_perf_event_enable(bp);
-	return 0;
+
+	return err;
 }
 
 static int perf_event_modify_attr(struct perf_event *event,
@@ -5948,6 +5943,7 @@ perf_output_sample_ustack(struct perf_output_handle *handle, u64 dump_size,
 		unsigned long sp;
 		unsigned int rem;
 		u64 dyn_size;
+		mm_segment_t fs;
 
 		/*
 		 * We dump:
@@ -5965,7 +5961,10 @@ perf_output_sample_ustack(struct perf_output_handle *handle, u64 dump_size,
 
 		/* Data. */
 		sp = perf_user_stack_pointer(regs);
+		fs = get_fs();
+		set_fs(USER_DS);
 		rem = __output_copy_user(handle, (void *) sp, dump_size);
+		set_fs(fs);
 		dyn_size = dump_size - rem;
 
 		perf_output_skip(handle, rem);
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index b3814fce5ecb..d6b56180827c 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -509,6 +509,8 @@ modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *a
  */
 int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *attr)
 {
+	int err;
+
 	/*
 	 * modify_user_hw_breakpoint can be invoked with IRQs disabled and hence it
 	 * will not be possible to raise IPIs that invoke __perf_event_disable.
@@ -520,15 +522,12 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
 	else
 		perf_event_disable(bp);
 
-	if (!attr->disabled) {
-		int err = modify_user_hw_breakpoint_check(bp, attr, false);
+	err = modify_user_hw_breakpoint_check(bp, attr, false);
 
-		if (err)
-			return err;
+	if (!bp->attr.disabled)
 		perf_event_enable(bp);
-		bp->attr.disabled = 0;
-	}
-	return 0;
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(modify_user_hw_breakpoint);
 
diff --git a/tools/arch/arm/include/uapi/asm/kvm.h b/tools/arch/arm/include/uapi/asm/kvm.h
index 16e006f708ca..4602464ebdfb 100644
--- a/tools/arch/arm/include/uapi/asm/kvm.h
+++ b/tools/arch/arm/include/uapi/asm/kvm.h
@@ -27,6 +27,7 @@
 #define __KVM_HAVE_GUEST_DEBUG
 #define __KVM_HAVE_IRQ_LINE
 #define __KVM_HAVE_READONLY_MEM
+#define __KVM_HAVE_VCPU_EVENTS
 
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 
@@ -125,6 +126,18 @@ struct kvm_sync_regs {
 struct kvm_arch_memory_slot {
 };
 
+/* for KVM_GET/SET_VCPU_EVENTS */
+struct kvm_vcpu_events {
+	struct {
+		__u8 serror_pending;
+		__u8 serror_has_esr;
+		/* Align it to 8 bytes */
+		__u8 pad[6];
+		__u64 serror_esr;
+	} exception;
+	__u32 reserved[12];
+};
+
 /* If you need to interpret the index values, here is the key: */
 #define KVM_REG_ARM_COPROC_MASK		0x000000000FFF0000
 #define KVM_REG_ARM_COPROC_SHIFT	16
diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index 4e76630dd655..97c3478ee6e7 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -39,6 +39,7 @@
 #define __KVM_HAVE_GUEST_DEBUG
 #define __KVM_HAVE_IRQ_LINE
 #define __KVM_HAVE_READONLY_MEM
+#define __KVM_HAVE_VCPU_EVENTS
 
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 
@@ -154,6 +155,18 @@ struct kvm_sync_regs {
 struct kvm_arch_memory_slot {
 };
 
+/* for KVM_GET/SET_VCPU_EVENTS */
+struct kvm_vcpu_events {
+	struct {
+		__u8 serror_pending;
+		__u8 serror_has_esr;
+		/* Align it to 8 bytes */
+		__u8 pad[6];
+		__u64 serror_esr;
+	} exception;
+	__u32 reserved[12];
+};
+
 /* If you need to interpret the index values, here is the key: */
 #define KVM_REG_ARM_COPROC_MASK		0x000000000FFF0000
 #define KVM_REG_ARM_COPROC_SHIFT	16
diff --git a/tools/arch/s390/include/uapi/asm/kvm.h b/tools/arch/s390/include/uapi/asm/kvm.h
index 4cdaa55fabfe..9a50f02b9894 100644
--- a/tools/arch/s390/include/uapi/asm/kvm.h
+++ b/tools/arch/s390/include/uapi/asm/kvm.h
@@ -4,7 +4,7 @@
 /*
  * KVM s390 specific structures and definitions
  *
- * Copyright IBM Corp. 2008
+ * Copyright IBM Corp. 2008, 2018
  *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
@@ -225,6 +225,7 @@ struct kvm_guest_debug_arch {
 #define KVM_SYNC_FPRS   (1UL << 8)
 #define KVM_SYNC_GSCB   (1UL << 9)
 #define KVM_SYNC_BPBC   (1UL << 10)
+#define KVM_SYNC_ETOKEN (1UL << 11)
 /* length and alignment of the sdnx as a power of two */
 #define SDNXC 8
 #define SDNXL (1UL << SDNXC)
@@ -258,6 +259,8 @@ struct kvm_sync_regs {
 		struct {
 			__u64 reserved1[2];
 			__u64 gscb[4];
+			__u64 etoken;
+			__u64 etoken_extension;
 		};
 	};
 };
diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index c535c2fdea13..86299efa804a 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -378,4 +378,41 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
 #define KVM_X86_QUIRK_CD_NW_CLEARED	(1 << 1)
 
+#define KVM_STATE_NESTED_GUEST_MODE	0x00000001
+#define KVM_STATE_NESTED_RUN_PENDING	0x00000002
+
+#define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
+#define KVM_STATE_NESTED_SMM_VMXON	0x00000002
+
+struct kvm_vmx_nested_state {
+	__u64 vmxon_pa;
+	__u64 vmcs_pa;
+
+	struct {
+		__u16 flags;
+	} smm;
+};
+
+/* for KVM_CAP_NESTED_STATE */
+struct kvm_nested_state {
+	/* KVM_STATE_* flags */
+	__u16 flags;
+
+	/* 0 for VMX, 1 for SVM.  */
+	__u16 format;
+
+	/* 128 for SVM, 128 + VMCS size for VMX.  */
+	__u32 size;
+
+	union {
+		/* VMXON, VMCS */
+		struct kvm_vmx_nested_state vmx;
+
+		/* Pad the header to 128 bytes.  */
+		__u8 pad[120];
+	};
+
+	__u8 data[0];
+};
+
 #endif /* _ASM_X86_KVM_H */
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 42990676a55e..df4bedb9b01c 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -734,9 +734,11 @@ __SYSCALL(__NR_pkey_free,     sys_pkey_free)
 __SYSCALL(__NR_statx,     sys_statx)
 #define __NR_io_pgetevents 292
 __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
+#define __NR_rseq 293
+__SYSCALL(__NR_rseq, sys_rseq)
 
 #undef __NR_syscalls
-#define __NR_syscalls 293
+#define __NR_syscalls 294
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index 9c660e1688ab..300f336633f2 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -687,6 +687,15 @@ struct drm_get_cap {
  */
 #define DRM_CLIENT_CAP_ASPECT_RATIO    4
 
+/**
+ * DRM_CLIENT_CAP_WRITEBACK_CONNECTORS
+ *
+ * If set to 1, the DRM core will expose special connectors to be used for
+ * writing back to memory the scene setup in the commit. Depends on client
+ * also supporting DRM_CLIENT_CAP_ATOMIC
+ */
+#define DRM_CLIENT_CAP_WRITEBACK_CONNECTORS	5
+
 /** DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
 struct drm_set_client_cap {
 	__u64 capability;
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index cf01b6824244..43391e2d1153 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -164,6 +164,8 @@ enum {
 	IFLA_CARRIER_UP_COUNT,
 	IFLA_CARRIER_DOWN_COUNT,
 	IFLA_NEW_IFINDEX,
+	IFLA_MIN_MTU,
+	IFLA_MAX_MTU,
 	__IFLA_MAX
 };
 
@@ -334,6 +336,7 @@ enum {
 	IFLA_BRPORT_GROUP_FWD_MASK,
 	IFLA_BRPORT_NEIGH_SUPPRESS,
 	IFLA_BRPORT_ISOLATED,
+	IFLA_BRPORT_BACKUP_PORT,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
@@ -459,6 +462,16 @@ enum {
 
 #define IFLA_MACSEC_MAX (__IFLA_MACSEC_MAX - 1)
 
+/* XFRM section */
+enum {
+	IFLA_XFRM_UNSPEC,
+	IFLA_XFRM_LINK,
+	IFLA_XFRM_IF_ID,
+	__IFLA_XFRM_MAX
+};
+
+#define IFLA_XFRM_MAX (__IFLA_XFRM_MAX - 1)
+
 enum macsec_validation_type {
 	MACSEC_VALIDATE_DISABLED = 0,
 	MACSEC_VALIDATE_CHECK = 1,
@@ -920,6 +933,7 @@ enum {
 	XDP_ATTACHED_DRV,
 	XDP_ATTACHED_SKB,
 	XDP_ATTACHED_HW,
+	XDP_ATTACHED_MULTI,
 };
 
 enum {
@@ -928,6 +942,9 @@ enum {
 	IFLA_XDP_ATTACHED,
 	IFLA_XDP_FLAGS,
 	IFLA_XDP_PROG_ID,
+	IFLA_XDP_DRV_PROG_ID,
+	IFLA_XDP_SKB_PROG_ID,
+	IFLA_XDP_HW_PROG_ID,
 	__IFLA_XDP_MAX,
 };
 
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index b6270a3b38e9..07548de5c988 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -949,6 +949,9 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
 #define KVM_CAP_HYPERV_TLBFLUSH 155
+#define KVM_CAP_S390_HPAGE_1M 156
+#define KVM_CAP_NESTED_STATE 157
+#define KVM_CAP_ARM_INJECT_SERROR_ESR 158
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1391,6 +1394,9 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_HYPERV_EVENTFD */
 #define KVM_HYPERV_EVENTFD        _IOW(KVMIO,  0xbd, struct kvm_hyperv_eventfd)
 
+/* Available with KVM_CAP_NESTED_STATE */
+#define KVM_GET_NESTED_STATE         _IOWR(KVMIO, 0xbe, struct kvm_nested_state)
+#define KVM_SET_NESTED_STATE         _IOW(KVMIO,  0xbf, struct kvm_nested_state)
 
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index eeb787b1c53c..f35eb72739c0 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -144,7 +144,7 @@ enum perf_event_sample_format {
 
 	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
 
-	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63,
+	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
 
 /*
diff --git a/tools/include/uapi/linux/vhost.h b/tools/include/uapi/linux/vhost.h
index c51f8e5cc608..84c3de89696a 100644
--- a/tools/include/uapi/linux/vhost.h
+++ b/tools/include/uapi/linux/vhost.h
@@ -65,6 +65,7 @@ struct vhost_iotlb_msg {
 };
 
 #define VHOST_IOTLB_MSG 0x1
+#define VHOST_IOTLB_MSG_V2 0x2
 
 struct vhost_msg {
 	int type;
@@ -74,6 +75,15 @@ struct vhost_msg {
 	};
 };
 
+struct vhost_msg_v2 {
+	__u32 type;
+	__u32 reserved;
+	union {
+		struct vhost_iotlb_msg iotlb;
+		__u8 padding[64];
+	};
+};
+
 struct vhost_memory_region {
 	__u64 guest_phys_addr;
 	__u64 memory_size; /* bytes */
@@ -160,6 +170,14 @@ struct vhost_memory {
 #define VHOST_GET_VRING_BUSYLOOP_TIMEOUT _IOW(VHOST_VIRTIO, 0x24,	\
 					 struct vhost_vring_state)
 
+/* Set or get vhost backend capability */
+
+/* Use message type V2 */
+#define VHOST_BACKEND_F_IOTLB_MSG_V2 0x1
+
+#define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
+#define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
+
 /* VHOST_NET specific defines */
 
 /* Attach virtio net ring to a raw socket, or tap device.
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b3d1b12a5081..5224ade3d5af 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -777,14 +777,12 @@ endif
 	$(call QUIET_INSTALL, libexec) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
 ifndef NO_LIBBPF
-	$(call QUIET_INSTALL, lib) \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'
-	$(call QUIET_INSTALL, include/bpf) \
-		$(INSTALL) include/bpf/*.h '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'
-	$(call QUIET_INSTALL, lib) \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
-	$(call QUIET_INSTALL, examples/bpf) \
-		$(INSTALL) examples/bpf/*.c '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
+	$(call QUIET_INSTALL, bpf-headers) \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'; \
+		$(INSTALL) include/bpf/*.h -t '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'
+	$(call QUIET_INSTALL, bpf-examples) \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'; \
+		$(INSTALL) examples/bpf/*.c -t '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
 endif
 	$(call QUIET_INSTALL, perf-archive) \
 		$(INSTALL) $(OUTPUT)perf-archive -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index f013b115dc86..dbef716a1913 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -11,7 +11,8 @@ PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 
 out    := $(OUTPUT)arch/arm64/include/generated/asm
 header := $(out)/syscalls.c
-sysdef := $(srctree)/tools/include/uapi/asm-generic/unistd.h
+incpath := $(srctree)/tools
+sysdef := $(srctree)/tools/arch/arm64/include/uapi/asm/unistd.h
 sysprf := $(srctree)/tools/perf/arch/arm64/entry/syscalls/
 systbl := $(sysprf)/mksyscalltbl
 
@@ -19,7 +20,7 @@ systbl := $(sysprf)/mksyscalltbl
 _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 
 $(header): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(sysdef) > $@
+	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(incpath) $(sysdef) > $@
 
 clean::
 	$(call QUIET_CLEAN, arm64) $(RM) $(header)
diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
index 52e197317d3e..2dbb8cade048 100755
--- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
@@ -11,7 +11,8 @@
 
 gcc=$1
 hostcc=$2
-input=$3
+incpath=$3
+input=$4
 
 if ! test -r $input; then
 	echo "Could not read input file" >&2
@@ -28,7 +29,6 @@ create_table_from_c()
 
 	cat <<-_EoHEADER
 		#include <stdio.h>
-		#define __ARCH_WANT_RENAMEAT
 		#include "$input"
 		int main(int argc, char *argv[])
 		{
@@ -42,7 +42,7 @@ create_table_from_c()
 	printf "%s\n" "	printf(\"#define SYSCALLTBL_ARM64_MAX_ID %d\\n\", __NR_$last_sc);"
 	printf "}\n"
 
-	} | $hostcc -o $create_table_exe -x c -
+	} | $hostcc -I $incpath/include/uapi -o $create_table_exe -x c -
 
 	$create_table_exe
 
diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 20e7d74d86cd..10a44e946f77 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -22,15 +22,16 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
 
 #endif
 
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
 int arch__choose_best_symbol(struct symbol *syma,
 			     struct symbol *symb __maybe_unused)
 {
 	char *sym = syma->name;
 
+#if !defined(_CALL_ELF) || _CALL_ELF != 2
 	/* Skip over any initial dot */
 	if (*sym == '.')
 		sym++;
+#endif
 
 	/* Avoid "SyS" kernel syscall aliases */
 	if (strlen(sym) >= 3 && !strncmp(sym, "SyS", 3))
@@ -41,6 +42,7 @@ int arch__choose_best_symbol(struct symbol *syma,
 	return SYMBOL_A;
 }
 
+#if !defined(_CALL_ELF) || _CALL_ELF != 2
 /* Allow matching against dot variants */
 int arch__compare_symbol_names(const char *namea, const char *nameb)
 {
diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
index c1bd979b957b..613709cfbbd0 100644
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@ -9,6 +9,7 @@ struct test;
 int test__rdpmc(struct test *test __maybe_unused, int subtest);
 int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest);
 int test__insn_x86(struct test *test __maybe_unused, int subtest);
+int test__bp_modify(struct test *test, int subtest);
 
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 struct thread;
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 8e2c5a38c3b9..586849ff83a0 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -5,3 +5,4 @@ libperf-y += arch-tests.o
 libperf-y += rdpmc.o
 libperf-y += perf-time-to-tsc.o
 libperf-$(CONFIG_AUXTRACE) += insn-x86.o
+libperf-$(CONFIG_X86_64) += bp-modify.o
diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
index cc1802ff5410..d47d3f8e3c8e 100644
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@ -23,6 +23,12 @@ struct test arch_tests[] = {
 		.desc = "x86 instruction decoder - new instructions",
 		.func = test__insn_x86,
 	},
+#endif
+#if defined(__x86_64__)
+	{
+		.desc = "x86 bp modify",
+		.func = test__bp_modify,
+	},
 #endif
 	{
 		.func = NULL,
diff --git a/tools/perf/arch/x86/tests/bp-modify.c b/tools/perf/arch/x86/tests/bp-modify.c
new file mode 100644
index 000000000000..f53e4406709f
--- /dev/null
+++ b/tools/perf/arch/x86/tests/bp-modify.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/user.h>
+#include <syscall.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/ptrace.h>
+#include <asm/ptrace.h>
+#include <errno.h>
+#include "debug.h"
+#include "tests/tests.h"
+#include "arch-tests.h"
+
+static noinline int bp_1(void)
+{
+	pr_debug("in %s\n", __func__);
+	return 0;
+}
+
+static noinline int bp_2(void)
+{
+	pr_debug("in %s\n", __func__);
+	return 0;
+}
+
+static int spawn_child(void)
+{
+	int child = fork();
+
+	if (child == 0) {
+		/*
+		 * The child sets itself for as tracee and
+		 * waits in signal for parent to trace it,
+		 * then it calls bp_1 and quits.
+		 */
+		int err = ptrace(PTRACE_TRACEME, 0, NULL, NULL);
+
+		if (err) {
+			pr_debug("failed to PTRACE_TRACEME\n");
+			exit(1);
+		}
+
+		raise(SIGCONT);
+		bp_1();
+		exit(0);
+	}
+
+	return child;
+}
+
+/*
+ * This tests creates HW breakpoint, tries to
+ * change it and checks it was properly changed.
+ */
+static int bp_modify1(void)
+{
+	pid_t child;
+	int status;
+	unsigned long rip = 0, dr7 = 1;
+
+	child = spawn_child();
+
+	waitpid(child, &status, 0);
+	if (WIFEXITED(status)) {
+		pr_debug("tracee exited prematurely 1\n");
+		return TEST_FAIL;
+	}
+
+	/*
+	 * The parent does following steps:
+	 *  - creates a new breakpoint (id 0) for bp_2 function
+	 *  - changes that breakponit to bp_1 function
+	 *  - waits for the breakpoint to hit and checks
+	 *    it has proper rip of bp_1 function
+	 *  - detaches the child
+	 */
+	if (ptrace(PTRACE_POKEUSER, child,
+		   offsetof(struct user, u_debugreg[0]), bp_2)) {
+		pr_debug("failed to set breakpoint, 1st time: %s\n",
+			 strerror(errno));
+		goto out;
+	}
+
+	if (ptrace(PTRACE_POKEUSER, child,
+		   offsetof(struct user, u_debugreg[0]), bp_1)) {
+		pr_debug("failed to set breakpoint, 2nd time: %s\n",
+			 strerror(errno));
+		goto out;
+	}
+
+	if (ptrace(PTRACE_POKEUSER, child,
+		   offsetof(struct user, u_debugreg[7]), dr7)) {
+		pr_debug("failed to set dr7: %s\n", strerror(errno));
+		goto out;
+	}
+
+	if (ptrace(PTRACE_CONT, child, NULL, NULL)) {
+		pr_debug("failed to PTRACE_CONT: %s\n", strerror(errno));
+		goto out;
+	}
+
+	waitpid(child, &status, 0);
+	if (WIFEXITED(status)) {
+		pr_debug("tracee exited prematurely 2\n");
+		return TEST_FAIL;
+	}
+
+	rip = ptrace(PTRACE_PEEKUSER, child,
+		     offsetof(struct user_regs_struct, rip), NULL);
+	if (rip == (unsigned long) -1) {
+		pr_debug("failed to PTRACE_PEEKUSER: %s\n",
+			 strerror(errno));
+		goto out;
+	}
+
+	pr_debug("rip %lx, bp_1 %p\n", rip, bp_1);
+
+out:
+	if (ptrace(PTRACE_DETACH, child, NULL, NULL)) {
+		pr_debug("failed to PTRACE_DETACH: %s", strerror(errno));
+		return TEST_FAIL;
+	}
+
+	return rip == (unsigned long) bp_1 ? TEST_OK : TEST_FAIL;
+}
+
+/*
+ * This tests creates HW breakpoint, tries to
+ * change it to bogus value and checks the original
+ * breakpoint is hit.
+ */
+static int bp_modify2(void)
+{
+	pid_t child;
+	int status;
+	unsigned long rip = 0, dr7 = 1;
+
+	child = spawn_child();
+
+	waitpid(child, &status, 0);
+	if (WIFEXITED(status)) {
+		pr_debug("tracee exited prematurely 1\n");
+		return TEST_FAIL;
+	}
+
+	/*
+	 * The parent does following steps:
+	 *  - creates a new breakpoint (id 0) for bp_1 function
+	 *  - tries to change that breakpoint to (-1) address
+	 *  - waits for the breakpoint to hit and checks
+	 *    it has proper rip of bp_1 function
+	 *  - detaches the child
+	 */
+	if (ptrace(PTRACE_POKEUSER, child,
+		   offsetof(struct user, u_debugreg[0]), bp_1)) {
+		pr_debug("failed to set breakpoint: %s\n",
+			 strerror(errno));
+		goto out;
+	}
+
+	if (ptrace(PTRACE_POKEUSER, child,
+		   offsetof(struct user, u_debugreg[7]), dr7)) {
+		pr_debug("failed to set dr7: %s\n", strerror(errno));
+		goto out;
+	}
+
+	if (!ptrace(PTRACE_POKEUSER, child,
+		   offsetof(struct user, u_debugreg[0]), (unsigned long) (-1))) {
+		pr_debug("failed, breakpoint set to bogus address\n");
+		goto out;
+	}
+
+	if (ptrace(PTRACE_CONT, child, NULL, NULL)) {
+		pr_debug("failed to PTRACE_CONT: %s\n", strerror(errno));
+		goto out;
+	}
+
+	waitpid(child, &status, 0);
+	if (WIFEXITED(status)) {
+		pr_debug("tracee exited prematurely 2\n");
+		return TEST_FAIL;
+	}
+
+	rip = ptrace(PTRACE_PEEKUSER, child,
+		     offsetof(struct user_regs_struct, rip), NULL);
+	if (rip == (unsigned long) -1) {
+		pr_debug("failed to PTRACE_PEEKUSER: %s\n",
+			 strerror(errno));
+		goto out;
+	}
+
+	pr_debug("rip %lx, bp_1 %p\n", rip, bp_1);
+
+out:
+	if (ptrace(PTRACE_DETACH, child, NULL, NULL)) {
+		pr_debug("failed to PTRACE_DETACH: %s", strerror(errno));
+		return TEST_FAIL;
+	}
+
+	return rip == (unsigned long) bp_1 ? TEST_OK : TEST_FAIL;
+}
+
+int test__bp_modify(struct test *test __maybe_unused,
+		    int subtest __maybe_unused)
+{
+	TEST_ASSERT_VAL("modify test 1 failed\n", !bp_modify1());
+	TEST_ASSERT_VAL("modify test 2 failed\n", !bp_modify2());
+
+	return 0;
+}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 20061cf42288..28cd6a17491b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -246,8 +246,14 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 
 indirect_call:
 	tok = strchr(endptr, '*');
-	if (tok != NULL)
-		ops->target.addr = strtoull(tok + 1, NULL, 16);
+	if (tok != NULL) {
+		endptr++;
+
+		/* Indirect call can use a non-rip register and offset: callq  *0x8(%rbx).
+		 * Do not parse such instruction.  */
+		if (strstr(endptr, "(%r") == NULL)
+			ops->target.addr = strtoull(endptr, NULL, 16);
+	}
 	goto find_target;
 }
 
@@ -276,7 +282,19 @@ bool ins__is_call(const struct ins *ins)
 	return ins->ops == &call_ops || ins->ops == &s390_call_ops;
 }
 
-static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *ops, struct map_symbol *ms)
+/*
+ * Prevents from matching commas in the comment section, e.g.:
+ * ffff200008446e70:       b.cs    ffff2000084470f4 <generic_exec_single+0x314>  // b.hs, b.nlast
+ */
+static inline const char *validate_comma(const char *c, struct ins_operands *ops)
+{
+	if (ops->raw_comment && c > ops->raw_comment)
+		return NULL;
+
+	return c;
+}
+
+static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms)
 {
 	struct map *map = ms->map;
 	struct symbol *sym = ms->sym;
@@ -285,6 +303,10 @@ static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *op
 	};
 	const char *c = strchr(ops->raw, ',');
 	u64 start, end;
+
+	ops->raw_comment = strchr(ops->raw, arch->objdump.comment_char);
+	c = validate_comma(c, ops);
+
 	/*
 	 * Examples of lines to parse for the _cpp_lex_token@@Base
 	 * function:
@@ -304,6 +326,7 @@ static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *op
 		ops->target.addr = strtoull(c, NULL, 16);
 		if (!ops->target.addr) {
 			c = strchr(c, ',');
+			c = validate_comma(c, ops);
 			if (c++ != NULL)
 				ops->target.addr = strtoull(c, NULL, 16);
 		}
@@ -361,9 +384,12 @@ static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 		return scnprintf(bf, size, "%-6s %s", ins->name, ops->target.sym->name);
 
 	c = strchr(ops->raw, ',');
+	c = validate_comma(c, ops);
+
 	if (c != NULL) {
 		const char *c2 = strchr(c + 1, ',');
 
+		c2 = validate_comma(c2, ops);
 		/* check for 3-op insn */
 		if (c2 != NULL)
 			c = c2;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 005a5fe8a8c6..5399ba2321bb 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -22,6 +22,7 @@ struct ins {
 
 struct ins_operands {
 	char	*raw;
+	char	*raw_comment;
 	struct {
 		char	*raw;
 		char	*name;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c980bbff6353..1a61628a1c12 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -251,8 +251,9 @@ struct perf_evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
 {
 	struct perf_evsel *evsel = zalloc(perf_evsel__object.size);
 
-	if (evsel != NULL)
-		perf_evsel__init(evsel, attr, idx);
+	if (!evsel)
+		return NULL;
+	perf_evsel__init(evsel, attr, idx);
 
 	if (perf_evsel__is_bpf_output(evsel)) {
 		evsel->attr.sample_type |= (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 36d0763311ef..6a6929f208b4 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -576,6 +576,13 @@ struct symbol *map_groups__find_symbol(struct map_groups *mg,
 	return NULL;
 }
 
+static bool map__contains_symbol(struct map *map, struct symbol *sym)
+{
+	u64 ip = map->unmap_ip(map, sym->start);
+
+	return ip >= map->start && ip < map->end;
+}
+
 struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
 					 struct map **mapp)
 {
@@ -591,6 +598,10 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
 
 		if (sym == NULL)
 			continue;
+		if (!map__contains_symbol(pos, sym)) {
+			sym = NULL;
+			continue;
+		}
 		if (mapp != NULL)
 			*mapp = pos;
 		goto out;
diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index c85d0d1a65ed..7b0ca7cbb7de 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -377,7 +377,7 @@ static int record_ftrace_printk(void)
 
 static int record_saved_cmdline(void)
 {
-	unsigned int size;
+	unsigned long long size;
 	char *path;
 	struct stat st;
 	int ret, err = 0;
diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index 920b1d58a068..e76214f8d596 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -164,16 +164,15 @@ void parse_ftrace_printk(struct tep_handle *pevent,
 void parse_saved_cmdline(struct tep_handle *pevent,
 			 char *file, unsigned int size __maybe_unused)
 {
-	char *comm;
+	char comm[17]; /* Max comm length in the kernel is 16. */
 	char *line;
 	char *next = NULL;
 	int pid;
 
 	line = strtok_r(file, "\n", &next);
 	while (line) {
-		sscanf(line, "%d %ms", &pid, &comm);
-		tep_register_comm(pevent, comm, pid);
-		free(comm);
+		if (sscanf(line, "%d %16s", &pid, comm) == 2)
+			tep_register_comm(pevent, comm, pid);
 		line = strtok_r(NULL, "\n", &next);
 	}
 }
