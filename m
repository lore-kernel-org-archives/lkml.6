Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756312AbeEAS56 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:57:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7639 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754790AbeEAS5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:57:55 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 0/9] Misc bug fixes for HNS3 Ethernet driver
Date: Tue, 1 May 2018 19:55:56 +0100
Message-ID: <20180501185605.9584-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set presents some miscellaneous bug fixs and cleanups for
HNS3 Ethernet Driver.

Fuyun Liang (1):
  net: hns3: Fix to support autoneg only for port attached with phy

Huazhong Tan (5):
  net: hns3: fix to correctly fetch l4 protocol outer header
  net: hns3: Fixes the out of bounds access in hclge_map_tqp
  net: hns3: Fixes the error legs in hclge_init_ae_dev function
  net: hns3: fix for phy_addr error in hclge_mac_mdio_config
  net: hns3: fix a dead loop in hclge_cmd_csq_clean

Xi Wang (1):
  net: hns3: Remove packet statistics in the range of 8192~12287

Yunsheng Lin (2):
  net: hns3: Remove error log when getting pfc stats fails
  net: hns3: Fix for packet loss due wrong filter config in VLAN tbls

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c |  19 +++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 167 ++++++++++++++-------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  20 ++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |   7 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |   7 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |   5 +-
 7 files changed, 153 insertions(+), 74 deletions(-)

-- 
2.7.4
