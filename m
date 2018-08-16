Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBA7C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B632147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B632147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392235AbeHPTKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:10:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11122 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388141AbeHPTKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:10:17 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3972FFA57ECF0;
        Fri, 17 Aug 2018 00:10:46 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Fri, 17 Aug 2018 00:10:46 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <alcooperx@gmail.com>, <kishon@ti.com>, <robh@kernel.org>,
        <hauke@hauke-m.de>, <ralf@linux-mips.org>
CC:     <f.fainelli@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCHv2 1/2] phy:phy-brcm-usb: Use PTR_ERR_OR_ZERO to replace the open coded version
Date:   Thu, 16 Aug 2018 23:58:54 +0800
Message-ID: <1534435135-49332-2-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1534435135-49332-1-git-send-email-zhongjiang@huawei.com>
References: <1534435135-49332-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTR_ERR_OR_ZERO has implemented the if(IS_ERR(...)) + PTR_ERR, So
just replace them rather than duplicating its implement.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index d1dab36..f59b1dc 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -372,10 +372,8 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
 	clk_disable(priv->usb_30_clk);
 
 	phy_provider = devm_of_phy_provider_register(dev, brcm_usb_phy_xlate);
-	if (IS_ERR(phy_provider))
-		return PTR_ERR(phy_provider);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
1.7.12.4

