Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B6DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AC120854
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfBWJX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:23:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4275 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727769AbfBWJXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:23:15 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ADE57F7482E0074081F3;
        Sat, 23 Feb 2019 17:23:07 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sat, 23 Feb 2019 17:22:58 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [Patch net-next 00/12] code optimizations & bugfixes for HNS3 driver
Date:   Sat, 23 Feb 2019 17:22:07 +0800
Message-ID: <1550913739-13232-1-git-send-email-tanhuazhong@huawei.com>
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

Huazhong Tan (1):
  net: hns3: fix improper error handling for hns3_client_start

Jian Shen (2):
  net: hns3: enable VF VLAN filter for each VF when initializing
  net: hns3: fix get VF RSS issue

Peng Li (1):
  net: hns3: add support to config depth for tx|rx ring separately

Shiju Jose (1):
  net: hns3: fix setting of the hns reset_type for rdma hw errors

Yunsheng Lin (7):
  net: hns3: add xps setting support for hns3 driver
  net: hns3: avoid mult + div op in critical data path
  net: hns3: limit some variable scope in critical data path
  net: hns3: remove some ops in struct hns3_nic_ops
  net: hns3: add unlikely for error handling in data path
  net: hns3: replace hnae3_set_bit and hnae3_set_field in data path
  net: hns3: remove hnae3_get_bit in data path

 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |   1 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  10 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 264 +++++++++++----------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   8 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  54 +++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   4 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c |  36 +--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  52 ++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   3 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  53 ++++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  89 ++++++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   3 +-
 12 files changed, 369 insertions(+), 208 deletions(-)

-- 
2.7.4

