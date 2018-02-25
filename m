Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeBYTAe (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 14:00:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751853AbeBYTAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 14:00:11 -0500
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, linux-doc <linux-doc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 3/3] mm: kernel-doc: add missing parameter descriptions
Date: Sun, 25 Feb 2018 20:59:51 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519585191-10180-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1519585191-10180-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022519-0040-0000-0000-0000041695CF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022519-0041-0000-0000-00002619B46B
Message-Id: <1519585191-10180-4-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802250253
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 mm/cma.c            |  5 +++++
 mm/compaction.c     |  1 +
 mm/kmemleak.c       | 10 ++++++++++
 mm/memory_hotplug.c |  6 ++++++
 mm/oom_kill.c       |  2 ++
 mm/pagewalk.c       |  3 +++
 mm/rmap.c           |  1 +
 mm/zsmalloc.c       |  2 ++
 8 files changed, 30 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index 0607729abf3b..0600fc08a9f4 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -165,6 +165,9 @@ core_initcall(cma_init_reserved_areas);
  * @base: Base address of the reserved area
  * @size: Size of the reserved area (in bytes),
  * @order_per_bit: Order of pages represented by one bit on bitmap.
+ * @name: The name of the area. If this parameter is NULL, the name of
+ *        the area will be set to "cmaN", where N is a running counter of
+ *        used areas.
  * @res_cma: Pointer to store the created cma region.
  *
  * This function creates custom contiguous area from already reserved memory.
@@ -227,6 +230,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
  * @alignment: Alignment for the CMA area, should be power of 2 or zero
  * @order_per_bit: Order of pages represented by one bit on bitmap.
  * @fixed: hint about where to place the reserved area
+ * @name: The name of the area. See function cma_init_reserved_mem()
  * @res_cma: Pointer to store the created cma region.
  *
  * This function reserves memory from early allocator. It should be
@@ -390,6 +394,7 @@ static inline void cma_debug_show_areas(struct cma *cma) { }
  * @cma:   Contiguous memory region for which the allocation is performed.
  * @count: Requested number of pages.
  * @align: Requested alignment of pages (in PAGE_SIZE order).
+ * @gfp_mask:  GFP mask to use during compaction
  *
  * This function allocates part of contiguous memory on specific
  * contiguous memory area.
diff --git a/mm/compaction.c b/mm/compaction.c
index 2c8999d027ab..40966f88c39d 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -576,6 +576,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 
 /**
  * isolate_freepages_range() - isolate free pages.
+ * @cc:        Compaction control structure.
  * @start_pfn: The first PFN to start isolating.
  * @end_pfn:   The one-past-last PFN.
  *
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index e83987c55a08..7e73961dcf89 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1187,6 +1187,11 @@ EXPORT_SYMBOL(kmemleak_no_scan);
 /**
  * kmemleak_alloc_phys - similar to kmemleak_alloc but taking a physical
  *			 address argument
+ * @phys:	physical address of the object
+ * @size:	size of the object
+ * @min_count:	minimum number of references to this object.
+ *              See kmemleak_alloc()
+ * @gfp:	kmalloc() flags used for kmemleak internal memory allocations
  */
 void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
 			       gfp_t gfp)
@@ -1199,6 +1204,9 @@ EXPORT_SYMBOL(kmemleak_alloc_phys);
 /**
  * kmemleak_free_part_phys - similar to kmemleak_free_part but taking a
  *			     physical address argument
+ * @phys:	physical address if the beginning or inside an object. This
+ *		also represents the start of the range to be freed
+ * @size:	size to be unregistered
  */
 void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
 {
@@ -1210,6 +1218,7 @@ EXPORT_SYMBOL(kmemleak_free_part_phys);
 /**
  * kmemleak_not_leak_phys - similar to kmemleak_not_leak but taking a physical
  *			    address argument
+ * @phys:	physical address of the object
  */
 void __ref kmemleak_not_leak_phys(phys_addr_t phys)
 {
@@ -1221,6 +1230,7 @@ EXPORT_SYMBOL(kmemleak_not_leak_phys);
 /**
  * kmemleak_ignore_phys - similar to kmemleak_ignore but taking a physical
  *			  address argument
+ * @phys:	physical address of the object
  */
 void __ref kmemleak_ignore_phys(phys_addr_t phys)
 {
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b2bd52ff7605..e84d626d7b89 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -559,6 +559,7 @@ static int __remove_section(struct zone *zone, struct mem_section *ms,
  * @zone: zone from which pages need to be removed
  * @phys_start_pfn: starting pageframe (must be aligned to start of a section)
  * @nr_pages: number of pages to remove (must be multiple of section size)
+ * @altmap: alternative device page map or %NULL if default memmap is used
  *
  * Generic helper function to remove section mappings and sysfs entries
  * for the section of the memory we are removing. Caller needs to make
@@ -1055,6 +1056,7 @@ static void rollback_node_hotadd(int nid, pg_data_t *pgdat)
 
 /**
  * try_online_node - online a node if offlined
+ * @nid: the node ID
  *
  * called by cpu_up() to online a node without onlined memory.
  */
@@ -1814,6 +1816,7 @@ static int check_and_unmap_cpu_on_node(pg_data_t *pgdat)
 
 /**
  * try_offline_node
+ * @nid: the node ID
  *
  * Offline a node if all memory sections and cpus of the node are removed.
  *
@@ -1857,6 +1860,9 @@ EXPORT_SYMBOL(try_offline_node);
 
 /**
  * remove_memory
+ * @nid: the node ID
+ * @start: physical address of the region to remove
+ * @size: size of the region to remove
  *
  * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
  * and online/offline operations before this call, as required by
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index f2e7dfb81eee..82a92ad67af3 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -185,6 +185,8 @@ static bool is_dump_unreclaim_slabs(void)
  * oom_badness - heuristic function to determine which candidate task to kill
  * @p: task struct of which task we should calculate
  * @totalpages: total present RAM allowed for page allocation
+ * @memcg: task's memory controller, if constrained
+ * @nodemask: nodemask passed to page allocator for mempolicy ooms
  *
  * The heuristic for determining which task to kill is made to be as simple and
  * predictable as possible.  The goal is to return the highest value for the
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 8d2da5dec1e0..c3084ff2569d 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -258,6 +258,9 @@ static int __walk_page_range(unsigned long start, unsigned long end,
 
 /**
  * walk_page_range - walk page table with caller specific callbacks
+ * @start: start address of the virtual address range
+ * @end: end address of the virtual address range
+ * @walk: mm_walk structure defining the callbacks and the target address space
  *
  * Recursively walk the page table tree of the process represented by @walk->mm
  * within the virtual address range [@start, @end). During walking, we can do
diff --git a/mm/rmap.c b/mm/rmap.c
index 47db27f8049e..9eaa6354fe70 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1171,6 +1171,7 @@ void page_add_new_anon_rmap(struct page *page,
 /**
  * page_add_file_rmap - add pte mapping to a file page
  * @page: the page to add the mapping to
+ * @compound: charge the page as compound or small page
  *
  * The caller needs to hold the pte lock.
  */
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c3013505c305..52c3b0230bc4 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -860,6 +860,7 @@ static struct page *get_next_page(struct page *page)
 
 /**
  * obj_to_location - get (<page>, <obj_idx>) from encoded object value
+ * @obj: the encoded object value
  * @page: page object resides in zspage
  * @obj_idx: object index
  */
@@ -1310,6 +1311,7 @@ EXPORT_SYMBOL_GPL(zs_get_total_pages);
  * zs_map_object - get address of allocated object from handle.
  * @pool: pool from which the object was allocated
  * @handle: handle returned from zs_malloc
+ * @mm: maping mode to use
  *
  * Before using an object allocated from zs_malloc, it must be mapped using
  * this function. When done with the object, it must be unmapped using
-- 
2.7.4
