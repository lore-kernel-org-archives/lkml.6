Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 83FD7C5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B503205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B503205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965245AbeFNXyP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 19:54:15 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:55382 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965121AbeFNXyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 19:54:12 -0400
Received: from mipsdag01.mipstec.com (mail1.mips.com [12.201.5.31]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Thu, 14 Jun 2018 23:53:54 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag01.mipstec.com
 (10.20.40.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Thu, 14
 Jun 2018 16:53:09 -0700
Received: from pburton-laptop.mipstec.com (10.20.2.29) by
 mipsdag02.mipstec.com (10.20.40.47) with Microsoft SMTP Server id 15.1.1415.2
 via Frontend Transport; Thu, 14 Jun 2018 16:53:09 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        James Hogan <jhogan@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH 4/4] rseq/selftests: Implement MIPS support
Date:   Thu, 14 Jun 2018 16:52:10 -0700
Message-ID: <20180614235211.31357-5-paul.burton@mips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614235211.31357-1-paul.burton@mips.com>
References: <20180614235211.31357-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1529020407-321459-9504-17803-2
X-BESS-VER: 2018.7-r1806112253
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194071
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: linux-mips@linux-mips.org,peterz@infradead.org,jhogan@kernel.org,linux-kernel@vger.kernel.org,mathieu.desnoyers@efficios.com,boqun.feng@gmail.com,paulmck@linux.vnet.ibm.com,ralf@linux-mips.org
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for both MIPS32 & MIPS64 in the rseq selftests, in
order to sanity check the recently enabled rseq syscall.

The tests all pass on a MIPS Boston development board running either a
MIPS32r2 interAptiv CPU & a MIPS64r6 I6500 CPU, both of which were
configured with 2 cores each of which have 2 hardware threads (VP(E)s) -
ie. 4 CPUs.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org

---

 tools/testing/selftests/rseq/param_test.c |  24 +
 tools/testing/selftests/rseq/rseq-mips.h  | 725 ++++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h       |   2 +
 3 files changed, 751 insertions(+)
 create mode 100644 tools/testing/selftests/rseq/rseq-mips.h

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 6a9f602a8718..615252331813 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -137,6 +137,30 @@ unsigned int yield_mod_cnt, nr_abort;
 	"subic. %%" INJECT_ASM_REG ", %%" INJECT_ASM_REG ", 1\n\t" \
 	"bne 222b\n\t" \
 	"333:\n\t"
+
+#elif defined(__mips__)
+
+#define RSEQ_INJECT_INPUT \
+	, [loop_cnt_1]"m"(loop_cnt[1]) \
+	, [loop_cnt_2]"m"(loop_cnt[2]) \
+	, [loop_cnt_3]"m"(loop_cnt[3]) \
+	, [loop_cnt_4]"m"(loop_cnt[4]) \
+	, [loop_cnt_5]"m"(loop_cnt[5]) \
+	, [loop_cnt_6]"m"(loop_cnt[6])
+
+#define INJECT_ASM_REG	"$5"
+
+#define RSEQ_INJECT_CLOBBER \
+	, INJECT_ASM_REG
+
+#define RSEQ_INJECT_ASM(n) \
+	"lw " INJECT_ASM_REG ", %[loop_cnt_" #n "]\n\t" \
+	"beqz " INJECT_ASM_REG ", 333f\n\t" \
+	"222:\n\t" \
+	"addiu " INJECT_ASM_REG ", -1\n\t" \
+	"bnez " INJECT_ASM_REG ", 222b\n\t" \
+	"333:\n\t"
+
 #else
 #error unsupported target
 #endif
diff --git a/tools/testing/selftests/rseq/rseq-mips.h b/tools/testing/selftests/rseq/rseq-mips.h
new file mode 100644
index 000000000000..63131352fbdd
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-mips.h
@@ -0,0 +1,725 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Author: Paul Burton <paul.burton@mips.com>
+ * (C) Copyright 2018 MIPS Tech LLC
+ *
+ * Based on rseq-arm.h:
+ * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#define RSEQ_SIG	0x53053053
+
+#define rseq_smp_mb()	__asm__ __volatile__ ("sync" ::: "memory")
+#define rseq_smp_rmb()	rseq_smp_mb()
+#define rseq_smp_wmb()	rseq_smp_mb()
+
+#define rseq_smp_load_acquire(p)					\
+__extension__ ({							\
+	__typeof(*p) ____p1 = RSEQ_READ_ONCE(*p);			\
+	rseq_smp_mb();							\
+	____p1;								\
+})
+
+#define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_rmb()
+
+#define rseq_smp_store_release(p, v)					\
+do {									\
+	rseq_smp_mb();							\
+	RSEQ_WRITE_ONCE(*p, v);						\
+} while (0)
+
+#ifdef RSEQ_SKIP_FASTPATH
+#include "rseq-skip.h"
+#else /* !RSEQ_SKIP_FASTPATH */
+
+#if _MIPS_SZLONG == 64
+# define LONG			".dword"
+# define LONG_LA		"dla"
+# define LONG_L			"ld"
+# define LONG_S			"sd"
+# define LONG_ADDI		"daddiu"
+# define U32_U64_PAD(x)		x
+#elif _MIPS_SZLONG == 32
+# define LONG			".word"
+# define LONG_LA		"la"
+# define LONG_L			"lw"
+# define LONG_S			"sw"
+# define LONG_ADDI		"addiu"
+# ifdef __BIG_ENDIAN
+#  define U32_U64_PAD(x)	"0x0, " x
+# else
+#  define U32_U64_PAD(x)	x ", 0x0"
+# endif
+#else
+# error unsupported _MIPS_SZLONG
+#endif
+
+#define __RSEQ_ASM_DEFINE_TABLE(version, flags,	start_ip,			\
+				post_commit_offset, abort_ip)			\
+		".pushsection __rseq_table, \"aw\"\n\t"				\
+		".balign 32\n\t"						\
+		".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t"	\
+		LONG " " U32_U64_PAD(__rseq_str(start_ip)) "\n\t"		\
+		LONG " " U32_U64_PAD(__rseq_str(post_commit_offset)) "\n\t"	\
+		LONG " " U32_U64_PAD(__rseq_str(abort_ip)) "\n\t"		\
+		".popsection\n\t"
+
+#define RSEQ_ASM_DEFINE_TABLE(start_ip, post_commit_ip, abort_ip)		\
+	__RSEQ_ASM_DEFINE_TABLE(0x0, 0x0, start_ip,				\
+				(post_commit_ip - start_ip), abort_ip)
+
+#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)			\
+		RSEQ_INJECT_ASM(1)						\
+		LONG_LA " $4, " __rseq_str(cs_label) "\n\t"			\
+		LONG_S  " $4, %[" __rseq_str(rseq_cs) "]\n\t"			\
+		__rseq_str(label) ":\n\t"
+
+#define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)			\
+		RSEQ_INJECT_ASM(2)						\
+		"lw  $4, %[" __rseq_str(current_cpu_id) "]\n\t"			\
+		"bne $4, %[" __rseq_str(cpu_id) "], " __rseq_str(label) "\n\t"
+
+#define __RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown,			\
+				abort_label, version, flags,			\
+				start_ip, post_commit_offset, abort_ip)		\
+		".balign 32\n\t"						\
+		__rseq_str(table_label) ":\n\t"					\
+		".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t"	\
+		LONG " " U32_U64_PAD(__rseq_str(start_ip)) "\n\t"		\
+		LONG " " U32_U64_PAD(__rseq_str(post_commit_offset)) "\n\t"	\
+		LONG " " U32_U64_PAD(__rseq_str(abort_ip)) "\n\t"		\
+		".word " __rseq_str(RSEQ_SIG) "\n\t"				\
+		__rseq_str(label) ":\n\t"					\
+		teardown							\
+		"b %l[" __rseq_str(abort_label) "]\n\t"
+
+#define RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown, abort_label,	\
+			      start_ip, post_commit_ip, abort_ip)		\
+	__RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown,			\
+				abort_label, 0x0, 0x0, start_ip,		\
+				(post_commit_ip - start_ip), abort_ip)
+
+#define RSEQ_ASM_DEFINE_CMPFAIL(label, teardown, cmpfail_label)			\
+		__rseq_str(label) ":\n\t"					\
+		teardown							\
+		"b %l[" __rseq_str(cmpfail_label) "]\n\t"
+
+#define rseq_workaround_gcc_asm_size_guess()	__asm__ __volatile__("")
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	rseq_workaround_gcc_asm_size_guess();
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[error2]\n\t"
+#endif
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_workaround_gcc_asm_size_guess();
+	return 0;
+abort:
+	rseq_workaround_gcc_asm_size_guess();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_workaround_gcc_asm_size_guess();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
+			       off_t voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	rseq_workaround_gcc_asm_size_guess();
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $4, %[v]\n\t"
+		"beq $4, %[expectnot], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_L " $4, %[v]\n\t"
+		"beq $4, %[expectnot], %l[error2]\n\t"
+#endif
+		LONG_S " $4, %[load]\n\t"
+		LONG_ADDI " $4, %[voffp]\n\t"
+		LONG_L " $4, 0($4)\n\t"
+		/* final store */
+		LONG_S " $4, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [voffp]		"Ir" (voffp),
+		  [load]		"m" (*load)
+		  RSEQ_INJECT_INPUT
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_workaround_gcc_asm_size_guess();
+	return 0;
+abort:
+	rseq_workaround_gcc_asm_size_guess();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_workaround_gcc_asm_size_guess();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_addv(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	rseq_workaround_gcc_asm_size_guess();
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+#endif
+		LONG_L " $4, %[v]\n\t"
+		LONG_ADDI " $4, %[count]\n\t"
+		/* final store */
+		LONG_S " $4, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [v]			"m" (*v),
+		  [count]		"Ir" (count)
+		  RSEQ_INJECT_INPUT
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	rseq_workaround_gcc_asm_size_guess();
+	return 0;
+abort:
+	rseq_workaround_gcc_asm_size_guess();
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	rseq_workaround_gcc_asm_size_guess();
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[error2]\n\t"
+#endif
+		/* try store */
+		LONG_S " %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_workaround_gcc_asm_size_guess();
+	return 0;
+abort:
+	rseq_workaround_gcc_asm_size_guess();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_workaround_gcc_asm_size_guess();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
+					 intptr_t *v2, intptr_t newv2,
+					 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	rseq_workaround_gcc_asm_size_guess();
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[error2]\n\t"
+#endif
+		/* try store */
+		LONG_S " %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+		"sync\n\t"	/* full sync provides store-release */
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_workaround_gcc_asm_size_guess();
+	return 0;
+abort:
+	rseq_workaround_gcc_asm_size_guess();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_workaround_gcc_asm_size_guess();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	rseq_workaround_gcc_asm_size_guess();
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+		LONG_L " $4, %[v2]\n\t"
+		"bne $4, %[expect2], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], %l[error2]\n\t"
+		LONG_L " $4, %[v2]\n\t"
+		"bne $4, %[expect2], %l[error3]\n\t"
+#endif
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* cmp2 input */
+		  [v2]			"m" (*v2),
+		  [expect2]		"r" (expect2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2, error3
+#endif
+	);
+	rseq_workaround_gcc_asm_size_guess();
+	return 0;
+abort:
+	rseq_workaround_gcc_asm_size_guess();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_workaround_gcc_asm_size_guess();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("1st expected value comparison failed");
+error3:
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	uintptr_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	rseq_workaround_gcc_asm_size_guess();
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		LONG_S " %[src], %[rseq_scratch0]\n\t"
+		LONG_S "  %[dst], %[rseq_scratch1]\n\t"
+		LONG_S " %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], 7f\n\t"
+#endif
+		/* try memcpy */
+		"beqz %[len], 333f\n\t" \
+		"222:\n\t" \
+		"lb   $4, 0(%[src])\n\t" \
+		"sb   $4, 0(%[dst])\n\t" \
+		LONG_ADDI " %[src], 1\n\t" \
+		LONG_ADDI " %[dst], 1\n\t" \
+		LONG_ADDI " %[len], -1\n\t" \
+		"bnez %[len], 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		LONG_L " %[len], %[rseq_scratch2]\n\t"
+		LONG_L " %[dst], %[rseq_scratch1]\n\t"
+		LONG_L " %[src], %[rseq_scratch0]\n\t"
+		"b 8f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4,
+				      /* teardown */
+				      LONG_L " %[len], %[rseq_scratch2]\n\t"
+				      LONG_L " %[dst], %[rseq_scratch1]\n\t"
+				      LONG_L " %[src], %[rseq_scratch0]\n\t",
+				      abort, 1b, 2b, 4f)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+					/* teardown */
+					LONG_L " %[len], %[rseq_scratch2]\n\t"
+					LONG_L " %[dst], %[rseq_scratch1]\n\t"
+					LONG_L " %[src], %[rseq_scratch0]\n\t",
+					cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+					/* teardown */
+					LONG_L " %[len], %[rseq_scratch2]\n\t"
+					LONG_L " %[dst], %[rseq_scratch1]\n\t"
+					LONG_L " %[src], %[rseq_scratch0]\n\t",
+					error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+					/* teardown */
+					LONG_L " %[len], %[rseq_scratch2]\n\t"
+					LONG_L " %[dst], %[rseq_scratch1]\n\t"
+					LONG_L " %[src], %[rseq_scratch0]\n\t",
+					error2)
+#endif
+		"8:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len),
+		  [rseq_scratch0]	"m" (rseq_scratch[0]),
+		  [rseq_scratch1]	"m" (rseq_scratch[1]),
+		  [rseq_scratch2]	"m" (rseq_scratch[2])
+		  RSEQ_INJECT_INPUT
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_workaround_gcc_asm_size_guess();
+	return 0;
+abort:
+	rseq_workaround_gcc_asm_size_guess();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_workaround_gcc_asm_size_guess();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_workaround_gcc_asm_size_guess();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_workaround_gcc_asm_size_guess();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
+					 void *dst, void *src, size_t len,
+					 intptr_t newv, int cpu)
+{
+	uintptr_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	rseq_workaround_gcc_asm_size_guess();
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		LONG_S " %[src], %[rseq_scratch0]\n\t"
+		LONG_S " %[dst], %[rseq_scratch1]\n\t"
+		LONG_S " %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		LONG_L " $4, %[v]\n\t"
+		"bne $4, %[expect], 7f\n\t"
+#endif
+		/* try memcpy */
+		"beqz %[len], 333f\n\t" \
+		"222:\n\t" \
+		"lb   $4, 0(%[src])\n\t" \
+		"sb   $4, 0(%[dst])\n\t" \
+		LONG_ADDI " %[src], 1\n\t" \
+		LONG_ADDI " %[dst], 1\n\t" \
+		LONG_ADDI " %[len], -1\n\t" \
+		"bnez %[len], 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+		"sync\n\t"	/* full sync provides store-release */
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		LONG_L " %[len], %[rseq_scratch2]\n\t"
+		LONG_L " %[dst], %[rseq_scratch1]\n\t"
+		LONG_L " %[src], %[rseq_scratch0]\n\t"
+		"b 8f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4,
+				      /* teardown */
+				      LONG_L " %[len], %[rseq_scratch2]\n\t"
+				      LONG_L " %[dst], %[rseq_scratch1]\n\t"
+				      LONG_L " %[src], %[rseq_scratch0]\n\t",
+				      abort, 1b, 2b, 4f)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+					/* teardown */
+					LONG_L " %[len], %[rseq_scratch2]\n\t"
+					LONG_L " %[dst], %[rseq_scratch1]\n\t"
+					LONG_L " %[src], %[rseq_scratch0]\n\t",
+					cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+					/* teardown */
+					LONG_L " %[len], %[rseq_scratch2]\n\t"
+					LONG_L " %[dst], %[rseq_scratch1]\n\t"
+					LONG_L " %[src], %[rseq_scratch0]\n\t",
+					error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+					/* teardown */
+					LONG_L " %[len], %[rseq_scratch2]\n\t"
+					LONG_L " %[dst], %[rseq_scratch1]\n\t"
+					LONG_L " %[src], %[rseq_scratch0]\n\t",
+					error2)
+#endif
+		"8:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len),
+		  [rseq_scratch0]	"m" (rseq_scratch[0]),
+		  [rseq_scratch1]	"m" (rseq_scratch[1]),
+		  [rseq_scratch2]	"m" (rseq_scratch[2])
+		  RSEQ_INJECT_INPUT
+		: "$4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_workaround_gcc_asm_size_guess();
+	return 0;
+abort:
+	rseq_workaround_gcc_asm_size_guess();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_workaround_gcc_asm_size_guess();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_workaround_gcc_asm_size_guess();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_workaround_gcc_asm_size_guess();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 0a808575cbc4..a4684112676c 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -73,6 +73,8 @@ extern __thread volatile struct rseq __rseq_abi;
 #include <rseq-arm.h>
 #elif defined(__PPC__)
 #include <rseq-ppc.h>
+#elif defined(__mips__)
+#include <rseq-mips.h>
 #else
 #error unsupported target
 #endif
-- 
2.17.1

