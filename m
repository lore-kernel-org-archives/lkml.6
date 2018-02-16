Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934733AbeBPLAI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:00:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36329 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeBPLAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:00:06 -0500
Date: Fri, 16 Feb 2018 02:49:25 -0800
From: tip-bot for Matthew Whitehead <tipbot@zytor.com>
Message-ID: <tip-f960cfd12650fad43c1cde07a1f7642cf2c57f97@git.kernel.org>
Cc: dvlasenk@redhat.com, hpa@zytor.com, peterz@infradead.org,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        brgerst@gmail.com, bp@alien8.de, arjan@linux.intel.com,
        tedheadster@gmail.com, mingo@kernel.org, torvalds@linux-foundation.org,
        luto@kernel.org
Reply-To: bp@alien8.de, arjan@linux.intel.com, tedheadster@gmail.com,
        mingo@kernel.org, torvalds@linux-foundation.org, luto@kernel.org,
        dvlasenk@redhat.com, hpa@zytor.com, jpoimboe@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org, brgerst@gmail.com,
        tglx@linutronix.de
In-Reply-To: <1518713696-11360-1-git-send-email-tedheadster@gmail.com>
References: <1518713696-11360-1-git-send-email-tedheadster@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/Kconfig: Add missing i586-class CPUs to the
 X86_CMPXCHG64 Kconfig group
Git-Commit-ID: f960cfd12650fad43c1cde07a1f7642cf2c57f97
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

Commit-ID:  f960cfd12650fad43c1cde07a1f7642cf2c57f97
Gitweb:     https://git.kernel.org/tip/f960cfd12650fad43c1cde07a1f7642cf2c57f97
Author:     Matthew Whitehead <tedheadster@gmail.com>
AuthorDate: Thu, 15 Feb 2018 11:54:54 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 16 Feb 2018 10:36:39 +0100

x86/Kconfig: Add missing i586-class CPUs to the X86_CMPXCHG64 Kconfig group

Several i586-class CPUs supporting this instruction are missing from
the X86_CMPXCHG64 config group.

Using a configuration with either M586TSC or M586MMX currently sets
X86_MINIMUM_CPU_FAMILY=4 instead of the correct value of 5.

Booting on an i486 it will fail to generate the "This kernel
requires an i586 CPU, but only detected an i486 CPU" message and
intentional halt as expected. It will instead just silently hang
when it hits i586-specific instructions.

The M586 CPU is not in this list because at least the Cyrix 5x86
lacks this instruction, and perhaps others.

Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1518713696-11360-1-git-send-email-tedheadster@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig.cpu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 65a9a47..ec64aa7 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -374,7 +374,7 @@ config X86_TSC
 
 config X86_CMPXCHG64
 	def_bool y
-	depends on X86_PAE || X86_64 || MCORE2 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MATOM
+	depends on X86_PAE || X86_64 || MCORE2 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586TSC || M586MMX || MATOM || MGEODE_LX || MGEODEGX1 || MK6 || MK7 || MK8
 
 # this should be set for all -march=.. options where the compiler
 # generates cmov.
