Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F760C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 03:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D6F20659
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 03:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D6F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeKRNjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 08:39:23 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48609 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbeKRNjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 08:39:23 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5F750A0962F74;
        Sun, 18 Nov 2018 11:20:28 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.88.178) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Sun, 18 Nov 2018 11:20:18 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 0/5] net: hns3: Add vf mtu support
Date:   Sun, 18 Nov 2018 03:19:09 +0000
Message-ID: <20181118031914.23892-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.88.178]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds vf mtu support to HNS3 driver.

Yunsheng Lin (5):
  net: hns3: Support two vlan header when setting mtu
  net: hns3: Refactor mac mtu setting related functions
  net: hns3: Add vport alive state checking support
  net: hns3: Add mtu setting support for vf
  net: hns3: up/down netdev in hclge module when setting mtu

 .../net/ethernet/hisilicon/hns3/hclge_mbx.h   |   3 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   6 +
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  39 +++--
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |   5 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 148 ++++++++++++++----
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  16 +-
 .../hisilicon/hns3/hns3pf/hclge_mbx.c         |  49 ++++++
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  76 ++++++++-
 .../hisilicon/hns3/hns3vf/hclgevf_main.h      |   2 +
 9 files changed, 295 insertions(+), 49 deletions(-)

-- 
2.17.1


