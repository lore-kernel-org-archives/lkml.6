Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65778ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FB521471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDVeQGzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FB521471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbeIROwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:52:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37576 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeIROwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:52:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id 2-v6so734181pgo.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 02:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NN7QfFhaUIrbkblz9fe0BCttQGiR10LAyGLSoFsf6/U=;
        b=IDVeQGzIeOBFp9p+IJfv2lr7cBUswXB+BHzziVITCeMKIkZgyi+WFdiIOdPqGJZmQx
         7yTV2sLkz/WfQNjrLS0WrxVEHv4MSyFhJ4sUdf7HQ5Tqk+9WYecHeV4CZAweJ/6AP8oR
         xdryniksCMCy9UfHuix1JLU4KXK0miwX+Ma08SOvNSEMg/4X4Ta2UbDjuXrmH+ClFOfv
         8NFoZNO9kpwnxmRyYuVPE5GwjhFTsC65Swzes3z/4v4OeSGWAR3Dql/qTlLDaK4FjSK0
         x/uqac6sH2R3uoqjDkHLUqNcdTm91jOZ5SW4NBF75rRSiTx2OnCLwWURq6ipFpS+azmv
         K93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NN7QfFhaUIrbkblz9fe0BCttQGiR10LAyGLSoFsf6/U=;
        b=Ttp8NvulqcyshMoEKQWj7TWYnvldrk3f3Xe/C1m9XgkrVS5YPP3BsoJsGKFX3mJDjk
         qvJI2SEeBTUatLykmAqY23X67/sKw0BIHKQT8EClCzichMKhh8adrytGupzZqiPSRwlD
         CHelUFuSe+djl/m5t3CNow72PpF0NQUS7kTWdtlwAdwaa3eING4JUu3QXGLHmpM3+y8W
         iLtkv36S+Sh1esV2IbDKQLIyZkz3vKjQaJXFjyiQ+zJp13wqXtxCaZlUXgnZNs2Apcos
         vB2d85nBnufmLyIdr+Y+aLWV0yB/l66+OnDjz23etKlrOFUsaQXImPU1wBBK7qNAnb3r
         rp0w==
X-Gm-Message-State: APzg51BNjKJQ+XRreohpj7eIu4AFPcnq+CYe5P5Zv+OgJbQnmDIE7UeM
        cHkjffOrPSTGOf0/2benJ78wt/jNDaI=
X-Google-Smtp-Source: ANB0VdZ2Gpxwg0ruJi8Ml4L2aHPKTkYKdNBeT5ATwbRhhZdamm/mWQanGYVdGwOiPWq5vAJH2FzTjw==
X-Received: by 2002:a62:9683:: with SMTP id s3-v6mr29963428pfk.191.1537262453955;
        Tue, 18 Sep 2018 02:20:53 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id 1-v6sm29932877pfm.145.2018.09.18.02.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 02:20:53 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     vincentc@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, zong@andestech.com,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH 3/5] lib: Add umoddi3 and udivmoddi4 of GCC library routines
Date:   Tue, 18 Sep 2018 17:19:15 +0800
Message-Id: <2ccc6c0758624dbb22f6fe451a3e476a000108ef.1537260207.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1537260207.git.zongbox@gmail.com>
References: <cover.1537260207.git.zongbox@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add umoddi3 and udivmoddi4 support for 32-bit.

Signed-off-by: Zong Li <zong@andestech.com>
---
 lib/Kconfig      |   3 +
 lib/Makefile     |   1 +
 lib/udivmoddi4.c | 291 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/umoddi3.c    |  16 +++
 4 files changed, 311 insertions(+)
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
index 0000000..69f2d36
--- /dev/null
+++ b/lib/udivmoddi4.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0
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
+	return ww.ll;
+}
diff --git a/lib/umoddi3.c b/lib/umoddi3.c
new file mode 100644
index 0000000..85b2b86
--- /dev/null
+++ b/lib/umoddi3.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
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

