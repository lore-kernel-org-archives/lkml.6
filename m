Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24DBC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC9220665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC9220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbeJWV5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 17:57:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60373 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726277AbeJWV5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 17:57:47 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AD0F91356CD48;
        Tue, 23 Oct 2018 21:34:13 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Tue, 23 Oct 2018 21:34:13 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] pch_uart: remove set but not used variable 'tx_empty'
Date:   Tue, 23 Oct 2018 21:21:34 +0800
Message-ID: <1540300894-27202-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tx_empty is not used after setting its value. It is safe to remove
the unused variable.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/tty/serial/pch_uart.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index cb85002..9ed121f 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -933,7 +933,6 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
 	struct scatterlist *sg;
 	int nent;
 	int fifo_size;
-	int tx_empty;
 	struct dma_async_tx_descriptor *desc;
 	int num;
 	int i;
@@ -958,11 +957,9 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
 	}
 
 	fifo_size = max(priv->fifo_size, 1);
-	tx_empty = 1;
 	if (pop_tx_x(priv, xmit->buf)) {
 		pch_uart_hal_write(priv, xmit->buf, 1);
 		port->icount.tx++;
-		tx_empty = 0;
 		fifo_size--;
 	}
 
-- 
1.7.12.4

