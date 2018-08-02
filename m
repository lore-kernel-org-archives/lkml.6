Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3E9C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2A92083E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED2A92083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbeHBNbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:31:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10221 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732173AbeHBNbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:31:01 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E87E9C5255744;
        Thu,  2 Aug 2018 19:40:10 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Thu, 2 Aug 2018 19:40:11 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <aacraid@microsemi.com>
CC:     <andy.shevchenko@gmail.com>, <joe@perches.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] Use dma_zalloc_coherent and kvcalloc to replace open code
Date:   Thu, 2 Aug 2018 19:28:30 +0800
Message-ID: <1533209314-1074-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 
v1->v2: 

According to Andy and Joe suggestions. 
[patch 1/4] get rid of unnessary parens and use kvcalloc and kvfree to
replace the vmalloc and vfree.
[patch 2/4] modify the changelog as Andy's suggestion.
[patch 3/4] replace vmalloc and vfree by using kvcalloc adn kvfree.
[patch 4/4] do nothing. just add Andy's review-by.


zhong jiang (4):
  driver/scsi/fnic/fnic_trace: Use kvcalloc instead of vmalloc+memset
  drivers/scsi/dpt_i2o: Use dma_zalloc_coherent to repalce
    dma_alloc_coherent+memset
  drivers/scsi/snic/snic_trc: Use kvcalloc instead of vmalloc+memset
  drivers/scsi/mvsas/mv_init: Use dma_zalloc_coherent to replace
    dma_alloc_coherent+memset

 drivers/scsi/dpt_i2o.c         | 12 ++++--------
 drivers/scsi/fnic/fnic_trace.c |  7 +++----
 drivers/scsi/mvsas/mv_init.c   | 12 ++++--------
 drivers/scsi/snic/snic_trc.c   |  7 +++----
 4 files changed, 14 insertions(+), 24 deletions(-)

-- 
1.7.12.4

