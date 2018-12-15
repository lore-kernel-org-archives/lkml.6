Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61F1C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6571206C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbeLOPcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 10:32:50 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16571 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730182AbeLOPcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 10:32:50 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 97A1AD3B3474D;
        Sat, 15 Dec 2018 23:32:43 +0800 (CST)
Received: from S00293818-DELL1.home (10.47.95.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sat, 15 Dec 2018 23:32:34 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V2 net-next 0/6] net: hns3: Add more commands to Debugfs in HNS3 driver
Date:   Sat, 15 Dec 2018 15:31:52 +0000
Message-ID: <20181215153158.1239-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.95.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set adds few more debugfs commands to HNS3 Ethernet
Driver. Support has been added to query info related to below
items:
1. Packet buffer descriptor ("echo bd info [queue no] [bd index] > cmd")
2. Manager table("echo dump mng tbl > cmd")
3. Dfx status register("echo dump reg ssu [prt id] > cmd")
4. Dcb status register("echo dump reg dcb [port id] > cmd")
5. Queue map ("echo queue map [queue no] > cmd")
6. Tm map ("echo tm map [queue no] > cmd")

NOTE: Above commands are *read-only* and are only intended to
query the information from the SoC(and dump inside the kernel,
for now) and in no way tries to perform write operations for
the purpose of configuration etc.

Change Log:
V1-->V2:
1. Addressed the GCC-8.2 compiler issue reported by David S. Miller.
   Link: https://lkml.org/lkml/2018/12/14/1298

liuzhongzhu (6):
  net: hns3: Add "bd info" query function
  net: hns3: Add "manager table" information query function
  net: hns3: Add "status register" information query function
  net: hns3: Add "dcb register" status information query function
  net: hns3: Add "queue map" information query function
  net: hns3: Add "tm map" status information query function

 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |   1 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 140 ++++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  43 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 446 +++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h | 690 +++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   4 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  20 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |   7 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  18 +
 11 files changed, 1366 insertions(+), 5 deletions(-)

-- 
2.11.0


