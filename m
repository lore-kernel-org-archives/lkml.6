Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA1CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C60620811
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C60620811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbeKMULm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:11:42 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15095 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731878AbeKMULm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:11:42 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2593A748953AF;
        Tue, 13 Nov 2018 18:14:15 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.86.21) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Tue, 13 Nov 2018 18:14:07 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH net-next 0/5] net: hns3: Add support of hardware GRO to HNS3 Driver
Date:   Tue, 13 Nov 2018 10:13:02 +0000
Message-ID: <20181113101307.6020-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.86.21]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set adds support of hardware assisted GRO feature to
HNS3 driver on Rev B(=0x21) platform. Current hardware only
supports TCP/IPv{4|6} flows.

Peng Li (5):
  net: hns3: Enable HW GRO for Rev B(=0x21) HNS3 hardware
  net: hns3: Add handling of GRO Pkts not fully RX'ed in NAPI poll
  net: hns3: Add support for ethtool -K to enable/disable HW GRO
  net: hns3: Add skb chain when num of RX buf exceeds MAX_SKB_FRAGS
  net: hns3: Adds GRO params to SKB for the stack

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   7 +
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 289 ++++++++++++++----
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  17 +-
 .../hisilicon/hns3/hns3pf/hclge_cmd.h         |   7 +
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  45 +++
 .../hisilicon/hns3/hns3vf/hclgevf_cmd.h       |   8 +
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  45 +++
 7 files changed, 351 insertions(+), 67 deletions(-)

-- 
2.17.1


