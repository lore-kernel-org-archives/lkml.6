Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7978CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DD620675
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGA4oSnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbeL1MVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:21:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35276 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeL1MVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:21:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so10450734pfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 04:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Ux+D4MH1DW1ueKPe4DurKxc5bwGArSn6NsttyagiSKI=;
        b=pGA4oSndPGAAj3BZ5dZQ725lq1Uz4PZukm0ky0af7dkgpcAFQseDRG0DNw3BwljIO7
         iOVZMYByFeX/KdqCzSGdboNz1+ELphCTUTxYYjM6zhmOrjlaIFHj4MKRMMdzTeg7CQpW
         PvP8REF4wIH5/KjdgXvYRYh2/mnNzGAU8VOOQ2BFqh55Z/Q2i4XvhHska4JqQyVU8ZSL
         CfpeURmN5gFxVrjVpa3Nf2BMjQguB5MBh82HimC1fKngL34icwGvdEAO7navyAXzs+y8
         BKSbfU/ylNyB2/L+je+nWH4gKOHDLjgSqr9GyOwMqiTvKUEW8Dfluyv1XZuHGUtPTwGG
         /jPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ux+D4MH1DW1ueKPe4DurKxc5bwGArSn6NsttyagiSKI=;
        b=NzWww8hUrFzTJzmshLEkrx4GtBUwwu8U0mC9EpEcT0Hhq2l08cEAL+XPz3hu6S6YQE
         lFuwBJeYmKw5qcGps+5cDarrdYZxRhnbQ+ktRWRwHfcrpJO//7rVuuexF3gRZ1XIJsUh
         Es5ofFARXH5qejlH/YNpWFk5XsBz/N5nH7ykeDhAIeLDi94AAnMY7UBHzjzarvSymjYT
         aWqMtfBqAQZdGqqazvIy49iiRW4N1RB6FIMkZmgodPuzVltPb4z2R2uInT0SR8SAoAev
         DmFmiQBAuMax/iVaDwcoszIjI0rT/MYNSwRF5UMmW1nNsI9xx22RnA1hYGIKoiLA6Tbg
         mCrQ==
X-Gm-Message-State: AJcUukcQT8Utt02zLEled0ZKE9+dFzAVClKkDqyAq5VXa/upop3YaAbi
        m4rFedwEnku8zjCegTPE3/c=
X-Google-Smtp-Source: ALg8bN7a5RJNRezQT2h63efL7NurwhXiq/ENVDYIJfY8egdTuvp9WyVHTxuGoSU1chn+CNJmbwuh8g==
X-Received: by 2002:a65:65c9:: with SMTP id y9mr26839617pgv.438.1545999665476;
        Fri, 28 Dec 2018 04:21:05 -0800 (PST)
Received: from localhost.localdomain ([117.237.213.200])
        by smtp.gmail.com with ESMTPSA id v5sm70588785pgn.5.2018.12.28.04.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 04:21:04 -0800 (PST)
Date:   Fri, 28 Dec 2018 17:51:09 +0530
From:   Sushil Verma <sushil.bit.cse@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: fix camelcase style warning
Message-ID: <20181228122104.GA25322@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove CamelCase words. Warning found using checkpatch.pl

Signed-off-by: Sushil Verma <sushil.bit.cse@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c | 84 +++++++++++++++----------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index a1c096124683..bf151d81767f 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -15,11 +15,11 @@
 #include "dot11d.h"
 
 struct channel_list {
-	u8      Channel[32];
-	u8      Len;
+	u8      channel[32];
+	u8      len;
 };
 
-static struct channel_list ChannelPlan[] = {
+static struct channel_list channelPlan[] = {
 	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 36, 40, 44, 48, 52, 56, 60, 64,
 	  149, 153, 157, 161, 165}, 24},
 	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}, 11},
@@ -48,29 +48,29 @@ void dot11d_init(struct rtllib_device *ieee)
 
 	pDot11dInfo->bEnabled = false;
 
-	pDot11dInfo->State = DOT11D_STATE_NONE;
-	pDot11dInfo->CountryIeLen = 0;
+	pDot11dInfo->state = DOT11D_STATE_NONE;
+	pDot11dInfo->countryIelen = 0;
 	memset(pDot11dInfo->channel_map, 0, MAX_CHANNEL_NUMBER + 1);
-	memset(pDot11dInfo->MaxTxPwrDbmList, 0xFF, MAX_CHANNEL_NUMBER + 1);
+	memset(pDot11dInfo->maxTxPwrDbmList, 0xFF, MAX_CHANNEL_NUMBER + 1);
 	RESET_CIE_WATCHDOG(ieee);
 }
 EXPORT_SYMBOL(dot11d_init);
 
-void Dot11d_Channelmap(u8 channel_plan, struct rtllib_device *ieee)
+void dot11d_channelmap(u8 channel_plan, struct rtllib_device *ieee)
 {
 	int i, max_chan = 14, min_chan = 1;
 
 	ieee->bGlobalDomain = false;
 
-	if (ChannelPlan[channel_plan].Len != 0) {
+	if (channelPlan[channel_plan].len != 0) {
 		memset(GET_DOT11D_INFO(ieee)->channel_map, 0,
 		       sizeof(GET_DOT11D_INFO(ieee)->channel_map));
-		for (i = 0; i < ChannelPlan[channel_plan].Len; i++) {
-			if (ChannelPlan[channel_plan].Channel[i] < min_chan ||
-			    ChannelPlan[channel_plan].Channel[i] > max_chan)
+		for (i = 0; i < channelPlan[channel_plan].len; i++) {
+			if (channelPlan[channel_plan].channel[i] < min_chan ||
+			    channelPlan[channel_plan].channel[i] > max_chan)
 				break;
-			GET_DOT11D_INFO(ieee)->channel_map[ChannelPlan
-					[channel_plan].Channel[i]] = 1;
+			GET_DOT11D_INFO(ieee)->channel_map[channelPlan
+					[channel_plan].channel[i]] = 1;
 		}
 	}
 
@@ -79,73 +79,73 @@ void Dot11d_Channelmap(u8 channel_plan, struct rtllib_device *ieee)
 		ieee->bGlobalDomain = true;
 		for (i = 12; i <= 14; i++)
 			GET_DOT11D_INFO(ieee)->channel_map[i] = 2;
-		ieee->IbssStartChnl = 10;
+		ieee->ibssStartChnl = 10;
 		ieee->ibss_maxjoin_chal = 11;
 		break;
 
 	case COUNTRY_CODE_WORLD_WIDE_13:
 		for (i = 12; i <= 13; i++)
 			GET_DOT11D_INFO(ieee)->channel_map[i] = 2;
-		ieee->IbssStartChnl = 10;
+		ieee->ibssStartChnl = 10;
 		ieee->ibss_maxjoin_chal = 11;
 		break;
 
 	default:
-		ieee->IbssStartChnl = 1;
+		ieee->ibssStartChnl = 1;
 		ieee->ibss_maxjoin_chal = 14;
 		break;
 	}
 }
-EXPORT_SYMBOL(Dot11d_Channelmap);
+EXPORT_SYMBOL(dot11d_channelmap);
 
-void Dot11d_Reset(struct rtllib_device *ieee)
+void dot11d_Reset(struct rtllib_device *ieee)
 {
 	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(ieee);
 	u32 i;
 
 	memset(pDot11dInfo->channel_map, 0, MAX_CHANNEL_NUMBER + 1);
-	memset(pDot11dInfo->MaxTxPwrDbmList, 0xFF, MAX_CHANNEL_NUMBER + 1);
+	memset(pDot11dInfo->maxTxPwrDbmList, 0xFF, MAX_CHANNEL_NUMBER + 1);
 	for (i = 1; i <= 11; i++)
 		(pDot11dInfo->channel_map)[i] = 1;
 	for (i = 12; i <= 14; i++)
 		(pDot11dInfo->channel_map)[i] = 2;
-	pDot11dInfo->State = DOT11D_STATE_NONE;
-	pDot11dInfo->CountryIeLen = 0;
+	pDot11dInfo->state = DOT11D_STATE_NONE;
+	pDot11dInfo->countryIelen = 0;
 	RESET_CIE_WATCHDOG(ieee);
 }
 
-void Dot11d_UpdateCountryIe(struct rtllib_device *dev, u8 *pTaddr,
-			    u16 CoutryIeLen, u8 *pCoutryIe)
+void dot11d_UpdateCountryIe(struct rtllib_device *dev, u8 *pTaddr,
+			    u16 coutryIeLen, u8 *pCoutryIe)
 {
 	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(dev);
-	u8 i, j, NumTriples, MaxChnlNum;
+	u8 i, j, numTriples, maxChnlNum;
 	struct chnl_txpow_triple *pTriple;
 
 	memset(pDot11dInfo->channel_map, 0, MAX_CHANNEL_NUMBER + 1);
-	memset(pDot11dInfo->MaxTxPwrDbmList, 0xFF, MAX_CHANNEL_NUMBER + 1);
-	MaxChnlNum = 0;
-	NumTriples = (CoutryIeLen - 3) / 3;
+	memset(pDot11dInfo->maxTxPwrDbmList, 0xFF, MAX_CHANNEL_NUMBER + 1);
+	maxChnlNum = 0;
+	numTriples = (coutryIeLen - 3) / 3;
 	pTriple = (struct chnl_txpow_triple *)(pCoutryIe + 3);
-	for (i = 0; i < NumTriples; i++) {
-		if (MaxChnlNum >= pTriple->FirstChnl) {
+	for (i = 0; i < numTriples; i++) {
+		if (maxChnlNum >= pTriple->firstChnl) {
 			netdev_info(dev->dev,
 				    "%s: Invalid country IE, skip it......1\n",
 				    __func__);
 			return;
 		}
-		if (MAX_CHANNEL_NUMBER < (pTriple->FirstChnl +
-		    pTriple->NumChnls)) {
+		if (MAX_CHANNEL_NUMBER < (pTriple->firstChnl +
+		    pTriple->numChnls)) {
 			netdev_info(dev->dev,
 				    "%s: Invalid country IE, skip it......2\n",
 				    __func__);
 			return;
 		}
 
-		for (j = 0; j < pTriple->NumChnls; j++) {
-			pDot11dInfo->channel_map[pTriple->FirstChnl + j] = 1;
-			pDot11dInfo->MaxTxPwrDbmList[pTriple->FirstChnl + j] =
-						 pTriple->MaxTxPowerInDbm;
-			MaxChnlNum = pTriple->FirstChnl + j;
+		for (j = 0; j < pTriple->numChnls; j++) {
+			pDot11dInfo->channel_map[pTriple->firstChnl + j] = 1;
+			pDot11dInfo->maxTxPwrDbmList[pTriple->firstChnl + j] =
+						 pTriple->maxTxPowerInDbm;
+			maxChnlNum = pTriple->firstChnl + j;
 		}
 
 		pTriple = (struct chnl_txpow_triple *)((u8 *)pTriple + 3);
@@ -153,21 +153,21 @@ void Dot11d_UpdateCountryIe(struct rtllib_device *dev, u8 *pTaddr,
 
 	UPDATE_CIE_SRC(dev, pTaddr);
 
-	pDot11dInfo->CountryIeLen = CoutryIeLen;
-	memcpy(pDot11dInfo->CountryIeBuf, pCoutryIe, CoutryIeLen);
-	pDot11dInfo->State = DOT11D_STATE_LEARNED;
+	pDot11dInfo->countryIelen = coutryIeLen;
+	memcpy(pDot11dInfo->countryIeBuf, pCoutryIe, coutryIeLen);
+	pDot11dInfo->state = DOT11D_STATE_LEARNED;
 }
 
 void DOT11D_ScanComplete(struct rtllib_device *dev)
 {
 	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(dev);
 
-	switch (pDot11dInfo->State) {
+	switch (pDot11dInfo->state) {
 	case DOT11D_STATE_LEARNED:
-		pDot11dInfo->State = DOT11D_STATE_DONE;
+		pDot11dInfo->state = DOT11D_STATE_DONE;
 		break;
 	case DOT11D_STATE_DONE:
-		Dot11d_Reset(dev);
+		dot11d_Reset(dev);
 		break;
 	case DOT11D_STATE_NONE:
 		break;
-- 
2.19.1

