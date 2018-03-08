Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755741AbeCHLKN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:10:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47333 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751971AbeCHLKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:10:11 -0500
Date: Thu, 8 Mar 2018 03:09:48 -0800
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-9558080935e0bd744d68a7e1747a7117310623cf@git.kernel.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, luto@amacapital.net,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        peterz@infradead.org, jpoimboe@redhat.com, mingo@kernel.org,
        bp@suse.de
Reply-To: bp@suse.de, peterz@infradead.org, mingo@kernel.org,
        jpoimboe@redhat.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        luto@amacapital.net
In-Reply-To: <20180306094920.16917-3-bp@alien8.de>
References: <20180306094920.16917-3-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/fault: Do not print IP in show_fault_oops()
Git-Commit-ID: 9558080935e0bd744d68a7e1747a7117310623cf
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

Commit-ID:  9558080935e0bd744d68a7e1747a7117310623cf
Gitweb:     https://git.kernel.org/tip/9558080935e0bd744d68a7e1747a7117310623cf
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Tue, 6 Mar 2018 10:49:13 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 12:04:59 +0100

x86/fault: Do not print IP in show_fault_oops()

... because __show_regs() already does that.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Link: https://lkml.kernel.org/r/20180306094920.16917-3-bp@alien8.de

---
 arch/x86/mm/fault.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index c88573d90f3e..93505990df10 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -699,7 +699,6 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		printk(KERN_CONT "paging request");
 
 	printk(KERN_CONT " at %px\n", (void *) address);
-	printk(KERN_ALERT "IP: %pS\n", (void *)regs->ip);
 
 	dump_pagetable(address);
 }
