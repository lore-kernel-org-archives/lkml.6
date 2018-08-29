Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C128CC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F7220659
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAspw04Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F7220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbeH3AfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:35:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51442 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbeH3Ae7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:34:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so6532100wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nlzgjWogMjlJlz6VifoTpxpSHdHsn6HDc9HJLZmK++Q=;
        b=NAspw04Ydc/F5wcmaFFkYbUfA6PeuCGGoTKW6DfnxybaS0rULIqGoBUAVK13EhwcG1
         X//2HeWdVEE2YnyMUEP/DkayjPbhObue0Tl0xyUUY7VmVa/T68abAHjfxrk6Co74ioUl
         6j+/PaIwh35HzqeRqtrBdErF81WhGS9htZpgtkJEGF25eBB9rx9oj8oA/QxxC0/6UjXv
         z9A0zjQlH1y4eliIxjw0GcbReUAKbGUWQxBaDoYkLSb3EzZEXosBTBuD9mIfc4B0+CR1
         MlpMh86Wt25XvbPmSoaTjjsfXAs6WBJIpduo91nX4EfnjZL5N/p315bMtLPQEcWt0vdD
         bb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nlzgjWogMjlJlz6VifoTpxpSHdHsn6HDc9HJLZmK++Q=;
        b=pzFy5up7lI8Va2CqeIeESV0BjapBOF23A6997eHJ39jLKXg4ELK+sQdcPRkQXjU6Dd
         lZg5BX+Fayr05d/qqGVQCEC2HH2/xnprlDtqFgfL6JHQRaWXvqFoA4lymyH2S7Pu4LLB
         aUsaUcSvwqhZf9bt4K9I2bK7gwHn8qSRKG6F2JQ8PIP0rkojHuDdSMwqotgZHppwNk42
         02umjX5qtECdJyNhpBR1fohA+GywmEjRQkN1f+tMISt4veNc8CkC4S0sGF6CxNxWu0ed
         SQxdrAo2Uy2tZS3m/AFhZ+I5yCd996S9muvdxApJew4eDqlOMx7wYqcRsDZ5GV6+tFZK
         abCQ==
X-Gm-Message-State: APzg51A7xGrz9hC+auiMuO6oqpDp5xl72U0/UcZvP0RP+mgL3YitKQt/
        jPvpEiU5irGAWA5HBsNFgyCTmWiXfNQ=
X-Google-Smtp-Source: ANB0VdZ2o/lyoqlHifnABIibmEVMz+on6xML/AO7U6aRkG9JsbiA0tOAcYQojk/usHg9VNTETkNJqg==
X-Received: by 2002:a1c:c95:: with SMTP id 143-v6mr5476371wmm.50.1535574984116;
        Wed, 29 Aug 2018 13:36:24 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:36:23 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 16/21] staging:rtl8192u: Rename MPDUDensity - Style
Date:   Wed, 29 Aug 2018 21:35:42 +0100
Message-Id: <20180829203547.15650-17-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the bitfield member 'MPDUDensity' to 'mpdu_density', this
clears the checkpatch issue with CamelCase naming.

This is a coding style change which should not have an impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h    |  2 +-
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 12db4ac9703b..9066f309bac9 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -56,7 +56,7 @@ struct ht_capability_ele {
 
 	//MAC HT parameters info
 	u8	max_rx_ampdu_factor:2;
-	u8	MPDUDensity:3;
+	u8	mpdu_density:3;
 	u8	Rsvd2:3;
 
 	//Supported MCS set
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 4fc919ebd10b..19c4903b572f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -99,9 +99,9 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 #endif
 	/*
 	 * 8190 only, Realtek proprietary aggregation mode
-	 * Set MPDUDensity=2,   1: Set MPDUDensity=2(32k)  for Realtek AP and set MPDUDensity=0(8k) for others
+	 * Set mpdu_density=2,   1: Set mpdu_density=2(32k)  for Realtek AP and set mpdu_density=0(8k) for others
 	 */
-	pHTInfo->bRegRT2RTAggregation = 1;//0: Set MPDUDensity=2,   1: Set MPDUDensity=2(32k)  for Realtek AP and set MPDUDensity=0(8k) for others
+	pHTInfo->bRegRT2RTAggregation = 1;//0: Set mpdu_density=2,   1: Set mpdu_density=2(32k)  for Realtek AP and set mpdu_density=0(8k) for others
 
 	// For Rx Reorder Control
 	pHTInfo->bRegRxReorderEnable = 1;
@@ -148,7 +148,7 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMSDU Size = %s\n", (pCapELE->max_amsdu_size) ? "3839" : "7935");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport CCK in 20/40 mode = %s\n", (pCapELE->dss_cck) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMPDU Factor = %d\n", pCapELE->max_rx_ampdu_factor);
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMPDU Density = %d\n", pCapELE->MPDUDensity);
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMPDU Density = %d\n", pCapELE->mpdu_density);
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMCS Rate Set = [%x][%x][%x][%x][%x]\n", pCapELE->MCS[0],\
 				pCapELE->MCS[1], pCapELE->MCS[2], pCapELE->MCS[3], pCapELE->MCS[4]);
 }
@@ -570,11 +570,11 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "TX HT cap/info ele BW=%d max_amsdu_size:%d dss_cck:%d\n", pCapELE->chl_width, pCapELE->max_amsdu_size, pCapELE->dss_cck);
 
 	if (IsEncrypt) {
-		pCapELE->MPDUDensity	= 7; // 8us
+		pCapELE->mpdu_density	= 7; // 8us
 		pCapELE->max_rx_ampdu_factor = 2; // 2 is for 32 K and 3 is 64K
 	} else {
 		pCapELE->max_rx_ampdu_factor = 3; // 2 is for 32 K and 3 is 64K
-		pCapELE->MPDUDensity	= 0; // no density
+		pCapELE->mpdu_density	= 0; // no density
 	}
 
 	//Supported MCS set
@@ -1005,10 +1005,10 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	 * <2> Set AMPDU Minimum MPDU Start Spacing
 	 * 802.11n 3.0 section 9.7d.3
 	 */
-	if (pHTInfo->MPDU_Density > pPeerHTCap->MPDUDensity)
+	if (pHTInfo->MPDU_Density > pPeerHTCap->mpdu_density)
 		pHTInfo->CurrentMPDUDensity = pHTInfo->MPDU_Density;
 	else
-		pHTInfo->CurrentMPDUDensity = pPeerHTCap->MPDUDensity;
+		pHTInfo->CurrentMPDUDensity = pPeerHTCap->mpdu_density;
 	if (ieee->pairwise_key_type != KEY_TYPE_NA)
 		pHTInfo->CurrentMPDUDensity	= 7; // 8us
 	// Force TX AMSDU
-- 
2.18.0

