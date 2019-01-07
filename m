Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0527AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55452087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfAGXsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:48:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52505 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfAGXsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:48:14 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1ggecs-0005aI-0z; Mon, 07 Jan 2019 23:48:10 +0000
From:   Colin King <colin.king@canonical.com>
To:     Arjun Vynipadath <arjun@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: cxgb4: fix various indentation issues
Date:   Mon,  7 Jan 2019 23:48:09 +0000
Message-Id: <20190107234809.14373-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are some lines that have indentation issues, fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c | 8 ++++----
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c | 2 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c
index 9f9d6cae39d5..58a039c3224a 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c
@@ -378,10 +378,10 @@ static void cxgb4_init_ptp_timer(struct adapter *adapter)
 	int err;
 
 	memset(&c, 0, sizeof(c));
-		c.op_to_portid = cpu_to_be32(FW_CMD_OP_V(FW_PTP_CMD) |
-					     FW_CMD_REQUEST_F |
-					     FW_CMD_WRITE_F |
-					     FW_PTP_CMD_PORTID_V(0));
+	c.op_to_portid = cpu_to_be32(FW_CMD_OP_V(FW_PTP_CMD) |
+				     FW_CMD_REQUEST_F |
+				     FW_CMD_WRITE_F |
+				     FW_PTP_CMD_PORTID_V(0));
 	c.retval_len16 = cpu_to_be32(FW_CMD_LEN16_V(sizeof(c) / 16));
 	c.u.scmd.sc = FW_PTP_SC_INIT_TIMER;
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c
index 9a6065a3fa46..c041f44324db 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c
@@ -78,7 +78,7 @@ static void free_msix_idx_in_bmap(struct adapter *adap, unsigned int msix_idx)
 	unsigned long flags;
 
 	spin_lock_irqsave(&bmap->lock, flags);
-	 __clear_bit(msix_idx, bmap->msix_bmap);
+	__clear_bit(msix_idx, bmap->msix_bmap);
 	spin_unlock_irqrestore(&bmap->lock, flags);
 }
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index e8c34292a0ec..2b03f6187a24 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -3794,7 +3794,7 @@ int t4_load_phy_fw(struct adapter *adap,
 	/* If we have version number support, then check to see if the adapter
 	 * already has up-to-date PHY firmware loaded.
 	 */
-	 if (phy_fw_version) {
+	if (phy_fw_version) {
 		new_phy_fw_vers = phy_fw_version(phy_fw_data, phy_fw_size);
 		ret = t4_phy_fw_ver(adap, &cur_phy_fw_ver);
 		if (ret < 0)
-- 
2.19.1

