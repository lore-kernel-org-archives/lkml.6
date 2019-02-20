Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D51AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB2821773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfBTCdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:33:49 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727424AbfBTCdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:33:39 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E51FB1AE30134FF65857;
        Wed, 20 Feb 2019 10:33:36 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Wed, 20 Feb 2019 10:33:28 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [Patch net-next 00/12] code optimizations & bugfixes for HNS3 driver
Date:   Wed, 20 Feb 2019 10:32:39 +0800
Message-ID: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes bugfixes and code optimizations for
the HNS3 ethernet controller driver.

Huazhong Tan (2):
  net: hns3: uninitialize command queue while unloading PF driver
  net: hns3: clear command queue's registers when unloading VF driver

Jian Shen (2):
  net: hns3: convert mac advertize and supported from u32 to link mode
  net: hns3: fix port info query issue for copper port

Weihang Li (4):
  net: hns3: modify print message of ssu common ecc errors
  net: hns3: some bugfix of ppu(rcb) ras errors
  net: hns3: enable 8~11th bit of mac common msi-x error
  net: hns3: fix 6th bit of ppp mpf abnormal errors

Yonglong Liu (2):
  net: hns3: add pointer checking at the beginning of the exported
    functions.
  net: hns3: Check variable is valid before assigning it to another

liuzhongzhu (2):
  net: hns3: Record VF unicast and multicast tables
  net: hns3: Record VF vlan tables

 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |   2 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.c        |  37 ++-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   9 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c |  26 +++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c |  69 +++++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h |   5 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 248 +++++++++++++++++++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  40 ++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  32 ++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |  17 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   |  20 ++
 12 files changed, 451 insertions(+), 56 deletions(-)

-- 
2.7.4

