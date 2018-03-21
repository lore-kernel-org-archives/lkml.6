Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753668AbeCUT0e (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:26:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753524AbeCUTZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:25:21 -0400
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
Subject: [PATCH 30/32] docs/vm: zswap.txt: convert to ReST format
Date: Wed, 21 Mar 2018 21:22:46 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18032119-0044-0000-0000-0000053E735A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0045-0000-0000-0000287D78FE
Message-Id: <1521660168-14372-31-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210221
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/vm/zswap.txt | 71 +++++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/Documentation/vm/zswap.txt b/Documentation/vm/zswap.txt
index 0b3a114..1444ecd 100644
--- a/Documentation/vm/zswap.txt
+++ b/Documentation/vm/zswap.txt
@@ -1,4 +1,11 @@
-Overview:
+.. _zswap:
+
+=====
+zswap
+=====
+
+Overview
+========
 
 Zswap is a lightweight compressed cache for swap pages. It takes pages that are
 in the process of being swapped out and attempts to compress them into a
@@ -7,32 +14,34 @@ for potentially reduced swap I/O.  This trade-off can also result in a
 significant performance improvement if reads from the compressed cache are
 faster than reads from a swap device.
 
-NOTE: Zswap is a new feature as of v3.11 and interacts heavily with memory
-reclaim.  This interaction has not been fully explored on the large set of
-potential configurations and workloads that exist.  For this reason, zswap
-is a work in progress and should be considered experimental.
+.. note::
+   Zswap is a new feature as of v3.11 and interacts heavily with memory
+   reclaim.  This interaction has not been fully explored on the large set of
+   potential configurations and workloads that exist.  For this reason, zswap
+   is a work in progress and should be considered experimental.
+
+   Some potential benefits:
 
-Some potential benefits:
 * Desktop/laptop users with limited RAM capacities can mitigate the
-    performance impact of swapping.
+  performance impact of swapping.
 * Overcommitted guests that share a common I/O resource can
-    dramatically reduce their swap I/O pressure, avoiding heavy handed I/O
-    throttling by the hypervisor. This allows more work to get done with less
-    impact to the guest workload and guests sharing the I/O subsystem
+  dramatically reduce their swap I/O pressure, avoiding heavy handed I/O
+  throttling by the hypervisor. This allows more work to get done with less
+  impact to the guest workload and guests sharing the I/O subsystem
 * Users with SSDs as swap devices can extend the life of the device by
-    drastically reducing life-shortening writes.
+  drastically reducing life-shortening writes.
 
 Zswap evicts pages from compressed cache on an LRU basis to the backing swap
 device when the compressed pool reaches its size limit.  This requirement had
 been identified in prior community discussions.
 
 Zswap is disabled by default but can be enabled at boot time by setting
-the "enabled" attribute to 1 at boot time. ie: zswap.enabled=1.  Zswap
+the ``enabled`` attribute to 1 at boot time. ie: ``zswap.enabled=1``.  Zswap
 can also be enabled and disabled at runtime using the sysfs interface.
 An example command to enable zswap at runtime, assuming sysfs is mounted
-at /sys, is:
+at ``/sys``, is::
 
-echo 1 > /sys/module/zswap/parameters/enabled
+	echo 1 > /sys/module/zswap/parameters/enabled
 
 When zswap is disabled at runtime it will stop storing pages that are
 being swapped out.  However, it will _not_ immediately write out or fault
@@ -43,7 +52,8 @@ pages out of the compressed pool, a swapoff on the swap device(s) will
 fault back into memory all swapped out pages, including those in the
 compressed pool.
 
-Design:
+Design
+======
 
 Zswap receives pages for compression through the Frontswap API and is able to
 evict pages from its own compressed pool on an LRU basis and write them back to
@@ -53,12 +63,12 @@ Zswap makes use of zpool for the managing the compressed memory pool.  Each
 allocation in zpool is not directly accessible by address.  Rather, a handle is
 returned by the allocation routine and that handle must be mapped before being
 accessed.  The compressed memory pool grows on demand and shrinks as compressed
-pages are freed.  The pool is not preallocated.  By default, a zpool of type
-zbud is created, but it can be selected at boot time by setting the "zpool"
-attribute, e.g. zswap.zpool=zbud.  It can also be changed at runtime using the
-sysfs "zpool" attribute, e.g.
+pages are freed.  The pool is not preallocated.  By default, a zpool
+of type zbud is created, but it can be selected at boot time by
+setting the ``zpool`` attribute, e.g. ``zswap.zpool=zbud``. It can
+also be changed at runtime using the sysfs ``zpool`` attribute, e.g.::
 
-echo zbud > /sys/module/zswap/parameters/zpool
+	echo zbud > /sys/module/zswap/parameters/zpool
 
 The zbud type zpool allocates exactly 1 page to store 2 compressed pages, which
 means the compression ratio will always be 2:1 or worse (because of half-full
@@ -83,14 +93,16 @@ via frontswap, to free the compressed entry.
 
 Zswap seeks to be simple in its policies.  Sysfs attributes allow for one user
 controlled policy:
+
 * max_pool_percent - The maximum percentage of memory that the compressed
-    pool can occupy.
+  pool can occupy.
 
-The default compressor is lzo, but it can be selected at boot time by setting
-the “compressor” attribute, e.g. zswap.compressor=lzo.  It can also be changed
-at runtime using the sysfs "compressor" attribute, e.g.
+The default compressor is lzo, but it can be selected at boot time by
+setting the ``compressor`` attribute, e.g. ``zswap.compressor=lzo``.
+It can also be changed at runtime using the sysfs "compressor"
+attribute, e.g.::
 
-echo lzo > /sys/module/zswap/parameters/compressor
+	echo lzo > /sys/module/zswap/parameters/compressor
 
 When the zpool and/or compressor parameter is changed at runtime, any existing
 compressed pages are not modified; they are left in their own zpool.  When a
@@ -106,11 +118,12 @@ compressed length of the page is set to zero and the pattern or same-filled
 value is stored.
 
 Same-value filled pages identification feature is enabled by default and can be
-disabled at boot time by setting the "same_filled_pages_enabled" attribute to 0,
-e.g. zswap.same_filled_pages_enabled=0. It can also be enabled and disabled at
-runtime using the sysfs "same_filled_pages_enabled" attribute, e.g.
+disabled at boot time by setting the ``same_filled_pages_enabled`` attribute
+to 0, e.g. ``zswap.same_filled_pages_enabled=0``. It can also be enabled and
+disabled at runtime using the sysfs ``same_filled_pages_enabled``
+attribute, e.g.::
 
-echo 1 > /sys/module/zswap/parameters/same_filled_pages_enabled
+	echo 1 > /sys/module/zswap/parameters/same_filled_pages_enabled
 
 When zswap same-filled page identification is disabled at runtime, it will stop
 checking for the same-value filled pages during store operation. However, the
-- 
2.7.4
