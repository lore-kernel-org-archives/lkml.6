Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DA1ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC3221531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ol6KQSWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC3221531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbeITXIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:08:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35991 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388146AbeITXIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:08:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id j192-v6so361818wmj.1;
        Thu, 20 Sep 2018 10:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=twtedPeeZz5KoysBQfVb1d5EctHONCIBWFDY7XlqfhI=;
        b=Ol6KQSWwqMxHMW2MGqYxwKMBZm7Reg5Kt+juHiMq2fr/oMpj+P2D1f0Ni2rNfAiKrG
         vjCI0EymqDtrplAJF2kOUWMKzLtbb3wXTtLHb6RiSn/DmsqphXqRZdfwEgQyFVXmkHJn
         MQL33oRe1OpABvhCBuH3ckMIibCCrVjPhvfQeOCpQm6a6q3mDsXj1I7ZreBpPPHeysRl
         ThKCSonsCXsjnz4FkAkt6nm/ig8qQ/zJA1L8Ludb51eySowy0M/9703DlqMieClzoDzu
         mUlalCmHfzfMIQ8dH04wi6TyMriIcQuJt3pMF5cmsvGMf+vZ4cdsS/bQP9RtK19oe9E+
         CB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=twtedPeeZz5KoysBQfVb1d5EctHONCIBWFDY7XlqfhI=;
        b=joSfW0GS35oaL+djOgr5DimHJQuEP/Ra6owLDq4DhVBZ9v86wmLhlDN+2ewHVfv78z
         XhTX86Lz03E4NSnw6iFYpOOb0/uW3r+mtY8KlUV5ffgVRgSSha2pWOgiVHhZqaGR8OsM
         FwFVt1ooJWz6gnepSVcJMlBRUTQyyQ9Gl3jPSEeAI2AXHr+r3SvlABJhbUdDARayIaWK
         yXy6l81IDmnTJFsefzoRWv0ZEfJ1hXENmWv8ypyVNd7CUcvLNoWhowur7rBKYR3bGAx6
         tIzNUeLvvk+NmfS6ymFYG2Uyk348GaakcykDBFfQ8aOvPIWg7WA/sBWR7tb2suKUBixM
         AyRQ==
X-Gm-Message-State: APzg51ClTSPL9M0DEl+ynmztQFWwNL3Zj+pw/EgTRiClO8Dsee8DuKEP
        eqavtwoIeQhi6N/dPDRDONg=
X-Google-Smtp-Source: ACcGV62jh5I3d0SxFnA3UY6WCKlfBUKZh/iZ3//O8F1vh1odvSENoZlxyzoI2PON3pJIksQWNhU1Tg==
X-Received: by 2002:a1c:cf8a:: with SMTP id f132-v6mr3820080wmg.0.1537464226338;
        Thu, 20 Sep 2018 10:23:46 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id q200-v6sm3466562wmd.2.2018.09.20.10.23.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:23:45 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
Subject: [PATCH v5 10/15] Compiler Attributes: add Doc/process/programming-language.rst
Date:   Thu, 20 Sep 2018 19:22:56 +0200
Message-Id: <20180920172301.21868-11-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 Documentation/process/index.rst               |  1 +
 .../process/programming-language.rst          | 45 +++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/process/programming-language.rst

diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index 9ae3e317bddf..00558b6d2649 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -23,6 +23,7 @@ Below are the essential guides that every developer should read.
    code-of-conduct
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

