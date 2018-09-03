Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DADC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B2020869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3fGzuJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B2020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbeIDAz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:55:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33207 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbeIDAz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:55:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id r1-v6so7523335wmh.0;
        Mon, 03 Sep 2018 13:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=znhKATxSpbkpApPLKvpo/RP4a7pgZj+EIzOmJtisvm4=;
        b=G3fGzuJ8YAXjLEgorIVa9LBuBMxP2AmACUEmpXHr0Mqnx5H2P1f33bsFU1ybS0lOO6
         O7+9jJ4Z7dJswrHEowKjhOcQTo+BLcCmsYDjOxVttJ+BckBlS2T+70ppRKepIIVNdqNi
         Pwv79Jk1uTaroUYgt6zECHd0Gx0fQOEG9sPPbOTnqvH5nLGZRbTq0UIOnlVxPbWFtETT
         iSYEmXBROtc1nUFXKFEih3n+DVI8XsjUMM/uLvCtbwqy5+63sQRFFCeIDAGSHhRLFm1w
         ndMvVMqiF/5iLo28uZMs8Iz3lOpGeBLODyND76efpcjWailAsYvlovXTDznxtgWcIc4D
         XJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=znhKATxSpbkpApPLKvpo/RP4a7pgZj+EIzOmJtisvm4=;
        b=IOqZAO9FMuWz4PKMWqifW9xPtGjgALWmbMX5EaOgklTIWwKtxi2n7tcDC2xwxeyN8M
         P8fb/HmD5fP2+aobs67GLePDuWjJEmzXKjqJA8aZlYdK887tTP9z6NqFQDFyz2TpWH5N
         NyZkTLhxMKtlRxjthfvpOJ1vSlA07PMr6FpMvrE+zN9Kt99//Lm3bxwcJ1mpvHNzxsgD
         TNRUlIUZ2+hdM+udVZHQ0kcF0pYnZ1TYTkQJUVmyuaLIar31MvjHb+LGcm/TJTPV2sDL
         0tsx5j4H7oR/m2k0qIJegGk2omLeECPkJiTRCPkG3xxOFNQTvWh8ZGehxeuwLCotHH6u
         CN5w==
X-Gm-Message-State: APzg51D8WavOw1j3tnB0SvmRc6JFhI2csEsF4TPlyWtSyjOirgTZqyum
        1J5iIp77VALoKumxFxeCBwu1X6fuHIc=
X-Google-Smtp-Source: ANB0VdaNuTgx+ecVabi+TjVYZ6aXQsJrRDw08xQeVKWcudJG4q4jgYmVtaln+97uR+FQX99cZVHD4g==
X-Received: by 2002:a1c:230f:: with SMTP id j15-v6mr629820wmj.124.1536006844302;
        Mon, 03 Sep 2018 13:34:04 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id 132-v6sm12354870wmd.13.2018.09.03.13.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 13:34:03 -0700 (PDT)
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
Subject: [PATCH 12/12] Compiler Attributes: add Doc/process/programming-language.rst
Date:   Mon,  3 Sep 2018 22:33:16 +0200
Message-Id: <20180903203316.16183-13-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
References: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
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
 .../process/programming-language.rst          | 44 +++++++++++++++++++
 2 files changed, 45 insertions(+)
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
index 000000000000..674f28ae7f73
--- /dev/null
+++ b/Documentation/process/programming-language.rst
@@ -0,0 +1,44 @@
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
+directly the GNU attribute syntax (e.g. ``__attribute__((pure))``).
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

