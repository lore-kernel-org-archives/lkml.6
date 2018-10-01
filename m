Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D17C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9618C2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9618C2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbeJASZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:25:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729220AbeJASZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:25:45 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 825ABAF74FC58;
        Mon,  1 Oct 2018 19:48:16 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Mon, 1 Oct 2018 19:48:09 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 0/7] Support of Flow Director in HNS3 Ethernet Driver for HiP08 Rev2 SoC
Date:   Mon, 1 Oct 2018 12:46:40 +0100
Message-ID: <20181001114647.15504-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set adds the support of FD(Flow Director) in the HNS3 PF driver
for HiP08 Rev2(0x21) SoC of Hisilicon. FD can be used in filtering the flows
and deciding to drop the flow or forward it to paricular queue.

Configuration consists of rules with input keys and actions. The rules are
stored in TCAM.

Jian Shen (7):
  net: hns3: Add flow director initialization
  net: hns3: Add input key and action config support for flow director
  net: hns3: Add support for rule add/delete for flow director
  net: hns3: Add support for rule query of flow director
  net: hns3: Add reset handle for flow director
  net: hns3: Remove all flow director rules when unload hns3 driver
  net: hns3: Add support for enable/disable flow director

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   19 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   55 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |    5 +
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   39 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   77 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 1303 ++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  232 ++++
 7 files changed, 1721 insertions(+), 9 deletions(-)

-- 
2.7.4


