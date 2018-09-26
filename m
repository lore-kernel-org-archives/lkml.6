Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A84C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA42221533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA42221533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbeI0ApE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:45:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43134 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbeI0Anr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:43:47 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AA912567590DA;
        Thu, 27 Sep 2018 02:29:28 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Thu, 27 Sep 2018 02:29:20 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 00/10] Cleanups, minor additions & fixes for HNS3 driver
Date:   Wed, 26 Sep 2018 19:28:30 +0100
Message-ID: <20180926182840.28392-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set contains cleans-ups, minor changes and fixes to the HNS3 driver.

Fuyun Liang (4):
  net: hns3: Set extra mac address of pause param for HW
  net: hns3: Rename loop mode
  net: hns3: Rename mac loopback to app loopback
  net: hns3: Add serdes parallel inner loopback support

Huazhong Tan (3):
  net: hns3: Change return type of hclge_tm_schd_info_update()
  net: hns3: Modify hns3_get_max_available_channels
  net: hns3: Fix loss of coal configuration while doing reset

Peng Li (1):
  net: hns3: Add support for sctp checksum offload

Yunsheng Lin (2):
  net: hns3: Fix for packet buffer setting bug
  net: hns3: Fix for netdev not up problem when setting mtu

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  16 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 101 ++++++++++-----------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   2 +
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  24 +++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |   8 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  94 ++++++++++++-------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |  10 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |   6 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   4 +-
 10 files changed, 157 insertions(+), 109 deletions(-)

-- 
2.7.4


