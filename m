Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C6AECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 19:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51942087B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 19:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx0b4G4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51942087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbeIQBDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 21:03:45 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43965 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbeIQBDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 21:03:45 -0400
Received: by mail-qt0-f196.google.com with SMTP id g53-v6so13451371qtg.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 12:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fCmbThanHNRqWzkPf9ptq4ou3MsvAkPKVX/ISu4SdFA=;
        b=Nx0b4G4feo35u9iHrtGrfPVKpUJAVz3fiQAGIRS4X3HvR6sqgsX9g0PH1m9gnB9RNu
         6j0j8unVBkmOdPFhqgNZkBWrs1ErmI3oyfFaoe4nbgadoufIpl1f/RoAf8sqrhYNsCd6
         uMCHFm2kchFQynX9j8qIYv1nuiE9nwyeNzWPkF2h8EoAfiZwCEI9mek9K5e7ygEtzl3f
         Zdl+h3S9VCDNb7GGzhO9X3RaksIw49qbvuyVWHWEMiwIaCGeIhtio4tkK+U6s61zNSMI
         XeaNPUWNDn/38P1ieREyLakkg54a39H+lvo2Rwt2PAsFuPUzFGFs0UyuCT38GlS/WfSS
         QZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fCmbThanHNRqWzkPf9ptq4ou3MsvAkPKVX/ISu4SdFA=;
        b=ah5gacgPP9FkEAcKdbjYtEZEI5YCBzRp7GRIqklG2zRWSgjioE1vmNdPGE7plx4LHZ
         zh0hJPBoD4kTLR2TUGwSRZtfIE/AjXp3PFQSpcZQ+GvzI1BKaLme9mMUKwEQh4tSffjJ
         SS7yUvOpVQmKrnXA+Znf7ZcbwOMGmQIfc6uVrEtMbRF4zo5SWHtZzGbkr7geDsdDr18P
         bb8EMiyHccTu4PIYeIdK1JXoOLpcJlTlDFAlucJ8R9NPnonhE0o28SwK5OycnHLNOU5u
         razTytbuSu8luVuG4BrbYigKbzr9UV7XZ9WlrPl7RdsjGpSGqXahr1P6DIJjwQis75W7
         1Hxg==
X-Gm-Message-State: APzg51DUuyjanEr8bsnO3t86rGQaRUg9bkDMJ6TKnwVfaCoITp0frrHp
        NtijO0kYUJ4E5l0fGltXr74=
X-Google-Smtp-Source: ANB0Vda93F1D7zZ0y25cxcv/Tpz6G3yWMhs3CaFQ0/DABSX9busDWWHt/4Yvy8z3iK+iNiQExh+FaQ==
X-Received: by 2002:a0c:ca06:: with SMTP id c6-v6mr15724451qvk.64.1537126785067;
        Sun, 16 Sep 2018 12:39:45 -0700 (PDT)
Received: from localhost.localdomain ([186.19.75.93])
        by smtp.gmail.com with ESMTPSA id a66-v6sm7079328qkf.96.2018.09.16.12.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 12:39:44 -0700 (PDT)
From:   Pablo Pellecchia <pablo9891@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Pablo Pellecchia <pablo9891@gmail.com>
Subject: [PATCH 1/4] Staging: wlan-ng: Solved Coding Style issues
Date:   Sun, 16 Sep 2018 16:39:11 -0300
Message-Id: <20180916193911.8191-1-pablo9891@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Solved parenthesis alignment issues throw by checkpatch.pl

Signed-off-by: Pablo Pellecchia <pablo9891@gmail.com>
---
 drivers/staging/wlan-ng/cfg80211.c | 40 ++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

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
-- 
2.14.1


From 16682e3ba99b18e6ecead3865ce2d06459281887 Mon Sep 17 00:00:00 2001
From: Pablo Pellecchia <pablo9891@gmail.com>
Date: Sun, 16 Sep 2018 15:56:36 -0300
Subject: [PATCH 2/4] Staging: wlan-ng: Solved coding style issues

Added comments on struct hfa384x_usbctlxq structure

Signed-off-by: Pablo Pellecchia <pablo9891@gmail.com>
---
 drivers/staging/wlan-ng/hfa384x.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

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
-- 
2.14.1


From a75dd8f88e5bbecdb6228e2c529b436748cf5929 Mon Sep 17 00:00:00 2001
From: Pablo Pellecchia <pablo9891@gmail.com>
Date: Sun, 16 Sep 2018 15:59:34 -0300
Subject: [PATCH 3/4] Staging: wlan-ng: Solved wrong usless cast issue

Checkpatch was throwing warnings with 'long int' casting considering
it useless. So i fixed that to only 'long' cast

Signed-off-by: Pablo Pellecchia <pablo9891@gmail.com>
---
 drivers/staging/wlan-ng/p80211conv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.14.1


From b3c401741387f39cc5f6eddf7216ed8cb4e942c1 Mon Sep 17 00:00:00 2001
From: Pablo Pellecchia <pablo9891@gmail.com>
Date: Sun, 16 Sep 2018 16:04:25 -0300
Subject: [PATCH 4/4] Staging: wlan-ng: Solved coding style issues

Solved parenthesis alignment issues

Signed-off-by: Pablo Pellecchia <pablo9891@gmail.com>
---
 drivers/staging/wlan-ng/prism2mgmt.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

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

