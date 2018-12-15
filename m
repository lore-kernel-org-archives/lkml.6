Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82131C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801A6208C1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbeLODRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 22:17:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728675AbeLODRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 22:17:32 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DC5085128520E;
        Sat, 15 Dec 2018 11:17:29 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Sat, 15 Dec 2018 11:17:24 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [Patch net 08/10] net: hns: Fix ntuple-filters status error.
Date:   Sat, 15 Dec 2018 11:53:27 +0800
Message-ID: <1544846009-50276-9-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544846009-50276-1-git-send-email-lipeng321@huawei.com>
References: <1544846009-50276-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

The ntuple-filters features is forced on by chip.
But it shows "ntuple-filters: off [fixed]" when use ethtool.
This patch make it correct with "ntuple-filters: on [fixed]".

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 8a53c82..6242249 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -2374,7 +2374,7 @@ static int hns_nic_dev_probe(struct platform_device *pdev)
 	ndev->min_mtu = MAC_MIN_MTU;
 	switch (priv->enet_ver) {
 	case AE_VERSION_2:
-		ndev->features |= NETIF_F_TSO | NETIF_F_TSO6;
+		ndev->features |= NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_NTUPLE;
 		ndev->hw_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 			NETIF_F_RXCSUM | NETIF_F_SG | NETIF_F_GSO |
 			NETIF_F_GRO | NETIF_F_TSO | NETIF_F_TSO6;
-- 
1.9.1

