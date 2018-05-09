Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934092AbeEIIYI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:24:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:45755 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933811AbeEIIYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:24:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="47858160"
From: "Huang, Ying" <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH -mm] mm, THP, doc: Add document for thp_swpout/thp_swpout_fallback
Date: Wed,  9 May 2018 16:23:41 +0800
Message-Id: <20180509082341.13953-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

Add document for newly added thp_swpout, thp_swpout_fallback fields in
/proc/vmstat.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/vm/transhuge.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/vm/transhuge.rst b/Documentation/vm/transhuge.rst
index 569d182cc973..2c6867fca6ff 100644
--- a/Documentation/vm/transhuge.rst
+++ b/Documentation/vm/transhuge.rst
@@ -355,6 +355,15 @@ thp_zero_page_alloc_failed
 	is incremented if kernel fails to allocate
 	huge zero page and falls back to using small pages.
 
+thp_swpout
+	is incremented every time a huge page is swapout in one
+	piece without splitting.
+
+thp_swpout_fallback
+	is incremented if a huge page has to be split before swapout.
+	Usually because failed to allocate some continuous swap space
+	for the huge page.
+
 As the system ages, allocating huge pages may be expensive as the
 system uses memory compaction to copy data around memory to free a
 huge page for use. There are some counters in ``/proc/vmstat`` to help
-- 
2.16.1
