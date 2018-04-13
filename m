Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754535AbeDMNds (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 09:33:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750980AbeDMNdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 09:33:47 -0400
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC 8/8] mm: export more functions used to online/offline memory
Date: Fri, 13 Apr 2018 15:33:42 +0200
Message-Id: <20180413133344.3672-1-david@redhat.com>
In-Reply-To: <20180413131632.1413-1-david@redhat.com>
References: <20180413131632.1413-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel modules that want to control how/when memory is onlined/offlined
need these functions.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index ac14ea772792..3c374d308cf4 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -979,6 +979,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
 	memory_notify(MEM_CANCEL_ONLINE, &arg);
 	return ret;
 }
+EXPORT_SYMBOL(online_pages);
 #endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
 
 static void reset_node_present_pages(pg_data_t *pgdat)
@@ -1296,6 +1297,7 @@ bool is_mem_section_removable(unsigned long start_pfn, unsigned long nr_pages)
 	/* All pageblocks in the memory block are likely to be hot-removable */
 	return true;
 }
+EXPORT_SYMBOL(is_mem_section_removable);
 
 /*
  * Confirm all pages in a range [start, end) belong to the same zone.
@@ -1752,6 +1754,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 {
 	return __offline_pages(start_pfn, start_pfn + nr_pages);
 }
+EXPORT_SYMBOL(offline_pages);
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
 /**
@@ -1802,6 +1805,7 @@ int walk_memory_range(unsigned long start_pfn, unsigned long end_pfn,
 
 	return 0;
 }
+EXPORT_SYMBOL(walk_memory_range);
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
 static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
-- 
2.14.3
