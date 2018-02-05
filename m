Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeBEULT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 15:11:19 -0500
Received: from sauhun.de ([88.99.104.3]:34245 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751617AbeBEUK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 15:10:26 -0500
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, netdev@vger.kernel.org
Subject: [PATCH 4/4] net: amd-xgbe: fix comparison to bitshift when dealing with a mask
Date: Mon,  5 Feb 2018 21:10:01 +0100
Message-Id: <20180205201002.23621-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180205201002.23621-1-wsa+renesas@sang-engineering.com>
References: <20180205201002.23621-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a typo, the mask was destroyed by a comparison instead of a bit
shift.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Only build tested. To be applied individually per subsystem.

 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 7a3ebfd236f5eb..100adee778dfd6 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -595,7 +595,7 @@ static void xgbe_isr_task(unsigned long data)
 
 		reissue_mask = 1 << 0;
 		if (!pdata->per_channel_irq)
-			reissue_mask |= 0xffff < 4;
+			reissue_mask |= 0xffff << 4;
 
 		XP_IOWRITE(pdata, XP_INT_REISSUE_EN, reissue_mask);
 	}
-- 
2.11.0
