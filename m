Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeBTK1i (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 05:27:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42331 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeBTK1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 05:27:37 -0500
Date: Tue, 20 Feb 2018 02:27:06 -0800
From: tip-bot for Jan Beulich <tipbot@zytor.com>
Message-ID: <tip-6262b6e78ce5ba62be47774ca80f5b0a6f0eb428@git.kernel.org>
Cc: mingo@kernel.org, JBeulich@suse.com, dvlasenk@redhat.com,
        luto@kernel.org, hpa@zytor.com, tglx@linutronix.de, brgerst@gmail.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
        jpoimboe@redhat.com, torvalds@linux-foundation.org, jbeulich@suse.com
Reply-To: torvalds@linux-foundation.org, jbeulich@suse.com,
        jpoimboe@redhat.com, peterz@infradead.org, bp@alien8.de,
        linux-kernel@vger.kernel.org, brgerst@gmail.com, tglx@linutronix.de,
        hpa@zytor.com, luto@kernel.org, dvlasenk@redhat.com, mingo@kernel.org,
        JBeulich@suse.com
In-Reply-To: <5A8AF23F02000078001A91E5@prv-mh.provo.novell.com>
References: <5A8AF23F02000078001A91E5@prv-mh.provo.novell.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/IO-APIC: Avoid warning in 32-bit builds
Git-Commit-ID: 6262b6e78ce5ba62be47774ca80f5b0a6f0eb428
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

Commit-ID:  6262b6e78ce5ba62be47774ca80f5b0a6f0eb428
Gitweb:     https://git.kernel.org/tip/6262b6e78ce5ba62be47774ca80f5b0a6f0eb428
Author:     Jan Beulich <JBeulich@suse.com>
AuthorDate: Mon, 19 Feb 2018 07:50:23 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Feb 2018 09:33:40 +0100

x86/IO-APIC: Avoid warning in 32-bit builds

Constants wider than 32 bits should be tagged with ULL.

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
Link: http://lkml.kernel.org/r/5A8AF23F02000078001A91E5@prv-mh.provo.novell.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/apic/io_apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 8ad2e41..7c55387 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1603,7 +1603,7 @@ static void __init delay_with_tsc(void)
 	do {
 		rep_nop();
 		now = rdtsc();
-	} while ((now - start) < 40000000000UL / HZ &&
+	} while ((now - start) < 40000000000ULL / HZ &&
 		time_before_eq(jiffies, end));
 }
 
