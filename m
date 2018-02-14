Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967808AbeBNNOz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:14:55 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54687 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967729AbeBNNOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:14:54 -0500
Date: Wed, 14 Feb 2018 05:04:20 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-b83ce5ee91471d19c403ff91227204fb37c95fb2@git.kernel.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, bp@suse.de, peterz@infradead.org,
        tglx@linutronix.de, luto@amacapital.net,
        kirill.shutemov@linux.intel.com, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org, bp@suse.de,
        mingo@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        luto@amacapital.net
In-Reply-To: <20180214111656.88514-2-kirill.shutemov@linux.intel.com>
References: <20180214111656.88514-2-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52
Git-Commit-ID: b83ce5ee91471d19c403ff91227204fb37c95fb2
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

Commit-ID:  b83ce5ee91471d19c403ff91227204fb37c95fb2
Gitweb:     https://git.kernel.org/tip/b83ce5ee91471d19c403ff91227204fb37c95fb2
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 14 Feb 2018 14:16:48 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 14 Feb 2018 13:11:13 +0100

x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52

__PHYSICAL_MASK_SHIFT is used to define the mask that helps to extract
physical address from a page table entry.

Although real physical address space available may differ between
machines, it's safe to use 52 as __PHYSICAL_MASK_SHIFT. Unused bits
above log2(MAXPHYADDR) up to bit 51 are reserved and must be 0.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180214111656.88514-2-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/page_64_types.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index e140731..f68e652 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -52,11 +52,12 @@
 #define __START_KERNEL_map	_AC(0xffffffff80000000, UL)
 
 /* See Documentation/x86/x86_64/mm.txt for a description of the memory map. */
-#ifdef CONFIG_X86_5LEVEL
+
 #define __PHYSICAL_MASK_SHIFT	52
+
+#ifdef CONFIG_X86_5LEVEL
 #define __VIRTUAL_MASK_SHIFT	56
 #else
-#define __PHYSICAL_MASK_SHIFT	46
 #define __VIRTUAL_MASK_SHIFT	47
 #endif
 
