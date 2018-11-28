Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC40C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F2420645
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOouVdZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F2420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbeK2Ebl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:31:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42246 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbeK2Ebl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:31:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so27143465wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vTW2CeU+mouA8DegU7nFXfU8M/ZBYIVanD8Ri0TnsUE=;
        b=UOouVdZ+SBOm7LPnmQVn6m6YNmWVS/vYhycnJEV8aY7MswnONh/X7If4ItTdLNfXXy
         xcnDtpLX60HmUVzKHdLniLeUHSaO0bqBliDnTY7qaL4DfBMwspkQxyaIBz7TcCwGwpIl
         lZilX8rA4lb3v/l9T/cyn1KfMrLOf2R8cvdYnBXUvTmVvPIuKkOA9+958cL3yvDOB7NK
         Rg2hjjQ+L3/igaaZgWBDuQtsUOpF/Q7uKFz9SU6Fop+iLAbiYAt53TciGUB6nsyRHEMW
         OSgf1zfnqiatmIeQYuaG0dlBge9PNqA8aERMN6gtKuxcCbxZbmkXlhEr3bKM09oL/H/g
         nQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vTW2CeU+mouA8DegU7nFXfU8M/ZBYIVanD8Ri0TnsUE=;
        b=K6tIogsbnHumn39uzyWVwVGTVTRIgDeHeTtefpEg1SyKMbZS8gDf4dSwKCGsx+Kl+V
         WXhVWQz5xeyVpHccJOypt+IckQ3lc6XJyXXWo+CaeBvn+HZXV+vmLWbZVnv+Rum8OCeM
         F/QoapUemADJX8rQrVfcQ7oZSfHz+KqJFn0vSa/Ts53Vnea4lSmfCRhX610jZ/Z6+Kdq
         5W9Y/bN/aCMYYlW5B+OUARPkKhsUkGexB8Va75gc/1moikrIIzgTgwYJsrCHc0L2eGEm
         4kK8MabVDlnH7hHrM/KJP0neKqiF4PBY0Ru+ornC83RYX/jE+gA+Y133YJnhrai2DJbC
         INvw==
X-Gm-Message-State: AA+aEWYdVerY0NNHbnnKJDhy3PqFiHtsHv6mT537HjRTwyGQ3OSQdlMX
        g22btvF3Xv4YlbuSXRENNe4=
X-Google-Smtp-Source: AFSGD/Wd6RAdGr7ktzA27HSy6wzbaEBJE9QjB3/Si7iv6fIbcnFz4V6pZaQZR2u7GRJlMrwgyYIc2A==
X-Received: by 2002:a05:6000:104b:: with SMTP id c11mr32706724wrx.303.1543426156768;
        Wed, 28 Nov 2018 09:29:16 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id m126sm4199467wmb.30.2018.11.28.09.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 09:29:16 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/6] staging: rtl8188eu: use __func__ in hal8188e_rate_adaptive.c
Date:   Wed, 28 Nov 2018 18:29:01 +0100
Message-Id: <20181128172906.1694-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __func__ instead of hardcoded function names.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../rtl8188eu/hal/hal8188e_rate_adaptive.c    | 36 ++++++++++---------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c b/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
index 6dbd7d261f1e..02f423accee8 100644
--- a/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
+++ b/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
@@ -127,10 +127,10 @@ static int odm_RateDown_8188E(struct odm_dm_struct *dm_odm,
 	u8 i;
 
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE,
-			ODM_DBG_TRACE, ("=====>odm_RateDown_8188E()\n"));
+			ODM_DBG_TRACE, ("=====>%s()\n", __func__));
 	if (!pRaInfo) {
 		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-				("odm_RateDown_8188E(): pRaInfo is NULL\n"));
+				("%s(): pRaInfo is NULL\n", __func__));
 		return -1;
 	}
 	RateID = pRaInfo->PreRate;
@@ -180,7 +180,7 @@ static int odm_RateDown_8188E(struct odm_dm_struct *dm_odm,
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
 			("Rate down to RateID %d RateSGI %d\n", RateID, pRaInfo->RateSGI));
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-			("<===== odm_RateDown_8188E()\n"));
+			("<===== %s()\n", __func__));
 	return 0;
 }
 
@@ -193,10 +193,10 @@ static int odm_RateUp_8188E(
 	u8 i;
 
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE,
-			ODM_DBG_TRACE, ("=====>odm_RateUp_8188E()\n"));
+			ODM_DBG_TRACE, ("=====>%s()\n", __func__));
 	if (!pRaInfo) {
 		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-				("odm_RateUp_8188E(): pRaInfo is NULL\n"));
+				("%s(): pRaInfo is NULL\n", __func__));
 		return -1;
 	}
 	RateID = pRaInfo->PreRate;
@@ -213,7 +213,7 @@ static int odm_RateUp_8188E(
 	}
 	odm_SetTxRPTTiming_8188E(dm_odm, pRaInfo, 0);
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-			("odm_RateUp_8188E():Decrease RPT Timing\n"));
+			("%s():Decrease RPT Timing\n", __func__));
 
 	if (RateID < HighestRate) {
 		for (i = RateID+1; i <= HighestRate; i++) {
@@ -244,7 +244,7 @@ static int odm_RateUp_8188E(
 			("RAWaitingCounter %d, RAPendingCounter %d",
 			 pRaInfo->RAWaitingCounter, pRaInfo->RAPendingCounter));
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE,
-			ODM_DBG_TRACE, ("<===== odm_RateUp_8188E()\n"));
+			ODM_DBG_TRACE, ("<===== %s()\n", __func__));
 	return 0;
 }
 
@@ -266,7 +266,7 @@ static void odm_RateDecision_8188E(struct odm_dm_struct *dm_odm,
 	static u8 DynamicTxRPTTimingCounter;
 
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-			("=====>odm_RateDecision_8188E()\n"));
+			("=====>%s()\n", __func__));
 
 	if (pRaInfo->Active && (pRaInfo->TOTAL > 0)) { /*  STA used and data packet exits */
 		if ((pRaInfo->RssiStaRA < (pRaInfo->PreRssiStaRA - 3)) ||
@@ -345,7 +345,8 @@ static void odm_RateDecision_8188E(struct odm_dm_struct *dm_odm,
 
 		odm_ResetRaCounter_8188E(pRaInfo);
 	}
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, ("<===== odm_RateDecision_8188E()\n"));
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
+		     ("<===== %s()\n", __func__));
 }
 
 static int odm_ARFBRefresh_8188E(struct odm_dm_struct *dm_odm, struct odm_ra_info *pRaInfo)
@@ -533,7 +534,8 @@ odm_RATxRPTTimerSetting(
 		u16 minRptTime
 )
 {
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, (" =====>odm_RATxRPTTimerSetting()\n"));
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
+		     (" =====>%s()\n", __func__));
 
 	if (dm_odm->CurrminRptTime != minRptTime) {
 		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
@@ -541,7 +543,8 @@ odm_RATxRPTTimerSetting(
 		rtw_rpt_timer_cfg_cmd(dm_odm->Adapter, minRptTime);
 		dm_odm->CurrminRptTime = minRptTime;
 	}
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, (" <===== odm_RATxRPTTimerSetting()\n"));
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
+		     (" <===== %s()\n", __func__));
 }
 
 int ODM_RAInfo_Init(struct odm_dm_struct *dm_odm, u8 macid)
@@ -563,8 +566,8 @@ int ODM_RAInfo_Init(struct odm_dm_struct *dm_odm, u8 macid)
 	}
 
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-		     ("ODM_RAInfo_Init(): WirelessMode:0x%08x , max_raid_idx:0x%02x\n",
-		     WirelessMode, max_rate_idx));
+		     ("%s(): WirelessMode:0x%08x , max_raid_idx:0x%02x\n",
+		      __func__, WirelessMode, max_rate_idx));
 
 	pRaInfo->DecisionRate = max_rate_idx;
 	pRaInfo->PreRate = max_rate_idx;
@@ -694,8 +697,8 @@ void ODM_RA_TxRPT2Handle_8188E(struct odm_dm_struct *dm_odm, u8 *TxRPT_Buf, u16
 	u16 minRptTime = 0x927c;
 
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-		     ("=====>ODM_RA_TxRPT2Handle_8188E(): valid0 =%d valid1 =%d BufferLength =%d\n",
-		     macid_entry0, macid_entry1, TxRPT_Len));
+		     ("=====>%s(): valid0 =%d valid1 =%d BufferLength =%d\n",
+		      __func__, macid_entry0, macid_entry1, TxRPT_Len));
 
 	ItemNum = TxRPT_Len >> 3;
 	pBuffer = TxRPT_Buf;
@@ -769,5 +772,6 @@ void ODM_RA_TxRPT2Handle_8188E(struct odm_dm_struct *dm_odm, u8 *TxRPT_Buf, u16
 
 	odm_RATxRPTTimerSetting(dm_odm, minRptTime);
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("<===== ODM_RA_TxRPT2Handle_8188E()\n"));
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
+		     ("<===== %s()\n", __func__));
 }
-- 
2.19.2

