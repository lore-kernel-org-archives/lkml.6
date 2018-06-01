Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753149AbeFAQxt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:53:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8623 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751693AbeFAQxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:53:47 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 00/11] Misc. bug fixes & optimizations for HNS3 driver
Date: Fri, 1 Jun 2018 17:52:00 +0100
Message-ID: <20180601165211.46372-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set presents some bug fixes found out during the internal
review and system testing and some small optimizations.

Jian Shen (2):
  net: hns3: Add repeat address checking for setting mac address
  net: hns3: Fix setting mac address error

Peng Li (1):
  net: hns3: Add support for IFF_ALLMULTI flag

Xi Wang (2):
  net: hns3: Optimize the PF's process of updating multicast MAC
  net: hns3: Optimize the VF's process of updating multicast MAC

Yunsheng Lin (6):
  net: hns3: Disable vf vlan filter when vf vlan table is full
  net: hns3: Fix for service_task not running problem after resetting
  net: hns3: Fix for hclge_reset running repeatly problem
  net: hns3: Fix for phy not link up problem after resetting
  net: hns3: Add missing break in misc_irq_handle
  net: hns3: Fix for vxlan tx checksum bug

 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |   2 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   4 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  60 +++++-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 205 +++++++++++++++++----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  12 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  63 ++++++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 140 +++++++++++++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   4 +
 9 files changed, 441 insertions(+), 51 deletions(-)

-- 
2.7.4
