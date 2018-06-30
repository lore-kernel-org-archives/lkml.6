Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AB1C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A87271F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7K3wZf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A87271F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030241AbeF3KDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 06:03:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35453 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964816AbeF3KDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 06:03:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id z137-v6so4288941wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 03:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IxnxUz6TYobEsc1wbsm6JY+/yyCRO/dZa6yrYyVSGKo=;
        b=F7K3wZf1/j/aipi6zxP2FF4pJn0jYkpnSV3ZBMTCTIFxHg+PrdBiS/g0oQpXueG7n9
         Mxg2GXgIIfPmd05l99ei95O6IQet4Hs5Nxgk4lPio3xCp9lNqNJ/v4zbtZP/NdfJS1al
         os91jMMO32HZLaE1rSrBCJfXxs8Z6VId2EVbLB2wGBcFMZJ05SM97069fTh24sjgtmmu
         pJ0FiwnoWv1EP0ATvjYSNtRVlKiOdPELepPWTSC1slSFYccoyi5bO37MIXVEfIAw7HIk
         ebfmNRsLD8iUDl0MG7D/G0z3lV2itHFgaGsXplyQs3D/+IZb8VR6zBS35429vLjbK8qF
         6Mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IxnxUz6TYobEsc1wbsm6JY+/yyCRO/dZa6yrYyVSGKo=;
        b=H/e7QcuuUp67Pht6NtaS50lGhQTthgnW3LcXrIO56bbzTIjSlD4iZvEAuzX4UVTUKs
         qpNpVVI0CjpNLimFtwxxnoSR++PkTJR0OgprdsAGfe2c0PdZ0yNpv9rU7lXUqymm9Gyn
         gTMoTLYRZeGHzMGI+fAuqwEgH/YbC5RxZ9MyKolzEFT4zZzt0y/id4queJ+bhFGJolWT
         n3q4snB/Yj+72GieidK1YoM9/X67FqHV0yvZLbviWH+dyQ5oXtqNOafv+GtGpiTd/gSl
         1ih3VdXg28Eh77xDLZLv+AGY+3zo7XjiXhEGb5y0ldSI9g7iAw3Hc3VoKUmPhfEjODkj
         LWRQ==
X-Gm-Message-State: APt69E0LTacTVM/zfsLRaLbQQUllIb2JxiPVkMaJ2yDtqPUktM7dKEyo
        I6D0I41hCXL5wN4axDCyWB3LxpWO
X-Google-Smtp-Source: AAOMgpdOGt+pJatmjiTem8yjjoj7cRoUWgUYztLEMTAIeQBBrrD0ESyE8s5Pym9CdIvZXUxzjvvpmQ==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73-v6mr3753815wme.141.1530352985659;
        Sat, 30 Jun 2018 03:03:05 -0700 (PDT)
Received: from arch.localdomain (x4db215a8.dyn.telefonica.de. [77.178.21.168])
        by smtp.gmail.com with ESMTPSA id b190-v6sm4569504wma.24.2018.06.30.03.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 03:03:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: fix comparsion to true/false and brace issues
Date:   Sat, 30 Jun 2018 12:02:52 +0200
Message-Id: <20180630100252.572-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use if(x) and if(!x) instead of comparsion to true/false.
Reported by checkpatch.

Remove unrequired braces from single if else statements.
Add missing space after else: else{ -> else {

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_btcoex.c | 13 ++++++-------
 drivers/staging/rtl8723bs/core/rtw_efuse.c  |  5 ++---
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_btcoex.c b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
index adac915a2153..922628c59f80 100644
--- a/drivers/staging/rtl8723bs/core/rtw_btcoex.c
+++ b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
@@ -77,14 +77,14 @@ void rtw_btcoex_SuspendNotify(struct adapter *padapter, u8 state)
 
 void rtw_btcoex_HaltNotify(struct adapter *padapter)
 {
-	if (false == padapter->bup) {
+	if (!padapter->bup) {
 		DBG_871X(FUNC_ADPT_FMT ": bup =%d Skip!\n",
 			FUNC_ADPT_ARG(padapter), padapter->bup);
 
 		return;
 	}
 
-	if (true == padapter->bSurpriseRemoved) {
+	if (padapter->bSurpriseRemoved) {
 		DBG_871X(FUNC_ADPT_FMT ": bSurpriseRemoved =%d Skip!\n",
 			FUNC_ADPT_ARG(padapter), padapter->bSurpriseRemoved);
 
@@ -115,11 +115,10 @@ s32 rtw_btcoex_IsBTCoexCtrlAMPDUSize(struct adapter *padapter)
 
 void rtw_btcoex_SetManualControl(struct adapter *padapter, u8 manual)
 {
-	if (true == manual) {
+	if (manual)
 		hal_btcoex_SetManualControl(padapter, true);
-	} else{
+	else
 		hal_btcoex_SetManualControl(padapter, false);
-	}
 }
 
 u8 rtw_btcoex_IsBtControlLps(struct adapter *padapter)
@@ -198,11 +197,11 @@ void rtw_btcoex_RejectApAggregatedPacket(struct adapter *padapter, u8 enable)
 	pmlmeinfo = &padapter->mlmeextpriv.mlmext_info;
 	psta = rtw_get_stainfo(&padapter->stapriv, get_bssid(&padapter->mlmepriv));
 
-	if (true == enable) {
+	if (enable) {
 		pmlmeinfo->accept_addba_req = false;
 		if (psta)
 			send_delba(padapter, 0, psta->hwaddr);
-	} else{
+	} else {
 		pmlmeinfo->accept_addba_req = true;
 	}
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index c306ad7e395c..b3247c9642ea 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -580,11 +580,10 @@ void EFUSE_ShadowMapUpdate(
 
 	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, bPseudoTest);
 
-	if (pEEPROM->bautoload_fail_flag == true) {
+	if (pEEPROM->bautoload_fail_flag)
 		memset(pEEPROM->efuse_eeprom_data, 0xFF, mapLen);
-	} else{
+	else
 		Efuse_ReadAllMap(padapter, efuseType, pEEPROM->efuse_eeprom_data, bPseudoTest);
-	}
 
 	/* PlatformMoveMemory((void *)&pHalData->EfuseMap[EFUSE_MODIFY_MAP][0], */
 	/* void *)&pHalData->EfuseMap[EFUSE_INIT_MAP][0], mapLen); */
-- 
2.18.0

