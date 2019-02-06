Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F1CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3BF20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbfBFMbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:31:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730295AbfBFMbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:31:48 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x16CTHTJ094663
        for <linux-kernel@vger.kernel.org>; Wed, 6 Feb 2019 07:31:47 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qfxbqvqqp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:31:46 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 6 Feb 2019 12:31:44 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 6 Feb 2019 12:31:42 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x16CVfxs9306546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 12:31:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6325A48B3;
        Wed,  6 Feb 2019 12:10:30 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70F68A48AE;
        Wed,  6 Feb 2019 12:10:29 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  6 Feb 2019 12:10:29 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 06 Feb 2019 14:10:28 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 1/2] memblock: remove memblock_{set,clear}_region_flags
Date:   Wed,  6 Feb 2019 14:10:24 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549455025-17706-1-git-send-email-rppt@linux.ibm.com>
References: <1549455025-17706-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19020612-4275-0000-0000-0000030C2305
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020612-4276-0000-0000-0000381A283D
Message-Id: <1549455025-17706-2-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=887 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memblock API provides dedicated helpers to set or clear a flag on a
memory region, e.g. memblock_{mark,clear}_hotplug().

The memblock_{set,clear}_region_flags() functions are used only by the
memblock internal function that adjusts the region flags.
Drop these functions and use open-coded implementation instead.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/memblock.h | 12 ------------
 mm/memblock.c            |  9 ++++++---
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 71c9e32..32a9a6b 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -317,18 +317,6 @@ void __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
 	for_each_mem_range_rev(i, &memblock.memory, &memblock.reserved,	\
 			       nid, flags, p_start, p_end, p_nid)
 
-static inline void memblock_set_region_flags(struct memblock_region *r,
-					     enum memblock_flags flags)
-{
-	r->flags |= flags;
-}
-
-static inline void memblock_clear_region_flags(struct memblock_region *r,
-					       enum memblock_flags flags)
-{
-	r->flags &= ~flags;
-}
-
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 int memblock_set_node(phys_addr_t base, phys_addr_t size,
 		      struct memblock_type *type, int nid);
diff --git a/mm/memblock.c b/mm/memblock.c
index 0151a5b..af5fe8e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -851,11 +851,14 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
 	if (ret)
 		return ret;
 
-	for (i = start_rgn; i < end_rgn; i++)
+	for (i = start_rgn; i < end_rgn; i++) {
+		struct memblock_region *r = &type->regions[i];
+
 		if (set)
-			memblock_set_region_flags(&type->regions[i], flag);
+			r->flags |= flag;
 		else
-			memblock_clear_region_flags(&type->regions[i], flag);
+			r->flags &= ~flag;
+	}
 
 	memblock_merge_regions(type);
 	return 0;
-- 
2.7.4

