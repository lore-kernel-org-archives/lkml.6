Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E719C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69BC20883
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hXxMzg2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69BC20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388527AbeGYDrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:47:10 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:41301 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbeGYDrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:47:10 -0400
Received: by mail-it0-f73.google.com with SMTP id h26-v6so4380983itj.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 19:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=q8LnwAnSwMHhv79EyjtY8UagaAVpzBEC4VDrQwjyP2c=;
        b=hXxMzg2LBxUOQNGZL8crG6KdrXQ8iqEU434TWN+D/7kjuy3vhyg1n2ecUPmhfoYIKt
         82eGrsJOY2dHq8cNXd/i+21lU3QAWJI1cZxKOzwLgc7rI1wW0GJ+gSIn0qSmQKnRXsiI
         /YBdexJPlhPYA8X9cRDfq7uUI2ZkA8nCWpRp4fPNLFQqS75zhZkjHLBKseScNJJa/jGa
         efjZ2hD5azfRWM+IjuK2T3NP4azOe4dY89LEhZxNkMsWzanxmj7ior4XEJ42zLy6Qx3y
         ULQLD6ut9qLiveLwXjC6LAjQEiWzmiPYLT9s6/+m7DQ44Au3/0ApeadtIMs0xP4xBogE
         vGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=q8LnwAnSwMHhv79EyjtY8UagaAVpzBEC4VDrQwjyP2c=;
        b=Ozc3Y+79J0lpKuQGZhDKrFMznIW5UHH/aVpAePJWhIzwMZIIVdm8S3jKShtJX7VFav
         HXHrgTQTSDm43J+0qtzwfyN6D/UgnQOeSiRsn7Tcv5zsYA/qWloyGRFG8FE1Qft3m+BP
         B+I5qS/m/4eYqDFGrVe7DaAB8SLd2hrVgPCYpbScNiXLhU0v9z7u23G4M/Te0ASPKx1q
         Bk0nnLcLo0RWyxzrBVOlTB9XkAC1XSgEFF72mLX8oOoYLn/lWxyRBpZZsUJkTbjoB6Re
         SyNyP6Cw3vJtvI24FZXrwRwFVzrZfMvG8/8xueS6H/uGfiyDYpNS7PHJ8HUQ6+15gNnr
         xTKQ==
X-Gm-Message-State: AOUpUlG7ZccWzV6rgjuA2IM87d5e2JZCCKwOtT9GdBD3JlOkz9XpfmPg
        GsyV9ZLhyDDIB8vOpx3EI1JJRMyW6OXGmucJZAtcYQ==
X-Google-Smtp-Source: AAOMgpcu7qPhGdVMHCtkmU+daCU9xvjc8tc5B6URVRmoWVj0l7AN76/hIy7LKU5P0kgdzO7mIH0a09VOaOfn0bL03cQobQ==
MIME-Version: 1.0
X-Received: by 2002:a6b:4919:: with SMTP id u25-v6mr3313831iob.0.1532486262855;
 Tue, 24 Jul 2018 19:37:42 -0700 (PDT)
Date:   Tue, 24 Jul 2018 19:37:28 -0700
In-Reply-To: <20180724210923.GA20168@bombadil.infradead.org>
Message-Id: <20180725023728.44630-1-cannonmatthews@google.com>
References: <20180724210923.GA20168@bombadil.infradead.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: Re: [PATCH v2] RFC: clear 1G pages with streaming stores on x86
From:   Cannon Matthews <cannonmatthews@google.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
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
of view would be helpful. See the "Tested:" section below for some more data.

- Any other thoughts on the change overall and ways that this could
be made more generally useful, and designed to be easily extensible to
other platforms with non-temporal instructions and 1G pages, or any
additional pitfalls I have not thought to consider.

Tested:
	Time to `mlock()` a 512GiB region on broadwell CPU
				AVG time (s)	% imp.	ms/page
	clear_page_erms		133.584		-	261
	clear_page_nt		34.154		74.43%	67

For a more in depth look at how the frequency we call cond_resched() affects
the time this takes, I tested both on an idle system, and a system running
`stress -c N` program to overcommit CPU to ~115%, and ran 10 replications of
the 512GiB mlock test.

Unfortunately there wasn't as clear of a pattern as I had hoped. On an
otherwise idle system there is no substantive difference different values of
PAGES_BETWEEN_RESCHED.

On a stressed system, there appears to be a pattern, that resembles something
of a bell curve: constantly offering to yield, or never yielding until the end
produces the fastest results, but yielding infrequently increases latency to a
slight degree.

That being said, it's not clear this is actually a significant difference, the
std deviation is occasionally quite high, and perhaps a larger sample set would
be more informative. From looking at the log messages indicating the number of
times cond_resched() returned 1, there wasn't that much variance, with it
usually being 1 or 2 when idle, and only increasing to ~4-7 when stressed.


	PAGES_BETWEEN_RESCHED	state	AVG	stddev
	1	4 KiB		idle	36.086	1.920
	16	64 KiB		idle	34.797	1.702
	32	128 KiB		idle	35.104	1.752
	64	256 KiB		idle	34.468	0.661
	512	2048 KiB	idle	36.427	0.946
	2048	8192 KiB	idle	34.988	2.406
	262144	1048576 KiB	idle	36.792	0.193
	infin	512 GiB		idle	38.817	0.238  [causes softlockup]
	1	4 KiB		stress 	55.562	0.661
	16	64 KiB		stress 	57.509	0.248
	32	128 KiB		stress 	69.265	3.913
	64	256 KiB		stress 	70.217	4.534
	512	2048 KiB	stress 	68.474	1.708
	2048	8192 KiB	stress 	70.806	1.068
	262144	1048576 KiB	stress 	55.217	1.184
	infin	512 GiB		stress 	55.062	0.291  [causes softlockup]

Signed-off-by: Cannon Matthews <cannonmatthews@google.com>
---

v2:
 - Removed question about SSE2 Availability.
 - Changed #ifndef symbol to match function
 - removed spurious newlines
 - Expanded Tested: field to include additional timings for different sizes
   between cond_resched().

 arch/x86/include/asm/page_64.h     |  5 +++++
 arch/x86/lib/Makefile              |  2 +-
 arch/x86/lib/clear_gigantic_page.c | 29 +++++++++++++++++++++++++++++
 arch/x86/lib/clear_page_64.S       | 20 ++++++++++++++++++++
 include/linux/mm.h                 |  3 +++
 mm/memory.c                        |  4 +++-
 6 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/lib/clear_gigantic_page.c

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 939b1cff4a7b..177196d6abc7 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -56,6 +56,11 @@ static inline void clear_page(void *page)

 void copy_page(void *to, void *from);

+#ifndef __clear_page_nt
+void __clear_page_nt(void *page, u64 page_size);
+#define __clear_page_nt __clear_page_nt
+#endif  /* __clear_page_nt */
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
index 000000000000..0d51e38b5be0
--- /dev/null
+++ b/arch/x86/lib/clear_gigantic_page.c
@@ -0,0 +1,29 @@
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
index 7206a634270b..e43a3a446380 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4568,7 +4568,8 @@ EXPORT_SYMBOL(__might_fault);
 #endif

 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
-static void clear_gigantic_page(struct page *page,
+#ifndef __clear_page_nt
+void clear_gigantic_page(struct page *page,
 				unsigned long addr,
 				unsigned int pages_per_huge_page)
 {
@@ -4582,6 +4583,7 @@ static void clear_gigantic_page(struct page *page,
 		clear_user_highpage(p, addr + i * PAGE_SIZE);
 	}
 }
+#endif  /* __clear_page_nt */
 void clear_huge_page(struct page *page,
 		     unsigned long addr_hint, unsigned int pages_per_huge_page)
 {
--
2.18.0.233.g985f88cf7e-goog

