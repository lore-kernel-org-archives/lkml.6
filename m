Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4903C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA47217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbfBLQIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:08:12 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42301 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbfBLQIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:08:11 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gtabP-0003TA-ER; Tue, 12 Feb 2019 16:08:07 +0000
From:   Colin King <colin.king@canonical.com>
To:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] qlge: fix some indentation issues
Date:   Tue, 12 Feb 2019 16:08:07 +0000
Message-Id: <20190212160807.12807-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are some statements that are indented incorrectly. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/qlogic/qlge/qlge_ethtool.c | 4 ++--
 drivers/net/ethernet/qlogic/qlge/qlge_main.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlge/qlge_ethtool.c b/drivers/net/ethernet/qlogic/qlge/qlge_ethtool.c
index 5edbd532127d..a6886cc5654c 100644
--- a/drivers/net/ethernet/qlogic/qlge/qlge_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qlge/qlge_ethtool.c
@@ -249,8 +249,8 @@ static void ql_update_stats(struct ql_adapter *qdev)
 
 	spin_lock(&qdev->stats_lock);
 	if (ql_sem_spinlock(qdev, qdev->xg_sem_mask)) {
-			netif_err(qdev, drv, qdev->ndev,
-				  "Couldn't get xgmac sem.\n");
+		netif_err(qdev, drv, qdev->ndev,
+			  "Couldn't get xgmac sem.\n");
 		goto quit;
 	}
 	/*
diff --git a/drivers/net/ethernet/qlogic/qlge/qlge_main.c b/drivers/net/ethernet/qlogic/qlge/qlge_main.c
index 059ba9429e51..096515c27263 100644
--- a/drivers/net/ethernet/qlogic/qlge/qlge_main.c
+++ b/drivers/net/ethernet/qlogic/qlge/qlge_main.c
@@ -1159,10 +1159,10 @@ static void ql_update_lbq(struct ql_adapter *qdev, struct rx_ring *rx_ring)
 
 			map = lbq_desc->p.pg_chunk.map +
 				lbq_desc->p.pg_chunk.offset;
-				dma_unmap_addr_set(lbq_desc, mapaddr, map);
+			dma_unmap_addr_set(lbq_desc, mapaddr, map);
 			dma_unmap_len_set(lbq_desc, maplen,
 					rx_ring->lbq_buf_size);
-				*lbq_desc->addr = cpu_to_le64(map);
+			*lbq_desc->addr = cpu_to_le64(map);
 
 			pci_dma_sync_single_for_device(qdev->pdev, map,
 						rx_ring->lbq_buf_size,
-- 
2.20.1

