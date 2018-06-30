Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE4BC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1398B25703
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1398B25703
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeF3Oza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 10:55:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750802AbeF3OzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 10:55:21 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5UErWph085525
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 10:55:20 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jx412n7mt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 10:55:20 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Sat, 30 Jun 2018 15:55:18 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 30 Jun 2018 15:55:16 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5UEtFFp34537658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 30 Jun 2018 14:55:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F8034C040;
        Sat, 30 Jun 2018 15:55:01 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 821F64C04A;
        Sat, 30 Jun 2018 15:54:59 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.205.240])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 30 Jun 2018 15:54:59 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Sat, 30 Jun 2018 17:55:12 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2 02/11] docs/mm: nobootmem: fixup kernel-doc comments
Date:   Sat, 30 Jun 2018 17:54:57 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18063014-4275-0000-0000-00000293AA11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18063014-4276-0000-0000-0000379B1E25
Message-Id: <1530370506-21751-3-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806300176
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

