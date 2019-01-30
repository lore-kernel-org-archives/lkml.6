Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31F5C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10AB2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okc51cUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbfA3Rp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:45:56 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54188 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbfA3Rpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:45:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so417143wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 09:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hZA5+6dQ0IxnpOhRlyCjf/F14kZPf1RywVQbHEFcjqE=;
        b=okc51cUXHqqXNL3G7utUzTl23uA1urroBt3P62QmwoG0J9h0hyStetIpwJu7HTyqj6
         aMRRTAyEJr4IgNUhgqiicYBhVuAfEr5qJMP+32UfRxJry313XBwAhrXzRaxt1a3YDcbv
         5Dv827vxmaS/KEe78gYuakdxAi4pnKNulYweaWVHIasV0F/VgRhOr3F2T7NfcIm//kS9
         v4g9SrCAivbkh+P2hQD+Xe7nPWwUWdeDrAJUm1Zpgq8H+/zVDkov99h16avS6KKzQikw
         joJzY4okvLp1d5zAVmV1svTwDQ4uqhczyfy0fHmoUh/xgBGnYOrjN5zT2inJMnU/Q6uA
         Czxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hZA5+6dQ0IxnpOhRlyCjf/F14kZPf1RywVQbHEFcjqE=;
        b=jySurToi6l8X3C9TZoIoyGcOK4m1di7f7jrnotzhl7wE+yAMAeQI+uA0Uf7tYz5uyk
         kd4wK1gpRYmm1pMup7JeVLBe9NlyS8WmjP7xB60cqe3DUW14ZkUfgBYh3ilxOKp7i9j+
         jZDFpRyDi4HCnJjP1CyxmwEnaypQ2SNkh9PXWufP3s3oK3BqeE/HqbxEtF1oKrMUVBJB
         R0MiXQTHkr8D6sXTqWeynjsT5Y+CuNv+qinfqyHAqX86ytTKq0xQw5tITVWyDufEkID2
         pHsi0gkp45OTksQ3SXtaiVRahp7yefR2xF5tpCHdNq1GRmH9z8ec1B+kHnyBgt+HkDQa
         zhmw==
X-Gm-Message-State: AJcUukfuSujtL4dfbmtIzB2EZ/s4i4Wh8wYre9c1vMkm5EhpRQWmN1fF
        sH/cRSEocgvMpn8ZBs7pAoJ95kzIhG4=
X-Google-Smtp-Source: ALg8bN76JHRmyfMdjE0WGcGYrJN7uuYpcGzaOPyYE88zHx0IbQK5WkPYVn6qoqgyDBwuC7AOFv/KRA==
X-Received: by 2002:a1c:a6c2:: with SMTP id p185mr23832431wme.133.1548870354166;
        Wed, 30 Jan 2019 09:45:54 -0800 (PST)
Received: from localhost.localdomain ([141.72.240.238])
        by smtp.gmail.com with ESMTPSA id x12sm2278187wrt.20.2019.01.30.09.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 09:45:53 -0800 (PST)
From:   SandeshKa07 <kas.sandesh@gmail.com>
To:     gregkh@linuxfoundation.org, osdevtc@gmail.com,
        eklikeroomys@gmail.com, omer.efrat@tandemg.com
Cc:     linux-kernel@vger.kernel.org,
        Sandesh Kenjana Ashok <kas.sandesh@gmail.com>
Subject: [PATCH] staging:wlan-ng:cfg80211.c Fixed line more than 80 characters.
Date:   Wed, 30 Jan 2019 18:45:38 +0100
Message-Id: <20190130174538.9189-1-kas.sandesh@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandesh Kenjana Ashok <kas.sandesh@gmail.com>

Lines over 80 characters are adjusted according to standards

Signed-off-by: Sandesh Kenjana Ashok <kas.sandesh@gmail.com>
---
 drivers/staging/wlan-ng/cfg80211.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index e5d7def1f366..7687f619ee34 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -373,7 +373,8 @@ static int prism2_scan(struct wiphy *wiphy,
 			msg2.beaconperiod.data,
 			ie_buf,
 			ie_len,
-			(msg2.signal.data - 65536) * 100, /* Conversion to signed type */
+			/*Conversion to signed type*/
+			(msg2.signal.data - 65536) * 100,
 			GFP_KERNEL
 		);
 
@@ -410,7 +411,7 @@ static int prism2_set_wiphy_params(struct wiphy *wiphy, u32 changed)
 			data = wiphy->rts_threshold;
 
 		result = prism2_domibset_uint32(wlandev,
-						DIDMIB_DOT11MAC_OPERATIONTABLE_RTSTHRESHOLD,
+				DIDMIB_DOT11MAC_OPERATIONTABLE_RTSTHRESHOLD,
 						data);
 		if (result) {
 			err = -EFAULT;
@@ -425,7 +426,7 @@ static int prism2_set_wiphy_params(struct wiphy *wiphy, u32 changed)
 			data = wiphy->frag_threshold;
 
 		result = prism2_domibset_uint32(wlandev,
-						DIDMIB_DOT11MAC_OPERATIONTABLE_FRAGMENTATIONTHRESHOLD,
+			DIDMIB_DOT11MAC_OPERATIONTABLE_FRAGMENTATIONTHRESHOLD,
 						data);
 		if (result) {
 			err = -EFAULT;
@@ -455,7 +456,7 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
 	if (channel) {
 		chan = ieee80211_frequency_to_channel(channel->center_freq);
 		result = prism2_domibset_uint32(wlandev,
-						DIDMIB_DOT11PHY_DSSSTABLE_CURRENTCHANNEL,
+				DIDMIB_DOT11PHY_DSSSTABLE_CURRENTCHANNEL,
 						chan);
 		if (result)
 			goto exit;
@@ -502,13 +503,13 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
 		 * seems reasonable anyways
 		 */
 		result = prism2_domibset_uint32(wlandev,
-						DIDMIB_DOT11SMT_PRIVACYTABLE_PRIVACYINVOKED,
+				DIDMIB_DOT11SMT_PRIVACYTABLE_PRIVACYINVOKED,
 						P80211ENUM_truth_true);
 		if (result)
 			goto exit;
 
 		result = prism2_domibset_uint32(wlandev,
-						DIDMIB_DOT11SMT_PRIVACYTABLE_EXCLUDEUNENCRYPTED,
+				DIDMIB_DOT11SMT_PRIVACYTABLE_EXCLUDEUNENCRYPTED,
 						P80211ENUM_truth_true);
 		if (result)
 			goto exit;
@@ -518,13 +519,13 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
 		 * and exclude unencrypted
 		 */
 		result = prism2_domibset_uint32(wlandev,
-						DIDMIB_DOT11SMT_PRIVACYTABLE_PRIVACYINVOKED,
+				DIDMIB_DOT11SMT_PRIVACYTABLE_PRIVACYINVOKED,
 						P80211ENUM_truth_false);
 		if (result)
 			goto exit;
 
 		result = prism2_domibset_uint32(wlandev,
-						DIDMIB_DOT11SMT_PRIVACYTABLE_EXCLUDEUNENCRYPTED,
+				DIDMIB_DOT11SMT_PRIVACYTABLE_EXCLUDEUNENCRYPTED,
 						P80211ENUM_truth_false);
 		if (result)
 			goto exit;
-- 
2.17.1

