Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5532EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0880E23F04
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0880E23F04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753648AbeGFK3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:29:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55982 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753449AbeGFK27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:28:59 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 20691F391D849;
        Fri,  6 Jul 2018 18:28:56 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.382.0; Fri, 6 Jul 2018 18:28:46 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 00/10] Misc. bug fixes & cleanups for HNS3 driver
Date:   Fri, 6 Jul 2018 11:27:54 +0100
Message-ID: <20180706102804.196-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set presents some miscellaneous bug fixes and cleanups
for the HNS3 driver.

Fuyun Liang (1):
  net: hns3: Fix for mailbox message truncated problem

Huazhong Tan (1):
  net: hns3: Prevent sending command during global or core reset

Jian Shen (1):
  net: hns3: Add configure for mac minimal frame size

Peng Li (1):
  net: hns3: Remove the warning when clear reset cause

Yunsheng Lin (6):
  net: hns3: Fix tc setup when netdev is first up
  net: hns3: Fix for mac pause not disable in pfc mode
  net: hns3: Fix for waterline not setting correctly
  net: hns3: Fix for l4 checksum offload bug
  net: hns3: Fix warning bug when doing lp selftest
  net: hns3: Fix get_vector ops in hclgevf_main module

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 84 +++++++++-------------
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  2 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c |  4 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  3 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 27 +++----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |  9 ++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 11 ++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |  3 +-
 9 files changed, 70 insertions(+), 74 deletions(-)

-- 
2.7.4


