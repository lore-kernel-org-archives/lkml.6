Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538F1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0630E2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlFz/19k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0630E2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbeK2Ebp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:31:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41396 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbeK2Ebn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:31:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so27146775wrs.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8iP9HCHN0kl1JXo/GPO5AseYfkt4YRv1/VbVAWPSTWM=;
        b=SlFz/19ktK+a2fL9w3w63O6MDX2NiVHou8CcegjFznIvmHfZpGzBLiKZ1jFZJDyofk
         jfWbLkG2Z4CqxXD+zpPUYdNOvTq2hIygqrFtVuFb57eURH2ZTy2XKt2470UWrRpMllY1
         u+58KuESv9TZmUtMJGgKLCNZNy0VW2EAlD7ssOh7LeQa/P64bY1aH3kzG+XT2fgJHDBR
         XL7g7ob9MRaSxGVW69TTHUslnDdOq5IZY3e3T6iZkwBczc77B78iQpVCmChlSOCnMqXT
         qILWK10/JJJvV6/65cfQZSGtOSKpAO8ZnE7enwg9TV16c5Bixv3G71wLL1a9QAyicQBc
         UPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8iP9HCHN0kl1JXo/GPO5AseYfkt4YRv1/VbVAWPSTWM=;
        b=TAvzctUw7dbihJ0n5HRd1ph6HvraCE8iIADFYZ7wFYQOsc7C0HONuzS1Zz0Li+UQzN
         XPCu6DrATH44PTWt+qrvDbaeY9+HcMsQo37aOvN5340GglElKW+EGEymSlVqSf5CILjk
         vakAZIAqbtHP6fOVIk7QblaD6ngrGj7S0zKqRZyVHyNNgbnyEbxpFh1dpK8+DFvS5Brf
         qiyCiBoip/bZHibsQe+caKTuaWZFmX8+tRtMk+ZC8Az+8UD8WPWQywu6FQWvUNmpkR2L
         vIdhdIasAMm8QO0tqyG5pXAt/J23f4AxZmvIgx1lx9ios0vvhTngO0hZvY6Kx3dbdZvL
         ywLg==
X-Gm-Message-State: AA+aEWZ3XY+vYK5V0dxLZk9+QXVDwltyQh5hgby1Jw7ZnS1F6K1FgxHg
        W4QspcCrVjfwC9wqlVuBsKE=
X-Google-Smtp-Source: AFSGD/Wevop/MLhsQB4bNa0Lm5l5nFlP026P3N45WePCgiwB+4y747NDO0fgg6Dk0f7UE71KMFFW0w==
X-Received: by 2002:adf:fcc1:: with SMTP id f1mr30792423wrs.296.1543426158662;
        Wed, 28 Nov 2018 09:29:18 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id m126sm4199467wmb.30.2018.11.28.09.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 09:29:18 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/6] staging: rtl8188eu: add spaces around operators in hal8188e_rate_adaptive.c
Date:   Wed, 28 Nov 2018 18:29:03 +0100
Message-Id: <20181128172906.1694-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181128172906.1694-1-straube.linux@gmail.com>
References: <20181128172906.1694-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around operators to follow kernel coding style.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../rtl8188eu/hal/hal8188e_rate_adaptive.c    | 54 ++++++++++---------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c b/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
index 79e13d076553..ccd7bb24302b 100644
--- a/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
+++ b/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
@@ -18,7 +18,7 @@ Major Change History:
 
 /*  Rate adaptive parameters */
 
-static u8 RETRY_PENALTY[PERENTRY][RETRYSIZE+1] = {
+static u8 RETRY_PENALTY[PERENTRY][RETRYSIZE + 1] = {
 		{5, 4, 3, 2, 0, 3},      /* 92 , idx = 0 */
 		{6, 5, 4, 3, 0, 4},      /* 86 , idx = 1 */
 		{6, 5, 4, 2, 0, 4},      /* 81 , idx = 2 */
@@ -44,7 +44,7 @@ static u8 RETRY_PENALTY[PERENTRY][RETRYSIZE+1] = {
 		{49, 16, 16, 0, 0, 48}
 	}; /* 3, idx = 0x16 */
 
-static u8 PT_PENALTY[RETRYSIZE+1] = {34, 31, 30, 24, 0, 32};
+static u8 PT_PENALTY[RETRYSIZE + 1] = {34, 31, 30, 24, 0, 32};
 
 /*  wilson modify */
 static u8 RETRY_PENALTY_IDX[2][RATESIZE] = {
@@ -146,7 +146,7 @@ static int odm_RateDown_8188E(struct odm_dm_struct *dm_odm,
 		pRaInfo->RateSGI = 0;
 	} else if (RateID > LowestRate) {
 		if (RateID > 0) {
-			for (i = RateID-1; i > LowestRate; i--) {
+			for (i = RateID - 1; i > LowestRate; i--) {
 				if (pRaInfo->RAUseRate & BIT(i)) {
 					RateID = i;
 					goto RateDownFinish;
@@ -216,7 +216,7 @@ static int odm_RateUp_8188E(
 			("%s():Decrease RPT Timing\n", __func__));
 
 	if (RateID < HighestRate) {
-		for (i = RateID+1; i <= HighestRate; i++) {
+		for (i = RateID + 1; i <= HighestRate; i++) {
 			if (pRaInfo->RAUseRate & BIT(i)) {
 				RateID = i;
 				goto RateUpfinish;
@@ -232,7 +232,7 @@ static int odm_RateUp_8188E(
 	}
 RateUpfinish:
 	if (pRaInfo->RAWaitingCounter ==
-		(4+PendingForRateUpFail[pRaInfo->RAPendingCounter]))
+		(4 + PendingForRateUpFail[pRaInfo->RAPendingCounter]))
 		pRaInfo->RAWaitingCounter = 0;
 	else
 		pRaInfo->RAWaitingCounter++;
@@ -253,8 +253,10 @@ static void odm_ResetRaCounter_8188E(struct odm_ra_info *pRaInfo)
 	u8 RateID;
 
 	RateID = pRaInfo->DecisionRate;
-	pRaInfo->NscUp = (N_THRESHOLD_HIGH[RateID]+N_THRESHOLD_LOW[RateID])>>1;
-	pRaInfo->NscDown = (N_THRESHOLD_HIGH[RateID]+N_THRESHOLD_LOW[RateID])>>1;
+	pRaInfo->NscUp = (N_THRESHOLD_HIGH[RateID] +
+			  N_THRESHOLD_LOW[RateID]) >> 1;
+	pRaInfo->NscDown = (N_THRESHOLD_HIGH[RateID] +
+			    N_THRESHOLD_LOW[RateID]) >> 1;
 }
 
 static void odm_RateDecision_8188E(struct odm_dm_struct *dm_odm,
@@ -317,7 +319,7 @@ static void odm_RateDecision_8188E(struct odm_dm_struct *dm_odm,
 		else
 			pRaInfo->NscUp = 0;
 
-		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE|ODM_COMP_INIT, ODM_DBG_LOUD,
+		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE | ODM_COMP_INIT, ODM_DBG_LOUD,
 			     (" RssiStaRa = %d RtyPtID =%d PenaltyID1 = 0x%x  PenaltyID2 = 0x%x RateID =%d NscDown =%d NscUp =%d SGI =%d\n",
 			     pRaInfo->RssiStaRA, RtyPtID, PenaltyID1, PenaltyID2, RateID, pRaInfo->NscDown, pRaInfo->NscUp, pRaInfo->RateSGI));
 		if ((pRaInfo->NscDown < N_THRESHOLD_LOW[RateID]) ||
@@ -357,41 +359,41 @@ static int odm_ARFBRefresh_8188E(struct odm_dm_struct *dm_odm, struct odm_ra_inf
 
 	switch (pRaInfo->RateID) {
 	case RATR_INX_WIRELESS_NGB:
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x0f8ff015;
+		pRaInfo->RAUseRate = pRaInfo->RateMask & 0x0f8ff015;
 		break;
 	case RATR_INX_WIRELESS_NG:
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x0f8ff010;
+		pRaInfo->RAUseRate = pRaInfo->RateMask & 0x0f8ff010;
 		break;
 	case RATR_INX_WIRELESS_NB:
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x0f8ff005;
+		pRaInfo->RAUseRate = pRaInfo->RateMask & 0x0f8ff005;
 		break;
 	case RATR_INX_WIRELESS_N:
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x0f8ff000;
+		pRaInfo->RAUseRate = pRaInfo->RateMask & 0x0f8ff000;
 		break;
 	case RATR_INX_WIRELESS_GB:
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x00000ff5;
+		pRaInfo->RAUseRate = pRaInfo->RateMask & 0x00000ff5;
 		break;
 	case RATR_INX_WIRELESS_G:
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x00000ff0;
+		pRaInfo->RAUseRate = pRaInfo->RateMask & 0x00000ff0;
 		break;
 	case RATR_INX_WIRELESS_B:
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x0000000d;
+		pRaInfo->RAUseRate = pRaInfo->RateMask & 0x0000000d;
 		break;
 	case 12:
 		MaskFromReg = usb_read32(adapt, REG_ARFR0);
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&MaskFromReg;
+		pRaInfo->RAUseRate = pRaInfo->RateMask & MaskFromReg;
 		break;
 	case 13:
 		MaskFromReg = usb_read32(adapt, REG_ARFR1);
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&MaskFromReg;
+		pRaInfo->RAUseRate = pRaInfo->RateMask & MaskFromReg;
 		break;
 	case 14:
 		MaskFromReg = usb_read32(adapt, REG_ARFR2);
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&MaskFromReg;
+		pRaInfo->RAUseRate = pRaInfo->RateMask & MaskFromReg;
 		break;
 	case 15:
 		MaskFromReg = usb_read32(adapt, REG_ARFR3);
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&MaskFromReg;
+		pRaInfo->RAUseRate = pRaInfo->RateMask & MaskFromReg;
 		break;
 	default:
 		pRaInfo->RAUseRate = (pRaInfo->RateMask);
@@ -400,7 +402,7 @@ static int odm_ARFBRefresh_8188E(struct odm_dm_struct *dm_odm, struct odm_ra_inf
 	/*  Highest rate */
 	if (pRaInfo->RAUseRate) {
 		for (i = RATESIZE; i >= 0; i--) {
-			if ((pRaInfo->RAUseRate)&BIT(i)) {
+			if (pRaInfo->RAUseRate & BIT(i)) {
 				pRaInfo->HighestRate = i;
 				break;
 			}
@@ -512,15 +514,17 @@ static void odm_PTDecision_8188E(struct odm_ra_info *pRaInfo)
 	j >>= 1;
 	temp_stage = (pRaInfo->PTStage + 1) >> 1;
 	if (temp_stage > j)
-		stage_id = temp_stage-j;
+		stage_id = temp_stage - j;
 	else
 		stage_id = 0;
 
-	pRaInfo->PTSmoothFactor = (pRaInfo->PTSmoothFactor>>1) + (pRaInfo->PTSmoothFactor>>2) + stage_id*16+2;
+	pRaInfo->PTSmoothFactor = (pRaInfo->PTSmoothFactor >> 1) +
+				  (pRaInfo->PTSmoothFactor >> 2) +
+				  stage_id * 16 + 2;
 	if (pRaInfo->PTSmoothFactor > 192)
 		pRaInfo->PTSmoothFactor = 192;
 	stage_id = pRaInfo->PTSmoothFactor >> 6;
-	temp_stage = stage_id*2;
+	temp_stage = stage_id * 2;
 	if (temp_stage != 0)
 		temp_stage -= 1;
 	if (pRaInfo->DROP > 3)
@@ -579,8 +583,8 @@ int ODM_RAInfo_Init(struct odm_dm_struct *dm_odm, u8 macid)
 	pRaInfo->PreRssiStaRA = 0;
 	pRaInfo->SGIEnable = 0;
 	pRaInfo->RAUseRate = 0xffffffff;
-	pRaInfo->NscDown = (N_THRESHOLD_HIGH[0x13]+N_THRESHOLD_LOW[0x13])/2;
-	pRaInfo->NscUp = (N_THRESHOLD_HIGH[0x13]+N_THRESHOLD_LOW[0x13])/2;
+	pRaInfo->NscDown = (N_THRESHOLD_HIGH[0x13] + N_THRESHOLD_LOW[0x13]) / 2;
+	pRaInfo->NscUp = (N_THRESHOLD_HIGH[0x13] + N_THRESHOLD_LOW[0x13]) / 2;
 	pRaInfo->RateSGI = 0;
 	pRaInfo->Active = 1;	/* Active is not used at present. by page, 110819 */
 	pRaInfo->RptTime = 0x927c;
-- 
2.19.2

