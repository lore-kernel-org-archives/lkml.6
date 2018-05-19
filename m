Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbeESLga (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:36:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43507 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752119AbeESLg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:36:29 -0400
Date: Sat, 19 May 2018 04:36:09 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-e4e961e36f063484c48bed919013c106d178995d@git.kernel.org>
Cc: kirill.shutemov@linux.intel.com, hughd@google.com, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        hpa@zytor.com, peterz@infradead.org, kirill.shutemov@linux.intel.com,
        mingo@kernel.org, tglx@linutronix.de, hughd@google.com
In-Reply-To: <20180518103528.59260-8-kirill.shutemov@linux.intel.com>
References: <20180518103528.59260-8-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/mm: Mark __pgtable_l5_enabled __initdata
Git-Commit-ID: e4e961e36f063484c48bed919013c106d178995d
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

Commit-ID:  e4e961e36f063484c48bed919013c106d178995d
Gitweb:     https://git.kernel.org/tip/e4e961e36f063484c48bed919013c106d178995d
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Fri, 18 May 2018 13:35:28 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 19 May 2018 11:56:58 +0200

x86/mm: Mark __pgtable_l5_enabled __initdata

__pgtable_l5_enabled shouldn't be needed after system has booted.
All preparation is done. We can now mark it as __initdata.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180518103528.59260-8-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/head64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8047379e575a..a21d6ace648e 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -44,7 +44,7 @@ static unsigned int __initdata next_early_pgt;
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
 #ifdef CONFIG_X86_5LEVEL
-unsigned int __pgtable_l5_enabled __ro_after_init;
+unsigned int __pgtable_l5_enabled __initdata;
 unsigned int pgdir_shift __ro_after_init = 39;
 EXPORT_SYMBOL(pgdir_shift);
 unsigned int ptrs_per_p4d __ro_after_init = 1;
