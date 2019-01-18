Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5A4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA25A20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oHuBADgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfARHIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:08:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51382 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfARHI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:08:29 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0I73jqV104279;
        Fri, 18 Jan 2019 07:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=vLNiKQ7cLr4NNUDnnRzs3azMc/POr/UV7CezxjOM8zw=;
 b=oHuBADgFyAc7zX723JM0vXcxLY+w3Rm23W/jQiXuFt1jZT7mzPfnQWV/jsvvJ9KXt7o3
 O7ZuhmFM33XSBQeknnS0GRwF56jSGUMTqbviL/soL3PMS2Ozs1565ZrSmGXdJuBsGXvK
 uezfOpvtO6WrISu5fKJkEJtPsGJyDRx/rZ8MFhd1ggPqNf/3t461/r5qtDrMnruNkgTF
 7nLKpoapMMVZOpFSwZCsBwIDGOUrmjTnh8c9FBNRa3M5IA1Exd6BpvOfCFyHStMPZL5m
 v1XW25T2Fxnl3mvhIWo8H1R9Jk12eUrWqO08lzAcbv4tLaJnHtRDBRozyTn3d4fLuw+4 Kg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2pybjsm025-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jan 2019 07:08:17 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0I78GBP018784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jan 2019 07:08:16 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0I78FXL013325;
        Fri, 18 Jan 2019 07:08:15 GMT
Received: from linux.cn.oracle.com (/10.182.71.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Jan 2019 23:08:14 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, joe.jin@oracle.com, dongli.zhang@oracle.com
Subject: [PATCH v3 1/3] swiotlb: fix comment on swiotlb_bounce()
Date:   Fri, 18 Jan 2019 15:10:26 +0800
Message-Id: <1547795428-10595-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9139 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=727
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901180054
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
index 1fb6fd6..1d8b377 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -385,7 +385,7 @@ void __init swiotlb_exit(void)
 }
 
 /*
- * Bounce: copy the swiotlb buffer back to the original dma location
+ * Bounce: copy the swiotlb buffer from or back to the original dma location
  */
 static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
 			   size_t size, enum dma_data_direction dir)
-- 
2.7.4

