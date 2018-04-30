Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753228AbeD3Jmz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:42:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753075AbeD3Jmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:42:49 -0400
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH RCFv2 2/7] kdump: include PAGE_OFFLINE_MAPCOUNT_VALUE in ELF info
Date: Mon, 30 Apr 2018 11:42:31 +0200
Message-Id: <20180430094236.29056-3-david@redhat.com>
In-Reply-To: <20180430094236.29056-1-david@redhat.com>
References: <20180430094236.29056-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows dump tools to skip pages that are offline.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/crash_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index f7674d676889..c0a45e9ba84e 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -464,6 +464,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 #ifdef CONFIG_HUGETLB_PAGE
 	VMCOREINFO_NUMBER(HUGETLB_PAGE_DTOR);
 #endif
+	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
 
 	arch_crash_save_vmcoreinfo();
 	update_vmcoreinfo_note();
-- 
2.14.3
