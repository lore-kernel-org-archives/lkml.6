Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeDRIIO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:08:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753114AbeDRIIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:08:04 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 1/7] docs/vm: hugetlbpage: minor improvements
Date: Wed, 18 Apr 2018 11:07:44 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524038870-413-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1524038870-413-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041808-0012-0000-0000-000005CC1E1E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041808-0013-0000-0000-000019486DAA
Message-Id: <1524038870-413-2-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180076
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* fixed mistypes
* added internal cross-references for sections

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/vm/hugetlbpage.rst | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/vm/hugetlbpage.rst b/Documentation/vm/hugetlbpage.rst
index a5da14b..99ad5d9 100644
--- a/Documentation/vm/hugetlbpage.rst
+++ b/Documentation/vm/hugetlbpage.rst
@@ -87,7 +87,7 @@ memory pressure.
 Once a number of huge pages have been pre-allocated to the kernel huge page
 pool, a user with appropriate privilege can use either the mmap system call
 or shared memory system calls to use the huge pages.  See the discussion of
-Using Huge Pages, below.
+:ref:`Using Huge Pages <using_huge_pages>`, below.
 
 The administrator can allocate persistent huge pages on the kernel boot
 command line by specifying the "hugepages=N" parameter, where 'N' = the
@@ -115,8 +115,9 @@ over all the set of allowed nodes specified by the NUMA memory policy of the
 task that modifies ``nr_hugepages``. The default for the allowed nodes--when the
 task has default memory policy--is all on-line nodes with memory.  Allowed
 nodes with insufficient available, contiguous memory for a huge page will be
-silently skipped when allocating persistent huge pages.  See the discussion
-below of the interaction of task memory policy, cpusets and per node attributes
+silently skipped when allocating persistent huge pages.  See the
+:ref:`discussion below <mem_policy_and_hp_alloc>`
+of the interaction of task memory policy, cpusets and per node attributes
 with the allocation and freeing of persistent huge pages.
 
 The success or failure of huge page allocation depends on the amount of
@@ -158,7 +159,7 @@ normal page pool.
 Caveat: Shrinking the persistent huge page pool via ``nr_hugepages`` such that
 it becomes less than the number of huge pages in use will convert the balance
 of the in-use huge pages to surplus huge pages.  This will occur even if
-the number of surplus pages it would exceed the overcommit value.  As long as
+the number of surplus pages would exceed the overcommit value.  As long as
 this condition holds--that is, until ``nr_hugepages+nr_overcommit_hugepages`` is
 increased sufficiently, or the surplus huge pages go out of use and are freed--
 no more surplus huge pages will be allowed to be allocated.
@@ -187,6 +188,7 @@ Inside each of these directories, the same set of files will exist::
 
 which function as described above for the default huge page-sized case.
 
+.. _mem_policy_and_hp_alloc:
 
 Interaction of Task Memory Policy with Huge Page Allocation/Freeing
 ===================================================================
@@ -282,6 +284,7 @@ Note that the number of overcommit and reserve pages remain global quantities,
 as we don't know until fault time, when the faulting task's mempolicy is
 applied, from which node the huge page allocation will be attempted.
 
+.. _using_huge_pages:
 
 Using Huge Pages
 ================
@@ -295,7 +298,7 @@ type hugetlbfs::
 	min_size=<value>,nr_inodes=<value> none /mnt/huge
 
 This command mounts a (pseudo) filesystem of type hugetlbfs on the directory
-``/mnt/huge``.  Any files created on ``/mnt/huge`` uses huge pages.
+``/mnt/huge``.  Any file created on ``/mnt/huge`` uses huge pages.
 
 The ``uid`` and ``gid`` options sets the owner and group of the root of the
 file system.  By default the ``uid`` and ``gid`` of the current process
@@ -345,8 +348,8 @@ applications are going to use only shmat/shmget system calls or mmap with
 MAP_HUGETLB.  For an example of how to use mmap with MAP_HUGETLB see
 :ref:`map_hugetlb <map_hugetlb>` below.
 
-Users who wish to use hugetlb memory via shared memory segment should be a
-member of a supplementary group and system admin needs to configure that gid
+Users who wish to use hugetlb memory via shared memory segment should be
+members of a supplementary group and system admin needs to configure that gid
 into ``/proc/sys/vm/hugetlb_shm_group``.  It is possible for same or different
 applications to use any combination of mmaps and shm* calls, though the mount of
 filesystem will be required for using mmap calls without MAP_HUGETLB.
-- 
2.7.4
