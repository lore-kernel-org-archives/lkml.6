Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F24C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775DD2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775DD2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeJKC3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:29:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13643 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727101AbeJKC3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:29:45 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3A9E8377C0D0E;
        Thu, 11 Oct 2018 03:06:13 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.399.0; Thu, 11 Oct 2018 03:06:05 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 0/4] Adds support of RSS to HNS3 Driver for Rev 2(=0x21) H/W
Date:   Wed, 10 Oct 2018 20:05:33 +0100
Message-ID: <20181010190537.20972-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set mainly adds new additions related to RSS for the new
hardware Revision 0x21. It also adds support to use RSS hash value
provided by the hardware along with descriptor.

Jian Shen (3):
  net: hns3: Add new RSS hash algorithm support for PF
  net: hns3: Add RSS general configuration support for VF
  net: hns3: Add RSS tuples support for VF

Peng Li (1):
  net: hns3: Add HW RSS hash information to RX skb

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  17 +
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  10 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  49 ++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h   |   8 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 366 ++++++++++++++++++---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  19 ++
 7 files changed, 406 insertions(+), 64 deletions(-)

-- 
2.7.4


