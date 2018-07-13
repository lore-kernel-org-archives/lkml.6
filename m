Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76729ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096F02087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXCHdK1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096F02087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbeGMSjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:39:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55787 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbeGMSjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:39:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id v128-v6so9573616wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 11:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OYiECiHvf6jnZ2Nce9Bn8iLaZvBXz/ObLpsD7CouCLg=;
        b=bXCHdK1fB7L/lEwBFZGoeNmJFwvHlS/j18VC2pBa501oU/yUUEtsd1C17jnFK77yBW
         82NN/IB+TQIEklpNroFYwz1xjejdRBNYXgYlw3RPccOgzvyzfNjce6li+Ea7tdEEx1+/
         +P3cSxHdtkGKZIU4biHscs40jqcDTuXxMRtPsvbnzjMlHyxzWX6EckmPTp9l8RXwozhx
         +/PW4mo+uSosyQMtpFxLc7Y5IjteILtHcdMI5DRXAcOTpga3/zyBRJTQ4QPF39Jq/Cl7
         QQ3KCylDJt/wXiDhhQa62HZnrVMb1SfPyZ30Hr2WxAAchDXNlafEXy2SsZR1TMm63KsL
         gvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=OYiECiHvf6jnZ2Nce9Bn8iLaZvBXz/ObLpsD7CouCLg=;
        b=SwdT9nb6MlSBa/2rRGvmSBJI4vCNtMnQxfPkpRKVlr/b0XSlyuveIRkbZNiukxcAHD
         y1YcnErSu4S8wvGeaCXXZ5EBhn3IwRMPmlolPoSGyTSNNvkkGP4idQ3+OfWvq2eti6Z+
         bJ1GEKL//0d6HmdBzqTYjKwCjpRCC+61lzNZmg1gMGhwA3RedYGIFlRcWf1aiOQacEbH
         v7yIQfKBzML6Ne4vqzlUYoONJ1sltUbqRT2QwUcdtn/p8ttAA9GAQ7a8GwimmWuVQWAX
         VdfU4Ko0bwg0bD+WDkTNKhknovF7nbpMH04LNEHenXUMGhQnaMWqETj92a/ZvAqV5ObT
         JO6A==
X-Gm-Message-State: AOUpUlFzgRATRVW67FzwcLfLeLe9EMRLTmFmnSNS9Fp4AHaqLwmmzEas
        +cP2PRICKmV4/+a35ZC5pyLKWQ==
X-Google-Smtp-Source: AAOMgpdc9o8ESoX0wfXux95bk1Rc6FQkf+SQoCU5wsfRUAJFH4jZI+3YxzXzLwbM/mRCQDMX630j8g==
X-Received: by 2002:a1c:9809:: with SMTP id a9-v6mr4302940wme.15.1531506224387;
        Fri, 13 Jul 2018 11:23:44 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r7-v6sm22874871wrn.83.2018.07.13.11.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 11:23:43 -0700 (PDT)
Date:   Fri, 13 Jul 2018 20:23:41 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] rseq fixes
Message-ID: <20180713182341.GA21882@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

   # HEAD: 8a46580128a02bdc18d7dcc0cba19d3cea4fb9c4 rseq/selftests: cleanup: Update comment above rseq_prepare_unload

Various rseq ABI fixes and cleanups: use get_user()/put_user(), validate 
parameters and use proper uapi types, etc.

 Thanks,

	Ingo

------------------>
Mathieu Desnoyers (6):
      rseq: Use __u64 for rseq_cs fields, validate user inputs
      rseq: Use get_user/put_user rather than __get_user/__put_user
      rseq: uapi: Update uapi comments
      rseq: uapi: Declare rseq_cs field as union, update includes
      rseq: Remove unused types_32_64.h uapi header
      rseq/selftests: cleanup: Update comment above rseq_prepare_unload


 include/uapi/linux/rseq.h           | 102 ++++++++++++++++++++----------------
 include/uapi/linux/types_32_64.h    |  50 ------------------
 kernel/rseq.c                       |  41 +++++++++------
 tools/testing/selftests/rseq/rseq.h |  24 ++++++---
 4 files changed, 100 insertions(+), 117 deletions(-)
 delete mode 100644 include/uapi/linux/types_32_64.h

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index d620fa43756c..9a402fdb60e9 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -10,13 +10,8 @@
  * Copyright (c) 2015-2018 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
-#ifdef __KERNEL__
-# include <linux/types.h>
-#else
-# include <stdint.h>
-#endif
-
-#include <linux/types_32_64.h>
+#include <linux/types.h>
+#include <asm/byteorder.h>
 
 enum rseq_cpu_id_state {
 	RSEQ_CPU_ID_UNINITIALIZED		= -1,
@@ -52,10 +47,10 @@ struct rseq_cs {
 	__u32 version;
 	/* enum rseq_cs_flags */
 	__u32 flags;
-	LINUX_FIELD_u32_u64(start_ip);
+	__u64 start_ip;
 	/* Offset from start_ip. */
-	LINUX_FIELD_u32_u64(post_commit_offset);
-	LINUX_FIELD_u32_u64(abort_ip);
+	__u64 post_commit_offset;
+	__u64 abort_ip;
 } __attribute__((aligned(4 * sizeof(__u64))));
 
 /*
@@ -67,28 +62,30 @@ struct rseq_cs {
 struct rseq {
 	/*
 	 * Restartable sequences cpu_id_start field. Updated by the
-	 * kernel, and read by user-space with single-copy atomicity
-	 * semantics. Aligned on 32-bit. Always contains a value in the
-	 * range of possible CPUs, although the value may not be the
-	 * actual current CPU (e.g. if rseq is not initialized). This
-	 * CPU number value should always be compared against the value
-	 * of the cpu_id field before performing a rseq commit or
-	 * returning a value read from a data structure indexed using
-	 * the cpu_id_start value.
+	 * kernel. Read by user-space with single-copy atomicity
+	 * semantics. This field should only be read by the thread which
+	 * registered this data structure. Aligned on 32-bit. Always
+	 * contains a value in the range of possible CPUs, although the
+	 * value may not be the actual current CPU (e.g. if rseq is not
+	 * initialized). This CPU number value should always be compared
+	 * against the value of the cpu_id field before performing a rseq
+	 * commit or returning a value read from a data structure indexed
+	 * using the cpu_id_start value.
 	 */
 	__u32 cpu_id_start;
 	/*
-	 * Restartable sequences cpu_id field. Updated by the kernel,
-	 * and read by user-space with single-copy atomicity semantics.
-	 * Aligned on 32-bit. Values RSEQ_CPU_ID_UNINITIALIZED and
-	 * RSEQ_CPU_ID_REGISTRATION_FAILED have a special semantic: the
-	 * former means "rseq uninitialized", and latter means "rseq
-	 * initialization failed". This value is meant to be read within
-	 * rseq critical sections and compared with the cpu_id_start
-	 * value previously read, before performing the commit instruction,
-	 * or read and compared with the cpu_id_start value before returning
-	 * a value loaded from a data structure indexed using the
-	 * cpu_id_start value.
+	 * Restartable sequences cpu_id field. Updated by the kernel.
+	 * Read by user-space with single-copy atomicity semantics. This
+	 * field should only be read by the thread which registered this
+	 * data structure. Aligned on 32-bit. Values
+	 * RSEQ_CPU_ID_UNINITIALIZED and RSEQ_CPU_ID_REGISTRATION_FAILED
+	 * have a special semantic: the former means "rseq uninitialized",
+	 * and latter means "rseq initialization failed". This value is
+	 * meant to be read within rseq critical sections and compared
+	 * with the cpu_id_start value previously read, before performing
+	 * the commit instruction, or read and compared with the
+	 * cpu_id_start value before returning a value loaded from a data
+	 * structure indexed using the cpu_id_start value.
 	 */
 	__u32 cpu_id;
 	/*
@@ -105,27 +102,44 @@ struct rseq {
 	 * targeted by the rseq_cs. Also needs to be set to NULL by user-space
 	 * before reclaiming memory that contains the targeted struct rseq_cs.
 	 *
-	 * Read and set by the kernel with single-copy atomicity semantics.
-	 * Set by user-space with single-copy atomicity semantics. Aligned
-	 * on 64-bit.
+	 * Read and set by the kernel. Set by user-space with single-copy
+	 * atomicity semantics. This field should only be updated by the
+	 * thread which registered this data structure. Aligned on 64-bit.
 	 */
-	LINUX_FIELD_u32_u64(rseq_cs);
+	union {
+		__u64 ptr64;
+#ifdef __LP64__
+		__u64 ptr;
+#else
+		struct {
+#if (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || defined(__BIG_ENDIAN)
+			__u32 padding;		/* Initialized to zero. */
+			__u32 ptr32;
+#else /* LITTLE */
+			__u32 ptr32;
+			__u32 padding;		/* Initialized to zero. */
+#endif /* ENDIAN */
+		} ptr;
+#endif
+	} rseq_cs;
+
 	/*
-	 * - RSEQ_DISABLE flag:
+	 * Restartable sequences flags field.
+	 *
+	 * This field should only be updated by the thread which
+	 * registered this data structure. Read by the kernel.
+	 * Mainly used for single-stepping through rseq critical sections
+	 * with debuggers.
 	 *
-	 * Fallback fast-track flag for single-stepping.
-	 * Set by user-space if lack of progress is detected.
-	 * Cleared by user-space after rseq finish.
-	 * Read by the kernel.
 	 * - RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
-	 *     Inhibit instruction sequence block restart and event
-	 *     counter increment on preemption for this thread.
+	 *     Inhibit instruction sequence block restart on preemption
+	 *     for this thread.
 	 * - RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
-	 *     Inhibit instruction sequence block restart and event
-	 *     counter increment on signal delivery for this thread.
+	 *     Inhibit instruction sequence block restart on signal
+	 *     delivery for this thread.
 	 * - RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
-	 *     Inhibit instruction sequence block restart and event
-	 *     counter increment on migration for this thread.
+	 *     Inhibit instruction sequence block restart on migration for
+	 *     this thread.
 	 */
 	__u32 flags;
 } __attribute__((aligned(4 * sizeof(__u64))));
diff --git a/include/uapi/linux/types_32_64.h b/include/uapi/linux/types_32_64.h
deleted file mode 100644
index 0a87ace34a57..000000000000
--- a/include/uapi/linux/types_32_64.h
+++ /dev/null
@@ -1,50 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
-#ifndef _UAPI_LINUX_TYPES_32_64_H
-#define _UAPI_LINUX_TYPES_32_64_H
-
-/*
- * linux/types_32_64.h
- *
- * Integer type declaration for pointers across 32-bit and 64-bit systems.
- *
- * Copyright (c) 2015-2018 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
- */
-
-#ifdef __KERNEL__
-# include <linux/types.h>
-#else
-# include <stdint.h>
-#endif
-
-#include <asm/byteorder.h>
-
-#ifdef __BYTE_ORDER
-# if (__BYTE_ORDER == __BIG_ENDIAN)
-#  define LINUX_BYTE_ORDER_BIG_ENDIAN
-# else
-#  define LINUX_BYTE_ORDER_LITTLE_ENDIAN
-# endif
-#else
-# ifdef __BIG_ENDIAN
-#  define LINUX_BYTE_ORDER_BIG_ENDIAN
-# else
-#  define LINUX_BYTE_ORDER_LITTLE_ENDIAN
-# endif
-#endif
-
-#ifdef __LP64__
-# define LINUX_FIELD_u32_u64(field)			__u64 field
-# define LINUX_FIELD_u32_u64_INIT_ONSTACK(field, v)	field = (intptr_t)v
-#else
-# ifdef LINUX_BYTE_ORDER_BIG_ENDIAN
-#  define LINUX_FIELD_u32_u64(field)	__u32 field ## _padding, field
-#  define LINUX_FIELD_u32_u64_INIT_ONSTACK(field, v)	\
-	field ## _padding = 0, field = (intptr_t)v
-# else
-#  define LINUX_FIELD_u32_u64(field)	__u32 field, field ## _padding
-#  define LINUX_FIELD_u32_u64_INIT_ONSTACK(field, v)	\
-	field = (intptr_t)v, field ## _padding = 0
-# endif
-#endif
-
-#endif /* _UAPI_LINUX_TYPES_32_64_H */
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 22b6acf1ad63..c6242d8594dc 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -85,9 +85,9 @@ static int rseq_update_cpu_id(struct task_struct *t)
 {
 	u32 cpu_id = raw_smp_processor_id();
 
-	if (__put_user(cpu_id, &t->rseq->cpu_id_start))
+	if (put_user(cpu_id, &t->rseq->cpu_id_start))
 		return -EFAULT;
-	if (__put_user(cpu_id, &t->rseq->cpu_id))
+	if (put_user(cpu_id, &t->rseq->cpu_id))
 		return -EFAULT;
 	trace_rseq_update(t);
 	return 0;
@@ -100,14 +100,14 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
 	/*
 	 * Reset cpu_id_start to its initial state (0).
 	 */
-	if (__put_user(cpu_id_start, &t->rseq->cpu_id_start))
+	if (put_user(cpu_id_start, &t->rseq->cpu_id_start))
 		return -EFAULT;
 	/*
 	 * Reset cpu_id to RSEQ_CPU_ID_UNINITIALIZED, so any user coming
 	 * in after unregistration can figure out that rseq needs to be
 	 * registered again.
 	 */
-	if (__put_user(cpu_id, &t->rseq->cpu_id))
+	if (put_user(cpu_id, &t->rseq->cpu_id))
 		return -EFAULT;
 	return 0;
 }
@@ -115,29 +115,36 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
 static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 {
 	struct rseq_cs __user *urseq_cs;
-	unsigned long ptr;
+	u64 ptr;
 	u32 __user *usig;
 	u32 sig;
 	int ret;
 
-	ret = __get_user(ptr, &t->rseq->rseq_cs);
-	if (ret)
-		return ret;
+	if (copy_from_user(&ptr, &t->rseq->rseq_cs.ptr64, sizeof(ptr)))
+		return -EFAULT;
 	if (!ptr) {
 		memset(rseq_cs, 0, sizeof(*rseq_cs));
 		return 0;
 	}
-	urseq_cs = (struct rseq_cs __user *)ptr;
+	if (ptr >= TASK_SIZE)
+		return -EINVAL;
+	urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;
 	if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
 		return -EFAULT;
-	if (rseq_cs->version > 0)
-		return -EINVAL;
 
+	if (rseq_cs->start_ip >= TASK_SIZE ||
+	    rseq_cs->start_ip + rseq_cs->post_commit_offset >= TASK_SIZE ||
+	    rseq_cs->abort_ip >= TASK_SIZE ||
+	    rseq_cs->version > 0)
+		return -EINVAL;
+	/* Check for overflow. */
+	if (rseq_cs->start_ip + rseq_cs->post_commit_offset < rseq_cs->start_ip)
+		return -EINVAL;
 	/* Ensure that abort_ip is not in the critical section. */
 	if (rseq_cs->abort_ip - rseq_cs->start_ip < rseq_cs->post_commit_offset)
 		return -EINVAL;
 
-	usig = (u32 __user *)(rseq_cs->abort_ip - sizeof(u32));
+	usig = (u32 __user *)(unsigned long)(rseq_cs->abort_ip - sizeof(u32));
 	ret = get_user(sig, usig);
 	if (ret)
 		return ret;
@@ -146,7 +153,7 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 		printk_ratelimited(KERN_WARNING
 			"Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x (pid=%d, addr=%p).\n",
 			sig, current->rseq_sig, current->pid, usig);
-		return -EPERM;
+		return -EINVAL;
 	}
 	return 0;
 }
@@ -157,7 +164,7 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
 	int ret;
 
 	/* Get thread flags. */
-	ret = __get_user(flags, &t->rseq->flags);
+	ret = get_user(flags, &t->rseq->flags);
 	if (ret)
 		return ret;
 
@@ -195,9 +202,11 @@ static int clear_rseq_cs(struct task_struct *t)
 	 * of code outside of the rseq assembly block. This performs
 	 * a lazy clear of the rseq_cs field.
 	 *
-	 * Set rseq_cs to NULL with single-copy atomicity.
+	 * Set rseq_cs to NULL.
 	 */
-	return __put_user(0UL, &t->rseq->rseq_cs);
+	if (clear_user(&t->rseq->rseq_cs.ptr64, sizeof(t->rseq->rseq_cs.ptr64)))
+		return -EFAULT;
+	return 0;
 }
 
 /*
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index a4684112676c..86ce22417e0d 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -133,17 +133,27 @@ static inline uint32_t rseq_current_cpu(void)
 	return cpu;
 }
 
+static inline void rseq_clear_rseq_cs(void)
+{
+#ifdef __LP64__
+	__rseq_abi.rseq_cs.ptr = 0;
+#else
+	__rseq_abi.rseq_cs.ptr.ptr32 = 0;
+#endif
+}
+
 /*
- * rseq_prepare_unload() should be invoked by each thread using rseq_finish*()
- * at least once between their last rseq_finish*() and library unload of the
- * library defining the rseq critical section (struct rseq_cs). This also
- * applies to use of rseq in code generated by JIT: rseq_prepare_unload()
- * should be invoked at least once by each thread using rseq_finish*() before
- * reclaim of the memory holding the struct rseq_cs.
+ * rseq_prepare_unload() should be invoked by each thread executing a rseq
+ * critical section at least once between their last critical section and
+ * library unload of the library defining the rseq critical section
+ * (struct rseq_cs). This also applies to use of rseq in code generated by
+ * JIT: rseq_prepare_unload() should be invoked at least once by each
+ * thread executing a rseq critical section before reclaim of the memory
+ * holding the struct rseq_cs.
  */
 static inline void rseq_prepare_unload(void)
 {
-	__rseq_abi.rseq_cs = 0;
+	rseq_clear_rseq_cs();
 }
 
 #endif  /* RSEQ_H_ */
