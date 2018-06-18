Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A45C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798EB208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798EB208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964849AbeFRRA7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:00:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36645 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935457AbeFRRAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:00:30 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5IGx4Ft141938
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:00:30 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jpe1hqsgv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:00:29 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 18 Jun 2018 18:00:27 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Jun 2018 18:00:25 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5IH0OV634472094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Jun 2018 17:00:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5F0FA4051;
        Mon, 18 Jun 2018 17:51:07 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 510FAA405B;
        Mon, 18 Jun 2018 17:51:06 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.74])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 18 Jun 2018 17:51:06 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 18 Jun 2018 20:00:22 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 10/11] docs/mm: memblock: add overview documentation
Date:   Mon, 18 Jun 2018 19:59:58 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529341199-17682-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1529341199-17682-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18061817-0008-0000-0000-0000024916A4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061817-0009-0000-0000-000021AF5E9F
Message-Id: <1529341199-17682-11-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806180197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 mm/memblock.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index c4838a9..8bfeb82 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -26,6 +26,61 @@
 
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
+ * The early architecture setup should tell memblock what is the
+ * physical memory layout using :c:func:`memblock_add` or
+ * :c:func:`memblock_add_node` functions. The first function does not
+ * assign the region to a NUMA node and it is approptiate for UMA
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
+ * intialization compltes
+ */
+
 static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
 static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
-- 
2.7.4

