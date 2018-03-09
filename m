Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-872320-1520610598-2-3712030156768270056
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roensk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='fr',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520610596; b=JlF2pubg5/oCgLyTHAjaglsDWtz7WA0ns3dTah2WFWUP/pA
    w31xF4GaV5Y0ErNiTIz/a+nqz4mhAeDQWA8VSzNZUxYFVfS/A8kDUDqEyujeiV7E
    X73SkWFaR+Hhc6LxEA81r300TDd3VARoMEDG3+yf+Uy9M27HkoUKXtXGX5SbY+Md
    WWkwUt8a0WLwrockNYSsRvxb0vtrCk/jmW5M+BNbxWHHGBPnMm6J5fxhXFrcw1lW
    gpYtcrNU9SeoXvxM9bGv3Hs0oslLe3694AQXdlQnxX3TByTmURChkFvqX3kDbiKm
    A2TzNoCz8ozERp0E6juh/Tzp2NKG+ynIyi/I98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:in-reply-to:references:from
    :subject:to:cc:date:sender:list-id; s=arctest; t=1520610596; bh=
    pRHCxsoESp/J7GWo1Y7GPRfD7fHySziGNmEG2PtF7wY=; b=f2vwdOi45RW7g1xF
    sYdDhIMku+Cjt6HD7zOoQV4Uzi3Ma3jmXMX4IyN3qAt9+btfj9QUjJa8t9MoCrZa
    IE/hQkv1T6onUbCPpw7/NKJf5903d1nITwUsaTxvlBoIx/G42sQhFY/DCHW9FiqI
    PzwWyKI1LtcAi6er/Eq13OPsEUOJl4e7Ql1dDfig/ytFx5va0aNQSsVcUKWbU5/t
    fW2L6mN7U5qcNuvp+JlTC3vwYcD+/+x1Y+RUWS4AaV5j6gQQriLG41cldi9Xa/U3
    2pRrjiunC6b+wT8XtLaWQ9VhzfGaBmDXPUjVZMrhZttEWksSV5HxXRX9J2Prkc7L
    0lZIoA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=c-s.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=c-s.fr header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=c-s.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=c-s.fr header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932067AbeCIPt3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 10:49:29 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:10945 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbeCIPtF (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 9 Mar 2018 10:49:05 -0500
Message-Id: <a371a405643b73b023c26cd1d2256f8f37c68a11.1520468013.git.christophe.leroy@c-s.fr>
In-Reply-To: <69684e92a32d00c491540e8adfa34fcb50c36244.1520468013.git.christophe.leroy@c-s.fr>
References: <69684e92a32d00c491540e8adfa34fcb50c36244.1520468013.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4.14 3/4] powerpc/mm/slice: Enhance for supporting PPC32
To: stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  9 Mar 2018 16:49:03 +0100 (CET)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Upstream db3a528db41caaa6dfd4c64e9f5efb1c81a80467

In preparation for the following patch which will fix an issue on
the 8xx by re-using the 'slices', this patch enhances the
'slices' implementation to support 32 bits CPUs.

On PPC32, the address space is limited to 4Gbytes, hence only the low
slices will be used.

The high slices use bitmaps. As bitmap functions are not prepared to
handle bitmaps of size 0, this patch ensures that bitmap functions
are called only when SLICE_NUM_HIGH is not nul.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/nohash/32/slice.h | 18 +++++++++++++++
 arch/powerpc/include/asm/slice.h           |  4 +++-
 arch/powerpc/mm/slice.c                    | 37 +++++++++++++++++++++++-------
 3 files changed, 50 insertions(+), 9 deletions(-)
 create mode 100644 arch/powerpc/include/asm/nohash/32/slice.h

diff --git a/arch/powerpc/include/asm/nohash/32/slice.h b/arch/powerpc/include/asm/nohash/32/slice.h
new file mode 100644
index 000000000000..95d532e18092
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/32/slice.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_NOHASH_32_SLICE_H
+#define _ASM_POWERPC_NOHASH_32_SLICE_H
+
+#ifdef CONFIG_PPC_MM_SLICES
+
+#define SLICE_LOW_SHIFT		28
+#define SLICE_LOW_TOP		(0x100000000ull)
+#define SLICE_NUM_LOW		(SLICE_LOW_TOP >> SLICE_LOW_SHIFT)
+#define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
+
+#define SLICE_HIGH_SHIFT	0
+#define SLICE_NUM_HIGH		0ul
+#define GET_HIGH_SLICE_INDEX(addr)	(addr & 0)
+
+#endif /* CONFIG_PPC_MM_SLICES */
+
+#endif /* _ASM_POWERPC_NOHASH_32_SLICE_H */
diff --git a/arch/powerpc/include/asm/slice.h b/arch/powerpc/include/asm/slice.h
index 17c5a5d8c418..172711fadb1c 100644
--- a/arch/powerpc/include/asm/slice.h
+++ b/arch/powerpc/include/asm/slice.h
@@ -4,8 +4,10 @@
 
 #ifdef CONFIG_PPC_BOOK3S_64
 #include <asm/book3s/64/slice.h>
-#else
+#elif defined(CONFIG_PPC64)
 #include <asm/nohash/64/slice.h>
+#elif defined(CONFIG_PPC_MMU_NOHASH)
+#include <asm/nohash/32/slice.h>
 #endif
 
 #ifdef CONFIG_PPC_MM_SLICES
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index a7ac600f71c6..5b2d392a1a5e 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -73,10 +73,12 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
 	unsigned long end = start + len - 1;
 
 	ret->low_slices = 0;
-	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
+	if (SLICE_NUM_HIGH)
+		bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
 
 	if (start < SLICE_LOW_TOP) {
-		unsigned long mend = min(end, (SLICE_LOW_TOP - 1));
+		unsigned long mend = min(end,
+					 (unsigned long)(SLICE_LOW_TOP - 1));
 
 		ret->low_slices = (1u << (GET_LOW_SLICE_INDEX(mend) + 1))
 			- (1u << GET_LOW_SLICE_INDEX(start));
@@ -113,11 +115,13 @@ static int slice_high_has_vma(struct mm_struct *mm, unsigned long slice)
 	unsigned long start = slice << SLICE_HIGH_SHIFT;
 	unsigned long end = start + (1ul << SLICE_HIGH_SHIFT);
 
+#ifdef CONFIG_PPC64
 	/* Hack, so that each addresses is controlled by exactly one
 	 * of the high or low area bitmaps, the first high area starts
 	 * at 4GB, not 0 */
 	if (start == 0)
 		start = SLICE_LOW_TOP;
+#endif
 
 	return !slice_area_is_free(mm, start, end - start);
 }
@@ -127,7 +131,8 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret)
 	unsigned long i;
 
 	ret->low_slices = 0;
-	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
+	if (SLICE_NUM_HIGH)
+		bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
 
 	for (i = 0; i < SLICE_NUM_LOW; i++)
 		if (!slice_low_has_vma(mm, i))
@@ -149,7 +154,8 @@ static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_ma
 	u64 lpsizes;
 
 	ret->low_slices = 0;
-	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
+	if (SLICE_NUM_HIGH)
+		bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
 
 	lpsizes = mm->context.low_slices_psize;
 	for (i = 0; i < SLICE_NUM_LOW; i++)
@@ -171,6 +177,10 @@ static int slice_check_fit(struct mm_struct *mm,
 	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
 	unsigned long slice_count = GET_HIGH_SLICE_INDEX(mm->context.addr_limit);
 
+	if (!SLICE_NUM_HIGH)
+		return (mask.low_slices & available.low_slices) ==
+		       mask.low_slices;
+
 	bitmap_and(result, mask.high_slices,
 		   available.high_slices, slice_count);
 
@@ -180,6 +190,7 @@ static int slice_check_fit(struct mm_struct *mm,
 
 static void slice_flush_segments(void *parm)
 {
+#ifdef CONFIG_PPC64
 	struct mm_struct *mm = parm;
 	unsigned long flags;
 
@@ -191,6 +202,7 @@ static void slice_flush_segments(void *parm)
 	local_irq_save(flags);
 	slb_flush_and_rebolt();
 	local_irq_restore(flags);
+#endif
 }
 
 static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psize)
@@ -380,6 +392,8 @@ static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
 static inline void slice_or_mask(struct slice_mask *dst, struct slice_mask *src)
 {
 	dst->low_slices |= src->low_slices;
+	if (!SLICE_NUM_HIGH)
+		return;
 	bitmap_or(dst->high_slices, dst->high_slices, src->high_slices,
 		  SLICE_NUM_HIGH);
 }
@@ -388,6 +402,8 @@ static inline void slice_andnot_mask(struct slice_mask *dst, struct slice_mask *
 {
 	dst->low_slices &= ~src->low_slices;
 
+	if (!SLICE_NUM_HIGH)
+		return;
 	bitmap_andnot(dst->high_slices, dst->high_slices, src->high_slices,
 		      SLICE_NUM_HIGH);
 }
@@ -431,14 +447,17 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	 * init different masks
 	 */
 	mask.low_slices = 0;
-	bitmap_zero(mask.high_slices, SLICE_NUM_HIGH);
 
 	/* silence stupid warning */;
 	potential_mask.low_slices = 0;
-	bitmap_zero(potential_mask.high_slices, SLICE_NUM_HIGH);
 
 	compat_mask.low_slices = 0;
-	bitmap_zero(compat_mask.high_slices, SLICE_NUM_HIGH);
+
+	if (SLICE_NUM_HIGH) {
+		bitmap_zero(mask.high_slices, SLICE_NUM_HIGH);
+		bitmap_zero(potential_mask.high_slices, SLICE_NUM_HIGH);
+		bitmap_zero(compat_mask.high_slices, SLICE_NUM_HIGH);
+	}
 
 	/* Sanity checks */
 	BUG_ON(mm->task_size == 0);
@@ -584,7 +603,9 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
  convert:
 	slice_andnot_mask(&mask, &good_mask);
 	slice_andnot_mask(&mask, &compat_mask);
-	if (mask.low_slices || !bitmap_empty(mask.high_slices, SLICE_NUM_HIGH)) {
+	if (mask.low_slices ||
+	    (SLICE_NUM_HIGH &&
+	     !bitmap_empty(mask.high_slices, SLICE_NUM_HIGH))) {
 		slice_convert(mm, mask, psize);
 		if (psize > MMU_PAGE_BASE)
 			on_each_cpu(slice_flush_segments, mm, 1);
-- 
2.13.3
