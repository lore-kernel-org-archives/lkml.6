Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA53DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A71208E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A71208E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbeHQQjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 12:39:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11134 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726355AbeHQQjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 12:39:08 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A32BB295175FE;
        Fri, 17 Aug 2018 21:35:39 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Fri, 17 Aug 2018 21:35:37 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>
CC:     <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ide: Use NULL to compare with pointer-typed value rather than 0
Date:   Fri, 17 Aug 2018 21:23:47 +0800
Message-ID: <1534512227-39484-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should use NULL to compare with pointer-typed value rather than
0. The issue is detected with the help of Coccinelle.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/ide/pmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index c5b902b..673734b 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -1682,7 +1682,7 @@ static int pmac_ide_init_dma(ide_hwif_t *hwif, const struct ide_port_info *d)
 	/* We won't need pci_dev if we switch to generic consistent
 	 * DMA routines ...
 	 */
-	if (dev == NULL || pmif->dma_regs == 0)
+	if (dev == NULL || pmif->dma_regs == NULL)
 		return -ENODEV;
 	/*
 	 * Allocate space for the DBDMA commands.
-- 
1.7.12.4

