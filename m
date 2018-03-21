Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbeCUHSc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:18:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6668 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751533AbeCUHST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:18:19 -0400
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 00/11] fix some bugs for HNS3 driver
Date: Wed, 21 Mar 2018 15:49:19 +0800
Message-ID: <1521618570-129694-1-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes some bugs for HNS3 driver:
[Patch 1/11 - 5/11] fix various bugs reported by hisilicon test team.
[Patch 6/11 - 7/11] fix bugs about interrupt coalescing self-adaptive
function.
[Patch 8/11 - 11/11] fix bugs about ethtool_ops.get_link_ksettings.

Fuyun Liang (7):
  net: hns3: reallocate tx/rx buffer after changing mtu
  net: hns3: change GL update rate
  net: hns3: change the time interval of int_gl calculating
  net: hns3: fix for getting wrong link mode problem
  net: hns3: add get_link support to VF
  net: hns3: add querying speed and duplex support to VF
  net: hns3: fix for not returning problem in get_link_ksettings when
    phy exists

Peng Li (2):
  net: hns3: fix the VF queue reset flow error
  net: hns3: increase the max time for IMP handle command

Yunsheng Lin (2):
  net: hns3: fix for vlan table lost problem when resetting
  net: hns3: export pci table of hclge and hclgevf to userspace

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   4 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  80 ++++++++---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   6 +
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 107 +++-----------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   4 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 158 +++++++++++++++++++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  10 ++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  19 ++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h   |   2 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  42 +++++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   4 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |   5 +
 12 files changed, 309 insertions(+), 132 deletions(-)

-- 
2.9.3
