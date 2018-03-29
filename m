Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-10225-1522302764-2-9673700725684795699
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522302762; b=gMeOhKSlUbOTUfC6fcpjxQ+zVqGca4OOKtcg04O5O+r0wgn
    KBQesr0F90gk+qvaaMwiwCuXtw9L/BM/OJ/6KF07lW6f2/MY6F4hvwEnWxNKS/qY
    ellyQsOjfPqEy2gkYKTZTiSyJyP+1LquK3PZL7YPiATsS2+GuZ8Z4lcOfaLx+aFO
    gioEruHz3T/dZprWu8I8Z77TdPbOyqrMMp5E4FdmNTCAN4RtGmhB4xse7W6v4MNJ
    WPYjOq4oMvWTtutbYZciw5x3NHvW1+wPEEShfICxgunpX9/M5aGWojQwxJz0rE6R
    PaM2+ptTNg1LP++c1ycAmjVyFWlvOjhlKj2Oc0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522302762; bh=y
    ajAhIwfDNNAoi3zNsCTLxrn9Q+SGo2Olc9blffhis4=; b=JXG1e4O4O08LVnIc2
    XmmX9v7PIYNOq7OBR+1Ehd6TyyTScZU7IguOMd4rhjCXExfebNIQocJPKIcta8gO
    q+GzdAkhXFksQDyD7ln16GtPIXsr+6plo9knvA6xmUf2r7L3ZMYuSabW/HZZVZiv
    c1DCWy7Jv1eqR2h1F+K0FPZA/CCb1uc1jTbObUHsmx+Us2kCq1IlXJJtmk1zwM4V
    iizJgPoBhO+iK76LHFea/RfwDX0x68agjjJORIc9bUohrAfBACFb8fhxhanXsVG1
    2VQNz0QI4St0/QF4EoUADokED1OuMuaqXmoZmE/VBqGI5kaVOtJuF8dMzj91h1sd
    nVCjw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF5Xen1DaQkto8wYb8WMzb04wmikEgjJqidrcu6Ve5CnFn10rYvGJObu9fW8UsUd4xUvUzyXf5FMK+lWvh6UiffA3uZ4MZ86ueoWWDwntQa1B0FXkhuu
    0HUDDAlqroZjD375p4k6P0OGXRQZxOaN6LlPX5NfouQJgiEyKxhCn/TvzqArykACtGbzo+NX4i6TqnNH4JMxFd9H5kk5AZ0yxqaarGoGjIOUDKKS9TjeXais
    WWQEzd+bxWbifzYMWH57ug==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=VMF5nZUn56hVVvUg__cA:9 a=EAXSSJKOSuaHH3z1:21 a=B0Qk5Z_DJvj5VD1K:21
    a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 7/9] staging: ks7010: Remove trailing "_t" from all structure
 names.
Date: Wed, 28 Mar 2018 22:51:50 -0700
Message-Id: <20180329055152.13059-7-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329055152.13059-1-quytelda@tamalin.org>
References: <20180329055152.13059-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:9Hy4oPbWyvEEZb0fbZ6WDGVLsqPhcANWPYUaYj0H95EB2cYMpQi
 Oyhh4qU+8zXaMO97uvUMDltOuUwE83YNBS/7vpOpZjXqWxsYorFHlMkxYtgSnf4fN/xRQ5p
 1eDVa/ab6yTvm3VtprqM3m9F/fW+Ihp6W52u3DOgoS0Q3sqVRctyjqV05HuCoTDf5X+YG9m
 +N4Kw8/6xsL8fI1uN0isA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GBm9bc6ItG0=:0byQHbeVbpf0OygPQa+A7z
 lepQu/nPCp8e4KZqlMrimtHqd6QsH/s3YogABfi+Rf8z6oPIp0SeN9peNParfTTLlNDwMunGP
 wNIpy9N/QCVdQjkJ3ug2bri6S5tmVs85YuRuelOJzvTzU1fCVg/Wkz8zu/WhQ67VR0gjlv6nW
 ZtNWFK2LAdKLaNUB0WoVs8nEu0RDoptG+nHEOYO9vZNiH6ouvPM+zy/jCAQ7IuKcQItFRzI6p
 I1HXXr2YBJYbY5uP2odhaf/SjJy5GBrgLO6/y4BnVj2jsdyWjjS98fBuGOiCwcL0CsjD6Dwj3
 YtBEHyvRvwDQE8nhosOWT5qFw5FLaxizRQ5mwUvsyVCeWd8AvoMsL2Xpcsd9o4awZ8aelVWYx
 L8a7fg5My+MczH/+/QaR6er6uRepn/SCpSsetKZ1MNFSFgUEGpq27DeWt2L/1edBsUqxsHaFb
 mKi6H1R1DRUF/JixU0BFyu452/Mjk1+GDRZ9C9e0tVUOsF7MttS9YsY5tKAa4ZDjRxDDXBeCH
 Kzm+/MgBX99GYAgfTmUkTgoPG0DcT1hucnfUC4q8xPA/+9DmLqCQl+tR4I/gqm8X1/PAs9xKy
 JoXGxGwD3ZLKt4Oo0Hdh8Pa1tq6XsoAhmWDmxZa6PESmYyU8szs9oPNXCKHtAM/VzPCHhRE9O
 H1ffXL4BH2qhuTDOoB9qRWhLd3G0umlW4a115xVwNG4+5t/vXGX/drMBpgTFDnU/vhNMqWv7B
 yNobv9Ka9crLGQf9bI+FW400AclLA++b4i7psg==
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

The "_t" suffix is not needed for structure names in this driver,
and is a reflection of an older typedef system that is no longer
in place.  Remove the "_t" suffix from every structure defined in this
driver.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks7010_sdio.c |   2 +-
 drivers/staging/ks7010/ks_hostif.c   |  80 ++++++++++----------
 drivers/staging/ks7010/ks_hostif.h   | 142 +++++++++++++++++------------------
 drivers/staging/ks7010/ks_wlan.h     |  68 ++++++++---------
 drivers/staging/ks7010/ks_wlan_net.c |  12 +--
 drivers/staging/ks7010/michael_mic.c |   8 +-
 drivers/staging/ks7010/michael_mic.h |   4 +-
 7 files changed, 158 insertions(+), 158 deletions(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index b8f55a11ee1c..d083bf8d238e 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -950,7 +950,7 @@ static int ks7010_sdio_probe(struct sdio_func *func,
 /* send stop request to MAC */
 static int send_stop_request(struct sdio_func *func)
 {
-	struct hostif_stop_request_t *pp;
+	struct hostif_stop_request *pp;
 	struct ks_sdio_card *card;
 	size_t size;
 
diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 79d21a64ffa2..a4020eeaac18 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -107,16 +107,16 @@ int ks_wlan_do_power_save(struct ks_wlan_private *priv)
 }
 
 static
-int get_current_ap(struct ks_wlan_private *priv, struct link_ap_info_t *ap_info)
+int get_current_ap(struct ks_wlan_private *priv, struct link_ap_info *ap_info)
 {
-	struct local_ap_t *ap;
+	struct local_ap *ap;
 	union iwreq_data wrqu;
 	struct net_device *netdev = priv->net_dev;
 
 	ap = &priv->current_ap;
 
 	if (is_disconnect_status(priv->connect_status)) {
-		memset(ap, 0, sizeof(struct local_ap_t));
+		memset(ap, 0, sizeof(struct local_ap));
 		return -EPERM;
 	}
 
@@ -223,13 +223,13 @@ static u8 read_ie(unsigned char *bp, u8 max, u8 *body)
 
 
 static
-int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
-		       struct local_ap_t *ap)
+int get_ap_information(struct ks_wlan_private *priv, struct ap_info *ap_info,
+		       struct local_ap *ap)
 {
 	unsigned char *bp;
 	int bsize, offset;
 
-	memset(ap, 0, sizeof(struct local_ap_t));
+	memset(ap, 0, sizeof(struct local_ap));
 
 	/* bssid */
 	memcpy(ap->bssid, ap_info->bssid, ETH_ALEN);
@@ -314,11 +314,11 @@ int hostif_data_indication_wpa(struct ks_wlan_private *priv,
 	unsigned char recv_mic[8];
 	char buf[128];
 	unsigned long now;
-	struct mic_failure_t *mic_failure;
-	struct michael_mic_t michael_mic;
+	struct mic_failure *mic_failure;
+	struct michael_mic michael_mic;
 	union iwreq_data wrqu;
 	unsigned int key_index = auth_type - 1;
-	struct wpa_key_t *key = &priv->wpa.key[key_index];
+	struct wpa_key *key = &priv->wpa.key[key_index];
 
 	eth_hdr = (struct ether_hdr *)(priv->rxp);
 	eth_proto = ntohs(eth_hdr->h_proto);
@@ -745,7 +745,7 @@ void hostif_connect_indication(struct ks_wlan_private *priv)
 		break;
 	}
 
-	get_current_ap(priv, (struct link_ap_info_t *)priv->rxp);
+	get_current_ap(priv, (struct link_ap_info *)priv->rxp);
 	if (is_connect_status(priv->connect_status) &&
 	    is_disconnect_status(old_status)) {
 		/* for power save */
@@ -771,10 +771,10 @@ static
 void hostif_scan_indication(struct ks_wlan_private *priv)
 {
 	int i;
-	struct ap_info_t *ap_info;
+	struct ap_info *ap_info;
 
 	netdev_dbg(priv->net_dev, "scan_ind_count = %d\n", priv->scan_ind_count);
-	ap_info = (struct ap_info_t *)(priv->rxp);
+	ap_info = (struct ap_info *)(priv->rxp);
 
 	if (priv->scan_ind_count) {
 		/* bssid check */
@@ -794,7 +794,7 @@ void hostif_scan_indication(struct ks_wlan_private *priv)
 	if (priv->scan_ind_count < LOCAL_APLIST_MAX + 1) {
 		netdev_dbg(priv->net_dev, " scan_ind_count=%d :: aplist.size=%d\n",
 			priv->scan_ind_count, priv->aplist.size);
-		get_ap_information(priv, (struct ap_info_t *)(priv->rxp),
+		get_ap_information(priv, (struct ap_info *)(priv->rxp),
 				   &(priv->aplist.ap[priv->scan_ind_count - 1]));
 		priv->aplist.size = priv->scan_ind_count;
 	} else {
@@ -863,8 +863,8 @@ void hostif_adhoc_set_confirm(struct ks_wlan_private *priv)
 static
 void hostif_associate_indication(struct ks_wlan_private *priv)
 {
-	struct association_request_t *assoc_req;
-	struct association_response_t *assoc_resp;
+	struct association_request *assoc_req;
+	struct association_response *assoc_resp;
 	unsigned char *pb;
 	union iwreq_data wrqu;
 	char buf[IW_CUSTOM_MAX];
@@ -874,8 +874,8 @@ void hostif_associate_indication(struct ks_wlan_private *priv)
 	static const char associnfo_leader0[] = "ASSOCINFO(ReqIEs=";
 	static const char associnfo_leader1[] = " RespIEs=";
 
-	assoc_req = (struct association_request_t *)(priv->rxp);
-	assoc_resp = (struct association_response_t *)(assoc_req + 1);
+	assoc_req = (struct association_request *)(priv->rxp);
+	assoc_resp = (struct association_response *)(assoc_req + 1);
 	pb = (unsigned char *)(assoc_resp + 1);
 
 	memset(&wrqu, 0, sizeof(wrqu));
@@ -1060,12 +1060,12 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
 
 	unsigned char *buffer = NULL;
 	unsigned int length = 0;
-	struct hostif_data_request_t *pp;
+	struct hostif_data_request *pp;
 	unsigned char *p;
 	int result = 0;
 	unsigned short eth_proto;
 	struct ether_hdr *eth_hdr;
-	struct michael_mic_t michael_mic;
+	struct michael_mic michael_mic;
 	unsigned short keyinfo = 0;
 	struct ieee802_1x_hdr *aa1x_hdr;
 	struct wpa_eapol_key *eap_key;
@@ -1240,7 +1240,7 @@ static
 void hostif_mib_get_request(struct ks_wlan_private *priv,
 			    unsigned long mib_attribute)
 {
-	struct hostif_mib_get_request_t *pp;
+	struct hostif_mib_get_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_MIB_GET_REQ);
 	if (!pp)
@@ -1258,7 +1258,7 @@ void hostif_mib_set_request(struct ks_wlan_private *priv,
 			    unsigned long mib_attribute, unsigned short size,
 			    unsigned short type, void *vp)
 {
-	struct hostif_mib_set_request_t *pp;
+	struct hostif_mib_set_request *pp;
 
 	if (priv->dev_state < DEVICE_STATE_BOOT)
 		return;
@@ -1280,7 +1280,7 @@ void hostif_mib_set_request(struct ks_wlan_private *priv,
 static
 void hostif_start_request(struct ks_wlan_private *priv, unsigned char mode)
 {
-	struct hostif_start_request_t *pp;
+	struct hostif_start_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_START_REQ);
 	if (!pp)
@@ -1313,7 +1313,7 @@ static __le16 ks_wlan_cap(struct ks_wlan_private *priv)
 	return cpu_to_le16((uint16_t)capability);
 }
 
-static void init_request(struct ks_wlan_private *priv, struct hostif_request_t *req)
+static void init_request(struct ks_wlan_private *priv, struct hostif_request *req)
 {
 	req->phy_type = cpu_to_le16((uint16_t)(priv->reg.phy_type));
 	req->cts_mode = cpu_to_le16((uint16_t)(priv->reg.cts_mode));
@@ -1327,7 +1327,7 @@ static void init_request(struct ks_wlan_private *priv, struct hostif_request_t *
 static
 void hostif_ps_adhoc_set_request(struct ks_wlan_private *priv)
 {
-	struct hostif_ps_adhoc_set_request_t *pp;
+	struct hostif_ps_adhoc_set_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_PS_ADH_SET_REQ);
 	if (!pp)
@@ -1344,7 +1344,7 @@ void hostif_ps_adhoc_set_request(struct ks_wlan_private *priv)
 static
 void hostif_infrastructure_set_request(struct ks_wlan_private *priv, int event)
 {
-	struct hostif_infrastructure_set_request_t *pp;
+	struct hostif_infrastructure_set_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), event);
 	if (!pp)
@@ -1385,7 +1385,7 @@ void hostif_infrastructure_set_request(struct ks_wlan_private *priv, int event)
 static
 void hostif_adhoc_set_request(struct ks_wlan_private *priv)
 {
-	struct hostif_adhoc_set_request_t *pp;
+	struct hostif_adhoc_set_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_ADH_SET_REQ);
 	if (!pp)
@@ -1404,7 +1404,7 @@ void hostif_adhoc_set_request(struct ks_wlan_private *priv)
 static
 void hostif_adhoc_set2_request(struct ks_wlan_private *priv)
 {
-	struct hostif_adhoc_set2_request_t *pp;
+	struct hostif_adhoc_set2_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_ADH_SET_REQ);
 	if (!pp)
@@ -1426,7 +1426,7 @@ void hostif_adhoc_set2_request(struct ks_wlan_private *priv)
 static
 void hostif_stop_request(struct ks_wlan_private *priv)
 {
-	struct hostif_stop_request_t *pp;
+	struct hostif_stop_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_STOP_REQ);
 	if (!pp)
@@ -1440,7 +1440,7 @@ void hostif_stop_request(struct ks_wlan_private *priv)
 static
 void hostif_phy_information_request(struct ks_wlan_private *priv)
 {
-	struct hostif_phy_information_request_t *pp;
+	struct hostif_phy_information_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_PHY_INFO_REQ);
 	if (!pp)
@@ -1464,7 +1464,7 @@ void hostif_power_mgmt_request(struct ks_wlan_private *priv,
 			       unsigned long mode, unsigned long wake_up,
 			       unsigned long receive_dtims)
 {
-	struct hostif_power_mgmt_request_t *pp;
+	struct hostif_power_mgmt_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_POWER_MGMT_REQ);
 	if (!pp)
@@ -1483,7 +1483,7 @@ static
 void hostif_sleep_request(struct ks_wlan_private *priv,
 			  enum sleep_mode_type mode)
 {
-	struct hostif_sleep_request_t *pp;
+	struct hostif_sleep_request *pp;
 
 	if (mode == SLP_SLEEP) {
 		pp = hostif_generic_request(sizeof(*pp), HIF_SLEEP_REQ);
@@ -1508,7 +1508,7 @@ void hostif_bss_scan_request(struct ks_wlan_private *priv,
 			     unsigned long scan_type, uint8_t *scan_ssid,
 			     uint8_t scan_ssid_len)
 {
-	struct hostif_bss_scan_request_t *pp;
+	struct hostif_bss_scan_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_SCAN_REQ);
 	if (!pp)
@@ -1558,7 +1558,7 @@ void hostif_mic_failure_request(struct ks_wlan_private *priv,
 				unsigned short failure_count,
 				unsigned short timer)
 {
-	struct hostif_mic_failure_request_t *pp;
+	struct hostif_mic_failure_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_MIC_FAILURE_REQ);
 	if (!pp)
@@ -1660,12 +1660,12 @@ void hostif_sme_set_wep(struct ks_wlan_private *priv, int type)
 	}
 }
 
-struct wpa_suite_t {
+struct wpa_suite {
 	__le16 size;
 	unsigned char suite[4][CIPHER_ID_LEN];
 } __packed;
 
-struct rsn_mode_t {
+struct rsn_mode {
 	__le32 rsn_mode;
 	__le16 rsn_capability;
 } __packed;
@@ -1673,8 +1673,8 @@ struct rsn_mode_t {
 static
 void hostif_sme_set_rsn(struct ks_wlan_private *priv, int type)
 {
-	struct wpa_suite_t wpa_suite;
-	struct rsn_mode_t rsn_mode;
+	struct wpa_suite wpa_suite;
+	struct rsn_mode rsn_mode;
 	__le32 val;
 
 	memset(&wpa_suite, 0, sizeof(wpa_suite));
@@ -2123,14 +2123,14 @@ void hostif_sme_set_key(struct ks_wlan_private *priv, int type)
 static
 void hostif_sme_set_pmksa(struct ks_wlan_private *priv)
 {
-	struct pmk_cache_t {
+	struct pmk_cache {
 		__le16 size;
 		struct {
 			u8 bssid[ETH_ALEN];
 			u8 pmkid[IW_PMKID_LEN];
 		} __packed list[PMK_LIST_MAX];
 	} __packed pmkcache;
-	struct pmk_t *pmk;
+	struct pmk *pmk;
 	int i;
 
 	i = 0;
@@ -2359,7 +2359,7 @@ void hostif_sme_enqueue(struct ks_wlan_private *priv, unsigned short event)
 
 static inline void hostif_aplist_init(struct ks_wlan_private *priv)
 {
-	size_t size = LOCAL_APLIST_MAX * sizeof(struct local_ap_t);
+	size_t size = LOCAL_APLIST_MAX * sizeof(struct local_ap);
 	priv->aplist.size = 0;
 	memset(&priv->aplist.ap[0], 0, size);
 }
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 2f918b11b337..f42a5921528f 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -67,7 +67,7 @@ struct hostif_hdr {
 	__le16 event;
 } __packed;
 
-struct hostif_data_request_t {
+struct hostif_data_request {
 	struct hostif_hdr header;
 	__le16 auth_type;
 #define TYPE_DATA 0x0000
@@ -76,7 +76,7 @@ struct hostif_data_request_t {
 	u8 data[0];
 } __packed;
 
-struct hostif_data_indication_t {
+struct hostif_data_indication {
 	struct hostif_hdr header;
 	__le16 auth_type;
 /* #define TYPE_DATA 0x0000 */
@@ -88,7 +88,7 @@ struct hostif_data_indication_t {
 } __packed;
 
 #define CHANNEL_LIST_MAX_SIZE 14
-struct channel_list_t {
+struct channel_list {
 	u8 size;
 	u8 body[CHANNEL_LIST_MAX_SIZE];
 	u8 pad;
@@ -142,12 +142,12 @@ struct channel_list_t {
 #define LOCAL_GAIN                        0xF10D0100	/* Carrer sense threshold for demo ato show */
 #define LOCAL_EEPROM_SUM                  0xF10E0100	/* EEPROM checksum information */
 
-struct hostif_mib_get_request_t {
+struct hostif_mib_get_request {
 	struct hostif_hdr header;
 	__le32 mib_attribute;
 } __packed;
 
-struct hostif_mib_value_t {
+struct hostif_mib_value {
 	__le16 size;
 	__le16 type;
 #define MIB_VALUE_TYPE_NULL     0
@@ -158,7 +158,7 @@ struct hostif_mib_value_t {
 	u8 body[0];
 } __packed;
 
-struct hostif_mib_get_confirm_t {
+struct hostif_mib_get_confirm {
 	struct hostif_hdr header;
 	__le32 mib_status;
 #define MIB_SUCCESS    0
@@ -166,22 +166,22 @@ struct hostif_mib_get_confirm_t {
 #define MIB_READ_ONLY  2
 #define MIB_WRITE_ONLY 3
 	__le32 mib_attribute;
-	struct hostif_mib_value_t mib_value;
+	struct hostif_mib_value mib_value;
 } __packed;
 
-struct hostif_mib_set_request_t {
+struct hostif_mib_set_request {
 	struct hostif_hdr header;
 	__le32 mib_attribute;
-	struct hostif_mib_value_t mib_value;
+	struct hostif_mib_value mib_value;
 } __packed;
 
-struct hostif_mib_set_confirm_t {
+struct hostif_mib_set_confirm {
 	struct hostif_hdr header;
 	__le32 mib_status;
 	__le32 mib_attribute;
 } __packed;
 
-struct hostif_power_mgmt_request_t {
+struct hostif_power_mgmt_request {
 	struct hostif_hdr header;
 	__le32 mode;
 #define POWER_ACTIVE  1
@@ -206,12 +206,12 @@ enum power_mgmt_mode_type {
 /* #define	RESULT_ALREADY_RUNNING    3 */
 #define	RESULT_ALREADY_RUNNING    7
 
-struct hostif_power_mgmt_confirm_t {
+struct hostif_power_mgmt_confirm {
 	struct hostif_hdr header;
 	__le16 result_code;
 } __packed;
 
-struct hostif_start_request_t {
+struct hostif_start_request {
 	struct hostif_hdr header;
 	__le16 mode;
 #define MODE_PSEUDO_ADHOC   0
@@ -220,63 +220,63 @@ struct hostif_start_request_t {
 #define MODE_ADHOC          3
 } __packed;
 
-struct hostif_start_confirm_t {
+struct hostif_start_confirm {
 	struct hostif_hdr header;
 	__le16 result_code;
 } __packed;
 
-struct ssid_t {
+struct ssid {
 	u8 size;
 	u8 body[IEEE80211_MAX_SSID_LEN];
 	u8 ssid_pad;
 } __packed;
 
 #define RATE_SET_MAX_SIZE 16
-struct rate_set8_t {
+struct rate_set8 {
 	u8 size;
 	u8 body[8];
 	u8 rate_pad;
 } __packed;
 
-struct fh_parms_t {
+struct fh_parms {
 	__le16 dwell_time;
 	u8 hop_set;
 	u8 hop_pattern;
 	u8 hop_index;
 } __packed;
 
-struct ds_parms_t {
+struct ds_parms {
 	u8 channel;
 } __packed;
 
-struct cf_parms_t {
+struct cf_parms {
 	u8 count;
 	u8 period;
 	__le16 max_duration;
 	__le16 dur_remaining;
 } __packed;
 
-struct ibss_parms_t {
+struct ibss_parms {
 	__le16 atim_window;
 } __packed;
 
-struct rsn_t {
+struct rsn {
 	u8 size;
 #define RSN_BODY_SIZE 64
 	u8 body[RSN_BODY_SIZE];
 } __packed;
 
-struct erp_params_t {
+struct erp_params {
 	u8 erp_info;
 } __packed;
 
-struct rate_set16_t {
+struct rate_set16 {
 	u8 size;
 	u8 body[16];
 	u8 rate_pad;
 } __packed;
 
-struct ap_info_t {
+struct ap_info {
 	u8 bssid[6];	/* +00 */
 	u8 rssi;	/* +06 */
 	u8 sq;	/* +07 */
@@ -291,7 +291,7 @@ struct ap_info_t {
 	/* +1032 */
 } __packed;
 
-struct link_ap_info_t {
+struct link_ap_info {
 	u8 bssid[6];	/* +00 */
 	u8 rssi;	/* +06 */
 	u8 sq;	/* +07 */
@@ -299,14 +299,14 @@ struct link_ap_info_t {
 	u8 pad0;	/* +09 */
 	__le16 beacon_period;	/* +10 */
 	__le16 capability;	/* +12 */
-	struct rate_set8_t rate_set;	/* +14 */
-	struct fh_parms_t fh_parameter;	/* +24 */
-	struct ds_parms_t ds_parameter;	/* +29 */
-	struct cf_parms_t cf_parameter;	/* +30 */
-	struct ibss_parms_t ibss_parameter;	/* +36 */
-	struct erp_params_t erp_parameter;	/* +38 */
+	struct rate_set8 rate_set;	/* +14 */
+	struct fh_parms fh_parameter;	/* +24 */
+	struct ds_parms ds_parameter;	/* +29 */
+	struct cf_parms cf_parameter;	/* +30 */
+	struct ibss_parms ibss_parameter;	/* +36 */
+	struct erp_params erp_parameter;	/* +38 */
 	u8 pad1;	/* +39 */
-	struct rate_set8_t ext_rate_set;	/* +40 */
+	struct rate_set8 ext_rate_set;	/* +40 */
 	u8 DTIM_period;	/* +50 */
 	u8 rsn_mode;	/* +51 */
 #define RSN_MODE_NONE	0
@@ -318,19 +318,19 @@ struct link_ap_info_t {
 	} __packed rsn;
 } __packed;
 
-struct hostif_connect_indication_t {
+struct hostif_connect_indication {
 	struct hostif_hdr header;
 	__le16 connect_code;
 #define RESULT_CONNECT    0
 #define RESULT_DISCONNECT 1
-	struct link_ap_info_t link_ap_info;
+	struct link_ap_info link_ap_info;
 } __packed;
 
-struct hostif_stop_request_t {
+struct hostif_stop_request {
 	struct hostif_hdr header;
 } __packed;
 
-struct hostif_stop_confirm_t {
+struct hostif_stop_confirm {
 	struct hostif_hdr header;
 	__le16 result_code;
 } __packed;
@@ -343,28 +343,28 @@ struct hostif_stop_confirm_t {
 #define CTS_MODE_FALSE	0
 #define CTS_MODE_TRUE	1
 
-struct hostif_request_t {
+struct hostif_request {
 	__le16 phy_type;
 	__le16 cts_mode;
 	__le16 scan_type;
 	__le16 capability;
-	struct rate_set16_t rate_set;
+	struct rate_set16 rate_set;
 } __packed;
 
 /**
- * struct hostif_ps_adhoc_set_request_t - pseudo adhoc mode
+ * struct hostif_ps_adhoc_set_request - pseudo adhoc mode
  * @capability: bit5  : preamble
  *              bit6  : pbcc - Not supported always 0
  *              bit10 : ShortSlotTime
  *              bit13 : DSSS-OFDM - Not supported always 0
  */
-struct hostif_ps_adhoc_set_request_t {
+struct hostif_ps_adhoc_set_request {
 	struct hostif_hdr header;
-	struct hostif_request_t request;
+	struct hostif_request request;
 	__le16 channel;
 } __packed;
 
-struct hostif_ps_adhoc_set_confirm_t {
+struct hostif_ps_adhoc_set_confirm {
 	struct hostif_hdr header;
 	__le16 result_code;
 } __packed;
@@ -379,17 +379,17 @@ struct hostif_ps_adhoc_set_confirm_t {
  *              bit10 : ShortSlotTime
  *              bit13 : DSSS-OFDM - Not supported always 0
  */
-struct hostif_infrastructure_set_request_t {
+struct hostif_infrastructure_set_request {
 	struct hostif_hdr header;
-	struct hostif_request_t request;
-	struct ssid_t ssid;
+	struct hostif_request request;
+	struct ssid ssid;
 	__le16 beacon_lost_count;
 	__le16 auth_type;
-	struct channel_list_t channel_list;
+	struct channel_list channel_list;
 	u8 bssid[ETH_ALEN];
 } __packed;
 
-struct hostif_infrastructure_set_confirm_t {
+struct hostif_infrastructure_set_confirm {
 	struct hostif_hdr header;
 	__le16 result_code;
 } __packed;
@@ -401,10 +401,10 @@ struct hostif_infrastructure_set_confirm_t {
  *              bit10 : ShortSlotTime
  *              bit13 : DSSS-OFDM - Not supported always 0
  */
-struct hostif_adhoc_set_request_t {
+struct hostif_adhoc_set_request {
 	struct hostif_hdr header;
-	struct hostif_request_t request;
-	struct ssid_t ssid;
+	struct hostif_request request;
+	struct ssid ssid;
 	__le16 channel;
 } __packed;
 
@@ -415,26 +415,26 @@ struct hostif_adhoc_set_request_t {
  *              bit10 : ShortSlotTime
  *              bit13 : DSSS-OFDM - Not supported always 0
  */
-struct hostif_adhoc_set2_request_t {
+struct hostif_adhoc_set2_request {
 	struct hostif_hdr header;
-	struct hostif_request_t request;
+	struct hostif_request request;
 	__le16 reserved;
-	struct ssid_t ssid;
-	struct channel_list_t channel_list;
+	struct ssid ssid;
+	struct channel_list channel_list;
 	u8 bssid[ETH_ALEN];
 } __packed;
 
-struct hostif_adhoc_set_confirm_t {
+struct hostif_adhoc_set_confirm {
 	struct hostif_hdr header;
 	__le16 result_code;
 } __packed;
 
-struct last_associate_t {
+struct last_associate {
 	u8 type;
 	u8 status;
 } __packed;
 
-struct association_request_t {
+struct association_request {
 	u8 type;
 	u8 pad;
 	__le16 capability;
@@ -443,7 +443,7 @@ struct association_request_t {
 	__le16 req_ies_size;
 } __packed;
 
-struct association_response_t {
+struct association_response {
 	u8 type;
 	u8 pad;
 	__le16 capability;
@@ -452,15 +452,15 @@ struct association_response_t {
 	__le16 resp_ies_size;
 } __packed;
 
-struct hostif_associate_indication_t {
+struct hostif_associate_indication {
 	struct hostif_hdr header;
-	struct association_request_t assoc_req;
-	struct association_response_t assoc_resp;
+	struct association_request assoc_req;
+	struct association_response assoc_resp;
 	/* followed by (req_ies_size + resp_ies_size) octets of data */
 	/* reqIEs data *//* respIEs data */
 } __packed;
 
-struct hostif_bss_scan_request_t {
+struct hostif_bss_scan_request {
 	struct hostif_hdr header;
 	u8 scan_type;
 #define ACTIVE_SCAN  0
@@ -468,17 +468,17 @@ struct hostif_bss_scan_request_t {
 	u8 pad[3];
 	__le32 ch_time_min;
 	__le32 ch_time_max;
-	struct channel_list_t channel_list;
-	struct ssid_t ssid;
+	struct channel_list channel_list;
+	struct ssid ssid;
 } __packed;
 
-struct hostif_bss_scan_confirm_t {
+struct hostif_bss_scan_confirm {
 	struct hostif_hdr header;
 	__le16 result_code;
 	__le16 reserved;
 } __packed;
 
-struct hostif_phy_information_request_t {
+struct hostif_phy_information_request {
 	struct hostif_hdr header;
 	__le16 type;
 #define NORMAL_TYPE	0
@@ -486,7 +486,7 @@ struct hostif_phy_information_request_t {
 	__le16 time;	/* unit 100ms */
 } __packed;
 
-struct hostif_phy_information_confirm_t {
+struct hostif_phy_information_confirm {
 	struct hostif_hdr header;
 	u8 rssi;
 	u8 sq;
@@ -503,22 +503,22 @@ enum sleep_mode_type {
 	SLP_SLEEP
 };
 
-struct hostif_sleep_request_t {
+struct hostif_sleep_request {
 	struct hostif_hdr header;
 } __packed;
 
-struct hostif_sleep_confirm_t {
+struct hostif_sleep_confirm {
 	struct hostif_hdr header;
 	__le16 result_code;
 } __packed;
 
-struct hostif_mic_failure_request_t {
+struct hostif_mic_failure_request {
 	struct hostif_hdr header;
 	__le16 failure_count;
 	__le16 timer;
 } __packed;
 
-struct hostif_mic_failure_confirm_t {
+struct hostif_mic_failure_confirm {
 	struct hostif_hdr header;
 	__le16 result_code;
 } __packed;
diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 1b7036c32d1c..999a929b8083 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -24,7 +24,7 @@
 #include <linux/netdevice.h>	/* struct net_device_stats,  struct sk_buff */
 #include <linux/etherdevice.h>
 #include <linux/wireless.h>
-#include <linux/atomic.h>	/* struct atomic_t */
+#include <linux/atomic.h>	/* struct atomic */
 #include <linux/timer.h>	/* struct timer_list */
 #include <linux/string.h>
 #include <linux/completion.h>	/* struct completion */
@@ -196,14 +196,14 @@ struct sme_info {
 	unsigned long sme_flag;
 };
 
-struct hostt_t {
+struct hostt {
 	int buff[SME_EVENT_BUFF_SIZE];
 	unsigned int qhead;
 	unsigned int qtail;
 };
 
 #define RSN_IE_BODY_MAX 64
-struct rsn_ie_t {
+struct rsn_ie {
 	u8 id;	/* 0xdd = WPA or 0x30 = RSN */
 	u8 size;	/* max ? 255 ? */
 	u8 body[RSN_IE_BODY_MAX];
@@ -211,14 +211,14 @@ struct rsn_ie_t {
 
 #ifdef WPS
 #define WPS_IE_BODY_MAX 255
-struct wps_ie_t {
+struct wps_ie {
 	u8 id;	/* 221 'dd <len> 00 50 F2 04' */
 	u8 size;	/* max ? 255 ? */
 	u8 body[WPS_IE_BODY_MAX];
 } __packed;
 #endif /* WPS */
 
-struct local_ap_t {
+struct local_ap {
 	u8 bssid[6];
 	u8 rssi;
 	u8 sq;
@@ -235,28 +235,28 @@ struct local_ap_t {
 	u16 capability;
 	u8 channel;
 	u8 noise;
-	struct rsn_ie_t wpa_ie;
-	struct rsn_ie_t rsn_ie;
+	struct rsn_ie wpa_ie;
+	struct rsn_ie rsn_ie;
 #ifdef WPS
-	struct wps_ie_t wps_ie;
+	struct wps_ie wps_ie;
 #endif /* WPS */
 };
 
 #define LOCAL_APLIST_MAX 31
 #define LOCAL_CURRENT_AP LOCAL_APLIST_MAX
-struct local_aplist_t {
+struct local_aplist {
 	int size;
-	struct local_ap_t ap[LOCAL_APLIST_MAX + 1];
+	struct local_ap ap[LOCAL_APLIST_MAX + 1];
 };
 
-struct local_gain_t {
+struct local_gain {
 	u8 tx_mode;
 	u8 rx_mode;
 	u8 tx_gain;
 	u8 rx_gain;
 };
 
-struct local_eeprom_sum_t {
+struct local_eeprom_sum {
 	u8 type;
 	u8 result;
 };
@@ -278,21 +278,21 @@ enum {
 	PS_WAKEUP
 };
 
-struct power_save_status_t {
+struct power_save_status {
 	atomic_t status;	/* initialvalue 0 */
 	struct completion wakeup_wait;
 	atomic_t confirm_wait;
 	atomic_t snooze_guard;
 };
 
-struct sleep_status_t {
+struct sleep_status {
 	atomic_t status;	/* initialvalue 0 */
 	atomic_t doze_request;
 	atomic_t wakeup_request;
 };
 
 /* WPA */
-struct scan_ext_t {
+struct scan_ext {
 	unsigned int flag;
 	char ssid[IW_ESSID_MAX_SIZE + 1];
 };
@@ -339,7 +339,7 @@ enum {
 
 #define MIC_KEY_SIZE 8
 
-struct wpa_key_t {
+struct wpa_key {
 	u32 ext_flags;	/* IW_ENCODE_EXT_xxx */
 	u8 tx_seq[IW_ENCODE_SEQ_MAX_SIZE];	/* LSB first */
 	u8 rx_seq[IW_ENCODE_SEQ_MAX_SIZE];	/* LSB first */
@@ -357,14 +357,14 @@ struct wpa_key_t {
 #define WPA_KEY_INDEX_MAX 4
 #define WPA_RX_SEQ_LEN 6
 
-struct mic_failure_t {
+struct mic_failure {
 	u16 failure;	/* MIC Failure counter 0 or 1 or 2 */
 	u16 counter;	/* 1sec counter 0-60 */
 	u32 last_failure_time;
 	int stop;	/* stop flag */
 };
 
-struct wpa_status_t {
+struct wpa_status {
 	int wpa_enabled;
 	unsigned int rsn_enabled;
 	int version;
@@ -373,17 +373,17 @@ struct wpa_status_t {
 	int key_mgmt_suite;	/* authentication key management suite */
 	int auth_alg;
 	int txkey;
-	struct wpa_key_t key[WPA_KEY_INDEX_MAX];
-	struct scan_ext_t scan_ext;
-	struct mic_failure_t mic_failure;
+	struct wpa_key key[WPA_KEY_INDEX_MAX];
+	struct scan_ext scan_ext;
+	struct mic_failure mic_failure;
 };
 
 #include <linux/list.h>
 #define PMK_LIST_MAX 8
-struct pmk_list_t {
+struct pmk_list {
 	u16 size;
 	struct list_head head;
-	struct pmk_t {
+	struct pmk {
 		struct list_head list;
 		u8 bssid[ETH_ALEN];
 		u8 pmkid[IW_PMKID_LEN];
@@ -391,7 +391,7 @@ struct pmk_list_t {
 };
 
 #ifdef WPS
-struct wps_status_t {
+struct wps_status {
 	int wps_enabled;
 	int ielen;
 	u8 ie[255];
@@ -423,12 +423,12 @@ struct ks_wlan_private {
 
 	unsigned char eth_addr[ETH_ALEN];
 
-	struct local_aplist_t aplist;
-	struct local_ap_t current_ap;
-	struct power_save_status_t psstatus;
-	struct sleep_status_t sleepstatus;
-	struct wpa_status_t wpa;
-	struct pmk_list_t pmklist;
+	struct local_aplist aplist;
+	struct local_ap current_ap;
+	struct power_save_status psstatus;
+	struct sleep_status sleepstatus;
+	struct wpa_status wpa;
+	struct pmk_list pmklist;
 	/* wireless parameter */
 	struct ks_wlan_parameter reg;
 	u8 current_rate;
@@ -471,19 +471,19 @@ struct ks_wlan_private {
 
 	u8 scan_ssid_len;
 	u8 scan_ssid[IW_ESSID_MAX_SIZE + 1];
-	struct local_gain_t gain;
+	struct local_gain gain;
 #ifdef WPS
 	struct net_device *l2_dev;
 	int l2_fd;
-	struct wps_status_t wps;
+	struct wps_status wps;
 #endif /* WPS */
 	u8 sleep_mode;
 
 	u8 region;
-	struct local_eeprom_sum_t eeprom_sum;
+	struct local_eeprom_sum eeprom_sum;
 	u8 eeprom_checksum;
 
-	struct hostt_t hostt;
+	struct hostt hostt;
 
 	unsigned long last_doze;
 	unsigned long last_wakeup;
diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index df6192be8a3e..d1296008dbf9 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -1316,7 +1316,7 @@ static int ks_wlan_set_scan(struct net_device *dev,
 static inline char *ks_wlan_translate_scan(struct net_device *dev,
 					   struct iw_request_info *info,
 					   char *current_ev, char *end_buf,
-					   struct local_ap_t *ap)
+					   struct local_ap *ap)
 {
 	/* struct ks_wlan_private *priv = (struct ks_wlan_private *)dev->priv; */
 	struct iw_event iwe;	/* Temporary buffer */
@@ -1721,7 +1721,7 @@ static int ks_wlan_set_encode_ext(struct net_device *dev,
 	struct iw_encode_ext *enc;
 	int index = dwrq->flags & IW_ENCODE_INDEX;
 	unsigned int commit = 0;
-	struct wpa_key_t *key;
+	struct wpa_key *key;
 
 	enc = (struct iw_encode_ext *)extra;
 	if (!enc)
@@ -1833,7 +1833,7 @@ static int ks_wlan_set_pmksa(struct net_device *dev,
 	struct ks_wlan_private *priv = netdev_priv(dev);
 	struct iw_pmksa *pmksa;
 	int i;
-	struct pmk_t *pmk;
+	struct pmk *pmk;
 	struct list_head *ptr;
 
 	if (priv->sleep_mode == SLP_SLEEP)
@@ -1862,7 +1862,7 @@ static int ks_wlan_set_pmksa(struct net_device *dev,
 		}
 		/* search cache data */
 		list_for_each(ptr, &priv->pmklist.head) {
-			pmk = list_entry(ptr, struct pmk_t, list);
+			pmk = list_entry(ptr, struct pmk, list);
 			if (memcmp(pmksa->bssid.sa_data, pmk->bssid, ETH_ALEN) == 0) {
 				memcpy(pmk->pmkid, pmksa->pmkid, IW_PMKID_LEN);
 				list_move(&pmk->list, &priv->pmklist.head);
@@ -1884,7 +1884,7 @@ static int ks_wlan_set_pmksa(struct net_device *dev,
 			list_add(&pmk->list, &priv->pmklist.head);
 			priv->pmklist.size++;
 		} else {	/* overwrite old cache data */
-			pmk = list_entry(priv->pmklist.head.prev, struct pmk_t,
+			pmk = list_entry(priv->pmklist.head.prev, struct pmk,
 					 list);
 			memcpy(pmk->bssid, pmksa->bssid.sa_data, ETH_ALEN);
 			memcpy(pmk->pmkid, pmksa->pmkid, IW_PMKID_LEN);
@@ -1897,7 +1897,7 @@ static int ks_wlan_set_pmksa(struct net_device *dev,
 		}
 		/* search cache data */
 		list_for_each(ptr, &priv->pmklist.head) {
-			pmk = list_entry(ptr, struct pmk_t, list);
+			pmk = list_entry(ptr, struct pmk, list);
 			if (memcmp(pmksa->bssid.sa_data, pmk->bssid, ETH_ALEN) == 0) {
 				eth_zero_addr(pmk->bssid);
 				memset(pmk->pmkid, 0, IW_PMKID_LEN);
diff --git a/drivers/staging/ks7010/michael_mic.c b/drivers/staging/ks7010/michael_mic.c
index 861721d762aa..6beee407c38b 100644
--- a/drivers/staging/ks7010/michael_mic.c
+++ b/drivers/staging/ks7010/michael_mic.c
@@ -36,7 +36,7 @@ do {					\
 } while (0)
 
 static
-void MichaelInitializeFunction(struct michael_mic_t *Mic, uint8_t *key)
+void MichaelInitializeFunction(struct michael_mic *Mic, uint8_t *key)
 {
 	// Set the key
 	Mic->k0 = getUInt32(key, 0);
@@ -59,7 +59,7 @@ do {								\
 } while (0)
 
 static
-void MichaelAppend(struct michael_mic_t *Mic, uint8_t *src, int nBytes)
+void MichaelAppend(struct michael_mic *Mic, uint8_t *src, int nBytes)
 {
 	int addlen;
 
@@ -94,7 +94,7 @@ void MichaelAppend(struct michael_mic_t *Mic, uint8_t *src, int nBytes)
 }
 
 static
-void MichaelGetMIC(struct michael_mic_t *Mic, uint8_t *dst)
+void MichaelGetMIC(struct michael_mic *Mic, uint8_t *dst)
 {
 	u8 *data = Mic->m;
 
@@ -123,7 +123,7 @@ void MichaelGetMIC(struct michael_mic_t *Mic, uint8_t *dst)
 	MichaelClear(Mic);
 }
 
-void MichaelMICFunction(struct michael_mic_t *Mic, u8 *Key,
+void MichaelMICFunction(struct michael_mic *Mic, u8 *Key,
 			u8 *Data, int Len, u8 priority,
 			u8 *Result)
 {
diff --git a/drivers/staging/ks7010/michael_mic.h b/drivers/staging/ks7010/michael_mic.h
index 64db7d1211d7..70234c3cd804 100644
--- a/drivers/staging/ks7010/michael_mic.h
+++ b/drivers/staging/ks7010/michael_mic.h
@@ -10,7 +10,7 @@
  */
 
 /* MichaelMIC routine define */
-struct michael_mic_t {
+struct michael_mic {
 	u32 k0;	// Key
 	u32 k1;	// Key
 	u32 l;	// Current state
@@ -20,6 +20,6 @@ struct michael_mic_t {
 	u8 result[8];
 };
 
-void MichaelMICFunction(struct michael_mic_t *Mic, u8 *Key,
+void MichaelMICFunction(struct michael_mic *Mic, u8 *Key,
 			u8 *Data, int Len, u8 priority,
 			u8 *Result);
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
