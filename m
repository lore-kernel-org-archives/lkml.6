Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997B7C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 04:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE6A219CE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 04:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE6A219CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeHFHDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 03:03:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42051 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726726AbeHFHDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 03:03:32 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0615FF9215B77;
        Mon,  6 Aug 2018 12:56:11 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.399.0; Mon, 6 Aug 2018
 12:56:04 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <pkshih@realtek.com>, <kvalo@codeaurora.org>,
        <Larry.Finger@lwfinger.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <davem@davemloft.net>, <colin.king@canonical.com>,
        <linux-wireless@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] rtlwifi: btcoex: Fix if == else warnings in halbtc8723b2ant.c
Date:   Mon, 6 Aug 2018 12:54:40 +0800
Message-ID: <20180806045440.11920-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccinelle warning:

./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:2952:2-4: WARNING: possible condition with no effect (if == else)
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:2961:2-4: WARNING: possible condition with no effect (if == else)
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3011:2-4: WARNING: possible condition with no effect (if == else)
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3020:2-4: WARNING: possible condition with no effect (if == else)
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3439:2-4: WARNING: possible condition with no effect (if == else)
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3448:2-4: WARNING: possible condition with no effect (if == else)
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3339:2-4: WARNING: possible condition with no effect (if == else)
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3348:2-4: WARNING: possible condition with no effect (if == else)
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3074:2-4: WARNING: possible condition with no effect (if == else)
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3083:2-4: WARNING: possible condition with no effect (if == else)
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3192:2-4: WARNING: possible condition with no effect (if == else)
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3201:2-4: WARNING: possible condition with no effect (if == else)
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3267:2-4: WARNING: possible condition with no effect (if == else)
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3276:2-4: WARNING: possible condition with no effect (if == else)
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3124:2-4: WARNING: possible condition with no effect (if == else)
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:3133:2-4: WARNING: possible condition with no effect (if == else)
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:2821:2-4: WARNING: possible condition with no effect (if == else)
./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:2830:2-4: WARNING: possible condition with no effect (if == else)

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 .../realtek/rtlwifi/btcoexist/halbtc8723b2ant.c    | 180 +++++----------------
 1 file changed, 36 insertions(+), 144 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c
index df3facc..6597f7c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c
@@ -2818,23 +2818,11 @@ static void btc8723b2ant_action_sco(struct btc_coexist *btcoexist)
 
 	/* sw mechanism */
 	if (BTC_WIFI_BW_HT40 == wifi_bw) {
-		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
-		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
-			btc8723b2ant_sw_mechanism(btcoexist, true, true,
-						  false, false);
-		} else {
-			btc8723b2ant_sw_mechanism(btcoexist, true, true,
-						  false, false);
-		}
+		btc8723b2ant_sw_mechanism(btcoexist, true, true,
+					  false, false);
 	} else {
-		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
-		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
-			btc8723b2ant_sw_mechanism(btcoexist, false, true,
-						  false, false);
-		} else {
-			btc8723b2ant_sw_mechanism(btcoexist, false, true,
-						  false, false);
-		}
+		btc8723b2ant_sw_mechanism(btcoexist, false, true,
+					  false, false);
 	}
 }
 
@@ -2949,23 +2937,11 @@ static void btc8723b2ant_action_a2dp(struct btc_coexist *btcoexist)
 	/* sw mechanism */
 	btcoexist->btc_get(btcoexist, BTC_GET_U4_WIFI_BW, &wifi_bw);
 	if (BTC_WIFI_BW_HT40 == wifi_bw) {
-		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
-		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
-			btc8723b2ant_sw_mechanism(btcoexist, true, false,
-						  false, false);
-		} else {
-			btc8723b2ant_sw_mechanism(btcoexist, true, false,
-						  false, false);
-		}
+		btc8723b2ant_sw_mechanism(btcoexist, true, false,
+					  false, false);
 	} else {
-		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
-		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
-			btc8723b2ant_sw_mechanism(btcoexist, false, false,
-						  false, false);
-		} else {
-			btc8723b2ant_sw_mechanism(btcoexist, false, false,
-						  false, false);
-		}
+		btc8723b2ant_sw_mechanism(btcoexist, false, false,
+					  false, false);
 	}
 }
 
@@ -3008,23 +2984,11 @@ static void btc8723b2ant_action_a2dp_pan_hs(struct btc_coexist *btcoexist)
 	/* sw mechanism */
 	btcoexist->btc_get(btcoexist, BTC_GET_U4_WIFI_BW, &wifi_bw);
 	if (BTC_WIFI_BW_HT40 == wifi_bw) {
-		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
-		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
-			btc8723b2ant_sw_mechanism(btcoexist, true, false,
-						  false, false);
-		} else {
-			btc8723b2ant_sw_mechanism(btcoexist, true, false,
-						  false, false);
-		}
+		btc8723b2ant_sw_mechanism(btcoexist, true, false,
+					  false, false);
 	} else {
-		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
-		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
-			btc8723b2ant_sw_mechanism(btcoexist, false, false,
-						  false, false);
-		} else {
-			btc8723b2ant_sw_mechanism(btcoexist, false, false,
-						  false, false);
-		}
+		btc8723b2ant_sw_mechanism(btcoexist, false, false,
+					  false, false);
 	}
 }
 
@@ -3071,23 +3035,11 @@ static void btc8723b2ant_action_pan_edr(struct btc_coexist *btcoexist)
 	/* sw mechanism */
 	btcoexist->btc_get(btcoexist, BTC_GET_U4_WIFI_BW, &wifi_bw);
 	if (BTC_WIFI_BW_HT40 == wifi_bw) {
-		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
-		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
-			btc8723b2ant_sw_mechanism(btcoexist, true, false,
-						  false, false);
-		} else {
-			btc8723b2ant_sw_mechanism(btcoexist, true, false,
-						  false, false);
-		}
+		btc8723b2ant_sw_mechanism(btcoexist, true, false,
+					  false, false);
 	} else {
-		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
-		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
-			btc8723b2ant_sw_mechanism(btcoexist, false, false,
-						  false, false);
-		} else {
-			btc8723b2ant_sw_mechanism(btcoexist, false, false,
-						  false, false);
-		}
+		btc8723b2ant_sw_mechanism(btcoexist, false, false,
+					  false, false);
 	}
 }
 
@@ -3121,23 +3073,11 @@ static void btc8723b2ant_action_pan_hs(struct btc_coexist *btcoexist)
 
 	btcoexist->btc_get(btcoexist, BTC_GET_U4_WIFI_BW, &wifi_bw);
 	if (BTC_WIFI_BW_HT40 == wifi_bw) {
-		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
-		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
-			btc8723b2ant_sw_mechanism(btcoexist, true, false,
-						  false, false);
-		} else {
-			btc8723b2ant_sw_mechanism(btcoexist, true, false,
-						  false, false);
-		}
+		btc8723b2ant_sw_mechanism(btcoexist, true, false,
+					  false, false);
 	} else {
-		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
-		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
-			btc8723b2ant_sw_mechanism(btcoexist, false, false,
-						  false, false);
-		} else {
-			btc8723b2ant_sw_mechanism(btcoexist, false, false,
-						  false, false);
-		}
+		btc8723b2ant_sw_mechanism(btcoexist, false, false,
+					  false, false);
 	}
 }
 
@@ -3189,23 +3129,11 @@ static void btc8723b2ant_action_pan_edr_a2dp(struct btc_coexist *btcoexist)
 
 	/* sw mechanism	*/
 	if (BTC_WIFI_BW_HT40 == wifi_bw) {
-		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
-		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
-			btc8723b2ant_sw_mechanism(btcoexist, true, false,
-						  false, false);
-		} else {
-			btc8723b2ant_sw_mechanism(btcoexist, true, false,
-						  false, false);
-		}
+		btc8723b2ant_sw_mechanism(btcoexist, true, false,
+					  false, false);
 	} else {
-		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
-		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
-			btc8723b2ant_sw_mechanism(btcoexist, false, false,
-						  false, false);
-		} else {
-			btc8723b2ant_sw_mechanism(btcoexist, false, false,
-						  false, false);
-		}
+		btc8723b2ant_sw_mechanism(btcoexist, false, false,
+					  false, false);
 	}
 }
 
@@ -3264,23 +3192,11 @@ static void btc8723b2ant_action_pan_edr_hid(struct btc_coexist *btcoexist)
 
 	/* sw mechanism */
 	if (BTC_WIFI_BW_HT40 == wifi_bw) {
-		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
-		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
-			btc8723b2ant_sw_mechanism(btcoexist, true, true,
-						  false, false);
-		} else {
-			btc8723b2ant_sw_mechanism(btcoexist, true, true,
-						  false, false);
-		}
+		btc8723b2ant_sw_mechanism(btcoexist, true, true,
+					  false, false);
 	} else {
-		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
-		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
-			btc8723b2ant_sw_mechanism(btcoexist, false, true,
-						  false, false);
-		} else {
-			btc8723b2ant_sw_mechanism(btcoexist, false, true,
-						  false, false);
-		}
+		btc8723b2ant_sw_mechanism(btcoexist, false, true,
+					  false, false);
 	}
 }
 
@@ -3336,23 +3252,11 @@ static void btc8723b2ant_action_hid_a2dp_pan_edr(struct btc_coexist *btcoexist)
 
 	/* sw mechanism */
 	if (BTC_WIFI_BW_HT40 == wifi_bw) {
-		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
-		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
-			btc8723b2ant_sw_mechanism(btcoexist, true, true,
-						  false, false);
-		} else {
-			btc8723b2ant_sw_mechanism(btcoexist, true, true,
-						  false, false);
-		}
+		btc8723b2ant_sw_mechanism(btcoexist, true, true,
+					  false, false);
 	} else {
-		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
-		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
-			btc8723b2ant_sw_mechanism(btcoexist, false, true,
-						  false, false);
-		} else {
-			btc8723b2ant_sw_mechanism(btcoexist, false, true,
-						  false, false);
-		}
+		btc8723b2ant_sw_mechanism(btcoexist, false, true,
+					  false, false);
 	}
 }
 
@@ -3436,23 +3340,11 @@ static void btc8723b2ant_action_hid_a2dp(struct btc_coexist *btcoexist)
 
 	/* sw mechanism */
 	if (BTC_WIFI_BW_HT40 == wifi_bw) {
-		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
-		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
-			btc8723b2ant_sw_mechanism(btcoexist, true, true,
-						  false, false);
-		} else {
-			btc8723b2ant_sw_mechanism(btcoexist, true, true,
-						  false, false);
-		}
+		btc8723b2ant_sw_mechanism(btcoexist, true, true,
+					  false, false);
 	} else {
-		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
-		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
-			btc8723b2ant_sw_mechanism(btcoexist, false, true,
-						  false, false);
-		} else {
-			btc8723b2ant_sw_mechanism(btcoexist, false, true,
-						  false, false);
-		}
+		btc8723b2ant_sw_mechanism(btcoexist, false, true,
+					  false, false);
 	}
 }
 
-- 
2.7.0


