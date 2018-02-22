Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753039AbeBVJLu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 04:11:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753017AbeBVJLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 04:11:46 -0500
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, dave.hansen@intel.com
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com, tglx@linutronix.de,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 1/3] mm/sparse: Add a static variable nr_present_sections
Date: Thu, 22 Feb 2018 17:11:28 +0800
Message-Id: <20180222091130.32165-2-bhe@redhat.com>
In-Reply-To: <20180222091130.32165-1-bhe@redhat.com>
References: <20180222091130.32165-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's used to record how many memory sections are marked as present
during system boot up, and will be used in the later patch.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/sparse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/sparse.c b/mm/sparse.c
index 7af5e7a92528..433d3c9b4b56 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -202,6 +202,7 @@ static inline int next_present_section_nr(int section_nr)
 	      (section_nr <= __highest_present_section_nr));	\
 	     section_nr = next_present_section_nr(section_nr))
 
+static int nr_present_sections;
 /* Record a memory area against a node. */
 void __init memory_present(int nid, unsigned long start, unsigned long end)
 {
@@ -231,6 +232,7 @@ void __init memory_present(int nid, unsigned long start, unsigned long end)
 			ms->section_mem_map = sparse_encode_early_nid(nid) |
 							SECTION_IS_ONLINE;
 			section_mark_present(ms);
+			nr_present_sections++;
 		}
 	}
 }
-- 
2.13.6
