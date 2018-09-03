Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CC2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FE02077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30FE02077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeICOm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:42:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11625 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727355AbeICOm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:42:27 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9AA7AB2E654E9;
        Mon,  3 Sep 2018 18:22:54 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Mon, 3 Sep 2018 18:22:48 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 00/11] Misc. bug fixes & small enhancements for HNS3 Driver
Date:   Mon, 3 Sep 2018 11:21:45 +0100
Message-ID: <20180903102156.18676-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set presents some fixes and minor enhancements to HNS3 Driver

Huazhong Tan (1):
  net: hns3: Fix for multicast failure

Jian Shen (3):
  net: hns3: Fix error of checking used vlan id
  net: hns3: Remove redundant codes of query advertised flow control
    abilitiy
  net: hns3: Refine hns3_get_link_ksettings()

Yunsheng Lin (7):
  net: hns3: Fix for vf vlan delete failed problem
  net: hns3: Implement shutdown ops in hns3 pci driver
  net: hns3: Fix for loopback selftest failed problem
  net: hns3: Fix ping exited problem when doing lp selftest
  net: hns3: Preserve vlan 0 in hardware table
  net: hns3: Only update mac configuation when necessary
  net: hns3: Change the dst mac addr of loopback packet

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  13 ++
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 102 +++++++---------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 131 ++++++++++++---------
 3 files changed, 132 insertions(+), 114 deletions(-)

-- 
2.7.4


