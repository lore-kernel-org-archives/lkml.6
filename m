Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A247C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0233208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0233208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935372AbeFRRAX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:00:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934536AbeFRRAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:00:17 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5IGx4dM141983
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:00:17 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jpe1hqs6f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:00:16 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 18 Jun 2018 18:00:15 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Jun 2018 18:00:12 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5IH0Brf28836036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Jun 2018 17:00:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1C554C046;
        Mon, 18 Jun 2018 17:51:13 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DEE94C044;
        Mon, 18 Jun 2018 17:51:12 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.74])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 18 Jun 2018 17:51:12 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 18 Jun 2018 20:00:09 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 04/11] docs/mm: bootmem: add kernel-doc description of 'struct bootmem_data'
Date:   Mon, 18 Jun 2018 19:59:52 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529341199-17682-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1529341199-17682-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18061817-0028-0000-0000-000002D2302C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061817-0029-0000-0000-000023896B22
Message-Id: <1529341199-17682-5-git-send-email-rppt@linux.vnet.ibm.com>
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
 include/linux/bootmem.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
index 7942a96..1526ba1 100644
--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -27,9 +27,20 @@ extern unsigned long max_pfn;
 extern unsigned long long max_possible_pfn;
 
 #ifndef CONFIG_NO_BOOTMEM
-/*
- * node_bootmem_map is a map pointer - the bits represent all physical 
- * memory pages (including holes) on the node.
+/**
+ * struct bootmem_data - per-node information used by the bootmem allocator
+ * @node_min_pfn: the starting physical address of the node's memory
+ * @node_low_pfn: the end physical address of the directly addressable memory
+ * @node_bootmem_map: is a bitmap pointer - the bits represent all physical
+ *		     memory pages (including holes) on the node.
+ * @last_end_off: the offset within the page of the end of the last allocation;
+ *                if 0, the page used is full
+ * @hint_idx: the the PFN of the page used with the last allocation;
+ *	       together with using this with the @last_end_offset field,
+ *	       a test can be made to see if allocations can be merged
+ *	       with the page used for the last allocation rather than
+ *	       using up a full new page.
+ * @list: list entry in the linked list ordered by the memory addresses
  */
 typedef struct bootmem_data {
 	unsigned long node_min_pfn;
-- 
2.7.4

