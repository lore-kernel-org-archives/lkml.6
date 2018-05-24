Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968595AbeEXTQH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:16:07 -0400
Received: from gateway30.websitewelcome.com ([192.185.149.4]:18152 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967476AbeEXTQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:16:06 -0400
X-Authority-Reason: nr=8
Date: Thu, 24 May 2018 13:54:50 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] rtlwifi: remove duplicate code
Message-ID: <20180524185450.GA2875@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.46.223
X-Source-L: No
X-Exim-ID: 1fLvO4-000QbU-57
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.46.223]:57742
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove and refactor some code in order to avoid having identical code
for different branches.

Notice that the logic has been there since 2014.

Addresses-Coverity-ID: 1426199 ("Identical code for different branches")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 .../realtek/rtlwifi/btcoexist/halbtc8723b2ant.c    | 23 ++++------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c
index 279fe01..df3facc 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c
@@ -2876,25 +2876,10 @@ static void btc8723b2ant_action_hid(struct btc_coexist *btcoexist)
 		btc8723b2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 13);
 
 	/* sw mechanism */
-	if (BTC_WIFI_BW_HT40 == wifi_bw) {
-		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
-		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
-			btc8723b2ant_sw_mechanism(btcoexist, true, true,
-						  false, false);
-		} else {
-			btc8723b2ant_sw_mechanism(btcoexist, true, true,
-						  false, false);
-		}
-	} else {
-		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
-		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
-			btc8723b2ant_sw_mechanism(btcoexist, false, true,
-						  false, false);
-		} else {
-			btc8723b2ant_sw_mechanism(btcoexist, false, true,
-						  false, false);
-		}
-	}
+	if (wifi_bw == BTC_WIFI_BW_HT40)
+		btc8723b2ant_sw_mechanism(btcoexist, true, true, false, false);
+	else
+		btc8723b2ant_sw_mechanism(btcoexist, false, true, false, false);
 }
 
 /* A2DP only / PAN(EDR) only/ A2DP+PAN(HS) */
-- 
2.7.4
