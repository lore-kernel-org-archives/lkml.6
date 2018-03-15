Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932672AbeCOPpx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:45:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47936 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932480AbeCOPpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:45:50 -0400
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/9] x86/dumpstack: Unexport oops_begin()
Date: Thu, 15 Mar 2018 16:44:41 +0100
Message-Id: <20180315154448.16222-3-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180315154448.16222-1-bp@alien8.de>
References: <20180315154448.16222-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The only user outside of arch/ is not a module since

  86cd47334b00 ("ACPI, APEI, GHES, Prevent GHES to be built as module")

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
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
-- 
2.13.0
