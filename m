Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbeDYKbZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 06:31:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41565 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752431AbeDYKbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 06:31:20 -0400
From: Colin King <colin.king@canonical.com>
To: "David S . Miller" <davem@davemloft.net>,
        Allen Pais <allen.lkml@gmail.com>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: amd8111e: remove redundant duplicated if statement
Date: Wed, 25 Apr 2018 11:31:13 +0100
Message-Id: <20180425103113.8013-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two identical nested if statements, the second is redundant
and can be removed. Also clean up white space formatting.

Cleans up cppcheck warning:
drivers/net/ethernet/amd/amd8111e.c:1080: (warning) Identical inner 'if'
condition is always true.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/amd/amd8111e.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/amd/amd8111e.c b/drivers/net/ethernet/amd/amd8111e.c
index c99e3e845ac0..a90080f12e67 100644
--- a/drivers/net/ethernet/amd/amd8111e.c
+++ b/drivers/net/ethernet/amd/amd8111e.c
@@ -1074,16 +1074,12 @@ static int amd8111e_calc_coalesce(struct net_device *dev)
 				amd8111e_set_coalesce(dev,TX_INTR_COAL);
 				coal_conf->tx_coal_type = MEDIUM_COALESCE;
 			}
-
-		}
-		else if(tx_pkt_size >= 1024){
-			if (tx_pkt_size >= 1024){
-				if(coal_conf->tx_coal_type !=  HIGH_COALESCE){
-					coal_conf->tx_timeout = 4;
-					coal_conf->tx_event_count = 8;
-					amd8111e_set_coalesce(dev,TX_INTR_COAL);
-					coal_conf->tx_coal_type = HIGH_COALESCE;
-				}
+		} else if (tx_pkt_size >= 1024) {
+			if (coal_conf->tx_coal_type != HIGH_COALESCE) {
+				coal_conf->tx_timeout = 4;
+				coal_conf->tx_event_count = 8;
+				amd8111e_set_coalesce(dev, TX_INTR_COAL);
+				coal_conf->tx_coal_type = HIGH_COALESCE;
 			}
 		}
 	}
-- 
2.17.0
