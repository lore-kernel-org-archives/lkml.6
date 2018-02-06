Return-Path: <l4stpr0gr4m@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517952228; cv=none;
        d=google.com; s=arc-20160816;
        b=ITBELusJe/XtfCyhZpZEzOTY7X6vKl96Mir7aonNtl2yx7efSYYYEoMZZK/Ci55qkd
         Wr/F/XghwDD9n7N9W6LAws1VNVqHPBh0SH55uEmPlJFPscy79C8mnZUFvBzLvZky5tlq
         rBb9KSEQSp71LRZeNyGoKeArXvc/86FViBV2Mun9kCmcMyBQAZkBDWWe8ZFzAYbj6fha
         5Bby2QWc4aDfSz6z4SG2TuzU7GXzqIc0HA+bDThKyulfsFDNJcqMx1tT2iXPQwXAX6Ui
         3pcefxYQIls9k/EWrOXre6kv5RzWFsOcnCLsmtfm/VhkVMIMULVma1dhMV1ERhS44FzY
         K/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=HTN8d28E7edd76Q+DFdB1P3yq5Xyu3XexHReA/vouR8=;
        b=Q5PLJkhe4HFT9MTmMBTtVID/kM78Kb+7cfHjBeTnZHGdWYjVhPdDuz4yy7WUcuf3ml
         LEiPLC47kgA2ld5U1C2lhcgwGeJk8F0yyLWjijb8qVkZBPl7FQdraFIoH40XBzglZUoY
         PnFrFn89H53XWAH+ipf4BvufJbdA8KZSnoKBYKMvW6KPDI9BNf93NAj+yeia525thq26
         ZSBcsBlC/L10VHxCV50ZUUI1+TbAuJZj4AsET90NK1w9+4SjmbEWcMkKdpSwoXndaud7
         rrJ3BDhLugrafT3rXlrcMrA0CQdVpbADofF6nYa1AgNJW1q4vUKcS8bqbuU1IkJYxqAG
         5uLg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Kl61ZQW6;
       spf=pass (google.com: domain of l4stpr0gr4m@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=l4stpr0gr4m@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Kl61ZQW6;
       spf=pass (google.com: domain of l4stpr0gr4m@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=l4stpr0gr4m@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224v1WztQIEsYK4ddiN+Dtf+Kb6P1wBDpq5j3sp1sHR4Bt7eWtTdxU7grBcE6A6qwuTukjq6bA==
From: l4stpr0gr4m@gmail.com
To: gregkh@linuxfoundation.org
Cc: justin@jvreeland.com,
	hdegoede@redhat.com,
	hadess@hadess.net,
	colin.king@canonical.com,
	Larry.Finger@lwfinger.net,
	aishpant@gmail.com,
	himanshujha199640@gmail.com,
	arnd@arndb.de,
	ianwmorrison@gmail.com,
	davem@davemloft.net,
	joe@perches.com,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Kangmin Park <l4stpr0gr4m@gmail.com>
Subject: [PATCH] Update rf_type_definition
Date: Wed,  7 Feb 2018 06:23:34 +0900
Message-Id: <1517952214-3434-1-git-send-email-l4stpr0gr4m@gmail.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591688275498143058?=
X-GMAIL-MSGID: =?utf-8?q?1591688275498143058?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kangmin Park <l4stpr0gr4m@gmail.com>

enum RT_RF_TYPE_DEFINITION on rtl8723bs/include/rtw_rf.h
is different from enum tag_HAL_RF_Type_Definition on
rtl8723bs/include/HalVerDef.h

So, update them to be the same reference from
enum rf_type on rtlwifi/wifi.h which recent version.

As a result, ODM_RF_TYPE_E needs to be updated as well
Therefore, it is updated reference from enum odm_rf_type
on rtlwifi/phydm/phydm_pre_define.h too.
And update some additional code to check more
chip versions that resulted from it.

Also, fixed some space required errors and
line over 80 characters warnings by checkpatch.pl.

Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.h               | 18 +++---
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c       | 18 +++++-
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 12 ++++
 drivers/staging/rtl8723bs/include/HalVerDef.h     | 77 ++++++++++++++++-------
 drivers/staging/rtl8723bs/include/rtw_rf.h        | 14 +++--
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 20 +++---
 6 files changed, 111 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index 87a76ba..771b894 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -511,14 +511,16 @@ typedef enum tag_ODM_RF_Path_Bit_Definition {
 
 
 typedef enum tag_ODM_RF_Type_Definition {
-	ODM_1T1R	=	0,
-	ODM_1T2R	=	1,
-	ODM_2T2R	=	2,
-	ODM_2T3R	=	3,
-	ODM_2T4R	=	4,
-	ODM_3T3R	=	5,
-	ODM_3T4R	=	6,
-	ODM_4T4R	=	7,
+	ODM_1T1R		=	0,
+	ODM_1T2R		=	1,
+	ODM_2T2R		=	2,
+	ODM_2T2R_GREEN	=	3,
+	ODM_2T3R		=	4,
+	ODM_2T4R		=	5,
+	ODM_3T3R		=	6,
+	ODM_3T4R		=	7,
+	ODM_4T4R		=	8,
+	ODM_XTXR		=	9,
 } ODM_RF_TYPE_E;
 
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
index b162559..6069e1c 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
@@ -64,10 +64,24 @@ static void Init_ODM_ComInfo_8723b(struct adapter *Adapter)
 
 	if (pHalData->rf_type == RF_1T1R) {
 		ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_1T1R);
-	} else if (pHalData->rf_type == RF_2T2R) {
-		ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_2T2R);
 	} else if (pHalData->rf_type == RF_1T2R) {
 		ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_1T2R);
+	} else if (pHalData->rf_type == RF_2T2R) {
+		ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_2T2R);
+	} else if (pHalData->rf_type == RF_2T2R_GREEN) {
+		ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_2T2R_GREEN);
+	} else if (pHalData->rf_type == RF_2T3R) {
+		ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_2T3R);
+	} else if (pHalData->rf_type == RF_2T4R) {
+		ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_2T4R);
+	} else if (pHalData->rf_type == RF_3T3R) {
+		ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_3T3R);
+	} else if (pHalData->rf_type == RF_3T4R) {
+		ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_3T4R);
+	} else if (pHalData->rf_type == RF_4T4R) {
+		ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_4T4R);
+	} else {
+		ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_XTXR);
 	}
 
 	pdmpriv->InitODMFlag = ODM_RF_CALIBRATION|ODM_RF_TX_PWR_TRACK;
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index d6cef9e..a4df098 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1926,6 +1926,18 @@ static HAL_VERSION ReadChipVersion8723B(struct adapter *padapter)
 		pHalData->rf_type = RF_1T2R;
 	else if (IS_2T2R(ChipVersion))
 		pHalData->rf_type = RF_2T2R;
+	else if (IS_2T2R_GREEN(ChipVersion))
+		pHalData->rf_type = RF_2T2R_GREEN;
+	else if (IS_2T3R(ChipVersion))
+		pHalData->rf_type = RF_2T3R;
+	else if (IS_2T4R(ChipVersion))
+		pHalData->rf_type = RF_2T4R;
+	else if (IS_3T3R(ChipVersion))
+		pHalData->rf_type = RF_3T3R;
+	else if (IS_3T4R(ChipVersion))
+		pHalData->rf_type = RF_3T4R;
+	else if (IS_4T4R(ChipVersion))
+		pHalData->rf_type = RF_4T4R;
 	else
 		pHalData->rf_type = RF_1T1R;
 
diff --git a/drivers/staging/rtl8723bs/include/HalVerDef.h b/drivers/staging/rtl8723bs/include/HalVerDef.h
index a9e8609..08301fc 100644
--- a/drivers/staging/rtl8723bs/include/HalVerDef.h
+++ b/drivers/staging/rtl8723bs/include/HalVerDef.h
@@ -64,14 +64,15 @@ typedef enum tag_HAL_Manufacturer_Version_Definition
 
 typedef enum tag_HAL_RF_Type_Definition
 {
-	RF_TYPE_1T1R	=	0,
-	RF_TYPE_1T2R	=	1,
-	RF_TYPE_2T2R	=	2,
-	RF_TYPE_2T3R	=	3,
-	RF_TYPE_2T4R	=	4,
-	RF_TYPE_3T3R	=	5,
-	RF_TYPE_3T4R	=	6,
-	RF_TYPE_4T4R	=	7,
+	RF_TYPE_1T1R		=	0,
+	RF_TYPE_1T2R		=	1,
+	RF_TYPE_2T2R		=	2,
+	RF_TYPE_2T2R_GREEN	=	3,
+	RF_TYPE_2T3R		=	4,
+	RF_TYPE_2T4R		=	5,
+	RF_TYPE_3T3R		=	6,
+	RF_TYPE_3T4R		=	7,
+	RF_TYPE_4T4R		=	8,
 }HAL_RF_TYPE_E;
 
 typedef	struct tag_HAL_VERSION
@@ -101,27 +102,55 @@ typedef	struct tag_HAL_VERSION
 /* HAL_VERSION VersionID */
 
 /* HAL_CHIP_TYPE_E */
-#define IS_TEST_CHIP(version)			((GET_CVID_CHIP_TYPE(version) ==TEST_CHIP)? true: false)
-#define IS_NORMAL_CHIP(version)			((GET_CVID_CHIP_TYPE(version) ==NORMAL_CHIP)? true: false)
+#define IS_TEST_CHIP(version)			\
+	((GET_CVID_CHIP_TYPE(version) == TEST_CHIP) ? true : false)
+#define IS_NORMAL_CHIP(version)			\
+	((GET_CVID_CHIP_TYPE(version) == NORMAL_CHIP) ? true : false)
 
 /* HAL_CUT_VERSION_E */
-#define IS_A_CUT(version)				((GET_CVID_CUT_VERSION(version) == A_CUT_VERSION) ? true : false)
-#define IS_B_CUT(version)				((GET_CVID_CUT_VERSION(version) == B_CUT_VERSION) ? true : false)
-#define IS_C_CUT(version)				((GET_CVID_CUT_VERSION(version) == C_CUT_VERSION) ? true : false)
-#define IS_D_CUT(version)				((GET_CVID_CUT_VERSION(version) == D_CUT_VERSION) ? true : false)
-#define IS_E_CUT(version)				((GET_CVID_CUT_VERSION(version) == E_CUT_VERSION) ? true : false)
-#define IS_I_CUT(version)				((GET_CVID_CUT_VERSION(version) == I_CUT_VERSION) ? true : false)
-#define IS_J_CUT(version)				((GET_CVID_CUT_VERSION(version) == J_CUT_VERSION) ? true : false)
-#define IS_K_CUT(version)				((GET_CVID_CUT_VERSION(version) == K_CUT_VERSION) ? true : false)
+#define IS_A_CUT(version)				\
+	((GET_CVID_CUT_VERSION(version) == A_CUT_VERSION) ? true : false)
+#define IS_B_CUT(version)				\
+	((GET_CVID_CUT_VERSION(version) == B_CUT_VERSION) ? true : false)
+#define IS_C_CUT(version)				\
+	((GET_CVID_CUT_VERSION(version) == C_CUT_VERSION) ? true : false)
+#define IS_D_CUT(version)				\
+	((GET_CVID_CUT_VERSION(version) == D_CUT_VERSION) ? true : false)
+#define IS_E_CUT(version)				\
+	((GET_CVID_CUT_VERSION(version) == E_CUT_VERSION) ? true : false)
+#define IS_I_CUT(version)				\
+	((GET_CVID_CUT_VERSION(version) == I_CUT_VERSION) ? true : false)
+#define IS_J_CUT(version)				\
+	((GET_CVID_CUT_VERSION(version) == J_CUT_VERSION) ? true : false)
+#define IS_K_CUT(version)				\
+	((GET_CVID_CUT_VERSION(version) == K_CUT_VERSION) ? true : false)
 
 /* HAL_VENDOR_E */
-#define IS_CHIP_VENDOR_TSMC(version)	((GET_CVID_MANUFACTUER(version) == CHIP_VENDOR_TSMC)? true: false)
-#define IS_CHIP_VENDOR_UMC(version)	((GET_CVID_MANUFACTUER(version) == CHIP_VENDOR_UMC)? true: false)
-#define IS_CHIP_VENDOR_SMIC(version)	((GET_CVID_MANUFACTUER(version) == CHIP_VENDOR_SMIC)? true: false)
+#define IS_CHIP_VENDOR_TSMC(version)	\
+	((GET_CVID_MANUFACTUER(version) == CHIP_VENDOR_TSMC) ? true : false)
+#define IS_CHIP_VENDOR_UMC(version)		\
+	((GET_CVID_MANUFACTUER(version) == CHIP_VENDOR_UMC) ? true : false)
+#define IS_CHIP_VENDOR_SMIC(version)	\
+	((GET_CVID_MANUFACTUER(version) == CHIP_VENDOR_SMIC) ? true : false)
 
 /* HAL_RF_TYPE_E */
-#define IS_1T1R(version)					((GET_CVID_RF_TYPE(version) == RF_TYPE_1T1R)? true : false)
-#define IS_1T2R(version)					((GET_CVID_RF_TYPE(version) == RF_TYPE_1T2R)? true : false)
-#define IS_2T2R(version)					((GET_CVID_RF_TYPE(version) == RF_TYPE_2T2R)? true : false)
+#define IS_1T1R(version)				\
+	((GET_CVID_RF_TYPE(version) == RF_TYPE_1T1R) ? true : false)
+#define IS_1T2R(version)				\
+	((GET_CVID_RF_TYPE(version) == RF_TYPE_1T2R) ? true : false)
+#define IS_2T2R(version)				\
+	((GET_CVID_RF_TYPE(version) == RF_TYPE_2T2R) ? true : false)
+#define IS_2T2R_GREEN(version)			\
+	((GET_CVID_RF_TYPE(version) == RF_TYPE_2T2R_GREEN) ? true : false)
+#define IS_2T3R(version)				\
+	((GET_CVID_RF_TYPE(version) == RF_TYPE_2T3R) ? true : false)
+#define IS_2T4R(version)				\
+	((GET_CVID_RF_TYPE(version) == RF_TYPE_2T4R) ? true : false)
+#define IS_3T3R(version)				\
+	((GET_CVID_RF_TYPE(version) == RF_TYPE_3T3R) ? true : false)
+#define IS_3T4R(version)				\
+	((GET_CVID_RF_TYPE(version) == RF_TYPE_3T4R) ? true : false)
+#define IS_4T4R(version)				\
+	((GET_CVID_RF_TYPE(version) == RF_TYPE_4T4R) ? true : false)
 
 #endif
diff --git a/drivers/staging/rtl8723bs/include/rtw_rf.h b/drivers/staging/rtl8723bs/include/rtw_rf.h
index f9becab..d1fc396 100644
--- a/drivers/staging/rtl8723bs/include/rtw_rf.h
+++ b/drivers/staging/rtl8723bs/include/rtw_rf.h
@@ -146,12 +146,16 @@ enum PROTECTION_MODE {
 
 /* 2007/11/15 MH Define different RF type. */
 enum RT_RF_TYPE_DEFINITION {
-	RF_1T2R = 0,
-	RF_2T4R = 1,
+	RF_1T1R = 0,
+	RF_1T2R = 1,
 	RF_2T2R = 2,
-	RF_1T1R = 3,
-	RF_2T2R_GREEN = 4,
-	RF_MAX_TYPE = 5,
+	RF_2T2R_GREEN = 3,
+	RF_2T3R = 4,
+	RF_2T4R = 5,
+	RF_3T3R = 6,
+	RF_3T4R = 7,
+	RF_4T4R = 8,
+	RF_MAX_TYPE = 9,
 };
 
 u32 rtw_ch2freq(u32 ch);
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 51d48de..22fc6fa 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -3299,7 +3299,7 @@ static int cfg80211_rtw_sched_scan_stop(struct wiphy *wiphy,
 
 static void rtw_cfg80211_init_ht_capab(struct ieee80211_sta_ht_cap *ht_cap, enum nl80211_band band, u8 rf_type)
 {
-
+#define MAX_BIT_RATE_40MHZ_MCS23	450	/* Mbps */
 #define MAX_BIT_RATE_40MHZ_MCS15	300	/* Mbps */
 #define MAX_BIT_RATE_40MHZ_MCS7		150	/* Mbps */
 
@@ -3330,24 +3330,26 @@ static void rtw_cfg80211_init_ht_capab(struct ieee80211_sta_ht_cap *ht_cap, enum
 	 *if BW_40 rx_mask[4]= 0x01;
 	 *highest supported RX rate
 	 */
-	if (rf_type == RF_1T1R)
-	{
+	if (rf_type == RF_1T1R) {
 		ht_cap->mcs.rx_mask[0] = 0xFF;
 		ht_cap->mcs.rx_mask[1] = 0x00;
 		ht_cap->mcs.rx_mask[4] = 0x01;
 
 		ht_cap->mcs.rx_highest = cpu_to_le16(MAX_BIT_RATE_40MHZ_MCS7);
-	}
-	else if ((rf_type == RF_1T2R) || (rf_type ==RF_2T2R))
-	{
+	} else if ((rf_type == RF_1T2R) || (rf_type == RF_2T2R)
+			|| (rf_type == RF_2T2R_GREEN)) {
 		ht_cap->mcs.rx_mask[0] = 0xFF;
 		ht_cap->mcs.rx_mask[1] = 0xFF;
 		ht_cap->mcs.rx_mask[4] = 0x01;
 
 		ht_cap->mcs.rx_highest = cpu_to_le16(MAX_BIT_RATE_40MHZ_MCS15);
-	}
-	else
-	{
+	} else if ((rf_type == RF_2T3R) || (rf_type == RF_3T3R)) {
+		ht_cap->mcs.rx_mask[0] = 0xFF;
+		ht_cap->mcs.rx_mask[1] = 0xFF;
+		ht_cap->mcs.rx_mask[2] = 0x01;
+
+		ht_cap->mcs.rx_highest = cpu_to_le16(MAX_BIT_RATE_40MHZ_MCS23);
+	} else {
 		DBG_8192C("%s, error rf_type =%d\n", __func__, rf_type);
 	}
 
-- 
2.7.4
