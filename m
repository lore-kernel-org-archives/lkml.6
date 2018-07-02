Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4340DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21252150F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21252150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932767AbeGBHTU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:19:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9146 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752862AbeGBHTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:19:11 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 682564D852CA;
        Mon,  2 Jul 2018 15:18:57 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.382.0; Mon, 2 Jul 2018 15:18:49 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH V2 net-next 0/9] net: hns3: a few code improvements
Date:   Mon, 2 Jul 2018 15:50:17 +0800
Message-ID: <1530517826-69226-1-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes some redundant code and fixes a few code
stylistic issues from internal concentrated review,
no functional changes introduced.

---
Change log:
V1 -> V2:
1, remove a patch according to the comment reported by David Miller.
---

Huazhong Tan (8):
  net: hns3: remove unused hclge_ring_to_dma_dir
  net: hns3: remove useless code in hclge_cmd_send
  net: hns3: remove some redundant assignments
  net: hns3: simplify hclge_cmd_csq_clean
  net: hns3: remove a redundant hclge_cmd_csq_done
  net: hns3: remove some unused members of some structures
  net: hns3: give default option while dependency HNS3 set
  net: hns3: use dma_zalloc_coherent instead of kzalloc/dma_map_single

Peng Li (1):
  net: hns3: modify hnae_ to hnae3_

 drivers/net/ethernet/hisilicon/Kconfig             |  15 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.c        |  28 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  18 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 244 ++++++++--------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   9 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c |  69 ++---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 317 ++++++++++-----------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  24 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |  38 +--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |   8 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |   7 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   |  26 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  25 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |   2 +-
 14 files changed, 395 insertions(+), 435 deletions(-)

-- 
1.9.1

