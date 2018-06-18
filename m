Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C03AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBD8208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBD8208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935486AbeFRRAc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:00:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935319AbeFRRA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:00:28 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5IGwsqT124674
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:00:28 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jpfw329jd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:00:27 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 18 Jun 2018 18:00:26 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Jun 2018 18:00:23 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5IH0MTI23068894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Jun 2018 17:00:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58F134C059;
        Mon, 18 Jun 2018 17:51:24 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D782F4C05E;
        Mon, 18 Jun 2018 17:51:22 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.74])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 18 Jun 2018 17:51:22 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 18 Jun 2018 20:00:20 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 09/11] docs/mm: memblock: add kernel-doc description for memblock types
Date:   Mon, 18 Jun 2018 19:59:57 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529341199-17682-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1529341199-17682-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18061817-0016-0000-0000-000001DD5BFA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061817-0017-0000-0000-000032316266
Message-Id: <1529341199-17682-10-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=966 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806180197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 include/linux/memblock.h | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 63704c6..5169205 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -20,7 +20,13 @@
 #define INIT_MEMBLOCK_REGIONS	128
 #define INIT_PHYSMEM_REGIONS	4
 
-/* Definition of memblock flags. */
+/**
+ * enum memblock_flags - definition of memory region attributes
+ * @MEMBLOCK_NONE: no special request
+ * @MEMBLOCK_HOTPLUG: hotpluggable region
+ * @MEMBLOCK_MIRROR: mirrored region
+ * @MEMBLOCK_NOMAP: don't add to kernel direct mapping
+ */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
 	MEMBLOCK_HOTPLUG	= 0x1,	/* hotpluggable region */
@@ -28,6 +34,13 @@ enum memblock_flags {
 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
 };
 
+/**
+ * struct memblock_region - represents a memory region
+ * @base: physical address of the region
+ * @size: size of the region
+ * @flags: memory region attributes
+ * @nid: NUMA node id
+ */
 struct memblock_region {
 	phys_addr_t base;
 	phys_addr_t size;
@@ -37,14 +50,30 @@ struct memblock_region {
 #endif
 };
 
+/**
+ * struct memblock_type - collection of memory regions of certain type
+ * @cnt: number of regions
+ * @max: size of the allocated array
+ * @total_size: size of all regions
+ * @regions: array of regions
+ * @name: the memory type symbolic name
+ */
 struct memblock_type {
-	unsigned long cnt;	/* number of regions */
-	unsigned long max;	/* size of the allocated array */
-	phys_addr_t total_size;	/* size of all regions */
+	unsigned long cnt;
+	unsigned long max;
+	phys_addr_t total_size;
 	struct memblock_region *regions;
 	char *name;
 };
 
+/**
+ * struct memblock - memblock allocator metadata
+ * @bottom_up: is bottom up direction?
+ * @current_limit: physical address of the current allocation limit
+ * @memory: usabe memory regions
+ * @reserved: reserved memory regions
+ * @physmem: all physical memory
+ */
 struct memblock {
 	bool bottom_up;  /* is bottom up direction? */
 	phys_addr_t current_limit;
-- 
2.7.4

