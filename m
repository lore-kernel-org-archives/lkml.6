Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752393AbeEOFk7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 01:40:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48145 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752090AbeEOFk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 01:40:58 -0400
Date: Mon, 14 May 2018 22:40:22 -0700
From: tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-61615faf0a8968b604bd279fec5cb834ba59ed58@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, richard@nod.at,
        torvalds@linux-foundation.org, yamada.masahiro@socionext.com,
        jdike@addtoit.com, hpa@zytor.com, tglx@linutronix.de,
        peterz@infradead.org, luto@amacapital.net
Reply-To: jdike@addtoit.com, hpa@zytor.com, luto@amacapital.net,
        tglx@linutronix.de, peterz@infradead.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, yamada.masahiro@socionext.com,
        torvalds@linux-foundation.org, richard@nod.at
In-Reply-To: <1526352744-28229-3-git-send-email-yamada.masahiro@socionext.com>
References: <1526352744-28229-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/build/vdso: Remove unnecessary export in
 Makefile
Git-Commit-ID: 61615faf0a8968b604bd279fec5cb834ba59ed58
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

Commit-ID:  61615faf0a8968b604bd279fec5cb834ba59ed58
Gitweb:     https://git.kernel.org/tip/61615faf0a8968b604bd279fec5cb834ba59ed58
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Tue, 15 May 2018 11:52:23 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 07:32:42 +0200

x86/build/vdso: Remove unnecessary export in Makefile

CPPFLAGS_vdso.lds is assigned and referenced internally in each
Makefile.  No need to export it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net
Link: http://lkml.kernel.org/r/1526352744-28229-3-git-send-email-yamada.masahiro@socionext.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/Makefile | 2 +-
 arch/x86/um/vdso/Makefile    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 298850683ee2..690df4c6b40a 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -44,7 +44,7 @@ obj-y += $(vdso_img_objs)
 targets += $(vdso_img_cfiles)
 targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
 
-export CPPFLAGS_vdso.lds += -P -C
+CPPFLAGS_vdso.lds += -P -C
 
 VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
 			-Wl,--no-undefined \
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 10003359e633..e51d95c9098c 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -23,7 +23,7 @@ $(obj)/vdso.o: $(obj)/vdso.so
 
 targets += vdso.so vdso.so.dbg vdso.lds $(vobjs-y)
 
-export CPPFLAGS_vdso.lds += -P -C
+CPPFLAGS_vdso.lds += -P -C
 
 VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
        -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
