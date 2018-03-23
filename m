Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-212613-1521781732-2-18158594429231162587
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521781731; b=K3/vAeZsZfSRdh+qml1ERQHa+blAzMXaIs5ScZcL/m/EH0a
    CAC34JJBEJagTrxS0ynLrVfI8MmZwer2ds7NBhJOpneQeF+qY9WDmxM9K3eNaQ54
    8QrRM+OCm0POgBZuAXCJhcWmdAUpAE8Ri08F8C1/FEOHJ4oxTEzkgTwgtUlRAyvJ
    oOJPGe8uY07vsJlGSOAu5x/v2QxiL/wX0uHWrKef30uEGHe2IB9psOztwfnOYvUY
    S7ZuPbdiOgXgiVf5pMmEWC6Om0q0RjE+NqZcPkFYNU/eiWGU+5m7Bexi+uUa7rPf
    fMXDFABDUrHIOs4YoVluKxRy2PmHnJqZuOQkE8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521781731; bh=W
    6Oyv2zBbKu+fN82UiUpYmFoWEV0yNgHFNTuXAsUJio=; b=IUV4RIRpyM8b5qurW
    duIvDZ2w7NxqU2lY+PUjvC7OogIPWsJtDtJoUF5eE7OLBMp95wJNkVxT9wpMnLf9
    +5LNJYUISHAnVHqqG/mX0ug7ap6eQVXNdDHeTcWuwgyjgIGdljf4jrcSe73/Rqhk
    ZbutwFGTnTfBlNLIoTbFYvxTQ4XnDscdZA0ku/1jTw/5SavCRrtYiB4vzIsmP6o9
    kl3K39jqSgqfAYZsZg1b2Q9oKHbxB5eDQltYjuSRcLQmFMhBWYBmWfynlHOasFgW
    OOzFUhlM7K5cd1QJDdCniOCobGjIYHoyg92KM2in/Wv7MTPNa8m40snfGJhRP8O/
    lWF0w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 3/7] staging: ks7010: Factor out common members in request
 structs.
Date: Thu, 22 Mar 2018 22:07:41 -0700
Message-Id: <20180323050745.28903-3-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323050745.28903-1-quytelda@tamalin.org>
References: <20180322172014.GA6801@kroah.com>
 <20180323050745.28903-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:kwWaYHJzr7px6OdNePeEZKi7zCjQIPYl9Xmqxp/S+7QUmX0OBTH
 JwyS+7lShVZuQWNKrgbACJTb01Pj36Dfyl2QNFfxdtT7B+AsfNUv2KKUxc3A9WjoHIy7R9Q
 JFx9wtljYMdLNELQReWysbCuw881/Tvp/fmVYU4KZH+S5569H4SM7rYfXfi4NE/k6Rvq2kk
 npjiFxjKzye5avPZu0LAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7WgMTATtdfk=:OrVK0URRw16pF+lzfugRCO
 +HCmvlLkdScNq4epE4KA5UJ/1Cn/De2xDYnaYeMke4CsX5ZJiDjGTAgR5NIbpIA/Qf17Y8mw6
 hL1TWuYgi7eFPD+yMG6ivZUEtn/W19iLq9knjGPOPvioaTzxaJCbv1i95Pj2vbMmFRCgxmH39
 2eHokkAy2flBPNRTnVuXxnkf+CghQByWDwSa2El7mCi1tLWJ5NhUHk99bWJENHPra8X0MSR+Y
 gqq9O+kRB/rYucPZW4xEiLKgJZHtEgGMQXw0z22mBLamiD6Oiy7ujn81bSGZMR43SJ90mqMvN
 kizzDZVcKP7QcCSAL2LaX4Q/vS/YLPLAZAsEwdTmpBevposFd9FW1hwyYX2hSjMAsaosNli0b
 l033aI035imowKFd2mNxmh8Z077HiPm2L/epl5n8CRx2qL3PnniUwhDMOOd2jDm27csBT6Mcz
 vyUMqNlTgtgaOg3My/NinNdHWJuicPUeJWagSWIyVdBplsyMZtEG9/MMGnA8pCApa6+VdgGv5
 2+G5UrhLjXO7EVLygnRXyT3LqMSBbTOmtCH7chK8WmzwVLBAhF2xsAiwXA0o8nDpu6bvBjI8E
 Xp6asD9xJ77faCEPPVdM3DSsAkN7Nw/nbLCxIFsRfn+cyBBQmKtzUn9+wGxeS1IJHkj+0xswU
 MdZjUmR7o3dDdvTJs8el0DWTOkrjmtYyFVXbAsXYLLaykmOb1RZiMHtkzfmcdj+JvtakpFKXB
 vNYbhtncc/Q0ZZ96x190DfU2n4auR4HTiIuFQQ==
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

Most of the request structures defined in ks_hostif.h have common
members:
* __le16 phy_type;
* __le16 cts_mode;
* __le16 scan_type;
* __le16 capability;
* struct rate_set16_t rate_set;

Factor out these members into a common substructure of type
'hostif_request_t'.  This allows a large portion of the request
initialization code in ks_hostif.c to be factored out into the
'init_request' function.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 53 +++++++++++--------------------------
 drivers/staging/ks7010/ks_hostif.h | 54 ++++++++++++++++----------------------
 2 files changed, 38 insertions(+), 69 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 653f6aae3420..32f35d297628 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1316,6 +1316,17 @@ static __le16 ks_wlan_cap(struct ks_wlan_private *priv)
 	return cpu_to_le16((uint16_t)capability);
 }
 
+static void init_request(struct ks_wlan_private *priv, struct hostif_request_t *req)
+{
+	req->phy_type = cpu_to_le16((uint16_t)(priv->reg.phy_type));
+	req->cts_mode = cpu_to_le16((uint16_t)(priv->reg.cts_mode));
+	req->scan_type = cpu_to_le16((uint16_t)(priv->reg.scan_type));
+	req->rate_set.size = priv->reg.rate_set.size;
+	req->capability = ks_wlan_cap(priv);
+	memcpy(&req->rate_set.body[0], &priv->reg.rate_set.body[0],
+	       priv->reg.rate_set.size);
+}
+
 static
 void hostif_ps_adhoc_set_request(struct ks_wlan_private *priv)
 {
@@ -1325,14 +1336,8 @@ void hostif_ps_adhoc_set_request(struct ks_wlan_private *priv)
 	if (!pp)
 		return;
 
-	pp->phy_type = cpu_to_le16((uint16_t)(priv->reg.phy_type));
-	pp->cts_mode = cpu_to_le16((uint16_t)(priv->reg.cts_mode));
-	pp->scan_type = cpu_to_le16((uint16_t)(priv->reg.scan_type));
+	init_request(priv, &pp->request);
 	pp->channel = cpu_to_le16((uint16_t)(priv->reg.channel));
-	pp->rate_set.size = priv->reg.rate_set.size;
-	pp->capability = ks_wlan_cap(priv);
-	memcpy(&pp->rate_set.body[0], &priv->reg.rate_set.body[0],
-	       priv->reg.rate_set.size);
 
 	/* send to device request */
 	ps_confirm_wait_inc(priv);
@@ -1348,16 +1353,9 @@ void hostif_infrastructure_set_request(struct ks_wlan_private *priv)
 	if (!pp)
 		return;
 
-	pp->phy_type = cpu_to_le16((uint16_t)(priv->reg.phy_type));
-	pp->cts_mode = cpu_to_le16((uint16_t)(priv->reg.cts_mode));
-	pp->scan_type = cpu_to_le16((uint16_t)(priv->reg.scan_type));
-
-	pp->rate_set.size = priv->reg.rate_set.size;
-	memcpy(&pp->rate_set.body[0], &priv->reg.rate_set.body[0],
-	       priv->reg.rate_set.size);
+	init_request(priv, &pp->request);
 	pp->ssid.size = priv->reg.ssid.size;
 	memcpy(&pp->ssid.body[0], &priv->reg.ssid.body[0], priv->reg.ssid.size);
-	pp->capability = ks_wlan_cap(priv);
 	pp->beacon_lost_count =
 	    cpu_to_le16((uint16_t)(priv->reg.beacon_lost_count));
 	pp->auth_type = cpu_to_le16((uint16_t)(priv->reg.authenticate_type));
@@ -1395,16 +1393,9 @@ static void hostif_infrastructure_set2_request(struct ks_wlan_private *priv)
 	if (!pp)
 		return;
 
-	pp->phy_type = cpu_to_le16((uint16_t)(priv->reg.phy_type));
-	pp->cts_mode = cpu_to_le16((uint16_t)(priv->reg.cts_mode));
-	pp->scan_type = cpu_to_le16((uint16_t)(priv->reg.scan_type));
-
-	pp->rate_set.size = priv->reg.rate_set.size;
-	memcpy(&pp->rate_set.body[0], &priv->reg.rate_set.body[0],
-	       priv->reg.rate_set.size);
+	init_request(priv, &pp->request);
 	pp->ssid.size = priv->reg.ssid.size;
 	memcpy(&pp->ssid.body[0], &priv->reg.ssid.body[0], priv->reg.ssid.size);
-	pp->capability = ks_wlan_cap(priv);
 	pp->beacon_lost_count =
 	    cpu_to_le16((uint16_t)(priv->reg.beacon_lost_count));
 	pp->auth_type = cpu_to_le16((uint16_t)(priv->reg.authenticate_type));
@@ -1445,16 +1436,10 @@ void hostif_adhoc_set_request(struct ks_wlan_private *priv)
 	if (!pp)
 		return;
 
-	pp->phy_type = cpu_to_le16((uint16_t)(priv->reg.phy_type));
-	pp->cts_mode = cpu_to_le16((uint16_t)(priv->reg.cts_mode));
-	pp->scan_type = cpu_to_le16((uint16_t)(priv->reg.scan_type));
+	init_request(priv, &pp->request);
 	pp->channel = cpu_to_le16((uint16_t)(priv->reg.channel));
-	pp->rate_set.size = priv->reg.rate_set.size;
-	memcpy(&pp->rate_set.body[0], &priv->reg.rate_set.body[0],
-	       priv->reg.rate_set.size);
 	pp->ssid.size = priv->reg.ssid.size;
 	memcpy(&pp->ssid.body[0], &priv->reg.ssid.body[0], priv->reg.ssid.size);
-	pp->capability = ks_wlan_cap(priv);
 
 	/* send to device request */
 	ps_confirm_wait_inc(priv);
@@ -1470,15 +1455,9 @@ void hostif_adhoc_set2_request(struct ks_wlan_private *priv)
 	if (!pp)
 		return;
 
-	pp->phy_type = cpu_to_le16((uint16_t)(priv->reg.phy_type));
-	pp->cts_mode = cpu_to_le16((uint16_t)(priv->reg.cts_mode));
-	pp->scan_type = cpu_to_le16((uint16_t)(priv->reg.scan_type));
-	pp->rate_set.size = priv->reg.rate_set.size;
-	memcpy(&pp->rate_set.body[0], &priv->reg.rate_set.body[0],
-	       priv->reg.rate_set.size);
+	init_request(priv, &pp->request);
 	pp->ssid.size = priv->reg.ssid.size;
 	memcpy(&pp->ssid.body[0], &priv->reg.ssid.body[0], priv->reg.ssid.size);
-	pp->capability = ks_wlan_cap(priv);
 
 	pp->channel_list.body[0] = priv->reg.channel;
 	pp->channel_list.size = 1;
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 166d83e4885c..87686fe83c67 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -335,6 +335,22 @@ struct hostif_stop_confirm_t {
 	__le16 result_code;
 } __packed;
 
+#define D_11B_ONLY_MODE		0
+#define D_11G_ONLY_MODE		1
+#define D_11BG_COMPATIBLE_MODE	2
+#define D_11A_ONLY_MODE		3
+
+#define CTS_MODE_FALSE	0
+#define CTS_MODE_TRUE	1
+
+struct hostif_request_t {
+	__le16 phy_type;
+	__le16 cts_mode;
+	__le16 scan_type;
+	__le16 capability;
+	struct rate_set16_t rate_set;
+} __packed;
+
 /**
  * struct hostif_ps_adhoc_set_request_t - pseudo adhoc mode
  * @capability: bit5  : preamble
@@ -344,18 +360,8 @@ struct hostif_stop_confirm_t {
  */
 struct hostif_ps_adhoc_set_request_t {
 	struct hostif_hdr header;
-	__le16 phy_type;
-#define D_11B_ONLY_MODE		0
-#define D_11G_ONLY_MODE		1
-#define D_11BG_COMPATIBLE_MODE	2
-#define D_11A_ONLY_MODE		3
-	__le16 cts_mode;
-#define CTS_MODE_FALSE	0
-#define CTS_MODE_TRUE	1
+	struct hostif_request_t request;
 	__le16 channel;
-	struct rate_set16_t rate_set;
-	__le16 capability;
-	__le16 scan_type;
 } __packed;
 
 struct hostif_ps_adhoc_set_confirm_t {
@@ -372,17 +378,13 @@ struct hostif_ps_adhoc_set_confirm_t {
  */
 struct hostif_infrastructure_set_request_t {
 	struct hostif_hdr header;
-	__le16 phy_type;
-	__le16 cts_mode;
-	struct rate_set16_t rate_set;
+	struct hostif_request_t request;
 	struct ssid_t ssid;
-	__le16 capability;
 	__le16 beacon_lost_count;
 	__le16 auth_type;
 #define AUTH_TYPE_OPEN_SYSTEM 0
 #define AUTH_TYPE_SHARED_KEY  1
 	struct channel_list_t channel_list;
-	__le16 scan_type;
 } __packed;
 
 /**
@@ -394,17 +396,13 @@ struct hostif_infrastructure_set_request_t {
  */
 struct hostif_infrastructure_set2_request_t {
 	struct hostif_hdr header;
-	__le16 phy_type;
-	__le16 cts_mode;
-	struct rate_set16_t rate_set;
+	struct hostif_request_t request;
 	struct ssid_t ssid;
-	__le16 capability;
 	__le16 beacon_lost_count;
 	__le16 auth_type;
 #define AUTH_TYPE_OPEN_SYSTEM 0
 #define AUTH_TYPE_SHARED_KEY  1
 	struct channel_list_t channel_list;
-	__le16 scan_type;
 	u8 bssid[ETH_ALEN];
 } __packed;
 
@@ -422,13 +420,9 @@ struct hostif_infrastructure_set_confirm_t {
  */
 struct hostif_adhoc_set_request_t {
 	struct hostif_hdr header;
-	__le16 phy_type;
-	__le16 cts_mode;
-	__le16 channel;
-	struct rate_set16_t rate_set;
+	struct hostif_request_t request;
 	struct ssid_t ssid;
-	__le16 capability;
-	__le16 scan_type;
+	__le16 channel;
 } __packed;
 
 /**
@@ -440,13 +434,9 @@ struct hostif_adhoc_set_request_t {
  */
 struct hostif_adhoc_set2_request_t {
 	struct hostif_hdr header;
-	__le16 phy_type;
-	__le16 cts_mode;
+	struct hostif_request_t request;
 	__le16 reserved;
-	struct rate_set16_t rate_set;
 	struct ssid_t ssid;
-	__le16 capability;
-	__le16 scan_type;
 	struct channel_list_t channel_list;
 	u8 bssid[ETH_ALEN];
 } __packed;
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
