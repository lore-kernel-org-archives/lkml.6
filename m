Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488C4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060E82086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d60ZFqnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060E82086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbeK2Ebz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:31:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37020 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbeK2Ebo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:31:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so3399228wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5hz/8W+MNwR3dN88NvKxNkyMqNBJwgZFUV8cTyNzvUo=;
        b=d60ZFqncIWIPLldTPJGKfphEDtKNYkOn6yZhIrH3ZODAzd6fsD9Knv1Z7suJYdOLAz
         l7E7h1sracYNmX3C94fkfSKlfeuLgGGBP1HMqCYmX1xovsqOuIpRlvW8KksQUslbFwq2
         vtDRQxYRif/4wZXQObYsh1Oj1mkB27jN3MqP5wrPZkMscrFWPWfnfjM242QOsT+80ONn
         /5dzR/6Q+nSE62Z8WdnUFIYEj2xXA/0poVghyO8B+ImInNh8qTiuhtDAq3uJKQ7hMC6I
         +noqrRoHN3+JAGtPHWG6WZcYPBUe9SQC9omKyjI2mC3XmX59Imy+G4/6rhcRuLNNV1s4
         sbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5hz/8W+MNwR3dN88NvKxNkyMqNBJwgZFUV8cTyNzvUo=;
        b=XxUWow+Ove+zXJJZxtaAQepIAxbUoM9gP/FRM+Hw1zgbPZN/9ADyWElp+jiD9uJqeW
         4ma3vd3r+T1VGR/PiTCZwCMpm4RVkvERK8bAT1fuaWl26QDZpBSQFCFcfB+t+EeMRwyq
         xr6RAkpXvbUzw4Px3j8qvmIXo5ZHsSP3Y9aVS1ygpvPIOOucr+OdFs2khO4TPB0W61Ac
         9PLr9qT1PaQkd2QrqB5c/0hvAcHLg+GV0raVEFqGjxIUYRwhKdWZCpk0PF2A9BYX6veX
         BS8lr7buQ21XlSgf1fwKX5BhjYgb6FgpWnEpTk4CRbRaBI++b9fOPnHM3yMnU4fkGUFx
         Iwng==
X-Gm-Message-State: AA+aEWYvuR4x4aHG2tc3CO8jiM7w/h0oZ+USHEhba9N4eRlv37C19z6e
        y2aGjtjkJGClI7f+KUhKdLg=
X-Google-Smtp-Source: AFSGD/VqfVzLdKN+xEDQsbtPReFoedHs6OKZb4LlMW1I/JSaQNfV2KkuG6qlsSUGfOxCuJ/wd90Srw==
X-Received: by 2002:a1c:7c0b:: with SMTP id x11mr3561048wmc.20.1543426160337;
        Wed, 28 Nov 2018 09:29:20 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id m126sm4199467wmb.30.2018.11.28.09.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 09:29:19 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/6] staging: rtl8188eu: cleanup alignment issues in hal8188e_rate_adaptive.c
Date:   Wed, 28 Nov 2018 18:29:05 +0100
Message-Id: <20181128172906.1694-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181128172906.1694-1-straube.linux@gmail.com>
References: <20181128172906.1694-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup alignment issues reported by checkpatch.
CHECK: Alignment should match open parenthesis

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../rtl8188eu/hal/hal8188e_rate_adaptive.c    | 37 +++++++++----------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c b/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
index c6f6594feaa2..f1ff86fec654 100644
--- a/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
+++ b/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
@@ -114,20 +114,20 @@ static void odm_SetTxRPTTiming_8188E(struct odm_dm_struct *dm_odm,
 	pRaInfo->RptTime = DynamicTxRPTTiming[idx];
 
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-			("pRaInfo->RptTime = 0x%x\n", pRaInfo->RptTime));
+		     ("pRaInfo->RptTime = 0x%x\n", pRaInfo->RptTime));
 }
 
 static int odm_RateDown_8188E(struct odm_dm_struct *dm_odm,
-				struct odm_ra_info *pRaInfo)
+			      struct odm_ra_info *pRaInfo)
 {
 	u8 RateID, LowestRate, HighestRate;
 	u8 i;
 
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE,
-			ODM_DBG_TRACE, ("=====>%s()\n", __func__));
+		     ODM_DBG_TRACE, ("=====>%s()\n", __func__));
 	if (!pRaInfo) {
 		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-				("%s(): pRaInfo is NULL\n", __func__));
+			     ("%s(): pRaInfo is NULL\n", __func__));
 		return -1;
 	}
 	RateID = pRaInfo->PreRate;
@@ -170,14 +170,14 @@ static int odm_RateDown_8188E(struct odm_dm_struct *dm_odm,
 	pRaInfo->DecisionRate = RateID;
 	odm_SetTxRPTTiming_8188E(dm_odm, pRaInfo, 2);
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE,
-			ODM_DBG_LOUD, ("Rate down, RPT Timing default\n"));
+		     ODM_DBG_LOUD, ("Rate down, RPT Timing default\n"));
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-			("RAWaitingCounter %d, RAPendingCounter %d",
+		     ("RAWaitingCounter %d, RAPendingCounter %d",
 			 pRaInfo->RAWaitingCounter, pRaInfo->RAPendingCounter));
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-			("Rate down to RateID %d RateSGI %d\n", RateID, pRaInfo->RateSGI));
+		     ("Rate down to RateID %d RateSGI %d\n", RateID, pRaInfo->RateSGI));
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-			("<===== %s()\n", __func__));
+		     ("<===== %s()\n", __func__));
 	return 0;
 }
 
@@ -188,10 +188,10 @@ static int odm_RateUp_8188E(struct odm_dm_struct *dm_odm,
 	u8 i;
 
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE,
-			ODM_DBG_TRACE, ("=====>%s()\n", __func__));
+		     ODM_DBG_TRACE, ("=====>%s()\n", __func__));
 	if (!pRaInfo) {
 		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-				("%s(): pRaInfo is NULL\n", __func__));
+			     ("%s(): pRaInfo is NULL\n", __func__));
 		return -1;
 	}
 	RateID = pRaInfo->PreRate;
@@ -208,7 +208,7 @@ static int odm_RateUp_8188E(struct odm_dm_struct *dm_odm,
 	}
 	odm_SetTxRPTTiming_8188E(dm_odm, pRaInfo, 0);
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-			("%s():Decrease RPT Timing\n", __func__));
+		     ("%s():Decrease RPT Timing\n", __func__));
 
 	if (RateID < HighestRate) {
 		for (i = RateID + 1; i <= HighestRate; i++) {
@@ -234,12 +234,12 @@ static int odm_RateUp_8188E(struct odm_dm_struct *dm_odm,
 
 	pRaInfo->DecisionRate = RateID;
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-			("Rate up to RateID %d\n", RateID));
+		     ("Rate up to RateID %d\n", RateID));
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-			("RAWaitingCounter %d, RAPendingCounter %d",
-			 pRaInfo->RAWaitingCounter, pRaInfo->RAPendingCounter));
+		     ("RAWaitingCounter %d, RAPendingCounter %d",
+		      pRaInfo->RAWaitingCounter, pRaInfo->RAPendingCounter));
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE,
-			ODM_DBG_TRACE, ("<===== %s()\n", __func__));
+		     ODM_DBG_TRACE, ("<===== %s()\n", __func__));
 	return 0;
 }
 
@@ -255,15 +255,14 @@ static void odm_ResetRaCounter_8188E(struct odm_ra_info *pRaInfo)
 }
 
 static void odm_RateDecision_8188E(struct odm_dm_struct *dm_odm,
-		struct odm_ra_info *pRaInfo
-	)
+				   struct odm_ra_info *pRaInfo)
 {
 	u8 RateID = 0, RtyPtID = 0, PenaltyID1 = 0, PenaltyID2 = 0, i = 0;
 	/* u32 pool_retry; */
 	static u8 DynamicTxRPTTimingCounter;
 
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-			("=====>%s()\n", __func__));
+		     ("=====>%s()\n", __func__));
 
 	if (pRaInfo->Active && (pRaInfo->TOTAL > 0)) { /*  STA used and data packet exits */
 		if ((pRaInfo->RssiStaRA < (pRaInfo->PreRssiStaRA - 3)) ||
@@ -631,7 +630,7 @@ u8 ODM_RA_GetDecisionRate_8188E(struct odm_dm_struct *dm_odm, u8 macid)
 		return 0;
 	DecisionRate = dm_odm->RAInfo[macid].DecisionRate;
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-		(" macid =%d DecisionRate = 0x%x\n", macid, DecisionRate));
+		     (" macid =%d DecisionRate = 0x%x\n", macid, DecisionRate));
 	return DecisionRate;
 }
 
-- 
2.19.2

