Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA1AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FAE20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn/6HF/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00FAE20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeJBPlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:41:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33108 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeJBPll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:41:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id s4-v6so656274plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 01:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+qTsaXWzvSPB3bgxqanTaYEbSHGn3qx/htIPeNdvvd4=;
        b=Hn/6HF/ZsOL7X3ZDvarV5npC2YaabQM5TFNLhlqb8WIW91KvwcbLry3ousdwVnzNgm
         ka3hjwVRVpvlKHRDPUqaFCJBe5XG9e/xI03K+XFQik03n/cIm2Dixn2bod0i0X/x5Pkr
         ydC2qmq4w1CRc7C11khB+c6WLF+R5yTpDyMYK2Y3nyg4WDSAd5jXq8QVAwttGKQkl1p+
         jVM/rHQlp7YsjZceMyq+PAkuN2GC8wTs03tdKadNhTOw/HZMevKwIszvN3HwoaCqeXO/
         NTpHhqyE0IyTvvs33sZ7+3tnnDA2wZz13q678gZWT6Cp0Da5fAeyZS8aHKwsX0oPMuYN
         nCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+qTsaXWzvSPB3bgxqanTaYEbSHGn3qx/htIPeNdvvd4=;
        b=mKbRg/VUSOYl6+XtoRuRkYfQQvCNwKpuRqI8SOSwkAjcjW/8A92SXKfSBStTYR34uV
         +xbYuKEeBcFRlXcWrWHpNRNUa9pwGbHC3r82WECoRO43PLGOrPCZ8tmW19fh5LhIdST3
         ijqp9aFnyUNHa0jPb8IrwZ2OF4l8QlAF0Bv7XaULUmfC3/lJ6QhDlN/z5R5Mf5AtUxJo
         msn0Z/v4pADYN/J1SJmvmejZr8rkx25bFwiqkgBrCDahxVLybAGbO93sDRhyCwNW8vA6
         ae7MNFAn+njG1l6DCdZBxHwpkDr4+3n5YsDTJ8bENTA7RZmeIrPGOnrNmszRd0ZXKxHh
         tSYQ==
X-Gm-Message-State: ABuFfoh7FGZGCol4F4WI4kfGka4zNG55N1/AWcjv1rYCRxnPpUb/sUR4
        HdCRxlQrMjbsWBP1vtRTBcA=
X-Google-Smtp-Source: ACcGV6113w/0IuyhZfz13AfDlk8OEesu3iFQtxJuzx6l8MDdIh96KNbVcya2rrvtmunJd0bLnCPE2Q==
X-Received: by 2002:a63:4b25:: with SMTP id y37-v6mr13561991pga.14.1538470767524;
        Tue, 02 Oct 2018 01:59:27 -0700 (PDT)
Received: from app09.andestech.com (59-120-53-16.HINET-IP.hinet.net. [59.120.53.16])
        by smtp.gmail.com with ESMTPSA id 62-v6sm5057927pgc.58.2018.10.02.01.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 01:59:26 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     hch@infradead.org, zong@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH v3 3/5] lib: Add umoddi3 and udivmoddi4 of GCC library routines
Date:   Tue,  2 Oct 2018 16:52:29 +0800
Message-Id: <2144f372b95f236afe47da4fc575a42ec95e8239.1538470103.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1538470103.git.zongbox@gmail.com>
References: <cover.1538470103.git.zongbox@gmail.com>
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

The udivmoddi4 and umoddi3 are copies from libgcc in gcc. There are other
functions use the udivmoddi4 in libgcc, so I separate the umoddi3 and
udivmoddi4 for flexible extension in the future.

Signed-off-by: Zong Li <zong@andestech.com>
---
 lib/Kconfig      |   3 +
 lib/Makefile     |   1 +
 lib/udivmoddi4.c | 310 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/umoddi3.c    |  32 ++++++
 4 files changed, 346 insertions(+)
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
index 0000000..c08bc8a
--- /dev/null
+++ b/lib/udivmoddi4.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.
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
index 0000000..d7bbf0f
--- /dev/null
+++ b/lib/umoddi3.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.
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

