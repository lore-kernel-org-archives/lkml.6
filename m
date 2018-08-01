Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AB0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E0820894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E0820894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389520AbeHAPYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:24:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56983 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389274AbeHAPXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:23:55 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E718CC3F6FD47;
        Wed,  1 Aug 2018 21:38:00 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.399.0; Wed, 1 Aug 2018 21:37:52 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <john.garry@huawei.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <aacraid@microsemi.com>
CC:     <andy.shevchenko@gmail.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] use dma_zalloc_coherent and vzalloc to replace open code
Date:   Wed, 1 Aug 2018 21:26:12 +0800
Message-ID: <1533129976-51930-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


zhong jiang (4):
  driver/scsi/fnic/fnic_trace: Use vzalloc to zero instead of
    vmalloc+memset
  drivers/scsi/dpt_i2o: Use dma_zalloc_coherent to repalce
    dma_alloc_coherent+memset
  drivers/scsi/snic/snic_trc: Use vzalloc instead of vmalloc+memset
  drivers/scsi/mvsas/mv_init: Use dma_zalloc_coherent to replace
    dma_alloc_coherent+memset

 drivers/scsi/dpt_i2o.c         | 12 ++++--------
 drivers/scsi/fnic/fnic_trace.c |  3 +--
 drivers/scsi/mvsas/mv_init.c   | 12 ++++--------
 drivers/scsi/snic/snic_trc.c   |  3 +--
 4 files changed, 10 insertions(+), 20 deletions(-)

-- 
1.7.12.4

