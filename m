Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF07CC65BA7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2C2208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swquZCyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2C2208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJCJ7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 05:59:12 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41331 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeJCJ7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 05:59:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id q17-v6so2707826plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 20:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KVriMd+NJqUjin+7AL5q2vB4qBdyQ6TJdFXFHCuDqVc=;
        b=swquZCyBOpp1FaTr+TmfLoF1tnpo/ZfZfwEyHLz9pGiV4tV/Oig2Ar1lEjuFwqafpw
         6xPy/gHSr4lb/RwLSB6vGjF5T+Yj9HB23ILbXGASz1GyFViq6/r1EY/aqMQCFgXRVfI5
         sn6fdy2gvptJa3QW2YyxLYgnuXxUAcGtq890VgZzLpi4USEkDXhzHXkHKdz7aU2p8Ka+
         jNEA2pjyr4/HUMOr48vwdU9TId76qOReVl2V71OluBe8DAoJ3fqaJhGPnh3p42UF608z
         habS4xLvbGf19f67c2Tmv54vk5yVaIBCBit2LINAelbJJY/DWesSMg+0OHWx2Tv8HYoj
         IxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KVriMd+NJqUjin+7AL5q2vB4qBdyQ6TJdFXFHCuDqVc=;
        b=goAASHk50hRmohqQuUNkXnctEE1cExrDas9p3rug03O09iLujKIuQFipKKkUaKGhVv
         RxvlamSAKt1Jsr0QRGknFChm6wr9gyns1Gx0zppNoSP1HhdWBcDzMtvnb5UsCYe/stTl
         mMG9lDyTwKt4AIs03Clp8SCQdIQwyiYmiQUhyo+zQTsCJmbHV25sb3aclvaEK8abKrNa
         EDh11LNP96vaG49kuqNu2wjiMnNdEyhKYzC1OcDu8nye3LecU4V5eWv6Ghqv0HeG8W5m
         oNgj6aVmiRRS0e3ePzwJbbi3+uogHGiSZbhOew1ASNSTUvWVNmz15DgS76TW6iixqcUx
         k0Og==
X-Gm-Message-State: ABuFfojBXjTsbNVATWq0KNQxJ/S8qz7NZkRmNKT5uXKHECB9qzHXBvvo
        9v+yVUeVlP/Rqdbz77IayNU=
X-Google-Smtp-Source: ACcGV62oXR4mRqaoVIg5zHK21rh8cRrMHrYY63hPQGKLTS58iNRstLeVmLWaF0BwYaar+9glZCm3IQ==
X-Received: by 2002:a17:902:7887:: with SMTP id q7-v6mr19513029pll.111.1538536365129;
        Tue, 02 Oct 2018 20:12:45 -0700 (PDT)
Received: from app09.andestech.com (59-120-53-16.HINET-IP.hinet.net. [59.120.53.16])
        by smtp.gmail.com with ESMTPSA id v23-v6sm21777747pfm.80.2018.10.02.20.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 20:12:44 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     hch@infradead.org, zong@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH v4 3/5] lib: Add umoddi3 and udivmoddi4 of GCC library routines
Date:   Wed,  3 Oct 2018 11:10:00 +0800
Message-Id: <779b0b25cc96101a525402f38053db5e2f360d6f.1538535528.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1538535527.git.zongbox@gmail.com>
References: <cover.1538535527.git.zongbox@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add umoddi3 and udivmoddi4 support for 32-bit.

The RV32 need the umoddi3 to do modulo when the operands are long long
type, like other libraries implementation such as ucmpdi2, lshrdi3 and
so on.

I encounter the undefined reference 'umoddi3' when I use the in
house dma driver, although it is in house driver, but I think that
umoddi3 is a common function for RV32.

The udivmoddi4 and umoddi3 are copies from libgcc in gcc 4.2.1.
There are other functions use the udivmoddi4 in libgcc, so I separate
the umoddi3 and udivmoddi4 for flexible extension in the future.

Signed-off-by: Zong Li <zong@andestech.com>
---
 lib/Kconfig      |   3 +
 lib/Makefile     |   1 +
 lib/udivmoddi4.c | 326 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/umoddi3.c    |  48 ++++++++
 4 files changed, 378 insertions(+)
 create mode 100644 lib/udivmoddi4.c
 create mode 100644 lib/umoddi3.c

diff --git a/lib/Kconfig b/lib/Kconfig
index a3928d4..d82f206 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -621,3 +621,6 @@ config GENERIC_LIB_CMPDI2
 
 config GENERIC_LIB_UCMPDI2
 	bool
+
+config GENERIC_LIB_UMODDI3
+	bool
diff --git a/lib/Makefile b/lib/Makefile
index ca3f7eb..51bf24d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -271,3 +271,4 @@ obj-$(CONFIG_GENERIC_LIB_LSHRDI3) += lshrdi3.o
 obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
 obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
 obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
+obj-$(CONFIG_GENERIC_LIB_UMODDI3) += umoddi3.o udivmoddi4.o
diff --git a/lib/udivmoddi4.c b/lib/udivmoddi4.c
new file mode 100644
index 0000000..ddbe4fa
--- /dev/null
+++ b/lib/udivmoddi4.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* More subroutines needed by GCC output code on some machines.  */
+/* Compile this one with gcc.  */
+/* Copyright (C) 1989, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999,
+ * 2000, 2001, 2002, 2003, 2004, 2005  Free Software Foundation, Inc.
+ *
+ * This file is part of GCC.
+ *
+ * GCC is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2, or (at your option) any later
+ * version.
+ *
+ * In addition to the permissions in the GNU General Public License, the
+ * Free Software Foundation gives you unlimited permission to link the
+ * compiled version of this file into combinations with other programs,
+ * and to distribute those combinations without any restriction coming
+ * from the use of this file.  (The General Public License restrictions
+ * do apply in other respects; for example, they cover modification of
+ * the file, and distribution when not linked into a combine
+ * executable.)
+ *
+ * GCC is distributed in the hope that it will be useful, but WITHOUT ANY
+ * WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with GCC; see the file COPYING.  If not, write to the Free
+ * Software Foundation, 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+
+#include <linux/libgcc.h>
+
+#define count_leading_zeros(COUNT, X)   ((COUNT) = __builtin_clz(X))
+
+#define W_TYPE_SIZE 32
+
+#define __ll_B ((unsigned long) 1 << (W_TYPE_SIZE / 2))
+#define __ll_lowpart(t) ((unsigned long) (t) & (__ll_B - 1))
+#define __ll_highpart(t) ((unsigned long) (t) >> (W_TYPE_SIZE / 2))
+
+/* If we still don't have umul_ppmm, define it using plain C. */
+#if !defined(umul_ppmm)
+#define umul_ppmm(w1, w0, u, v)						\
+	do {								\
+		unsigned long __x0, __x1, __x2, __x3;			\
+		unsigned short __ul, __vl, __uh, __vh;			\
+									\
+		__ul = __ll_lowpart(u);					\
+		__uh = __ll_highpart(u);				\
+		__vl = __ll_lowpart(v);					\
+		__vh = __ll_highpart(v);				\
+									\
+		__x0 = (unsigned long) __ul * __vl;			\
+		__x1 = (unsigned long) __ul * __vh;			\
+		__x2 = (unsigned long) __uh * __vl;			\
+		__x3 = (unsigned long) __uh * __vh;			\
+									\
+		__x1 += __ll_highpart(__x0);				\
+		__x1 += __x2;						\
+		if (__x1 < __x2)					\
+			__x3 += __ll_B;					\
+									\
+		(w1) = __x3 + __ll_highpart(__x1);			\
+		(w0) = __ll_lowpart(__x1) * __ll_B + __ll_lowpart(__x0);\
+	} while (0)
+#endif
+
+#if !defined(sub_ddmmss)
+#define sub_ddmmss(sh, sl, ah, al, bh, bl)				\
+	do {								\
+		unsigned long __x;					\
+		__x = (al) - (bl);					\
+		(sh) = (ah) - (bh) - (__x > (al));			\
+		(sl) = __x;						\
+	} while (0)
+#endif
+
+/* Define this unconditionally, so it can be used for debugging. */
+#define __udiv_qrnnd_c(q, r, n1, n0, d)					\
+	do {								\
+		unsigned long __d1, __d0, __q1, __q0;			\
+		unsigned long __r1, __r0, __m;				\
+		__d1 = __ll_highpart(d);				\
+		__d0 = __ll_lowpart(d);				\
+									\
+		__r1 = (n1) % __d1;					\
+		__q1 = (n1) / __d1;					\
+		__m = (unsigned long) __q1 * __d0;			\
+		__r1 = __r1 * __ll_B | __ll_highpart(n0);		\
+		if (__r1 < __m) {					\
+			__q1--, __r1 += (d);				\
+			if (__r1 >= (d))				\
+				if (__r1 < __m)				\
+					__q1--, __r1 += (d);		\
+		}							\
+		__r1 -= __m;						\
+									\
+		__r0 = __r1 % __d1;					\
+		__q0 = __r1 / __d1;					\
+		__m = (unsigned long) __q0 * __d0;			\
+		__r0 = __r0 * __ll_B | __ll_lowpart(n0);		\
+		if (__r0 < __m) {					\
+			__q0--, __r0 += (d);				\
+			if (__r0 >= (d))				\
+				if (__r0 < __m)				\
+					__q0--, __r0 += (d);		\
+		}							\
+		__r0 -= __m;						\
+									\
+		(q) = (unsigned long) __q1 * __ll_B | __q0;		\
+		(r) = __r0;						\
+	} while (0)
+
+/* If udiv_qrnnd was not defined for this processor, use __udiv_qrnnd_c. */
+#if !defined(udiv_qrnnd)
+#define UDIV_NEEDS_NORMALIZATION 1
+#define udiv_qrnnd __udiv_qrnnd_c
+#endif
+
+unsigned long long __udivmoddi4(unsigned long long u, unsigned long long v,
+				unsigned long long *rp)
+{
+	const DWunion nn = {.ll = u };
+	const DWunion dd = {.ll = v };
+	DWunion rr, ww;
+	unsigned long d0, d1, n0, n1, n2;
+	unsigned long q0 = 0, q1 = 0;
+	unsigned long b, bm;
+
+	d0 = dd.s.low;
+	d1 = dd.s.high;
+	n0 = nn.s.low;
+	n1 = nn.s.high;
+
+#if !UDIV_NEEDS_NORMALIZATION
+
+	if (d1 == 0) {
+		if (d0 > n1) {
+			/* 0q = nn / 0D */
+
+			udiv_qrnnd(q0, n0, n1, n0, d0);
+			q1 = 0;
+
+			/* Remainder in n0. */
+		} else {
+			/* qq = NN / 0d */
+
+			if (d0 == 0)
+				/* Divide intentionally by zero. */
+				d0 = 1 / d0;
+
+			udiv_qrnnd(q1, n1, 0, n1, d0);
+			udiv_qrnnd(q0, n0, n1, n0, d0);
+
+			/* Remainder in n0. */
+		}
+
+		if (rp != 0) {
+			rr.s.low = n0;
+			rr.s.high = 0;
+			*rp = rr.ll;
+		}
+
+#else /* UDIV_NEEDS_NORMALIZATION */
+
+	if (d1 == 0) {
+		if (d0 > n1) {
+			/* 0q = nn / 0D */
+
+			count_leading_zeros(bm, d0);
+
+			if (bm != 0) {
+				/*
+				 * Normalize, i.e. make the most significant bit
+				 * of the denominator set.
+				 */
+
+				d0 = d0 << bm;
+				n1 = (n1 << bm) | (n0 >> (W_TYPE_SIZE - bm));
+				n0 = n0 << bm;
+			}
+
+			udiv_qrnnd(q0, n0, n1, n0, d0);
+			q1 = 0;
+
+			/* Remainder in n0 >> bm. */
+		} else {
+			/* qq = NN / 0d */
+
+			if (d0 == 0)
+				/* Divide intentionally by zero. */
+				d0 = 1 / d0;
+
+			count_leading_zeros(bm, d0);
+
+			if (bm == 0) {
+				/*
+				 * From (n1 >= d0) /\ (the most significant bit
+				 * of d0 is set), conclude (the most significant
+				 * bit of n1 is set) /\ (theleading quotient
+				 * digit q1 = 1).
+				 *
+				 * This special case is necessary, not an
+				 * optimization. (Shifts counts of W_TYPE_SIZE
+				 * are undefined.)
+				 */
+
+				n1 -= d0;
+				q1 = 1;
+			} else {
+				/* Normalize. */
+
+				b = W_TYPE_SIZE - bm;
+
+				d0 = d0 << bm;
+				n2 = n1 >> b;
+				n1 = (n1 << bm) | (n0 >> b);
+				n0 = n0 << bm;
+
+				udiv_qrnnd(q1, n1, n2, n1, d0);
+			}
+
+			/* n1 != d0... */
+
+			udiv_qrnnd(q0, n0, n1, n0, d0);
+
+			/* Remainder in n0 >> bm. */
+		}
+
+		if (rp != 0) {
+			rr.s.low = n0 >> bm;
+			rr.s.high = 0;
+			*rp = rr.ll;
+		}
+
+#endif /* UDIV_NEEDS_NORMALIZATION */
+
+	} else {
+		if (d1 > n1) {
+			/* 00 = nn / DD */
+
+			q0 = 0;
+			q1 = 0;
+
+			/* Remainder in n1n0. */
+			if (rp != 0) {
+				rr.s.low = n0;
+				rr.s.high = n1;
+				*rp = rr.ll;
+			}
+		} else {
+			/* 0q = NN / dd */
+
+			count_leading_zeros(bm, d1);
+			if (bm == 0) {
+				/*
+				 * From (n1 >= d1) /\ (the most significant bit
+				 * of d1 is set), conclude (the most significant
+				 * bit of n1 is set) /\ (the quotient digit q0 =
+				 * 0 or 1).
+				 *
+				 * This special case is necessary, not an
+				 * optimization.
+				 */
+
+				/*
+				 * The condition on the next line takes
+				 * advantage of that n1 >= d1 (true due to
+				 * program flow).
+				 */
+				if (n1 > d1 || n0 >= d0) {
+					q0 = 1;
+					sub_ddmmss(n1, n0, n1, n0, d1, d0);
+				} else {
+					q0 = 0;
+				}
+
+				q1 = 0;
+
+				if (rp != 0) {
+					rr.s.low = n0;
+					rr.s.high = n1;
+					*rp = rr.ll;
+				}
+			} else {
+				unsigned long m1, m0;
+				/* Normalize. */
+
+				b = W_TYPE_SIZE - bm;
+
+				d1 = (d1 << bm) | (d0 >> b);
+				d0 = d0 << bm;
+				n2 = n1 >> b;
+				n1 = (n1 << bm) | (n0 >> b);
+				n0 = n0 << bm;
+
+				udiv_qrnnd(q0, n1, n2, n1, d1);
+				umul_ppmm(m1, m0, q0, d0);
+
+				if (m1 > n1 || (m1 == n1 && m0 > n0)) {
+					q0--;
+					sub_ddmmss(m1, m0, m1, m0, d1, d0);
+				}
+
+				q1 = 0;
+
+				/* Remainder in (n1n0 - m1m0) >> bm. */
+				if (rp != 0) {
+					sub_ddmmss(n1, n0, n1, n0, m1, m0);
+					rr.s.low = (n1 << b) | (n0 >> bm);
+					rr.s.high = n1 >> bm;
+					*rp = rr.ll;
+				}
+			}
+		}
+	}
+
+	ww.s.low = q0;
+	ww.s.high = q1;
+
+	return ww.ll;
+}
diff --git a/lib/umoddi3.c b/lib/umoddi3.c
new file mode 100644
index 0000000..153961f
--- /dev/null
+++ b/lib/umoddi3.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* More subroutines needed by GCC output code on some machines.  */
+/* Compile this one with gcc.  */
+/* Copyright (C) 1989, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999,
+ * 2000, 2001, 2002, 2003, 2004, 2005  Free Software Foundation, Inc.
+ *
+ * This file is part of GCC.
+ *
+ * GCC is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2, or (at your option) any later
+ * version.
+ *
+ * In addition to the permissions in the GNU General Public License, the
+ * Free Software Foundation gives you unlimited permission to link the
+ * compiled version of this file into combinations with other programs,
+ * and to distribute those combinations without any restriction coming
+ * from the use of this file.  (The General Public License restrictions
+ * do apply in other respects; for example, they cover modification of
+ * the file, and distribution when not linked into a combine
+ * executable.)
+ *
+ * GCC is distributed in the hope that it will be useful, but WITHOUT ANY
+ * WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with GCC; see the file COPYING.  If not, write to the Free
+ * Software Foundation, 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/libgcc.h>
+
+extern unsigned long long __udivmoddi4(unsigned long long u,
+				       unsigned long long v,
+				       unsigned long long *rp);
+
+unsigned long long __umoddi3(unsigned long long u, unsigned long long v)
+{
+	unsigned long long w;
+	(void)__udivmoddi4(u, v, &w);
+	return w;
+}
+EXPORT_SYMBOL(__umoddi3);
-- 
2.7.4

