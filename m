Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416B9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084252084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="VBFMwJDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbfAKItk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:49:40 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38378 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfAKItk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:49:40 -0500
Received: by mail-lf1-f66.google.com with SMTP id a8so10245284lfk.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 00:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oC6ziq5fxiVzD7cELc4jGVaxms6bqh5WYS64Kd13oII=;
        b=VBFMwJDZh5yOkp5aZG3ywcXU2ZcM8OSw6hv0AMn/3R5g74O5661p3ZqKbYOOrhR/lX
         jbGcxiUcbc6/noL3ZZKhCsmoQGMEpOvkB6fGCBPjTBeM5ae+X9IwZoF4dESIF1RR+6HC
         4Jrz11CPKGXZZ7g8RGKPd6B74NETsTLZKoJOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oC6ziq5fxiVzD7cELc4jGVaxms6bqh5WYS64Kd13oII=;
        b=DJdLPKtgVO1lYDKjPbfqcdGDN2mdis1gw0pQFOBIulSJKvZWWd2VxWTqdFwQlNiIt9
         4mFieNSB+H6sAkoGpF3ApNBM6yFpzkPZ1a/cqWNeMuFWcAv16tksDrZDk/RR1lySVqMm
         4dZmvPKPRrdWgwSvXxi6Hm8kPyzUQEQHG0ciwcnSB9YBLhNpTRcRxPGG434G7pnt0TvW
         UuaEXHg3R4t4uaaY2hjTnAxsdWBqnwugRPNvt/jql2DAdJVqdeQyG6IkZjmsxaErA/EO
         ovIPMMuimxO4wAjEv10dluwE+BgZju+76xrYE+3gzvBfX9Nkum8OrCnyy5l+TkwAQCRp
         A41Q==
X-Gm-Message-State: AJcUukfzjUkno1BUISGyBAas/FU/71Pu3tsfEEVHGjne33fw6NSIXwfc
        dcpRsxLoYccGCNBE1vNH1YSJbA==
X-Google-Smtp-Source: ALg8bN4OGm6Ng4UZaLLnaIjVkBfWXRPOxVLCQnGENerh5jm0nQv/Np86/B6UUyiFKMcC2EV64TIfrg==
X-Received: by 2002:a19:2106:: with SMTP id h6mr7427434lfh.29.1547196578026;
        Fri, 11 Jan 2019 00:49:38 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s3-v6sm15860801lje.73.2019.01.11.00.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 00:49:37 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/include: remove dead __GNUC__ conditionals
Date:   Fri, 11 Jan 2019 09:49:30 +0100
Message-Id: <20190111084931.24601-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We require gcc >= 4.6, so these can be removed.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/x86/include/asm/bitops.h    |  6 ------
 arch/x86/include/asm/string_32.h | 20 --------------------
 arch/x86/include/asm/string_64.h | 15 ---------------
 3 files changed, 41 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index ad7b210aa3f6..d153d570bb04 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -36,13 +36,7 @@
  * bit 0 is the LSB of addr; bit 32 is the LSB of (addr+1).
  */
 
-#if __GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ < 1)
-/* Technically wrong, but this avoids compilation errors on some gcc
-   versions. */
-#define BITOP_ADDR(x) "=m" (*(volatile long *) (x))
-#else
 #define BITOP_ADDR(x) "+m" (*(volatile long *) (x))
-#endif
 
 #define ADDR				BITOP_ADDR(addr)
 
diff --git a/arch/x86/include/asm/string_32.h b/arch/x86/include/asm/string_32.h
index 55d392c6bd29..2fd165f1cffa 100644
--- a/arch/x86/include/asm/string_32.h
+++ b/arch/x86/include/asm/string_32.h
@@ -179,14 +179,7 @@ static inline void *__memcpy3d(void *to, const void *from, size_t len)
  *	No 3D Now!
  */
 
-#if (__GNUC__ >= 4)
 #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
-#else
-#define memcpy(t, f, n)				\
-	(__builtin_constant_p((n))		\
-	 ? __constant_memcpy((t), (f), (n))	\
-	 : __memcpy((t), (f), (n)))
-#endif
 
 #endif
 #endif /* !CONFIG_FORTIFY_SOURCE */
@@ -282,12 +275,7 @@ void *__constant_c_and_count_memset(void *s, unsigned long pattern,
 
 	{
 		int d0, d1;
-#if __GNUC__ == 4 && __GNUC_MINOR__ == 0
-		/* Workaround for broken gcc 4.0 */
-		register unsigned long eax asm("%eax") = pattern;
-#else
 		unsigned long eax = pattern;
-#endif
 
 		switch (count % 4) {
 		case 0:
@@ -321,15 +309,7 @@ void *__constant_c_and_count_memset(void *s, unsigned long pattern,
 #define __HAVE_ARCH_MEMSET
 extern void *memset(void *, int, size_t);
 #ifndef CONFIG_FORTIFY_SOURCE
-#if (__GNUC__ >= 4)
 #define memset(s, c, count) __builtin_memset(s, c, count)
-#else
-#define memset(s, c, count)						\
-	(__builtin_constant_p(c)					\
-	 ? __constant_c_x_memset((s), (0x01010101UL * (unsigned char)(c)), \
-				 (count))				\
-	 : __memset((s), (c), (count)))
-#endif
 #endif /* !CONFIG_FORTIFY_SOURCE */
 
 #define __HAVE_ARCH_MEMSET16
diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 4e4194e21a09..75314c3dbe47 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -14,21 +14,6 @@
 extern void *memcpy(void *to, const void *from, size_t len);
 extern void *__memcpy(void *to, const void *from, size_t len);
 
-#ifndef CONFIG_FORTIFY_SOURCE
-#if (__GNUC__ == 4 && __GNUC_MINOR__ < 3) || __GNUC__ < 4
-#define memcpy(dst, src, len)					\
-({								\
-	size_t __len = (len);					\
-	void *__ret;						\
-	if (__builtin_constant_p(len) && __len >= 64)		\
-		__ret = __memcpy((dst), (src), __len);		\
-	else							\
-		__ret = __builtin_memcpy((dst), (src), __len);	\
-	__ret;							\
-})
-#endif
-#endif /* !CONFIG_FORTIFY_SOURCE */
-
 #define __HAVE_ARCH_MEMSET
 void *memset(void *s, int c, size_t n);
 void *__memset(void *s, int c, size_t n);
-- 
2.20.1

