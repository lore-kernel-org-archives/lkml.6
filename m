Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0343FC64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0322087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0322087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbeJHRJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:09:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43757 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJHRJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:09:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w989vfwK560181
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Oct 2018 02:57:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w989vfkr560178;
        Mon, 8 Oct 2018 02:57:41 -0700
Date:   Mon, 8 Oct 2018 02:57:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Chang S. Bae" <tipbot@zytor.com>
Message-ID: <tip-c4755613a1339ea77dbb15de75c9f74217209265@git.kernel.org>
Cc:     markus.t.metzger@intel.com, hpa@zytor.com,
        ravi.v.shankar@intel.com, dvlasenk@redhat.com,
        linux-kernel@vger.kernel.org, riel@surriel.com,
        dave.hansen@linux.intel.com, torvalds@linux-foundation.org,
        brgerst@gmail.com, luto@kernel.org, luto@amacapital.net,
        mingo@kernel.org, chang.seok.bae@intel.com, bp@alien8.de,
        peterz@infradead.org, tglx@linutronix.de
Reply-To: brgerst@gmail.com, mingo@kernel.org, luto@amacapital.net,
          luto@kernel.org, torvalds@linux-foundation.org,
          dave.hansen@linux.intel.com, dvlasenk@redhat.com,
          linux-kernel@vger.kernel.org, riel@surriel.com,
          markus.t.metzger@intel.com, hpa@zytor.com,
          ravi.v.shankar@intel.com, tglx@linutronix.de,
          peterz@infradead.org, chang.seok.bae@intel.com, bp@alien8.de
In-Reply-To: <1537312139-5580-7-git-send-email-chang.seok.bae@intel.com>
References: <1537312139-5580-7-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/segments/64: Rename the GDT PER_CPU entry to
 CPU_NUMBER
Git-Commit-ID: c4755613a1339ea77dbb15de75c9f74217209265
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

Commit-ID:  c4755613a1339ea77dbb15de75c9f74217209265
Gitweb:     https://git.kernel.org/tip/c4755613a1339ea77dbb15de75c9f74217209265
Author:     Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate: Tue, 18 Sep 2018 16:08:57 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 8 Oct 2018 10:41:10 +0200

x86/segments/64: Rename the GDT PER_CPU entry to CPU_NUMBER

The old 'per CPU' naming was misleading: 64-bit kernels don't use this
GDT entry for per CPU data, but to store the CPU (and node) ID.

[ mingo: Wrote new changelog. ]

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Markus T Metzger <markus.t.metzger@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Link: http://lkml.kernel.org/r/1537312139-5580-7-git-send-email-chang.seok.bae@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/vma.c      | 2 +-
 arch/x86/include/asm/segment.h | 5 ++---
 arch/x86/include/asm/vgtod.h   | 8 ++++----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 5b8b556dbb12..0b114aafcedc 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -359,7 +359,7 @@ static void vgetcpu_cpu_init(void *arg)
 	d.p = 1;		/* Present */
 	d.d = 1;		/* 32-bit */
 
-	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_PER_CPU, &d, DESCTYPE_S);
+	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_CPU_NUMBER, &d, DESCTYPE_S);
 }
 
 static int vgetcpu_online(unsigned int cpu)
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index e293c122d0d5..e3e788ea52e5 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -186,8 +186,7 @@
 #define GDT_ENTRY_TLS_MIN		12
 #define GDT_ENTRY_TLS_MAX		14
 
-/* Abused to load per CPU data from limit */
-#define GDT_ENTRY_PER_CPU		15
+#define GDT_ENTRY_CPU_NUMBER		15
 
 /*
  * Number of entries in the GDT table:
@@ -207,7 +206,7 @@
 #define __USER_DS			(GDT_ENTRY_DEFAULT_USER_DS*8 + 3)
 #define __USER32_DS			__USER_DS
 #define __USER_CS			(GDT_ENTRY_DEFAULT_USER_CS*8 + 3)
-#define __PER_CPU_SEG			(GDT_ENTRY_PER_CPU*8 + 3)
+#define __CPU_NUMBER_SEG		(GDT_ENTRY_CPU_NUMBER*8 + 3)
 
 #endif
 
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index 53748541c487..4e81ea920722 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -86,9 +86,9 @@ static inline unsigned int __getcpu(void)
 	unsigned int p;
 
 	/*
-	 * Load per CPU data from GDT.  LSL is faster than RDTSCP and
-	 * works on all CPUs.  This is volatile so that it orders
-	 * correctly wrt barrier() and to keep gcc from cleverly
+	 * Load CPU (and node) number from GDT.  LSL is faster than RDTSCP
+	 * and works on all CPUs.  This is volatile so that it orders
+	 * correctly with respect to barrier() and to keep GCC from cleverly
 	 * hoisting it out of the calling function.
 	 *
 	 * If RDPID is available, use it.
@@ -96,7 +96,7 @@ static inline unsigned int __getcpu(void)
 	alternative_io ("lsl %[seg],%[p]",
 			".byte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax */
 			X86_FEATURE_RDPID,
-			[p] "=a" (p), [seg] "r" (__PER_CPU_SEG));
+			[p] "=a" (p), [seg] "r" (__CPU_NUMBER_SEG));
 
 	return p;
 }
