Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756585AbeDZOTm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:19:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34077 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756431AbeDZOTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:19:38 -0400
Date: Thu, 26 Apr 2018 07:19:16 -0700
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-5df61707f0bdf8dce714a14806740e6abf2114c7@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        luto@amacapital.net, peterz@infradead.org, jpoimboe@redhat.com,
        hpa@zytor.com, torvalds@linux-foundation.org, bp@suse.de
Reply-To: tglx@linutronix.de, luto@amacapital.net,
        linux-kernel@vger.kernel.org, mingo@kernel.org, bp@suse.de,
        peterz@infradead.org, jpoimboe@redhat.com, hpa@zytor.com,
        torvalds@linux-foundation.org
In-Reply-To: <20180417161124.5294-3-bp@alien8.de>
References: <20180417161124.5294-3-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/dumpstack: Unexport oops_begin()
Git-Commit-ID: 5df61707f0bdf8dce714a14806740e6abf2114c7
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

Commit-ID:  5df61707f0bdf8dce714a14806740e6abf2114c7
Gitweb:     https://git.kernel.org/tip/5df61707f0bdf8dce714a14806740e6abf2114c7
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Tue, 17 Apr 2018 18:11:17 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 26 Apr 2018 16:15:26 +0200

x86/dumpstack: Unexport oops_begin()

The only user outside of arch/ is not a module since

  86cd47334b00 ("ACPI, APEI, GHES, Prevent GHES to be built as module")

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Link: https://lkml.kernel.org/r/20180417161124.5294-3-bp@alien8.de

---
 arch/x86/kernel/dumpstack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 593db796374d..579455c2b91e 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -268,7 +268,6 @@ unsigned long oops_begin(void)
 	bust_spinlocks(1);
 	return flags;
 }
-EXPORT_SYMBOL_GPL(oops_begin);
 NOKPROBE_SYMBOL(oops_begin);
 
 void __noreturn rewind_stack_do_exit(int signr);
