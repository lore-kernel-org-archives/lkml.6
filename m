Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935756AbeCHLEb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:04:31 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59369 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754752AbeCHLE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:04:29 -0500
Date: Thu, 8 Mar 2018 03:03:52 -0800
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-5ad751053704df3f00d2bb2dc9345c697c212150@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, bp@suse.de, tglx@linutronix.de,
        jpoimboe@redhat.com, torvalds@linux-foundation.org,
        peterz@infradead.org, luto@amacapital.net,
        linux-kernel@vger.kernel.org
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
        luto@amacapital.net, tglx@linutronix.de, bp@suse.de, hpa@zytor.com,
        mingo@kernel.org, torvalds@linux-foundation.org, jpoimboe@redhat.com
In-Reply-To: <20180306094920.16917-2-bp@alien8.de>
References: <20180306094920.16917-2-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/core] panic: Add closing panic marker parenthesis
Git-Commit-ID: 5ad751053704df3f00d2bb2dc9345c697c212150
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

Commit-ID:  5ad751053704df3f00d2bb2dc9345c697c212150
Gitweb:     https://git.kernel.org/tip/5ad751053704df3f00d2bb2dc9345c697c212150
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Tue, 6 Mar 2018 10:49:12 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 12:01:10 +0100

panic: Add closing panic marker parenthesis

Otherwise it looks unbalanced.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Link: https://lkml.kernel.org/r/20180306094920.16917-2-bp@alien8.de

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
