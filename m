Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbeCUT2V (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:28:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753470AbeCUTYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:24:47 -0400
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
Subject: [PATCH 23/32] docs/vm: split_page_table_lock: convert to ReST format
Date: Wed, 21 Mar 2018 21:22:39 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0040-0000-0000-00000425821B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0041-0000-0000-00002628877D
Message-Id: <1521660168-14372-24-git-send-email-rppt@linux.vnet.ibm.com>
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
 Documentation/vm/split_page_table_lock | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/vm/split_page_table_lock b/Documentation/vm/split_page_table_lock
index 62842a8..889b00b 100644
--- a/Documentation/vm/split_page_table_lock
+++ b/Documentation/vm/split_page_table_lock
@@ -1,3 +1,6 @@
+.. _split_page_table_lock:
+
+=====================
 Split page table lock
 =====================
 
@@ -11,6 +14,7 @@ access to the table. At the moment we use split lock for PTE and PMD
 tables. Access to higher level tables protected by mm->page_table_lock.
 
 There are helpers to lock/unlock a table and other accessor functions:
+
  - pte_offset_map_lock()
 	maps pte and takes PTE table lock, returns pointer to the taken
 	lock;
@@ -34,12 +38,13 @@ Split page table lock for PMD tables is enabled, if it's enabled for PTE
 tables and the architecture supports it (see below).
 
 Hugetlb and split page table lock
----------------------------------
+=================================
 
 Hugetlb can support several page sizes. We use split lock only for PMD
 level, but not for PUD.
 
 Hugetlb-specific helpers:
+
  - huge_pte_lock()
 	takes pmd split lock for PMD_SIZE page, mm->page_table_lock
 	otherwise;
@@ -47,7 +52,7 @@ Hugetlb-specific helpers:
 	returns pointer to table lock;
 
 Support of split page table lock by an architecture
----------------------------------------------------
+===================================================
 
 There's no need in special enabling of PTE split page table lock:
 everything required is done by pgtable_page_ctor() and pgtable_page_dtor(),
@@ -73,7 +78,7 @@ NOTE: pgtable_page_ctor() and pgtable_pmd_page_ctor() can fail -- it must
 be handled properly.
 
 page->ptl
----------
+=========
 
 page->ptl is used to access split page table lock, where 'page' is struct
 page of page containing the table. It shares storage with page->private
@@ -81,6 +86,7 @@ page of page containing the table. It shares storage with page->private
 
 To avoid increasing size of struct page and have best performance, we use a
 trick:
+
  - if spinlock_t fits into long, we use page->ptr as spinlock, so we
    can avoid indirect access and save a cache line.
  - if size of spinlock_t is bigger then size of long, we use page->ptl as
-- 
2.7.4
