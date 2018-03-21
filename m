Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753582AbeCUTZb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:25:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753514AbeCUTZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:25:03 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 26/32] docs/vm: unevictable-lru.txt: convert to ReST format
Date: Wed, 21 Mar 2018 21:22:42 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0044-0000-0000-0000053E7353
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0045-0000-0000-0000287D78F5
Message-Id: <1521660168-14372-27-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210221
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/vm/unevictable-lru.txt | 117 +++++++++++++++--------------------
 1 file changed, 49 insertions(+), 68 deletions(-)

diff --git a/Documentation/vm/unevictable-lru.txt b/Documentation/vm/unevictable-lru.txt
index e147185..fdd84cb 100644
--- a/Documentation/vm/unevictable-lru.txt
+++ b/Documentation/vm/unevictable-lru.txt
@@ -1,37 +1,13 @@
-			==============================
-			UNEVICTABLE LRU INFRASTRUCTURE
-			==============================
-
-========
-CONTENTS
-========
-
- (*) The Unevictable LRU
-
-     - The unevictable page list.
-     - Memory control group interaction.
-     - Marking address spaces unevictable.
-     - Detecting Unevictable Pages.
-     - vmscan's handling of unevictable pages.
-
- (*) mlock()'d pages.
-
-     - History.
-     - Basic management.
-     - mlock()/mlockall() system call handling.
-     - Filtering special vmas.
-     - munlock()/munlockall() system call handling.
-     - Migrating mlocked pages.
-     - Compacting mlocked pages.
-     - mmap(MAP_LOCKED) system call handling.
-     - munmap()/exit()/exec() system call handling.
-     - try_to_unmap().
-     - try_to_munlock() reverse map scan.
-     - Page reclaim in shrink_*_list().
+.. _unevictable_lru:
 
+==============================
+Unevictable LRU Infrastructure
+==============================
 
-============
-INTRODUCTION
+.. contents:: :local:
+
+
+Introduction
 ============
 
 This document describes the Linux memory manager's "Unevictable LRU"
@@ -46,8 +22,8 @@ details - the "what does it do?" - by reading the code.  One hopes that the
 descriptions below add value by provide the answer to "why does it do that?".
 
 
-===================
-THE UNEVICTABLE LRU
+
+The Unevictable LRU
 ===================
 
 The Unevictable LRU facility adds an additional LRU list to track unevictable
@@ -66,17 +42,17 @@ completely unresponsive.
 
 The unevictable list addresses the following classes of unevictable pages:
 
- (*) Those owned by ramfs.
+ * Those owned by ramfs.
 
- (*) Those mapped into SHM_LOCK'd shared memory regions.
+ * Those mapped into SHM_LOCK'd shared memory regions.
 
- (*) Those mapped into VM_LOCKED [mlock()ed] VMAs.
+ * Those mapped into VM_LOCKED [mlock()ed] VMAs.
 
 The infrastructure may also be able to handle other conditions that make pages
 unevictable, either by definition or by circumstance, in the future.
 
 
-THE UNEVICTABLE PAGE LIST
+The Unevictable Page List
 -------------------------
 
 The Unevictable LRU infrastructure consists of an additional, per-zone, LRU list
@@ -118,7 +94,7 @@ the unevictable list when one task has the page isolated from the LRU and other
 tasks are changing the "evictability" state of the page.
 
 
-MEMORY CONTROL GROUP INTERACTION
+Memory Control Group Interaction
 --------------------------------
 
 The unevictable LRU facility interacts with the memory control group [aka
@@ -144,7 +120,9 @@ effects:
      the control group to thrash or to OOM-kill tasks.
 
 
-MARKING ADDRESS SPACES UNEVICTABLE
+.. _mark_addr_space_unevict:
+
+Marking Address Spaces Unevictable
 ----------------------------------
 
 For facilities such as ramfs none of the pages attached to the address space
@@ -152,15 +130,15 @@ may be evicted.  To prevent eviction of any such pages, the AS_UNEVICTABLE
 address space flag is provided, and this can be manipulated by a filesystem
 using a number of wrapper functions:
 
- (*) void mapping_set_unevictable(struct address_space *mapping);
+ * ``void mapping_set_unevictable(struct address_space *mapping);``
 
 	Mark the address space as being completely unevictable.
 
- (*) void mapping_clear_unevictable(struct address_space *mapping);
+ * ``void mapping_clear_unevictable(struct address_space *mapping);``
 
 	Mark the address space as being evictable.
 
- (*) int mapping_unevictable(struct address_space *mapping);
+ * ``int mapping_unevictable(struct address_space *mapping);``
 
 	Query the address space, and return true if it is completely
 	unevictable.
@@ -177,12 +155,13 @@ These are currently used in two places in the kernel:
      ensure they're in memory.
 
 
-DETECTING UNEVICTABLE PAGES
+Detecting Unevictable Pages
 ---------------------------
 
 The function page_evictable() in vmscan.c determines whether a page is
-evictable or not using the query function outlined above [see section "Marking
-address spaces unevictable"] to check the AS_UNEVICTABLE flag.
+evictable or not using the query function outlined above [see section
+:ref:`Marking address spaces unevictable <mark_addr_space_unevict>`]
+to check the AS_UNEVICTABLE flag.
 
 For address spaces that are so marked after being populated (as SHM regions
 might be), the lock action (eg: SHM_LOCK) can be lazy, and need not populate
@@ -202,7 +181,7 @@ flag, PG_mlocked (as wrapped by PageMlocked()), which is set when a page is
 faulted into a VM_LOCKED vma, or found in a vma being VM_LOCKED.
 
 
-VMSCAN'S HANDLING OF UNEVICTABLE PAGES
+Vmscan's Handling of Unevictable Pages
 --------------------------------------
 
 If unevictable pages are culled in the fault path, or moved to the unevictable
@@ -233,8 +212,7 @@ extra evictabilty checks should not occur in the majority of calls to
 putback_lru_page().
 
 
-=============
-MLOCKED PAGES
+MLOCKED Pages
 =============
 
 The unevictable page list is also useful for mlock(), in addition to ramfs and
@@ -242,7 +220,7 @@ SYSV SHM.  Note that mlock() is only available in CONFIG_MMU=y situations; in
 NOMMU situations, all mappings are effectively mlocked.
 
 
-HISTORY
+History
 -------
 
 The "Unevictable mlocked Pages" infrastructure is based on work originally
@@ -263,7 +241,7 @@ replaced by walking the reverse map to determine whether any VM_LOCKED VMAs
 mapped the page.  More on this below.
 
 
-BASIC MANAGEMENT
+Basic Management
 ----------------
 
 mlocked pages - pages mapped into a VM_LOCKED VMA - are a class of unevictable
@@ -304,10 +282,10 @@ mlocked pages become unlocked and rescued from the unevictable list when:
  (4) before a page is COW'd in a VM_LOCKED VMA.
 
 
-mlock()/mlockall() SYSTEM CALL HANDLING
+mlock()/mlockall() System Call Handling
 ---------------------------------------
 
-Both [do_]mlock() and [do_]mlockall() system call handlers call mlock_fixup()
+Both [do\_]mlock() and [do\_]mlockall() system call handlers call mlock_fixup()
 for each VMA in the range specified by the call.  In the case of mlockall(),
 this is the entire active address space of the task.  Note that mlock_fixup()
 is used for both mlocking and munlocking a range of memory.  A call to mlock()
@@ -351,7 +329,7 @@ mlock_vma_page() is unable to isolate the page from the LRU, vmscan will handle
 it later if and when it attempts to reclaim the page.
 
 
-FILTERING SPECIAL VMAS
+Filtering Special VMAs
 ----------------------
 
 mlock_fixup() filters several classes of "special" VMAs:
@@ -379,8 +357,9 @@ VM_LOCKED flag.  Therefore, we won't have to deal with them later during
 munlock(), munmap() or task exit.  Neither does mlock_fixup() account these
 VMAs against the task's "locked_vm".
 
+.. _munlock_munlockall_handling:
 
-munlock()/munlockall() SYSTEM CALL HANDLING
+munlock()/munlockall() System Call Handling
 -------------------------------------------
 
 The munlock() and munlockall() system calls are handled by the same functions -
@@ -426,7 +405,7 @@ This is fine, because we'll catch it later if and if vmscan tries to reclaim
 the page.  This should be relatively rare.
 
 
-MIGRATING MLOCKED PAGES
+Migrating MLOCKED Pages
 -----------------------
 
 A page that is being migrated has been isolated from the LRU lists and is held
@@ -451,7 +430,7 @@ list because of a race between munlock and migration, page migration uses the
 putback_lru_page() function to add migrated pages back to the LRU.
 
 
-COMPACTING MLOCKED PAGES
+Compacting MLOCKED Pages
 ------------------------
 
 The unevictable LRU can be scanned for compactable regions and the default
@@ -461,7 +440,7 @@ unevictable LRU is enabled, the work of compaction is mostly handled by
 the page migration code and the same work flow as described in MIGRATING
 MLOCKED PAGES will apply.
 
-MLOCKING TRANSPARENT HUGE PAGES
+MLOCKING Transparent Huge Pages
 -------------------------------
 
 A transparent huge page is represented by a single entry on an LRU list.
@@ -483,7 +462,7 @@ to unevictable LRU and the rest can be reclaimed.
 
 See also comment in follow_trans_huge_pmd().
 
-mmap(MAP_LOCKED) SYSTEM CALL HANDLING
+mmap(MAP_LOCKED) System Call Handling
 -------------------------------------
 
 In addition the mlock()/mlockall() system calls, an application can request
@@ -514,7 +493,7 @@ memory range accounted as locked_vm, as the protections could be changed later
 and pages allocated into that region.
 
 
-munmap()/exit()/exec() SYSTEM CALL HANDLING
+munmap()/exit()/exec() System Call Handling
 -------------------------------------------
 
 When unmapping an mlocked region of memory, whether by an explicit call to
@@ -568,16 +547,18 @@ munlock or munmap system calls, mm teardown (munlock_vma_pages_all), reclaim,
 holepunching, and truncation of file pages and their anonymous COWed pages.
 
 
-try_to_munlock() REVERSE MAP SCAN
+try_to_munlock() Reverse Map Scan
 ---------------------------------
 
- [!] TODO/FIXME: a better name might be page_mlocked() - analogous to the
-     page_referenced() reverse map walker.
+.. warning::
+   [!] TODO/FIXME: a better name might be page_mlocked() - analogous to the
+   page_referenced() reverse map walker.
 
-When munlock_vma_page() [see section "munlock()/munlockall() System Call
-Handling" above] tries to munlock a page, it needs to determine whether or not
-the page is mapped by any VM_LOCKED VMA without actually attempting to unmap
-all PTEs from the page.  For this purpose, the unevictable/mlock infrastructure
+When munlock_vma_page() [see section :ref:`munlock()/munlockall() System Call
+Handling <munlock_munlockall_handling>` above] tries to munlock a
+page, it needs to determine whether or not the page is mapped by any
+VM_LOCKED VMA without actually attempting to unmap all PTEs from the
+page.  For this purpose, the unevictable/mlock infrastructure
 introduced a variant of try_to_unmap() called try_to_munlock().
 
 try_to_munlock() calls the same functions as try_to_unmap() for anonymous and
@@ -595,7 +576,7 @@ large region or tearing down a large address space that has been mlocked via
 mlockall(), overall this is a fairly rare event.
 
 
-PAGE RECLAIM IN shrink_*_list()
+Page Reclaim in shrink_*_list()
 -------------------------------
 
 shrink_active_list() culls any obviously unevictable pages - i.e.
-- 
2.7.4
