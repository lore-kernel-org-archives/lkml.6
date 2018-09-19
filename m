Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DDCC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E792151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E792151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733101AbeISXJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:09:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12205 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727628AbeISXJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:09:58 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EF6B769700C29;
        Thu, 20 Sep 2018 01:30:57 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Thu, 20 Sep 2018 01:30:53 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 00/12] Fixes, cleanups & minor additions to HNS3 driver
Date:   Wed, 19 Sep 2018 18:29:46 +0100
Message-ID: <20180919172958.12992-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set present some fixes, cleanups to the HNS£ PF and VF driver.

Fuyun Liang (2):
  net: hns3: Set STATE_DOWN bit of hdev state when stopping net
  net: hns3: Fix for setting speed for phy failed problem

Jian Shen (4):
  net: hns3: Fix cmdq registers initialization issue for vf
  net: hns3: Clear client pointer when initialize client failed or
    unintialize finished
  net: hns3: Fix client initialize state issue when roce client
    initialize failed
  net: hns3: Fix parameter type for q_id in hclge_tm_q_to_qs_map_cfg()

Peng Li (5):
  net: hns3: Add default irq affinity
  net: hns3: Add unlikely for buf_num check
  net: hns3: Remove tx budget to clean more TX descriptors in a napi
  net: hns3: Remove packet statistics of public
  net: hns3: Check hdev state when getting link status

Xi Wang (1):
  net: hns3: Add support for hns3_nic_netdev_ops.ndo_do_ioctl

 drivers/net/ethernet/hisilicon/hns3/hnae3.c        |  12 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   5 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  83 ++++-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   4 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 367 +++------------------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    | 105 ------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |   2 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   |   4 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  47 ++-
 10 files changed, 171 insertions(+), 460 deletions(-)

-- 
2.7.4


