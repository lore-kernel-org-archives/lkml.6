Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7388C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8B82183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfBTCdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:33:46 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3687 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726544AbfBTCdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:33:39 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E9910BFC89ECC512A382;
        Wed, 20 Feb 2019 10:33:36 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Wed, 20 Feb 2019 10:33:28 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "Huazhong Tan" <tanhuazhong@huawei.com>
Subject: [Patch net-next 03/12] net: hns3: convert mac advertize and supported from u32 to link mode
Date:   Wed, 20 Feb 2019 10:32:42 +0800
Message-ID: <1550629971-23999-4-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
References: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

The link mode with bits has been up to more than 31 for some MAC
and phy. Convert to using a linkmode bitmap, which can support all
link modes.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 75ec309..9a442f3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -839,27 +839,27 @@ static void hclge_parse_fiber_link_mode(struct hclge_dev *hdev,
 	unsigned long *supported = hdev->hw.mac.supported;
 
 	if (speed_ability & HCLGE_SUPPORT_1G_BIT)
-		set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
-			supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+				 supported);
 
 	if (speed_ability & HCLGE_SUPPORT_10G_BIT)
-		set_bit(ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
-			supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
+				 supported);
 
 	if (speed_ability & HCLGE_SUPPORT_25G_BIT)
-		set_bit(ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
-			supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
+				 supported);
 
 	if (speed_ability & HCLGE_SUPPORT_50G_BIT)
-		set_bit(ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
-			supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
+				 supported);
 
 	if (speed_ability & HCLGE_SUPPORT_100G_BIT)
-		set_bit(ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT,
-			supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT,
+				 supported);
 
-	set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, supported);
-	set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
 }
 
 static void hclge_parse_link_mode(struct hclge_dev *hdev, u8 speed_ability)
-- 
2.7.4

