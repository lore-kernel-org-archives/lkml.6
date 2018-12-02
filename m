Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FA9C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97F920834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97F920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbeLBXLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:11:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51995 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbeLBXLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 18:11:12 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1976E5E84B35F;
        Mon,  3 Dec 2018 07:11:08 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.90.156) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Mon, 3 Dec 2018 07:11:01 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [RFC net-next 0/9] net: hns3: Add more commands to Debugfs in HNS3 driver
Date:   Sun, 2 Dec 2018 23:09:24 +0000
Message-ID: <20181202230933.15560-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.90.156]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set adds few more debugfs commands to HNS3 Ethernet
Driver. Support has been added to query info related to below
items:
1. Packet buffer descriptor ("echo bd info [queue no] [bd index] > cmd")
2. Mac Forward table("echo dump mac tbl > cmd")
3. Port vlan Forward table("echo dump port vlan tbl > cmd")
4. Vf vlan Forward table("echo dump vf vlan tbl [vf id]> cmd")
5. Manager table("echo dump mng tbl > cmd")
6. Dfx status register("echo dump reg ssu [prt id] > cmd")
7. Dcb status register("echo dump reg dcb [port id] > cmd")
8. Queue map ("echo queue map [queue no] > cmd")
9. Tm map ("echo tm map [queue no] > cmd")

NOTE: Above commands are *read-only* and are only intended to
query the information from the SoC(and dump inside the kernel,
for now) and in no way tries to perform write operations for
the purpose of configuration etc.

As per the earlier community review, it was understood that any
attempt to add commands for which standard tools are present is
discouraged. Any review comments and suggestions related to above
set of commands would be of great help in preapring the final
patch-set. Thank you!


liuzhongzhu (9):
  net: hns3: Add "bd info" query function
  net: hns3: Add "mac table" information query function
  net: hns3: Add "port vlan table" information query function
  net: hns3: Add "vf vlan table" information query function
  net: hns3: Add "manager table" information query function
  net: hns3: Add "status register" information query function
  net: hns3: Add "dcb register" status information query function
  net: hns3: Add "queue map" information query function
  net: hns3: Add "tm map" status information query function

 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |   1 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 139 +++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  58 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 744 +++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h | 706 +++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   4 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  20 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |   7 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  18 +
 11 files changed, 1696 insertions(+), 3 deletions(-)

-- 
2.11.0


