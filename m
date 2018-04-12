Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753095AbeDLMjQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 08:39:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:56178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751832AbeDLMjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 08:39:15 -0400
Date: Thu, 12 Apr 2018 14:39:10 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] x86/mm: vmemmap and vmalloc base addressess are usngined
 longs
Message-ID: <nycvar.YFH.7.76.1804121437350.28129@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

Commits 9b46a051e4 ("x86/mm: Initialize vmemmap_base at boot-time") and 
a7412546d8 ("x86/mm: Adjust vmalloc base and size at boot-time") lost the 
type information for __VMALLOC_BASE_L4, __VMALLOC_BASE_L5, 
__VMEMMAP_BASE_L4 and __VMEMMAP_BASE_L5 constants.

Let's declare them explicitly unsigned long again.

Fixes: 9b46a051e4 ("x86/mm: Initialize vmemmap_base at boot-time")
Fixes: a7412546d8 ("x86/mm: Adjust vmalloc base and size at boot-time")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 arch/x86/include/asm/pgtable_64_types.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index d5c21a3..adb4755 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -105,14 +105,14 @@
 #define LDT_PGD_ENTRY		(pgtable_l5_enabled ? LDT_PGD_ENTRY_L5 : LDT_PGD_ENTRY_L4)
 #define LDT_BASE_ADDR		(LDT_PGD_ENTRY << PGDIR_SHIFT)
 
-#define __VMALLOC_BASE_L4	0xffffc90000000000
-#define __VMALLOC_BASE_L5 	0xffa0000000000000
+#define __VMALLOC_BASE_L4	0xffffc90000000000UL
+#define __VMALLOC_BASE_L5 	0xffa0000000000000UL
 
 #define VMALLOC_SIZE_TB_L4	32UL
 #define VMALLOC_SIZE_TB_L5	12800UL
 
-#define __VMEMMAP_BASE_L4	0xffffea0000000000
-#define __VMEMMAP_BASE_L5	0xffd4000000000000
+#define __VMEMMAP_BASE_L4	0xffffea0000000000UL
+#define __VMEMMAP_BASE_L5	0xffd4000000000000UL
 
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 # define VMALLOC_START		vmalloc_base

-- 
Jiri Kosina
SUSE Labs
