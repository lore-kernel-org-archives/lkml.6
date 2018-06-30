Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74026C6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA8A2575D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA8A2575D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeF3O4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 10:56:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751834AbeF3Ozl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 10:55:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5UErVTt036138
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 10:55:40 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jx3g6x3h2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 10:55:40 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Sat, 30 Jun 2018 15:55:38 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 30 Jun 2018 15:55:35 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5UEtYsX31391866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 30 Jun 2018 14:55:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A21442042;
        Sat, 30 Jun 2018 15:55:21 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB73742041;
        Sat, 30 Jun 2018 15:55:19 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.205.240])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 30 Jun 2018 15:55:19 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Sat, 30 Jun 2018 17:55:32 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2 10/11] docs/mm: memblock: add overview documentation
Date:   Sat, 30 Jun 2018 17:55:05 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18063014-0028-0000-0000-000002D6B5D8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18063014-0029-0000-0000-0000238E2AF9
Message-Id: <1530370506-21751-11-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806300176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 mm/memblock.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 3e6be01..084f5f5 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -27,6 +27,61 @@
 
 #include "internal.h"
 
+/**
+ * DOC: memblock overview
+ *
+ * Memblock is a method of managing memory regions during the early
+ * boot period when the usual kernel memory allocators are not up and
+ * running.
+ *
+ * Memblock views the system memory as collections of contiguous
+ * regions. There are several types of these collections:
+ *
+ * * ``memory`` - describes the physical memory available to the
+ *   kernel; this may differ from the actual physical memory installed
+ *   in the system, for instance when the memory is restricted with
+ *   ``mem=`` command line parameter
+ * * ``reserved`` - describes the regions that were allocated
+ * * ``physmap`` - describes the actual physical memory regardless of
+ *   the possible restrictions; the ``physmap`` type is only available
+ *   on some architectures.
+ *
+ * Each region is represented by :c:type:`struct memblock_region` that
+ * defines the region extents, its attributes and NUMA node id on NUMA
+ * systems. Every memory type is described by the :c:type:`struct
+ * memblock_type` which contains an array of memory regions along with
+ * the allocator metadata. The memory types are nicely wrapped with
+ * :c:type:`struct memblock`. This structure is statically initialzed
+ * at build time. The region arrays for the "memory" and "reserved"
+ * types are initially sized to %INIT_MEMBLOCK_REGIONS and for the
+ * "physmap" type to %INIT_PHYSMEM_REGIONS.
+ * The :c:func:`memblock_allow_resize` enables automatic resizing of
+ * the region arrays during addition of new regions. This feature
+ * should be used with care so that memory allocated for the region
+ * array will not overlap with areas that should be reserved, for
+ * example initrd.
+ *
+ * The early architecture setup should tell memblock what the physical
+ * memory layout is by using :c:func:`memblock_add` or
+ * :c:func:`memblock_add_node` functions. The first function does not
+ * assign the region to a NUMA node and it is appropriate for UMA
+ * systems. Yet, it is possible to use it on NUMA systems as well and
+ * assign the region to a NUMA node later in the setup process using
+ * :c:func:`memblock_set_node`. The :c:func:`memblock_add_node`
+ * performs such an assignment directly.
+ *
+ * Once memblock is setup the memory can be allocated using either
+ * memblock or bootmem APIs.
+ *
+ * As the system boot progresses, the architecture specific
+ * :c:func:`mem_init` function frees all the memory to the buddy page
+ * allocator.
+ *
+ * If an architecure enables %CONFIG_ARCH_DISCARD_MEMBLOCK, the
+ * memblock data structures will be discarded after the system
+ * initialization compltes.
+ */
+
 static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
 static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
-- 
2.7.4

