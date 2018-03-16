Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2161282-1521181859-2-6568468831484888875
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521181858; b=uVd/niz+nprSDJguVcYRDY1b2Qerzvv4U0OJh1e0yv22zH3
    kRjm7VHpnMjEUilLTN4EKScS3Mm0dgStAYFAk8aWg+WUDgnhmr3KJcZAc8vBcOIi
    mwFgQdpJ6zQ1e3mOHRPPXPiINWkmkP2fUBcaGE7OC1x37SAA0/u7TwbszAtDwosd
    ID+VX2TpNQIH8UjYhveB63FjkLE9BgmGBxD2UUqiYv8q2zqMQhCCqGe/ZME77Ena
    i3QKCKv7Es5vwJ9yrTszkgZnvAvqmuxqXBHLRpnZMu4IRtz1RuO6trh486R+cYyD
    8NIBj+YUnF2H2dhoWHD9pBrVPRDyC2CBHTNGDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521181858; bh=i
    H1HVy7C43VX1xeQ/f7uP9/XlrnMJ/QnRkPGOIfyDCk=; b=paF1QalA45SLguGwk
    od4CFWx1nutTa/uiZL/wv3HgnpPV2c+hYs+rF8Biu6c14MWj/mDxHC0ktOZT6AXr
    49HFDrJFDOYxGBjrPzaViNThFT6FYXz18ThglBCGTDL9sErj0kI24tGo2y9nvnQ5
    en7L6iuVp7O5XiGexlWxlVE3ZDRwx+utXKN4b7e6MmaoG3pqaqfGTgJ89IQ1WwVp
    Bxr4BnHbVsgTmx8ZIZG8CBQhjKmIwzfa5nvWpXYrZXQA+7YSz5PCtejSYzN5L6cn
    ObSotsOqDYSf4bpE2SNyhCSkihX0U8yoc6zGI0HmncD9J5cviEIB4oKobMQL3kYy
    ACiaQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 2/6] staging: ks7010: Factor out code into helper methods.
Date: Thu, 15 Mar 2018 23:30:31 -0700
Message-Id: <20180316063035.3037-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
X-Provags-ID: V03:K0:nbLu5DOHpteVs3U3rcE0NtnI60T+OJ2H6IvbMRJ+1nnZ1PrPtY2
 4+hifWI9/V/25OxbjqmUeOAdfHUu70QQ77fSVOT8AgeK2Ffe9iHEIQTQ4nIrZaDxXun5rBS
 VpO4vmoMBosX2qY7lsemtMG8htOZwDBBHnwoVxZRjbJm4KnJ7KC5qWVKjILGTIJlXD55cvA
 Ots445p0wPRQfzm4suCiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wAKU8HO2EkQ=:xzkfFDtqoQndxrIj9j4NTZ
 wWWmMQCY7AihgO+y6lBNIVshJn8qHlAm99uLxebA9tcmZURF0WvrjZh+WHRFvmRf050LP4dxz
 v9X5zAdiETiQ7S9qvXXmg8gl3xbZuqe8BkGiVGvB3VRlQIVLl6EjAlAbVQk2FNwVrps8CInjV
 meyPHkkTi3UXrVZqJXFFAsNc+LwxS/E2Pm/QWDbVvVZz2CgbFDCYM5yCoJcqdz66OKvCcjd1j
 vptSn8xPpa9zDjjT5mokI6A0xk5sutMb8SvaroP296TqqkIjRg/Jyj8ndPnfokmPmxz1ckiNt
 g8g81VLFgNLvzCl740NaOQAzc6ogoYZjp2OhxQ729Vyt8yy712X5DB79ktLYbMekTG8l79/m1
 JZXVBnfcVl8QDLv0KFUwGTA3+zqE9vAXCuhjXg15tQfdxtV3LEhatHcOtUYuoydiNjXkJw/rb
 ee+00jeak0DUMb1lJr2YYhHekfsHq7uDUXRg2RonlRwxXdF9SXOEeT27Tm3it2DtlCTZvVSLU
 tAhNmmz8BZ6xLxMA65uqd4WMkyehgBcw5++5O98Tz0dzd57LXAvni6tNWHM/+Xr0Xw6nYigKL
 yepTG5eaKrVM86AnHfFAg0o4z3nQRt3YiYcIbg2vLIDXtF/CcX52PzBrdpljiSocV76YlVVpo
 QHqXS0rxDy6IghCRpyzG5M5/3myAgubT6MhKd9owDJUh5pUubGH3keOOCity/ihX7FDI7gZZl
 qrvDZ5NTTp7vWNCkV3oRPHvWyHUnD4layvBW8w==
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
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some cases in the switch statement in get_ap_information() are indented
as much as five levels, which makes the code difficult to read because
of all the wrapping.  Factor them out into helper methods.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 46 +++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index a946ce76f899..948d45280d18 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -238,6 +238,30 @@ static u8 read_ie(unsigned char *bp, u8 max, u8 *body, char *name)
 	return size;
 }
 
+static void read_ie_ext_supp_rates(struct local_ap_t *ap, unsigned char *bp)
+{
+	if ((*(bp + 1) + ap->rate_set.size) <= RATE_SET_MAX_SIZE) {
+		memcpy(&ap->rate_set.body[ap->rate_set.size],
+		       bp + 2, *(bp + 1));
+		ap->rate_set.size += *(bp + 1);
+	} else {
+		DPRINTK(1, "size over :: rate size=%d\n",
+			(*(bp + 1) + ap->rate_set.size));
+		memcpy(&ap->rate_set.body[ap->rate_set.size], bp + 2,
+		       RATE_SET_MAX_SIZE - ap->rate_set.size);
+		ap->rate_set.size += (RATE_SET_MAX_SIZE - ap->rate_set.size);
+	}
+}
+
+static void read_ie_wpa(struct local_ap_t *ap, unsigned char *bp)
+{
+	if (memcmp(bp + 2, CIPHER_ID_WPA_WEP40, 4) == 0) { /* WPA OUI check */
+		ap->wpa_ie.id = *bp;
+		ap->wpa_ie.size = read_ie(bp, RSN_IE_BODY_MAX,
+					  ap->wpa_ie.body, "wpa");
+	}
+}
+
 static
 int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
 		       struct local_ap_t *ap)
@@ -273,20 +297,7 @@ int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
 			break;
 		case WLAN_EID_SUPP_RATES:
 		case WLAN_EID_EXT_SUPP_RATES:
-			if ((*(bp + 1) + ap->rate_set.size) <=
-			    RATE_SET_MAX_SIZE) {
-				memcpy(&ap->rate_set.body[ap->rate_set.size],
-				       bp + 2, *(bp + 1));
-				ap->rate_set.size += *(bp + 1);
-			} else {
-				DPRINTK(1, "size over :: rate size=%d\n",
-					(*(bp + 1) + ap->rate_set.size));
-				memcpy(&ap->rate_set.body[ap->rate_set.size],
-				       bp + 2,
-				       RATE_SET_MAX_SIZE - ap->rate_set.size);
-				ap->rate_set.size +=
-				    (RATE_SET_MAX_SIZE - ap->rate_set.size);
-			}
+			read_ie_ext_supp_rates(ap, bp);
 			break;
 		case WLAN_EID_DS_PARAMS:
 			break;
@@ -296,12 +307,7 @@ int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
 						  ap->rsn_ie.body, "rsn");
 			break;
 		case WLAN_EID_VENDOR_SPECIFIC: /* WPA */
-			if (memcmp(bp + 2, CIPHER_ID_WPA_WEP40, 4) == 0) { /* WPA OUI check */
-				ap->wpa_ie.id = *bp;
-				ap->wpa_ie.size = read_ie(bp, RSN_IE_BODY_MAX,
-							  ap->wpa_ie.body,
-							  "wpa");
-			}
+			read_ie_wpa(ap, bp);
 			break;
 
 		case WLAN_EID_FH_PARAMS:
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
