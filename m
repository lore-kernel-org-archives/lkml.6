Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD2EC6778D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6335925703
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6335925703
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751681AbeF3Ozc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 10:55:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41690 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751318AbeF3OzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 10:55:22 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5UErWiK098208
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 10:55:21 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jx2t3xss7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 10:55:21 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Sat, 30 Jun 2018 15:55:20 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 30 Jun 2018 15:55:18 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5UEtH7641943278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 30 Jun 2018 14:55:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE094A4040;
        Sat, 30 Jun 2018 15:55:03 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D4EFA404D;
        Sat, 30 Jun 2018 15:55:02 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.205.240])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 30 Jun 2018 15:55:02 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Sat, 30 Jun 2018 17:55:15 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2 03/11] docs/mm: bootmem: fix kernel-doc warnings
Date:   Sat, 30 Jun 2018 17:54:58 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18063014-0028-0000-0000-000002D6B5D3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18063014-0029-0000-0000-0000238E2AF3
Message-Id: <1530370506-21751-4-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=913 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806300176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add descriptions of the return value where they were missing and fixup the
syntax for present ones.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 mm/bootmem.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/bootmem.c b/mm/bootmem.c
index 42ab0da..76fc17e 100644
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -62,6 +62,8 @@ static unsigned long __init bootmap_bytes(unsigned long pages)
 /**
  * bootmem_bootmap_pages - calculate bitmap size in pages
  * @pages: number of pages the bitmap has to represent
+ *
+ * Return: the number of pages needed to hold the bitmap.
  */
 unsigned long __init bootmem_bootmap_pages(unsigned long pages)
 {
@@ -121,7 +123,7 @@ static unsigned long __init init_bootmem_core(bootmem_data_t *bdata,
  * @startpfn: first pfn on the node
  * @endpfn: first pfn after the node
  *
- * Returns the number of bytes needed to hold the bitmap for this node.
+ * Return: the number of bytes needed to hold the bitmap for this node.
  */
 unsigned long __init init_bootmem_node(pg_data_t *pgdat, unsigned long freepfn,
 				unsigned long startpfn, unsigned long endpfn)
@@ -134,7 +136,7 @@ unsigned long __init init_bootmem_node(pg_data_t *pgdat, unsigned long freepfn,
  * @start: pfn where the bitmap is to be placed
  * @pages: number of available physical pages
  *
- * Returns the number of bytes needed to hold the bitmap.
+ * Return: the number of bytes needed to hold the bitmap.
  */
 unsigned long __init init_bootmem(unsigned long start, unsigned long pages)
 {
@@ -406,6 +408,8 @@ void __init free_bootmem(unsigned long physaddr, unsigned long size)
  * Partial pages will be reserved.
  *
  * The range must reside completely on the specified node.
+ *
+ * Return: 0 on success, -errno on failure.
  */
 int __init reserve_bootmem_node(pg_data_t *pgdat, unsigned long physaddr,
 				 unsigned long size, int flags)
@@ -427,6 +431,8 @@ int __init reserve_bootmem_node(pg_data_t *pgdat, unsigned long physaddr,
  * Partial pages will be reserved.
  *
  * The range must be contiguous but may span node boundaries.
+ *
+ * Return: 0 on success, -errno on failure.
  */
 int __init reserve_bootmem(unsigned long addr, unsigned long size,
 			    int flags)
-- 
2.7.4

