Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F05C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A920223EDE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A920223EDE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933696AbeGCP7m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:59:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48789 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932775AbeGCP7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:59:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w63Fx8to338515
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 08:59:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w63Fx8VS338512;
        Tue, 3 Jul 2018 08:59:08 -0700
Date:   Tue, 3 Jul 2018 08:59:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nick Desaulniers <tipbot@zytor.com>
Message-ID: <tip-d03db2bc26f0e4a6849ad649a09c9c73fccdc656@git.kernel.org>
Cc:     ndesaulniers@google.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, joe@perches.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, jgross@suse.com, mingo@kernel.org,
        peterz@infradead.org, arnd@arndb.de
Reply-To: joe@perches.com, tglx@linutronix.de,
          torvalds@linux-foundation.org, ndesaulniers@google.com,
          arnd@arndb.de, peterz@infradead.org, jgross@suse.com,
          mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180621162324.36656-2-ndesaulniers@google.com>
References: <20180621162324.36656-2-ndesaulniers@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] compiler-gcc.h: Add __attribute__((gnu_inline)) to
 all inline declarations
Git-Commit-ID: d03db2bc26f0e4a6849ad649a09c9c73fccdc656
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d03db2bc26f0e4a6849ad649a09c9c73fccdc656
Gitweb:     https://git.kernel.org/tip/d03db2bc26f0e4a6849ad649a09c9c73fccdc656
Author:     Nick Desaulniers <ndesaulniers@google.com>
AuthorDate: Thu, 21 Jun 2018 09:23:22 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 3 Jul 2018 10:56:27 +0200

compiler-gcc.h: Add __attribute__((gnu_inline)) to all inline declarations

Functions marked extern inline do not emit an externally visible
function when the gnu89 C standard is used. Some KBUILD Makefiles
overwrite KBUILD_CFLAGS. This is an issue for GCC 5.1+ users as without
an explicit C standard specified, the default is gnu11. Since c99, the
semantics of extern inline have changed such that an externally visible
function is always emitted. This can lead to multiple definition errors
of extern inline functions at link time of compilation units whose build
files have removed an explicit C standard compiler flag for users of GCC
5.1+ or Clang.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@redhat.com
Cc: akataria@vmware.com
Cc: akpm@linux-foundation.org
Cc: andrea.parri@amarulasolutions.com
Cc: ard.biesheuvel@linaro.org
Cc: aryabinin@virtuozzo.com
Cc: astrachan@google.com
Cc: boris.ostrovsky@oracle.com
Cc: brijesh.singh@amd.com
Cc: caoj.fnst@cn.fujitsu.com
Cc: geert@linux-m68k.org
Cc: ghackmann@google.com
Cc: gregkh@linuxfoundation.org
Cc: jan.kiszka@siemens.com
Cc: jarkko.sakkinen@linux.intel.com
Cc: jpoimboe@redhat.com
Cc: keescook@google.com
Cc: kirill.shutemov@linux.intel.com
Cc: kstewart@linuxfoundation.org
Cc: linux-efi@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: manojgupta@google.com
Cc: mawilcox@microsoft.com
Cc: michal.lkml@markovi.net
Cc: mjg59@google.com
Cc: mka@chromium.org
Cc: pombredanne@nexb.com
Cc: rientjes@google.com
Cc: rostedt@goodmis.org
Cc: sedat.dilek@gmail.com
Cc: thomas.lendacky@amd.com
Cc: tstellar@redhat.com
Cc: tweek@google.com
Cc: virtualization@lists.linux-foundation.org
Cc: will.deacon@arm.com
Cc: yamada.masahiro@socionext.com
Link: http://lkml.kernel.org/r/20180621162324.36656-2-ndesaulniers@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/compiler-gcc.h | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index fd282c7d3e5e..573f5a7d42d4 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -65,6 +65,18 @@
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 #endif
 
+/*
+ * Feature detection for gnu_inline (gnu89 extern inline semantics). Either
+ * __GNUC_STDC_INLINE__ is defined (not using gnu89 extern inline semantics,
+ * and we opt in to the gnu89 semantics), or __GNUC_STDC_INLINE__ is not
+ * defined so the gnu89 semantics are the default.
+ */
+#ifdef __GNUC_STDC_INLINE__
+# define __gnu_inline	__attribute__((gnu_inline))
+#else
+# define __gnu_inline
+#endif
+
 /*
  * Force always-inline if the user requests it so via the .config,
  * or if gcc is too old.
@@ -72,19 +84,22 @@
  * -Wunused-function.  This turns out to avoid the need for complex #ifdef
  * directives.  Suppress the warning in clang as well by using "unused"
  * function attribute, which is redundant but not harmful for gcc.
+ * Prefer gnu_inline, so that extern inline functions do not emit an
+ * externally visible function. This makes extern inline behave as per gnu89
+ * semantics rather than c99. This prevents multiple symbol definition errors
+ * of extern inline functions at link time.
+ * A lot of inline functions can cause havoc with function tracing.
  */
 #if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) ||		\
     !defined(CONFIG_OPTIMIZE_INLINING) || (__GNUC__ < 4)
-#define inline inline		__attribute__((always_inline,unused)) notrace
-#define __inline__ __inline__	__attribute__((always_inline,unused)) notrace
-#define __inline __inline	__attribute__((always_inline,unused)) notrace
+#define inline \
+	inline __attribute__((always_inline, unused)) notrace __gnu_inline
 #else
-/* A lot of inline functions can cause havoc with function tracing */
-#define inline inline		__attribute__((unused)) notrace
-#define __inline__ __inline__	__attribute__((unused)) notrace
-#define __inline __inline	__attribute__((unused)) notrace
+#define inline inline		__attribute__((unused)) notrace __gnu_inline
 #endif
 
+#define __inline__ inline
+#define __inline inline
 #define __always_inline	inline __attribute__((always_inline))
 #define  noinline	__attribute__((noinline))
 
