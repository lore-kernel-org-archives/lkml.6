Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46446C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39C620836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39C620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757227AbeFSURf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:17:35 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:47398 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755072AbeFSURd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:17:33 -0400
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx4.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Tue, 19 Jun 2018 20:15:57 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 19
 Jun 2018 13:15:22 -0700
Received: from pburton-laptop.mipstec.com (10.20.2.29) by
 mipsdag02.mipstec.com (10.20.40.47) with Microsoft SMTP Server id 15.1.1415.2
 via Frontend Transport; Tue, 19 Jun 2018 13:15:22 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     <linux-kbuild@vger.kernel.org>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-mips@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>,
        Ingo Molnar <mingo@kernel.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Thomas Gleixner <tglx@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        He Zhe <zhe.he@windriver.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Khem Raj <raj.khem@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Gideon Israel Dsouza <gidisrael@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
        <linuxppc-dev@lists.ozlabs.org>, Paul Burton <paul.burton@mips.com>
Subject: [PATCH v2 1/3] kbuild: add macro for controlling warnings to linux/compiler.h
Date:   Tue, 19 Jun 2018 13:14:56 -0700
Message-ID: <20180619201458.4559-2-paul.burton@mips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619201458.4559-1-paul.burton@mips.com>
References: <20180619190225.7eguhiw3ixaiwpgl@pburton-laptop>
 <20180619201458.4559-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1529439356-298555-14291-6912-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194199
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: linux-kbuild@vger.kernel.org,paulus@samba.org,linux-kernel@vger.kernel.org,heiko.carstens@de.ibm.com,mpe@ellerman.id.au,keescook@chromium.org,yamada.masahiro@socionext.com,gidisrael@gmail.com,shorne@gmail.com,viro@zeniv.linux.org.uk,christophe.leroy@c-s.fr,raj.khem@gmail.com,linuxppc-dev@lists.ozlabs.org,michal.lkml@markovi.net,zhe.he@windriver.com,mka@chromium.org,akpm@linux-foundation.org,jpoimboe@redhat.com,dianders@chromium.org,tglx@linutronix.de,matthew@wil.cx,mingo@kernel.org,arnd@arndb.de,linux-mips@linux-mips.org,mchehab@kernel.org,benh@kernel.crashing.org
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

I have occasionally run into a situation where it would make sense to
control a compiler warning from a source file rather than doing so from
a Makefile using the $(cc-disable-warning, ...) or $(cc-option, ...)
helpers.

The approach here is similar to what glibc uses, using __diag() and
related macros to encapsulate a _Pragma("GCC diagnostic ...") statement
that gets turned into the respective "#pragma GCC diagnostic ..." by
the preprocessor when the macro gets expanded.

Like glibc, I also have an argument to pass the affected compiler
version, but decided to actually evaluate that one. For now, this
supports GCC_4_6, GCC_4_7, GCC_4_8, GCC_4_9, GCC_5, GCC_6, GCC_7,
GCC_8 and GCC_9. Adding support for CLANG_5 and other interesting
versions is straightforward here. GNU compilers starting with gcc-4.2
could support it in principle, but "#pragma GCC diagnostic push"
was only added in gcc-4.6, so it seems simpler to not deal with those
at all. The same versions show a large number of warnings already,
so it seems easier to just leave it at that and not do a more
fine-grained control for them.

The use cases I found so far include:

- turning off the gcc-8 -Wattribute-alias warning inside of the
  SYSCALL_DEFINEx() macro without having to do it globally.

- Reducing the build time for a simple re-make after a change,
  once we move the warnings from ./Makefile and
  ./scripts/Makefile.extrawarn into linux/compiler.h

- More control over the warnings based on other configurations,
  using preprocessor syntax instead of Makefile syntax. This should make
  it easier for the average developer to understand and change things.

- Adding an easy way to turn the W=1 option on unconditionally
  for a subdirectory or a specific file. This has been requested
  by several developers in the past that want to have their subsystems
  W=1 clean.

- Integrating clang better into the build systems. Clang supports
  more warnings than GCC, and we probably want to classify them
  as default, W=1, W=2 etc, but there are cases in which the
  warnings should be classified differently due to excessive false
  positives from one or the other compiler.

- Adding a way to turn the default warnings into errors (e.g. using
  a new "make E=0" tag) while not also turning the W=1 warnings into
  errors.

This patch for now just adds the minimal infrastructure in order to
do the first of the list above. As the #pragma GCC diagnostic
takes precedence over command line options, the next step would be
to convert a lot of the individual Makefiles that set nonstandard
options to use __diag() instead.

[paul.burton@mips.com:
  - Rebase atop current master.
  - Add __diag_GCC, or more generally __diag_<compiler>, abstraction to
    avoid code outside of linux/compiler-gcc.h needing to duplicate
    knowledge about different GCC versions.
  - Add a comment argument to __diag_{ignore,warn,error} which isn't
    used in the expansion of the macros but serves to push people to
    document the reason for using them - per feedback from Kees Cook.
  - Translate severity to GCC-specific pragmas in linux/compiler-gcc.h
    rather than using GCC-specific in linux/compiler_types.h.
  - Drop all but GCC 8 macros, since we only need to define macros for
    versions that we need to introduce pragmas for, and as of this
    series that's just GCC 8.
  - Capitalize comments in linux/compiler-gcc.h to match the style of
    the rest of the file.
  - Line up macro definitions with tabs in linux/compiler-gcc.h.]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Tested-by: Stafford Horne <shorne@gmail.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Matthew Wilcox <matthew@wil.cx>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Gideon Israel Dsouza <gidisrael@gmail.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Khem Raj <raj.khem@gmail.com>
Cc: He Zhe <zhe.he@windriver.com>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linuxppc-dev@lists.ozlabs.org

---

Changes in v2:
- Add version argument to fallback __diag_GCC definition.
- Translate severity from generic ignore,warn,error to GCC-specific
  pragma content ignored,warning,error in linux/compiler-gcc.h in order
  to keep linux/compiler_types.h generic per feedback from Masahiro
  Yamada.
- Drop all but GCC 8 macros, since we only need to define macros for
  versions that we need to introduce pragmas for, and as of this series
  that's just GCC 8.
- Capitalize comments in linux/compiler-gcc.h to match the style of the
  rest of the file.
- Line up macro definitions with tabs in linux/compiler-gcc.h.

 include/linux/compiler-gcc.h   | 27 +++++++++++++++++++++++++++
 include/linux/compiler_types.h | 18 ++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index f1a7492a5cc8..5067a90af9c3 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -347,3 +347,30 @@
 #if GCC_VERSION >= 50100
 #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
+
+/*
+ * Turn individual warnings and errors on and off locally, depending
+ * on version.
+ */
+#define __diag_GCC(version, severity, s) \
+	__diag_GCC_ ## version(__diag_GCC_ ## severity s)
+
+/* Severity used in pragma directives */
+#define __diag_GCC_ignore	ignored
+#define __diag_GCC_warn		warning
+#define __diag_GCC_error	error
+
+/* Compilers before gcc-4.6 do not understand "#pragma GCC diagnostic push" */
+#if GCC_VERSION >= 40600
+#define __diag_str1(s)		#s
+#define __diag_str(s)		__diag_str1(s)
+#define __diag(s)		_Pragma(__diag_str(GCC diagnostic s))
+#else
+#define __diag(s)
+#endif
+
+#if GCC_VERSION >= 80000
+#define __diag_GCC_8(s)		__diag(s)
+#else
+#define __diag_GCC_8(s)
+#endif
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 6b79a9bba9a7..a8ba6b04152c 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -271,4 +271,22 @@ struct ftrace_likely_data {
 # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
 #endif
 
+#ifndef __diag
+#define __diag(string)
+#endif
+
+#ifndef __diag_GCC
+#define __diag_GCC(version, severity, string)
+#endif
+
+#define __diag_push()	__diag(push)
+#define __diag_pop()	__diag(pop)
+
+#define __diag_ignore(compiler, version, option, comment) \
+	__diag_ ## compiler(version, ignore, option)
+#define __diag_warn(compiler, version, option, comment) \
+	__diag_ ## compiler(version, warn, option)
+#define __diag_error(compiler, version, option, comment) \
+	__diag_ ## compiler(version, error, option)
+
 #endif /* __LINUX_COMPILER_TYPES_H */
-- 
2.17.1

