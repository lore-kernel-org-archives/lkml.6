Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965341AbeBMRAA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:00:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38373 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965261AbeBMQ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:59:56 -0500
Date: Tue, 13 Feb 2018 08:59:31 -0800
From: tip-bot for Alexey Dobriyan <tipbot@zytor.com>
Message-ID: <tip-1acdbf7ea8a80706561013346d281d282a3c00f9@git.kernel.org>
Cc: mingo@kernel.org, peterz@infradead.org, adobriyan@gmail.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@suse.de, torvalds@linux-foundation.org
Reply-To: peterz@infradead.org, adobriyan@gmail.com, hpa@zytor.com,
        mingo@kernel.org, torvalds@linux-foundation.org, bp@suse.de,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20180113185048.GA23111@avx2>
References: <20180113185048.GA23111@avx2>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/asm: Clobber flags in clear_page()
Git-Commit-ID: 1acdbf7ea8a80706561013346d281d282a3c00f9
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

Commit-ID:  1acdbf7ea8a80706561013346d281d282a3c00f9
Gitweb:     https://git.kernel.org/tip/1acdbf7ea8a80706561013346d281d282a3c00f9
Author:     Alexey Dobriyan <adobriyan@gmail.com>
AuthorDate: Sat, 13 Jan 2018 21:50:48 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 17:36:49 +0100

x86/asm: Clobber flags in clear_page()

All clear_page() implementations use XOR which resets flags.

Judging by allyesconfig disassembly no code is affected.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180113185048.GA23111@avx2
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/page_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 4baa6bc..f8a85c6 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -47,7 +47,7 @@ static inline void clear_page(void *page)
 			   clear_page_erms, X86_FEATURE_ERMS,
 			   "=D" (page),
 			   "0" (page)
-			   : "memory", "rax", "rcx");
+			   : "cc", "memory", "rax", "rcx");
 }
 
 void copy_page(void *to, void *from);
