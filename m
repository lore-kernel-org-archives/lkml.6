Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A568C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4AE20C03
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4AE20C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391582AbeHPQCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 12:02:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391573AbeHPQC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 12:02:29 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7GCxtva106469
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 09:03:59 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kw85tv55c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 09:03:58 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Thu, 16 Aug 2018 14:03:54 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 Aug 2018 14:03:50 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7GD3nYT46137512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Aug 2018 13:03:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E1AD4203F;
        Thu, 16 Aug 2018 16:03:53 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0551042041;
        Thu, 16 Aug 2018 16:03:52 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.148])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 16 Aug 2018 16:03:51 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Thu, 16 Aug 2018 16:03:46 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Michal Hocko <mhocko@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2 3/3] docs: core-api: add memory allocation guide
Date:   Thu, 16 Aug 2018 16:03:38 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534424618-24713-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1534424618-24713-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18081613-4275-0000-0000-000002AAB68C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081613-4276-0000-0000-000037B3DCB7
Message-Id: <1534424618-24713-4-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808160137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 Documentation/core-api/index.rst             |   1 +
 Documentation/core-api/memory-allocation.rst | 124 +++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)
 create mode 100644 Documentation/core-api/memory-allocation.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index cdc2020..8afc0da 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -27,6 +27,7 @@ Core utilities
    errseq
    printk-formats
    circular-buffers
+   memory-allocation
    mm-api
    gfp_mask-from-fs-io
    timekeeping
diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation/core-api/memory-allocation.rst
new file mode 100644
index 0000000..b9b0823
--- /dev/null
+++ b/Documentation/core-api/memory-allocation.rst
@@ -0,0 +1,124 @@
+=======================
+Memory Allocation Guide
+=======================
+
+Linux provides a variety of APIs for memory allocation. You can
+allocate small chunks using `kmalloc` or `kmem_cache_alloc` families,
+large virtually contiguous areas using `vmalloc` and its derivatives,
+or you can directly request pages from the page allocator with
+`alloc_pages`. It is also possible to use more specialized allocators,
+for instance `cma_alloc` or `zs_malloc`.
+
+Most of the memory allocation APIs use GFP flags to express how that
+memory should be allocated. The GFP acronym stands for "get free
+pages", the underlying memory allocation function.
+
+Diversity of the allocation APIs combined with the numerous GFP flags
+makes the question "How should I allocate memory?" not that easy to
+answer, although very likely you should use
+
+::
+
+  kzalloc(<size>, GFP_KERNEL);
+
+Of course there are cases when other allocation APIs and different GFP
+flags must be used.
+
+Get Free Page flags
+===================
+
+The GFP flags control the allocators behavior. They tell what memory
+zones can be used, how hard the allocator should try to find free
+memory, whether the memory can be accessed by the userspace etc. The
+:ref:`Documentation/core-api/mm-api.rst <mm-api-gfp-flags>` provides
+reference documentation for the GFP flags and their combinations and
+here we briefly outline their recommended usage:
+
+  * Most of the time ``GFP_KERNEL`` is what you need. Memory for the
+    kernel data structures, DMAable memory, inode cache, all these and
+    many other allocations types can use ``GFP_KERNEL``. Note, that
+    using ``GFP_KERNEL`` implies ``GFP_RECLAIM``, which means that
+    direct reclaim may be triggered under memory pressure; the calling
+    context must be allowed to sleep.
+  * If the allocation is performed from an atomic context, e.g interrupt
+    handler, use ``GFP_NOWAIT``. This flag prevents direct reclaim and
+    IO or filesystem operations. Consequently, under memory pressure
+    ``GFP_NOWAIT`` allocation is likely to fail. Allocations which
+    have a reasonable fallback should be using ``GFP_NOWARN``.
+  * If you think that accessing memory reserves is justified and the kernel
+    will be stressed unless allocation succeeds, you may use ``GFP_ATOMIC``.
+  * Untrusted allocations triggered from userspace should be a subject
+    of kmem accounting and must have ``__GFP_ACCOUNT`` bit set. There
+    is the handy ``GFP_KERNEL_ACCOUNT`` shortcut for ``GFP_KERNEL``
+    allocations that should be accounted.
+  * Userspace allocations should use either of the ``GFP_USER``,
+    ``GFP_HIGHUSER`` or ``GFP_HIGHUSER_MOVABLE`` flags. The longer
+    the flag name the less restrictive it is.
+
+    ``GFP_HIGHUSER_MOVABLE`` does not require that allocated memory
+    will be directly accessible by the kernel or the hardware and
+    implies that the data is movable.
+
+    ``GFP_HIGHUSER`` means that the allocated memory is not movable,
+    but it is not required to be directly accessible by the kernel or
+    the hardware. An example may be a hardware allocation that maps
+    data directly into userspace but has no addressing limitations.
+
+    ``GFP_USER`` means that the allocated memory is not movable and it
+    must be directly accessible by the kernel or the hardware. It is
+    typically used by hardware for buffers that are mapped to
+    userspace (e.g. graphics) that hardware still must DMA to.
+
+You may notice that quite a few allocations in the existing code
+specify ``GFP_NOIO`` or ``GFP_NOFS``. Historically, they were used to
+prevent recursion deadlocks caused by direct memory reclaim calling
+back into the FS or IO paths and blocking on already held
+resources. Since 4.12 the preferred way to address this issue is to
+use new scope APIs described in
+:ref:`Documentation/core-api/gfp_mask-from-fs-io.rst <gfp_mask_from_fs_io>`.
+
+Other legacy GFP flags are ``GFP_DMA`` and ``GFP_DMA32``. They are
+used to ensure that the allocated memory is accessible by hardware
+with limited addressing capabilities. So unless you are writing a
+driver for a device with such restrictions, avoid using these
+flags. And even with HW with restrictions it is preferable to use
+`dma_alloc*` APIs.
+
+Selecting memory allocator
+==========================
+
+The most straightforward way to allocate memory is to use a function
+from the :c:func:`kmalloc` family. And, to be on the safe size it's
+best to use routines that set memory to zero, like
+:c:func:`kzalloc`. If you need to allocate memory for an array, there
+are :c:func:`kmalloc_array` and :c:func:`kcalloc` helpers.
+
+The maximal size of a chunk that can be allocated with `kmalloc` is
+limited. The actual limit depends on the hardware and the kernel
+configuration, but it is a good practice to use `kmalloc` for objects
+smaller than page size.
+
+For large allocations you can use :c:func:`vmalloc` and
+:c:func:`vzalloc`, or directly request pages from the page
+allocator. The memory allocated by `vmalloc` and related functions is
+not physically contiguous.
+
+If you are not sure whether the allocation size is too large for
+`kmalloc`, it is possible to use :c:func:`kvmalloc` and its
+derivatives. It will try to allocate memory with `kmalloc` and if the
+allocation fails it will be retried with `vmalloc`. There are
+restrictions on which GFP flags can be used with `kvmalloc`; please
+see :c:func:`kvmalloc_node` reference documentation. Note that
+`kvmalloc` may return memory that is not physically contiguous.
+
+If you need to allocate many identical objects you can use the slab
+cache allocator. The cache should be set up with
+:c:func:`kmem_cache_create` before it can be used. Afterwards
+:c:func:`kmem_cache_alloc` and its convenience wrappers can allocate
+memory from that cache.
+
+When the allocated memory is no longer needed it must be freed. You
+can use :c:func:`kvfree` for the memory allocated with `kmalloc`,
+`vmalloc` and `kvmalloc`. The slab caches should be freed with
+:c:func:`kmem_cache_free`. And don't forget to destroy the cache with
+:c:func:`kmem_cache_destroy`.
-- 
2.7.4

