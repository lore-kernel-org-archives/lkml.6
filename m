Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELvhD62XhAfOsD9kxO64jc11qhGKSBJhYi2q0G1NhcDus3LJnakdYCU9jsbftfE51vOp0ejO
ARC-Seal: i=1; a=rsa-sha256; t=1522140092; cv=none;
        d=google.com; s=arc-20160816;
        b=n8k3NfKJMZDGWUBbtXHzySb5Hn7U3WyH4AkM69qp5LwCa6W1LBP+IkcOwTuSNLdRdA
         0Tcy5f8ILhbltm7Lsu5LjApw0Rm8F0ZdUZr2dc7PWoZiRNT3d6nXvGBG18jjLsUzugJu
         I6p9hXSIXCpoyVtJZNUE6/wjSz2Gd+cptEt3eKaE5h7+PIFtW8wkVnHdDAtIwWz5kkB5
         Q4ygQkLUTAlSdSMlhE73FJWZImYEPi18pVHhsn7NLuscccEHOTPKggvu5tCo3djKLkBz
         g6CmTbJtZin0DCktJa6hyu1yr/bAuxaWERfl6iunszPabIH1vWVLz0vXaPV6qxDGM5DO
         xVGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=cHOHNeB1L4NTTQdtlxf2MK5Z391+uHiAzKUkF/jw7CI=;
        b=WreNlBojn9fL1lLKMRDZHf1fb/vPetnatYPlsZ8zGXUMbHpt9/LPcmg0mKabbzL0cj
         CI87h65QOcLj8qk6pwzYO3Sup0+gAwbxervU8R8QlO59hnTrdXGoqDIWJl116RkdR1ZS
         AMzt1EvMSQrCnRo8p9mSTr11R6V+J7jCz+WbiK0SA9VbVgRl4nIJL3IP5UcIEVsTu8ti
         WU05atGFGcKTaDPUVjYSg8+q5g1xlbxmsQ8Dy7zyovNH5udseAJ64XpgCVduIlOMUNO0
         Xo4g5snLsySZjYZvfeuJzP7fD/di2GwMmGPgcd1lRMNuLWV+6XiP8vzUlJ8ltYdeNbTP
         QtOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 10/23] staging: rtl8723bs: Fix IEEE80211 authentication algorithm constants.
Date: Tue, 27 Mar 2018 01:41:02 -0700
Message-Id: <20180327084115.16129-10-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:g1hRnAbZZI5mg2h9vx/It56gQ3gUiCykcT3OuoiVXL8f6140jDw
 KiK4y9u5erFAMf/v2mUA6g0Bm9T3QLeENLksye5Nm7Y1jl4TN9aqbcXipcqzJaAR9ivIuv7
 Bw3HPtKKYZ8nFNPJYFslADBBiishwStY0NHEkR/kDPqaCLk3IlVSrg4S7IrfNGl4Kz8sZ3I
 6GiEmVyanhvi3ZR21fydA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gSnjNdmIENs=:e0iiSCVkI7QGAe2pFhWDPN
 9g8m7C8pkiWHEiW4nHw5mhR5kZrg2/sKc2x/TfC7ZXthiOmew1OOldTETxBPINhdvIgJymbyY
 RjAGcguHGQAk1THiv7hfo8c4wuBNXJeBuGcGJ1txNJI1kYtga7/AGNExQbEWUNwrTjujEj89Q
 ZE9I5FiHuwjnrpaPMrQpL/iN94HEzgHf6hhhPmZliOKY2735onfGudiFV0RWSFUqvBqb7tjSd
 4Er0pTF+VdNt8Pw4Fq5naWxN6gVzISEgg3CELZm3kSnhHqdi06JST8th7WIraG11eDgsawUOs
 BofawyJkMA18F1tR7D3/oylwhKcVRKLb5/ccv2de4ivIncJOrHvvB493SZM9DK8S+SYDYt0Sd
 +eTRn63yhHkqWIjy9M9Jdw4TML3HfMIobMBL+kd7Sai8ItXixRy9u8UcOiHIRX/nLVLWe8S2/
 Pnme+KQv2Vd+EHZIy+YxraGHNcSIxWzYtrhhvVF4MRzlSeKPyNOyVyXEmMWDRMbflLApzAPcp
 EVnkIgIcTvpp+O/cts8y3qK50nfxt/sbAyMa7URK1d9RhlqC7l2yjCv8XHRGHJt1se2mk8kzV
 b1H8nQIYRyCA7u6SHQY5ouWlz70m3h8j25K18Sr9QkoTo4SoOUp0MD7YMeavxlUWLWcF4SlAC
 xwLJursgvnf2exQwlzDLEqOm7lubvx41ggA+p2qTqP+fmpJNWDT7Eh9CIlfYgz98RZ2zpNysX
 VWVEt6eI1AQOhOwwV5fRTc4WAy8YSq1CAOdVZQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079569139754041?=
X-GMAIL-MSGID: =?utf-8?q?1596079569139754041?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This driver's local ieee80211 include file defines the constants
AUTH_ALG_* to represent authenication algorithm options.  However,
these constants are defined in 'linux/ieee80211.h' as WLAN_AUTH_*,
and have the correct values.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/include/ieee80211.h  |  4 ----
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 16 ++++++++--------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 2c7597ad0470..a353dc9b883a 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -84,10 +84,6 @@ enum {
 #define IEEE_PARAM_IEEE_802_1X				6
 #define IEEE_PARAM_WPAX_SELECT				7
 
-#define AUTH_ALG_OPEN_SYSTEM			0x1
-#define AUTH_ALG_SHARED_KEY			0x2
-#define AUTH_ALG_LEAP				0x00000004
-
 #define IEEE_MLME_STA_DEAUTH				1
 #define IEEE_MLME_STA_DISASSOC			2
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 32dcee9a1451..b26533983864 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -476,26 +476,26 @@ static int wpa_set_auth_algs(struct net_device *dev, u32 value)
 	struct adapter *padapter = (struct adapter *) rtw_netdev_priv(dev);
 	int ret = 0;
 
-	if ((value & AUTH_ALG_SHARED_KEY) && (value & AUTH_ALG_OPEN_SYSTEM)) {
-		DBG_871X("wpa_set_auth_algs, AUTH_ALG_SHARED_KEY and  AUTH_ALG_OPEN_SYSTEM [value:0x%x]\n", value);
+	if ((value & WLAN_AUTH_SHARED_KEY) && (value & WLAN_AUTH_OPEN)) {
+		DBG_871X("wpa_set_auth_algs, WLAN_AUTH_SHARED_KEY and WLAN_AUTH_OPEN [value:0x%x]\n", value);
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeAutoSwitch;
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Auto;
-	} else if (value & AUTH_ALG_SHARED_KEY)	{
-		DBG_871X("wpa_set_auth_algs, AUTH_ALG_SHARED_KEY  [value:0x%x]\n", value);
+	} else if (value & WLAN_AUTH_SHARED_KEY)	{
+		DBG_871X("wpa_set_auth_algs, WLAN_AUTH_SHARED_KEY  [value:0x%x]\n", value);
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 
 		padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeShared;
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Shared;
-	} else if (value & AUTH_ALG_OPEN_SYSTEM) {
-		DBG_871X("wpa_set_auth_algs, AUTH_ALG_OPEN_SYSTEM\n");
+	} else if (value & WLAN_AUTH_OPEN) {
+		DBG_871X("wpa_set_auth_algs, WLAN_AUTH_OPEN\n");
 		/* padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled; */
 		if (padapter->securitypriv.ndisauthtype < Ndis802_11AuthModeWPAPSK) {
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
 		}
-	} else if (value & AUTH_ALG_LEAP) {
-		DBG_871X("wpa_set_auth_algs, AUTH_ALG_LEAP\n");
+	} else if (value & WLAN_AUTH_LEAP) {
+		DBG_871X("wpa_set_auth_algs, WLAN_AUTH_LEAP\n");
 	} else {
 		DBG_871X("wpa_set_auth_algs, error!\n");
 		ret = -EINVAL;
-- 
2.16.3
