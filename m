Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELv9a7eeXLJDoml2R0DGYgaALJaXvISTuCrxP2rrBeehVHJFAQdYwSauiyr0kj7yeQZ3EgVa
ARC-Seal: i=1; a=rsa-sha256; t=1519881580; cv=none;
        d=google.com; s=arc-20160816;
        b=vBim9uU2tRybNIkZfrMsEKJq0UJThWhQHlcq3sHEX8hYuiOG0gCAVHSYohQfAPDMqP
         e+n9lPhsHfmbhK8AmblSMjhjYomE5ZDlMHOwFNZ86RUsnNQDfwDDTxgph7T6Y//YgNXZ
         T4zPs8yBs+DaButwN9ZWPKaYKNUHhMXXvmhRfQ8p3W6gymnaL/Ai/XBWTwGmnpAhBvsy
         1WHNqm8J0aph033spyU8Ikc4/GY/yT+sLwlBp0IdRVAvUdA6dRsOCCl9x+64Wf5U34RV
         sVFO+o2M/43RdpAAPmi9PwI/5jYvaCs1jG9L8MVlYAVxlHPAscCNEp/rnNDOaPCQnAZc
         O2LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=jPCi4u/ucGx5Jr0VCzrqVl6hEfg1NwHFtSqQ0NMnI2M=;
        b=cSe3IQIISmU+i48ulFrfEwrlKdunD12J7tqPoMS7uk1fwNaWRAMBymIeaiQdmIsPha
         encvrwf7M+byq6L1ur5Abeau3OCThcfdPleDnLqVP2ijj/9A9o50CuG4xVLov7QRujg9
         u/pFKCZj/wKatRaJv/1g0h0lz2Eby1mvNvXHP2MM37EScOylxsLq/8FaXaXtgY5raftd
         Qh7KJqnj4bS9Wvy/ZdkTNg80YifJwjiFQWdthP0Pv1C8Uuhyqc01Ltsp1AOPWpXdHFB4
         xHyi32H1qPn6UU+RnOPUDseul4oXLlDGnfksyntQANr4cDbX5g6emQx7V4Evd6d5gxfP
         ughw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 2/5] staging: ks7010: Replace SSID_MAX_SIZE with IEEE80211_MAX_SSID_LEN.
Date: Wed, 28 Feb 2018 21:19:08 -0800
Message-Id: <20180301051911.1314-2-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180301051911.1314-1-quytelda@tamalin.org>
References: <20180301051911.1314-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:9V+4iqSPP68LoRK+vBILjwKT7xGIHtYlsmFdvufvgN8uADLDlYd
 3eJydhBdhH34mHfjNApajXInIwEcTfGt88Byq8fRROtPE90pJVl0kVzKdCxnBZuYw8mBlHz
 iCe295juNPXmW2fFHmhNPyv3aJ5e5490IiU4X9LHurcXVzdFVy2jrp5WfLC9YYFtHZ3Ly4Q
 4lc6A96sw0jjYWlgKzBvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9VzqNW8JUpo=:OM7ua3VER264UqV64vFMqB
 gZLj7cMxPmKqPytrzGSy/91Deeq3aqU5CJslN1wTrb6MW4x4CJVoVFcmEyXztfT9NHdF2N2xh
 3VklVdj7i891Ve2AvLD8lRE550LtRZQOChIp1E7BDEpALAuTROkCinuqNJ3Is3XzjdS7Fr2/L
 Nv0fzrwnfbZoAOb3U57rzJnnw+PX5/ZMb06DXUUvGvClRxk7W0HRcxcK8wJaomUqpptv6legz
 Z7H9JnfINIJWKceUNbOXTUJAex7jKYcBFmxPdp/DQ0s2JVt6nt6hcCqW4B5STv8tt3unxMsWZ
 3GajbueAkrP2wr1HOJt5T9yHIshHlW2l0UU5gUXvUnzWo6k02Lv0DcT633UsEW0o/Fp2phxSh
 QvMkNqa/QWZCCmw/M0t5CPQ6R3w1K9QydTgaTGx9Cv4kI8Efv3ZWlijctqnbCe+FznXhoQH8N
 yO3Cz0C7CiPL23/0+PnUz+VZjDpj6oTzAgSe4NGBPryIds8VyYJxkvELi3ieZjoXZG2TZEO6s
 y0RnMv4+q9XCDJEayQkLLEbR6cQtjZnCrfH11cqjeASMMs/Q7W35v3t+Vy3UxrlM0X6YzZJZ9
 9e4QYKMvsHwROlSTax0BiLDWgsGYXin4TsZioI0DZo7OAB8UKc9td6dFShN3rpbN0wU8wq2QI
 74LHL63ot4sDHA6nDrzLblHbjhQUIt+2b+FxSwysIU9SFf7s2rNRjh8fd89GQBirB0BVtBBqv
 tbJaCffwHta/ax0KzwIFbbjGZtsALeu0zca5kg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593711348040953526?=
X-GMAIL-MSGID: =?utf-8?q?1593711348040953526?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SSID_MAX_SIZE is a constant defined locally in ks_hostif.h, but it should
be replaced with IEEE80211_MAX_SSID_LEN from the kernel's 802.11 header,
of which it is just a copy.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
Reviewed-by: Tobin C. Harding <me@tobin.cc>
---
 drivers/staging/ks7010/ks_hostif.c | 4 ++--
 drivers/staging/ks7010/ks_hostif.h | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 67cf32433023..59f7c4e422d3 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -253,12 +253,12 @@ int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
 	while (bsize > offset) {
 		switch (*bp) { /* Information Element ID */
 		case WLAN_EID_SSID:
-			if (*(bp + 1) <= SSID_MAX_SIZE) {
+			if (*(bp + 1) <= IEEE80211_MAX_SSID_LEN) {
 				ap->ssid.size = *(bp + 1);
 			} else {
 				DPRINTK(1, "size over :: ssid size=%d\n",
 					*(bp + 1));
-				ap->ssid.size = SSID_MAX_SIZE;
+				ap->ssid.size = IEEE80211_MAX_SSID_LEN;
 			}
 			memcpy(ap->ssid.body, bp + 2, ap->ssid.size);
 			break;
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 9ac317e4b507..b46aa94c0d48 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -225,10 +225,9 @@ struct hostif_start_confirm_t {
 	__le16 result_code;
 } __packed;
 
-#define SSID_MAX_SIZE 32
 struct ssid_t {
 	u8 size;
-	u8 body[SSID_MAX_SIZE];
+	u8 body[IEEE80211_MAX_SSID_LEN];
 	u8 ssid_pad;
 } __packed;
 
-- 
2.16.2
