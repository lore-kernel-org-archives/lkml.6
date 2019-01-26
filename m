Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD8EC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7368F214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfAZQuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:50:01 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42308 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726070AbfAZQt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:49:58 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D365C79B32884D046CCF;
        Sun, 27 Jan 2019 00:49:53 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.143.145) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Sun, 27 Jan 2019 00:49:45 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 00/12] code optimizations & bugfixes for HNS3 driver
Date:   Sun, 27 Jan 2019 00:49:09 +0800
Message-ID: <20190126164921.3872-1-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.143.145]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes bugfixes and code optimizations for the HNS3
ethernet controller driver

Jian Shen (6):
  net: hns3: don't update packet statistics for packets dropped by
    hardware
  net: hns3: clear pci private data when unload hns3 driver
  net: hns3: fix return value handle issue for hclge_set_loopback()
  net: hns3: fix broadcast promisc issue for revision 0x20
  net: hns3: add initialization for nic state
  net: hns3: don't allow vf to enable promisc mode

Peng Li (1):
  net: hns3: add 8 BD limit for tx flow

Yunsheng Lin (4):
  net: hns3: add error handling in hclge_ieee_setets
  net: hns3: do reinitialization while mqprio configuration changed
  net: hns3: remove dcb_ops->map_update in hclge_dcb
  net: hns3: call hns3_nic_set_real_num_queue with netdev down

liuzhongzhu (1):
  net: hns3: After setting the loopback, add the status of getting MAC

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  1 -
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 72 +++++++++----------
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  8 +--
 .../hisilicon/hns3/hns3pf/hclge_dcb.c         | 51 ++++++++++---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 36 +++++++++-
 .../hisilicon/hns3/hns3pf/hclge_mbx.c         |  7 +-
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 32 +++++----
 7 files changed, 138 insertions(+), 69 deletions(-)

-- 
2.20.1


