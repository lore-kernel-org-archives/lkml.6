Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63F7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A112083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AKgupg3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A112083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbeIHDE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 23:04:27 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:33404 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeIHDE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 23:04:27 -0400
Received: by mail-yb1-f201.google.com with SMTP id d202-v6so6377147ybh.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 15:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rU17X48zlaL0ooq4Yca3uERHAwdG+fJGmuN+EU/m6KY=;
        b=AKgupg3UY9o1xxYiDWKmn+9wC0qr7Iy7JS7a85FhLq5dX0zQhGPomVgjP2WO2vatWJ
         TC4+VPWNANkKBMpSpMTLjV9dcKD+TfAgTQGkWxrV62LVR5gMfEBVBRXvEd1mg7Nd9FO/
         Z+Z3TPEp/ymUrjTq1rXaH8lEL1yQVOOpsfsvw2AomUjaaMLEMMCjA/o9ajr0PcoTPP/t
         /K0AsiS6rk/3TEKWp2L7yQRpKVvCVrl0+qXMsIlXH0gZfHpBJh+P4KL9ztEzGUMdrdYw
         lfO29pZ8yVe3+IVxvJ2da6qQVzWfy/Hlq75hRj8QdXFjMJZc/f25Qvdg5uQSZ3drIPnf
         riGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rU17X48zlaL0ooq4Yca3uERHAwdG+fJGmuN+EU/m6KY=;
        b=ZKPh9SpUdrMSl73mFVXI+3XXQioZnzlm3WARMZjwgIyjK9mLgULY8EhVH2uREY7hYl
         vFREpAPsmoO2mXkeWcKS/1g6N1cfmLCWrzs5hVZ+AWmEkWNAFSE8fn8aa55X2ySHv6NC
         OijKAZGdh+/qm5R+r4WoKucEXkLlpjYo8ri7LPH3ap26vh0+WQhUG50JH1mvRotBOEC3
         Hz9+iIojPM5qglqTFLZJP0YL3+liIxcTaSAOdyhUdup8qClQecHOv7/3lEHWG+T3xHTS
         ET5OyT6LvuyCFsCyXUbUBC9/ui6tGZy5bnhYPB/87Qom5Qxa5fmGUEzAvjY4fluSa0Z5
         qArQ==
X-Gm-Message-State: APzg51Dp0CuL6tF78gm6M3L1eLBNle2Q7ijS5HdZuY44w5savQ+FXDX0
        Lvp4u9TfPJegDujKguApG6LfFLkQcgoEcgm7uKw=
X-Google-Smtp-Source: ANB0VdbGSuACc4TJwKe7ZLlgvlqxgHHqp7KQlI141/EtU8DDVP/aklyoa+Y+QgwNw8JB70NOrdTsUIIAwuj1Z/J7lZQ=
X-Received: by 2002:a81:5a56:: with SMTP id o83-v6mr2373488ywb.59.1536358881741;
 Fri, 07 Sep 2018 15:21:21 -0700 (PDT)
Date:   Fri,  7 Sep 2018 15:21:03 -0700
Message-Id: <20180907222109.163802-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
Subject: [PATCH] include/linux/compiler*.h: add version detection to asm_volatile_goto
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org
Cc:     miguel.ojeda.sandonis@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment above asm_volatile_goto mentions working around a GCC bug,
and links to a bug report that claims this has been fixed in newer
versions of GCC.  Testing shows that this was resolved in GCC 4.8.2.
asm_volatile_goto should also be defined for other compilers that
support asm goto.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/compiler-gcc.h   | 7 ++++++-
 include/linux/compiler_types.h | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 763bbad1e258..149f411b4366 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -171,7 +171,7 @@
 #endif
 
 /*
- * GCC 'asm goto' miscompiles certain code sequences:
+ * GCC < 4.8.2 'asm goto' miscompiles certain code sequences:
  *
  *   http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58670
  *
@@ -179,7 +179,12 @@
  *
  * (asm goto is automatically volatile - the naming reflects this.)
  */
+#if GCC_VERSION < 40802
 #define asm_volatile_goto(x...)	do { asm goto(x); asm (""); } while (0)
+#else
+#define asm_volatile_goto(x...)	asm goto(x)
+#endif
+
 
 /*
  * sparse (__CHECKER__) pretends to be gcc, but can't do constant
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 3525c179698c..61449dbf30d8 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -151,6 +151,10 @@ struct ftrace_likely_data {
 #define __assume_aligned(a, ...)
 #endif
 
+#ifndef asm_volatile_goto
+#define asm_volatile_goto(x...) asm goto(x)
+#endif
+
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
 
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

