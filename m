Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967980AbeEYSow (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:44:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967598AbeEYSoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:44:44 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 00/12] Misc. bug fixes & some minor additions to HNS3 driver
Date: Fri, 25 May 2018 19:42:55 +0100
Message-ID: <20180525184307.36288-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set provides some bug fixes figured out during testing
and review. It also provides some additions due to running of the
existing code on the new revision of the HNS3 hardware.

Fuyun Liang (3):
  net: hns3: Fixes the init of the VALID BD info in the descriptor
  net: hns3: Removes unnecessary check when clearing TX/RX rings
  net: hns3: Clear TX/RX rings when stopping port & un-initializing
    client

Jian Shen (2):
  net: hns3: Remove unused led control code
  net: hns3: Adds support for led locate command for copper port

Lijun Ou (1):
  net: hns3: Fixes initalization of RoCE handle and makes it conditional

Peng Li (5):
  net: hns3: Updates RX packet info fetch in case of multi BD
  net: hns3: Add support for tx_accept_tag2 and tx_accept_untag2 config
  net: hns3: Add STRP_TAGP field support for hardware revision 0x21
  net: hns3: Add support to enable TX/RX promisc mode for H/W rev(0x21)
  net: hns3: Fixes the state to indicate client-type initialization

Xi Wang (1):
  net: hns3: Fix for PF mailbox receving unknown message

 drivers/net/ethernet/hisilicon/hns3/hnae3.c        |  49 +++++-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   4 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 189 +++++++++++++++++----
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   4 +
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   4 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  22 +--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 179 ++++---------------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   8 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  23 ++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   8 +-
 10 files changed, 283 insertions(+), 207 deletions(-)

-- 
2.7.4
