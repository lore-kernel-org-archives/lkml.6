Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbeBQFtV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 00:49:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:1061 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751137AbeBQFtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 00:49:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,523,1511856000";
   d="scan'208";a="20863372"
From: changbin.du@intel.com
To: corbet@lwn.net, rostedt@goodmis.org
Cc: mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 10/17] trace doc: convert trace/events-kmem.txt to rst format
Date: Sat, 17 Feb 2018 13:39:43 +0800
Message-Id: <1518845990-20733-11-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
References: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

This converts the plain text documentation to reStructuredText format and
add it into Sphinx TOC tree. No essential content change.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 .../trace/{events-kmem.txt => events-kmem.rst}     | 50 ++++++++++++++--------
 Documentation/trace/index.rst                      |  1 +
 2 files changed, 32 insertions(+), 19 deletions(-)
 rename Documentation/trace/{events-kmem.txt => events-kmem.rst} (76%)

diff --git a/Documentation/trace/events-kmem.txt b/Documentation/trace/events-kmem.rst
similarity index 76%
rename from Documentation/trace/events-kmem.txt
rename to Documentation/trace/events-kmem.rst
index 1948004..5554841 100644
--- a/Documentation/trace/events-kmem.txt
+++ b/Documentation/trace/events-kmem.rst
@@ -1,22 +1,26 @@
-			Subsystem Trace Points: kmem
+============================
+Subsystem Trace Points: kmem
+============================
 
 The kmem tracing system captures events related to object and page allocation
 within the kernel. Broadly speaking there are five major subheadings.
 
-  o Slab allocation of small objects of unknown type (kmalloc)
-  o Slab allocation of small objects of known type
-  o Page allocation
-  o Per-CPU Allocator Activity
-  o External Fragmentation
+  - Slab allocation of small objects of unknown type (kmalloc)
+  - Slab allocation of small objects of known type
+  - Page allocation
+  - Per-CPU Allocator Activity
+  - External Fragmentation
 
 This document describes what each of the tracepoints is and why they
 might be useful.
 
 1. Slab allocation of small objects of unknown type
 ===================================================
-kmalloc		call_site=%lx ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s
-kmalloc_node	call_site=%lx ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d
-kfree		call_site=%lx ptr=%p
+::
+
+  kmalloc		call_site=%lx ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s
+  kmalloc_node	call_site=%lx ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d
+  kfree		call_site=%lx ptr=%p
 
 Heavy activity for these events may indicate that a specific cache is
 justified, particularly if kmalloc slab pages are getting significantly
@@ -27,9 +31,11 @@ the allocation sites were.
 
 2. Slab allocation of small objects of known type
 =================================================
-kmem_cache_alloc	call_site=%lx ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s
-kmem_cache_alloc_node	call_site=%lx ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d
-kmem_cache_free		call_site=%lx ptr=%p
+::
+
+  kmem_cache_alloc	call_site=%lx ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s
+  kmem_cache_alloc_node	call_site=%lx ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d
+  kmem_cache_free		call_site=%lx ptr=%p
 
 These events are similar in usage to the kmalloc-related events except that
 it is likely easier to pin the event down to a specific cache. At the time
@@ -38,10 +44,12 @@ but the call_site can usually be used to extrapolate that information.
 
 3. Page allocation
 ==================
-mm_page_alloc		  page=%p pfn=%lu order=%d migratetype=%d gfp_flags=%s
-mm_page_alloc_zone_locked page=%p pfn=%lu order=%u migratetype=%d cpu=%d percpu_refill=%d
-mm_page_free		  page=%p pfn=%lu order=%d
-mm_page_free_batched	  page=%p pfn=%lu order=%d cold=%d
+::
+
+  mm_page_alloc		  page=%p pfn=%lu order=%d migratetype=%d gfp_flags=%s
+  mm_page_alloc_zone_locked page=%p pfn=%lu order=%u migratetype=%d cpu=%d percpu_refill=%d
+  mm_page_free		  page=%p pfn=%lu order=%d
+  mm_page_free_batched	  page=%p pfn=%lu order=%d cold=%d
 
 These four events deal with page allocation and freeing. mm_page_alloc is
 a simple indicator of page allocator activity. Pages may be allocated from
@@ -65,8 +73,10 @@ contention on the zone->lru_lock.
 
 4. Per-CPU Allocator Activity
 =============================
-mm_page_alloc_zone_locked	page=%p pfn=%lu order=%u migratetype=%d cpu=%d percpu_refill=%d
-mm_page_pcpu_drain		page=%p pfn=%lu order=%d cpu=%d migratetype=%d
+::
+
+  mm_page_alloc_zone_locked	page=%p pfn=%lu order=%u migratetype=%d cpu=%d percpu_refill=%d
+  mm_page_pcpu_drain		page=%p pfn=%lu order=%d cpu=%d migratetype=%d
 
 In front of the page allocator is a per-cpu page allocator. It exists only
 for order-0 pages, reduces contention on the zone->lock and reduces the
@@ -92,7 +102,9 @@ can be allocated and freed on the same CPU through some algorithm change.
 
 5. External Fragmentation
 =========================
-mm_page_alloc_extfrag		page=%p pfn=%lu alloc_order=%d fallback_order=%d pageblock_order=%d alloc_migratetype=%d fallback_migratetype=%d fragmenting=%d change_ownership=%d
+::
+
+  mm_page_alloc_extfrag		page=%p pfn=%lu alloc_order=%d fallback_order=%d pageblock_order=%d alloc_migratetype=%d fallback_migratetype=%d fragmenting=%d change_ownership=%d
 
 External fragmentation affects whether a high-order allocation will be
 successful or not. For some types of hardware, this is important although
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index b1cb484..95586aa 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -13,3 +13,4 @@ Linux Tracing Technologies
    uprobetracer
    tracepoints
    events
+   events-kmem
-- 
2.7.4
