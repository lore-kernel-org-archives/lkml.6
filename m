Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934912AbeCHCfC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:35:02 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5747 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934752AbeCHCe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:34:58 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 00/23] net: hns3: HNS3 bug fixes & code improvements
Date: Thu, 8 Mar 2018 11:06:25 +0800
Message-ID: <1520478408-116992-1-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set introduces various HNS3 bug fixes, optimizations and code
improvements.

Fuyun Liang (4):
  {topost} net: hns3: add existence check when remove old uc mac address
  {topost} net: hns3: fix for netdev not running problem after calling
    net_stop and net_open
  {topost} net: hns3: fix for ipv6 address loss problem after setting
    channels
  {topost} net: hns3: unify the pause params setup function

Peng Li (8):
  {topost} net: hns3: VF should get the real rss_size instead of
    rss_size_max
  {topost} net: hns3: set the cmdq out_vld bit to 0 after used
  {topost} net: hns3: fix endian issue when PF get mbx message flag
  {topost} net: hns3: fix rx path skb->truesize reporting bug
  {topost} net: hns3: Add support for querying pfc puase packets
    statistic
  {topost} net: hns3: fix the queue id for tqp enable&&reset
  {topost} net: hns3: set the max ring num when alloc netdev
  {topost} net: hns3: add support for VF driver inner interface
    hclgevf_ops.get_tqps_and_rss_info

Yunsheng Lin (11):
  {topost} net: hns3: Refactor the hclge_get/set_rss function
  {topost} net: hns3: Refactor the hclge_get/set_rss_tuple function
  {topost} net: hns3: Fix for RSS configuration loss problem during
    reset
  {topost} net: hns3: Fix for pause configuration lost during reset
  {topost} net: hns3: Fix for use-after-free when setting ring parameter
  {topost} net: hns3: Refactor the get/put_vector function
  {topost} net: hns3: Fix for coalesce configuration lost during reset
  {topost} net: hns3: Refactor the coalesce related struct
  {topost} net: hns3: Fix for coal configuation lost when setting the
    channel
  {topost} net: hns3: Fix for loopback failure when vlan filter is
    enable
  {topost} net: hns3: Fix for buffer overflow smatch warning

 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |   2 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   6 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 286 +++++++++++++------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  10 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  42 ++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |  16 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 307 +++++++++++----------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  16 ++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  31 ++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |  76 ++++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |   8 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  95 ++++---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |   1 +
 13 files changed, 574 insertions(+), 322 deletions(-)

-- 
2.9.3
