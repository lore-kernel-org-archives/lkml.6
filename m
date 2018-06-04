Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeFDMXI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:23:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750868AbeFDMXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:23:07 -0400
Date: Mon, 4 Jun 2018 15:22:35 +0300
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/admin-guide/mm: add high level concepts overview
References: <20180529113725.GB13092@rapoport-lnx>
 <285dd950-0b25-dba3-60b6-ceac6075fb48@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <285dd950-0b25-dba3-60b6-ceac6075fb48@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18060412-0028-0000-0000-000002CC7EC9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060412-0029-0000-0000-000023830475
Message-Id: <20180604122235.GB15196@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040149
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Thanks for the review! I always have trouble with articles :)
The patch below addresses most of your comments.

On Fri, Jun 01, 2018 at 05:09:38PM -0700, Randy Dunlap wrote:
> On 05/29/2018 04:37 AM, Mike Rapoport wrote:
> > Hi,
> > 
> > From 2d3ec7ea101a66b1535d5bec4acfc1e0f737fd53 Mon Sep 17 00:00:00 2001
> > From: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Date: Tue, 29 May 2018 14:12:39 +0300
> > Subject: [PATCH] docs/admin-guide/mm: add high level concepts overview
> > 
> > The are terms that seem obvious to the mm developers, but may be somewhat

Huh, I afraid it's to late to change the commit message :(
 
>   There are [or: These are]
> 
> > obscure for, say, less involved readers.
> > 
> > The concepts overview can be seen as an "extended glossary" that introduces
> > such terms to the readers of the kernel documentation.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > ---
> >  Documentation/admin-guide/mm/concepts.rst | 222 ++++++++++++++++++++++++++++++
> >  Documentation/admin-guide/mm/index.rst    |   5 +
> >  2 files changed, 227 insertions(+)
> >  create mode 100644 Documentation/admin-guide/mm/concepts.rst
> > 
> > diff --git a/Documentation/admin-guide/mm/concepts.rst b/Documentation/admin-guide/mm/concepts.rst
> > new file mode 100644
> > index 0000000..291699c
> > --- /dev/null
> > +++ b/Documentation/admin-guide/mm/concepts.rst

[...]

> > +All this makes dealing directly with physical memory quite complex and
> > +to avoid this complexity a concept of virtual memory was developed.
> > +
> > +The virtual memory abstracts the details of physical memory from the
> 
>        virtual memory {system, implementation} abstracts
> 
> > +application software, allows to keep only needed information in the
> 
>                software, allowing the VM to keep only needed information in the
> 
> > +physical memory (demand paging) and provides a mechanism for the
> > +protection and controlled sharing of data between processes.
> > +

My intention was "virtual memory concept allows ... and provides ..."
I didn't want to repeat "concept", to I've just omitted it.

Somehow, I don't feel that "system" or "implementation" fit here...

> 
> -- 
> ~Randy
> 

-- 
Sincerely yours,
Mike.

>From 60e74f6ef29789f22555c4fdbbb85215e506f6d0 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Mon, 4 Jun 2018 15:09:54 +0300
Subject: [PATCH] docs/admin-guide/mm/concepts.rst: grammar fixups

The patch is mostly about adding 'a' and 'the' and updating indentation.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/admin-guide/mm/concepts.rst | 39 ++++++++++++++++---------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/mm/concepts.rst b/Documentation/admin-guide/mm/concepts.rst
index 291699c..ab7a0f9 100644
--- a/Documentation/admin-guide/mm/concepts.rst
+++ b/Documentation/admin-guide/mm/concepts.rst
@@ -4,13 +4,13 @@
 Concepts overview
 =================
 
-The memory management in Linux is complex system that evolved over the
-years and included more and more functionality to support variety of
+The memory management in Linux is a complex system that evolved over the
+years and included more and more functionality to support a variety of
 systems from MMU-less microcontrollers to supercomputers. The memory
-management for systems without MMU is called ``nommu`` and it
+management for systems without an MMU is called ``nommu`` and it
 definitely deserves a dedicated document, which hopefully will be
 eventually written. Yet, although some of the concepts are the same,
-here we assume that MMU is available and CPU can translate a virtual
+here we assume that an MMU is available and a CPU can translate a virtual
 address to a physical address.
 
 .. contents:: :local:
@@ -21,10 +21,10 @@ Virtual Memory Primer
 The physical memory in a computer system is a limited resource and
 even for systems that support memory hotplug there is a hard limit on
 the amount of memory that can be installed. The physical memory is not
-necessary contiguous, it might be accessible as a set of distinct
+necessary contiguous; it might be accessible as a set of distinct
 address ranges. Besides, different CPU architectures, and even
-different implementations of the same architecture have different view
-how these address ranges defined.
+different implementations of the same architecture have different views
+of how these address ranges defined.
 
 All this makes dealing directly with physical memory quite complex and
 to avoid this complexity a concept of virtual memory was developed.
@@ -48,8 +48,9 @@ appropriate kernel configuration option.
 
 Each physical memory page can be mapped as one or more virtual
 pages. These mappings are described by page tables that allow
-translation from virtual address used by programs to real address in
-the physical memory. The page tables organized hierarchically.
+translation from a virtual address used by programs to the real
+address in the physical memory. The page tables are organized
+hierarchically.
 
 The tables at the lowest level of the hierarchy contain physical
 addresses of actual pages used by the software. The tables at higher
@@ -121,8 +122,8 @@ Nodes
 Many multi-processor machines are NUMA - Non-Uniform Memory Access -
 systems. In such systems the memory is arranged into banks that have
 different access latency depending on the "distance" from the
-processor. Each bank is referred as `node` and for each node Linux
-constructs an independent memory management subsystem. A node has it's
+processor. Each bank is referred as a `node` and for each node Linux
+constructs an independent memory management subsystem. A node has its
 own set of zones, lists of free and used pages and various statistics
 counters. You can find more details about NUMA in
 :ref:`Documentation/vm/numa.rst <numa>` and in
@@ -149,7 +150,7 @@ for program's stack and heap or by explicit calls to mmap(2) system
 call. Usually, the anonymous mappings only define virtual memory areas
 that the program is allowed to access. The read accesses will result
 in creation of a page table entry that references a special physical
-page filled with zeroes. When the program performs a write, regular
+page filled with zeroes. When the program performs a write, a regular
 physical page will be allocated to hold the written data. The page
 will be marked dirty and if the kernel will decide to repurpose it,
 the dirty page will be swapped out.
@@ -181,8 +182,8 @@ pressure.
 The process of freeing the reclaimable physical memory pages and
 repurposing them is called (surprise!) `reclaim`. Linux can reclaim
 pages either asynchronously or synchronously, depending on the state
-of the system. When system is not loaded, most of the memory is free
-and allocation request will be satisfied immediately from the free
+of the system. When the system is not loaded, most of the memory is free
+and allocation requests will be satisfied immediately from the free
 pages supply. As the load increases, the amount of the free pages goes
 down and when it reaches a certain threshold (high watermark), an
 allocation request will awaken the ``kswapd`` daemon. It will
@@ -190,7 +191,7 @@ asynchronously scan memory pages and either just free them if the data
 they contain is available elsewhere, or evict to the backing storage
 device (remember those dirty pages?). As memory usage increases even
 more and reaches another threshold - min watermark - an allocation
-will trigger the `direct reclaim`. In this case allocation is stalled
+will trigger `direct reclaim`. In this case allocation is stalled
 until enough memory pages are reclaimed to satisfy the request.
 
 Compaction
@@ -200,7 +201,7 @@ As the system runs, tasks allocate and free the memory and it becomes
 fragmented. Although with virtual memory it is possible to present
 scattered physical pages as virtually contiguous range, sometimes it is
 necessary to allocate large physically contiguous memory areas. Such
-need may arise, for instance, when a device driver requires large
+need may arise, for instance, when a device driver requires a large
 buffer for DMA, or when THP allocates a huge page. Memory `compaction`
 addresses the fragmentation issue. This mechanism moves occupied pages
 from the lower part of a memory zone to free pages in the upper part
@@ -208,13 +209,13 @@ of the zone. When a compaction scan is finished free pages are grouped
 together at the beginning of the zone and allocations of large
 physically contiguous areas become possible.
 
-Like reclaim, the compaction may happen asynchronously in ``kcompactd``
-daemon or synchronously as a result of memory allocation request.
+Like reclaim, the compaction may happen asynchronously in the ``kcompactd``
+daemon or synchronously as a result of a memory allocation request.
 
 OOM killer
 ==========
 
-It may happen, that on a loaded machine memory will be exhausted. When
+It may happen that on a loaded machine memory will be exhausted. When
 the kernel detects that the system runs out of memory (OOM) it invokes
 `OOM killer`. Its mission is simple: all it has to do is to select a
 task to sacrifice for the sake of the overall system health. The
-- 
2.7.4
