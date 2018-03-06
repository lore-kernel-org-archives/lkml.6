Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753489AbeCFJtm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:49:42 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33286 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750865AbeCFJth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:49:37 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/9] x86/fault: Do not print IP in show_fault_oops()
Date: Tue,  6 Mar 2018 10:49:13 +0100
Message-Id: <20180306094920.16917-3-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180306094920.16917-1-bp@alien8.de>
References: <20180306094920.16917-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... because __show_regs() already does that.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/mm/fault.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e6af2b464c3d..26865147a507 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -699,7 +699,6 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		printk(KERN_CONT "paging request");
 
 	printk(KERN_CONT " at %px\n", (void *) address);
-	printk(KERN_ALERT "IP: %pS\n", (void *)regs->ip);
 
 	dump_pagetable(address);
 }
-- 
2.13.0
