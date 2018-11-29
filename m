Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B307EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6578920989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6578920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbeK3Dru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:47:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15173 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729402AbeK3Dru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:47:50 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ECBA4C27D89BF;
        Fri, 30 Nov 2018 00:41:45 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Fri, 30 Nov 2018 00:41:41 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 0/2] Adds VF/PF PCIe reg dump(ethtool -d) support to HNS3 driver
Date:   Thu, 29 Nov 2018 16:40:57 +0000
Message-ID: <20181129164059.25580-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds VF/PF PCIe register dump support to HNS3 VF and PF driver
using "ethtool -d" command.

Jian Shen (2):
  net: hns3: Support "ethtool -d" for HNS3 VF driver
  net: hns3: Adds support to dump(using ethool-d) PCIe regs in HNS3 PF
    driver

 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 120 ++++++++++++++++++++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  56 ++++++++++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 120 +++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  54 ++++++++++
 4 files changed, 345 insertions(+), 5 deletions(-)

-- 
2.7.4


