Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B51AECDFB4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D615D208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D615D208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbeGPQFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:05:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9627 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727653AbeGPQFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:05:22 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0480F1C2C7F33;
        Mon, 16 Jul 2018 23:37:09 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.382.0; Mon, 16 Jul 2018 23:37:01 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 0/9] Bug fixes and some minor changes to HNS3 driver
Date:   Mon, 16 Jul 2018 16:36:18 +0100
Message-ID: <20180716153627.476-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set presents some fixes and minor changes to the HNS3 Ethernet Driver.

Fuyun Liang (2):
  net: hns3: Fix for using wrong mask and shift in
    hclge_get_ring_chain_from_mbx
  net: hns3: Fix comments for hclge_get_ring_chain_from_mbx

Huazhong Tan (6):
  net: hns3: Modify the order of initializing command queue register
  net: hns3: Reset net device with rtnl_lock
  net: hns3: Prevent to request reset frequently
  net: hns3: Correct reset event status register
  net: hns3: Fix return value error in hns3_reset_notify_down_enet
  net: hns3: remove unnecessary ring configuration operation while
    resetting

Yunsheng Lin (1):
  net: hns3: Fix for reset_level default assignment probelm

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c      | 16 ++++++----------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c   |  4 ++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c  | 20 +++++++++++++-------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h  |  1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c   | 14 ++++++++------
 5 files changed, 30 insertions(+), 25 deletions(-)

-- 
2.7.4


