Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEF8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933922087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfARIPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:15:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2258 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727279AbfARINw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:13:52 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 98678C64177C6DCF0FD4;
        Fri, 18 Jan 2019 16:13:49 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 18 Jan 2019 16:13:40 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 00/12] net: hns3: code optimizations & bugfixes for HNS3 driver
Date:   Fri, 18 Jan 2019 16:13:02 +0800
Message-ID: <1547799194-38212-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes bugfixes and code optimizations for the HNS3
ethernet controller driver

Huazhong Tan (11):
  net: hns3: modify enet reinitialization interface
  net: hns3: remove unused member in struct hns3_enet_ring
  net: hns3: remove unnecessary hns3_adjust_tqps_num
  net: hns3: reuse reinitialization interface in the hns3_set_channels
  net: hns3: add interface hclge_tm_bp_setup
  net: hns3: modify parameter checks in the hns3_set_channels
  net: hns3: remove redundant codes in hclge_knic_setup
  net: hns3: fix user configuration loss for ethtool -L
  net: hns3: adjust the use of alloc_tqps and num_tqps
  net: hns3: fix wrong combined count returned by ethtool -l
  net: hns3: do reinitialization while ETS configuration changed

Yunsheng Lin (1):
  net: hns3: add HNAE3_RESTORE_CLIENT interface in enet module

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   2 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 180 ++++++++-------------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   1 -
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |  17 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  96 ++++-------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   2 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |  65 ++++++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |   1 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   2 +-
 9 files changed, 166 insertions(+), 200 deletions(-)

-- 
2.7.4

