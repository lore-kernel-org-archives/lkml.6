Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4B9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5643420835
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlUjtXkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5643420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeHaVNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:13:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40981 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbeHaVNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:13:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id z96-v6so11850399wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0v/+Zwx16Fnpgc4bSyVBE5da4LsVXCU9DjhKCldisdI=;
        b=RlUjtXkwdrUqd8rTAnNhtDpeq8I9tWN+zOQ6Yp+1Ycp4EZ5NlGLP/2NkkUs0Uc5CEG
         NyvQRSwvJUKKnSjF7XoLF0MmJUVJ7jFcxal/21x2IjUo9lblVIeZttWigs6CUmxT2W5h
         zOTIsLE7IwkX5Nx9LAzFaG7mcFUrF+A9QJZ29BNPsSlDjDV7dp0cnAcmi5vZAd5VnLst
         vtKhMZYncCk+1irgbrpkW/BFOKkoFxFaUqkxMJ0Uu087EQD3O/LpJBm7WznpYnMWUDnm
         Eo48WtNs3LmBkMqS+aExAAwfpGSOecsIN3ya+IT5b5D1XT2T+z9vHVgfqJ3+xp0KqnyF
         5SKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0v/+Zwx16Fnpgc4bSyVBE5da4LsVXCU9DjhKCldisdI=;
        b=G1usI+ipYVx92zHMaP6ApjBCjxwWDtvcK0AdJORphy8ETytmTd44HSjbYGFz3jmrJN
         O9xJJXHbzAPG9tgZAidiQCni1vTcu8Jphhy82vOYacIeGs0cTeblWz7y7DdIKuw8j2eF
         oMGblz0wtr696ct/L3XpWrhrWL4Q9hsygErrZbi9xbjHmxSKUlbBhQ5ts4bEf6jLYAue
         r1xEV4xjmqJdhuGroqlfLGw277+7wPEQKBwGZ+K785JwbbDdEJpZm0i/Vd89jWR1ut2w
         Jju23x3mYDHnCMyM9pKHonhg7w2xHfqaxW+hv/S/PcFM1rHyVBo9zuSL6J68Ty1HZYtK
         jD+A==
X-Gm-Message-State: APzg51A/WEBJDWT32RAJxYCGgU9ySpdNnJ/WaVJX/dB2ai4k/ehkvZue
        VQLI7jpmfmEUn+Nj81dpUvY=
X-Google-Smtp-Source: ANB0VdbbAPf2ZaYzF3jwMiM4bHCvfLIHBaRvAK42NxLP71eC9MZZNQIBBh3FWV1VXnYLzFExkgzVNQ==
X-Received: by 2002:a5d:5606:: with SMTP id l6-v6mr11772258wrv.209.1535735124673;
        Fri, 31 Aug 2018 10:05:24 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id c19-v6sm11280332wre.86.2018.08.31.10.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 10:05:24 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 3/7] Compiler Attributes: remove unneeded tests
Date:   Fri, 31 Aug 2018 19:05:10 +0200
Message-Id: <20180831170514.24665-3-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attributes const and always_inline have tests around them
which are unneeded, since they are supported by gcc >= 4.6,
clang >= 3 and icc >= 13. See https://godbolt.org/z/no0OZH

In the case of gnu_inline, we do not need to test for
__GNUC_STDC_INLINE__ because, regardless of the current
inlining behavior, we can simply always force the old
GCC inlining behavior by using the attribute in all cases.

Cc: Eli Friedman <efriedma@codeaurora.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler_types.h | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 7cd958360ead..3662b19599fc 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -158,10 +158,6 @@ struct ftrace_likely_data {
 	(sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
 	 sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
 
-#ifndef __attribute_const__
-#define __attribute_const__	__attribute__((const))
-#endif
-
 #ifndef __noclone
 #define __noclone
 #endif
@@ -196,6 +192,7 @@ struct ftrace_likely_data {
  * [...]
  */
 #define __pure			__attribute__((pure))
+#define __const			__attribute__((const))
 #define __aligned(x)		__attribute__((aligned(x)))
 #define __aligned_largest	__attribute__((aligned))
 #define __printf(a, b)		__attribute__((format(printf, a, b)))
@@ -227,17 +224,7 @@ struct ftrace_likely_data {
 
 #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
 
-/*
- * Feature detection for gnu_inline (gnu89 extern inline semantics). Either
- * __GNUC_STDC_INLINE__ is defined (not using gnu89 extern inline semantics,
- * and we opt in to the gnu89 semantics), or __GNUC_STDC_INLINE__ is not
- * defined so the gnu89 semantics are the default.
- */
-#ifdef __GNUC_STDC_INLINE__
-# define __gnu_inline	__attribute__((gnu_inline))
-#else
-# define __gnu_inline
-#endif
+#define __gnu_inline	__attribute__((gnu_inline))
 
 /*
  * Force always-inline if the user requests it so via the .config.
@@ -263,9 +250,7 @@ struct ftrace_likely_data {
 #define __inline inline
 #define noinline	__attribute__((noinline))
 
-#ifndef __always_inline
 #define __always_inline inline __attribute__((always_inline))
-#endif
 
 /*
  * Rather then using noinline to prevent stack consumption, use
-- 
2.17.1

