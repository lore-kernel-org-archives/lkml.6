Return-Path: <l4stpr0gr4m@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517924386; cv=none;
        d=google.com; s=arc-20160816;
        b=deyAbIrJhNV33lsCuTilsgaUo84MINPfO/OkNgmJj7179FoQDgiIih541lwFA++aq3
         tJXIGS1E/MN/G2HWXctMNVHnWR2UgaCGqBV/8O2pWwjCRz/N5VmfUjOqSt3sUdOIKsiq
         J6MV44PQtbB6BIx68mxYzbuzph7CQjbPpyGWZBCSwUVprbLfCQGu2N8FRVx3GDSMrWnd
         cczzkxKiIHqCzfJ4xZR/LsJM/10m4Sk/mtH8Molh1vN4Iw3HBwPbi9dY5LrGJc9fKrr7
         hA5XFR8bo6VSePNe/0VQDu3C/DhkixunZWVH8P0wmkgA9UenRYsidHaxn/M9hgNzDTTj
         pjbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:subject:message-id:date:from:mime-version:dkim-signature
         :arc-authentication-results;
        bh=ohLyCn/Yg5rNoazl/EaL9SLTjNIW69sTEix8YifDLu8=;
        b=BOTBnKzto5KropiXkBh3QRbTgP8hzQQhpNcq4OaWMOaoWgOiOX9rFSNijG280q/oUn
         R150VMjpwqH4Zz8eKCEIjaMKwxiRanKmBAotyW8MMkXM+jg5BVUJgcclCQjHn6pkEFg0
         FQSnLGs7DiCmgOYphP1k3x73t/pX7UJMRkcXQiExi/TJsC45pFFIo5bv+EdtOEC+mcqa
         /JpsaiEMFa6q0HtLHm6Ym10RnUScgocGwVI/6Qi8QIvcw4Wba5XyyzCfrYoJ2uRjrM3m
         a4O+uIXrXXZZLwrCFcmudeeHtmSGlwcq6OTevcX7ncoZXYdBhhBsMzc+VH1eL3R08NkO
         pRCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HO45pFmL;
       spf=pass (google.com: domain of l4stpr0gr4m@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=l4stpr0gr4m@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HO45pFmL;
       spf=pass (google.com: domain of l4stpr0gr4m@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=l4stpr0gr4m@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227YZb+sZnsOqd7ZaHhibRuRBDi9QfrqPxr8dD2Qn6KZYOzb0sWPAwGsUXblRC3z/YhNGR7zA7PwQnLGESIqb4c=
MIME-Version: 1.0
From: Kangmin Park <l4stpr0gr4m@gmail.com>
Date: Tue, 6 Feb 2018 22:39:45 +0900
Message-ID: <CAKW4uUwhr4ypwQacnwQEEH0aZD+R2S_jMf+w2J9SdsPVBsziuA@mail.gmail.com>
Subject: [PATCH] Resolve RF Type mismatch
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591659081270914487?=
X-GMAIL-MSGID: =?utf-8?q?1591659081270914487?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Match rf_type of staging/rtlwifi/wifi.h and staging/rtl8723bs/include/rtw_rf.h,
and update some additional code that resulted.

Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---


diff --git a/drivers/staging/rtl8723bs/hal/odm.h
b/drivers/staging/rtl8723bs/hal/odm.h
index 87a76ba..dbb78fe 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -511,14 +511,15 @@ typedef enum tag_ODM_RF_Path_Bit_Definition {


 typedef enum tag_ODM_RF_Type_Definition {
- ODM_1T1R = 0,
- ODM_1T2R = 1,
- ODM_2T2R = 2,
- ODM_2T3R = 3,
- ODM_2T4R = 4,
- ODM_3T3R = 5,
- ODM_3T4R = 6,
- ODM_4T4R = 7,
+ ODM_1T1R = 0,
+ ODM_1T2R = 1,
+ ODM_2T2R = 2,
+ ODM_2T2R_GREEN = 3,
+ ODM_2T3R = 4,
+ ODM_2T4R = 5,
+ ODM_3T3R = 6,
+ ODM_3T4R = 7,
+ ODM_4T4R = 8,
 } ODM_RF_TYPE_E;


diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
index b162559..20dcdcd 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
@@ -64,10 +64,22 @@ static void Init_ODM_ComInfo_8723b(struct adapter *Adapter)

  if (pHalData->rf_type == RF_1T1R) {
  ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_1T1R);
- } else if (pHalData->rf_type == RF_2T2R) {
- ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_2T2R);
  } else if (pHalData->rf_type == RF_1T2R) {
  ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_1T2R);
+ } else if (pHalData->rf_type == RF_2T2R) {
+ ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_2T2R);
+ } else if (pHalData->rf_type == RF_2T2R_GREEN) {
+ ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_2T2R_GREEN);
+ } else if (pHalData->rf_type == RF_2T3R) {
+ ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_2T3R);
+ } else if (pHalData->rf_type == RF_2T4R) {
+ ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_2T4R);
+ } else if (pHalData->rf_type == RF_3T3R) {
+ ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_3T3R);
+ } else if (pHalData->rf_type == RF_3T4R) {
+ ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_3T4R);
+ } else if (pHalData->rf_type == RF_4T4R) {
+ ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_4T4R);
  }

  pdmpriv->InitODMFlag = ODM_RF_CALIBRATION|ODM_RF_TX_PWR_TRACK;
diff --git a/drivers/staging/rtl8723bs/include/rtw_rf.h
b/drivers/staging/rtl8723bs/include/rtw_rf.h
index f9becab..7ef113d1 100644
--- a/drivers/staging/rtl8723bs/include/rtw_rf.h
+++ b/drivers/staging/rtl8723bs/include/rtw_rf.h
@@ -146,12 +146,17 @@ enum PROTECTION_MODE {

 /* 2007/11/15 MH Define different RF type. */
 enum RT_RF_TYPE_DEFINITION {
- RF_1T2R = 0,
- RF_2T4R = 1,
+ RF_1T1R = 0,
+ RF_1T2R = 1,
  RF_2T2R = 2,
- RF_1T1R = 3,
- RF_2T2R_GREEN = 4,
- RF_MAX_TYPE = 5,
+ RF_2T2R_GREEN = 3,
+ RF_2T3R = 4,
+ RF_2T4R = 5,
+ RF_3T3R = 6,
+ RF_3T4R = 7,
+ RF_4T4R = 8,
+
+ RF_MAX_TYPE = 0xF
 };

 u32 rtw_ch2freq(u32 ch);
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 51d48de..520d2f6 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -3299,7 +3299,7 @@ static int cfg80211_rtw_sched_scan_stop(struct
wiphy *wiphy,

 static void rtw_cfg80211_init_ht_capab(struct ieee80211_sta_ht_cap
*ht_cap, enum nl80211_band band, u8 rf_type)
 {
-
+#define MAX_BIT_RATE_40MHZ_MCS23 450 /* Mbps */
 #define MAX_BIT_RATE_40MHZ_MCS15 300 /* Mbps */
 #define MAX_BIT_RATE_40MHZ_MCS7 150 /* Mbps */

@@ -3338,7 +3338,7 @@ static void rtw_cfg80211_init_ht_capab(struct
ieee80211_sta_ht_cap *ht_cap, enum

  ht_cap->mcs.rx_highest = cpu_to_le16(MAX_BIT_RATE_40MHZ_MCS7);
  }
- else if ((rf_type == RF_1T2R) || (rf_type ==RF_2T2R))
+ else if ((rf_type == RF_1T2R) || (rf_type == RF_2T2R) || (rf_type ==
RF_2T2R_GREEN))
  {
  ht_cap->mcs.rx_mask[0] = 0xFF;
  ht_cap->mcs.rx_mask[1] = 0xFF;
@@ -3346,6 +3346,14 @@ static void rtw_cfg80211_init_ht_capab(struct
ieee80211_sta_ht_cap *ht_cap, enum

  ht_cap->mcs.rx_highest = cpu_to_le16(MAX_BIT_RATE_40MHZ_MCS15);
  }
+ else if ((rf_type == RF_2T3R) || (rf_type == RF_3T3R))
+ {
+ ht_cap->mcs.rx_mask[0] = 0xFF;
+ ht_cap->mcs.rx_mask[1] = 0xFF;
+ ht_cap->mcs.rx_mask[2] = 0xFF;
+
+ ht_cap->mcs.rx_highest = cpu_to_le16(MAX_BIT_RATE_40MHZ_MCS23);
+ }
  else
  {
  DBG_8192C("%s, error rf_type =%d\n", __func__, rf_type);
