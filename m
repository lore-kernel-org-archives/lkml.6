Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeCNUqw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:46:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752261AbeCNUqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:46:49 -0400
Date: Wed, 14 Mar 2018 13:45:56 -0700
From: "tip-bot for Tautschnig, Michael" <tipbot@zytor.com>
Message-ID: <tip-1227b344de283f96c41de02cde4b26d5290f5302@git.kernel.org>
Cc: tautschn@amazon.com, linux-kernel@vger.kernel.org,
        jaswinder@infradead.org, ak@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, linux@dominikbrodowski.net, tautschn@amazon.co.uk,
        hpa@zytor.com
Reply-To: tautschn@amazon.com, linux-kernel@vger.kernel.org,
        jaswinder@infradead.org, ak@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, linux@dominikbrodowski.net, tautschn@amazon.co.uk,
        hpa@zytor.com
In-Reply-To: <9C9981F4-0E5E-42A7-8788-70F3DEAD258D@amazon.com>
References: <9C9981F4-0E5E-42A7-8788-70F3DEAD258D@amazon.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/sigreturn: Use SYSCALL_DEFINE0
Git-Commit-ID: 1227b344de283f96c41de02cde4b26d5290f5302
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

Commit-ID:  1227b344de283f96c41de02cde4b26d5290f5302
Gitweb:     https://git.kernel.org/tip/1227b344de283f96c41de02cde4b26d5290f5302
Author:     Tautschnig, Michael <tautschn@amazon.co.uk>
AuthorDate: Wed, 14 Mar 2018 09:41:42 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 14 Mar 2018 21:43:09 +0100

x86/sigreturn: Use SYSCALL_DEFINE0

All definitions of syscalls in x86 except for those patched here have
already been using the appropriate SYSCALL_DEFINE*.

Signed-off-by: Michael Tautschnig <tautschn@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: linux-api@vger.kernel.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Jaswinder Singh <jaswinder@infradead.org>
Cc: "linux-api@vger.kernel.org"
Cc: "x86@kernel.org"
Link: https://lkml.kernel.org/r/9C9981F4-0E5E-42A7-8788-70F3DEAD258D@amazon.com

---
 arch/x86/kernel/signal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 4cdc0b27ec82..da270b95fe4d 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -25,6 +25,7 @@
 #include <linux/user-return-notifier.h>
 #include <linux/uprobes.h>
 #include <linux/context_tracking.h>
+#include <linux/syscalls.h>
 
 #include <asm/processor.h>
 #include <asm/ucontext.h>
@@ -601,7 +602,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
  * Do a signal return; undo the signal stack.
  */
 #ifdef CONFIG_X86_32
-asmlinkage unsigned long sys_sigreturn(void)
+SYSCALL_DEFINE0(sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct sigframe __user *frame;
@@ -633,7 +634,7 @@ badframe:
 }
 #endif /* CONFIG_X86_32 */
 
-asmlinkage long sys_rt_sigreturn(void)
+SYSCALL_DEFINE0(rt_sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct rt_sigframe __user *frame;
