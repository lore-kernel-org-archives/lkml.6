Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BA2C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 08:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2D1252F4
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 08:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMszBj9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2D1252F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934366AbeF3Io5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 04:44:57 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:47094 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933577AbeF3Iov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 04:44:51 -0400
Received: by mail-wr0-f176.google.com with SMTP id s11-v6so1630676wra.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 01:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xASCTvTUE/kiIDQwWKpey1QRwlbnXFo7nzQfMi+qPg0=;
        b=VMszBj9q+SBCWJ9VYomePlMPgOm67yZpFIIbfkM4zvGEJoBm3Pb0rH+/KZpT5ylWQp
         pGLDo2tR9r/zg83vRLg5IvcgZMvlqL0WmWz6dcC/f4EIPIYlcaTalM+sxinYDSJe5jzy
         y9BAgNs7qxjpTgPOZp8YQQ3EbJzzVfEyxyQDlmnjT+1TzLPRUAeRdCskHhG7TjytOw+a
         6W5VW72lNmqJaTwxFfNTnF4EkqoObytRPcyeITOIcPSlQhkNMfFNDQK791rWsAeKw8+R
         F6tnq0JZcwN9ppOabOOQL1U/wvzgwYVv4V9SeULQSGnPde/Tcfhxmf7oyvIh5rxJvt5q
         ZNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=xASCTvTUE/kiIDQwWKpey1QRwlbnXFo7nzQfMi+qPg0=;
        b=JSXjTcg/78Oj0gIPFdV3Z5c27KG1yx1BpzDpJNUvSj+X2bu8gnqEKabh4H7t3Eykaf
         pNtJC52StUmDMpSUx4dKLK4lvuEVjVDjOC4bVVCEXJrHk4P2MUlC8g0Nr/5p27KEbK40
         qzVYmYx3EPmqmW0WeUrH4CKTSjyka3qYVUPJcOb5yHuidiGs+dfVB8fr3dAtx6GDW7NT
         UmX4zFK9mXqgZ/1cJbGcUxKggMD7HaNeZ+DrRHfru9eWiNc9iQPo3k7J4Vq+muSbOhCN
         cBjK9A7rFUW8ZAClPdmZkXJdYu4TGKyJvXgF/INxkF4A5nCQoBtezNP0KGhX2Wrs48lK
         CXYg==
X-Gm-Message-State: APt69E17CbuYfBb9l3W83EhdmJLodjIVI/nlEjPOXd1cf+xY0HzM9FE+
        kLdTzEoh+wBlSy5s5ib4ql0=
X-Google-Smtp-Source: AAOMgpe3rKzFsc74ilahLFTpWXSQR2rza8UXtWMje7JPLpfemamN50dmWMcEcy8MfxKAdKrY/QwMbQ==
X-Received: by 2002:adf:c7c3:: with SMTP id y3-v6mr14426256wrg.230.1530348289640;
        Sat, 30 Jun 2018 01:44:49 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h1-v6sm14501316wri.90.2018.06.30.01.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 01:44:48 -0700 (PDT)
Date:   Sat, 30 Jun 2018 10:44:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20180630084446.GA13569@gmail.com>
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

   # HEAD: 9331510135640429711afbd0c810686100824a79 perf/core: Move inline keyword at the beginning of declaration

Tooling fixes mostly, plus a build warning fix.

 Thanks,

	Ingo

------------------>
Adrian Hunter (1):
      perf intel-pt: Fix packet decoding of CYC packets

Arnaldo Carvalho de Melo (5):
      tools headers uapi: Synchronize drm/drm.h
      perf tools: Update x86's syscall_64.tbl, adding 'io_pgetevents' and 'rseq'
      tools include powerpc: Update arch/powerpc/include/uapi/asm/unistd.h copy to get 'rseq' syscall
      tools include uapi: Update if_link.h to pick IFLA_{BRPORT_ISOLATED,VXLAN_TTL_INHERIT}
      tools include uapi: Synchronize bpf.h with the kernel

Ingo Molnar (1):
      tools/headers: Pick up latest kernel ABIs

Jiri Olsa (3):
      perf tests: Add event parsing error handling to parse events test
      perf tests: Add valid callback for parse-events test
      perf bench: Fix numa report output code

Mathieu Malaterre (1):
      perf/core: Move inline keyword at the beginning of declaration

Ravi Bangoria (3):
      perf script: Add missing output fields in a hint
      perf script: Fix crash because of missing evsel->priv
      perf tools: Fix crash caused by accessing feat_ops[HEADER_LAST_FEATURE]

Sandipan Das (1):
      perf report powerpc: Fix crash if callchain is empty

Thomas Richter (5):
      perf record: Support s390 random socket_id assignment
      perf test session topology: Fix test on s390
      perf alias: Remove trailing newline when reading sysfs files
      perf alias: Rebuild alias expression string to make it comparable
      perf stat: Remove duplicate event counting

Yonghong Song (1):
      perf tools: Fix a clang 7.0 compilation error


 kernel/events/core.c                               |  2 +-
 tools/arch/arm/include/uapi/asm/kvm.h              |  1 +
 tools/arch/arm64/include/uapi/asm/kvm.h            |  1 +
 tools/arch/powerpc/include/uapi/asm/kvm.h          |  1 +
 tools/arch/powerpc/include/uapi/asm/unistd.h       |  1 +
 tools/arch/x86/include/asm/cpufeatures.h           |  2 +
 tools/include/uapi/drm/drm.h                       |  7 ++
 tools/include/uapi/linux/bpf.h                     |  2 +-
 tools/include/uapi/linux/if_link.h                 |  2 +
 tools/include/uapi/linux/kvm.h                     |  1 +
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |  2 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |  2 +
 tools/perf/bench/numa.c                            |  5 +-
 tools/perf/builtin-annotate.c                      | 11 ++-
 tools/perf/builtin-report.c                        |  3 +-
 tools/perf/builtin-script.c                        | 30 ++++++-
 tools/perf/tests/parse-events.c                    | 25 ++++--
 tools/perf/tests/topology.c                        |  1 +
 tools/perf/util/c++/clang.cpp                      | 11 ++-
 tools/perf/util/header.c                           | 12 ++-
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   |  2 +-
 tools/perf/util/pmu.c                              | 99 +++++++++++++++++++++-
 22 files changed, 201 insertions(+), 22 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80cca2b30c4f..8f0434a9951a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6482,7 +6482,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 		data->phys_addr = perf_virt_to_phys(data->addr);
 }
 
-static void __always_inline
+static __always_inline void
 __perf_event_output(struct perf_event *event,
 		    struct perf_sample_data *data,
 		    struct pt_regs *regs,
diff --git a/tools/arch/arm/include/uapi/asm/kvm.h b/tools/arch/arm/include/uapi/asm/kvm.h
index caae4843cb70..16e006f708ca 100644
--- a/tools/arch/arm/include/uapi/asm/kvm.h
+++ b/tools/arch/arm/include/uapi/asm/kvm.h
@@ -91,6 +91,7 @@ struct kvm_regs {
 #define KVM_VGIC_V3_ADDR_TYPE_DIST	2
 #define KVM_VGIC_V3_ADDR_TYPE_REDIST	3
 #define KVM_VGIC_ITS_ADDR_TYPE		4
+#define KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION	5
 
 #define KVM_VGIC_V3_DIST_SIZE		SZ_64K
 #define KVM_VGIC_V3_REDIST_SIZE		(2 * SZ_64K)
diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index 04b3256f8e6d..4e76630dd655 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -91,6 +91,7 @@ struct kvm_regs {
 #define KVM_VGIC_V3_ADDR_TYPE_DIST	2
 #define KVM_VGIC_V3_ADDR_TYPE_REDIST	3
 #define KVM_VGIC_ITS_ADDR_TYPE		4
+#define KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION	5
 
 #define KVM_VGIC_V3_DIST_SIZE		SZ_64K
 #define KVM_VGIC_V3_REDIST_SIZE		(2 * SZ_64K)
diff --git a/tools/arch/powerpc/include/uapi/asm/kvm.h b/tools/arch/powerpc/include/uapi/asm/kvm.h
index 833ed9a16adf..1b32b56a03d3 100644
--- a/tools/arch/powerpc/include/uapi/asm/kvm.h
+++ b/tools/arch/powerpc/include/uapi/asm/kvm.h
@@ -633,6 +633,7 @@ struct kvm_ppc_cpu_char {
 #define KVM_REG_PPC_PSSCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbd)
 
 #define KVM_REG_PPC_DEC_EXPIRY	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbe)
+#define KVM_REG_PPC_ONLINE	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xbf)
 
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
diff --git a/tools/arch/powerpc/include/uapi/asm/unistd.h b/tools/arch/powerpc/include/uapi/asm/unistd.h
index 389c36fd8299..ac5ba55066dd 100644
--- a/tools/arch/powerpc/include/uapi/asm/unistd.h
+++ b/tools/arch/powerpc/include/uapi/asm/unistd.h
@@ -398,5 +398,6 @@
 #define __NR_pkey_alloc		384
 #define __NR_pkey_free		385
 #define __NR_pkey_mprotect	386
+#define __NR_rseq		387
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index fb00a2fca990..5701f5cecd31 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -282,7 +282,9 @@
 #define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction Barrier */
 #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
 #define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
+#define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index 6fdff5945c8a..9c660e1688ab 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -680,6 +680,13 @@ struct drm_get_cap {
  */
 #define DRM_CLIENT_CAP_ATOMIC	3
 
+/**
+ * DRM_CLIENT_CAP_ASPECT_RATIO
+ *
+ * If set to 1, the DRM core will provide aspect ratio information in modes.
+ */
+#define DRM_CLIENT_CAP_ASPECT_RATIO    4
+
 /** DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
 struct drm_set_client_cap {
 	__u64 capability;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e0b06784f227..59b19b6a40d7 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2630,7 +2630,7 @@ struct bpf_fib_lookup {
 	union {
 		/* inputs to lookup */
 		__u8	tos;		/* AF_INET  */
-		__be32	flowlabel;	/* AF_INET6 */
+		__be32	flowinfo;	/* AF_INET6, flow_label + priority */
 
 		/* output: metric of fib result (IPv4/IPv6 only) */
 		__u32	rt_metric;
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 68699f654118..cf01b6824244 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -333,6 +333,7 @@ enum {
 	IFLA_BRPORT_BCAST_FLOOD,
 	IFLA_BRPORT_GROUP_FWD_MASK,
 	IFLA_BRPORT_NEIGH_SUPPRESS,
+	IFLA_BRPORT_ISOLATED,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
@@ -516,6 +517,7 @@ enum {
 	IFLA_VXLAN_COLLECT_METADATA,
 	IFLA_VXLAN_LABEL,
 	IFLA_VXLAN_GPE,
+	IFLA_VXLAN_TTL_INHERIT,
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 39e364c70caf..b6270a3b38e9 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -948,6 +948,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_BPB 152
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
+#define KVM_CAP_HYPERV_TLBFLUSH 155
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index 3598b8b75d27..ef5d59a5742e 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -243,7 +243,7 @@ int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
 	u64 ip;
 	u64 skip_slot = -1;
 
-	if (chain->nr < 3)
+	if (!chain || chain->nr < 3)
 		return skip_slot;
 
 	ip = chain->ips[2];
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 4dfe42666d0c..f0b1709a5ffb 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -341,6 +341,8 @@
 330	common	pkey_alloc		__x64_sys_pkey_alloc
 331	common	pkey_free		__x64_sys_pkey_free
 332	common	statx			__x64_sys_statx
+333	common	io_pgetevents		__x64_sys_io_pgetevents
+334	common	rseq			__x64_sys_rseq
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 63eb49082774..44195514b19e 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -1098,7 +1098,7 @@ static void *worker_thread(void *__tdata)
 	u8 *global_data;
 	u8 *process_data;
 	u8 *thread_data;
-	u64 bytes_done;
+	u64 bytes_done, secs;
 	long work_done;
 	u32 l;
 	struct rusage rusage;
@@ -1254,7 +1254,8 @@ static void *worker_thread(void *__tdata)
 	timersub(&stop, &start0, &diff);
 	td->runtime_ns = diff.tv_sec * NSEC_PER_SEC;
 	td->runtime_ns += diff.tv_usec * NSEC_PER_USEC;
-	td->speed_gbs = bytes_done / (td->runtime_ns / NSEC_PER_SEC) / 1e9;
+	secs = td->runtime_ns / NSEC_PER_SEC;
+	td->speed_gbs = secs ? bytes_done / secs / 1e9 : 0;
 
 	getrusage(RUSAGE_THREAD, &rusage);
 	td->system_time_ns = rusage.ru_stime.tv_sec * NSEC_PER_SEC;
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 5eb22cc56363..8180319285af 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -283,6 +283,15 @@ static int process_sample_event(struct perf_tool *tool,
 	return ret;
 }
 
+static int process_feature_event(struct perf_tool *tool,
+				 union perf_event *event,
+				 struct perf_session *session)
+{
+	if (event->feat.feat_id < HEADER_LAST_FEATURE)
+		return perf_event__process_feature(tool, event, session);
+	return 0;
+}
+
 static int hist_entry__tty_annotate(struct hist_entry *he,
 				    struct perf_evsel *evsel,
 				    struct perf_annotate *ann)
@@ -471,7 +480,7 @@ int cmd_annotate(int argc, const char **argv)
 			.attr	= perf_event__process_attr,
 			.build_id = perf_event__process_build_id,
 			.tracing_data   = perf_event__process_tracing_data,
-			.feature	= perf_event__process_feature,
+			.feature	= process_feature_event,
 			.ordered_events = true,
 			.ordering_requires_timestamps = true,
 		},
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index cdb5b6949832..c04dc7b53797 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -217,7 +217,8 @@ static int process_feature_event(struct perf_tool *tool,
 	}
 
 	/*
-	 * All features are received, we can force the
+	 * (feat_id = HEADER_LAST_FEATURE) is the end marker which
+	 * means all features are received, now we can force the
 	 * group if needed.
 	 */
 	setup_forced_leader(rep, session->evlist);
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index a31d7082188e..568ddfac3213 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1834,6 +1834,7 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	struct perf_evlist *evlist;
 	struct perf_evsel *evsel, *pos;
 	int err;
+	static struct perf_evsel_script *es;
 
 	err = perf_event__process_attr(tool, event, pevlist);
 	if (err)
@@ -1842,6 +1843,19 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	evlist = *pevlist;
 	evsel = perf_evlist__last(*pevlist);
 
+	if (!evsel->priv) {
+		if (scr->per_event_dump) {
+			evsel->priv = perf_evsel_script__new(evsel,
+						scr->session->data);
+		} else {
+			es = zalloc(sizeof(*es));
+			if (!es)
+				return -ENOMEM;
+			es->fp = stdout;
+			evsel->priv = es;
+		}
+	}
+
 	if (evsel->attr.type >= PERF_TYPE_MAX &&
 	    evsel->attr.type != PERF_TYPE_SYNTH)
 		return 0;
@@ -3030,6 +3044,15 @@ int process_cpu_map_event(struct perf_tool *tool __maybe_unused,
 	return set_maps(script);
 }
 
+static int process_feature_event(struct perf_tool *tool,
+				 union perf_event *event,
+				 struct perf_session *session)
+{
+	if (event->feat.feat_id < HEADER_LAST_FEATURE)
+		return perf_event__process_feature(tool, event, session);
+	return 0;
+}
+
 #ifdef HAVE_AUXTRACE_SUPPORT
 static int perf_script__process_auxtrace_info(struct perf_tool *tool,
 					      union perf_event *event,
@@ -3074,7 +3097,7 @@ int cmd_script(int argc, const char **argv)
 			.attr		 = process_attr,
 			.event_update   = perf_event__process_event_update,
 			.tracing_data	 = perf_event__process_tracing_data,
-			.feature	 = perf_event__process_feature,
+			.feature	 = process_feature_event,
 			.build_id	 = perf_event__process_build_id,
 			.id_index	 = perf_event__process_id_index,
 			.auxtrace_info	 = perf_script__process_auxtrace_info,
@@ -3125,8 +3148,9 @@ int cmd_script(int argc, const char **argv)
 		     "+field to add and -field to remove."
 		     "Valid types: hw,sw,trace,raw,synth. "
 		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,"
-		     "addr,symoff,period,iregs,uregs,brstack,brstacksym,flags,"
-		     "bpf-output,callindent,insn,insnlen,brstackinsn,synth,phys_addr",
+		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
+		     "brstacksym,flags,bpf-output,brstackinsn,brstackoff,"
+		     "callindent,insn,insnlen,synth,phys_addr,metric,misc",
 		     parse_output_fields),
 	OPT_BOOLEAN('a', "all-cpus", &system_wide,
 		    "system-wide collection from all CPUs"),
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 7d4077068454..61211918bfba 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1309,6 +1309,11 @@ static int test__checkevent_config_cache(struct perf_evlist *evlist)
 	return 0;
 }
 
+static bool test__intel_pt_valid(void)
+{
+	return !!perf_pmu__find("intel_pt");
+}
+
 static int test__intel_pt(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel = perf_evlist__first(evlist);
@@ -1375,6 +1380,7 @@ struct evlist_test {
 	const char *name;
 	__u32 type;
 	const int id;
+	bool (*valid)(void);
 	int (*check)(struct perf_evlist *evlist);
 };
 
@@ -1648,6 +1654,7 @@ static struct evlist_test test__events[] = {
 	},
 	{
 		.name  = "intel_pt//u",
+		.valid = test__intel_pt_valid,
 		.check = test__intel_pt,
 		.id    = 52,
 	},
@@ -1686,17 +1693,24 @@ static struct terms_test test__terms[] = {
 
 static int test_event(struct evlist_test *e)
 {
+	struct parse_events_error err = { .idx = 0, };
 	struct perf_evlist *evlist;
 	int ret;
 
+	if (e->valid && !e->valid()) {
+		pr_debug("... SKIP");
+		return 0;
+	}
+
 	evlist = perf_evlist__new();
 	if (evlist == NULL)
 		return -ENOMEM;
 
-	ret = parse_events(evlist, e->name, NULL);
+	ret = parse_events(evlist, e->name, &err);
 	if (ret) {
-		pr_debug("failed to parse event '%s', err %d\n",
-			 e->name, ret);
+		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
+			 e->name, ret, err.str);
+		parse_events_print_error(&err, e->name);
 	} else {
 		ret = e->check(evlist);
 	}
@@ -1714,10 +1728,11 @@ static int test_events(struct evlist_test *events, unsigned cnt)
 	for (i = 0; i < cnt; i++) {
 		struct evlist_test *e = &events[i];
 
-		pr_debug("running test %d '%s'\n", e->id, e->name);
+		pr_debug("running test %d '%s'", e->id, e->name);
 		ret1 = test_event(e);
 		if (ret1)
 			ret2 = ret1;
+		pr_debug("\n");
 	}
 
 	return ret2;
@@ -1799,7 +1814,7 @@ static int test_pmu_events(void)
 	}
 
 	while (!ret && (ent = readdir(dir))) {
-		struct evlist_test e;
+		struct evlist_test e = { .id = 0, };
 		char name[2 * NAME_MAX + 1 + 12 + 3];
 
 		/* Names containing . are special and cannot be used directly */
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 40e30a26b23c..9497d02f69e6 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -45,6 +45,7 @@ static int session_write_header(char *path)
 
 	perf_header__set_feat(&session->header, HEADER_CPU_TOPOLOGY);
 	perf_header__set_feat(&session->header, HEADER_NRCPUS);
+	perf_header__set_feat(&session->header, HEADER_ARCH);
 
 	session->header.data_size += DATA_SIZE;
 
diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
index bf31ceab33bd..89512504551b 100644
--- a/tools/perf/util/c++/clang.cpp
+++ b/tools/perf/util/c++/clang.cpp
@@ -146,8 +146,15 @@ getBPFObjectFromModule(llvm::Module *Module)
 	raw_svector_ostream ostream(*Buffer);
 
 	legacy::PassManager PM;
-	if (TargetMachine->addPassesToEmitFile(PM, ostream,
-					       TargetMachine::CGFT_ObjectFile)) {
+	bool NotAdded;
+#if CLANG_VERSION_MAJOR < 7
+	NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream,
+						      TargetMachine::CGFT_ObjectFile);
+#else
+	NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream, nullptr,
+						      TargetMachine::CGFT_ObjectFile);
+#endif
+	if (NotAdded) {
 		llvm::errs() << "TargetMachine can't emit a file of this type\n";
 		return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);;
 	}
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 540cd2dcd3e7..653ff65aa2c3 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2129,6 +2129,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 	int cpu_nr = ff->ph->env.nr_cpus_avail;
 	u64 size = 0;
 	struct perf_header *ph = ff->ph;
+	bool do_core_id_test = true;
 
 	ph->env.cpu = calloc(cpu_nr, sizeof(*ph->env.cpu));
 	if (!ph->env.cpu)
@@ -2183,6 +2184,13 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		return 0;
 	}
 
+	/* On s390 the socket_id number is not related to the numbers of cpus.
+	 * The socket_id number might be higher than the numbers of cpus.
+	 * This depends on the configuration.
+	 */
+	if (ph->env.arch && !strncmp(ph->env.arch, "s390", 4))
+		do_core_id_test = false;
+
 	for (i = 0; i < (u32)cpu_nr; i++) {
 		if (do_read_u32(ff, &nr))
 			goto free_cpu;
@@ -2192,7 +2200,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		if (do_read_u32(ff, &nr))
 			goto free_cpu;
 
-		if (nr != (u32)-1 && nr > (u32)cpu_nr) {
+		if (do_core_id_test && nr != (u32)-1 && nr > (u32)cpu_nr) {
 			pr_debug("socket_id number is too big."
 				 "You may need to upgrade the perf tool.\n");
 			goto free_cpu;
@@ -3456,7 +3464,7 @@ int perf_event__process_feature(struct perf_tool *tool,
 		pr_warning("invalid record type %d in pipe-mode\n", type);
 		return 0;
 	}
-	if (feat == HEADER_RESERVED || feat > HEADER_LAST_FEATURE) {
+	if (feat == HEADER_RESERVED || feat >= HEADER_LAST_FEATURE) {
 		pr_warning("invalid record type %d in pipe-mode\n", type);
 		return -1;
 	}
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
index ba4c9dd18643..d426761a549d 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
@@ -366,7 +366,7 @@ static int intel_pt_get_cyc(unsigned int byte, const unsigned char *buf,
 		if (len < offs)
 			return INTEL_PT_NEED_MORE_BYTES;
 		byte = buf[offs++];
-		payload |= (byte >> 1) << shift;
+		payload |= ((uint64_t)byte >> 1) << shift;
 	}
 
 	packet->type = INTEL_PT_CYC;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d2fb597c9a8c..3ba6a1742f91 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -234,6 +234,74 @@ static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
 	return 0;
 }
 
+static void perf_pmu_assign_str(char *name, const char *field, char **old_str,
+				char **new_str)
+{
+	if (!*old_str)
+		goto set_new;
+
+	if (*new_str) {	/* Have new string, check with old */
+		if (strcasecmp(*old_str, *new_str))
+			pr_debug("alias %s differs in field '%s'\n",
+				 name, field);
+		zfree(old_str);
+	} else		/* Nothing new --> keep old string */
+		return;
+set_new:
+	*old_str = *new_str;
+	*new_str = NULL;
+}
+
+static void perf_pmu_update_alias(struct perf_pmu_alias *old,
+				  struct perf_pmu_alias *newalias)
+{
+	perf_pmu_assign_str(old->name, "desc", &old->desc, &newalias->desc);
+	perf_pmu_assign_str(old->name, "long_desc", &old->long_desc,
+			    &newalias->long_desc);
+	perf_pmu_assign_str(old->name, "topic", &old->topic, &newalias->topic);
+	perf_pmu_assign_str(old->name, "metric_expr", &old->metric_expr,
+			    &newalias->metric_expr);
+	perf_pmu_assign_str(old->name, "metric_name", &old->metric_name,
+			    &newalias->metric_name);
+	perf_pmu_assign_str(old->name, "value", &old->str, &newalias->str);
+	old->scale = newalias->scale;
+	old->per_pkg = newalias->per_pkg;
+	old->snapshot = newalias->snapshot;
+	memcpy(old->unit, newalias->unit, sizeof(old->unit));
+}
+
+/* Delete an alias entry. */
+static void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
+{
+	zfree(&newalias->name);
+	zfree(&newalias->desc);
+	zfree(&newalias->long_desc);
+	zfree(&newalias->topic);
+	zfree(&newalias->str);
+	zfree(&newalias->metric_expr);
+	zfree(&newalias->metric_name);
+	parse_events_terms__purge(&newalias->terms);
+	free(newalias);
+}
+
+/* Merge an alias, search in alias list. If this name is already
+ * present merge both of them to combine all information.
+ */
+static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
+				 struct list_head *alist)
+{
+	struct perf_pmu_alias *a;
+
+	list_for_each_entry(a, alist, list) {
+		if (!strcasecmp(newalias->name, a->name)) {
+			perf_pmu_update_alias(a, newalias);
+			perf_pmu_free_alias(newalias);
+			return true;
+		}
+	}
+	return false;
+}
+
 static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 				 char *desc, char *val,
 				 char *long_desc, char *topic,
@@ -241,9 +309,11 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 				 char *metric_expr,
 				 char *metric_name)
 {
+	struct parse_events_term *term;
 	struct perf_pmu_alias *alias;
 	int ret;
 	int num;
+	char newval[256];
 
 	alias = malloc(sizeof(*alias));
 	if (!alias)
@@ -262,6 +332,27 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 		return ret;
 	}
 
+	/* Scan event and remove leading zeroes, spaces, newlines, some
+	 * platforms have terms specified as
+	 * event=0x0091 (read from files ../<PMU>/events/<FILE>
+	 * and terms specified as event=0x91 (read from JSON files).
+	 *
+	 * Rebuild string to make alias->str member comparable.
+	 */
+	memset(newval, 0, sizeof(newval));
+	ret = 0;
+	list_for_each_entry(term, &alias->terms, list) {
+		if (ret)
+			ret += scnprintf(newval + ret, sizeof(newval) - ret,
+					 ",");
+		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
+			ret += scnprintf(newval + ret, sizeof(newval) - ret,
+					 "%s=%#x", term->config, term->val.num);
+		else if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
+			ret += scnprintf(newval + ret, sizeof(newval) - ret,
+					 "%s=%s", term->config, term->val.str);
+	}
+
 	alias->name = strdup(name);
 	if (dir) {
 		/*
@@ -285,9 +376,10 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
 	}
 	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
-	alias->str = strdup(val);
+	alias->str = strdup(newval);
 
-	list_add_tail(&alias->list, list);
+	if (!perf_pmu_merge_alias(alias, list))
+		list_add_tail(&alias->list, list);
 
 	return 0;
 }
@@ -303,6 +395,9 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
 
 	buf[ret] = 0;
 
+	/* Remove trailing newline from sysfs file */
+	rtrim(buf);
+
 	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL, NULL, NULL,
 				     NULL, NULL, NULL);
 }

