Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbeCXELq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 00:11:46 -0400
Received: from mout.perfora.net ([74.208.4.194]:48829 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750734AbeCXELn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 00:11:43 -0400
From: Quytelda Kahja <quytelda@tamalin.org>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 1/3] ieee80211: Replace bit shifts with the BIT() macro for WLAN_CAPABILITY_*.
Date: Fri, 23 Mar 2018 21:10:25 -0700
Message-Id: <20180324041027.6498-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
X-Provags-ID: V03:K0:r0pFKLcgPf40IShiGzhZG2pDDVS2lR3D1O5PirsYnbSnJT+1mJs
 UHXoUj4Nk2Ch137xbhadVbZtK/mCdbtoKXKP14XRdqIxJeDaL0t2BjIUZZz046cZTZt04Ai
 Zj7Bni6oN0BdCnX4deB+7zmBZ73DdkP6Nvudy+ZyoGJlxs5qa86b8j7DgSPKm83zCIVYJ+/
 8KpQDtOdL+9LEl16hlRxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k1fjKRpqVA8=:u7N4ha8QZNU4gUDIPsqlRf
 Q9QbOIJQj4SP+eiRiTHcfKbGxI0Z6kEoqvOPJ9aZ8KPYqtHEhEQdvmE2p3llW+IxkS66QzPl5
 sQ6hCqX59Dv/BXq7GDRYoQRzPwTJwDxeqLSU85OHlInvcBpcs6PtknMMR3SJLfMhRViCas+I0
 Hgb1p3l0ybW6g+7nUgbQczSacHkg3EiMyYviGd7l4jaHgHUB+LTyGRo0G/BkQb/Pgxsx3J6ah
 FoRAtdEXaxZJQCHQfHGMb7cGbTBFN7bk7v0C4wCPu5fJlyIuLTvww9ye+3TDcVa3HJQrn7o3l
 XcgBLbPqDnViIXbcF2D8EoUaqUdD601rnIPWMvid1Dj2JgESQtyTW2kjQZtGO3HNJx43JVnnh
 czWSSv7E29dDuPdbHzxaDIEJBL7BadzFizmCCOS3P69cWT6UHM5Wvv0qiSNv5rQ7Ofx6K/PzM
 9KoMWr5eJIdo7Or8/vN8Z8P/3C9IkHoJzi+g0nD0debpiQI4AKHOWMAshXDP1w/oYom1h2uRf
 C3CtATCntNeK/3IyLlc5wbobkSjuT2iE4LIAkvZp2lXMqlZBin78LGZgW7SkFTbAcgWM5caKJ
 ED4Hjmci3pfOnsQDRoDA/XeURSOH8PmD8afALWZgrsUuanqQ1FrYyOjHXrtG2AyOCHF+Z01jc
 7RwMqlbBTkElhMKu6mFFmR1xSanXRwRFR78qNAwGQGZcH/lQsLv6JZev7Gl6XBEkj0WVvDSUd
 MIqedNmG4iFsU3iji8SD++t6BGBSwsU6Re+Niw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is neater and more consistent with the rest of the document to use the
BIT() macro from 'linux/bitops.h' to define the WLAN_CAPABILITY_*
bitmasks.  In the case of WLAN_CAPABILITY_DMG_TYPE_{IBSS, PBSS, AP},
bitshifting integers by 0 does nothing, so there is no reason to do it in
the code; replace these values with plain integers.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 include/linux/ieee80211.h | 56 +++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index ee6657a0ed69..58069176b432 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1588,8 +1588,8 @@ struct ieee80211_vht_operation {
 
 #define WLAN_AUTH_CHALLENGE_LEN 128
 
-#define WLAN_CAPABILITY_ESS		(1<<0)
-#define WLAN_CAPABILITY_IBSS		(1<<1)
+#define WLAN_CAPABILITY_ESS		BIT(0)
+#define WLAN_CAPABILITY_IBSS		BIT(1)
 
 /*
  * A mesh STA sets the ESS and IBSS capability bits to zero.
@@ -1599,37 +1599,37 @@ struct ieee80211_vht_operation {
 #define WLAN_CAPABILITY_IS_STA_BSS(cap)	\
 	(!((cap) & (WLAN_CAPABILITY_ESS | WLAN_CAPABILITY_IBSS)))
 
-#define WLAN_CAPABILITY_CF_POLLABLE	(1<<2)
-#define WLAN_CAPABILITY_CF_POLL_REQUEST	(1<<3)
-#define WLAN_CAPABILITY_PRIVACY		(1<<4)
-#define WLAN_CAPABILITY_SHORT_PREAMBLE	(1<<5)
-#define WLAN_CAPABILITY_PBCC		(1<<6)
-#define WLAN_CAPABILITY_CHANNEL_AGILITY	(1<<7)
+#define WLAN_CAPABILITY_CF_POLLABLE	BIT(2)
+#define WLAN_CAPABILITY_CF_POLL_REQUEST	BIT(3)
+#define WLAN_CAPABILITY_PRIVACY		BIT(4)
+#define WLAN_CAPABILITY_SHORT_PREAMBLE	BIT(5)
+#define WLAN_CAPABILITY_PBCC		BIT(6)
+#define WLAN_CAPABILITY_CHANNEL_AGILITY	BIT(7)
 
 /* 802.11h */
-#define WLAN_CAPABILITY_SPECTRUM_MGMT	(1<<8)
-#define WLAN_CAPABILITY_QOS		(1<<9)
-#define WLAN_CAPABILITY_SHORT_SLOT_TIME	(1<<10)
-#define WLAN_CAPABILITY_APSD		(1<<11)
-#define WLAN_CAPABILITY_RADIO_MEASURE	(1<<12)
-#define WLAN_CAPABILITY_DSSS_OFDM	(1<<13)
-#define WLAN_CAPABILITY_DEL_BACK	(1<<14)
-#define WLAN_CAPABILITY_IMM_BACK	(1<<15)
+#define WLAN_CAPABILITY_SPECTRUM_MGMT	BIT(8)
+#define WLAN_CAPABILITY_QOS		BIT(9)
+#define WLAN_CAPABILITY_SHORT_SLOT_TIME	BIT(10)
+#define WLAN_CAPABILITY_APSD		BIT(11)
+#define WLAN_CAPABILITY_RADIO_MEASURE	BIT(12)
+#define WLAN_CAPABILITY_DSSS_OFDM	BIT(13)
+#define WLAN_CAPABILITY_DEL_BACK	BIT(14)
+#define WLAN_CAPABILITY_IMM_BACK	BIT(15)
 
 /* DMG (60gHz) 802.11ad */
 /* type - bits 0..1 */
-#define WLAN_CAPABILITY_DMG_TYPE_MASK		(3<<0)
-#define WLAN_CAPABILITY_DMG_TYPE_IBSS		(1<<0) /* Tx by: STA */
-#define WLAN_CAPABILITY_DMG_TYPE_PBSS		(2<<0) /* Tx by: PCP */
-#define WLAN_CAPABILITY_DMG_TYPE_AP		(3<<0) /* Tx by: AP */
-
-#define WLAN_CAPABILITY_DMG_CBAP_ONLY		(1<<2)
-#define WLAN_CAPABILITY_DMG_CBAP_SOURCE		(1<<3)
-#define WLAN_CAPABILITY_DMG_PRIVACY		(1<<4)
-#define WLAN_CAPABILITY_DMG_ECPAC		(1<<5)
-
-#define WLAN_CAPABILITY_DMG_SPECTRUM_MGMT	(1<<8)
-#define WLAN_CAPABILITY_DMG_RADIO_MEASURE	(1<<12)
+#define WLAN_CAPABILITY_DMG_TYPE_MASK   (BIT(0) | BIT(1))
+#define WLAN_CAPABILITY_DMG_TYPE_IBSS   1 /* Tx by: STA */
+#define WLAN_CAPABILITY_DMG_TYPE_PBSS   2 /* Tx by: PCP */
+#define WLAN_CAPABILITY_DMG_TYPE_AP     3 /* Tx by: AP */
+
+#define WLAN_CAPABILITY_DMG_CBAP_ONLY		BIT(2)
+#define WLAN_CAPABILITY_DMG_CBAP_SOURCE		BIT(3)
+#define WLAN_CAPABILITY_DMG_PRIVACY		BIT(4)
+#define WLAN_CAPABILITY_DMG_ECPAC		BIT(5)
+
+#define WLAN_CAPABILITY_DMG_SPECTRUM_MGMT	BIT(8)
+#define WLAN_CAPABILITY_DMG_RADIO_MEASURE	BIT(12)
 
 /* measurement */
 #define IEEE80211_SPCT_MSR_RPRT_MODE_LATE	(1<<0)
-- 
2.16.2
