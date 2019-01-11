Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E90CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7FC21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="cw9k9x+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbfAKIto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:49:44 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37045 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfAKItm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:49:42 -0500
Received: by mail-lf1-f65.google.com with SMTP id y11so10262542lfj.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 00:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8JlL2FJP+mcM8kBcFP2XtlvHyy25z/fTaIs7KBnQ+Js=;
        b=cw9k9x+E49NZSIaT11Nek9fVWdUWpVaD5hl89dRc4g6Uw4An61MsQ1NNVKO06O6pJ8
         JAytzn31dEQ/HQsnmtBF98c7oSAkLLc33jr+6vS+cCZNnazIZ7n0gwu5RVclq8q9oEoK
         jpN9Pp23vG68tp+yuo+WaCdGVHsbMUK9xFP7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8JlL2FJP+mcM8kBcFP2XtlvHyy25z/fTaIs7KBnQ+Js=;
        b=N7UzWqLgoPcXLohLBTXTH4s8aun0JnEmthX0mVpLVZEyfHs48KZppifmmN/o/rhHRG
         EZj9Ke8ySaFKA2fNEJHX38IvOx3cvr2AQFYL+ZU2vnu9Ul3l2Cgqdkr9mof88PGoLbF4
         u6l0BHagdYcU+zJkA2F6/20xFx6CinewEIqaT2HZiJyWRrrREc6WqaqUJ5jnhWE4lytB
         KSjsHUl/f+n4L6XuEeetcqO+kUo1MPrS6WgGCI0wSlKtXIXGkGjCQVsM/jQeLCIEoXqW
         M+vVdvlofZtMV5+NdzEzCUdD7jWjG5fRzOg7oXOx7ziGPex1ulaEePAkO7zA6t8ocbOL
         QiUg==
X-Gm-Message-State: AJcUukdDrgj75rtIeQ8ecVxisS6pSUxPnn3Vm/5kAWPlIZgy0eoM5yoW
        5DUOW5p6NySs9TR9gJsaoF3rww==
X-Google-Smtp-Source: ALg8bN6vO93FCcBZRhX/Fy74GAY3RforRGg4DbJV4eP6jYiOWvnSlIHgSfvmx2njukTPwNS/sHk+rw==
X-Received: by 2002:a19:a104:: with SMTP id k4mr7851321lfe.36.1547196579998;
        Fri, 11 Jan 2019 00:49:39 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s3-v6sm15860801lje.73.2019.01.11.00.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 00:49:39 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86: string_32.h: remove unused macro and inlines
Date:   Fri, 11 Jan 2019 09:49:31 +0100
Message-Id: <20190111084931.24601-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111084931.24601-1-linux@rasmusvillemoes.dk>
References: <20190111084931.24601-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing refers to the __constant_c_x_memset macro anymore, and when we
remove that, the two referenced static inline functions become orphan.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/x86/include/asm/string_32.h | 84 --------------------------------
 1 file changed, 84 deletions(-)

diff --git a/arch/x86/include/asm/string_32.h b/arch/x86/include/asm/string_32.h
index 2fd165f1cffa..f74362b05619 100644
--- a/arch/x86/include/asm/string_32.h
+++ b/arch/x86/include/asm/string_32.h
@@ -209,29 +209,6 @@ static inline void *__memset_generic(void *s, char c, size_t count)
 /* we might want to write optimized versions of these later */
 #define __constant_count_memset(s, c, count) __memset_generic((s), (c), (count))
 
-/*
- * memset(x, 0, y) is a reasonably common thing to do, so we want to fill
- * things 32 bits at a time even when we don't know the size of the
- * area at compile-time..
- */
-static __always_inline
-void *__constant_c_memset(void *s, unsigned long c, size_t count)
-{
-	int d0, d1;
-	asm volatile("rep ; stosl\n\t"
-		     "testb $2,%b3\n\t"
-		     "je 1f\n\t"
-		     "stosw\n"
-		     "1:\ttestb $1,%b3\n\t"
-		     "je 2f\n\t"
-		     "stosb\n"
-		     "2:"
-		     : "=&c" (d0), "=&D" (d1)
-		     : "a" (c), "q" (count), "0" (count/4), "1" ((long)s)
-		     : "memory");
-	return s;
-}
-
 /* Added by Gertjan van Wingerde to make minix and sysv module work */
 #define __HAVE_ARCH_STRNLEN
 extern size_t strnlen(const char *s, size_t count);
@@ -240,67 +217,6 @@ extern size_t strnlen(const char *s, size_t count);
 #define __HAVE_ARCH_STRSTR
 extern char *strstr(const char *cs, const char *ct);
 
-/*
- * This looks horribly ugly, but the compiler can optimize it totally,
- * as we by now know that both pattern and count is constant..
- */
-static __always_inline
-void *__constant_c_and_count_memset(void *s, unsigned long pattern,
-				    size_t count)
-{
-	switch (count) {
-	case 0:
-		return s;
-	case 1:
-		*(unsigned char *)s = pattern & 0xff;
-		return s;
-	case 2:
-		*(unsigned short *)s = pattern & 0xffff;
-		return s;
-	case 3:
-		*(unsigned short *)s = pattern & 0xffff;
-		*((unsigned char *)s + 2) = pattern & 0xff;
-		return s;
-	case 4:
-		*(unsigned long *)s = pattern;
-		return s;
-	}
-
-#define COMMON(x)							\
-	asm volatile("rep ; stosl"					\
-		     x							\
-		     : "=&c" (d0), "=&D" (d1)				\
-		     : "a" (eax), "0" (count/4), "1" ((long)s)	\
-		     : "memory")
-
-	{
-		int d0, d1;
-		unsigned long eax = pattern;
-
-		switch (count % 4) {
-		case 0:
-			COMMON("");
-			return s;
-		case 1:
-			COMMON("\n\tstosb");
-			return s;
-		case 2:
-			COMMON("\n\tstosw");
-			return s;
-		default:
-			COMMON("\n\tstosw\n\tstosb");
-			return s;
-		}
-	}
-
-#undef COMMON
-}
-
-#define __constant_c_x_memset(s, c, count)			\
-	(__builtin_constant_p(count)				\
-	 ? __constant_c_and_count_memset((s), (c), (count))	\
-	 : __constant_c_memset((s), (c), (count)))
-
 #define __memset(s, c, count)				\
 	(__builtin_constant_p(count)			\
 	 ? __constant_count_memset((s), (c), (count))	\
-- 
2.20.1

