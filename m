Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2920666-1525592020-5-17934284969304758800
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525592019; b=MwlzdFpTaAQbhEqt/BYhn9nBoM7DAX0zEEpedHmyY2qCOYEm9E
    UAr8rHCouw6BMTBCrU0dwoFXTjA4KDo+JZ0HcRMwKaOi2VSexIkyGmJBnMwvgPsT
    /MgPEiSmN7Dyz/7FnEkNVp4e3KGro45UJy4yLQ4ILxQuEnfN2/Phy6KXzQ/e7d43
    ykHDscKxyNe33pwZAS8ZsRdHhqfqNZ0vAnO4DyyI4p5ThNXywP7cJKVyQ9Wb/Yr7
    Px5Uw+UOzwXB3hXFo1jV1xz7lWINXqr8dXU7vQjYOMgCUuRwo4JGnJ9rl10vb1lI
    sONoXr89lyOPbXDbCCEf3V8qVpSPOw4QLnpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525592019; bh=mMSAz
    Z5n09XaklJKHPeUyC/YBAvRXOeEo03BEDop8uk=; b=Z+YK7uGjpQzP+0/tQvQmB
    W8xRkB5SQ4SyGqWvwSW5xp8iAkS9imYYsjVH0k6Tzi7rtFGAooxOZmzKJizXireU
    pSQdJSVaJBTO3UfEnQPJd1sj4P6JElRd7gxUAgCeF3gX66zBdYFp/F3Uq0PSK8Ql
    MQN3Fz9oAbZMZrSrC9/iIDW0iB6yx7IaXU6JxFRSMognQHD5cx5+NX+rM8g6tIQ3
    KakcOf11ltOyjnxSP0o4TmPXkgfSYkiH5XbLXxvGgWBbGmmfVWAd9AOO4tNo2qM5
    EIpvM81VoDdJYi0PybPsvqYx7FkqwFOh4LTwzhz0My9tlHmJtGiJfhQgIUAGswdh
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=QTEfR/EU x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Tj77C3Fl;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=QTEfR/EU x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Tj77C3Fl;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNvyPm9plh8KG78hyuAps13cXLAKaHZFEUoNmN24RCEz0GDCFraZqRV7hUzEnnh/u9iFGipUPFAOAxH0J7XAuwjYqCEC3D5hr+VLDF5xEI0mdT9u2+bX
    T2Y4A9UGtCEtQ43F2ylPxhGoPxfrTgYH9T4SNuJyx64WEWGwCWhpy1zXzI3XNmI2AuyXLy7CPQYw1hJIT9BTqFleI+3V6iR9Nj3MoktTHxDTzXW/V7o8REVH
    FvoZQ2c7HyV49LurDwS1yQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=DDOyTI_5AAAA:8 a=qVzR5ki6J9thZf30u_8A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZo/qXJjxMVdsK9M5UIzhAjPd/VqoTxYqqUzX30PywT/e/i77iJnjMTK3WHZjmzwjbCj6hHeZA==
From: Nathan Chancellor <natechancellor@gmail.com>
To: devel@driverdev.osuosl.org
Subject: [PATCH 1/3] staging: wilc1000: Remove unused variables
Date: Sun,  6 May 2018 00:33:31 -0700
Message-Id: <20180506073333.3770-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.17.0
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ganesh Krishna <ganesh.krishna@microchip.com>,
 Aditya Shankar <aditya.shankar@microchip.com>,
 Nathan Chancellor <natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

GCC warns these variables are all set but never used so remove them.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/wilc1000/host_interface.c         | 12 ------------
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c |  6 ------
 2 files changed, 18 deletions(-)

diff --git a/drivers/staging/wilc1000/host_interface.c b/drivers/staging/wilc1000/host_interface.c
index 28edd904b33a..3fd4c8e62da6 100644
--- a/drivers/staging/wilc1000/host_interface.c
+++ b/drivers/staging/wilc1000/host_interface.c
@@ -1432,13 +1432,7 @@ static s32 handle_rcvd_gnrl_async_info(struct wilc_vif *vif,
 {
 	s32 result = 0;
 	u8 msg_type = 0;
-	u8 msg_id = 0;
-	u16 msg_len = 0;
-	u16 wid_id = (u16)WID_NIL;
-	u8 wid_len  = 0;
 	u8 mac_status;
-	u8 mac_status_reason_code;
-	u8 mac_status_additional_info;
 	struct host_if_drv *hif_drv = vif->hif_drv;
 
 	if (!rcvd_info->buffer) {
@@ -1472,13 +1466,7 @@ static s32 handle_rcvd_gnrl_async_info(struct wilc_vif *vif,
 			return -EFAULT;
 		}
 
-		msg_id = rcvd_info->buffer[1];
-		msg_len = MAKE_WORD16(rcvd_info->buffer[2], rcvd_info->buffer[3]);
-		wid_id = MAKE_WORD16(rcvd_info->buffer[4], rcvd_info->buffer[5]);
-		wid_len = rcvd_info->buffer[6];
 		mac_status  = rcvd_info->buffer[7];
-		mac_status_reason_code = rcvd_info->buffer[8];
-		mac_status_additional_info = rcvd_info->buffer[9];
 		if (hif_drv->hif_state == HOST_IF_WAITING_CONN_RESP) {
 			host_int_parse_assoc_resp_info(vif, mac_status);
 		} else if ((mac_status == MAC_STATUS_DISCONNECTED) &&
diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
index 8be3c4c57579..76b4afaef423 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -917,12 +917,10 @@ static int add_key(struct wiphy *wiphy, struct net_device *netdev, u8 key_index,
 	const u8 *tx_mic = NULL;
 	u8 mode = NO_ENCRYPT;
 	u8 op_mode;
-	struct wilc *wl;
 	struct wilc_vif *vif;
 
 	priv = wiphy_priv(wiphy);
 	vif = netdev_priv(netdev);
-	wl = vif->wilc;
 
 	switch (params->cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
@@ -1885,12 +1883,10 @@ static int start_ap(struct wiphy *wiphy, struct net_device *dev,
 		    struct cfg80211_ap_settings *settings)
 {
 	struct cfg80211_beacon_data *beacon = &settings->beacon;
-	struct wilc_priv *priv;
 	s32 ret = 0;
 	struct wilc *wl;
 	struct wilc_vif *vif;
 
-	priv = wiphy_priv(wiphy);
 	vif = netdev_priv(dev);
 	wl = vif->wilc;
 
@@ -2016,14 +2012,12 @@ static int change_station(struct wiphy *wiphy, struct net_device *dev,
 			  const u8 *mac, struct station_parameters *params)
 {
 	s32 ret = 0;
-	struct wilc_priv *priv;
 	struct add_sta_param sta_params = { {0} };
 	struct wilc_vif *vif;
 
 	if (!wiphy)
 		return -EFAULT;
 
-	priv = wiphy_priv(wiphy);
 	vif = netdev_priv(dev);
 
 	if (vif->iftype == AP_MODE || vif->iftype == GO_MODE) {
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
