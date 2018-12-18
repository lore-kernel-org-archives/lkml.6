Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A70C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8CF2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbeLRLCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:02:07 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38134 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726592AbeLRLCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:02:06 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CF65DC12AFA74;
        Tue, 18 Dec 2018 19:02:03 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Tue, 18 Dec 2018 19:01:56 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 00/12] net: hns3: code optimizations & bugfixes for HNS3 driver
Date:   Tue, 18 Dec 2018 19:37:47 +0800
Message-ID: <1545133079-79605-1-git-send-email-lipeng321@huawei.com>
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

Fuyun Liang (1):
  net: hns3: remove 1000M/half support of phy

Huazhong Tan (6):
  net: hns3: fix error handling int the hns3_get_vector_ring_chain
  net: hns3: uninitialize pci in the hclgevf_uninit
  net: hns3: fix napi_disable not return problem
  net: hns3: update some variables while hclge_reset()/hclgevf_reset()
    done
  net: hns3: remove unnecessary configuration recapture while resetting
  net: hns3: fix incomplete uninitialization of IRQ in the
    hns3_nic_uninit_vector_data()

Peng Li (2):
  net: hns3: update coalesce param per second
  net: hns3: synchronize speed and duplex from phy when phy link up

Yunsheng Lin (3):
  net: hns3: getting tx and dv buffer size through firmware
  net: hns3: aligning buffer size in SSU to 256 bytes
  net: hns3: fix a SSU buffer checking bug

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 29 ++++---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  4 -
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  5 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 95 +++++++++++++---------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  3 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |  6 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  5 +-
 7 files changed, 88 insertions(+), 59 deletions(-)

-- 
1.9.1

