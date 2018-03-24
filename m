Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeCXDBP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 23:01:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6699 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752069AbeCXDBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 23:01:13 -0400
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 0/5] fix some bugs for HNS3
Date: Sat, 24 Mar 2018 11:32:42 +0800
Message-ID: <1521862367-111399-1-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes some bugs for HNS3 driver:
[Patch 1/5 - 2/5] fix 2 return vlaue issues.
[Patch 3/5 - 4/5] fix 2 comments reported by code review.
[Ptach 5/5] avoid sending message to IMP because IMP will not
handle any message when it is resetting.

Fuyun Liang (4):
  net: hns3: fix for returning wrong value problem in
    hns3_get_rss_key_size
  net: hns3: fix for returning wrong value problem in
    hns3_get_rss_indir_size
  net: hns3: fix for the wrong shift problem in hns3_set_txbd_baseinfo
  net: hns3: fix for not initializing VF rss_hash_key problem

Peng Li (1):
  net: hns3: never send command queue message to IMP when reset

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  4 ++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 27 ++++++++++++++++------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |  6 +++++
 4 files changed, 29 insertions(+), 10 deletions(-)

-- 
2.9.3
