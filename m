Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A48C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750F52087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750F52087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeJHRJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:09:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45441 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJHRJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:09:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w989wDAI560212
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Oct 2018 02:58:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w989wD7d560209;
        Mon, 8 Oct 2018 02:58:13 -0700
Date:   Mon, 8 Oct 2018 02:58:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Chang S. Bae" <tipbot@zytor.com>
Message-ID: <tip-ffebbaedc8616cffe648202e364dce6a045d65a2@git.kernel.org>
Cc:     torvalds@linux-foundation.org, chang.seok.bae@intel.com,
        hpa@zytor.com, dave.hansen@linux.intel.com, peterz@infradead.org,
        ravi.v.shankar@intel.com, dvlasenk@redhat.com,
        markus.t.metzger@intel.com, linux-kernel@vger.kernel.org,
        brgerst@gmail.com, mingo@kernel.org, luto@kernel.org,
        riel@surriel.com, luto@amacapital.net, tglx@linutronix.de,
        bp@alien8.de
Reply-To: mingo@kernel.org, riel@surriel.com, luto@kernel.org,
          tglx@linutronix.de, bp@alien8.de, luto@amacapital.net,
          hpa@zytor.com, torvalds@linux-foundation.org,
          chang.seok.bae@intel.com, dave.hansen@linux.intel.com,
          peterz@infradead.org, markus.t.metzger@intel.com,
          ravi.v.shankar@intel.com, dvlasenk@redhat.com, brgerst@gmail.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <1537312139-5580-8-git-send-email-chang.seok.bae@intel.com>
References: <1537312139-5580-8-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/vdso: Introduce helper functions for CPU and node
 number
Git-Commit-ID: ffebbaedc8616cffe648202e364dce6a045d65a2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ffebbaedc8616cffe648202e364dce6a045d65a2
Gitweb:     https://git.kernel.org/tip/ffebbaedc8616cffe648202e364dce6a045d65a2
Author:     Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate: Tue, 18 Sep 2018 16:08:58 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 8 Oct 2018 10:41:10 +0200

x86/vdso: Introduce helper functions for CPU and node number

Clean up the CPU/node number related code a bit, to make it more apparent
how we are encoding/extracting the CPU and node fields from the
segment limit.

No change in functionality intended.

[ mingo: Wrote new changelog. ]

Suggested-by: Andy Lutomirski <luto@kernel.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Markus T Metzger <markus.t.metzger@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Link: http://lkml.kernel.org/r/1537312139-5580-8-git-send-email-chang.seok.bae@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/vgetcpu.c  |  9 +--------
 arch/x86/entry/vdso/vma.c      | 19 +++++++------------
 arch/x86/include/asm/segment.h | 41 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/vgtod.h   | 26 --------------------------
 4 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/arch/x86/entry/vdso/vgetcpu.c b/arch/x86/entry/vdso/vgetcpu.c
index 8ec3d1f4ce9a..de78fc9cd963 100644
--- a/arch/x86/entry/vdso/vgetcpu.c
+++ b/arch/x86/entry/vdso/vgetcpu.c
@@ -13,14 +13,7 @@
 notrace long
 __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
 {
-	unsigned int p;
-
-	p = __getcpu();
-
-	if (cpu)
-		*cpu = p & VGETCPU_CPU_MASK;
-	if (node)
-		*node = p >> 12;
+	vdso_read_cpu_node(cpu, node);
 	return 0;
 }
 
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 0b114aafcedc..39b5584c5808 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -339,20 +339,15 @@ static void vgetcpu_cpu_init(void *arg)
 {
 	int cpu = smp_processor_id();
 	struct desc_struct d = { };
-	unsigned long node = 0;
-#ifdef CONFIG_NUMA
-	node = cpu_to_node(cpu);
-#endif
+	unsigned long cpudata = vdso_encode_cpu_node(cpu, cpu_to_node(cpu));
+
 	if (static_cpu_has(X86_FEATURE_RDTSCP))
-		write_rdtscp_aux((node << 12) | cpu);
+		write_rdtscp_aux(cpudata);
+
+	/* Store CPU and node number in limit */
+	d.limit0 = cpudata;
+	d.limit1 = cpudata >> 16;
 
-	/*
-	 * Store cpu number in limit so that it can be loaded
-	 * quickly in user space in vgetcpu. (12 bits for the CPU
-	 * and 8 bits for the node)
-	 */
-	d.limit0 = cpu | ((node & 0xf) << 12);
-	d.limit1 = node >> 4;
 	d.type = 5;		/* RO data, expand down, accessed */
 	d.dpl = 3;		/* Visible to user code */
 	d.s = 1;		/* Not a system segment */
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index e3e788ea52e5..4d1f6cc62e13 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -224,6 +224,47 @@
 #define GDT_ENTRY_TLS_ENTRIES		3
 #define TLS_SIZE			(GDT_ENTRY_TLS_ENTRIES* 8)
 
+#ifdef CONFIG_X86_64
+
+/* Bit size and mask of CPU number stored in the per CPU data (and TSC_AUX) */
+#define VDSO_CPU_SIZE			12
+#define VDSO_CPU_MASK			0xfff
+
+#ifndef __ASSEMBLY__
+
+/* Helper functions to store/load CPU and node numbers */
+
+static inline unsigned long vdso_encode_cpu_node(int cpu, unsigned long node)
+{
+	return ((node << VDSO_CPU_SIZE) | cpu);
+}
+
+static inline void vdso_read_cpu_node(unsigned *cpu, unsigned *node)
+{
+	unsigned int p;
+
+	/*
+	 * Load CPU and node number from GDT.  LSL is faster than RDTSCP
+	 * and works on all CPUs.  This is volatile so that it orders
+	 * correctly with respect to barrier() and to keep GCC from cleverly
+	 * hoisting it out of the calling function.
+	 *
+	 * If RDPID is available, use it.
+	 */
+	alternative_io ("lsl %[seg],%[p]",
+			".byte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax */
+			X86_FEATURE_RDPID,
+			[p] "=a" (p), [seg] "r" (__CPU_NUMBER_SEG));
+
+	if (cpu)
+		*cpu = (p & VDSO_CPU_MASK);
+	if (node)
+		*node = (p >> VDSO_CPU_SIZE);
+}
+
+#endif /* !__ASSEMBLY__ */
+#endif /* CONFIG_X86_64 */
+
 #ifdef __KERNEL__
 
 /*
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index 4e81ea920722..056a61c8c5c7 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -77,30 +77,4 @@ static inline void gtod_write_end(struct vsyscall_gtod_data *s)
 	++s->seq;
 }
 
-#ifdef CONFIG_X86_64
-
-#define VGETCPU_CPU_MASK 0xfff
-
-static inline unsigned int __getcpu(void)
-{
-	unsigned int p;
-
-	/*
-	 * Load CPU (and node) number from GDT.  LSL is faster than RDTSCP
-	 * and works on all CPUs.  This is volatile so that it orders
-	 * correctly with respect to barrier() and to keep GCC from cleverly
-	 * hoisting it out of the calling function.
-	 *
-	 * If RDPID is available, use it.
-	 */
-	alternative_io ("lsl %[seg],%[p]",
-			".byte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax */
-			X86_FEATURE_RDPID,
-			[p] "=a" (p), [seg] "r" (__CPU_NUMBER_SEG));
-
-	return p;
-}
-
-#endif /* CONFIG_X86_64 */
-
 #endif /* _ASM_X86_VGTOD_H */
