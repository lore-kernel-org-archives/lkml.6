Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756318AbeDZNAz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:00:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45939 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754516AbeDZNAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:00:54 -0400
Date: Thu, 26 Apr 2018 06:00:45 -0700
From: tip-bot for Jiri Kosina <tipbot@zytor.com>
Message-ID: <tip-14d12bb8582e158006c35cce0f8ae1706094f9a4@git.kernel.org>
Cc: mingo@kernel.org, jkosina@suse.cz, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        hpa@zytor.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, jkosina@suse.cz, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <nycvar.YFH.7.76.1804121437350.28129@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1804121437350.28129@cbobk.fhfr.pm>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Make vmemmap and vmalloc base address
 constants unsigned long
Git-Commit-ID: 14d12bb8582e158006c35cce0f8ae1706094f9a4
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

Commit-ID:  14d12bb8582e158006c35cce0f8ae1706094f9a4
Gitweb:     https://git.kernel.org/tip/14d12bb8582e158006c35cce0f8ae1706094f9a4
Author:     Jiri Kosina <jkosina@suse.cz>
AuthorDate: Thu, 12 Apr 2018 14:39:10 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 26 Apr 2018 14:56:24 +0200

x86/mm: Make vmemmap and vmalloc base address constants unsigned long

Commits 9b46a051e4 ("x86/mm: Initialize vmemmap_base at boot-time") and 
a7412546d8 ("x86/mm: Adjust vmalloc base and size at boot-time") lost the 
type information for __VMALLOC_BASE_L4, __VMALLOC_BASE_L5, 
__VMEMMAP_BASE_L4 and __VMEMMAP_BASE_L5 constants.

Declare them explicitly unsigned long again.

Fixes: 9b46a051e4 ("x86/mm: Initialize vmemmap_base at boot-time")
Fixes: a7412546d8 ("x86/mm: Adjust vmalloc base and size at boot-time")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Link: https://lkml.kernel.org/r/nycvar.YFH.7.76.1804121437350.28129@cbobk.fhfr.pm

---
 arch/x86/include/asm/pgtable_64_types.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index d5c21a382475..adb47552e6bb 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -105,14 +105,14 @@ extern unsigned int ptrs_per_p4d;
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
