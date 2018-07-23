Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76025ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3452320875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3452320875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387847AbeGWG4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 02:56:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728399AbeGWG4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 02:56:44 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6N5rvJw070957
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 01:57:12 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kd7vejxc2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 01:57:12 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 23 Jul 2018 06:57:10 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Jul 2018 06:57:07 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6N5v65r34603148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jul 2018 05:57:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F117F52051;
        Mon, 23 Jul 2018 08:57:21 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.108])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 6D85B5204E;
        Mon, 23 Jul 2018 08:57:20 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 23 Jul 2018 08:57:04 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-ia64@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 2/4] ia64: remove unused num_dma_physpages member from 'struct early_node_data'
Date:   Mon, 23 Jul 2018 08:56:56 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532325418-22617-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1532325418-22617-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072305-0008-0000-0000-000002565300
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072305-0009-0000-0000-000021BCBE8D
Message-Id: <1532325418-22617-3-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-22_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807230070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 05e0caad3b7b ("[PATCH] Have ia64 use add_active_range() and
free_area_init_nodes") the num_dma_physpages member of 'struct
early_node_data' is calculated but never used. Remove it.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/ia64/mm/discontig.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index 7d9bd20..6148ea8 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -38,9 +38,6 @@ struct early_node_data {
 	struct ia64_node_data *node_data;
 	unsigned long pernode_addr;
 	unsigned long pernode_size;
-#ifdef CONFIG_ZONE_DMA32
-	unsigned long num_dma_physpages;
-#endif
 	unsigned long min_pfn;
 	unsigned long max_pfn;
 };
@@ -669,11 +666,6 @@ static __init int count_node_pages(unsigned long start, unsigned long len, int n
 {
 	unsigned long end = start + len;
 
-#ifdef CONFIG_ZONE_DMA32
-	if (start <= __pa(MAX_DMA_ADDRESS))
-		mem_data[node].num_dma_physpages +=
-			(min(end, __pa(MAX_DMA_ADDRESS)) - start) >>PAGE_SHIFT;
-#endif
 	start = GRANULEROUNDDOWN(start);
 	end = GRANULEROUNDUP(end);
 	mem_data[node].max_pfn = max(mem_data[node].max_pfn,
-- 
2.7.4

