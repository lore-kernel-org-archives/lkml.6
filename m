Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3C4C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D16520852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vgffrONe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D16520852
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388941AbeGXVy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:54:58 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:43315 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388793AbeGXVy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:54:58 -0400
Received: by mail-yb0-f201.google.com with SMTP id a14-v6so2704113ybl.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=l0JQkD8TEB1qH/AuRZ8N7KTiKyOy0ls1e1RGSCGp+dw=;
        b=vgffrONeP8bhWRaPp4xvnQ8DqZf0XP/y8K2rcSPC5wli253MqZzgx5VYV8SYWtwSWn
         2Bd+qsCH2T3XHLu6A625UYtMDKr2oVhdDrecfN193pfjbqyShP7YbH8p1FdTYCFURjjT
         kDSguGHL1J6sJFTW8B2alGnnZuLz3Pywo77fz6RmYIb6XEDie6XbsgDVERRqhcFvlQ9/
         1xhnD32u9g0uWI4r4uRGvxKeQjAYKKD3qjngiHoEogegyx5NoqqoQxrh2UxAZKdvx3aA
         U7nTqVgAdwBV9V9mLpVRd+o5HvwxDH/FbDDqTPo4Nu/mYt+nnxJtZ6vqF2TNDKRGM8CK
         a8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=l0JQkD8TEB1qH/AuRZ8N7KTiKyOy0ls1e1RGSCGp+dw=;
        b=jB7zdoyy3Obl3XNPTiKTk/IC4hNKQrmJn8bq4NlM2bc4VKJ1nayy31TSmj7HfbLPUG
         1TXEiDTUFow1OS2HVO2u+diOFWBP8hD0ckHFxyg1PGZWKPQ+3vUma46Vh1zCOj2Zm3KF
         Y5pTEyUfXCM20cNbg29ba4gKMtjX5B3PnD3/MyN29r/LDyOLJ1O1kB/geOXelvhXJ7Ao
         +7kIJd6HDsTCUJRd3oRMB6+0+2GLtp6yst2y8QwWgbGG91GZQ2rgB8sCGmqYA0lYxP8k
         BBwHOv2JcFLsZDF6gSon7HcWk28Qy2RWyPoFWS0K0ovtSDc6eRKHlmmzlYrXxzb2kREw
         XzIA==
X-Gm-Message-State: AOUpUlFh5Hkv3qmWpkf0IChpKzYv3o3aiQUzsFmFBDUZcltQVtMwv7KR
        gK06ERL10UFCTbZE0Y4MPODnAKtGBus+T8/f+NbYKg==
X-Google-Smtp-Source: AAOMgpfHzYmEAg6WPeBLurWFMrGQ4B1+JbuJ1y8Cb6k6EojUZ6x3U++bjFt/vDCJKsCjZjv1G4SqYT63HxYxVwvRaRrGIw==
MIME-Version: 1.0
X-Received: by 2002:a25:2d50:: with SMTP id s16-v6mr5260751ybe.30.1532465203523;
 Tue, 24 Jul 2018 13:46:43 -0700 (PDT)
Date:   Tue, 24 Jul 2018 13:46:39 -0700
Message-Id: <20180724204639.26934-1-cannonmatthews@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH] RFC: clear 1G pages with streaming stores on x86
From:   Cannon Matthews <cannonmatthews@google.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andres Lagar-Cavilla <andreslc@google.com>,
        Salman Qazi <sqazi@google.com>, Paul Turner <pjt@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Alain Trinh <nullptr@google.com>,
        Cannon Matthews <cannonmatthews@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reimplement clear_gigantic_page() to clear gigabytes pages using the
non-temporal streaming store instructions that bypass the cache
(movnti), since an entire 1GiB region will not fit in the cache anyway.

Doing an mlock() on a 512GiB 1G-hugetlb region previously would take on
average 134 seconds, about 260ms/GiB which is quite slow. Using `movnti`
and optimizing the control flow over the constituent small pages, this
can be improved roughly by a factor of 3-4x, with the 512GiB mlock()
taking only 34 seconds on average, or 67ms/GiB.

The assembly code for the __clear_page_nt routine is more or less
taken directly from the output of gcc with -O3 for this function with
some tweaks to support arbitrary sizes and moving memory barriers:

void clear_page_nt_64i (void *page)
{
  for (int i = 0; i < GiB /sizeof(long long int); ++i)
    {
      _mm_stream_si64 (((long long int*)page) + i, 0);
    }
  sfence();
}

In general I would love to hear any thoughts and feedback on this
approach and any ways it could be improved.

Some specific questions:

- What is the appropriate method for defining an arch specific
implementation like this, is the #ifndef code sufficient, and did stuff
land in appropriate files?

- Are there any obvious pitfalls or caveats that have not been
considered? In particular the iterator over mem_map_next() seemed like a
no-op on x86, but looked like it could be important in certain
configurations or architectures I am not familiar with.

- Are there any x86_64 implementations that do not support SSE2
instructions like `movnti` ? What is the appropriate way to detect and
code around that if so?

- Is there anything that could be improved about the assembly code? I
originally wrote it in C and don't have much experience hand writing x86
asm, which seems riddled with optimization pitfalls.

- Is the highmem codepath really necessary? would 1GiB pages really be
of much use on a highmem system? We recently removed some other parts of
the code that support HIGHMEM for gigantic pages (see:
http://lkml.kernel.org/r/20180711195913.1294-1-mike.kravetz@oracle.com)
so this seems like a logical continuation.

- The calls to cond_resched() have been reduced from between every 4k
page to every 64, as between all of the 256K page seemed overly
frequent.  Does this seem like an appropriate frequency? On an idle
system with many spare CPUs it get's rescheduled typically once or twice
out of the 4096 times it calls cond_resched(), which seems like it is
maybe the right amount, but more insight from a scheduling/latency point
of view would be helpful.

- Any other thoughts on the change overall and ways that this could
be made more generally useful, and designed to be easily extensible to
other platforms with non-temporal instructions and 1G pages, or any
additional pitfalls I have not thought to consider.

Tested:
	Time to `mlock()` a 512GiB region on broadwell CPU
				AVG time (s)	% imp.	ms/page
	clear_page_erms		133.584		-	261
	clear_page_nt		34.154		74.43%	67

Signed-off-by: Cannon Matthews <cannonmatthews@google.com>
---
 arch/x86/include/asm/page_64.h     |  3 +++
 arch/x86/lib/Makefile              |  2 +-
 arch/x86/lib/clear_gigantic_page.c | 30 ++++++++++++++++++++++++++++++
 arch/x86/lib/clear_page_64.S       | 20 ++++++++++++++++++++
 include/linux/mm.h                 |  3 +++
 mm/memory.c                        |  5 ++++-
 6 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/lib/clear_gigantic_page.c

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 939b1cff4a7b..6c1ae21b4d84 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -56,6 +56,9 @@ static inline void clear_page(void *page)

 void copy_page(void *to, void *from);

+#define __HAVE_ARCH_CLEAR_GIGANTIC_PAGE
+void __clear_page_nt(void *page, u64 page_size);
+
 #endif	/* !__ASSEMBLY__ */

 #ifdef CONFIG_X86_VSYSCALL_EMULATION
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 25a972c61b0a..4ba395234088 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -44,7 +44,7 @@ endif
 else
         obj-y += iomap_copy_64.o
         lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
-        lib-y += clear_page_64.o copy_page_64.o
+        lib-y += clear_page_64.o copy_page_64.o clear_gigantic_page.o
         lib-y += memmove_64.o memset_64.o
         lib-y += copy_user_64.o
 	lib-y += cmpxchg16b_emu.o
diff --git a/arch/x86/lib/clear_gigantic_page.c b/arch/x86/lib/clear_gigantic_page.c
new file mode 100644
index 000000000000..80e70f31ddbd
--- /dev/null
+++ b/arch/x86/lib/clear_gigantic_page.c
@@ -0,0 +1,30 @@
+#include <asm/page.h>
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
+#define PAGES_BETWEEN_RESCHED 64
+void clear_gigantic_page(struct page *page,
+				unsigned long addr,
+				unsigned int pages_per_huge_page)
+{
+	int i;
+	void *dest = page_to_virt(page);
+	int resched_count = 0;
+
+	BUG_ON(pages_per_huge_page % PAGES_BETWEEN_RESCHED != 0);
+	BUG_ON(!dest);
+
+	might_sleep();
+	for (i = 0; i < pages_per_huge_page; i += PAGES_BETWEEN_RESCHED) {
+		__clear_page_nt(dest + (i * PAGE_SIZE),
+				PAGES_BETWEEN_RESCHED * PAGE_SIZE);
+		resched_count += cond_resched();
+	}
+	/* __clear_page_nt requrires and `sfence` barrier. */
+	wmb();
+	pr_debug("clear_gigantic_page: rescheduled %d times\n", resched_count);
+}
+#endif
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index 88acd349911b..81a39804ac72 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -49,3 +49,23 @@ ENTRY(clear_page_erms)
 	ret
 ENDPROC(clear_page_erms)
 EXPORT_SYMBOL_GPL(clear_page_erms)
+
+/*
+ * Zero memory using non temporal stores, bypassing the cache.
+ * Requires an `sfence` (wmb()) afterwards.
+ * %rdi - destination.
+ * %rsi - page size. Must be 64 bit aligned.
+*/
+ENTRY(__clear_page_nt)
+	leaq	(%rdi,%rsi), %rdx
+	xorl	%eax, %eax
+	.p2align 4,,10
+	.p2align 3
+.L2:
+	movnti	%rax, (%rdi)
+	addq	$8, %rdi
+	cmpq	%rdx, %rdi
+	jne	.L2
+	ret
+ENDPROC(__clear_page_nt)
+EXPORT_SYMBOL(__clear_page_nt)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a0fbb9ffe380..d10ac4e7ef6a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2729,6 +2729,9 @@ enum mf_action_page_type {
 };

 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
+extern void clear_gigantic_page(struct page *page,
+			 unsigned long addr,
+			 unsigned int pages_per_huge_page);
 extern void clear_huge_page(struct page *page,
 			    unsigned long addr_hint,
 			    unsigned int pages_per_huge_page);
diff --git a/mm/memory.c b/mm/memory.c
index 7206a634270b..2515cae4af4e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -70,6 +70,7 @@
 #include <linux/dax.h>
 #include <linux/oom.h>

+
 #include <asm/io.h>
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
@@ -4568,7 +4569,8 @@ EXPORT_SYMBOL(__might_fault);
 #endif

 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
-static void clear_gigantic_page(struct page *page,
+#ifndef __HAVE_ARCH_CLEAR_GIGANTIC_PAGE
+void clear_gigantic_page(struct page *page,
 				unsigned long addr,
 				unsigned int pages_per_huge_page)
 {
@@ -4582,6 +4584,7 @@ static void clear_gigantic_page(struct page *page,
 		clear_user_highpage(p, addr + i * PAGE_SIZE);
 	}
 }
+#endif  /* __HAVE_ARCH_CLEAR_GIGANTIC_PAGE */
 void clear_huge_page(struct page *page,
 		     unsigned long addr_hint, unsigned int pages_per_huge_page)
 {
--
2.18.0.233.g985f88cf7e-goog

