Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEB7C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 09:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DA721943
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 09:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DA721943
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeHLM0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 08:26:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10702 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727499AbeHLM0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 08:26:00 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6744D975BC59A;
        Sun, 12 Aug 2018 17:48:29 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.93.119) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Sun, 12 Aug 2018 17:48:20 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 0/9] Misc bug fixes & small enhancements for HNS3 Driver
Date:   Sun, 12 Aug 2018 10:47:29 +0100
Message-ID: <20180812094738.14852-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.93.119]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set presents some bug fixes and minor enhancements to
HNS3 Ethernet driver.

Fuyun Liang (1):
  net: hns3: Fix for information of phydev lost problem when down/up

Jian Shen (1):
  net: hns3: Fix for phy link issue when using marvell phy driver

Peng Li (2):
  net: hns3: Add support for serdes loopback selftest
  net: hns3: Add vlan filter setting by ethtool command -K

Xi Wang (1):
  net: hns3: Fix for command format parsing error in
    hclge_is_all_function_id_zero

Yunsheng Lin (4):
  net: hns3: Fix for vf vlan delete failed problem
  net: hns3: Fix desc num set to default when setting channel
  net: hns3: Remove tx ring BD len register in hns3_enet
  net: hns3: Set tx ring' tc info when netdev is up

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  32 +++++-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   7 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  12 +++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 113 +++++++++++++++++----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |  27 ++++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h    |   4 +-
 7 files changed, 171 insertions(+), 26 deletions(-)

-- 
2.11.0


