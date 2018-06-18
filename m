Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505F3C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A5D208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A5D208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935527AbeFRRCY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:02:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752835AbeFRRAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:00:15 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5IGwrTp045906
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:00:14 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jpfx8t56y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:00:14 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 18 Jun 2018 18:00:11 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Jun 2018 18:00:08 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5IH07re23920656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Jun 2018 17:00:07 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CE3DAE04D;
        Mon, 18 Jun 2018 17:48:51 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29204AE045;
        Mon, 18 Jun 2018 17:48:50 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.74])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 18 Jun 2018 17:48:50 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 18 Jun 2018 20:00:05 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 02/11] docs/mm: nobootmem: fixup kernel-doc comments
Date:   Mon, 18 Jun 2018 19:59:50 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529341199-17682-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1529341199-17682-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18061817-0020-0000-0000-0000029C3559
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061817-0021-0000-0000-000020E87C0B
Message-Id: <1529341199-17682-3-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806180197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* add kernel-doc marking to free_bootmem_late() description
* add return value descriptions
* mention that address parameter of free_bootmem{_node} is a physical address

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 mm/nobootmem.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/mm/nobootmem.c b/mm/nobootmem.c
index 9b02fda..c2cfa04 100644
--- a/mm/nobootmem.c
+++ b/mm/nobootmem.c
@@ -72,7 +72,7 @@ static void * __init __alloc_memory_core_early(int nid, u64 size, u64 align,
 	return ptr;
 }
 
-/*
+/**
  * free_bootmem_late - free bootmem pages directly to page allocator
  * @addr: starting address of the range
  * @size: size of the range in bytes
@@ -176,7 +176,7 @@ void __init reset_all_zones_managed_pages(void)
 /**
  * free_all_bootmem - release free pages to the buddy allocator
  *
- * Returns the number of pages actually released.
+ * Return: the number of pages actually released.
  */
 unsigned long __init free_all_bootmem(void)
 {
@@ -193,7 +193,7 @@ unsigned long __init free_all_bootmem(void)
 /**
  * free_bootmem_node - mark a page range as usable
  * @pgdat: node the range resides on
- * @physaddr: starting address of the range
+ * @physaddr: starting physical address of the range
  * @size: size of the range in bytes
  *
  * Partial pages will be considered reserved and left as they are.
@@ -208,7 +208,7 @@ void __init free_bootmem_node(pg_data_t *pgdat, unsigned long physaddr,
 
 /**
  * free_bootmem - mark a page range as usable
- * @addr: starting address of the range
+ * @addr: starting physical address of the range
  * @size: size of the range in bytes
  *
  * Partial pages will be considered reserved and left as they are.
@@ -256,7 +256,7 @@ static void * __init ___alloc_bootmem_nopanic(unsigned long size,
  *
  * Allocation may happen on any node in the system.
  *
- * Returns NULL on failure.
+ * Return: address of the allocated region or %NULL on failure.
  */
 void * __init __alloc_bootmem_nopanic(unsigned long size, unsigned long align,
 					unsigned long goal)
@@ -293,6 +293,8 @@ static void * __init ___alloc_bootmem(unsigned long size, unsigned long align,
  * Allocation may happen on any node in the system.
  *
  * The function panics if the request can not be satisfied.
+ *
+ * Return: address of the allocated region.
  */
 void * __init __alloc_bootmem(unsigned long size, unsigned long align,
 			      unsigned long goal)
@@ -367,6 +369,8 @@ static void * __init ___alloc_bootmem_node(pg_data_t *pgdat, unsigned long size,
  * can not hold the requested memory.
  *
  * The function panics if the request can not be satisfied.
+ *
+ * Return: address of the allocated region.
  */
 void * __init __alloc_bootmem_node(pg_data_t *pgdat, unsigned long size,
 				   unsigned long align, unsigned long goal)
@@ -396,6 +400,8 @@ void * __init __alloc_bootmem_node_high(pg_data_t *pgdat, unsigned long size,
  * Allocation may happen on any node in the system.
  *
  * The function panics if the request can not be satisfied.
+ *
+ * Return: address of the allocated region.
  */
 void * __init __alloc_bootmem_low(unsigned long size, unsigned long align,
 				  unsigned long goal)
@@ -425,6 +431,8 @@ void * __init __alloc_bootmem_low_nopanic(unsigned long size,
  * can not hold the requested memory.
  *
  * The function panics if the request can not be satisfied.
+ *
+ * Return: address of the allocated region.
  */
 void * __init __alloc_bootmem_low_node(pg_data_t *pgdat, unsigned long size,
 				       unsigned long align, unsigned long goal)
-- 
2.7.4

