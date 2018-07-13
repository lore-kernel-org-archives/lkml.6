Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F53ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954E8208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FY0+ya9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954E8208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387710AbeGMU3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:29:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38981 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733009AbeGMU3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:29:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id h20-v6so10374022wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 13:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pxR6W5/xjhMrwCOy/aRncl1mD85meYISMmgFd4dxkX4=;
        b=FY0+ya9X81SFWs91VFb/VE5/g0E6raDBpw/NS5I/ITkLcrgTCu7oRYBQNGR2tsPsZr
         HZeyHS+ypjYDJSsoWqLJRjy7eBCL3fICZfIH2/sj8S+3roAK9fGbiaVUr03+E/mjpS3b
         90nhMlauCjVgfAHPKpXSIlB21CSt1aRqbQBYAXUnrP+0u30gcVwba0cuC0PNoAeFlSLi
         oRDRrkHV86flL5VeJx6eSLxYOYY9vDkPKcguJrrBnjOIEWv483IIzIySU57MndzR/JlH
         5vh7AXFfOaWn61VNlZNAHKQmPxXq30dVoxko1SRk/kjLmnJsBU5xo+AyL/XOMn3g1nHW
         q4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pxR6W5/xjhMrwCOy/aRncl1mD85meYISMmgFd4dxkX4=;
        b=HJFDzYqe0yQioJDSRLhhCPxQJ2GgUODqytQJvyVoECZKgg+ulUsV96DKDRt0XZvcME
         VWZHZzwRzOB0eOuKoCHKhU5iiBOe0b+Xd+kNi8PnVu3YmGTS/7khlke///dchZs9tdH/
         xhLDpKSDH4K0ffn8sTTAsB5Idy7ubridQILpYDe20wMWwUngiVtu6uLUlzkjL2IOuUjI
         nOpxBJqB5VNTbB9snwUporwFkvpVMucvpY2ajDr3a20wutys0TueIKBN3kLdy59+2u9B
         9WqpNQKwMy2HzF0mpM9ZCRNWhmstAaH7TsVMzwHBTCYJZtQPBKG82kvnPqcYOs6dkSOt
         tJMA==
X-Gm-Message-State: AOUpUlHZFsG7zWlRDt6QRYCNX1QDDPcosJ3TnwuYoSmePoXHylzgrP4i
        YnFZFjVpPZkQSmihB+MQrwfWjdvu
X-Google-Smtp-Source: AAOMgpca8oRRuTzDADTRGNBdLd7YBgETHDnML0KWvbgbGeRu/8R5o05E0iGT0Rq9y6ArnBEztLVUnw==
X-Received: by 2002:a1c:ae8d:: with SMTP id x135-v6mr4678512wme.20.1531512815804;
        Fri, 13 Jul 2018 13:13:35 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id f6-v6sm14072677wrp.30.2018.07.13.13.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 13:13:35 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/10] staging:rtl8192u: Rename TSpec > t_spec - Style
Date:   Fri, 13 Jul 2018 21:12:44 +0100
Message-Id: <20180713201247.21428-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713201247.21428-1-johnfwhitmore@gmail.com>
References: <20180713201247.21428-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the TS_COMMON_INFO structure's member TSpec to t_spec. This change
clears the checkpatch issue with CamelCase naming of variables. There should
be no impact on runtime execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index f9716db4509e..03a22ef59dfb 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -626,7 +626,7 @@ TsInitAddBA(
 	pBA->DialogToken++;						// DialogToken: Only keep the latest dialog token
 	pBA->BaParamSet.field.AMSDU_Support = 0;	// Do not support A-MSDU with A-MPDU now!!
 	pBA->BaParamSet.field.BAPolicy = Policy;	// Policy: Delayed or Immediate
-	pBA->BaParamSet.field.TID = pTS->TsCommonInfo.TSpec.f.TSInfo.field.ucTSID;	// TID
+	pBA->BaParamSet.field.TID = pTS->TsCommonInfo.t_spec.f.TSInfo.field.ucTSID;	// TID
 	// BufferSize: This need to be set according to A-MPDU vector
 	pBA->BaParamSet.field.BufferSize = 32;		// BufferSize: This need to be set according to A-MPDU vector
 	pBA->BaTimeoutValue = 0;					// Timeout value: Set 0 to disable Timer
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 4ad152920be4..d84092d17441 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -20,7 +20,7 @@ struct TS_COMMON_INFO {
 	struct timer_list		setup_timer;
 	struct timer_list		inact_timer;
 	u8				addr[6];
-	TSPEC_BODY			TSpec;
+	TSPEC_BODY			t_spec;
 	QOS_TCLAS			TClass[TCLAS_NUM];
 	u8				TClasProc;
 	u8				TClasNum;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 80e03dc73bae..8df665f4028d 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -104,7 +104,7 @@ static void TsAddBaProcess(struct timer_list *t)
 static void ResetTsCommonInfo(struct TS_COMMON_INFO *pTsCommonInfo)
 {
 	eth_zero_addr(pTsCommonInfo->addr);
-	memset(&pTsCommonInfo->TSpec, 0, sizeof(TSPEC_BODY));
+	memset(&pTsCommonInfo->t_spec, 0, sizeof(TSPEC_BODY));
 	memset(&pTsCommonInfo->TClass, 0, sizeof(QOS_TCLAS)*TCLAS_NUM);
 	pTsCommonInfo->TClasProc = 0;
 	pTsCommonInfo->TClasNum = 0;
@@ -248,8 +248,8 @@ static struct TS_COMMON_INFO *SearchAdmitTRStream(struct ieee80211_device *ieee,
 		list_for_each_entry(pRet, psearch_list, list){
 	//		IEEE80211_DEBUG(IEEE80211_DL_TS, "ADD:%pM, TID:%d, dir:%d\n", pRet->Addr, pRet->TSpec.f.TSInfo.field.ucTSID, pRet->TSpec.f.TSInfo.field.ucDirection);
 			if (memcmp(pRet->addr, Addr, 6) == 0)
-				if (pRet->TSpec.f.TSInfo.field.ucTSID == TID)
-					if(pRet->TSpec.f.TSInfo.field.ucDirection == dir) {
+				if (pRet->t_spec.f.TSInfo.field.ucTSID == TID)
+					if(pRet->t_spec.f.TSInfo.field.ucDirection == dir) {
 	//					printk("Bingo! got it\n");
 						break;
 					}
@@ -276,7 +276,7 @@ static void MakeTSEntry(struct TS_COMMON_INFO *pTsCommonInfo, u8 *Addr,
 	memcpy(pTsCommonInfo->addr, Addr, 6);
 
 	if(pTSPEC != NULL)
-		memcpy((u8 *)(&(pTsCommonInfo->TSpec)), (u8 *)pTSPEC, sizeof(TSPEC_BODY));
+		memcpy((u8 *)(&(pTsCommonInfo->t_spec)), (u8 *)pTSPEC, sizeof(TSPEC_BODY));
 
 	for(count = 0; count < TCLAS_Num; count++)
 		memcpy((u8 *)(&(pTsCommonInfo->TClass[count])), (u8 *)pTCLAS, sizeof(QOS_TCLAS));
-- 
2.18.0

