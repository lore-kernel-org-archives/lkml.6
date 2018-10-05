Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0941C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A92208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A92208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeJFAEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:04:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728021AbeJFAEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:04:09 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 197D76571AF4C;
        Sat,  6 Oct 2018 01:04:29 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Sat, 6 Oct 2018 01:04:22 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 0/6] Fixes, minor changes & cleanups for the Unicast MAC VLAN table
Date:   Fri, 5 Oct 2018 18:03:23 +0100
Message-ID: <20181005170329.6512-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set presents necessary modifications, fixes & cleanups related
to Unicast MAC Vlan Table to support revision 0x21 hardware.

Jian Shen (5):
  net: hns3: Remove the default mask configuration for mac vlan table
  net: hns3: Clear mac vlan table entries when unload driver or function
    reset
  net: hns3: Optimize for unicast mac vlan table
  net: hns3: Drop depricated mta table support
  net: hns3: Fix for rx vlan id handle to support Rev 0x21 hardware

Zhongzhu Liu (1):
  net: hns3: Add egress/ingress vlan filter for revision 0x21

 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |   3 -
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   2 -
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  78 ++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  47 +--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 446 +++++++++------------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  40 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  58 ---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 129 ------
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   5 -
 9 files changed, 250 insertions(+), 558 deletions(-)

-- 
2.7.4


