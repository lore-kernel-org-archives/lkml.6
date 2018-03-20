Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-488525-1521525536-2-17335976385017170500
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521525535; b=L/k9wY85eBfGWET0TuEjDVTn4duedTOB3vIotiymwtTN7Sl
    MyImtkMSDl97IQF7jz+wIMsdNLF0VdNWMhqBFKWlhXG4S6e82NKfE6+97Exq7NfF
    ILGQ7W0E608paVrWBvuZx9mzYp2biZA9EVQrFf/z0nEgLNuzQqEcCbkBc09/fYyG
    p92U8ZV2xVKtdrn1LohXgSCOIDyDUzI7YtRan3zRdPjfD1ouiaMzfxhpalPH2OIC
    maw0J+Jio6PZ/qV68cI5Hq1OHmACwz+eRvh/ePvpQgmt0Se6DlxN5r6NktSXXwDK
    Mjzmq95b77jDc5XPx7ekPgrYJ3ezLWZb5wQ5vXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521525535; bh=b
    YjAsodE4ALk4o6/1OVWx2MFx2QWqQe8nURzncI2ZcI=; b=UZdy7ZIKeV5BZI1cC
    4rTRa0TrLtdkMX0I75LHTwi4RdQGFS16C6kDYeNZ7Yeb9x3uurxxVPDVdhA79woo
    cAW79pgTaNpVqEqQIjCxI5Qrq22LDlUQ8geBQZf7aKAofmgP616wMrYmE3XC3xc2
    ELqyFhecID25IvHcvuEZZik41CvlAdcf5LLQ9O1cdzdE/XXlB1l9GsP45xvy1LxT
    Fx6j8GzqLU6GhmjKW8KNBgybE68XnR29DnwbehsqHtxmD+OPAiaufPdmf0URbQYL
    BlKLMXbJ9a3FgPcuocI8BmL9S/j77vFMW+njVyRfyk7fB/yIu7bATn2sJxXieNDB
    2E30g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 6/6] staging: ks7010: Factor out repeated request
 initialization code.
Date: Mon, 19 Mar 2018 22:58:15 -0700
Message-Id: <20180320055815.32651-6-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320055815.32651-1-quytelda@tamalin.org>
References: <20180319185125.GA13209@kroah.com>
 <20180320055815.32651-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:cPTKj6Psih1RpbjkSh7DHqrByWfRPWAjfYNw+fIw2L8snuctjrF
 A/sK85urnzu3d0EnITjsXgztuERyZkhq915YcQqMGOq1y90xSOJPLGJhoOW9OS12/IieBSD
 gxK28Q2reqENCq/yY4An99hb5vnxGIDb0iCWjjFnVfpS/2MgGMMJTSRIzheAqMupO+zO8nm
 /KKiTYlK7+QcMuNbvOF6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:owzFVOep5e0=:NlbCYJFgwabQMgbqMs+GJ9
 eIX9zSeLUtRXdwRyYdA5PKxHqhlqQ0P6cZAcJ+2Po5LBTqxssfhudwybZ45t2EsDLMpNKfJbv
 0AOQ3DqBEEN68s9EB/S+E+gbnsIF7aK+LxboEsl97BCwUUifSpfocO0NEWoi5n+4vjQfcHR7S
 D6uyWZZ6WovYMQxeDnKZkzCuuFaFVBwfPNIqGWoPs8ymMySRho03yhD85z74atEHYf+YZffz2
 r8rP00haD79s/EkKVJ1SzE6gAbbjBLn+SYfH0vXi28XLPzNAvtyOB8akjWPBA0TXi25LEf8eM
 6R+5aJelEa0sytvE5GTddvgv9tRpbnWtQQJlW70CRtBkMMfnGFu3u5UJJPgqe2HX7L/jQALhq
 f5ScYxyTlDJ/NHRLrmkPE53r+xXl0M5033RtyUpZxvyXNFmlGSOgN0SfYlwa0SY2NnT4pDVuR
 dqZBrbWGlTb43Jiw5XVjwLmYfGt9gx3YxTkQNFlJpcfqEcuyOnQ3MoKR+C6ZlsUafyPuM9GOC
 6ljQnB3qMfc3u9eM5GQ9g+Qg82QvN0yZEPRSf6cR4cuK9YLP5+tWxBSWiMS5JXuWvKKyfkA2z
 jtTqhZLDQI/AAs88FIPyVx5fpPMTBIWfdoLx+1IIhBzwJHY9xlMkTZA4mJEGGTTqvgxPD6X+R
 3x/n1+0fXs5TDG+ya/bSiISKylOqo4sQPNEHn1sq/GIXVfhln7fioy1tMfU8K6ffEM1AlbDNu
 ExWhjNRlymPBPxH8qJX5ZCsPNUwHtswaNiUP0g==
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

The code to initialize various different types of request structs
is repeated multiple times.  Factor this code out into a macro
called INIT_REQUEST.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 55 +++++++++++---------------------------
 1 file changed, 16 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 6fc2c3647908..3e5016aad029 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -40,6 +40,17 @@ static inline unsigned int cnt_smeqbody(struct ks_wlan_private *priv)
 
 #define KS_WLAN_MEM_FLAG (GFP_ATOMIC)
 
+#define INIT_REQUEST(pp, priv)
+{(
+	pp->phy_type = cpu_to_le16((uint16_t)(priv->reg.phy_type));
+	pp->cts_mode = cpu_to_le16((uint16_t)(priv->reg.cts_mode));
+	pp->scan_type = cpu_to_le16((uint16_t)(priv->reg.scan_type));
+	pp->rate_set.size = priv->reg.rate_set.size;
+	pp->capability = ks_wlan_cap(priv);
+	memcpy(&pp->rate_set.body[0], &priv->reg.rate_set.body[0],
+	       priv->reg.rate_set.size);
+)}
+
 static
 inline u8 get_BYTE(struct ks_wlan_private *priv)
 {
@@ -1412,14 +1423,7 @@ void hostif_ps_adhoc_set_request(struct ks_wlan_private *priv)
 	if (!pp)
 		return;
 
-	pp->phy_type = cpu_to_le16((uint16_t)(priv->reg.phy_type));
-	pp->cts_mode = cpu_to_le16((uint16_t)(priv->reg.cts_mode));
-	pp->scan_type = cpu_to_le16((uint16_t)(priv->reg.scan_type));
-	pp->channel = cpu_to_le16((uint16_t)(priv->reg.channel));
-	pp->rate_set.size = priv->reg.rate_set.size;
-	pp->capability = ks_wlan_cap(priv);
-	memcpy(&pp->rate_set.body[0], &priv->reg.rate_set.body[0],
-	       priv->reg.rate_set.size);
+	INIT_REQUEST(pp, priv);
 
 	/* send to device request */
 	ps_confirm_wait_inc(priv);
@@ -1437,16 +1441,9 @@ void hostif_infrastructure_set_request(struct ks_wlan_private *priv)
 	if (!pp)
 		return;
 
-	pp->phy_type = cpu_to_le16((uint16_t)(priv->reg.phy_type));
-	pp->cts_mode = cpu_to_le16((uint16_t)(priv->reg.cts_mode));
-	pp->scan_type = cpu_to_le16((uint16_t)(priv->reg.scan_type));
-
-	pp->rate_set.size = priv->reg.rate_set.size;
-	memcpy(&pp->rate_set.body[0], &priv->reg.rate_set.body[0],
-	       priv->reg.rate_set.size);
+	INIT_REQUEST(pp, priv);
 	pp->ssid.size = priv->reg.ssid.size;
 	memcpy(&pp->ssid.body[0], &priv->reg.ssid.body[0], priv->reg.ssid.size);
-	pp->capability = ks_wlan_cap(priv);
 	pp->beacon_lost_count =
 	    cpu_to_le16((uint16_t)(priv->reg.beacon_lost_count));
 	pp->auth_type = cpu_to_le16((uint16_t)(priv->reg.authenticate_type));
@@ -1486,16 +1483,9 @@ static void hostif_infrastructure_set2_request(struct ks_wlan_private *priv)
 	if (!pp)
 		return;
 
-	pp->phy_type = cpu_to_le16((uint16_t)(priv->reg.phy_type));
-	pp->cts_mode = cpu_to_le16((uint16_t)(priv->reg.cts_mode));
-	pp->scan_type = cpu_to_le16((uint16_t)(priv->reg.scan_type));
-
-	pp->rate_set.size = priv->reg.rate_set.size;
-	memcpy(&pp->rate_set.body[0], &priv->reg.rate_set.body[0],
-	       priv->reg.rate_set.size);
+	INIT_REQUEST(pp, priv);
 	pp->ssid.size = priv->reg.ssid.size;
 	memcpy(&pp->ssid.body[0], &priv->reg.ssid.body[0], priv->reg.ssid.size);
-	pp->capability = ks_wlan_cap(priv);
 	pp->beacon_lost_count =
 	    cpu_to_le16((uint16_t)(priv->reg.beacon_lost_count));
 	pp->auth_type = cpu_to_le16((uint16_t)(priv->reg.authenticate_type));
@@ -1538,16 +1528,9 @@ void hostif_adhoc_set_request(struct ks_wlan_private *priv)
 	if (!pp)
 		return;
 
-	pp->phy_type = cpu_to_le16((uint16_t)(priv->reg.phy_type));
-	pp->cts_mode = cpu_to_le16((uint16_t)(priv->reg.cts_mode));
-	pp->scan_type = cpu_to_le16((uint16_t)(priv->reg.scan_type));
-	pp->channel = cpu_to_le16((uint16_t)(priv->reg.channel));
-	pp->rate_set.size = priv->reg.rate_set.size;
-	memcpy(&pp->rate_set.body[0], &priv->reg.rate_set.body[0],
-	       priv->reg.rate_set.size);
+	INIT_REQUEST(pp, priv);
 	pp->ssid.size = priv->reg.ssid.size;
 	memcpy(&pp->ssid.body[0], &priv->reg.ssid.body[0], priv->reg.ssid.size);
-	pp->capability = ks_wlan_cap(priv);
 
 	/* send to device request */
 	ps_confirm_wait_inc(priv);
@@ -1565,15 +1548,9 @@ void hostif_adhoc_set2_request(struct ks_wlan_private *priv)
 	if (!pp)
 		return;
 
-	pp->phy_type = cpu_to_le16((uint16_t)(priv->reg.phy_type));
-	pp->cts_mode = cpu_to_le16((uint16_t)(priv->reg.cts_mode));
-	pp->scan_type = cpu_to_le16((uint16_t)(priv->reg.scan_type));
-	pp->rate_set.size = priv->reg.rate_set.size;
-	memcpy(&pp->rate_set.body[0], &priv->reg.rate_set.body[0],
-	       priv->reg.rate_set.size);
+	INIT_REQUEST(pp, priv);
 	pp->ssid.size = priv->reg.ssid.size;
 	memcpy(&pp->ssid.body[0], &priv->reg.ssid.body[0], priv->reg.ssid.size);
-	pp->capability = ks_wlan_cap(priv);
 
 	pp->channel_list.body[0] = priv->reg.channel;
 	pp->channel_list.size = 1;
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
