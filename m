Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4CBC46467
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE362172A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE362172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbeHCI7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:59:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10621 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727192AbeHCI7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:59:54 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7EFEC22B1C3F6;
        Fri,  3 Aug 2018 15:04:57 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.399.0; Fri, 3 Aug 2018 15:04:53 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <woojung.huh@microchip.com>, <davem@davemloft.net>,
        <UNGLinuxDriver@microchip.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] net:usb: Use ARRAY_SIZE instead of calculating the array size
Date:   Fri, 3 Aug 2018 14:53:14 +0800
Message-ID: <1533279195-50245-2-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1533279195-50245-1-git-send-email-zhongjiang@huawei.com>
References: <1533279195-50245-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use ARRAY_SIZE to replace open code sizeof(lan78xx_regs) / sizeof(u32).
It make the code concise.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/net/usb/lan78xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 4662fa0..a9991c5 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1649,7 +1649,7 @@ static int lan78xx_get_regs_len(struct net_device *netdev)
 	struct lan78xx_net *dev = netdev_priv(netdev);
 
 	/* Read Device/MAC registers */
-	for (i = 0; i < (sizeof(lan78xx_regs) / sizeof(u32)); i++)
+	for (i = 0; i < ARRAY_SIZE(lan78xx_regs); i++)
 		lan78xx_read_reg(dev, lan78xx_regs[i], &data[i]);
 
 	if (!netdev->phydev)
-- 
1.7.12.4

