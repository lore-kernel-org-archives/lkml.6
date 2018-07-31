Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE82C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E54320857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRDPeDD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E54320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbeGaWmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:42:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45379 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732308AbeGaWms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:42:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id s16-v6so5851641edq.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BY1IdK1wFgVAU7//ogJdlD9Inn29scvgTHDtxMs8Xo8=;
        b=JRDPeDD8za7C4SemsC+nJvHXYMGMVsfD56QSVbYK0Iv5ejzB1mBTJxrvMCJ/Winqq3
         T/wiXdTg+0SSypzZrH9LTGtSM5fD0sNkJLw00p7Nt5g3VR5tSF0tW9YCL+veZAMSU25t
         bnmw1MI4hzL7LQbN0zaIm4lneYDouII/7V74AGAnDCKgdBps9kvhi6sRfP0jcpY1OdV1
         20JfQzjdbfaChkBhnyqkW2SM8RcmmSdwYKoPRKrDerGE/wgPwJYACC4PPoNJcuQc14Gy
         wTx97QkmJkhSElSh26AtY2K8Bfcw0LpCg0SOf8N9moDPunoFgM2ByoI3pmJ2YOi11f3f
         2nOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BY1IdK1wFgVAU7//ogJdlD9Inn29scvgTHDtxMs8Xo8=;
        b=pISj6eu9qsc2JVGDI469h7cLcoHh6Z4V6fhVA8W++UPy+pIoQS02NvjHgGeyS74BOU
         TgwwTubX6Gb56Gkb2PXMmGWhtkpEjnBfrSHWj0kUmJqi8gKUEKpKbq0s/X6AU2DoGnw0
         Px2d8B4inkIPlaw7YDj8xJcO9CaqifHfluKcTNmsoNLZirsqeJZswQ0sOqkSK7lCrOmB
         LL2K4wTA4lrmUcMhfRuHgNlS9VcVZmhC3vB+VkBqL81TtKzQ2djaVG1lc6PSyVarCviF
         hKfxG55Bgu1rtiUU7sjVsGcpI/Ndo3gBc2PeVM47A4xUxK95eRkre1JHEok6ssk8BuiL
         vLjA==
X-Gm-Message-State: AOUpUlGtcbtpOA1WvtuTr1Ul5asi7Gtv6zz4XKKBedbeKXYI2Pxgt0+6
        5j1Wo9Kr1X4pPdWhBbPNzm/8fLD1
X-Google-Smtp-Source: AAOMgpdvcI7lcuJWVEwk5NVjCg3cvgU+WVf7dM71ztQcwVJa7JyE7ifwFKS1lMQJ6F06NGtltum/pQ==
X-Received: by 2002:a50:a4a1:: with SMTP id w30-v6mr1099399edb.67.1533070836332;
        Tue, 31 Jul 2018 14:00:36 -0700 (PDT)
Received: from localhost.localdomain ([109.77.253.253])
        by smtp.gmail.com with ESMTPSA id j42-v6sm4143373eda.2.2018.07.31.14.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 14:00:35 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/14] staging:rtl8192u: Refactor union TSPEC_BODY - Style
Date:   Tue, 31 Jul 2018 21:59:56 +0100
Message-Id: <20180731210005.17452-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731210005.17452-1-johnfwhitmore@gmail.com>
References: <20180731210005.17452-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The union TSPEC_BODY is never used as a union. The union comprises an
array of bytes and a bitfield structure, both of which are 55 bytes in
length, but the byte array is never used. As a result the union has
been truncated to the bitfield struct, which is actually used.

Additionally the typedef has been removed from the structure to clear
the checkpatch issue with defining new types. Additionally the name has
been changed to lowercase to comply with coding style.

These changes are all coding style changes which should have no impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       |  2 +-
 .../staging/rtl8192u/ieee80211/rtl819x_Qos.h  | 49 +++++++++----------
 .../staging/rtl8192u/ieee80211/rtl819x_TS.h   |  2 +-
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       | 16 +++---
 4 files changed, 33 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 96fab43c1cfe..d35f10c695e4 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -626,7 +626,7 @@ TsInitAddBA(
 	pBA->DialogToken++;						// DialogToken: Only keep the latest dialog token
 	pBA->BaParamSet.field.AMSDU_Support = 0;	// Do not support A-MSDU with A-MPDU now!!
 	pBA->BaParamSet.field.BAPolicy = Policy;	// Policy: Delayed or Immediate
-	pBA->BaParamSet.field.TID = pTS->ts_common_info.t_spec.f.TSInfo.uc_tsid;	// TID
+	pBA->BaParamSet.field.TID = pTS->ts_common_info.t_spec.TSInfo.uc_tsid;	// TID
 	// BufferSize: This need to be set according to A-MPDU vector
 	pBA->BaParamSet.field.BufferSize = 32;		// BufferSize: This need to be set according to A-MPDU vector
 	pBA->BaTimeoutValue = 0;					// Timeout value: Set 0 to disable Timer
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index d36a14197b4c..a4cecf4cc756 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -46,32 +46,29 @@ struct qos_tsinfo {
 	u8:7;
 };
 
-//
-// WMM TSPEC Body.
-// Ref: WMM spec 2.2.11: WME TSPEC Element, p.16.
-//
-typedef union _TSPEC_BODY {
-	u8		charData[55];
-
-	struct {
-		struct qos_tsinfo	TSInfo;	//u8	TSInfo[3];
-		u16	NominalMSDUsize;
-		u16	MaxMSDUsize;
-		u32	MinServiceItv;
-		u32	MaxServiceItv;
-		u32	InactivityItv;
-		u32	SuspenItv;
-		u32	ServiceStartTime;
-		u32	MinDataRate;
-		u32	MeanDataRate;
-		u32	PeakDataRate;
-		u32	MaxBurstSize;
-		u32	DelayBound;
-		u32	MinPhyRate;
-		u16	SurplusBandwidthAllowance;
-		u16	MediumTime;
-	} f;	// Field
-} TSPEC_BODY, *PTSPEC_BODY;
+/*
+ * WMM TSPEC Body.
+ * Ref: WMM spec 2.2.11: WME TSPEC Element, p.16.
+ * Note: sizeof 55 bytes
+ */
+struct tspec_body {
+	struct qos_tsinfo	TSInfo;	//u8	TSInfo[3];
+	u16	NominalMSDUsize;
+	u16	MaxMSDUsize;
+	u32	MinServiceItv;
+	u32	MaxServiceItv;
+	u32	InactivityItv;
+	u32	SuspenItv;
+	u32	ServiceStartTime;
+	u32	MinDataRate;
+	u32	MeanDataRate;
+	u32	PeakDataRate;
+	u32	MaxBurstSize;
+	u32	DelayBound;
+	u32	MinPhyRate;
+	u16	SurplusBandwidthAllowance;
+	u16	MediumTime;
+};
 
 //typedef struct _TCLASS{
 // TODO
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index f5e79853fe9c..a9f865f810ce 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -19,7 +19,7 @@ struct ts_common_info {
 	struct timer_list		setup_timer;
 	struct timer_list		inact_timer;
 	u8				addr[6];
-	TSPEC_BODY			t_spec;
+	struct tspec_body		t_spec;
 	QOS_TCLAS			t_class[TCLAS_NUM];
 	u8				t_clas_proc;
 	u8				t_clas_num;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 076278dae321..bd2b4e5dfa60 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -104,7 +104,7 @@ static void TsAddBaProcess(struct timer_list *t)
 static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
 {
 	eth_zero_addr(pTsCommonInfo->addr);
-	memset(&pTsCommonInfo->t_spec, 0, sizeof(TSPEC_BODY));
+	memset(&pTsCommonInfo->t_spec, 0, sizeof(struct tspec_body));
 	memset(&pTsCommonInfo->t_class, 0, sizeof(QOS_TCLAS)*TCLAS_NUM);
 	pTsCommonInfo->t_clas_proc = 0;
 	pTsCommonInfo->t_clas_num = 0;
@@ -246,10 +246,10 @@ static struct ts_common_info *SearchAdmitTRStream(struct ieee80211_device *ieee,
 		if (!search_dir[dir])
 			continue;
 		list_for_each_entry(pRet, psearch_list, list){
-	//		IEEE80211_DEBUG(IEEE80211_DL_TS, "ADD:%pM, TID:%d, dir:%d\n", pRet->Addr, pRet->TSpec.f.TSInfo.ucTSID, pRet->TSpec.f.TSInfo.ucDirection);
+	//		IEEE80211_DEBUG(IEEE80211_DL_TS, "ADD:%pM, TID:%d, dir:%d\n", pRet->Addr, pRet->TSpec.TSInfo.ucTSID, pRet->TSpec.TSInfo.ucDirection);
 			if (memcmp(pRet->addr, Addr, 6) == 0)
-				if (pRet->t_spec.f.TSInfo.uc_tsid == TID)
-					if(pRet->t_spec.f.TSInfo.uc_direction == dir) {
+				if (pRet->t_spec.TSInfo.uc_tsid == TID)
+					if(pRet->t_spec.TSInfo.uc_direction == dir) {
 	//					printk("Bingo! got it\n");
 						break;
 					}
@@ -265,7 +265,7 @@ static struct ts_common_info *SearchAdmitTRStream(struct ieee80211_device *ieee,
 }
 
 static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *Addr,
-			PTSPEC_BODY pTSPEC, PQOS_TCLAS pTCLAS, u8 TCLAS_Num,
+			struct tspec_body *pTSPEC, PQOS_TCLAS pTCLAS, u8 TCLAS_Num,
 			u8 TCLAS_Proc)
 {
 	u8	count;
@@ -276,7 +276,7 @@ static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *Addr,
 	memcpy(pTsCommonInfo->addr, Addr, 6);
 
 	if(pTSPEC != NULL)
-		memcpy((u8 *)(&(pTsCommonInfo->t_spec)), (u8 *)pTSPEC, sizeof(TSPEC_BODY));
+		memcpy((u8 *)(&(pTsCommonInfo->t_spec)), (u8 *)pTSPEC, sizeof(struct tspec_body));
 
 	for(count = 0; count < TCLAS_Num; count++)
 		memcpy((u8 *)(&(pTsCommonInfo->t_class[count])), (u8 *)pTCLAS, sizeof(QOS_TCLAS));
@@ -354,8 +354,8 @@ bool GetTs(
 			// This is for EDCA and WMM to add a new TS.
 			// For HCCA or WMMSA, TS cannot be addmit without negotiation.
 			//
-			TSPEC_BODY	TSpec;
-			struct qos_tsinfo	*pTSInfo = &TSpec.f.TSInfo;
+			struct tspec_body	TSpec;
+			struct qos_tsinfo	*pTSInfo = &TSpec.TSInfo;
 			struct list_head	*pUnusedList =
 								(TxRxSelect == TX_DIR)?
 								(&ieee->Tx_TS_Unused_List):
-- 
2.18.0

