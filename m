Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED22C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00B720647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExazwKd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00B720647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbeH3Aeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:34:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51133 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbeH3Aen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:34:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so6528658wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zMUpfWD3Db3Zwd7nMEfw3n+Fhekc01LEGSYW7oLUYTM=;
        b=ExazwKd4pDs/c4UNQh5EV4OgeFDidSQNyeYFVDssgFk5SFHDsLmI8QRCqeziLsZHNw
         WeHNWUL09SjUQM+mtEG60K2aGBfq5fvCxXdsgkGDLog8Oj3z9LgrY4KroD0fNMjzOF1X
         +tNyaNNFemP2B8b71l4yNAu60u4Prk6UMsmCNvVUxTjsiqgrswXzso8tlns9Xbjmg1B0
         6KoEqj6X4BadH6e7Vl4zMTpAvbFH7x98yiLPr5w5JJBod9gvg93G+ZzDjZ+vZbWJc/ct
         7iNx/I2mizPy/J7cczCPlgWxhqtF8hiaDmTJRmfORaQjhTY3UyjBrVIbuX39GlRAj4Cg
         4OJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zMUpfWD3Db3Zwd7nMEfw3n+Fhekc01LEGSYW7oLUYTM=;
        b=HxQg3u4h13wge6sR/6vix3F4oSTD7eEVFe2tAGtyvM7yvxkPtiBzzutLIeI9toImYI
         Tdf+R8bqtumUqjDoLcMSitqmHQqUPKQWNbTrRTLGkPo9q5cA31EFTOPbpC7YPr4dCGB1
         kSZS1ADaZZSUZ2J3VEwCYhlsAGZR7CGP7TomQsRTOn7592gA9eZXGBRzBZ2DRZBQzMLr
         d5mUAhT3hlEt0whAJDIlhzFcTkBdA/zZX9nEQrVnurzX0D07rCq9WV25yvTRCvJb3bAh
         YRa5HHKvJ8k2OK2t61vAF+CdkMBRXLA1kn8fv9qX/yfnZccAKK4VgQr9REBgNOhzYnh6
         6vzg==
X-Gm-Message-State: APzg51DFDLxnmMIdbenjXeX/Sq3j9uPCH/Mwdet8XpV5fEJnh1aLS3SU
        QlcirwbwP69yfXVZWSugJuv8KQYGLd0=
X-Google-Smtp-Source: ANB0VdbLzv9yZl7avemUn25ZPpRSDbahDKJx14T9eI/A1XTh5z7EufOLFHfY0ixAZOI+olqCr94lJg==
X-Received: by 2002:a1c:2283:: with SMTP id i125-v6mr5380196wmi.28.1535574966281;
        Wed, 29 Aug 2018 13:36:06 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:36:05 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/21] staging:rtl8192u: Rename ShortGI40Mhz - Style
Date:   Wed, 29 Aug 2018 21:35:32 +0100
Message-Id: <20180829203547.15650-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the bitfield member 'ShortGI40Mhz' to 'short_gi40_mhz', this
clears the checkpatch issue with CamelCase naming.

This change is a simple coding style change, which should have no
impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c   |  2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     |  2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
index a0e91763e7f3..a6fe975902bb 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -156,7 +156,7 @@ static inline char *rtl819x_translate_scan(struct ieee80211_device *ieee,
 			ht_cap = (struct ht_capability_ele *)&network->bssht.bdHTCapBuf[0];
 		is40M = (ht_cap->chl_width)?1:0;
 		isShortGI = (ht_cap->chl_width)?
-						((ht_cap->ShortGI40Mhz)?1:0):
+						((ht_cap->short_gi40_mhz)?1:0):
 						((ht_cap->short_gi20_mhz)?1:0);
 
 		max_mcs = HTGetHighestMCSRate(ieee, ht_cap->MCS, MCS_FILTER_ALL);
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 64fd6a4f3bcd..23f8ee39e32d 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -44,7 +44,7 @@ struct ht_capability_ele {
 	u8	mimo_power_save:2;
 	u8	not_used_green_field:1;
 	u8	short_gi20_mhz:1;
-	u8	ShortGI40Mhz:1;
+	u8	short_gi40_mhz:1;
 	u8	TxSTBC:1;
 	u8	RxSTBC:2;
 	u8	DelayBA:1;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index fe8d75d8bd96..54c56cec612f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -144,7 +144,7 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupported Channel Width = %s\n", (pCapELE->chl_width) ? "20MHz" : "20/40MHz");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 20M = %s\n", (pCapELE->short_gi20_mhz) ? "YES" : "NO");
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 40M = %s\n", (pCapELE->ShortGI40Mhz) ? "YES" : "NO");
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 40M = %s\n", (pCapELE->short_gi40_mhz) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport TX STBC = %s\n", (pCapELE->TxSTBC) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMSDU Size = %s\n", (pCapELE->MaxAMSDUSize) ? "3839" : "7935");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport CCK in 20/40 mode = %s\n", (pCapELE->DssCCk) ? "YES" : "NO");
@@ -248,7 +248,7 @@ static bool IsHTHalfNmodeSGI(struct ieee80211_device *ieee, bool is40MHz)
 	else if (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))	// station in half n mode
 		retValue = false;
 	else if (is40MHz) { // ap support 40 bw
-		if (((struct ht_capability_ele *)(pHTInfo->PeerHTCapBuf))->ShortGI40Mhz) // ap support 40 bw short GI
+		if (((struct ht_capability_ele *)(pHTInfo->PeerHTCapBuf))->short_gi40_mhz) // ap support 40 bw short GI
 			retValue = true;
 		else
 			retValue = false;
@@ -558,9 +558,9 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 //	pCapELE->chl_width		= (pHT->bRegBW40MHz?1:0);
 	pCapELE->mimo_power_save        = pHT->SelfMimoPs;
 	pCapELE->short_gi20_mhz		= 1; // We can receive Short GI!!
-	pCapELE->ShortGI40Mhz		= 1; // We can receive Short GI!!
+	pCapELE->short_gi40_mhz		= 1; // We can receive Short GI!!
 	//DbgPrint("TX HT cap/info ele BW=%d SG20=%d SG40=%d\n\r",
-	//pCapELE->chl_width, pCapELE->short_gi20_mhz, pCapELE->ShortGI40Mhz);
+	//pCapELE->chl_width, pCapELE->short_gi20_mhz, pCapELE->short_gi40_mhz);
 	pCapELE->TxSTBC			= 1;
 	pCapELE->RxSTBC			= 0;
 	pCapELE->DelayBA		= 0;	// Do not support now!!
@@ -946,7 +946,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	pHTInfo->bCurShortGI20MHz = pHTInfo->bRegShortGI20MHz &&
 				    (pPeerHTCap->short_gi20_mhz == 1);
 	pHTInfo->bCurShortGI40MHz = pHTInfo->bRegShortGI40MHz &&
-				   (pPeerHTCap->ShortGI40Mhz == 1);
+				   (pPeerHTCap->short_gi40_mhz == 1);
 
 	/*
 	 * Config TX STBC setting
-- 
2.18.0

