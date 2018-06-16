Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6997C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 00:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D34208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 00:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D34208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936545AbeFPA5N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 20:57:13 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:35736 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936486AbeFPA5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 20:57:11 -0400
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx29.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Sat, 16 Jun 2018 00:54:19 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Fri, 15
 Jun 2018 17:54:00 -0700
Received: from pburton-laptop.mipstec.com (10.20.2.29) by
 mipsdag02.mipstec.com (10.20.40.47) with Microsoft SMTP Server id 15.1.1415.2
 via Frontend Transport; Fri, 15 Jun 2018 17:54:00 -0700
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
Subject: [PATCH 2/3] disable -Wattribute-alias warning for SYSCALL_DEFINEx()
Date:   Fri, 15 Jun 2018 17:53:21 -0700
Message-ID: <20180616005323.7938-3-paul.burton@mips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180616005323.7938-1-paul.burton@mips.com>
References: <20180616005323.7938-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1529110459-637139-29217-15683-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194099
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: linux-kbuild@vger.kernel.org,paulus@samba.org,linux-kernel@vger.kernel.org,heiko.carstens@de.ibm.com,mpe@ellerman.id.au,keescook@chromium.org,yamada.masahiro@socionext.com,gidisrael@gmail.com,shorne@gmail.com,viro@zeniv.linux.org.uk,christophe.leroy@c-s.fr,raj.khem@gmail.com,michal.lkml@markovi.net,zhe.he@windriver.com,mka@chromium.org,akpm@linux-foundation.org,jpoimboe@redhat.com,dianders@chromium.org,tglx@linutronix.de,matthew@wil.cx,arnd@arndb.de,linux-mips@linux-mips.org,benh@kernel.crashing.org
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc-8 warns for every single definition of a system call entry
point, e.g.:

include/linux/compat.h:56:18: error: 'compat_sys_rt_sigprocmask' alias between functions of incompatible types 'long int(int,  compat_sigset_t *, compat_sigset_t *, compat_size_t)' {aka 'long int(int,  struct <anonymous> *, struct <anonymous> *, unsigned int)'} and 'long int(long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
  asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))\
                  ^~~~~~~~~~
include/linux/compat.h:45:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
  COMPAT_SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~
kernel/signal.c:2601:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE4'
 COMPAT_SYSCALL_DEFINE4(rt_sigprocmask, int, how, compat_sigset_t __user *, nset,
 ^~~~~~~~~~~~~~~~~~~~~~
include/linux/compat.h:60:18: note: aliased declaration here
  asmlinkage long compat_SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))\
                  ^~~~~~~~~~

The new warning seems reasonable in principle, but it doesn't
help us here, since we rely on the type mismatch to sanitize the
system call arguments. After I reported this as GCC PR82435, a new
-Wno-attribute-alias option was added that could be used to turn the
warning off globally on the command line, but I'd prefer to do it a
little more fine-grained.

Interestingly, turning a warning off and on again inside of
a single macro doesn't always work, in this case I had to add
an extra statement inbetween and decided to copy the __SC_TEST
one from the native syscall to the compat syscall macro.  See
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83256 for more details
about this.

[paul.burton@mips.com:
  - Rebase atop current master.
  - Split GCC & version arguments to __diag_ignore() in order to match
    changes to the preceding patch.
  - Add the comment argument to match the preceding patch.]

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82435
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Paul Burton <paul.burton@mips.com>
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

 include/linux/compat.h   | 8 +++++++-
 include/linux/syscalls.h | 4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index b1a5562b3215..c68acc47da57 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -72,6 +72,9 @@
  */
 #ifndef COMPAT_SYSCALL_DEFINEx
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
+	__diag_push();								\
+	__diag_ignore(GCC, 8, "-Wattribute-alias",				\
+		      "Type aliasing is used to sanitize syscall arguments");\
 	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
 	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
 		__attribute__((alias(__stringify(__se_compat_sys##name))));	\
@@ -80,8 +83,11 @@
 	asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
 	asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
 	{									\
-		return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
+		long ret = __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
+		__MAP(x,__SC_TEST,__VA_ARGS__);					\
+		return ret;							\
 	}									\
+	__diag_pop();								\
 	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 #endif /* COMPAT_SYSCALL_DEFINEx */
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 73810808cdf2..a368a68cb667 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -231,6 +231,9 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
  */
 #ifndef __SYSCALL_DEFINEx
 #define __SYSCALL_DEFINEx(x, name, ...)					\
+	__diag_push();							\
+	__diag_ignore(GCC, 8, "-Wattribute-alias",			\
+		      "Type aliasing is used to sanitize syscall arguments");\
 	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
 		__attribute__((alias(__stringify(__se_sys##name))));	\
 	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
@@ -243,6 +246,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
 		return ret;						\
 	}								\
+	__diag_pop();							\
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 #endif /* __SYSCALL_DEFINEx */
 
-- 
2.17.1

