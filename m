Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1442588-1517932690-2-16234401171566548084
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517932689; b=Zj12lnkxnvQmwtkYGokrv9M0yNzOAwldrhtzwB3yaWUKXey
    R5SDkX2xGoXrzQYxqhBjeIM2pMS3sirbKoswxAU8MsgKhnSLJm/EVnOKCJNg3DZJ
    1ZKb4dYIHNS7f8ACCDzD1l8XUjESc9UrXGe0LDjBDmq3EIsc/yXnSFNwiwCuDrqn
    Pt+riawnO11YCkyr3R9rOfVDzDkgxNCs5MrfODarWh3tDjVprDRO0w8EQ9Tk+iPS
    C84PVDTO2hb+V9tcLURWZ5l6CayUm9J7bglbWw8OllDqr1/03fujWD1rN0Al+cyq
    HjussBKfj6LsEDkXfN/yPb+h1zpkWhtTJO2HPYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517932689; bh=b
    F8jJUPVgi1a1jFreGw3cyCgb4YaMW2IzS4gYNY5l8g=; b=RVJdl4T18JEKJ21WY
    hOjBwXwxzxQSsyOnVWhmJmuPkfaYDu7kEmGl+MYdzWT3gmxn6b8j1kjvgJpCYlqP
    4THrr5bZkRaYB9IRgv/Folbig4M3IvPhGugkdRRqk3T8cmibKBd5mIp+AvGEF80V
    qwATsEMF1UuS+BZSPfqTPGwlASrb6jAjXYF3IhYstq9i5Du1IPGQkQaVR7eKw6M1
    rKaT4QV4hZO+WKOk1zyRDfIWiJank5sbHMI0mf1Eejtr4AGz6MuFXxscvsE9MQYP
    rn+zkg50K8/qw8MX4DKdjaTp9G5pyvBVOVLWsq+oMPHzhXZrmRETcreO5oGmczGM
    Q+VPw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iMm9qlnE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=idFaAyV5;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iMm9qlnE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=idFaAyV5;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x224uubXSy/U102HkHcziwf1oj5zjwc6lAf6sY8W0sXzei0q4MyGKYYN542ZkMimOuil28ivqXA==
From: Kangmin Park <l4stpr0gr4m@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH] Resolve RF Type mismatch
Date: Wed,  7 Feb 2018 00:57:13 +0900
Message-Id: <1517932633-7832-1-git-send-email-l4stpr0gr4m@gmail.com>
X-Mailer: git-send-email 2.7.4
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
 justin@jvreeland.com, davem@davemloft.net, hdegoede@redhat.com,
 hadess@hadess.net, pr0gr4m <l4stpr0gr4m@gmail.com>, joe@perches.com,
 Larry.Finger@lwfinger.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: pr0gr4m <l4stpr0gr4m@gmail.com>

---
 drivers/staging/rtl8723bs/hal/odm.h               | 17 +++++++++--------
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c       | 16 ++++++++++++++--
 drivers/staging/rtl8723bs/include/rtw_rf.h        | 15 ++++++++++-----
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 12 ++++++++++--
 4 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index 87a76ba..dbb78fe 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -511,14 +511,15 @@ typedef enum tag_ODM_RF_Path_Bit_Definition {
 
 
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
 } ODM_RF_TYPE_E;
 
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
index b162559..20dcdcd 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
@@ -64,10 +64,22 @@ static void Init_ODM_ComInfo_8723b(struct adapter *Adapter)
 
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
 	}
 
 	pdmpriv->InitODMFlag = ODM_RF_CALIBRATION|ODM_RF_TX_PWR_TRACK;
diff --git a/drivers/staging/rtl8723bs/include/rtw_rf.h b/drivers/staging/rtl8723bs/include/rtw_rf.h
index f9becab..7ef113d1 100644
--- a/drivers/staging/rtl8723bs/include/rtw_rf.h
+++ b/drivers/staging/rtl8723bs/include/rtw_rf.h
@@ -146,12 +146,17 @@ enum PROTECTION_MODE {
 
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
+
+	RF_MAX_TYPE = 0xF
 };
 
 u32 rtw_ch2freq(u32 ch);
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 51d48de..520d2f6 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -3299,7 +3299,7 @@ static int cfg80211_rtw_sched_scan_stop(struct wiphy *wiphy,
 
 static void rtw_cfg80211_init_ht_capab(struct ieee80211_sta_ht_cap *ht_cap, enum nl80211_band band, u8 rf_type)
 {
-
+#define MAX_BIT_RATE_40MHZ_MCS23	450	/* Mbps */
 #define MAX_BIT_RATE_40MHZ_MCS15	300	/* Mbps */
 #define MAX_BIT_RATE_40MHZ_MCS7		150	/* Mbps */
 
@@ -3338,7 +3338,7 @@ static void rtw_cfg80211_init_ht_capab(struct ieee80211_sta_ht_cap *ht_cap, enum
 
 		ht_cap->mcs.rx_highest = cpu_to_le16(MAX_BIT_RATE_40MHZ_MCS7);
 	}
-	else if ((rf_type == RF_1T2R) || (rf_type ==RF_2T2R))
+	else if ((rf_type == RF_1T2R) || (rf_type == RF_2T2R) || (rf_type == RF_2T2R_GREEN))
 	{
 		ht_cap->mcs.rx_mask[0] = 0xFF;
 		ht_cap->mcs.rx_mask[1] = 0xFF;
@@ -3346,6 +3346,14 @@ static void rtw_cfg80211_init_ht_capab(struct ieee80211_sta_ht_cap *ht_cap, enum
 
 		ht_cap->mcs.rx_highest = cpu_to_le16(MAX_BIT_RATE_40MHZ_MCS15);
 	}
+	else if ((rf_type == RF_2T3R) || (rf_type == RF_3T3R))
+	{
+		ht_cap->mcs.rx_mask[0] = 0xFF;
+		ht_cap->mcs.rx_mask[1] = 0xFF;
+		ht_cap->mcs.rx_mask[2] = 0xFF;
+
+		ht_cap->mcs.rx_highest = cpu_to_le16(MAX_BIT_RATE_40MHZ_MCS23);
+	}
 	else
 	{
 		DBG_8192C("%s, error rf_type =%d\n", __func__, rf_type);
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
