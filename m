Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9977CC6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D69525703
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D69525703
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeF3Oz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 10:55:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751825AbeF3Ozi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 10:55:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5UErV7o050091
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 10:55:37 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jx60wj992-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 10:55:37 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Sat, 30 Jun 2018 15:55:35 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 30 Jun 2018 15:55:33 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5UEtWYE30343200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 30 Jun 2018 14:55:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 587C6A4053;
        Sat, 30 Jun 2018 15:55:18 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBB08A4040;
        Sat, 30 Jun 2018 15:55:16 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.205.240])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 30 Jun 2018 15:55:16 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Sat, 30 Jun 2018 17:55:29 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2 09/11] docs/mm: memblock: add kernel-doc description for memblock types
Date:   Sat, 30 Jun 2018 17:55:04 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18063014-0008-0000-0000-0000024E31D6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18063014-0009-0000-0000-000021B43446
Message-Id: <1530370506-21751-10-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=951 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806300176
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

