Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 26QEOHNHGVu0PQAAmS7hNA
	; Thu, 07 Jun 2018 14:56:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 11593607E7; Thu,  7 Jun 2018 14:56:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id ED04D601C3;
	Thu,  7 Jun 2018 14:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED04D601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935511AbeFGOzx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:55:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41077 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935481AbeFGOzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:55:47 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-0005hK-7c; Thu, 07 Jun 2018 15:09:08 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb9-000362-0b; Thu, 07 Jun 2018 15:09:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>,
        linux-edac@vger.kernel.org, "Petr Mladek" <pmladek@suse.com>,
        linux-sh@vger.kernel.org, "Will Deacon" <will.deacon@arm.com>,
        linux-snps-arc@lists.infradead.org,
        "Sergey Senozhatsky" <sergey.senozhatsky.work@gmail.com>,
        linux-c6x-dev@linux-c6x.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>, linux-am33-list@redhat.com
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.214381661@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 267/410] arm64: do not use print_symbol()
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

commit 4ef7963843d3243260aa335dfb9cb2fede06aacf upstream.

print_symbol() is a very old API that has been obsoleted by %pS format
specifier in a normal printk() call.

Replace print_symbol() with a direct printk("%pS") call.

Link: http://lkml.kernel.org/r/20171211125025.2270-3-sergey.senozhatsky@gmail.com
To: Andrew Morton <akpm@linux-foundation.org>
To: Russell King <linux@armlinux.org.uk>
To: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Salter <msalter@redhat.com>
To: Tony Luck <tony.luck@intel.com>
To: David Howells <dhowells@redhat.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
To: Borislav Petkov <bp@alien8.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
To: Vineet Gupta <vgupta@synopsys.com>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-c6x-dev@linux-c6x.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-am33-list@redhat.com
Cc: linux-sh@vger.kernel.org
Cc: linux-edac@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
[pmladek@suse.com: updated commit message]
Signed-off-by: Petr Mladek <pmladek@suse.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm64/kernel/process.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -31,7 +31,6 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/interrupt.h>
-#include <linux/kallsyms.h>
 #include <linux/init.h>
 #include <linux/cpu.h>
 #include <linux/elfcore.h>
@@ -198,8 +197,8 @@ void __show_regs(struct pt_regs *regs)
 	}
 
 	show_regs_print_info(KERN_DEFAULT);
-	print_symbol("pc : %s\n", regs->pc);
-	print_symbol("lr : %s\n", lr);
+	printk("pc : %pS\n", (void *)regs->pc);
+	printk("lr : %pS\n", (void *)lr);
 	printk("sp : %016llx pstate : %08llx\n", sp, regs->pstate);
 	for (i = top_reg; i >= 0; i--) {
 		printk("x%-2d: %016llx ", i, regs->regs[i]);
