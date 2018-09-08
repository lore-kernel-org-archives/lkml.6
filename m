Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1C9C43143
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0475220868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDN6zaJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0475220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeIICMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 22:12:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34241 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbeIICMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 22:12:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id j25-v6so2251478wmc.1;
        Sat, 08 Sep 2018 14:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZhryjHGsWzeSzxD0NW3OWSaZ8RANYxnQY/DMq4IP8+M=;
        b=PDN6zaJAOlY1XuRcBrqYA9UYPmi9gdnl6lxlT10cB7BabphGmS/O6ge6sqj4qezLo9
         cM5fhidKOz2HBOm7TfDcd69GqIajhkhl+DnTvI6dwL1ZMo3rWzXAP29M++Oylt6ahRko
         lCrq/yGCd7bYldLZS32IUp1jcGgqcSHh4QVNOVobMcAJJXG0bEW/+ayafUPDLyEtMiPb
         xljrlkl2ZcY/FWZkiSUdHzO3aU7mG28e1IqTjCIDXbaQ1mIa0dsz9W3cKBTYjsPd9v8V
         /gilTekxovA8rhHh/oahfHEiNwzrcK0J9U4Y4zCyJK8QEp+IFnQk8RI0ZToRZT7XWBUu
         3vyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZhryjHGsWzeSzxD0NW3OWSaZ8RANYxnQY/DMq4IP8+M=;
        b=cGsyl02bSS69ZPSqAM7jHaGY6S3IM3APTUXmaUBsXAZzD+Tgk0lx+CzAPGhfSrvAov
         QBltqkV2sP5VvoSUCgvdBhPjT11qDOqb6gUKhlxcZNEGAUUftxonF4d1rG2tBGCCOPr2
         h/29L3rr4u+FZwdXc0qersEeSNf5uJ3ClUohH6MWTgS8gSjIq3T9EuJKBodX171m0esc
         MxSC2yOzvVXmRxptkY8TSX5ATeGIM/WDUZZgJmWldxzL3/nfzW5C7K3BTiAmnzYayzfo
         T4U04DsHR77dS247IR1toC2bGlCwX5358HpDt3ZoxtIbSycAfq+/vG1O8rpKKdJ3ztoB
         OcYA==
X-Gm-Message-State: APzg51CeD73I7ASG+eNLxZzNQhwP1x9MAi5yeUhQmza0nDEuPhN2dXn2
        inS9Mbp+qQ7ZEBta6H/9VD4=
X-Google-Smtp-Source: ANB0VdaGRzqTk0KUdWnRvOm8fmIg34wdxIF3wZXxVMkKhhuw5RFiOZaFOIfw9KyDy2/REx1pQrrSqg==
X-Received: by 2002:a1c:e54:: with SMTP id 81-v6mr8839361wmo.84.1536441912565;
        Sat, 08 Sep 2018 14:25:12 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id u40-v6sm17340786wrc.43.2018.09.08.14.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 14:25:12 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
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
Subject: [PATCH v4 01/13] Compiler Attributes: remove unused attributes
Date:   Sat,  8 Sep 2018 23:24:47 +0200
Message-Id: <20180908212459.19736-2-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__optimize and __deprecate_for_modules are unused in
the whole kernel tree. Simply drop them.

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
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
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler-gcc.h   | 2 --
 include/linux/compiler.h       | 4 ----
 include/linux/compiler_types.h | 1 -
 3 files changed, 7 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 763bbad1e258..0a2d06677d83 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -95,8 +95,6 @@
 
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
-#define __optimize(level)	__attribute__((__optimize__(level)))
-
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
 
 #ifndef __CHECKER__
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 681d866efb1e..7c0157d50964 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -301,10 +301,6 @@ static inline void *offset_to_ptr(const int *off)
 
 #endif /* __ASSEMBLY__ */
 
-#ifndef __optimize
-# define __optimize(level)
-#endif
-
 /* Compile time object size, -1 for unknown */
 #ifndef __compiletime_object_size
 # define __compiletime_object_size(obj) -1
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 3525c179698c..b6534292ea33 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -108,7 +108,6 @@ struct ftrace_likely_data {
 
 /* Don't. Just don't. */
 #define __deprecated
-#define __deprecated_for_modules
 
 #endif /* __KERNEL__ */
 
-- 
2.17.1

