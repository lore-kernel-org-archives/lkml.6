Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AD8C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66A4205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCaomDZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66A4205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbeH3Aeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:34:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41969 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbeH3Aeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:34:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id z96-v6so6017853wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ugCEe+Cudgga/XtORGeuJxoIvkyegZim1qThAeXuwp4=;
        b=BCaomDZA8jtjtkoctqvGCMC7z6AhxeP+uyIiyHsLeYG7Nu+eT/9DyjiMfxZZ9fnyxp
         BctMicBQcV4Gi2FrWQcyfa4C78YF4KnRraEzavPk6iFzoB4jhZZAi0MGFkLpd3AaLd1q
         Oq7Ti0nPOdZnYJNd9gJEYsfJ/Gp7X3gDo28gkyN1Bcl86qSsJadc/WdDKn+9F6NKdtZM
         /L6vZO45QtaavIrL97QoFdaUIpmmOpIJ28i+Jfkh3cX3Qapc841nDMcS1WmZfoQlEvbV
         rHQCVErwVD8MtYvIYiABIx+7ZLNJVFNQxyOPjnoS8GkSsG4O0tOHs0ZHizSeR+6Tyo8d
         4n1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ugCEe+Cudgga/XtORGeuJxoIvkyegZim1qThAeXuwp4=;
        b=SqPVJbWPujBylwEKswy7QJ7veI0xsI12EdJNxRFRj3IP8f8v0hY8VR5sp23yYoLVD5
         VD5k9ZmV9Le3B9U9Wv86ONeyJ/bEYkY1fKrzc4m8vEXxpmLlwIlBpR33mGx4mX7cBBhK
         H18ZH91+vmd0rFE5FQxavZ75vkHU/i/nI2euHfhDIW88AAv9/igxm5irtZ+9GfNf1gNq
         6+zJQx4LhiKSqz8Woi9dwwHOJNndKMp1gmzGawDYmZ9oVVhNaGfuwSTfBG0dK+Bu9bvj
         UQ0ZtN1CU2nM51rlVYkag/A2hOE3h3bqvSBqXyFwrDtOyVf2Ys1Xh6m0sYqGUKDLa6by
         4gsQ==
X-Gm-Message-State: APzg51AXklKcqre44HKxUxa+QLZbn1oiPeMtJOupvE+CJ+0w2IGoeThS
        7MF5J3tvz7CsIzXQPipE2SMT1T9ARYo=
X-Google-Smtp-Source: ANB0VdZCx8wqI8fcinabmv0riChx3jxH1mvJgcQ30Vfw+FaO6FDALuGkEVzgimyEZsEZ4Er6TYgikw==
X-Received: by 2002:a5d:4512:: with SMTP id s18-v6mr5772987wrq.82.1535574960042;
        Wed, 29 Aug 2018 13:36:00 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:35:59 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/21] staging:rtl8192u: Rename ChlWidth - Style
Date:   Wed, 29 Aug 2018 21:35:28 +0100
Message-Id: <20180829203547.15650-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename 'ChlWidth', member variable of the structure ht_capability_ele.
This change is to clear the checkpatch issue with CamelCase naming.
The bitfield's name has been changed to 'chl_width'.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/ieee80211_wx.c    |  4 ++--
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h  |  2 +-
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c  | 16 ++++++++--------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
index fa59c712c74b..514445dc542e 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -154,8 +154,8 @@ static inline char *rtl819x_translate_scan(struct ieee80211_device *ieee,
 			ht_cap = (struct ht_capability_ele *)&network->bssht.bdHTCapBuf[4];
 		else
 			ht_cap = (struct ht_capability_ele *)&network->bssht.bdHTCapBuf[0];
-		is40M = (ht_cap->ChlWidth)?1:0;
-		isShortGI = (ht_cap->ChlWidth)?
+		is40M = (ht_cap->chl_width)?1:0;
+		isShortGI = (ht_cap->chl_width)?
 						((ht_cap->ShortGI40Mhz)?1:0):
 						((ht_cap->ShortGI20Mhz)?1:0);
 
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 66a0274077d3..d79126853cd3 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -40,7 +40,7 @@ enum ht_extension_chan_offset {
 struct ht_capability_ele {
 	//HT capability info
 	u8	not_used_adv_coding:1;
-	u8	ChlWidth:1;
+	u8	chl_width:1;
 	u8	MimoPwrSave:2;
 	u8	GreenField:1;
 	u8	ShortGI20Mhz:1;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index d7f73a5831da..d9c2a2df8d0e 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -142,7 +142,7 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 	}
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "<Log HT Capability>. Called by %s\n", TitleString);
 
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupported Channel Width = %s\n", (pCapELE->ChlWidth) ? "20MHz" : "20/40MHz");
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupported Channel Width = %s\n", (pCapELE->chl_width) ? "20MHz" : "20/40MHz");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 20M = %s\n", (pCapELE->ShortGI20Mhz) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 40M = %s\n", (pCapELE->ShortGI40Mhz) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport TX STBC = %s\n", (pCapELE->TxSTBC) ? "YES" : "NO");
@@ -230,7 +230,7 @@ static bool IsHTHalfNmode40Bandwidth(struct ieee80211_device *ieee)
 		retValue = false;
 	else if (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))	// station in half n mode
 		retValue = false;
-	else if (((struct ht_capability_ele *)(pHTInfo->PeerHTCapBuf))->ChlWidth) // ap support 40 bw
+	else if (((struct ht_capability_ele *)(pHTInfo->PeerHTCapBuf))->chl_width) // ap support 40 bw
 		retValue = true;
 	else
 		retValue = false;
@@ -551,17 +551,17 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 
 	//HT capability info
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
-		pCapELE->ChlWidth = 0;
+		pCapELE->chl_width = 0;
 	else
-		pCapELE->ChlWidth = (pHT->bRegBW40MHz ? 1 : 0);
+		pCapELE->chl_width = (pHT->bRegBW40MHz ? 1 : 0);
 
-//	pCapELE->ChlWidth		= (pHT->bRegBW40MHz?1:0);
+//	pCapELE->chl_width		= (pHT->bRegBW40MHz?1:0);
 	pCapELE->MimoPwrSave		= pHT->SelfMimoPs;
 	pCapELE->GreenField		= 0; // This feature is not supported now!!
 	pCapELE->ShortGI20Mhz		= 1; // We can receive Short GI!!
 	pCapELE->ShortGI40Mhz		= 1; // We can receive Short GI!!
 	//DbgPrint("TX HT cap/info ele BW=%d SG20=%d SG40=%d\n\r",
-	//pCapELE->ChlWidth, pCapELE->ShortGI20Mhz, pCapELE->ShortGI40Mhz);
+	//pCapELE->chl_width, pCapELE->ShortGI20Mhz, pCapELE->ShortGI40Mhz);
 	pCapELE->TxSTBC			= 1;
 	pCapELE->RxSTBC			= 0;
 	pCapELE->DelayBA		= 0;	// Do not support now!!
@@ -574,7 +574,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	 * MAC HT parameters info
 	 * TODO: Nedd to take care of this part
 	 */
-	IEEE80211_DEBUG(IEEE80211_DL_HT, "TX HT cap/info ele BW=%d MaxAMSDUSize:%d DssCCk:%d\n", pCapELE->ChlWidth, pCapELE->MaxAMSDUSize, pCapELE->DssCCk);
+	IEEE80211_DEBUG(IEEE80211_DL_HT, "TX HT cap/info ele BW=%d MaxAMSDUSize:%d DssCCk:%d\n", pCapELE->chl_width, pCapELE->MaxAMSDUSize, pCapELE->DssCCk);
 
 	if (IsEncrypt) {
 		pCapELE->MPDUDensity	= 7; // 8us
@@ -935,7 +935,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 //	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_HT, pPeerHTInfo, sizeof(HT_INFORMATION_ELE));
 	// Config Supported Channel Width setting
 	//
-	HTSetConnectBwMode(ieee, (enum ht_channel_width)(pPeerHTCap->ChlWidth), (enum ht_extension_chan_offset)(pPeerHTInfo->ExtChlOffset));
+	HTSetConnectBwMode(ieee, (enum ht_channel_width)(pPeerHTCap->chl_width), (enum ht_extension_chan_offset)(pPeerHTInfo->ExtChlOffset));
 
 	pHTInfo->bCurTxBW40MHz = (pPeerHTInfo->RecommemdedTxWidth == 1);
 
-- 
2.18.0

