Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0288BC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D046D2082C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfBCMoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 07:44:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3171 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727474AbfBCMnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 07:43:55 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 49AF8FD851FBD2CE2B46;
        Sun,  3 Feb 2019 20:43:53 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Sun, 3 Feb 2019 20:43:46 +0800
From:   "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <xavier.huwei@huawei.com>,
        <lijun_nudt@163.com>, <oulijun@huawei.com>,
        <liudongdong3@huawei.com>, <liuyixian@huawei.com>,
        <zhangxiping3@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <xavier_huwei@163.com>
Subject: [PATCH V4 rdma-next 0/3] RDMA/hns: Some fixes for hns RoCE driver
Date:   Sun, 3 Feb 2019 20:43:12 +0800
Message-ID: <1549197795-23118-1-git-send-email-xavier.huwei@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
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
 drivers/infiniband/hw/hns/hns_roce_device.h |  29 ++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 257 +++++++++++++++++++++++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  14 ++
 4 files changed, 302 insertions(+), 30 deletions(-)

-- 
2.7.4

