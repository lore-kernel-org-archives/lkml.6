Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88F4C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9F920673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9F920673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbeGSPbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:31:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730521AbeGSPbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:31:46 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 78BDE6FA97AB0;
        Thu, 19 Jul 2018 22:47:49 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Thu, 19 Jul 2018 22:47:40 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 0/9] Misc. cleanups for HNS3 ethernet driver
Date:   Thu, 19 Jul 2018 15:46:57 +0100
Message-ID: <20180719144706.644-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set presents some cleanups for HNS3 Ethernet Driver.

Jian Shen (9):
  net: hns3: Remove some redundant assignments
  net: hns3: Standardize the handle of return value
  net: hns3: Remove extra space and brackets
  net: hns3: Correct unreasonable code comments
  net: hns3: Use decimal for bit offset macros
  net: hns3: Modify inconsistent bit mask macros
  net: hns3: Fix misleading parameter name
  net: hns3: Remove unused struct member and definition
  net: hns3: Add SPDX tags to HNS3 PF driver

 drivers/net/ethernet/hisilicon/hns3/hnae3.c        |  10 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  10 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c   |  10 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  14 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  10 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  10 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c |  14 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h | 103 ++++++--------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |  10 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.h |  10 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 150 +++++++--------------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  42 +++---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |  10 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h    |  10 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |  10 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |  10 +-
 16 files changed, 136 insertions(+), 297 deletions(-)

-- 
2.7.4


