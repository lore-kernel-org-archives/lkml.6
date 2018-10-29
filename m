Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D882C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4497020824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lIznmpfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4497020824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbeJ3ERC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:17:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36499 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbeJ3ERB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:17:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id j22-v6so713111pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 12:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=o0fr6O+CT16P6jDrh9//txOtRxOGFrxAMrVfW+PxgZw=;
        b=lIznmpflyx5ovFbvCv2LXruclAp4UTInqSM3DtKdGozr3XqFURSyiNra47AKuZP2Rp
         xy+ts+CK7+e3q7AeAeZ/PFkzD8zMWRFNT5G3J1NaaHZI6C2HERIsMZ2+87otXdMgl0Qn
         hFDZjcPxinQU2Yi+SC3JhQIFvR0mr4kOQZXJzY/dVg9IN8clxnuhJ3ochOF+CHFAs0DV
         W5tY1gedZxp7eeQHKrVQjz0Cqs1weE363BkiHcpSQgreMELXFJ2CxJ3yMficLv2bbsg8
         1NafVW42+xqXtHvnCks9GQHLuZmY8DVTt2LT2aZslpM7p6h5Tlwz7hHHN5dLncc3Lt9R
         s6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=o0fr6O+CT16P6jDrh9//txOtRxOGFrxAMrVfW+PxgZw=;
        b=C6R5TnNBsGrZlePHPaXpWhZBp++A+UXsTtxaiXyaVfgGAVIMNtF3SaTZLZBGlEjoKu
         yRMIgE1n2hdYRHHnxDxa2qRZ/VM//CjAvtQkVYSLFgxwQNZkdKbOAyvHQ/Ie8a9IJ4+1
         lW/NzbcD4F9fuWfKg4jsnZAiGt/WC8BGEXbCrqLZ9wKJ0FSWg3eI3uhgFgHzEJONmTiH
         mCw1cCzlv8BybeCEh3E8R4pJTLCZ7iXlUSRJZlamkgAYSN1pwEFgRtV+swz49wTtlL/I
         cMqD7ZwRm8JVzewxf+kt1S9xT1qcW3/G8tT6VrxZIZrFLf34oQIQf3O0zL3Dv2Wj+slh
         EMMw==
X-Gm-Message-State: AGRZ1gJgUvjb2QcDBT/YNuhw0QC4LU9jZcBVzZ/zHDGuiy4aOViwgHrA
        q7ZQqoE+SsP7i9GwzcesYHj1LA==
X-Google-Smtp-Source: AJdET5cssFLzbGTS6x+FIjMI4toGo7e46JGbHlfJ4iPiYM2S0g773LbcVUBgb6Tug201jrn9gRnZfw==
X-Received: by 2002:a62:3a54:: with SMTP id h81-v6mr16315997pfa.119.1540841217423;
        Mon, 29 Oct 2018 12:26:57 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z4-v6sm30872024pgs.50.2018.10.29.12.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 12:26:56 -0700 (PDT)
Subject: [PATCH 2/2] Revert "lib: Add umoddi3 and udivmoddi4 of GCC library routines"
Date:   Mon, 29 Oct 2018 12:26:34 -0700
Message-Id: <20181029192634.30078-3-palmer@sifive.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181029192634.30078-1-palmer@sifive.com>
References: <20181029192634.30078-1-palmer@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        khandual@linux.vnet.ibm.com, colyli@suse.de,
        andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org,
        willy@infradead.org, yuanzhichang@hisilicon.com,
        matt.redfearn@mips.com, robh@kernel.org,
        boris.brezillon@bootlin.com, Greg KH <gregkh@linuxfoundation.org>,
        alexander.shishkin@linux.intel.com, ynorov@caviumnetworks.com,
        keescook@chromium.org, bigeasy@linutronix.de,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:      linux-riscv@lists.infradead.org, zongbox@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want 64-bit divide in the kernel.

This reverts commit 6315730e9eab7de5fa9864bb13a352713f48aef1.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 lib/Kconfig      |   3 -
 lib/Makefile     |   1 -
 lib/udivmoddi4.c | 310 -----------------------------------------------
 lib/umoddi3.c    |  32 -----
 4 files changed, 346 deletions(-)
 delete mode 100644 lib/udivmoddi4.c
 delete mode 100644 lib/umoddi3.c

diff --git a/lib/Kconfig b/lib/Kconfig
index d1573a16aa92..a9965f4af4dd 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -624,6 +624,3 @@ config GENERIC_LIB_CMPDI2
 
 config GENERIC_LIB_UCMPDI2
 	bool
-
-config GENERIC_LIB_UMODDI3
-	bool
diff --git a/lib/Makefile b/lib/Makefile
index 988949c4fd3a..db06d1237898 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -274,4 +274,3 @@ obj-$(CONFIG_GENERIC_LIB_LSHRDI3) += lshrdi3.o
 obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
 obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
 obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
-obj-$(CONFIG_GENERIC_LIB_UMODDI3) += umoddi3.o udivmoddi4.o
diff --git a/lib/udivmoddi4.c b/lib/udivmoddi4.c
deleted file mode 100644
index c08bc8a5f1cf..000000000000
--- a/lib/udivmoddi4.c
+++ /dev/null
@@ -1,310 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.
- */
-
-#include <linux/libgcc.h>
-
-#define count_leading_zeros(COUNT, X)   ((COUNT) = __builtin_clz(X))
-
-#define W_TYPE_SIZE 32
-
-#define __ll_B ((unsigned long) 1 << (W_TYPE_SIZE / 2))
-#define __ll_lowpart(t) ((unsigned long) (t) & (__ll_B - 1))
-#define __ll_highpart(t) ((unsigned long) (t) >> (W_TYPE_SIZE / 2))
-
-/* If we still don't have umul_ppmm, define it using plain C. */
-#if !defined(umul_ppmm)
-#define umul_ppmm(w1, w0, u, v)						\
-	do {								\
-		unsigned long __x0, __x1, __x2, __x3;			\
-		unsigned short __ul, __vl, __uh, __vh;			\
-									\
-		__ul = __ll_lowpart(u);					\
-		__uh = __ll_highpart(u);				\
-		__vl = __ll_lowpart(v);					\
-		__vh = __ll_highpart(v);				\
-									\
-		__x0 = (unsigned long) __ul * __vl;			\
-		__x1 = (unsigned long) __ul * __vh;			\
-		__x2 = (unsigned long) __uh * __vl;			\
-		__x3 = (unsigned long) __uh * __vh;			\
-									\
-		__x1 += __ll_highpart(__x0);				\
-		__x1 += __x2;						\
-		if (__x1 < __x2)					\
-			__x3 += __ll_B;					\
-									\
-		(w1) = __x3 + __ll_highpart(__x1);			\
-		(w0) = __ll_lowpart(__x1) * __ll_B + __ll_lowpart(__x0);\
-	} while (0)
-#endif
-
-#if !defined(sub_ddmmss)
-#define sub_ddmmss(sh, sl, ah, al, bh, bl)				\
-	do {								\
-		unsigned long __x;					\
-		__x = (al) - (bl);					\
-		(sh) = (ah) - (bh) - (__x > (al));			\
-		(sl) = __x;						\
-	} while (0)
-#endif
-
-/* Define this unconditionally, so it can be used for debugging. */
-#define __udiv_qrnnd_c(q, r, n1, n0, d)					\
-	do {								\
-		unsigned long __d1, __d0, __q1, __q0;			\
-		unsigned long __r1, __r0, __m;				\
-		__d1 = __ll_highpart(d);				\
-		__d0 = __ll_lowpart(d);				\
-									\
-		__r1 = (n1) % __d1;					\
-		__q1 = (n1) / __d1;					\
-		__m = (unsigned long) __q1 * __d0;			\
-		__r1 = __r1 * __ll_B | __ll_highpart(n0);		\
-		if (__r1 < __m) {					\
-			__q1--, __r1 += (d);				\
-			if (__r1 >= (d))				\
-				if (__r1 < __m)				\
-					__q1--, __r1 += (d);		\
-		}							\
-		__r1 -= __m;						\
-									\
-		__r0 = __r1 % __d1;					\
-		__q0 = __r1 / __d1;					\
-		__m = (unsigned long) __q0 * __d0;			\
-		__r0 = __r0 * __ll_B | __ll_lowpart(n0);		\
-		if (__r0 < __m) {					\
-			__q0--, __r0 += (d);				\
-			if (__r0 >= (d))				\
-				if (__r0 < __m)				\
-					__q0--, __r0 += (d);		\
-		}							\
-		__r0 -= __m;						\
-									\
-		(q) = (unsigned long) __q1 * __ll_B | __q0;		\
-		(r) = __r0;						\
-	} while (0)
-
-/* If udiv_qrnnd was not defined for this processor, use __udiv_qrnnd_c. */
-#if !defined(udiv_qrnnd)
-#define UDIV_NEEDS_NORMALIZATION 1
-#define udiv_qrnnd __udiv_qrnnd_c
-#endif
-
-unsigned long long __udivmoddi4(unsigned long long u, unsigned long long v,
-				unsigned long long *rp)
-{
-	const DWunion nn = {.ll = u };
-	const DWunion dd = {.ll = v };
-	DWunion rr, ww;
-	unsigned long d0, d1, n0, n1, n2;
-	unsigned long q0 = 0, q1 = 0;
-	unsigned long b, bm;
-
-	d0 = dd.s.low;
-	d1 = dd.s.high;
-	n0 = nn.s.low;
-	n1 = nn.s.high;
-
-#if !UDIV_NEEDS_NORMALIZATION
-
-	if (d1 == 0) {
-		if (d0 > n1) {
-			/* 0q = nn / 0D */
-
-			udiv_qrnnd(q0, n0, n1, n0, d0);
-			q1 = 0;
-
-			/* Remainder in n0. */
-		} else {
-			/* qq = NN / 0d */
-
-			if (d0 == 0)
-				/* Divide intentionally by zero. */
-				d0 = 1 / d0;
-
-			udiv_qrnnd(q1, n1, 0, n1, d0);
-			udiv_qrnnd(q0, n0, n1, n0, d0);
-
-			/* Remainder in n0. */
-		}
-
-		if (rp != 0) {
-			rr.s.low = n0;
-			rr.s.high = 0;
-			*rp = rr.ll;
-		}
-
-#else /* UDIV_NEEDS_NORMALIZATION */
-
-	if (d1 == 0) {
-		if (d0 > n1) {
-			/* 0q = nn / 0D */
-
-			count_leading_zeros(bm, d0);
-
-			if (bm != 0) {
-				/*
-				 * Normalize, i.e. make the most significant bit
-				 * of the denominator set.
-				 */
-
-				d0 = d0 << bm;
-				n1 = (n1 << bm) | (n0 >> (W_TYPE_SIZE - bm));
-				n0 = n0 << bm;
-			}
-
-			udiv_qrnnd(q0, n0, n1, n0, d0);
-			q1 = 0;
-
-			/* Remainder in n0 >> bm. */
-		} else {
-			/* qq = NN / 0d */
-
-			if (d0 == 0)
-				/* Divide intentionally by zero. */
-				d0 = 1 / d0;
-
-			count_leading_zeros(bm, d0);
-
-			if (bm == 0) {
-				/*
-				 * From (n1 >= d0) /\ (the most significant bit
-				 * of d0 is set), conclude (the most significant
-				 * bit of n1 is set) /\ (theleading quotient
-				 * digit q1 = 1).
-				 *
-				 * This special case is necessary, not an
-				 * optimization. (Shifts counts of W_TYPE_SIZE
-				 * are undefined.)
-				 */
-
-				n1 -= d0;
-				q1 = 1;
-			} else {
-				/* Normalize. */
-
-				b = W_TYPE_SIZE - bm;
-
-				d0 = d0 << bm;
-				n2 = n1 >> b;
-				n1 = (n1 << bm) | (n0 >> b);
-				n0 = n0 << bm;
-
-				udiv_qrnnd(q1, n1, n2, n1, d0);
-			}
-
-			/* n1 != d0... */
-
-			udiv_qrnnd(q0, n0, n1, n0, d0);
-
-			/* Remainder in n0 >> bm. */
-		}
-
-		if (rp != 0) {
-			rr.s.low = n0 >> bm;
-			rr.s.high = 0;
-			*rp = rr.ll;
-		}
-
-#endif /* UDIV_NEEDS_NORMALIZATION */
-
-	} else {
-		if (d1 > n1) {
-			/* 00 = nn / DD */
-
-			q0 = 0;
-			q1 = 0;
-
-			/* Remainder in n1n0. */
-			if (rp != 0) {
-				rr.s.low = n0;
-				rr.s.high = n1;
-				*rp = rr.ll;
-			}
-		} else {
-			/* 0q = NN / dd */
-
-			count_leading_zeros(bm, d1);
-			if (bm == 0) {
-				/*
-				 * From (n1 >= d1) /\ (the most significant bit
-				 * of d1 is set), conclude (the most significant
-				 * bit of n1 is set) /\ (the quotient digit q0 =
-				 * 0 or 1).
-				 *
-				 * This special case is necessary, not an
-				 * optimization.
-				 */
-
-				/*
-				 * The condition on the next line takes
-				 * advantage of that n1 >= d1 (true due to
-				 * program flow).
-				 */
-				if (n1 > d1 || n0 >= d0) {
-					q0 = 1;
-					sub_ddmmss(n1, n0, n1, n0, d1, d0);
-				} else {
-					q0 = 0;
-				}
-
-				q1 = 0;
-
-				if (rp != 0) {
-					rr.s.low = n0;
-					rr.s.high = n1;
-					*rp = rr.ll;
-				}
-			} else {
-				unsigned long m1, m0;
-				/* Normalize. */
-
-				b = W_TYPE_SIZE - bm;
-
-				d1 = (d1 << bm) | (d0 >> b);
-				d0 = d0 << bm;
-				n2 = n1 >> b;
-				n1 = (n1 << bm) | (n0 >> b);
-				n0 = n0 << bm;
-
-				udiv_qrnnd(q0, n1, n2, n1, d1);
-				umul_ppmm(m1, m0, q0, d0);
-
-				if (m1 > n1 || (m1 == n1 && m0 > n0)) {
-					q0--;
-					sub_ddmmss(m1, m0, m1, m0, d1, d0);
-				}
-
-				q1 = 0;
-
-				/* Remainder in (n1n0 - m1m0) >> bm. */
-				if (rp != 0) {
-					sub_ddmmss(n1, n0, n1, n0, m1, m0);
-					rr.s.low = (n1 << b) | (n0 >> bm);
-					rr.s.high = n1 >> bm;
-					*rp = rr.ll;
-				}
-			}
-		}
-	}
-
-	ww.s.low = q0;
-	ww.s.high = q1;
-
-	return ww.ll;
-}
diff --git a/lib/umoddi3.c b/lib/umoddi3.c
deleted file mode 100644
index d7bbf0f85197..000000000000
--- a/lib/umoddi3.c
+++ /dev/null
@@ -1,32 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.
- */
-
-#include <linux/module.h>
-#include <linux/libgcc.h>
-
-extern unsigned long long __udivmoddi4(unsigned long long u,
-				       unsigned long long v,
-				       unsigned long long *rp);
-
-unsigned long long __umoddi3(unsigned long long u, unsigned long long v)
-{
-	unsigned long long w;
-	(void)__udivmoddi4(u, v, &w);
-	return w;
-}
-EXPORT_SYMBOL(__umoddi3);
-- 
2.18.1

