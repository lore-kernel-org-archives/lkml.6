Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752895AbeCaIBg (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 04:01:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58567 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751766AbeCaIBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 04:01:34 -0400
Date: Sat, 31 Mar 2018 01:00:53 -0700
From: tip-bot for Cao jin <tipbot@zytor.com>
Message-ID: <tip-d6289f36aa7d5893d091a7a0c67eee7798719f03@git.kernel.org>
Cc: tglx@linutronix.de, yamada.masahiro@socionext.com,
        linux-kernel@vger.kernel.org, michal.lkml@markovi.net,
        mingo@kernel.org, peterz@infradead.org, caoj.fnst@cn.fujitsu.com,
        torvalds@linux-foundation.org, hpa@zytor.com
Reply-To: yamada.masahiro@socionext.com, tglx@linutronix.de,
        michal.lkml@markovi.net, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        caoj.fnst@cn.fujitsu.com
In-Reply-To: <20180316084944.3997-1-caoj.fnst@cn.fujitsu.com>
References: <20180316084944.3997-1-caoj.fnst@cn.fujitsu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/build: Don't pass in -D__KERNEL__ multiple
 times
Git-Commit-ID: d6289f36aa7d5893d091a7a0c67eee7798719f03
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d6289f36aa7d5893d091a7a0c67eee7798719f03
Gitweb:     https://git.kernel.org/tip/d6289f36aa7d5893d091a7a0c67eee7798719f03
Author:     Cao jin <caoj.fnst@cn.fujitsu.com>
AuthorDate: Fri, 16 Mar 2018 16:49:44 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 31 Mar 2018 08:02:07 +0200

x86/build: Don't pass in -D__KERNEL__ multiple times

Some .<target>.cmd files under arch/x86 are showing two instances of
-D__KERNEL__, like arch/x86/boot/ and arch/x86/realmode/rm/.

__KERNEL__ is already defined in KBUILD_CPPFLAGS in the top Makefile,
so it can be dropped safely.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kbuild@vger.kernel.org
Link: http://lkml.kernel.org/r/20180316084944.3997-1-caoj.fnst@cn.fujitsu.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Makefile                 | 3 +--
 arch/x86/boot/compressed/Makefile | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index d798e36d103c..a517852dad55 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -31,8 +31,7 @@ endif
 CODE16GCC_CFLAGS := -m32 -Wa,$(srctree)/arch/x86/boot/code16gcc.h
 M16_CFLAGS	 := $(call cc-option, -m16, $(CODE16GCC_CFLAGS))
 
-REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os -D__KERNEL__ \
-		   -DDISABLE_BRANCH_PROFILING \
+REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
 		   -mno-mmx -mno-sse
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f25e1530e064..f484ae0ece93 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -26,7 +26,7 @@ KCOV_INSTRUMENT		:= n
 targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4
 
-KBUILD_CFLAGS := -m$(BITS) -D__KERNEL__ -O2
+KBUILD_CFLAGS := -m$(BITS) -O2
 KBUILD_CFLAGS += -fno-strict-aliasing $(call cc-option, -fPIE, -fPIC)
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 cflags-$(CONFIG_X86_32) := -march=i386
