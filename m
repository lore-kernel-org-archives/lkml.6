Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbeEOFkQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 01:40:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41017 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbeEOFkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 01:40:15 -0400
Date: Mon, 14 May 2018 22:39:52 -0700
From: tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-b3656612118f8961182f988168c835f023f0408a@git.kernel.org>
Cc: hpa@zytor.com, luto@amacapital.net, yamada.masahiro@socionext.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de, mingo@kernel.org
Reply-To: yamada.masahiro@socionext.com, luto@amacapital.net, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org
In-Reply-To: <1526352744-28229-2-git-send-email-yamada.masahiro@socionext.com>
References: <1526352744-28229-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/build/vdso: Remove unused $(vobjs-nox32) in
 Makefile
Git-Commit-ID: b3656612118f8961182f988168c835f023f0408a
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

Commit-ID:  b3656612118f8961182f988168c835f023f0408a
Gitweb:     https://git.kernel.org/tip/b3656612118f8961182f988168c835f023f0408a
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Tue, 15 May 2018 11:52:22 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 07:32:42 +0200

x86/build/vdso: Remove unused $(vobjs-nox32) in Makefile

Since commit bfad381c0d1e ("x86/vdso: Improve the fake section
headers"), $(vobjs-nox32) is empty.  Therefore, $(vobjs64-for-x32)
is the same as $(vobjs-y).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1526352744-28229-2-git-send-email-yamada.masahiro@socionext.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index d998a487c9b1..298850683ee2 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -100,11 +100,8 @@ VDSO_LDFLAGS_vdsox32.lds = -Wl,-m,elf32_x86_64 \
 			   -Wl,-z,max-page-size=4096 \
 			   -Wl,-z,common-page-size=4096
 
-# 64-bit objects to re-brand as x32
-vobjs64-for-x32 := $(filter-out $(vobjs-nox32),$(vobjs-y))
-
 # x32-rebranded versions
-vobjx32s-y := $(vobjs64-for-x32:.o=-x32.o)
+vobjx32s-y := $(vobjs-y:.o=-x32.o)
 
 # same thing, but in the output directory
 vobjx32s := $(foreach F,$(vobjx32s-y),$(obj)/$F)
