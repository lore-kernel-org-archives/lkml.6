Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754552AbeEHHCd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 03:02:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754490AbeEHHC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 03:02:28 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-doc <linux-doc@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 3/3] docs/vm: move numa_memory_policy.rst to Documentation/admin-guide/mm
Date: Tue,  8 May 2018 10:02:10 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525762930-28163-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1525762930-28163-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050807-0012-0000-0000-000005D3DB21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050807-0013-0000-0000-00001950E952
Message-Id: <1525762930-28163-4-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-08_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805080069
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The document describes userspace API and as such it belongs to
Documentation/admin-guide/mm

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/admin-guide/mm/hugetlbpage.rst                | 2 +-
 Documentation/admin-guide/mm/index.rst                      | 1 +
 Documentation/{vm => admin-guide/mm}/numa_memory_policy.rst | 0
 Documentation/filesystems/proc.txt                          | 2 +-
 Documentation/filesystems/tmpfs.txt                         | 5 +++--
 Documentation/vm/00-INDEX                                   | 2 --
 Documentation/vm/index.rst                                  | 1 -
 Documentation/vm/numa.rst                                   | 2 +-
 8 files changed, 7 insertions(+), 8 deletions(-)
 rename Documentation/{vm => admin-guide/mm}/numa_memory_policy.rst (100%)

diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index a8b0806..1cc0bc7 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -220,7 +220,7 @@ memory policy mode--bind, preferred, local or interleave--may be used.  The
 resulting effect on persistent huge page allocation is as follows:
 
 #. Regardless of mempolicy mode [see
-   :ref:`Documentation/vm/numa_memory_policy.rst <numa_memory_policy>`],
+   :ref:`Documentation/admin-guide/mm/numa_memory_policy.rst <numa_memory_policy>`],
    persistent huge pages will be distributed across the node or nodes
    specified in the mempolicy as if "interleave" had been specified.
    However, if a node in the policy does not contain sufficient contiguous
diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index ad28644..a69aa69 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -24,6 +24,7 @@ the Linux memory management.
    hugetlbpage
    idle_page_tracking
    ksm
+   numa_memory_policy
    pagemap
    soft-dirty
    userfaultfd
diff --git a/Documentation/vm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
similarity index 100%
rename from Documentation/vm/numa_memory_policy.rst
rename to Documentation/admin-guide/mm/numa_memory_policy.rst
diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index ef53f80..520f6a8 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -566,7 +566,7 @@ address   policy    mapping details
 
 Where:
 "address" is the starting address for the mapping;
-"policy" reports the NUMA memory policy set for the mapping (see vm/numa_memory_policy.txt);
+"policy" reports the NUMA memory policy set for the mapping (see Documentation/admin-guide/mm/numa_memory_policy.rst);
 "mapping details" summarizes mapping data such as mapping type, page usage counters,
 node locality page counters (N0 == node0, N1 == node1, ...) and the kernel page
 size, in KB, that is backing the mapping up.
diff --git a/Documentation/filesystems/tmpfs.txt b/Documentation/filesystems/tmpfs.txt
index 627389a..d06e9a5 100644
--- a/Documentation/filesystems/tmpfs.txt
+++ b/Documentation/filesystems/tmpfs.txt
@@ -105,8 +105,9 @@ policy for the file will revert to "default" policy.
 NUMA memory allocation policies have optional flags that can be used in
 conjunction with their modes.  These optional flags can be specified
 when tmpfs is mounted by appending them to the mode before the NodeList.
-See Documentation/vm/numa_memory_policy.rst for a list of all available
-memory allocation policy mode flags and their effect on memory policy.
+See Documentation/admin-guide/mm/numa_memory_policy.rst for a list of
+all available memory allocation policy mode flags and their effect on
+memory policy.
 
 	=static		is equivalent to	MPOL_F_STATIC_NODES
 	=relative	is equivalent to	MPOL_F_RELATIVE_NODES
diff --git a/Documentation/vm/00-INDEX b/Documentation/vm/00-INDEX
index f8a96ca..f4a4f3e 100644
--- a/Documentation/vm/00-INDEX
+++ b/Documentation/vm/00-INDEX
@@ -22,8 +22,6 @@ mmu_notifier.rst
 	- a note about clearing pte/pmd and mmu notifications
 numa.rst
 	- information about NUMA specific code in the Linux vm.
-numa_memory_policy.rst
-	- documentation of concepts and APIs of the 2.6 memory policy support.
 overcommit-accounting.rst
 	- description of the Linux kernels overcommit handling modes.
 page_frags.rst
diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
index ed58cb9..8e1cc66 100644
--- a/Documentation/vm/index.rst
+++ b/Documentation/vm/index.rst
@@ -14,7 +14,6 @@ various features of the Linux memory management
    :maxdepth: 1
 
    ksm
-   numa_memory_policy
    transhuge
    swap_numa
    zswap
diff --git a/Documentation/vm/numa.rst b/Documentation/vm/numa.rst
index aada84b..185d8a5 100644
--- a/Documentation/vm/numa.rst
+++ b/Documentation/vm/numa.rst
@@ -110,7 +110,7 @@ to improve NUMA locality using various CPU affinity command line interfaces,
 such as taskset(1) and numactl(1), and program interfaces such as
 sched_setaffinity(2).  Further, one can modify the kernel's default local
 allocation behavior using Linux NUMA memory policy.
-[see Documentation/vm/numa_memory_policy.rst.]
+[see Documentation/admin-guide/mm/numa_memory_policy.rst.]
 
 System administrators can restrict the CPUs and nodes' memories that a non-
 privileged user can specify in the scheduling or NUMA commands and functions
-- 
2.7.4
