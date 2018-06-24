Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFF0C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CBC251F0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjpqLaDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CBC251F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755546AbeFXQJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 12:09:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32899 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755190AbeFXPgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:36:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id z6-v6so10330422wma.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XHKTm/djS/DqO1pyh10Q7PF32ua1SZd4KG2RyOnDzf8=;
        b=mjpqLaDaUi/VZ1lDb6yNSQKcuBYw3y4wmQQgxEXTB/VlkyRiliUNDyRr2TZCLWUW0U
         w/d2rzi88OSoqQKje5jfT1iocxveV44JT6Hf3dGcJ1VA9GZimO+/rmoEb0bOESuZurqC
         IezJKyzOCOmUEP+mIpgKuWlUUlODK+tof7AUzWxyrRZ/k8PZ5Ijr6Uw8PON4sfaBdT4X
         bY1zfGa0Qio32r2s9b2SWMC1AUlYgKE1UO1JQIDlxrcaI7MqhqXRpETeC7YhlGTCEezD
         5rDBQDjEpbvv0abC2FoegIyuO5ewKFBaGnYNdcJih40vO/SpqNwsBahQM2t6uSlORW+2
         kbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XHKTm/djS/DqO1pyh10Q7PF32ua1SZd4KG2RyOnDzf8=;
        b=VoeuRnFEY5tnAW6Vx1y4U2GL8VR1+X4tBvig+zAyKDRVln25rQNHXMSH6Uh2DFJ528
         Ea9t0tDAd1Dq5lvh07yW0Viz59MijHsB0jcsqS5SM1VT2fcQsU3N+SiXa2YfTxCqkPFc
         /84gtjNsE4Vs6adBojW6aNiAbjhcHsgjD7lpUkwsNuwkDphKRpfhhLCH3k/2J/ycxRJs
         fRsBRgdgWjKX52l4w3ap6yrRHuaMZGJNWvT8GWuITG4nl3LVHvJ3PZ0aa5TP8Namil9K
         l7zIhB1TofhiBW+mW8ex0n7mepJ1fiKsdWyqISGFjsjR2fwQh3Te8XWCoYbMjs5Jallo
         fr2A==
X-Gm-Message-State: APt69E3hJ6A7y/6NfHk48Dp5HNbC7cxIK0mPhanMyxyg0QKfLyIY+XoP
        PSfbmMHyur4CGROskKGkEJUm82Pl
X-Google-Smtp-Source: ADUXVKLR435BaJxknBCFNdLt5A676PeYnDmhKAz1zq5Hor+V2enR9nPfuMhmE0ERaRoEzb86HDpWAw==
X-Received: by 2002:a1c:8ec1:: with SMTP id q184-v6mr7307767wmd.104.1529854565178;
        Sun, 24 Jun 2018 08:36:05 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id j10-v6sm1505813wro.53.2018.06.24.08.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 08:36:04 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v3 5/8] staging: rtl8192u: Use %s and __func__ instead of hardcoded string - Style
Date:   Sun, 24 Jun 2018 16:34:51 +0100
Message-Id: <20180624153454.27356-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180624153454.27356-1-johnfwhitmore@gmail.com>
References: <20180624153454.27356-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed a number of hard coded function names to use %s and __func__

Mailing list response suggest that there is a better method for debugging
using netdev_dbg(). I can't argue with that, but for the moment this change
will clear the checkpatch.pl Warning.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 0bd41ded87c9..6793a9aabb2f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -534,7 +534,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	//u8 bIsDeclareMCS13;
 
 	if (!posHTCap || !pHT) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTCap or pHTInfo can't be null in HTConstructCapabilityElement()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTCap or pHTInfo can't be null in %s\n", __func__);
 		return;
 	}
 	memset(posHTCap, 0, *len);
@@ -646,7 +646,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 	PHT_INFORMATION_ELE		pHTInfoEle = (PHT_INFORMATION_ELE)posHTInfo;
 
 	if (!posHTInfo || !pHTInfoEle) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTInfo or pHTInfoEle can't be null in HTConstructInfoElement()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTInfo or pHTInfoEle can't be null in %s\n", __func__);
 		return;
 	}
 
@@ -710,7 +710,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg, u8 *len)
 {
 	if (!posRT2RTAgg) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posRT2RTAgg can't be null in HTConstructRT2RTAggElement()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posRT2RTAgg can't be null in %s\n", __func__);
 		return;
 	}
 	memset(posRT2RTAgg, 0, *len);
@@ -758,7 +758,7 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 {
 	if (!pOperateMCS) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in HT_PickMCSRate()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in %s\n", __func__);
 		return false;
 	}
 
@@ -819,7 +819,7 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 	u8		availableMcsRate[16];
 
 	if (!pMCSRateSet || !pMCSFilter) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in HTGetHighestMCSRate()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in %s\n", __func__);
 		return false;
 	}
 	for (i = 0; i < 16; i++)
@@ -901,7 +901,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	static u8				EWC11NHTInfo[] = {0x00, 0x90, 0x4c, 0x34};	// For 11n EWC definition, 2007.07.17, by Emily
 
 	if (!pHTInfo->bCurrentHTSupport) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "<=== HTOnAssocRsp(): HT_DISABLE\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "<=== %s: HT_DISABLE\n", __func__);
 		return;
 	}
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "===> HTOnAssocRsp_wq(): HT_ENABLE\n");
-- 
2.17.1

