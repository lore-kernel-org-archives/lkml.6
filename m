Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A94ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A75F21486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A75F21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeJTDYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:24:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14095 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727682AbeJTDY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:24:29 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6093F350689D1;
        Sat, 20 Oct 2018 03:17:02 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Sat, 20 Oct 2018 03:16:55 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 0/7] Adds support of RAS Error Handling in HNS3 Driver
Date:   Fri, 19 Oct 2018 20:15:25 +0100
Message-ID: <20181019191532.10088-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set adds support related to RAS Error handling to the HNS3
Ethernet PF Driver. Set of errors occurred in the HNS3 hardware are
reported to the driver through the PCIe AER interface. The received
error information is then used to classify the received errors and
then decide the appropriate receovery action depending on the type
of error.


Shiju Jose (7):
  net: hns3: Add PCIe AER callback error_detected
  net: hns3: Add PCIe AER error recovery
  net: hns3: Add support to enable and disable hw errors
  net: hns3: Add enable and process common ecc errors
  net: hns3: Add enable and process hw errors from IGU, EGU and NCSI
  net: hns3: Add enable and process hw errors from PPP
  net: hns3: Add enable and process hw errors of TM scheduler

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |    3 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   50 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/Makefile    |    2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   22 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 1088 ++++++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h |   83 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   33 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |    3 +-
 8 files changed, 1276 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h

-- 
2.7.4


