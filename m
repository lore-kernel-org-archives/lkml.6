Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01908C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C53D205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btd58V5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C53D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbeH3Aet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:34:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33372 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeH3Aes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:34:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id i134-v6so192008wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=//r8/vo4z4qkRD2RcJYwErFmZoeCJUSQYfVsF0JGnN8=;
        b=btd58V5iQMLm3ZhEb6wu+Vy3B2/b/TzmMUbCEFL7yk/iJJt9lNZUkGpsAAG16nXVl6
         +2LZR/jMPFdZRGONOYk/wvGbEuF1RtDBOtgDjOporfaSUb90uTbPTsLxrIM4bYIq5I3b
         EmDFTHQzEV9xwMRhFQmCvE7ikRW9JHww/g2wTUsDQ/ZU0BNVYIipLtGuuEPgf4xwU3uK
         8KIQ03U6ldRdUj53TDmHP/XIv4AbfhloIwDFx/H6CQPu8MIzDqSnXYNLyMh9BmYALkjc
         WWSHmxqj9Hu40TpA5V1NZUcWow+k9QKAENgxy+rIigTJVKVK1oocfDSiTWz7TBGm7d2x
         jAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=//r8/vo4z4qkRD2RcJYwErFmZoeCJUSQYfVsF0JGnN8=;
        b=UuiW9cCTIpRGRVl78ddESrlhAIQxxwPMAi8aE3dJdOj6dV8Jk+ExNC6UCmuCMeK0O1
         4Ql/4XQEx/8dwiovbk84AYk58J2WeTmLrYCWKYoLABhXb0yWcOsKNT7rJEkmIZuU+Fhw
         +bclC8j9WvcbkvjwHy+Ps73DMqX36Od1z/PbTrBAsrbJrkbMdtaPgVxnqAqcQnHDNJxD
         gLQF4UNkhRq1opn/vJqqCdBrkeJAZ76zc4AqmKV0G0+jZ2SvsbY4HZxWTF4P4XrZbxr7
         FlHvD/h5zzkCYebeGzT0IQnhoQV71XmVvb82Riqw2WmzWc2lNV7vi+d1Ud/957LeMxKA
         5Ffg==
X-Gm-Message-State: APzg51BFEJzDsha1aZncit44s/K+G5iptCapPRkqi5Raa3bED+w9nUV0
        hWhDeX3mghAWyMK3H/cI5kFa6Lk0IOc=
X-Google-Smtp-Source: ANB0VdaZlOkcn+SpstWgdEDZCyo6jLs6QS0bsfhiO3r44exRGEw4sj3oh5BZ8y47uLd7eAjDM6UKOA==
X-Received: by 2002:a1c:1dc9:: with SMTP id d192-v6mr5583590wmd.140.1535574972957;
        Wed, 29 Aug 2018 13:36:12 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:36:12 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/21] staging:rtl8192u: Rename MaxAMSDUSize - Style
Date:   Wed, 29 Aug 2018 21:35:36 +0100
Message-Id: <20180829203547.15650-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the bitfield member variable 'MaxAMSDUSize' to
'max_amsdu_size', this clears the checkpatch issue with CamelCase
naming.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 864bb9db2433..e4693832e1d6 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -48,7 +48,7 @@ struct ht_capability_ele {
 	u8	not_used_tx_stbc:1;
 	u8	not_used_rx_stbc:2;
 	u8	not_used_delay_ba:1;
-	u8	MaxAMSDUSize:1;
+	u8	max_amsdu_size:1;
 	u8	DssCCk:1;
 	u8	PSMP:1;
 	u8	Rsvd1:1;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index bc1d8e9221aa..7fb31638f60d 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -145,7 +145,7 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupported Channel Width = %s\n", (pCapELE->chl_width) ? "20MHz" : "20/40MHz");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 20M = %s\n", (pCapELE->short_gi20_mhz) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 40M = %s\n", (pCapELE->short_gi40_mhz) ? "YES" : "NO");
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMSDU Size = %s\n", (pCapELE->MaxAMSDUSize) ? "3839" : "7935");
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMSDU Size = %s\n", (pCapELE->max_amsdu_size) ? "3839" : "7935");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport CCK in 20/40 mode = %s\n", (pCapELE->DssCCk) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMPDU Factor = %d\n", pCapELE->MaxRxAMPDUFactor);
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMPDU Density = %d\n", pCapELE->MPDUDensity);
@@ -560,7 +560,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	pCapELE->short_gi40_mhz		= 1; // We can receive Short GI!!
 	//DbgPrint("TX HT cap/info ele BW=%d SG20=%d SG40=%d\n\r",
 	//pCapELE->chl_width, pCapELE->short_gi20_mhz, pCapELE->short_gi40_mhz);
-	pCapELE->MaxAMSDUSize	        = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
+	pCapELE->max_amsdu_size	        = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
 	pCapELE->DssCCk			= ((pHT->bRegBW40MHz) ? (pHT->bRegSuppCCK ? 1 : 0) : 0);
 	pCapELE->PSMP			= 0; // Do not support now!!
 	pCapELE->LSigTxopProtect	= 0; // Do not support now!!
@@ -569,7 +569,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	 * MAC HT parameters info
 	 * TODO: Nedd to take care of this part
 	 */
-	IEEE80211_DEBUG(IEEE80211_DL_HT, "TX HT cap/info ele BW=%d MaxAMSDUSize:%d DssCCk:%d\n", pCapELE->chl_width, pCapELE->MaxAMSDUSize, pCapELE->DssCCk);
+	IEEE80211_DEBUG(IEEE80211_DL_HT, "TX HT cap/info ele BW=%d max_amsdu_size:%d DssCCk:%d\n", pCapELE->chl_width, pCapELE->max_amsdu_size, pCapELE->DssCCk);
 
 	if (IsEncrypt) {
 		pCapELE->MPDUDensity	= 7; // 8us
@@ -963,7 +963,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	 */
 	pHTInfo->bCurrent_AMSDU_Support = pHTInfo->bAMSDU_Support;
 
-	nMaxAMSDUSize = (pPeerHTCap->MaxAMSDUSize == 0) ? 3839 : 7935;
+	nMaxAMSDUSize = (pPeerHTCap->max_amsdu_size == 0) ? 3839 : 7935;
 
 	if (pHTInfo->nAMSDU_MaxSize > nMaxAMSDUSize)
 		pHTInfo->nCurrent_AMSDU_MaxSize = nMaxAMSDUSize;
@@ -1169,7 +1169,6 @@ void HTInitializeBssDesc(PBSS_HT pBssHT)
 void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee80211_network *pNetwork)
 {
 	PRT_HIGH_THROUGHPUT		pHTInfo = ieee->pHTInfo;
-//	u16						nMaxAMSDUSize;
 //	struct ht_capability_ele       *pPeerHTCap = (struct ht_capability_ele *)pNetwork->bssht.bdHTCapBuf;
 //	PHT_INFORMATION_ELE		pPeerHTInfo = (PHT_INFORMATION_ELE)pNetwork->bssht.bdHTInfoBuf;
 //	u8*	pMcsFilter;
-- 
2.18.0

