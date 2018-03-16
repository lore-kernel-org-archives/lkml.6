Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2161282-1521181652-8-14143525561684329407
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521181651; b=gER2PnwaaZy6tjNhZ8yyGDtel4jy4LllCCZhAkt/kuqokot
    J2SqUh5qJdFa71r+WSOUKwUwoXELO/WVoF9Z7ST6si3ftkv0gX5uiq1R9WZPwg4x
    gRKOugSwwIwKKgZygdlBnXu3xrVykNi0YIkmIQWNjgWljXF1cZ1iSuuMQIXiCEcE
    10ca323Ze+sUWADNYtbWzXSTqIUG9l74Fu/3NkJSqI3jBRU7gYsIuPzHcKdjnTR2
    jtbs5W4ZZ2zK4eWWFeUTLSwuRF7HeS7KNDuX4uhHLBsI2+mqxFJWMSjh5+nyKG2K
    ULP8ASsiKNEi0mXRFxCiS6Pctl3RvgMDI1vBlOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521181651; bh=l
    9pkM4F6vcsyWWwQzoEt6MJmuXrlB2derr2i45C7d4Y=; b=o5a61tVAa6QX/hZrj
    jemQ1HJWnK175x+n49CDAUcS7KqlHX6pkSBHRf446lTh02ILWhSEjhwmqSbjK8bw
    vqSvo+CUvTX89DDMZu4BELIVfU8yN7zVRRYwQS4PQIx4Ns48lK+zVdX9gooosRvB
    WkwaD/X6Fn4jSkisMhzJbyXKuRgQo/S45X09Ua/UBcp6U5XCmADKcYBGBUoR5apy
    JM+25LYRW1VinDhYPcnHt+lsakHlBZCpmOlLwdyInCX7AKyArNuLw90L0FRfvl/Z
    yhBbdMH8jBTp6j80B3cYka5FEH/Tmygm3zYW/K76V8VeokCRsZcNFMpS/Lxnr3YO
    ZTQSA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 1/6] staging: ks7010: Factor out repeated code.
Date: Thu, 15 Mar 2018 23:26:59 -0700
Message-Id: <20180316062704.2713-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
X-Provags-ID: V03:K0:joj0ZFWPcZ5oaItOqxFjlrxAIsTw2FqpTczmuIqp6w0NRESfZeU
 OIyhd3kAVCSoPCjMQT9YKjzGNbsAzOjTR9jIQ8OJx6TnS0WgxjNFqqPjiPtvZ8mV2lHnrld
 mtzBTuB4oCsSbul81qhCg4RwGHOdINJNH87gjbyVnt1q2dY4r4FztlfULQe5HJWPfM73o/+
 lOyafsxE7H3m8WfTDVYfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dOM8iOb/gyY=:AxOslAknmLMh9dsiTpSn/h
 OP9GiXRk/upTVX7ylYMPHhyt4MBvGckgSr3ACpwbGa6E+CG+ncYxtn2/sVFKsXPI+nziW2dk0
 1j1v7CHLV0daBtLEKDssfiVUpuBDzXF2enLy9BKgXzvwmlU+uEP7epHDGL+e03oPvSNZDWFJu
 Kxli9O89ZzUgh+0L0ww/24EP1IzaXOdl7jgPSMN1KMWRxX6n9MwvVcAS626WLnc4m62+bCIs4
 GNyOPsdCg1s0R7metckOZUnOudpJVQib+Ss/4aOfpLKvOZAUT3+0HIDIzkKJJfZuph0U9xHxO
 Jv/QTPh3E9AmHLAKTdhbbRN3gQWbT002XNHao1UMHwXTxfpuvaAkRJOEDQ8MrRYPkt8rsf88i
 a8ltcT7STIvE8s8dquLC2AfeeKjwkzgNMkRDblO+WAM+8BhXxT4gqIiFjCzQjNnGe0NP3LBrQ
 WLSamo32qkf+qKscrspJrf20jC9Z5l8444nqDUdMbz7kIyfUI+DfwwNTw+5CWV9VATSjAdoQw
 tLtgW98S9HeRAcGpUYGiP1VXA4sdAo3Z/GGTRz4qeYp8AkHeHJ8gj0mdW+ypsLlF65HNYymZS
 afEx/RYbcoPHdERKi7h+q40bovegd6Jl0KeptcfvkiUuvge1+P0gvfvGhF9IBsbUAK1PW6O0b
 XcuRki3Mur2NeStYzJqyxex1abnxdzBKQ2PRTvKHFZq+iNTSSdeCuz2wudLtXcp23LgdnOOae
 Y3q/o9ojtIVlYnkgT0RbyaDZuR65+Ott7YTixw==
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

Some of the code for reading IEs is replicated multiple times in the
switch statement for get_ap_information().  Factor that code out into
read_ie().

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 48 +++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 05f7be4638fe..a946ce76f899 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -223,6 +223,21 @@ int get_current_ap(struct ks_wlan_private *priv, struct link_ap_info_t *ap_info)
 	return 0;
 }
 
+static u8 read_ie(unsigned char *bp, u8 max, u8 *body, char *name)
+{
+	u8 size;
+
+	if (*(bp + 1) <= max) {
+		size = *(bp + 1);
+	} else {
+		DPRINTK(1, "size over :: %s size=%d\n", name, *(bp + 1));
+		size = max;
+	}
+
+	memcpy(body, bp + 2, size);
+	return size;
+}
+
 static
 int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
 		       struct local_ap_t *ap)
@@ -253,14 +268,8 @@ int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
 	while (bsize > offset) {
 		switch (*bp) { /* Information Element ID */
 		case WLAN_EID_SSID:
-			if (*(bp + 1) <= IEEE80211_MAX_SSID_LEN) {
-				ap->ssid.size = *(bp + 1);
-			} else {
-				DPRINTK(1, "size over :: ssid size=%d\n",
-					*(bp + 1));
-				ap->ssid.size = IEEE80211_MAX_SSID_LEN;
-			}
-			memcpy(ap->ssid.body, bp + 2, ap->ssid.size);
+			ap->ssid.size = read_ie(bp, IEEE80211_MAX_SSID_LEN,
+						ap->ssid.body, "ssid");
 			break;
 		case WLAN_EID_SUPP_RATES:
 		case WLAN_EID_EXT_SUPP_RATES:
@@ -283,28 +292,15 @@ int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
 			break;
 		case WLAN_EID_RSN:
 			ap->rsn_ie.id = *bp;
-			if (*(bp + 1) <= RSN_IE_BODY_MAX) {
-				ap->rsn_ie.size = *(bp + 1);
-			} else {
-				DPRINTK(1, "size over :: rsn size=%d\n",
-					*(bp + 1));
-				ap->rsn_ie.size = RSN_IE_BODY_MAX;
-			}
-			memcpy(ap->rsn_ie.body, bp + 2, ap->rsn_ie.size);
+			ap->rsn_ie.size = read_ie(bp, RSN_IE_BODY_MAX,
+						  ap->rsn_ie.body, "rsn");
 			break;
 		case WLAN_EID_VENDOR_SPECIFIC: /* WPA */
 			if (memcmp(bp + 2, CIPHER_ID_WPA_WEP40, 4) == 0) { /* WPA OUI check */
 				ap->wpa_ie.id = *bp;
-				if (*(bp + 1) <= RSN_IE_BODY_MAX) {
-					ap->wpa_ie.size = *(bp + 1);
-				} else {
-					DPRINTK(1,
-						"size over :: wpa size=%d\n",
-						*(bp + 1));
-					ap->wpa_ie.size = RSN_IE_BODY_MAX;
-				}
-				memcpy(ap->wpa_ie.body, bp + 2,
-				       ap->wpa_ie.size);
+				ap->wpa_ie.size = read_ie(bp, RSN_IE_BODY_MAX,
+							  ap->wpa_ie.body,
+							  "wpa");
 			}
 			break;
 
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
