Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83A5ECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 04:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7025920883
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 04:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGIyPwcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7025920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeIPJpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 05:45:36 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39018 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeIPJpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 05:45:36 -0400
Received: by mail-qk1-f195.google.com with SMTP id b19-v6so7343323qkc.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 21:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6VNXaO3RSFyO5R5EsJNsP86JhiqJU+CYojtjPFQeqVo=;
        b=bGIyPwcP1kdvt8VdveuCCPHSyEN9bJ/TPZXFW63uPhtlSXborBI6Q2jYZgwyzU5wWn
         rteDpZJl8QLWhtcKwnY5q7phZLw+YiI5EwC6kLjRHLCxXIjPVktclVV5E/fW9fdgYsT9
         rmelnW+maO7IcfA29ydcg/qXBRRpOol6wl+ifbhidEupuUZl0CUHHpZUJDkcRBJ/oSiZ
         m0yfoS3b1Am1h2SdzrP/7gw3xjD3nXesJ8rtakea6j1Xh9t0LbPpkuxyGSMZLeUtlWIW
         ibnmrGTeHi6YCxvAIUBHkCU6OyCvxYssJ3j1MPntKvtL/+oEuHIftcslpOKPD75VaqEF
         JZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6VNXaO3RSFyO5R5EsJNsP86JhiqJU+CYojtjPFQeqVo=;
        b=KPL2Y2pbsCeebJrhaompgJ9NpyBNKDmBvrYn7OxSAnk56vJViSmTmdPgb/frnSqLEG
         xXZJ0mTUc34Bu12JDl/QffuOOfolMD7JKXx3McPBWP2zSeDDXgXZXg5Pnop7PZZGTCxn
         UD4cp7IjeU/rQBpMdZIx54ScVDA3kwh5vYhBMiM5ZhGplWIc6K8fDWDqCqYoUGPatb/T
         2L6whbytG6XaJRBzORXxPrgxqTdEz0BtiXA4fZThhXoZsdXUd+n1MAE8uNuGgJ7yFQVi
         lq7jwq6Oy8P305VIhH/0bgDE9pmeNfGq4CT72lJddekaQX6HHWL6jvq6AObl67Id987f
         6wEA==
X-Gm-Message-State: APzg51BviwFJI96t75SvxuYrmP3hUQsaSYhRSl4HFZ9lror4kqWXuQKB
        kYwM5HIS/ZcA/eyt4Y2nqVA=
X-Google-Smtp-Source: ANB0VdZoabIilGWnBZOfmDuuMsuxSGUUXj53TV41EgugrBV7UpalmWGluzP3ZQBpvCQYFVqFP2e5cw==
X-Received: by 2002:a37:179e:: with SMTP id 30-v6mr13094412qkx.33.1537071842211;
        Sat, 15 Sep 2018 21:24:02 -0700 (PDT)
Received: from localhost.localdomain ([186.19.75.93])
        by smtp.gmail.com with ESMTPSA id p4-v6sm8285108qkl.41.2018.09.15.21.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 21:24:01 -0700 (PDT)
From:   Pablo Pellecchia <pablo9891@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Pablo Pellecchia <pablo9891@gmail.com>
Subject: [PATCH] :Staging :Wlan-ng Fixed coding style issues
Date:   Sun, 16 Sep 2018 01:23:26 -0300
Message-Id: <20180916042326.22178-1-pablo9891@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed coding style issues on wlan-ng directory.

Changes include:
	- Parenthesis alignment
	- Wrong casting issues
	- Adding comments
    - Lines ending with '('

Signed-off-by: Pablo Pellecchia <pablo9891@gmail.com>
---
 drivers/staging/wlan-ng/cfg80211.c   | 40 +++++++++++++++++-------------------
 drivers/staging/wlan-ng/hfa384x.h    |  5 +++--
 drivers/staging/wlan-ng/p80211conv.c |  2 +-
 drivers/staging/wlan-ng/prism2mgmt.c | 28 ++++++++++++-------------
 4 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index d4cf09b11e33..38bf555a8d3e 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -234,8 +234,8 @@ static int prism2_set_default_key(struct wiphy *wiphy, struct net_device *dev,
 	int result = 0;
 
 	result = prism2_domibset_uint32(wlandev,
-		DIDmib_dot11smt_dot11PrivacyTable_dot11WEPDefaultKeyID,
-		key_index);
+					DIDmib_dot11smt_dot11PrivacyTable_dot11WEPDefaultKeyID,
+					key_index);
 
 	if (result)
 		err = -EFAULT;
@@ -331,8 +331,8 @@ static int prism2_scan(struct wiphy *wiphy,
 		(i < request->n_channels) && i < ARRAY_SIZE(prism2_channels);
 		i++)
 		msg1.channellist.data.data[i] =
-			ieee80211_frequency_to_channel(
-				request->channels[i]->center_freq);
+			ieee80211_frequency_to_channel
+		  (request->channels[i]->center_freq);
 	msg1.channellist.data.len = request->n_channels;
 
 	msg1.maxchanneltime.data = 250;
@@ -366,17 +366,16 @@ static int prism2_scan(struct wiphy *wiphy,
 		freq = ieee80211_channel_to_frequency(msg2.dschannel.data,
 						      NL80211_BAND_2GHZ);
 		bss = cfg80211_inform_bss(wiphy,
-			ieee80211_get_channel(wiphy, freq),
-			CFG80211_BSS_FTYPE_UNKNOWN,
-			(const u8 *)&msg2.bssid.data.data,
-			msg2.timestamp.data, msg2.capinfo.data,
-			msg2.beaconperiod.data,
-			ie_buf,
-			ie_len,
-			(msg2.signal.data - 65536) * 100, /* Conversion to signed type */
-			GFP_KERNEL
-		);
-
+					  ieee80211_get_channel(wiphy, freq),
+					  CFG80211_BSS_FTYPE_UNKNOWN,
+					  (const u8 *)&msg2.bssid.data.data,
+					  msg2.timestamp.data, msg2.capinfo.data,
+					  msg2.beaconperiod.data,
+					  ie_buf,
+					  ie_len,
+					  (msg2.signal.data - 65536) * 100, /* Conversion to signed type */
+					  GFP_KERNEL
+					  );
 		if (!bss) {
 			err = -ENOMEM;
 			goto exit;
@@ -482,14 +481,13 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
 			}
 
 			result = prism2_domibset_uint32(wlandev,
-				DIDmib_dot11smt_dot11PrivacyTable_dot11WEPDefaultKeyID,
-				sme->key_idx);
+							DIDmib_dot11smt_dot11PrivacyTable_dot11WEPDefaultKeyID,
+							sme->key_idx);
 			if (result)
 				goto exit;
 
 			/* send key to driver */
-			did = DIDmib_dot11smt_dot11WEPDefaultKeysTable_key(
-					sme->key_idx + 1);
+			did = DIDmib_dot11smt_dot11WEPDefaultKeysTable_key(sme->key_idx + 1);
 			result = prism2_domibset_pstr32(wlandev,
 							did, sme->key_len,
 							(u8 *)sme->key);
@@ -595,8 +593,8 @@ static int prism2_set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 		data = MBM_TO_DBM(mbm);
 
 	result = prism2_domibset_uint32(wlandev,
-		DIDmib_dot11phy_dot11PhyTxPowerTable_dot11CurrentTxPowerLevel,
-		data);
+					DIDmib_dot11phy_dot11PhyTxPowerTable_dot11CurrentTxPowerLevel,
+					data);
 
 	if (result) {
 		err = -EFAULT;
diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
index 992ebaa1071f..f2ea389c870b 100644
--- a/drivers/staging/wlan-ng/hfa384x.h
+++ b/drivers/staging/wlan-ng/hfa384x.h
@@ -1182,11 +1182,12 @@ struct hfa384x_usbctlx {
 	ctlx_usercb_t usercb;	/* Async user callback, */
 	void *usercb_data;	/*  at CTLX completion  */
 
-	int variant;		/* Identifies cmd variant */
+	int variant;	        /* Identifies cmd variant */
 };
 
+/*Queues for CTLX status.*/
 struct hfa384x_usbctlxq {
-	spinlock_t lock;
+	spinlock_t lock;        /*Spinlock to allow mutual exclusion*/
 	struct list_head pending;
 	struct list_head active;
 	struct list_head completing;
diff --git a/drivers/staging/wlan-ng/p80211conv.c b/drivers/staging/wlan-ng/p80211conv.c
index 91debcf20646..0ff5fda81b05 100644
--- a/drivers/staging/wlan-ng/p80211conv.c
+++ b/drivers/staging/wlan-ng/p80211conv.c
@@ -430,7 +430,7 @@ int skb_p80211_to_ether(struct wlandevice *wlandev, u32 ethconv,
 			/* A bogus length ethfrm has been sent. */
 			/* Is someone trying an oflow attack? */
 			netdev_err(netdev, "DIXII frame too large (%ld > %d)\n",
-				   (long int)(payload_length -
+				   (long)(payload_length -
 				   sizeof(struct wlan_llc) -
 				   sizeof(struct wlan_snap)), netdev->mtu);
 			return 1;
diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng/prism2mgmt.c
index 7350fe5d96a3..81ae22e18278 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -228,8 +228,8 @@ int prism2mgmt_scan(struct wlandevice *wlandev, void *msgp)
 		__le16 wordbuf[17];
 
 		result = hfa384x_drvr_setconfig16(hw,
-					HFA384x_RID_CNFROAMINGMODE,
-					HFA384x_ROAMMODE_HOSTSCAN_HOSTROAM);
+						  HFA384x_RID_CNFROAMINGMODE,
+						  HFA384x_ROAMMODE_HOSTSCAN_HOSTROAM);
 		if (result) {
 			netdev_err(wlandev->netdev,
 				   "setconfig(ROAMINGMODE) failed. result=%d\n",
@@ -275,8 +275,8 @@ int prism2mgmt_scan(struct wlandevice *wlandev, void *msgp)
 		}
 		/* ibss options */
 		result = hfa384x_drvr_setconfig16(hw,
-					HFA384x_RID_CREATEIBSS,
-					HFA384x_CREATEIBSS_JOINCREATEIBSS);
+						  HFA384x_RID_CREATEIBSS,
+						  HFA384x_CREATEIBSS_JOINCREATEIBSS);
 		if (result) {
 			netdev_err(wlandev->netdev,
 				   "Failed to set CREATEIBSS.\n");
@@ -1167,8 +1167,8 @@ int prism2mgmt_wlansniff(struct wlandevice *wlandev, void *msgp)
 		if (hw->presniff_port_type != 0) {
 			word = hw->presniff_port_type;
 			result = hfa384x_drvr_setconfig16(hw,
-						  HFA384x_RID_CNFPORTTYPE,
-						  word);
+							  HFA384x_RID_CNFPORTTYPE,
+							  word);
 			if (result) {
 				netdev_dbg
 				    (wlandev->netdev,
@@ -1198,8 +1198,8 @@ int prism2mgmt_wlansniff(struct wlandevice *wlandev, void *msgp)
 			if (wlandev->netdev->type == ARPHRD_ETHER) {
 				/* Save macport 0 state */
 				result = hfa384x_drvr_getconfig16(hw,
-						  HFA384x_RID_CNFPORTTYPE,
-						  &hw->presniff_port_type);
+								  HFA384x_RID_CNFPORTTYPE,
+								  &hw->presniff_port_type);
 				if (result) {
 					netdev_dbg
 					(wlandev->netdev,
@@ -1209,8 +1209,8 @@ int prism2mgmt_wlansniff(struct wlandevice *wlandev, void *msgp)
 				}
 				/* Save the wepflags state */
 				result = hfa384x_drvr_getconfig16(hw,
-						  HFA384x_RID_CNFWEPFLAGS,
-						  &hw->presniff_wepflags);
+								  HFA384x_RID_CNFWEPFLAGS,
+								  &hw->presniff_wepflags);
 				if (result) {
 					netdev_dbg
 					(wlandev->netdev,
@@ -1259,8 +1259,8 @@ int prism2mgmt_wlansniff(struct wlandevice *wlandev, void *msgp)
 			/* Set the port type to pIbss */
 			word = HFA384x_PORTTYPE_PSUEDOIBSS;
 			result = hfa384x_drvr_setconfig16(hw,
-						  HFA384x_RID_CNFPORTTYPE,
-						  word);
+							  HFA384x_RID_CNFPORTTYPE,
+							  word);
 			if (result) {
 				netdev_dbg
 				    (wlandev->netdev,
@@ -1276,8 +1276,8 @@ int prism2mgmt_wlansniff(struct wlandevice *wlandev, void *msgp)
 				    HFA384x_WEPFLAGS_DISABLE_RXCRYPT;
 				result =
 				    hfa384x_drvr_setconfig16(hw,
-						     HFA384x_RID_CNFWEPFLAGS,
-						     word);
+							     HFA384x_RID_CNFWEPFLAGS,
+							     word);
 			}
 
 			if (result) {
-- 
2.14.1

