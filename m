Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC368C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 03:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8501321741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 03:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbeLTDQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 22:16:31 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:59703 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729023AbeLTDQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 22:16:24 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E9D0B8B675C62;
        Thu, 20 Dec 2018 11:16:19 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Dec 2018 11:16:14 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 0/9] net: hns3: code optimizations & bugfixes for HNS3 driver
Date:   Thu, 20 Dec 2018 11:51:57 +0800
Message-ID: <1545277926-66432-1-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes bugfixes and code optimizations for the HNS3
ethernet controller driver

Huazhong Tan (1):
  net: hns3: reset tqp while doing DOWN operation

Jian Shen (5):
  net: hns3: refine the handle for hns3_nic_net_open/stop()
  net: hns3: change default tc state to close
  net: hns3: add max vector number check for pf
  net: hns3: fix vf id check issue when add flow director rule
  net: hns3: don't restore rules when flow director is disabled

Peng Li (3):
  net: hns3: fix a bug caused by udelay
  net: hns3: fix the descriptor index when get rss type
  net: hns3: remove redundant variable initialization

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 21 +++++++++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 46 +++++++++++++++-------
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 24 ++++++++---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |  4 +-
 5 files changed, 73 insertions(+), 23 deletions(-)

-- 
1.9.1

