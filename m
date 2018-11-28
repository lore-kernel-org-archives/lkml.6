Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6B4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A762081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A762081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeK1X01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:26:27 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:50833 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727703AbeK1X01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:26:27 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6CA149B0175AD;
        Wed, 28 Nov 2018 20:24:54 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Wed, 28 Nov 2018
 20:24:48 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <jdmason@kudzu.us>,
        <natechancellor@gmail.com>, <clabbe@baylibre.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: neterion: vxge: remove set but not used variables 'max_frags' and 'txdl_priv'
Date:   Wed, 28 Nov 2018 20:24:41 +0800
Message-ID: <20181128122441.15692-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/neterion/vxge/vxge-traffic.c:1698:35:
 warning: variable 'txdl_priv' set but not used [-Wunused-but-set-variable]
drivers/net/ethernet/neterion/vxge/vxge-traffic.c:1699:6:
 warning: variable 'max_frags' set but not used [-Wunused-but-set-variable]

It never used since introduction in
commit 113241321dcd ("Neterion: New driver: Traffic & alarm handler")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/neterion/vxge/vxge-traffic.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/neterion/vxge/vxge-traffic.c b/drivers/net/ethernet/neterion/vxge/vxge-traffic.c
index f7a0d1d..59e77e30 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-traffic.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-traffic.c
@@ -1695,17 +1695,10 @@ enum vxge_hw_status vxge_hw_fifo_handle_tcode(struct __vxge_hw_fifo *fifo,
  */
 void vxge_hw_fifo_txdl_free(struct __vxge_hw_fifo *fifo, void *txdlh)
 {
-	struct __vxge_hw_fifo_txdl_priv *txdl_priv;
-	u32 max_frags;
 	struct __vxge_hw_channel *channel;
 
 	channel = &fifo->channel;
 
-	txdl_priv = __vxge_hw_fifo_txdl_priv(fifo,
-			(struct vxge_hw_fifo_txd *)txdlh);
-
-	max_frags = fifo->config->max_frags;
-
 	vxge_hw_channel_dtr_free(channel, txdlh);
 }
 
-- 
2.7.0


