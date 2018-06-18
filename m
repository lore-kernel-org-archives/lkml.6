Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28558C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF42E208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF42E208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964886AbeFRRBB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:01:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41185 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935420AbeFRRA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:00:26 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5IGwsKi182596
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:00:25 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jpde7h93w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:00:24 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 18 Jun 2018 18:00:23 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Jun 2018 18:00:21 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5IH0KGJ33095774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Jun 2018 17:00:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 133E45204E;
        Mon, 18 Jun 2018 16:49:40 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.74])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 9A8CB52043;
        Mon, 18 Jun 2018 16:49:38 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 18 Jun 2018 20:00:18 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 08/11] docs/mm: memblock: add kernel-doc comments for memblock_add[_node]
Date:   Mon, 18 Jun 2018 19:59:56 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529341199-17682-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1529341199-17682-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18061817-0016-0000-0000-000001DD5BF8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061817-0017-0000-0000-000032316264
Message-Id: <1529341199-17682-9-git-send-email-rppt@linux.vnet.ibm.com>
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

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 mm/memblock.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 3d6deff..c4838a9 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -594,12 +594,35 @@ int __init_memblock memblock_add_range(struct memblock_type *type,
 	}
 }
 
+/**
+ * memblock_add_node - add new memblock region within a NUMA node
+ * @base: base address of the new region
+ * @size: size of the new region
+ * @nid: nid of the new region
+ *
+ * Add new memblock region [@base, @base + @size) to the "memory"
+ * type. See memblock_add_range() description for mode details
+ *
+ * Return:
+ * 0 on success, -errno on failure.
+ */
 int __init_memblock memblock_add_node(phys_addr_t base, phys_addr_t size,
 				       int nid)
 {
 	return memblock_add_range(&memblock.memory, base, size, nid, 0);
 }
 
+/**
+ * memblock_add - add new memblock region
+ * @base: base address of the new region
+ * @size: size of the new region
+ *
+ * Add new memblock region [@base, @base + @size) to the "memory"
+ * type. See memblock_add_range() description for mode details
+ *
+ * Return:
+ * 0 on success, -errno on failure.
+ */
 int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
 {
 	phys_addr_t end = base + size - 1;
@@ -1458,9 +1481,9 @@ void __init __memblock_free_early(phys_addr_t base, phys_addr_t size)
 	memblock_remove_range(&memblock.reserved, base, size);
 }
 
-/*
+/**
  * __memblock_free_late - free bootmem block pages directly to buddy allocator
- * @addr: phys starting address of the  boot memory block
+ * @base: phys starting address of the  boot memory block
  * @size: size of the boot memory block in bytes
  *
  * This is only useful when the bootmem allocator has already been torn
-- 
2.7.4

