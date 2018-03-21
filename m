Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753632AbeCUTZ6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:25:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753576AbeCUTZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:25:30 -0400
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
Subject: [PATCH 32/32] docs/vm: add index.rst and link MM documentation to top level index
Date: Wed, 21 Mar 2018 21:22:48 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0008-0000-0000-000004E0DF88
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0009-0000-0000-00001E7403FC
Message-Id: <1521660168-14372-33-git-send-email-rppt@linux.vnet.ibm.com>
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
 Documentation/index.rst    |  3 ++-
 Documentation/vm/conf.py   | 10 +++++++++
 Documentation/vm/index.rst | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/vm/conf.py
 create mode 100644 Documentation/vm/index.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index ef5080c..cc4a098 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -45,7 +45,7 @@ the kernel interface as seen by application developers.
 .. toctree::
    :maxdepth: 2
 
-   userspace-api/index	      
+   userspace-api/index
 
 
 Introduction to kernel development
@@ -88,6 +88,7 @@ needed).
    sound/index
    crypto/index
    filesystems/index
+   vm/index
 
 Architecture-specific documentation
 -----------------------------------
diff --git a/Documentation/vm/conf.py b/Documentation/vm/conf.py
new file mode 100644
index 0000000..3b0b601
--- /dev/null
+++ b/Documentation/vm/conf.py
@@ -0,0 +1,10 @@
+# -*- coding: utf-8; mode: python -*-
+
+project = "Linux Memory Management Documentation"
+
+tags.add("subproject")
+
+latex_documents = [
+    ('index', 'memory-management.tex', project,
+     'The kernel development community', 'manual'),
+]
diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
new file mode 100644
index 0000000..6c45142
--- /dev/null
+++ b/Documentation/vm/index.rst
@@ -0,0 +1,56 @@
+=====================================
+Linux Memory Management Documentation
+=====================================
+
+This is a collection of documents about Linux memory management (mm) subsystem.
+
+User guides for MM features
+===========================
+
+The following documents provide guides for controlling and tuning
+various features of the Linux memory management
+
+.. toctree::
+   :maxdepth: 1
+
+   hugetlbpage
+   idle_page_tracking
+   ksm
+   numa_memory_policy
+   pagemap
+   transhuge
+   soft-dirty
+   swap_numa
+   userfaultfd
+   zswap
+
+Kernel developers MM documentation
+==================================
+
+The below documents describe MM internals with different level of
+details ranging from notes and mailing list responses to elaborate
+descriptions of data structures and algorithms.
+
+.. toctree::
+   :maxdepth: 1
+
+   active_mm
+   balance
+   cleancache
+   frontswap
+   highmem
+   hmm
+   hwpoison
+   hugetlbfs_reserv
+   mmu_notifier
+   numa
+   overcommit-accounting
+   page_migration
+   page_frags
+   page_owner
+   remap_file_pages
+   slub
+   split_page_table_lock
+   unevictable-lru
+   z3fold
+   zsmalloc
-- 
2.7.4
