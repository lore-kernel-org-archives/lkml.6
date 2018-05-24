Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoVvh4Vq1PVTaHEmMBR27BffsjsfFInpbzagpu7aNpnB9UYgcZu4/OxpJ2L9ZHaGzqRaX7U
ARC-Seal: i=1; a=rsa-sha256; t=1527156190; cv=none;
        d=google.com; s=arc-20160816;
        b=rqi6RZ4jnwH78HzVLEzLtLFRUT0Yw23GbXcFHItg9j4TlAaSfpb8s1iUged/RLg5/Q
         r02k8+HwVuUW8ZYcWk9sc7h0Kz6Jxj/+KbcgVvm3WbesOTgmsAZPhb/B1tcPKo4z8xk/
         rE4zOPef29acokl9pgrhJ8EURYHQkjBbDS5pv5a2EgjEMRgaSIiQgucikk4uWDbX4V2Y
         8cXNukobvtXJm61MhUHTAthoptIXByMx6brI8vKU85axpnSiDZ8Sv8VzYtosbIEQnKXl
         n+cGRKp7mXyP1DQcJgFc09iP8VN4CYg3tAxXlHLTDth06zHVSXVGpQ+Fb5qrlSl+oRyd
         AHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=hLQRJ1KpYG21WnTdOaPbH1NNK8KnkwMswXuSgsicr5E=;
        b=YIMEj44xLaCvOPu4mtjzaWcb0c1U2nPY2Gv4NKW619qurlMbGFhewjcTFeldSFyQgI
         Uw66ZVxc2+YOgwd5hZc+jD7zvfRv5vEn8FLofJ4iHK4Il1kTrOTxeruJBIWlne883Lkg
         WwbJa1Mjl8zXbmMl5KzIweZJQ3o7heWdnQsDVMeibyV0x3VzEEwtsMqnodxEYcaLlgmF
         YRbqWWdBKKl5Ml41y/Ry796XcgaOXBbs2LrQi5XHg/BW4TbNROh5FPaG/IdmPVZ3HvU8
         udoSGCDwCk/Bzmrwrjp+NnibubOoofI+V7tHA1uFt2atwIA4KT/+vgg5XntVttV4mGot
         UAqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LYKX2rO5;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LYKX2rO5;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>,
	"Tobin C. Harding" <me@tobin.cc>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 095/161] staging: ks7010: Use constants from ieee80211_eid instead of literal ints.
Date: Thu, 24 May 2018 11:38:40 +0200
Message-Id: <20180524093029.795278427@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338826494174524?=
X-GMAIL-MSGID: =?utf-8?q?1601339329330986393?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quytelda Kahja <quytelda@tamalin.org>

[ Upstream commit dc13498ab47fdfae3cda4df712beb2e4244b3fe0 ]

The case statement in get_ap_information() should not use literal integers
to parse information element IDs when these values are provided by name
in 'enum ieee80211_eid' in the header 'linux/ieee80211.h'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
Reviewed-by: Tobin C. Harding <me@tobin.cc>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/ks7010/ks_hostif.c |   31 +++++++++++++++----------------
 drivers/staging/ks7010/ks_hostif.h |    1 +
 2 files changed, 16 insertions(+), 16 deletions(-)

--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -242,9 +242,8 @@ int get_ap_information(struct ks_wlan_pr
 	offset = 0;
 
 	while (bsize > offset) {
-		/* DPRINTK(4, "Element ID=%d\n",*bp); */
-		switch (*bp) {
-		case 0:	/* ssid */
+		switch (*bp) { /* Information Element ID */
+		case WLAN_EID_SSID:
 			if (*(bp + 1) <= SSID_MAX_SIZE) {
 				ap->ssid.size = *(bp + 1);
 			} else {
@@ -254,8 +253,8 @@ int get_ap_information(struct ks_wlan_pr
 			}
 			memcpy(ap->ssid.body, bp + 2, ap->ssid.size);
 			break;
-		case 1:	/* rate */
-		case 50:	/* ext rate */
+		case WLAN_EID_SUPP_RATES:
+		case WLAN_EID_EXT_SUPP_RATES:
 			if ((*(bp + 1) + ap->rate_set.size) <=
 			    RATE_SET_MAX_SIZE) {
 				memcpy(&ap->rate_set.body[ap->rate_set.size],
@@ -271,9 +270,9 @@ int get_ap_information(struct ks_wlan_pr
 				    (RATE_SET_MAX_SIZE - ap->rate_set.size);
 			}
 			break;
-		case 3:	/* DS parameter */
+		case WLAN_EID_DS_PARAMS:
 			break;
-		case 48:	/* RSN(WPA2) */
+		case WLAN_EID_RSN:
 			ap->rsn_ie.id = *bp;
 			if (*(bp + 1) <= RSN_IE_BODY_MAX) {
 				ap->rsn_ie.size = *(bp + 1);
@@ -284,8 +283,8 @@ int get_ap_information(struct ks_wlan_pr
 			}
 			memcpy(ap->rsn_ie.body, bp + 2, ap->rsn_ie.size);
 			break;
-		case 221:	/* WPA */
-			if (memcmp(bp + 2, "\x00\x50\xf2\x01", 4) == 0) {	/* WPA OUI check */
+		case WLAN_EID_VENDOR_SPECIFIC: /* WPA */
+			if (memcmp(bp + 2, "\x00\x50\xf2\x01", 4) == 0) { /* WPA OUI check */
 				ap->wpa_ie.id = *bp;
 				if (*(bp + 1) <= RSN_IE_BODY_MAX) {
 					ap->wpa_ie.size = *(bp + 1);
@@ -300,18 +299,18 @@ int get_ap_information(struct ks_wlan_pr
 			}
 			break;
 
-		case 2:	/* FH parameter */
-		case 4:	/* CF parameter */
-		case 5:	/* TIM */
-		case 6:	/* IBSS parameter */
-		case 7:	/* Country */
-		case 42:	/* ERP information */
-		case 47:	/* Reserve ID 47 Broadcom AP */
+		case WLAN_EID_FH_PARAMS:
+		case WLAN_EID_CF_PARAMS:
+		case WLAN_EID_TIM:
+		case WLAN_EID_IBSS_PARAMS:
+		case WLAN_EID_COUNTRY:
+		case WLAN_EID_ERP_INFO:
 			break;
 		default:
 			DPRINTK(4, "unknown Element ID=%d\n", *bp);
 			break;
 		}
+
 		offset += 2;	/* id & size field */
 		offset += *(bp + 1);	/* +size offset */
 		bp += (*(bp + 1) + 2);	/* pointer update */
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -13,6 +13,7 @@
 #define _KS_HOSTIF_H_
 
 #include <linux/compiler.h>
+#include <linux/ieee80211.h>
 
 /*
  * HOST-MAC I/F events
