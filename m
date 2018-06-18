Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265D6C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8BD208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD8BD208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933985AbeFRRAY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:00:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35217 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932762AbeFRRAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:00:17 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5IGwuhV131449
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:00:16 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jpfkkb3fx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:00:15 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 18 Jun 2018 18:00:13 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Jun 2018 18:00:10 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5IH09E831260904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Jun 2018 17:00:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8789A5204D;
        Mon, 18 Jun 2018 16:49:29 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.74])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 1412052041;
        Mon, 18 Jun 2018 16:49:28 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 18 Jun 2018 20:00:07 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 03/11] docs/mm: bootmem: fix kernel-doc warnings
Date:   Mon, 18 Jun 2018 19:59:51 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529341199-17682-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1529341199-17682-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18061817-4275-0000-0000-0000028F1EDD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061817-4276-0000-0000-000037965E4E
Message-Id: <1529341199-17682-4-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=946 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806180197
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

