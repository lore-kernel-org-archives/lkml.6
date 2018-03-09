Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeCICFF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:05:05 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38053 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750898AbeCICFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:05:02 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 0/9] fixes for configuration lost problems
Date: Fri, 9 Mar 2018 10:36:55 +0800
Message-ID: <1520563024-94811-1-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset refactors some functions and some bugs in order
to fix the configuration loss problem when resetting and
setting channel number.

Yunsheng Lin (9):
  net: hns3: refactor the hclge_get/set_rss function
  net: hns3: refactor the hclge_get/set_rss_tuple function
  net: hns3: fix for RSS configuration loss problem during reset
  net: hns3: fix for pause configuration lost during reset
  net: hns3: fix for use-after-free when setting ring parameter
  net: hns3: refactor the get/put_vector function
  net: hns3: fix for coalesce configuration lost during reset
  net: hns3: refactor the coalesce related struct
  net: hns3: fix for coal configuation lost when setting the channel

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   3 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 249 +++++++++++++++------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  10 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  26 ++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |   2 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 235 +++++++++----------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  16 ++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  12 +-
 8 files changed, 351 insertions(+), 202 deletions(-)

-- 
2.9.3
