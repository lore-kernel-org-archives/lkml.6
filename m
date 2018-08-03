Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BDEC46463
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F7C2174B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F7C2174B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbeHCLwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:52:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732327AbeHCLwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:52:34 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ACFE485E3E5B7;
        Fri,  3 Aug 2018 17:56:56 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.399.0; Fri, 3 Aug 2018 17:56:48 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 0/2] Some important fixes for HNS3 driver
Date:   Fri, 3 Aug 2018 10:56:29 +0100
Message-ID: <20180803095631.798-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch presents some important fixes related to MSIX allocation
in HNS3 driver.

Jian Shen (2):
  net: hns3: Fix MSIX allocation issue for VF
  net: hns3: Refine the MSIX allocation for PF

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  3 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  2 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  8 ++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  3 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h   | 14 ++++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 80 ++++++++++++++++++----
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  4 +-
 7 files changed, 94 insertions(+), 20 deletions(-)

-- 
2.7.4


