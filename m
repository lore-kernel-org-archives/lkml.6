Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeEUKQL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 06:16:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751645AbeEUKQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 06:16:08 -0400
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, pagupta@redhat.com
Cc: linux-mm@kvack.org, kirill.shutemov@linux.intel.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 1/4] mm/sparse: Add a static variable nr_present_sections
Date: Mon, 21 May 2018 18:15:52 +0800
Message-Id: <20180521101555.25610-2-bhe@redhat.com>
In-Reply-To: <20180521101555.25610-1-bhe@redhat.com>
References: <20180521101555.25610-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's used to record how many memory sections are marked as present
during system boot up, and will be used in the later patch.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/sparse.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/sparse.c b/mm/sparse.c
index 62eef264a7bd..48cf7b7982e2 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -202,6 +202,12 @@ static inline int next_present_section_nr(int section_nr)
 	      (section_nr <= __highest_present_section_nr));	\
 	     section_nr = next_present_section_nr(section_nr))
 
+/*
+ * Record how many memory sections are marked as present
+ * during system bootup.
+ */
+static int __initdata nr_present_sections;
+
 /* Record a memory area against a node. */
 void __init memory_present(int nid, unsigned long start, unsigned long end)
 {
@@ -231,6 +237,7 @@ void __init memory_present(int nid, unsigned long start, unsigned long end)
 			ms->section_mem_map = sparse_encode_early_nid(nid) |
 							SECTION_IS_ONLINE;
 			section_mark_present(ms);
+			nr_present_sections++;
 		}
 	}
 }
-- 
2.13.6
