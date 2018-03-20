Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-488525-1521525526-2-2197278967803634682
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521525525; b=NduGW/zeVvYrhvuP49Ggyzr4eHP+fEeE9dv3MYSudTXg5Bi
    ibPYov2sxu4uMBYwHfwaEVC7VHFXVOfAK37/R+hA6r8PjZYYfaNod4FEOq3p0FsR
    Bar0I7RqFUSarN5Nur6tbt0sS7fTZLLR46LBVpdcjULs817Dmz1pSBiUcmwtapjC
    Wei8MuRYe+7tbcsg91bVVCZsf/Pa4U423RlFTNPpcBtdxG+qJ/QpykRaKf+v8hQJ
    wAl0Y5POlCrOw6wrQtFmUYtq7qehdbz9pn3qfbp8bKOBRtPrsUZCjW1n2v+iNJbi
    VL4D5MesJ+GffDBnmPac/DXR2Au3sm9chzW7WBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521525525; bh=i
    H1HVy7C43VX1xeQ/f7uP9/XlrnMJ/QnRkPGOIfyDCk=; b=b26P6n0B9moxrPbQZ
    VChCyc8PPk454oQahBPo1OhEjsvV4NPKy/FH4twm5pUyBA/wJZ623WrA+ZWpq8zS
    GwIUGC7UlDR2Uyjd4KEM9YqigJbosIbtz4K0d1cJv8q+4Bx0q5313e3DOmGDlXYc
    vjOtX5P/0D3v2IL/rHLyxWpHLdV3wTQaR+MMK1l7Qy/knW8uqcZQHlnzHLyNsf15
    DZwGbObuMxl7nbLNaGhk/Z8DRqkqAZzGKv7D7xgM+/5r7TgNgwTYVPnindUs3GQV
    LEfvMX7lk4hLhnEDXIiwUlP+No2zKBukzpjiXpDNlUimkvjL1IpH+mw2t0lviJwM
    6waLw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 2/6] staging: ks7010: Factor out code into helper methods.
Date: Mon, 19 Mar 2018 22:58:11 -0700
Message-Id: <20180320055815.32651-2-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320055815.32651-1-quytelda@tamalin.org>
References: <20180319185125.GA13209@kroah.com>
 <20180320055815.32651-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:rT5cOCXfP6dfGl19BE8dw4gp/u21BpHBk9MMfO9dio5ik/F0Y5H
 OgUjYlaXBFOsm67xSut5RQ2vkzJgHhuYKu1IDOJr91lyH0nFUipcG/RP2YIbL91vEgsnphL
 6ZcBTWeoc51+XesyHNQiVjI49Ojoh+q2wmu/fmHX7VbPb7gA0he3V+XC/Ohy/FB4sxyPM8P
 0egdAe8uZZ17kqBtF1m9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MV+IDT+1ZLM=:Vcir0yo6ga+AKrxC56vtao
 gYEIdXTNsJbXz2FY3U+FxoTbK2U/iZIpfepibouuDEjSUdz02PPOHDi6RgdfvFmQyYkE/JV0J
 kO5pp0i+iG20si2i/Y3ynKN94nWHlC1gOPrjX1WsgXcMQ5jQvcFeNR21Ar9c8vdNBGdv7f5Zh
 Zat8HtFzDjiCh4ymW5RtbIBvSWyskfQ+B3fFafGTXXISJ/LURKKcqMyiuyKlrFlbLHi+GRDOG
 Bt326hh2k+CCEGlzAiIo4kHMmdkFb9bXhfHtPLRZuOctr2vETYrs8X4SAhqMMZg0AQWlSUnkV
 zn+jRg2z8lpsP+FDBLeF8AScltfh6r4BVOdnU93+ThnWOKKYLyETjMYYbZGlnRd7EXHUDjZ48
 YrsQcNHEIpIU0e9haZDPsnRolI4daK4ijctKITeei0ozISCFkVaZrLMNOKLLEUsvRwPyDWCEF
 D//T8QSrpu6+DcOUi8219Jf/0PwzR1zjwELUVKlyuhwe4WfRkG2/2iby930aBvLwAUdRj/SuS
 gZpy7SJ6xuQbyYX3XPgPUzKczjiVYj/hZxdIoUMMnOA94KpxBuIwGGeVjYH8s698NDMOx9ZXf
 hbp1CHowpEt82IhcxMAnmKGItVJUdePGxuf8SttRicX9BxdtxhZQb2EY3xInbPZ2MepWy2Sbb
 CesmWIs7Q57i8kOIP2cX2S2KGZ3Ks0VHYnMDb5rgY2t858EIaWUFtkrCNQd4+bGfT2XsFzxi7
 m4sYOjRfC+YSReSHNmnMjcZYoBTaVYjr/NL51w==
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
