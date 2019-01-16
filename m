Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1417C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CA0206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404505AbfAPNpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:45:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404483AbfAPNpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:45:32 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GDeY6t036397
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:45:31 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q240wd0q5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:45:30 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 16 Jan 2019 13:45:27 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 13:45:16 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GDjFbe20250696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 13:45:15 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9946A405B;
        Wed, 16 Jan 2019 13:45:15 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D4CFA4054;
        Wed, 16 Jan 2019 13:45:11 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.226])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Jan 2019 13:45:11 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 16 Jan 2019 15:45:11 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Petr Mladek <pmladek@suse.com>, Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        devicetree@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org,
        xen-devel@lists.xenproject.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 10/21] memblock: refactor internal allocation functions
Date:   Wed, 16 Jan 2019 15:44:10 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011613-4275-0000-0000-000002FFFEF1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011613-4276-0000-0000-0000380E2044
Message-Id: <1547646261-32535-11-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, memblock has several internal functions with overlapping
functionality. They all call memblock_find_in_range_node() to find free
memory and then reserve the allocated range and mark it with kmemleak.
However, there is difference in the allocation constraints and in fallback
strategies.

The allocations returning physical address first attempt to find free
memory on the specified node within mirrored memory regions, then retry on
the same node without the requirement for memory mirroring and finally fall
back to all available memory.

The allocations returning virtual address start with clamping the allowed
range to memblock.current_limit, attempt to allocate from the specified
node from regions with mirroring and with user defined minimal address. If
such allocation fails, next attempt is done with node restriction lifted.
Next, the allocation is retried with minimal address reset to zero and at
last without the requirement for mirrored regions.

Let's consolidate various fallbacks handling and make them more consistent
for physical and virtual variants. Most of the fallback handling is moved
to memblock_alloc_range_nid() and it now handles node and mirror fallbacks.

The memblock_alloc_internal() uses memblock_alloc_range_nid() to get a
physical address of the allocated range and converts it to virtual address.

The fallback for allocation below the specified minimal address remains in
memblock_alloc_internal() because memblock_alloc_range_nid() is used by CMA
with exact requirement for lower bounds.

The memblock_phys_alloc_nid() function is completely dropped as it is not
used anywhere outside memblock and its only usage can be replaced by a call
to memblock_alloc_range_nid().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/memblock.h |   1 -
 mm/memblock.c            | 173 +++++++++++++++++++++--------------------------
 2 files changed, 78 insertions(+), 96 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 6874fdc..cf4cd9c 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -371,7 +371,6 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
 
 phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t align,
 				      phys_addr_t start, phys_addr_t end);
-phys_addr_t memblock_phys_alloc_nid(phys_addr_t size, phys_addr_t align, int nid);
 phys_addr_t memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid);
 
 static inline phys_addr_t memblock_phys_alloc(phys_addr_t size,
diff --git a/mm/memblock.c b/mm/memblock.c
index 531fa77..739f769 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1312,30 +1312,84 @@ __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
 
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
+/**
+ * memblock_alloc_range_nid - allocate boot memory block
+ * @size: size of memory block to be allocated in bytes
+ * @align: alignment of the region and block's size
+ * @start: the lower bound of the memory region to allocate (phys address)
+ * @end: the upper bound of the memory region to allocate (phys address)
+ * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
+ *
+ * The allocation is performed from memory region limited by
+ * memblock.current_limit if @max_addr == %MEMBLOCK_ALLOC_ACCESSIBLE.
+ *
+ * If the specified node can not hold the requested memory the
+ * allocation falls back to any node in the system
+ *
+ * For systems with memory mirroring, the allocation is attempted first
+ * from the regions with mirroring enabled and then retried from any
+ * memory region.
+ *
+ * In addition, function sets the min_count to 0 using kmemleak_alloc_phys for
+ * allocated boot memory block, so that it is never reported as leaks.
+ *
+ * Return:
+ * Physical address of allocated memory block on success, %0 on failure.
+ */
 static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 					phys_addr_t align, phys_addr_t start,
-					phys_addr_t end, int nid,
-					enum memblock_flags flags)
+					phys_addr_t end, int nid)
 {
+	enum memblock_flags flags = choose_memblock_flags();
 	phys_addr_t found;
 
+	if (WARN_ONCE(nid == MAX_NUMNODES, "Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead\n"))
+		nid = NUMA_NO_NODE;
+
 	if (!align) {
 		/* Can't use WARNs this early in boot on powerpc */
 		dump_stack();
 		align = SMP_CACHE_BYTES;
 	}
 
+	if (end > memblock.current_limit)
+		end = memblock.current_limit;
+
+again:
 	found = memblock_find_in_range_node(size, align, start, end, nid,
 					    flags);
-	if (found && !memblock_reserve(found, size)) {
+	if (found && !memblock_reserve(found, size))
+		goto done;
+
+	if (nid != NUMA_NO_NODE) {
+		found = memblock_find_in_range_node(size, align, start,
+						    end, NUMA_NO_NODE,
+						    flags);
+		if (found && !memblock_reserve(found, size))
+			goto done;
+	}
+
+	if (flags & MEMBLOCK_MIRROR) {
+		flags &= ~MEMBLOCK_MIRROR;
+		pr_warn("Could not allocate %pap bytes of mirrored memory\n",
+			&size);
+		goto again;
+	}
+
+	return 0;
+
+done:
+	/* Skip kmemleak for kasan_init() due to high volume. */
+	if (end != MEMBLOCK_ALLOC_KASAN)
 		/*
-		 * The min_count is set to 0 so that memblock allocations are
-		 * never reported as leaks.
+		 * The min_count is set to 0 so that memblock allocated
+		 * blocks are never reported as leaks. This is because many
+		 * of these blocks are only referred via the physical
+		 * address which is not looked up by kmemleak.
 		 */
 		kmemleak_alloc_phys(found, size, 0, 0);
-		return found;
-	}
-	return 0;
+
+	return found;
 }
 
 phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
@@ -1343,35 +1397,13 @@ phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
 					     phys_addr_t start,
 					     phys_addr_t end)
 {
-	return memblock_alloc_range_nid(size, align, start, end, NUMA_NO_NODE,
-					MEMBLOCK_NONE);
-}
-
-phys_addr_t __init memblock_phys_alloc_nid(phys_addr_t size, phys_addr_t align, int nid)
-{
-	enum memblock_flags flags = choose_memblock_flags();
-	phys_addr_t ret;
-
-again:
-	ret = memblock_alloc_range_nid(size, align, 0,
-				       MEMBLOCK_ALLOC_ACCESSIBLE, nid, flags);
-
-	if (!ret && (flags & MEMBLOCK_MIRROR)) {
-		flags &= ~MEMBLOCK_MIRROR;
-		goto again;
-	}
-	return ret;
+	return memblock_alloc_range_nid(size, align, start, end, NUMA_NO_NODE);
 }
 
 phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid)
 {
-	phys_addr_t res = memblock_phys_alloc_nid(size, align, nid);
-
-	if (res)
-		return res;
-	return memblock_alloc_range_nid(size, align, 0,
-					MEMBLOCK_ALLOC_ACCESSIBLE,
-					NUMA_NO_NODE, MEMBLOCK_NONE);
+	return memblock_alloc_range_nid(size, align, 0, nid,
+					MEMBLOCK_ALLOC_ACCESSIBLE);
 }
 
 /**
@@ -1382,19 +1414,13 @@ phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t ali
  * @max_addr: the upper bound of the memory region to allocate (phys address)
  * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
  *
- * The @min_addr limit is dropped if it can not be satisfied and the allocation
- * will fall back to memory below @min_addr. Also, allocation may fall back
- * to any node in the system if the specified node can not
- * hold the requested memory.
- *
- * The allocation is performed from memory region limited by
- * memblock.current_limit if @max_addr == %MEMBLOCK_ALLOC_ACCESSIBLE.
- *
- * The phys address of allocated boot memory block is converted to virtual and
- * allocated memory is reset to 0.
+ * Allocates memory block using memblock_alloc_range_nid() and
+ * converts the returned physical address to virtual.
  *
- * In addition, function sets the min_count to 0 using kmemleak_alloc for
- * allocated boot memory block, so that it is never reported as leaks.
+ * The @min_addr limit is dropped if it can not be satisfied and the allocation
+ * will fall back to memory below @min_addr. Other constraints, such
+ * as node and mirrored memory will be handled again in
+ * memblock_alloc_range_nid().
  *
  * Return:
  * Virtual address of allocated memory block on success, NULL on failure.
@@ -1405,11 +1431,6 @@ static void * __init memblock_alloc_internal(
 				int nid)
 {
 	phys_addr_t alloc;
-	void *ptr;
-	enum memblock_flags flags = choose_memblock_flags();
-
-	if (WARN_ONCE(nid == MAX_NUMNODES, "Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead\n"))
-		nid = NUMA_NO_NODE;
 
 	/*
 	 * Detect any accidental use of these APIs after slab is ready, as at
@@ -1419,54 +1440,16 @@ static void * __init memblock_alloc_internal(
 	if (WARN_ON_ONCE(slab_is_available()))
 		return kzalloc_node(size, GFP_NOWAIT, nid);
 
-	if (!align) {
-		dump_stack();
-		align = SMP_CACHE_BYTES;
-	}
-
-	if (max_addr > memblock.current_limit)
-		max_addr = memblock.current_limit;
-again:
-	alloc = memblock_find_in_range_node(size, align, min_addr, max_addr,
-					    nid, flags);
-	if (alloc && !memblock_reserve(alloc, size))
-		goto done;
-
-	if (nid != NUMA_NO_NODE) {
-		alloc = memblock_find_in_range_node(size, align, min_addr,
-						    max_addr, NUMA_NO_NODE,
-						    flags);
-		if (alloc && !memblock_reserve(alloc, size))
-			goto done;
-	}
-
-	if (min_addr) {
-		min_addr = 0;
-		goto again;
-	}
-
-	if (flags & MEMBLOCK_MIRROR) {
-		flags &= ~MEMBLOCK_MIRROR;
-		pr_warn("Could not allocate %pap bytes of mirrored memory\n",
-			&size);
-		goto again;
-	}
+	alloc = memblock_alloc_range_nid(size, align, min_addr, max_addr, nid);
 
-	return NULL;
-done:
-	ptr = phys_to_virt(alloc);
+	/* retry allocation without lower limit */
+	if (!alloc && min_addr)
+		alloc = memblock_alloc_range_nid(size, align, 0, max_addr, nid);
 
-	/* Skip kmemleak for kasan_init() due to high volume. */
-	if (max_addr != MEMBLOCK_ALLOC_KASAN)
-		/*
-		 * The min_count is set to 0 so that bootmem allocated
-		 * blocks are never reported as leaks. This is because many
-		 * of these blocks are only referred via the physical
-		 * address which is not looked up by kmemleak.
-		 */
-		kmemleak_alloc(ptr, size, 0, 0);
+	if (!alloc)
+		return NULL;
 
-	return ptr;
+	return phys_to_virt(alloc);
 }
 
 /**
-- 
2.7.4

