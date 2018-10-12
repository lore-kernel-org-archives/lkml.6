Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB868C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B98020835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B98020835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbeJLWH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:07:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59959 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728616AbeJLWH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:07:28 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5F1CE9632E201;
        Fri, 12 Oct 2018 22:34:38 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Fri, 12 Oct 2018 22:34:32 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 0/3] Fixes & small enhancements related to the promisc mode in HNS3
Date:   Fri, 12 Oct 2018 15:34:03 +0100
Message-ID: <20181012143406.22600-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set presents some fixes and enhancements related to promiscuous
mode and MAC VLAN Table full condition in HNS3 Ethernet Driver.

Jian Shen (3):
  net: hns3: Enable promisc mode when mac vlan table is full
  net: hns3: Resume promisc mode and vlan filter status after reset
  net: hns3: Resume promisc mode and vlan filter status after loopback
    test

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        | 11 +++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 84 +++++++++++++++++++---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  3 +
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 10 ++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  9 ++-
 5 files changed, 103 insertions(+), 14 deletions(-)

-- 
2.7.4


