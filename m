Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELtSfCjI0SSdoxiG5+pRPVDiLHPAH3DkJJy8YWhmbjgXBzxyAz8+0paoH9maNrRi+5LT7lVd
ARC-Seal: i=1; a=rsa-sha256; t=1519881575; cv=none;
        d=google.com; s=arc-20160816;
        b=d1mofURooDvvsKXG6Z85nPQgwTh2Qw5EYCPg+wm+qinlS1KNvO5pM2tCJ2yRbCDDxf
         W1twmMB5A7NF064F8Dt93MZlgk7G1u2IVKZcXc3Ej72/1Yoj4SSf5T90GFyJ5sPSSONw
         iOWuIwFZM+Ga9iJHXJnlyT5WuAAx73jmEUyjgWp0bIBCp0BD2zrTVzYyFEYDXdsslYgU
         PPGyUPU17Uo6cM1k0lUk/UbEvyu4Fx4249L1l3M4rFZTQZOvA0u2rPPk4vZeE/2JPylI
         ntrVUsBS7dk6aTML8LHxzAUgFqRFRy/hlq+bcioFFwONoTbYt83IKUXW40pcAKO58zYC
         sFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=261A9nTeuZZXzj8hTmduCw7KGCnjQ39C0P+xwgPh4do=;
        b=jIfYuXOwkw7r57N1UfVY3ddNaVHkih0j9uvfW8IRWeHqkF6rkCVvOMHSe6WUSw6MEX
         q+HdLrAdw9mIW9xldAAbH6F1ednYSwToS7Philm5PaSuoN3lb3rebH9+V1xsca4+fYd1
         n+T4XHDeyth4CBbUfwenZwe62cnbgNhOMykU52oY92FrA97PU/GLULYvGTBD6HKog+QJ
         czKg9Wg+Xp9X2AKVn1mbep4BmfR76NX0Z6M8lxGi06MwOWKd54LII82VauooB2dnxUAk
         rJ5rU9bDJrAlYDshSAz7COEXF1osk5zkfpwMHnr+iyWtwOxe8X6x23xvaQecDeVauUwd
         wZmQ==
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
Subject: [PATCH 1/5] staging: ks7010: Use constants from ieee80211_eid instead of literal ints.
Date: Wed, 28 Feb 2018 21:19:07 -0800
Message-Id: <20180301051911.1314-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
X-Provags-ID: V03:K0:v6IoT7x7GBvnitzlS4EE+W8/tdk/vLv/6H5wP/ZUjkT4md9C612
 LOvSyMWzIt9lSfkxghYzq9gjx0XUKtsLfnPBRJGhfN/CUnUHUTZ6m04umarfOxhGJU0wQlz
 XofKRmvPZSuqyvhTzUVcEUoYIKdz3P3MzjcTdzro20NxyS3tzzFiacZIHvn5Z03n55REDxX
 GpBVuF6xkv0/eoiBOfXeA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n6S2YUgq+4Y=:P3YIzpmMdRrIWb8hzubTra
 pVC8YlfcdaJSWUDTs86b0UWoRkcfV30wyFjhBDIUxFnvIXHxiVBbtCm4uGKYF0rRdnSVLkVU1
 /FGU+k+Edp+WB2xVCUFxi7us/JykkdqDSaQRnabDiuRPoufzeC3E14uhnXv1OFjJgUbM25tLm
 VfA7ZkQf/Iu3jeiiWBqIkzNHH9I8wQXSzqXlMUj4aSLIdhJU/XbqMwrrKRcw6KeS+NZXiI7Yv
 XRYHa0CiGUZwSut4tzcKLzge5sdbPkR4n1Uee15iosSWQFKHQX0HwF8I6+aOZEY4ZXCVTzPdW
 I7jMM0D1zNyNGLLNfKj2CyFB13cVY+Khd83fKaC4kngFL+3R2D33mNu0iYlA1f2EfTu+MG+fd
 EIhT+X4wgy79jY8sdqkQZkfKw946szdxfWA094NigPGlzuVHeKnlSeccVcSja7AyIPIccSG45
 Bp2mQvSnjZJvHiuIfCnshkVxxWLwnzqjFxbXqoL8QrF3ArYJafd8yCcXOpZGWUDRmY4G7l8lv
 /bSvTdYNleIUWdHoeg42XLyn5dUARQ68rxDqm5uH6Ju0aYdJsfZX5LXEcRxywfRfyy1QEWaua
 YypWifnMElu+HfRqmOOZ/sMmwTiR36f6HlNPoBXs3zgvhS7kt5UJus/5HS+tkE9E9HDRc93uD
 QynxS0A30HjjduUjKnqiapWzfD+MfsTmTekiowCyOESJc8nPyMX8vuJVMCfeoaZu36/mbCluA
 x5BP5HqvuuLS1Q/H6b5iFIy1P0fIqrMWyyjQIA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593711342664103633?=
X-GMAIL-MSGID: =?utf-8?q?1593711342664103633?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The case statement in get_ap_information() should not use literal integers
to parse information element IDs when these values are provided by name
in 'enum ieee80211_eid' in the header 'linux/ieee80211.h'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
Reviewed-by: Tobin C. Harding <me@tobin.cc>
---
 drivers/staging/ks7010/ks_hostif.c | 31 +++++++++++++++----------------
 drivers/staging/ks7010/ks_hostif.h |  1 +
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 74a08417bd0b..67cf32433023 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -251,9 +251,8 @@ int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
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
@@ -263,8 +262,8 @@ int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
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
@@ -280,9 +279,9 @@ int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
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
@@ -293,8 +292,8 @@ int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
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
@@ -309,18 +308,18 @@ int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
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
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 5bae8d468e23..9ac317e4b507 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -13,6 +13,7 @@
 #define _KS_HOSTIF_H_
 
 #include <linux/compiler.h>
+#include <linux/ieee80211.h>
 
 /*
  * HOST-MAC I/F events
-- 
2.16.2
