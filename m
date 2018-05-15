Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752963AbeEOSVH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:21:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59419 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752304AbeEOSVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:21:06 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 00/10] Misc. Bug Fixes and clean-ups for HNS3 Driver
Date: Tue, 15 May 2018 19:20:04 +0100
Message-ID: <20180515182014.42196-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set mainly introduces various bug fixes, cleanups and one
very small enhancement to existing HN3 driver code.

Fuyun Liang (7):
  net: hns3: Fix for deadlock problem occurring when unregistering
    ae_algo
  net: hns3: Fix for the null pointer problem occurring when
    initializing ae_dev failed
  net: hns3: Add a check for client instance init state
  net: hns3: Change return type of hnae3_register_ae_dev
  net: hns3: Change return type of hnae3_register_ae_algo
  net: hns3: Change return value in hnae3_register_client
  net: hns3: Fixes the missing PCI iounmap for various legs

Peng Li (1):
  net: hns3: Add support of .sriov_configure in HNS3 driver

Yunsheng Lin (2):
  net: hns3: Fixes the back pressure setting When sriov is enabled
  net: hns3: Fix for fiber link up problem

 drivers/net/ethernet/hisilicon/hns3/hnae3.c        | 44 ++++++------
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  5 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 78 +++++++++++++++++++++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 55 +++------------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  | 45 +++++++++++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |  5 ++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 10 +--
 7 files changed, 164 insertions(+), 78 deletions(-)

-- 
2.7.4
