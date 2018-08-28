Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F77EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35512208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5Q8hb6w7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35512208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeH1LgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:36:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42490 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeH1LgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:36:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7S7iS1W057511;
        Tue, 28 Aug 2018 07:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=ztwho5heAy5+sTV57/6fJIXRMP+j4mLNtKGrNAURBvs=;
 b=5Q8hb6w7BqmQPt2QKaTuAp9wqZ+06RaBFJ1U3Tv3KQXIS+d7fx7N6H9oLL73z15lPo2E
 CvKk68w/He4mUxtSTXF3M86M23d1Ophrf2LWcFyiI4wnd03SNolcczVMJZdvdYmmjLKY
 TluHlyeVeusQJpU1mj2/Om6MSlGgKm5sMnKLZAqPekwKBCNu4yyjsaJYCoTbMl8zrhlH
 40PeQPIvPHn5eEFBNZNnWn6J4whg7hIEcqkYV+a1TIUHO96U3klAEk6MfV6lbxcUxuDh
 +ab1lZxBGqsFKYkSFeW1DqJgW1GdenRryAG9R81Kag4GkS0zxzKsQSmpDv9+wfSVaCEX tQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2m2yrq218m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Aug 2018 07:45:49 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7S7jlpb008465
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Aug 2018 07:45:48 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7S7jk7C011964;
        Tue, 28 Aug 2018 07:45:47 GMT
Received: from linux.cn.oracle.com (/10.182.70.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Aug 2018 00:45:46 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com
Subject: [PATCH 1/1] swiotlb: fix comment on swiotlb_bounce()
Date:   Tue, 28 Aug 2018 15:46:37 +0800
Message-Id: <1535442397-28647-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8998 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=741
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808280081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the comment as swiotlb_bounce() is used to copy from original dma
location to swiotlb buffer during swiotlb_tbl_map_single(), while to
copy from swiotlb buffer to original dma location during
swiotlb_tbl_unmap_single().

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 kernel/dma/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 4f8a6db..8fd4cfe 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -435,7 +435,7 @@ int is_swiotlb_buffer(phys_addr_t paddr)
 }
 
 /*
- * Bounce: copy the swiotlb buffer back to the original dma location
+ * Bounce: copy the swiotlb buffer from or back to the original dma location
  */
 static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
 			   size_t size, enum dma_data_direction dir)
-- 
2.7.4

