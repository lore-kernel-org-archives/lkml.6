Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756045AbeDQQN1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:13:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56956 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754078AbeDQQNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:13:24 -0400
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/9] x86/dumpstack: Unexport oops_begin()
Date: Tue, 17 Apr 2018 18:11:17 +0200
Message-Id: <20180417161124.5294-3-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180417161124.5294-1-bp@alien8.de>
References: <20180417161124.5294-1-bp@alien8.de>
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
