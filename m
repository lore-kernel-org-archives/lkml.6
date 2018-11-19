Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4023BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC652086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC652086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbeKTHpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:45:52 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15120 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730209AbeKTHpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:45:52 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1BFA8564ABB7;
        Tue, 20 Nov 2018 05:20:19 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.88.214) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Tue, 20 Nov 2018 05:20:10 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 0/8] net: hns3: Adds support of debugfs to HNS3 driver
Date:   Mon, 19 Nov 2018 21:18:37 +0000
Message-ID: <20181119211845.23168-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.88.214]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support of debugfs to the HNS3 driver. 

Support has been added to query info related to below items:
1. Queue related
2. Flow Director
3. TC config
4. Transmit Module/Scheduler
5. QoS pause
6. QoS buffer
7. QoS prio map

liuzhongzhu (8):
  net: hns3: Add debugfs framework registration
  net: hns3: Add "queue info" query function
  net: hns3: Add "FD flow table" info query function
  net: hns3: Add "tc config" info query function
  net: hns3: Add "tm config" info query function
  net: hns3: Add pause config info query function
  net: hns3: Add "qos prio map" info query function
  net: hns3: Add "qos buffer" config info query function

 drivers/net/ethernet/hisilicon/hns3/Makefile  |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   2 +
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 265 ++++++++++
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  17 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |   4 +
 .../ethernet/hisilicon/hns3/hns3pf/Makefile   |   2 +-
 .../hisilicon/hns3/hns3pf/hclge_cmd.h         |   1 +
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 487 ++++++++++++++++++
 .../hisilicon/hns3/hns3pf/hclge_debugfs.h     |  23 +
 .../hisilicon/hns3/hns3pf/hclge_main.c        |   1 +
 .../hisilicon/hns3/hns3pf/hclge_main.h        |   1 +
 .../hisilicon/hns3/hns3pf/hclge_main.h.rej    |  12 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.h |   6 +
 13 files changed, 819 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h.rej

-- 
2.17.1


