Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2A9C282C3
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDD8218FF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfAZDYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 22:24:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:58146 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfAZDYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 22:24:34 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 36CB3C3DFFF72844A094;
        Sat, 26 Jan 2019 11:24:32 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Sat, 26 Jan 2019 11:24:25 +0800
From:   "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <xavier.huwei@huawei.com>,
        <lijun_nudt@163.com>, <oulijun@huawei.com>,
        <liudongdong3@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <xavier_huwei@163.com>
Subject: [PATCH V3 rdma-next 0/3] RDMA/hns: Some fixes for hns RoCE driver 
Date:   Sat, 26 Jan 2019 11:59:20 +0800
Message-ID: <1548475163-44098-1-git-send-email-xavier.huwei@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason and Doug

This patch series includes three bugfixes for reset related operations
and are maked based on wip/jgg-for-next branch.

Best Regards
Xavier

Wei Hu (Xavier) (3):
  RDMA/hns: Fix the Oops during rmmod or insmod ko when reset occurs
  RDMA/hns: Fix the chip hanging caused by sending mailbox&CMQ during
    reset
  RDMA/hns: Fix the chip hanging caused by sending doorbell during reset

 drivers/infiniband/hw/hns/hns_roce_cmd.c    |  32 +++-
 drivers/infiniband/hw/hns/hns_roce_device.h |  29 +++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 270 +++++++++++++++++++++++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  14 ++
 4 files changed, 316 insertions(+), 29 deletions(-)

-- 
1.9.1

