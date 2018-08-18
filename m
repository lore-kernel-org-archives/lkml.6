Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191F7C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 06:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCEE218F9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 06:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCEE218F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeHRJvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 05:51:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57873 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbeHRJvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 05:51:00 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F410AAD87D5B2;
        Sat, 18 Aug 2018 14:44:20 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Sat, 18 Aug 2018 14:44:21 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>
CC:     <vz@mleia.com>, <slemieux.tyco@gmail.com>, <keescook@chromium.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCHv2 2/2] ethernet: lpc_eth: Use NULL to compare with pointer-typed value rather than 0
Date:   Sat, 18 Aug 2018 14:32:29 +0800
Message-ID: <1534573949-17548-3-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1534573949-17548-1-git-send-email-zhongjiang@huawei.com>
References: <1534573949-17548-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should use NULL to compare with pointer-typed value rather than 0.
The issue is detected with the help of Coccinelle.

Acked-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/net/ethernet/nxp/lpc_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index 08381ef..1c41b07 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -1350,7 +1350,7 @@ static int lpc_eth_drv_probe(struct platform_device *pdev)
 				"IRAM not big enough for net buffers, using SDRAM instead.\n");
 	}
 
-	if (pldat->dma_buff_base_v == 0) {
+	if (!pldat->dma_buff_base_v) {
 		ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 		if (ret)
 			goto err_out_free_irq;
-- 
1.7.12.4

