Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA13C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEAA20835
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfNVWWUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DEAA20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeHaVN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:13:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35750 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbeHaVNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:13:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so6022874wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mupvrEo/lP67QnEw8cB1q2IIZnTx6K5fAuZjj6tQMBw=;
        b=EfNVWWUmsuhOBUkdW0V0vhECAKxVzewo4oBf9h67eoN7MIxPF2n+tBaSUQ9/C49FxY
         l1/g3Z+gb8OhVwB5II2rkYuVF3qKB+IdIZJdPDSR2ETE7NsV3ojjhvcPXg5sbwseNBAc
         lxpzIVJ6jfjIhItIee9eWLO/onqSxP7jNQm9FR+Kb6mKZ4gqpFGktBD10/WPo6hegYH6
         cdKcnGVQvjXVkRtM2hS76ZP8gxYA/pjBJxO95oDsmIWTRRmiC0FrMYFyOTCUQjL6tBCo
         MRH/ELFE9AepXyn6qH+ayYPkSGMxP5a69xGTLjxmAU4Eq8mj6MlptprvJyy3rtwv2L86
         jjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mupvrEo/lP67QnEw8cB1q2IIZnTx6K5fAuZjj6tQMBw=;
        b=KpIO9vbwbjv/wRL5ycV/d5EJNtgndL9g5lkaO8MMw+PgowozvgKGqv+WyZ9Qo3zhFA
         mYfWgUevXEKb0h6XkO/aqQqDAKAZp6tmNH8BV/Chsplltmx3Q74LWZOqawpJuxV24/sv
         v6tTDZSZ3f8+Ofk9mUqUOLyoCsD6VyxQEkAaAvMK47cHNUyt7XC3El5+4mVgUw08RNBm
         SaUSj7rjhg1e2rEisqVzj6FtXpPiesWYL/kTpMobkM0pEKSMk0OdkVe0+EaO5V+qEQP1
         iPUOarHmnDQW52ISt321WY0ic8+zM36PTIKSWUxeETMnlyXXNNh0cs0iXKx+aRvPHKM8
         MOkA==
X-Gm-Message-State: APzg51A7Cgqsu0sHEKQo+3Ypy99W0/PTxK3kVcO5/EQBWeYANBJ10kXJ
        lfLPOxbCgyF143R/IO5ESmY=
X-Google-Smtp-Source: ANB0VdYmYjafvYaMitO9zYmPW9ftunhQ/wiKWF6LyHE7pcu6LCmoz19WISgC7E7IEy2xO1Iru1foBg==
X-Received: by 2002:a1c:3351:: with SMTP id z78-v6mr4994076wmz.23.1535735129378;
        Fri, 31 Aug 2018 10:05:29 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id c19-v6sm11280332wre.86.2018.08.31.10.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 10:05:28 -0700 (PDT)
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
Subject: [PATCH 5/7] Compiler Attributes: naked was fixed in gcc 4.6
Date:   Fri, 31 Aug 2018 19:05:12 +0200
Message-Id: <20180831170514.24665-5-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9c695203a7dd ("compiler-gcc.h: gcc-4.5 needs noclone
and noinline on __naked functions") added noinline and noclone
as a workaround for a gcc 4.5 bug, which was resolved in 4.6.0.

Since now the minimum gcc supported version is 4.6,
we can clean it up.

See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44290
and https://godbolt.org/z/h6NMIL

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
 include/linux/compiler-gcc.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 66e1eb8822d9..fdf2fbe6d544 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -77,14 +77,8 @@
  * to trace naked functions because then mcount is called without
  * stack and frame pointer being set up and there is no chance to
  * restore the lr register to the value before mcount was called.
- *
- * The asm() bodies of naked functions often depend on standard calling
- * conventions, therefore they must be noinline and noclone.
- *
- * GCC 4.[56] currently fail to enforce this, so we must do so ourselves.
- * See GCC PR44290.
  */
-#define __naked		__attribute__((naked)) noinline __noclone notrace
+#define __naked		__attribute__((naked)) notrace
 
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
-- 
2.17.1

