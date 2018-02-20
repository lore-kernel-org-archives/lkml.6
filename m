Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751608AbeBTK2t (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 05:28:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37191 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeBTK2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 05:28:47 -0500
Date: Tue, 20 Feb 2018 02:28:07 -0800
From: tip-bot for Jan Beulich <tipbot@zytor.com>
Message-ID: <tip-8554004a0231dedf44d4d62147fb3d6a6db489aa@git.kernel.org>
Cc: torvalds@linux-foundation.org, peterz@infradead.org, luto@kernel.org,
        hpa@zytor.com, jpoimboe@redhat.com, dvlasenk@redhat.com,
        JBeulich@suse.com, tglx@linutronix.de, brgerst@gmail.com,
        jbeulich@suse.com, bp@alien8.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: mingo@kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, hpa@zytor.com, luto@kernel.org, brgerst@gmail.com,
        jbeulich@suse.com, JBeulich@suse.com, dvlasenk@redhat.com,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org
In-Reply-To: <5A8AF5F602000078001A9230@prv-mh.provo.novell.com>
References: <5A8AF5F602000078001A9230@prv-mh.provo.novell.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86-64/realmode: Add instruction suffix
Git-Commit-ID: 8554004a0231dedf44d4d62147fb3d6a6db489aa
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

Commit-ID:  8554004a0231dedf44d4d62147fb3d6a6db489aa
Gitweb:     https://git.kernel.org/tip/8554004a0231dedf44d4d62147fb3d6a6db489aa
Author:     Jan Beulich <JBeulich@suse.com>
AuthorDate: Mon, 19 Feb 2018 08:06:14 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Feb 2018 09:33:41 +0100

x86-64/realmode: Add instruction suffix

Omitting suffixes from instructions in AT&T mode is bad practice when
operand size cannot be determined by the assembler from register
operands, and is likely going to be warned about by upstream GAS in the
future (mine does already). Add the single missing suffix here.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/5A8AF5F602000078001A9230@prv-mh.provo.novell.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/realmode/rm/trampoline_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index de53bd1..24bb759 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -102,7 +102,7 @@ ENTRY(startup_32)
 	 * don't we'll eventually crash trying to execute encrypted
 	 * instructions.
 	 */
-	bt	$TH_FLAGS_SME_ACTIVE_BIT, pa_tr_flags
+	btl	$TH_FLAGS_SME_ACTIVE_BIT, pa_tr_flags
 	jnc	.Ldone
 	movl	$MSR_K8_SYSCFG, %ecx
 	rdmsr
