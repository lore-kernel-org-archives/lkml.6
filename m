Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F1FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF7D20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF7D20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbeKGNeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 08:34:50 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:14602 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbeKGNeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 08:34:50 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A9DD09B45646F;
        Wed,  7 Nov 2018 12:06:11 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Wed, 7 Nov 2018 12:06:05 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
Subject: [Patch net-next 00/12] provide new interfaces & bugfixes & code optimization
Date:   Wed, 7 Nov 2018 12:06:06 +0800
Message-ID: <1541563578-28973-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset provides some reset interfaces for RAS & RoCE, also
some bugfixes and optimization related to reset.

Huazhong Tan (12):
  net: hns3: use HNS3_NIC_STATE_INITED to indicate the initialization
    state of enet
  net: hns3: add set_default_reset_request in the hnae3_ae_ops
  net: hns3: provide some interface & information for the client
  net: hns3: adjust the location of clearing the table when doing reset
  net: hns3: enable/disable ring in the enet while doing UP/DOWN
  net: hns3: use HNS3_NIC_STATE_RESETTING to indicate resetting
  net: hns3: ignore new coming low-level reset while doing high-level
    reset
  net: hns3: move some reset information from hnae3_handle into
    hclge_dev/hclgevf_dev
  net: hns3: adjust the process of PF reset
  net: hns3: call roce's reset notify callback when resetting
  net: hns3: add error handler for hclge_reset()
  net: hns3: fix for cmd queue memory not freed problem during reset

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  17 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c   |  12 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  91 +++++--
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  21 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  19 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 296 +++++++++++++++++----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   7 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   | 141 +++++-----
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h   |   1 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 109 +++++---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   8 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |   2 +-
 12 files changed, 544 insertions(+), 180 deletions(-)

-- 
2.7.4

