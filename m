Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883E1C10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A6121B1A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405616AbfBNDst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:48:49 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:35728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405548AbfBNDsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:48:46 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 011421BD69C26AD2488C;
        Thu, 14 Feb 2019 11:48:44 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Thu, 14 Feb 2019 11:48:34 +0800
From:   Jian Shen <shenjian15@huawei.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 0/2] net: phy: add new led configuration for marvell m88e1510
Date:   Thu, 14 Feb 2019 12:31:05 +0800
Message-ID: <1550118667-119947-1-git-send-email-shenjian15@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the m88e1510 phy driver used LED[0] and LED[1] for link,
LED[2] for active. It's incompatible with some boards which uses
LED[1] for active. This patchset adds new led configuration for
HNS3 driver.

Jian Shen (2):
  net: phy: marvell: add new m88e1510 LED configuration
  net: hns3: add fixup handle for hns3 driver

 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    | 19 +++++++++++++++++++
 drivers/net/phy/marvell.c                          | 22 +++++++++++++++++++++-
 include/linux/marvell_phy.h                        |  1 +
 3 files changed, 41 insertions(+), 1 deletion(-)

-- 
1.9.1

