Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889E0C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329792064D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWy/Q/2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329792064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeI0Bbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:31:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42860 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeI0Bbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:31:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id b20-v6so2876910edr.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PXa+SYILzf9C8a2JUQs9XvQInex8UcItY3Hf1+2HF3E=;
        b=oWy/Q/2YD1ghmX7O5cynktzZPM86ipQ68YDxmRegxCy6NV/sQ5yg1rTQXenuPCikUg
         b9w7hW1bD2XHfINiM8TjJQfG59xneFFNSpUsxz8Ti2PWeMf2EjKv5aA37D12w46GkzXx
         PxGkdMx6seINV14qIFxNpfjZlDrZjBaWFn8pN84Hw6xYpSoPGXgC0rNcaAk1yRV7GAZY
         pKvrB27BMMsHPigk0N6Y1KEby3Iov13LmcpscyT+Z7dE6NuicSWLXuQ4ZGk+P1o14J78
         cZxKsP/E1UKDOs7b1N+T9Crv6RlxSuYy6de3/hZgSP7Ygh7B+TUTOG89OUFfRRadsIyc
         T08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PXa+SYILzf9C8a2JUQs9XvQInex8UcItY3Hf1+2HF3E=;
        b=E+pOAhMV7a3+Tp6Vd70CKO6M3bKJY5tiV7ZLVlGGvxDAMeAPQOAP3+mqgfBDoiDHu3
         nWQ8+yxL4Emp2vbQQfSZqJi20VeqyyuWnV6ES0m5gFGUl9NWf0birPxam1nA/zX0hFz1
         /VrX8RIwVNFBcFKuB8FWgASYi4DQp7B50pNGzzDyRaGBcQgvbkrfnxTOigfNIr/VPMlF
         GMAvbh9EqrogFFIbK3TFWb/pFd/2FvWjOqlAdrt1i1ZSES5W/di5h8gaX1icEklKsUhB
         UcfdI7Y45aNmrYXH1B0nogovbb8k4N+5UGX3tPg+W5jsd3jYBmth0ftpikks2yBqZ2IZ
         l+Nw==
X-Gm-Message-State: ABuFfoiDpTvzjcp27NsEek7ykbmy7bvvpr3NbeQ4hLfc6dcKwPYxvjHO
        dzdpcXaBL1tPCUro/zH0e91sQcsL
X-Google-Smtp-Source: ACcGV60APlnJ31o+soUf0fYk6LGEbBmcPBG7AkvYGLXHMVVYFSQWgNSZlaVnG6XvDP1QrwV4NS259w==
X-Received: by 2002:a50:bdc5:: with SMTP id z5-v6mr12045901edh.46.1537989442986;
        Wed, 26 Sep 2018 12:17:22 -0700 (PDT)
Received: from localhost.localdomain ([109.78.196.57])
        by smtp.gmail.com with ESMTPSA id k13-v6sm91417eda.72.2018.09.26.12.17.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:17:22 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/13] staging:rtl8192u: Remove HTHalfMcsToDataRate() - Style
Date:   Wed, 26 Sep 2018 20:16:52 +0100
Message-Id: <20180926191704.16322-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180926191704.16322-1-johnfwhitmore@gmail.com>
References: <20180926191704.16322-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function HTHalfMcsToDataRate() is unused in code so has simply
been removed from the code.

As a result two static functions, (IsHTHalfNmode40Bandwidth and
IsHTHalfNmodeSGI), are not longer called, so they have been removed
as well.

These are coding style changes which should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/ieee80211.h    |  1 -
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       | 57 -------------------
 2 files changed, 58 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index b4e7ae60ac1c..cc694e567040 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -2382,7 +2382,6 @@ u8 HTCCheck(struct ieee80211_device *ieee, u8 *pFrame);
 //extern void HTSetConnectBwModeCallback(unsigned long data);
 void HTResetIOTSetting(PRT_HIGH_THROUGHPUT pHTInfo);
 bool IsHTHalfNmodeAPs(struct ieee80211_device *ieee);
-u16 HTHalfMcsToDataRate(struct ieee80211_device *ieee, u8 nMcsRate);
 u16 HTMcsToDataRate(struct ieee80211_device *ieee, u8 nMcsRate);
 u16 TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate);
 //function in BAPROC.c
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 9bf52cebe4cd..ea1261e33a68 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -216,63 +216,6 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 				pHTInfoEle->BasicMSC[1], pHTInfoEle->BasicMSC[2], pHTInfoEle->BasicMSC[3], pHTInfoEle->BasicMSC[4]);
 }
 
-/*
- *	Return:		true if station in half n mode and AP supports 40 bw
- */
-static bool IsHTHalfNmode40Bandwidth(struct ieee80211_device *ieee)
-{
-	bool			retValue = false;
-	PRT_HIGH_THROUGHPUT	 pHTInfo = ieee->pHTInfo;
-
-	if (!pHTInfo->bCurrentHTSupport)		// wireless is n mode
-		retValue = false;
-	else if (!pHTInfo->bRegBW40MHz)		// station supports 40 bw
-		retValue = false;
-	else if (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))	// station in half n mode
-		retValue = false;
-	else if (((struct ht_capability_ele *)(pHTInfo->PeerHTCapBuf))->ChlWidth) // ap support 40 bw
-		retValue = true;
-	else
-		retValue = false;
-
-	return retValue;
-}
-
-static bool IsHTHalfNmodeSGI(struct ieee80211_device *ieee, bool is40MHz)
-{
-	bool			retValue = false;
-	PRT_HIGH_THROUGHPUT	 pHTInfo = ieee->pHTInfo;
-
-	if (!pHTInfo->bCurrentHTSupport)		// wireless is n mode
-		retValue = false;
-	else if (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))	// station in half n mode
-		retValue = false;
-	else if (is40MHz) { // ap support 40 bw
-		if (((struct ht_capability_ele *)(pHTInfo->PeerHTCapBuf))->ShortGI40Mhz) // ap support 40 bw short GI
-			retValue = true;
-		else
-			retValue = false;
-	} else {
-		if (((struct ht_capability_ele *)(pHTInfo->PeerHTCapBuf))->ShortGI20Mhz) // ap support 40 bw short GI
-			retValue = true;
-		else
-			retValue = false;
-	}
-
-	return retValue;
-}
-
-u16 HTHalfMcsToDataRate(struct ieee80211_device *ieee,	u8	nMcsRate)
-{
-	u8	is40MHz;
-	u8	isShortGI;
-
-	is40MHz = (IsHTHalfNmode40Bandwidth(ieee)) ? 1 : 0;
-	isShortGI = (IsHTHalfNmodeSGI(ieee, is40MHz)) ? 1 : 0;
-
-	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate & 0x7f)];
-}
-
 u16 HTMcsToDataRate(struct ieee80211_device *ieee, u8 nMcsRate)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
-- 
2.18.0

