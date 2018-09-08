Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A152CC43143
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3732320868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMOnQEM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3732320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeIICMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 22:12:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42168 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbeIICMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 22:12:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id v17-v6so18096793wrr.9;
        Sat, 08 Sep 2018 14:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T5AM0lKpRA4nSd7QBTrQNLR7gE7jGERVXErV6YZkeSE=;
        b=gMOnQEM1BbB/38PkXlmKXunDGZtgen0DiYEDZfC7jwZzMc//YjTRaStJ4oC/D6QYoX
         IOt4/rdofucbKHE8j5f+zGA5Es98mGQFs+k8+qXlO6Tncnik1eElKeq8tGpiGtFuZMe+
         yxAWCZj5Mm6A3Pdr00Y/zko/tf280fhDSFy72Thy9LX2eqiNvdYELithIr1zaleCqac5
         znVdWB2OI3ZBrm+20lwQTED9kynbpN1/lrq7y2Prdo25WdTQEohDd9uQTnNC8UoeJZfk
         i36qpIV9Qs3OXfnD4dvuujVqFkbmRppRMtn4Tvpenh045rqshYyTiUCVTvriguwjb1TU
         i2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T5AM0lKpRA4nSd7QBTrQNLR7gE7jGERVXErV6YZkeSE=;
        b=QAjkMsC8SPyqg0Krc5EMXKBc01+DeAIsGtCK8wZP9TUFLyYxDFC3BQmwRN3I337x3g
         zjICu3691ezuHfnZgarwyHqyXWzsuOhgfgvqlcAI7R20pdDlS9PxycxkaMWf2lBJItiM
         5aoYTkA9qk2PGe3Iev/o1ECnU42a9SkCqB67PEEhpfJV7NueAiLbHWTdWn4AdqTzcTNY
         IbiGawhe5IhPyGr9Z35/HpiJ1AszNV5l+oc2GIBMNp/Vj11tHjHmEQMY5Parc2Iwzr3y
         DhJ4CSmwG1WbWQudxj/EX/BCJmdJTN99QDhkdgggNAvHWQqdiUL3175pzfKpv1KthmrK
         eefQ==
X-Gm-Message-State: APzg51CmnNcACDrI8vy+Ksh8utEBydynyf8xAfgfjhEIgr1YZXBeqIzS
        keQj8JsAE0bIJNQQ+BiXZ1Y=
X-Google-Smtp-Source: ANB0Vdbg4v1i84w/gZWVoB0R8lRp8yE3QK7vN9aYkiUrKcFuGTptu88oMurN2tyd5lqzwx8nC06ILg==
X-Received: by 2002:a05:6000:10d0:: with SMTP id b16mr10326996wrx.226.1536441927948;
        Sat, 08 Sep 2018 14:25:27 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id u40-v6sm17340786wrc.43.2018.09.08.14.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 14:25:27 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-sparse@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v4 12/13] Compiler Attributes: add Doc/process/programming-language.rst
Date:   Sat,  8 Sep 2018 23:24:58 +0200
Message-Id: <20180908212459.19736-13-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Jonathan Corbet <corbet@lwn.net>
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
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 Documentation/process/index.rst               |  1 +
 .../process/programming-language.rst          | 45 +++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/process/programming-language.rst

diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index 37bd0628b6ee..c56f24a22d2a 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -23,6 +23,7 @@ Below are the essential guides that every developer should read.
    code-of-conflict
    development-process
    submitting-patches
+   programming-language
    coding-style
    maintainer-pgp-guide
    email-clients
diff --git a/Documentation/process/programming-language.rst b/Documentation/process/programming-language.rst
new file mode 100644
index 000000000000..e5f5f065dc24
--- /dev/null
+++ b/Documentation/process/programming-language.rst
@@ -0,0 +1,45 @@
+.. _programming_language:
+
+Programming Language
+====================
+
+The kernel is written in the C programming language [c-language]_.
+More precisely, the kernel is typically compiled with ``gcc`` [gcc]_
+under ``-std=gnu89`` [gcc-c-dialect-options]_: the GNU dialect of ISO C90
+(including some C99 features).
+
+This dialect contains many extensions to the language [gnu-extensions]_,
+and many of them are used within the kernel as a matter of course.
+
+There is some support for compiling the kernel with ``clang`` [clang]_
+and ``icc`` [icc]_ for several of the architectures, although at the time
+of writing it is not completed, requiring third-party patches.
+
+Attributes
+----------
+
+One of the common extensions used throughout the kernel are attributes
+[gcc-attribute-syntax]_. Attributes allow to introduce
+implementation-defined semantics to language entities (like variables,
+functions or types) without having to make significant syntactic changes
+to the language (e.g. adding a new keyword) [n2049]_.
+
+In some cases, attributes are optional (i.e. a compiler not supporting them
+should still produce proper code, even if it is slower or does not perform
+as many compile-time checks/diagnostics).
+
+The kernel defines pseudo-keywords (e.g. ``__pure``) instead of using
+directly the GNU attribute syntax (e.g. ``__attribute__((__pure__))``)
+in order to feature detect which ones can be used and/or to shorten the code.
+
+Please refer to ``include/linux/compiler_attributes.h`` for more information.
+
+.. [c-language] http://www.open-std.org/jtc1/sc22/wg14/www/standards
+.. [gcc] https://gcc.gnu.org
+.. [clang] https://clang.llvm.org
+.. [icc] https://software.intel.com/en-us/c-compilers
+.. [gcc-c-dialect-options] https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
+.. [gnu-extensions] https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
+.. [gcc-attribute-syntax] https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
+.. [n2049] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf
+
-- 
2.17.1

