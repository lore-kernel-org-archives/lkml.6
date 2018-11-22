Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65599C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4062081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4062081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391657AbeKWAuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:50:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52175 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729224AbeKWAuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:50:35 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 24FE8F9E1AF31;
        Thu, 22 Nov 2018 22:10:59 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Thu, 22 Nov 2018 22:10:53 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V2 net-next 0/8] net: hns3: Adds support of debugfs to HNS3 driver
Date:   Thu, 22 Nov 2018 14:09:40 +0000
Message-ID: <20181122140948.23504-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support of debugfs to the HNS3 driver. 

Support has been added to query info related to below items:
1. Queue related ("echo queue info [queue no] > cmd")
2. Flow Director ("echo dump fd tcam > cmd")
3. TC config ("echo dump tc > cmd")
4. Transmit Module/Scheduler ("echo dump tm > cmd")
5. QoS pause ("echo dump qos pause cfg > cmd")
6. QoS buffer ("echo dump qos pri map > cmd")
7. QoS prio map ("echo dump qos buf cfg > cmd")

NOTE: Above commands are *read-only* and are only intended to
query the information from the SoC(and dump inside the kernel,
for now) and in no way tries to perform write operations for
the purpose of configuration etc.

Change Log
----------
V1-->V2:
   * Addressed the comments provided by Jakub Kicinski. 
     1. Removed the .rej files mistakenly made part of Flow Director patch.
        Link: https://lkml.org/lkml/2018/11/20/249
     2. Added command summary in the cover letter
        Link: https://lkml.org/lkml/2018/11/22/1 

liuzhongzhu (8):
  net: hns3: Add debugfs framework registration
  net: hns3: Add "queue info" query function
  net: hns3: Add "FD flow table" info query function
  net: hns3: Add "tc config" info query function
  net: hns3: Add "tm config" info query function
  net: hns3: Add "qos pause" config info query function
  net: hns3: Add "qos prio map" info query function
  net: hns3: Add "qos buffer" config info query function

 drivers/net/ethernet/hisilicon/hns3/Makefile       |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   2 +
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 265 +++++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  17 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   4 +
 .../net/ethernet/hisilicon/hns3/hns3pf/Makefile    |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 487 +++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h |  23 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |   6 +
 12 files changed, 807 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h

-- 
2.7.4


