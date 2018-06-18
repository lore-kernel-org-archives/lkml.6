Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2892BC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17D9208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17D9208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935443AbeFRRA0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:00:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935319AbeFRRAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:00:21 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5IGwsu1074224
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:00:20 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jpe6qqa6q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:00:19 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 18 Jun 2018 18:00:17 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Jun 2018 18:00:14 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5IH0DKG31457328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Jun 2018 17:00:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31C4AA404D;
        Mon, 18 Jun 2018 17:50:57 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA26EA4040;
        Mon, 18 Jun 2018 17:50:55 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.74])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 18 Jun 2018 17:50:55 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 18 Jun 2018 20:00:11 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 05/11] docs/mm: bootmem: add overview documentation
Date:   Mon, 18 Jun 2018 19:59:53 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529341199-17682-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1529341199-17682-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18061817-0016-0000-0000-000001DD5BF5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061817-0017-0000-0000-000032316261
Message-Id: <1529341199-17682-6-git-send-email-rppt@linux.vnet.ibm.com>
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
 mm/bootmem.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/mm/bootmem.c b/mm/bootmem.c
index 76fc17e..423cb5f 100644
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -21,6 +21,53 @@
 
 #include "internal.h"
 
+/**
+ * DOC: bootmem overview
+ *
+ * Bootmem is a boot-time physical memory allocator and configurator.
+ *
+ * It is used early in the boot process before the page allocator is
+ * set up.
+ *
+ * The bootmem is based on the most basic of allocators, a First Fit
+ * allocator which uses a bitmap to represent memory. If a bit is 1,
+ * the page is allocated and 0 if unallocated. To satisfy allocations
+ * of sizes smaller than a page, the allocator records the Page Frame
+ * Number (PFN) of the last allocation and the offset the allocation
+ * ended at. Subsequent small allocations are merged together and
+ * stored on the same page.
+ *
+ * The information used by the bootmem allocator is represented by
+ * :c:type:`struct bootmem_data`. An array to hold up to %MAX_NUMNODES
+ * such structures is statically allocated and then it is discarded
+ * when the system initialization completes. Each entry in this array
+ * corresponds to a node with memory. For UMA systems only entry 0 is
+ * used.
+ *
+ * The bootmem allocator is initialized during early architecture
+ * specific setup. Each architecture is required to supply a
+ * :c:func:`setup_arch` function which, among other tasks, is
+ * responsible for acquiring the necessary parameters to initialise
+ * the boot memory allocator. These parameters define limits of usable
+ * physical memory:
+ *
+ * * @min_low_pfn - the lowest PFN that is available in the system
+ * * @max_low_pfn - the highest PFN that may be addressed by low
+ *   memory (%ZONE_NORMAL)
+ * * @max_pfn - the last PFN available to the system.
+ *
+ * After those limits are determined, the :c:func:`init_bootmem` or
+ * :c:func:`init_bootmem_node` function should be called to initialize
+ * the bootmem allocator. The UMA case should use the `init_bootmem`
+ * function. It will initialize ``contig_page_data`` structure that
+ * represents the only memory node in the system. In the NUMA case the
+ * `init_bootmem_node` function should be called to initialize the
+ * bootmem allocator for each node.
+ *
+ * Once the allocator is set up, it is possible to use either single
+ * node or NUMA variant of the allocation APIs.
+ */
+
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 struct pglist_data __refdata contig_page_data = {
 	.bdata = &bootmem_node_data[0]
-- 
2.7.4

