Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932938AbeCJDAF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 22:00:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6223 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932515AbeCJC5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 21:57:37 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 00/12] fix some bugs for HNS3 driver
Date: Sat, 10 Mar 2018 11:29:21 +0800
Message-ID: <1520652573-75644-1-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes some bugs for HNS3 driver:
[Patch 1/12 - Patch 8/12] fix various bugs for PF driver.
[Patch 9/12 - Patch 12/12] fix issues when change the us mac address of
PF/VF device to an existent one in the mac_vlan table.

Fuyun Liang (4):
  net: hns3: add existence check when remove old uc mac address
  net: hns3: fix for netdev not running problem after calling net_stop
    and net_open
  net: hns3: fix for ipv6 address loss problem after setting channels
  net: hns3: unify the pause params setup function

Jian Shen (4):
  net: hns3: fix error type definition of return value
  net: hns3: fix return value error of hclge_get_mac_vlan_cmd_status()
  net: hns3: add existence checking before adding unicast mac address
  net: hns3: add result checking for VF when modify unicast mac address

Peng Li (2):
  net: hns3: fix rx path skb->truesize reporting bug
  net: hns3: add support for querying pfc puase packets statistic

Yunsheng Lin (2):
  net: hns3: fix for loopback failure when vlan filter is enable
  net: hns3: fix for buffer overflow smatch warning

 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |  2 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  3 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 18 +++--
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 16 +++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c | 14 ++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 59 ++++++++++-------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 23 ++++---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  | 76 ++++++++++++++++++----
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |  8 ++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 75 +++++++++++----------
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |  4 ++
 11 files changed, 205 insertions(+), 93 deletions(-)

-- 
2.9.3
