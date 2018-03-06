Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753473AbeCFJtk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:49:40 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33272 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750859AbeCFJtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:49:36 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/9] panic: Add closing panic marker parenthesis
Date: Tue,  6 Mar 2018 10:49:12 +0100
Message-Id: <20180306094920.16917-2-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180306094920.16917-1-bp@alien8.de>
References: <20180306094920.16917-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Otherwise it looks unbalanced.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 kernel/panic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 2cfef408fec9..9fb023d0cae1 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -289,7 +289,7 @@ void panic(const char *fmt, ...)
 		disabled_wait(caller);
 	}
 #endif
-	pr_emerg("---[ end Kernel panic - not syncing: %s\n", buf);
+	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
 	local_irq_enable();
 	for (i = 0; ; i += PANIC_TIMER_STEP) {
 		touch_softlockup_watchdog();
-- 
2.13.0
