Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbeEOFlX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 01:41:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50791 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbeEOFlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 01:41:21 -0400
Date: Mon, 14 May 2018 22:40:56 -0700
From: tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-1742ed2088ccc4ade3abd8fe888742dd0f1343f8@git.kernel.org>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, luto@amacapital.net,
        tglx@linutronix.de, richard@nod.at, torvalds@linux-foundation.org,
        yamada.masahiro@socionext.com, mingo@kernel.org, peterz@infradead.org,
        hpa@zytor.com
Reply-To: torvalds@linux-foundation.org, yamada.masahiro@socionext.com,
        mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        jdike@addtoit.com, linux-kernel@vger.kernel.org, richard@nod.at,
        tglx@linutronix.de, luto@amacapital.net
In-Reply-To: <1526352744-28229-4-git-send-email-yamada.masahiro@socionext.com>
References: <1526352744-28229-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/build/vdso: Put generated linker scripts to
 $(obj)/
Git-Commit-ID: 1742ed2088ccc4ade3abd8fe888742dd0f1343f8
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

Commit-ID:  1742ed2088ccc4ade3abd8fe888742dd0f1343f8
Gitweb:     https://git.kernel.org/tip/1742ed2088ccc4ade3abd8fe888742dd0f1343f8
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Tue, 15 May 2018 11:52:24 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 07:32:42 +0200

x86/build/vdso: Put generated linker scripts to $(obj)/

Let's put generated files to $(obj)/ rather than $(src)/ although
this is just a matter of taste because both are the same.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net
Link: http://lkml.kernel.org/r/1526352744-28229-4-git-send-email-yamada.masahiro@socionext.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/Makefile | 4 ++--
 arch/x86/um/vdso/Makefile    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 690df4c6b40a..261802b1cc50 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -51,7 +51,7 @@ VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
 			-Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096 \
 			$(DISABLE_LTO)
 
-$(obj)/vdso64.so.dbg: $(src)/vdso.lds $(vobjs) FORCE
+$(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
 
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include -I$(srctree)/include/uapi -I$(srctree)/arch/$(SUBARCH)/include/uapi
@@ -119,7 +119,7 @@ $(obj)/%.so: OBJCOPYFLAGS := -S
 $(obj)/%.so: $(obj)/%.so.dbg
 	$(call if_changed,objcopy)
 
-$(obj)/vdsox32.so.dbg: $(src)/vdsox32.lds $(vobjx32s) FORCE
+$(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
 	$(call if_changed,vdso)
 
 CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index e51d95c9098c..b2d6967262b2 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -30,7 +30,7 @@ VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
 
 $(obj)/vdso.o: $(src)/vdso.S $(obj)/vdso.so
 
-$(obj)/vdso.so.dbg: $(src)/vdso.lds $(vobjs) FORCE
+$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
 
 $(obj)/%.so: OBJCOPYFLAGS := -S
