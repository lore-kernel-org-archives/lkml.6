Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449E6C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38B920869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Skx0Jzuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38B920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbeIDAzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:55:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41620 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbeIDAzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:55:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id z96-v6so1742391wrb.8;
        Mon, 03 Sep 2018 13:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HoCi5EJzB+/PbEERt2xyXHFMzpFbJL9r+GdGJgj/E2I=;
        b=Skx0JzuzOifbH6Nu73FZZulPhYCoy3WAHSwkgknIK7riIm3YwzVs+waTWb1cNxZtVE
         VkljYkOsx8v3stytWW1mgYxYy6bmV76ypJ2+f3uNy6fNHNFbN7h8B4CjDTqdBjptm3KO
         7CZPBNWMH4OsPbDuG/Ul8wKoyllhlKj/4qDOqwANo0D4MaBiS74aW4D3HJmf/0NzJVWt
         rvBKxCOC3MDEebpsDlSdrYki/S20yYioFtUXt2lnBJvpTkTUu0EE5CfTS380S2MxY0ZL
         QSs5JZmqrfCTJyNhRCh2dIyvESJZZqnBA1VBOwcKx8s34uXqigHg49uOk3WYf96O2T9t
         5BbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HoCi5EJzB+/PbEERt2xyXHFMzpFbJL9r+GdGJgj/E2I=;
        b=jGD4MJEbnMCvbwgF/qObRhufYoRQx6XiVUjiuzO2+GrjJk7sRUc92WODq7+kWfVXa4
         1tVxTCfDIjNiiOqOUvouno9RCwlzDKgvDneU2ABStZKcMnCXZqyAOT0u2t7l2WQ1DymU
         Q1e1tZfWIJdOjhCghmwkN0ar0BUQQzTmAReLeahdYizYTiC4Vuw233u2Ssg5iUBdvzE3
         zs6wf+lhsqbdR/EvRyymoozDGknwaZjH+TVVX28XP1rg5uLBMzjnjPfn8Djjnmxu1G45
         MXgRi61Kt8Jv7/IczK6omeVy8QGyH7VVnDBFiF2idL9wdfe+GT+oxIZkghgBV182a7J1
         qPfw==
X-Gm-Message-State: APzg51DQrlC/b3j7/QAWJaYIwIWivr9fbKaK+ikrgZjyV5oRO2srDhLW
        Fub1mOwjd2HsbNG+BfgIdyU=
X-Google-Smtp-Source: ANB0VdbZb23hl5yC72x74//5yieVjzAtxnS1CcRJsCLFbrc43giXsUnFM9kteBQUwueSjE2MTwOXQQ==
X-Received: by 2002:adf:8919:: with SMTP id s25-v6mr20133892wrs.89.1536006836762;
        Mon, 03 Sep 2018 13:33:56 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id 132-v6sm12354870wmd.13.2018.09.03.13.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 13:33:56 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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
        linux-sparse@vger.kernel.org
Subject: [PATCH 07/12] Compiler Attributes: remove unneeded sparse (__CHECKER__) tests
Date:   Mon,  3 Sep 2018 22:33:11 +0200
Message-Id: <20180903203316.16183-8-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
References: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse knows about a few more attributes now, so we can remove
the __CHECKER__ conditions from them (which, in turn, allow us
to move some of them later on to compiler_attributes.h).

  * assume_aligned: since sparse's commit ffc860b ("sparse:
    ignore __assume_aligned__ attribute"), included in 0.5.1

  * error: since sparse's commit 0a04210 ("sparse: Add 'error'
    to ignored attributes"), included in 0.5.0

  * hotpatch: since sparse's commit 6043210 ("sparse/parse.c:
    ignore hotpatch attribute"), included in 0.5.1

  * warning: since sparse's commit 977365d ("Avoid "attribute
    'warning': unknown attribute" warning"), included in 0.4.2

On top of that, __must_be_array does not need it either because:

  * Even ancient versions of sparse do not have a problem

  * BUILD_BUG_ON_ZERO() is currently disabled for __CHECKER__

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler-gcc.h   | 6 ++----
 include/linux/compiler.h       | 4 ----
 include/linux/compiler_types.h | 2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 3b32bbfa5a49..1ca6a51cfaa9 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -76,14 +76,12 @@
 
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
 
-#ifndef __CHECKER__
 #define __compiletime_warning(message) __attribute__((__warning__(message)))
 #define __compiletime_error(message) __attribute__((__error__(message)))
 
-#ifdef LATENT_ENTROPY_PLUGIN
+#if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
 #define __latent_entropy __attribute__((latent_entropy))
 #endif
-#endif /* __CHECKER__ */
 
 /*
  * calling noreturn functions, __builtin_unreachable() and __builtin_trap()
@@ -131,7 +129,7 @@
 
 /* gcc version specific checks */
 
-#if GCC_VERSION >= 40900 && !defined(__CHECKER__)
+#if GCC_VERSION >= 40900
 /*
  * __assume_aligned(n, k): Tell the optimizer that the returned
  * pointer can be assumed to be k modulo n. The second argument is
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 165b1d5683ed..4030a2940d6b 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -357,11 +357,7 @@ static inline void *offset_to_ptr(const int *off)
 	compiletime_assert(__native_word(t),				\
 		"Need native word sized stores/loads for atomicity.")
 
-#ifdef __CHECKER__
-#define __must_be_array(a)	0
-#else
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
-#endif
 
 #endif /* __LINUX_COMPILER_H */
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index f182f2ef3227..65b10b1e2a59 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -217,7 +217,7 @@ struct ftrace_likely_data {
 #define __must_check
 #endif
 
-#if defined(CC_USING_HOTPATCH) && !defined(__CHECKER__)
+#if defined(CC_USING_HOTPATCH)
 #define notrace			__attribute__((hotpatch(0, 0)))
 #else
 #define notrace			__attribute__((__no_instrument_function__))
-- 
2.17.1

