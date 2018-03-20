Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-488525-1521525520-2-12848928873547632154
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
    t=1521525519; b=nPMT64R+i/7COcdly0Y7ocemEZpvatu9DKjpl2HS7ZAwgOT
    zjWHXnMnslzBYs18sKArGhD8f51RplQ42V/EnJU7cZopj0XjObCT6/z+BQAKMcQv
    OswVg5STLVt1S2gj4j7JWCphCIcSDT4FgxpotUW+awS5Ke9Sf1odWHz6CfiVqZAR
    RUmtDokSR9Dm1hGoA1R5xkUDi9tjRLzWjjKYPo2x2DKRjgtzBiPEKQBBewA3MVFu
    fj8vxsecGg+/ouBVVSU6OTFaCZ69u/K1UoMNHnLYSTMhOBJDKkvRYIRhYrMsGsj6
    sf/ij+SUCcgacP7Vb1NXWk6b5W6bPMwZl/1PSmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521525519; bh=l
    9pkM4F6vcsyWWwQzoEt6MJmuXrlB2derr2i45C7d4Y=; b=kKzgz3UdJZ6ioiZYk
    4S2ujO1wJIyOVPZBicUDSpmkdMIbGNwjjXi6Lqj2SYIuaTNmr41ITEZP6NwMypAK
    AeV4h6AKKNcwEp79IEjAQG8bnc4fNhY6ms/jAtWr4V2NU4+RR5QUBMUQl0pQQQNP
    SdnRfBVYXyJMNnQ40rJVeQ74tw4HAwg25hTy0MPDO05jWc13ZjltEurrDS10Jf9t
    QVP5RvC3WvLXgTuboVL85V9mzRA+e/uoujMizJuaRHisG2juC8MvaihT/q5L/bQZ
    HOYF9oxgxFWASstfYR+5guKR6zAMttwXno24M5tFeCKUcC96YtUIt+AghsR+i+ND
    mSdYw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
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
Subject: [PATCH 1/6] staging: ks7010: Factor out repeated code.
Date: Mon, 19 Mar 2018 22:58:10 -0700
Message-Id: <20180320055815.32651-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319185125.GA13209@kroah.com>
References: <20180319185125.GA13209@kroah.com>
X-Provags-ID: V03:K0:2QGVymWLqG3dr5/6LXsN2p4W7wHbIFcC3oq0x8XawcH04p43v/P
 gyK4zzk5rnlS3Arco7M0Zzc1YjD45Fu8pUM15U9Jz0KYbfbfJ/JyX4PcAUHAX2e1B6Ssd04
 UC7wOwXxoTQ+MKggbPcf1XjThzeSGTZgYfJlk23lkXArG6tC3PU7M3t6e2krjkp57D8Vjps
 LdIZMNKRVwLxYVpF9d7jg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JdzHLZDbr4g=:EwbwSTVA9f0XKvnWS0+iiN
 uy7WUzbbEc7tt0R4xtBiI6zJ4a1imYkjTrmtolLQ8Z5+nrhI/qYg+8lkEVaSNCRV6jRJSSsN2
 PFCgIl5lKmgOMjkUAWkUfi+GVAWnJ8OKggIQM715hozF5AKPa0ySaZdWeRyzy5Aiu6qRHfSoh
 ezu9aiNat7LjJk9vt/QnNlvKIkJ06ocsjKAHcSKrVXMtuhZdVaiD7Ku1CYA7q2B/ok/HKx9f7
 iBEERcJaF6icpD9HCNQaGoJzQL/k4Yn9GtlAqsgztQyJxy5M9SCMjCOHmRw4zH869y0s1C9OJ
 3BW+smZDfSoml1oFaHklkF4i5nRORL7SgUufqpGcrHQzYAi0rXFR5e4iet8j/aSMfb9MgQHII
 B6mDqJXT/H5yZU29bxWDeq+q3vjkFH3irdvVdB1Ul2kpa21+bfi4zwePRK45mupnMH5tHcXkS
 19+6IwMUauVHc+yOCjUBHCdlD2nmMOFQFpg5KxGmI8FHAZHVeseQyJv8x0KkZn1KWhEpfSYlv
 SjLRWLek9eLESvDZQ806+f0fOPUtK/lGVw6Sb2gHk5ILu4Sq0QKdlJ/uNrxCA9ZgfHQpq7HVb
 4zn+V3GOI6ff4Fyq2b/innEqbGPlT3P+SB14Yz/05C6Pq2MoNhh35B85WYfG2lNsKGYejMkmH
 3X0YxQWK8IMMsfh5H+jXSkMrp6RQ4lqnWb+oC7AMqH8HPtjlvw+4kLHh1rvtcqPuATB04DYQj
 sj9uRda6AoBLLuYnbwwmIL14qHl4d7YpkY+8WQ==
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
