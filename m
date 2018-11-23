Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADFAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2691620863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2691620863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440044AbeKXBWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:22:14 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46505 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388198AbeKXBWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:22:14 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E7530DDE0EE3A;
        Fri, 23 Nov 2018 22:37:39 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 23 Nov 2018 22:37:35 +0800
From:   "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <xavier.huwei@huawei.com>,
        <lijun_nudt@163.com>, <oulijun@huawei.com>,
        <charles.chenxin@huawei.com>, <liuyixian@huawei.com>,
        <zhangxiping3@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <xavier_huwei@163.com>
Subject: [PATCH rdma-next 0/3] RDMA/hns: Updates for reset process of roce device in hip08
Date:   Fri, 23 Nov 2018 23:14:22 +0800
Message-ID: <1542986065-44265-1-git-send-email-xavier.huwei@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Doug and Janson

This series mainly include updates for reset process of roce device
in hip08.
One patch adds support for reset and loading or unloading driver occur
simultaneously to ensure work normally, one stops sending mailbox&cmq&
doorbell when reset occured or reset is occuring, the last one modifies
the name of hns RoCE device's name in order to ensure that the name is
consistent before and after reset.

This series relies on the the new interfaces in hns NIC driver those
had been accepted by David, the related commit as below:
https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git 
commit cb7ea80c6dfda472a068d40f4f9755d034b2dfde

Best Regards
Xavier


Wei Hu (Xavier) (3):
  RDMA/hns: Add support for reset and loading or unloading driver occur
    simultaneously
  RDMA/hns: Stop sending mailbox&cmq&doorbell when reset occured or is
    occuring
  RDMA/hns: Modify hns RoCE device's name

 drivers/infiniband/hw/hns/hns_roce_cmd.c    |  32 ++-
 drivers/infiniband/hw/hns/hns_roce_device.h |  30 +++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 323 ++++++++++++++++++++++++++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  21 ++
 drivers/infiniband/hw/hns/hns_roce_main.c   |   4 +-
 5 files changed, 382 insertions(+), 28 deletions(-)

-- 
1.9.1

