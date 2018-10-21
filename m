Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A72FECDE45
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 17:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D4F204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 17:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRWf59DL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D4F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeJVB3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 21:29:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34187 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeJVB3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 21:29:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id l6-v6so41973927wrt.1;
        Sun, 21 Oct 2018 10:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G4Oe/grs/sDFeXzk7keghoCO7T6jCmzsN8LvN6wwuhY=;
        b=gRWf59DL+s4AisZ9ktCuXqkZnNO27qnC6AL6SdllC3SkFl6wxN2rqUuuqn6gLaciZA
         X14ug1KsN+R6adQe+yCccR5mP2hLA9hHXCAWixoNkZ6cqrhrItoUObmye+CbhvO00oH8
         Xo8fpsd5Hes3iHUrpsMMrGJM7jbA6vPnAjFzSgQ4KdijV59zpeoDrHQPtH543tVns21c
         fAtdYoE0FxIwwgrLWn+AMKvWsGUzw2PNf/wLZaSrrScrVtK7NBCmVjZblEm+wvpeYIzE
         kzoqEHd5uDJhNZCLU+5dNTxRMGAdQz5PqsjDrOROsRJzlWJj7FMr8EIeI9nH/FQCALpA
         m1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G4Oe/grs/sDFeXzk7keghoCO7T6jCmzsN8LvN6wwuhY=;
        b=WFCBIPYRA/c6UWZYPHbMhnwclUAZBX7//XeiQ00QCsYoJ2ORskpGKtLTi6omm2m7dQ
         MJzPMwqDT055Fr5tSdRPH3VM1L3+K4vj8sFdZuZKhhnHdaZ70RCndbvcXLcy6XJCi0DZ
         mHJEwSJKevV+Yv+OPgf0AMXynm4CuHeMO3kffnkkVlFjmokrLNVmSIOZKK7naJvzGFVT
         hl2iRb74TDmKQdQxxIBOahtxlU8Qe49KeUEOUvpEHYJ2hVGDNRUwN9zCN35j0Kjmv+EG
         9zzFxIo6TDu/fL1b+x5vr7mDCUQFoBzW5wExLaLJZl/I6pj4YP05t5ZwXKhkxENJQbl1
         e3bQ==
X-Gm-Message-State: ABuFfohOnfoJMco8o3u9fgA/7Tv/ka3+MXwFvPm6UAkUgXSHxRTF1zhq
        GHkH1GROhORE6bcF8/bwlJI=
X-Google-Smtp-Source: ACcGV60RJ5cbQIXXY59mhk3w5PIlmRWUU8Gys/hVeRQwu8AFJtevD99EmqUZDshrGDbwgNdfSltABQ==
X-Received: by 2002:adf:a706:: with SMTP id c6-v6mr45239758wrd.56.1540142077445;
        Sun, 21 Oct 2018 10:14:37 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id y16-v6sm20860113wru.18.2018.10.21.10.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 10:14:36 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Theodore Ts'o <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH 1/2] Compiler Attributes: add support for __fallthrough (gcc >= 7.1)
Date:   Sun, 21 Oct 2018 19:14:13 +0200
Message-Id: <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the GCC manual:

  fallthrough

    The fallthrough attribute with a null statement serves as a
    fallthrough statement. It hints to the compiler that a statement
    that falls through to another case label, or user-defined label
    in a switch statement is intentional and thus the -Wimplicit-fallthrough
    warning must not trigger. The fallthrough attribute may appear
    at most once in each attribute list, and may not be mixed with
    other attributes. It can only be used in a switch statement
    (the compiler will issue an error otherwise), after a preceding
    statement and before a logically succeeding case label,
    or user-defined label.

  https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html

Currently, most of the kernel uses fallthrough comments to silence
the -Wimplicit-fallthrough warnings (enabled by -Wextra, in W=1).
However, C++17 standarized an "statement attribute" (the first
of its kind) to deal with this: [[fallthrough]] is meant to be
a new control keyword in the form of an extension.

In C mode, GCC supports the __fallthrough__ attribute since 7.1,
the same time the warning and the comment parsing were introduced.

While comment parsing is a good idea to deal with old codebases
that used such a comment as documentation for humans, the best
solution is to use the attribute:

  * It is a "real" part of the AST (=> better for tooling).

  * It does not follow arbitrary rules for parsing (e.g. regexps
    for the comment parsing).

  * It may even become standarized in C as well: there are ongoing
    proposals to import some C++ standard attributes into
    the C standard, e.g. for fallthrough:

      http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2268.pdf

On top of that, it is also a better solution for the kernel, because:

  * We can actually use a #define for it like for the rest of
    attributes/extensions, which is not possible with a comment,
    so that its naming/usage is consistent across the entire kernel.

  * Whenever the migration from the comments to the attribute
    is complete, we may increase the level of the GCC warning up to 5,
    i.e. comments will not longer be considered for warning
    surpression:  only the attribute must be used. This would enforce
    consistency by leveraging the compiler directly (instead of
    enforcing it with other tools).

  * Further into the future, we can consider moving the warning
    up to W=0 or even making it an error.

It is worth noting that clang >= 3.2 supports the warning and
the attribute, but only in C++ mode (and it is not enabled by
-Wall/-Wextra/-Wpedantic like in gcc). Hopefully, they will also
support it for C as well.

Further, icc >= 18 does not seem to know anything about the warning;
except that it accepts (i.e. ignores) [[fallthrough]] in C++17 mode
(to be conformant, probably).

Link: https://lore.kernel.org/lkml/20181017062255.oiu44y4zuuwilan3@mwanda/
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler_attributes.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 6b28c1b7310c..9e2153f85462 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -32,6 +32,7 @@
 # define __GCC4_has_attribute___assume_aligned__      (__GNUC_MINOR__ >= 9)
 # define __GCC4_has_attribute___designated_init__     0
 # define __GCC4_has_attribute___externally_visible__  1
+# define __GCC4_has_attribute___fallthrough__         0
 # define __GCC4_has_attribute___noclone__             1
 # define __GCC4_has_attribute___optimize__            1
 # define __GCC4_has_attribute___nonstring__           0
@@ -133,6 +134,23 @@
 # define __visible
 #endif
 
+/*
+ * Currently, most of the kernel uses fallthrough comments to silence
+ * the -Wimplicit-fallthrough warnings (enabled by -Wextra, in W=1).
+ * For new instances, please use this attribute instead.
+ *
+ * Optional: only supported since gcc >= 7.1
+ * Optional: not supported by clang
+ * Optional: not supported by icc
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#index-fallthrough-statement-attribute
+ */
+#if __has_attribute(__fallthrough__)
+# define __fallthrough                  __attribute__((__fallthrough__))
+#else
+# define __fallthrough
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-format-function-attribute
  * clang: https://clang.llvm.org/docs/AttributeReference.html#format
-- 
2.17.1

