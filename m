Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0D8ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A8B215E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A8B215E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390405AbeIUVcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:32:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389547AbeIUVcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:32:17 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 115F03CE649C3;
        Fri, 21 Sep 2018 23:42:48 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Fri, 21 Sep 2018 23:42:39 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 00/12] Bug fixes, snall modifications & cleanup for HNS3 driver
Date:   Fri, 21 Sep 2018 16:41:36 +0100
Message-ID: <20180921154148.26756-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch presents some bug fixes, small modifications and cleanups
to the HNS3 VF and PF driver.

Fuyun Liang (1):
  net: hns3: Fix speed/duplex information loss problem when executing
    ethtool ethx cmd of VF

Jian Shen (9):
  net: hns3: Fix ets validate issue
  net: hns3: Unify the type convert for desc.data
  net: hns3: Adjust prefix of tx/rx statistic names
  net: hns3: Fix tqp array traversal condition for vf
  net: hns3: Unify the prefix of vf functions
  net: hns3: Add handle for default case
  net: hns3: Add nic state check before calling netif_tx_wake_queue
  net: hns3: Add unlikely for dma_mapping_error check
  net: hns3: Remove print messages for error packet

Peng Li (2):
  net: hns3: Add get_media_type ops support for VF
  net: hns3: Remove redundant hclge_get_port_type()

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 13 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 83 +++++++++++++---------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |  6 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 36 +++-------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |  6 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   |  8 +--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 72 +++++++++++--------
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  1 +
 9 files changed, 120 insertions(+), 107 deletions(-)

-- 
2.7.4


