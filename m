Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524ECFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0181020861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0181020861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbeINOl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:41:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728268AbeINOlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:41:55 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8E9O6X4089831
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 05:28:16 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mg7468as7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 05:28:16 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Fri, 14 Sep 2018 10:28:14 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Sep 2018 10:28:11 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8E9SA2x58917038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Sep 2018 09:28:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04DED4203F;
        Fri, 14 Sep 2018 12:28:01 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C4A542049;
        Fri, 14 Sep 2018 12:27:59 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.116])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 14 Sep 2018 12:27:59 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Fri, 14 Sep 2018 12:28:08 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v4 3/3] docs: core-api: add memory allocation guide
Date:   Fri, 14 Sep 2018 12:27:58 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536917278-31191-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536917278-31191-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18091409-0012-0000-0000-000002A8C425
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091409-0013-0000-0000-000020DD0E2D
Message-Id: <1536917278-31191-4-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809140101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/core-api/index.rst             |   1 +
 Documentation/core-api/memory-allocation.rst | 122 +++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)
 create mode 100644 Documentation/core-api/memory-allocation.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 26b735c..165d7688 100644
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
index 0000000..f8bb9aa
--- /dev/null
+++ b/Documentation/core-api/memory-allocation.rst
@@ -0,0 +1,122 @@
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
+    will be directly accessible by the kernel and implies that the
+    data is movable.
+
+    ``GFP_HIGHUSER`` means that the allocated memory is not movable,
+    but it is not required to be directly accessible by the kernel. An
+    example may be a hardware allocation that maps data directly into
+    userspace but has no addressing limitations.
+
+    ``GFP_USER`` means that the allocated memory is not movable and it
+    must be directly accessible by the kernel.
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
+driver for a device with such restrictions, avoid using these flags.
+And even with hardware with restrictions it is preferable to use
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

