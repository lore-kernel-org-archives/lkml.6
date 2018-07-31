Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8C1C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6953F20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2o7aWZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6953F20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbeGaWmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:42:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36942 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732308AbeGaWmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:42:45 -0400
Received: by mail-ed1-f68.google.com with SMTP id b10-v6so5860683eds.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RiuZTphyHW/+CIawOqW1yX8ru5JLiiNmEhyJZPF9e0U=;
        b=t2o7aWZXwV4FaQLaSYXXILZKBnDmoJopYXfSBjPAZhAgVpjFWRORAy+D6f24UHzaBK
         eIN2n9biTlm1ZujpBS7WZ7tlttxl8B+AwO47YHowzNAzH4aEfuYUUHdvEBJZurk4TRfm
         XkZTD9kMe1aO6hC+Nk8fk0AHYxGxABdvnEnrZloGKJiCChABeJQjBIjIlqNIYVR2MOUs
         IUC4udjoYx8OmV8zeQPdW3S/YKBSqOQPZmszhyZf7xby6MnGAe7V9Odbdh/ugpoD9JEC
         x/atVf296L3XES4BBgXBZXucOc3ihr3T1x/LOAKPm5oG7wdUptF/qODWfgsoP1bhNgdN
         BeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RiuZTphyHW/+CIawOqW1yX8ru5JLiiNmEhyJZPF9e0U=;
        b=aUdwMPreKlKPCGxNI6zVKqxnZr4L8760S62O4W+3Gw8IzizNU/xmavKItvXdeNOk4R
         Sr//nt/M3NcGMrsTqbvNwL3BFV0DABHhs8c00Ujwp0OsYZyqbINb7sDdykEVbRR6wPnJ
         9yhdZ07uPhD8Svd2f5wDJm0dx38/pIBATiZcbUlltXiv19UKYtnGCiH3ZB1jLGP8Qh3k
         20fmgGGciBIcRf2uV4SJIt7CLsXbftCYvWiaCTwDKdgDPVqkDUrj37BtRAKXXv8FexFs
         N1aq8v7Xrvzw5w4bIWD5t/W2CzrbSsnxK5T81Rzzr3yJ5fD5SlmE+ERpAI89XRNbnLat
         rbLQ==
X-Gm-Message-State: AOUpUlFj/89rYzYzqz+HYPAWXN7NfCfhiOPE29dv+qmu7F6f94mqqbq2
        koCWIZAEqb1D05N9605D5xUldCu4
X-Google-Smtp-Source: AAOMgpeCzMbTXb1lwq5OwmvQla8q5ffBU+WHYy5rgWqldDbSXoRfZDLh5TPcIxUo9jTdSkiwLN2lyg==
X-Received: by 2002:a50:e68c:: with SMTP id z12-v6mr1078731edm.275.1533070833191;
        Tue, 31 Jul 2018 14:00:33 -0700 (PDT)
Received: from localhost.localdomain ([109.77.253.253])
        by smtp.gmail.com with ESMTPSA id j42-v6sm4143373eda.2.2018.07.31.14.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 14:00:32 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/14] staging:rtl8192u: Remove union from qos_tsinfo - Style
Date:   Tue, 31 Jul 2018 21:59:54 +0100
Message-Id: <20180731210005.17452-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731210005.17452-1-johnfwhitmore@gmail.com>
References: <20180731210005.17452-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The union is never used as a union but only as a bitfield struct.
One side of the union (u8 charData[3];) Only seems to be present to
ensure that the structures size is 3 bytes in length. That length, of
the structure is dictated by the largest element of the union, so the
byte array only dictates size if it's the largest element of the union.
The byte array and union add nothing.

The union has therefore been removed and the structure and access to
the structure simplified.

Additionally since one of the bitfield variables (ucAccessPolicy)
spans a byte boundary the base type of the bitfield has been changed
from u8 to u16. Compilers have probably moved on from having an issue
with this, call it OCD.

The changes are coding style in nature and should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       |  2 +-
 .../staging/rtl8192u/ieee80211/rtl819x_Qos.h  | 40 +++++++++----------
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       | 26 ++++++------
 3 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index e296813203aa..4e8bcc25ad2c 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -626,7 +626,7 @@ TsInitAddBA(
 	pBA->DialogToken++;						// DialogToken: Only keep the latest dialog token
 	pBA->BaParamSet.field.AMSDU_Support = 0;	// Do not support A-MSDU with A-MPDU now!!
 	pBA->BaParamSet.field.BAPolicy = Policy;	// Policy: Delayed or Immediate
-	pBA->BaParamSet.field.TID = pTS->ts_common_info.t_spec.f.TSInfo.field.ucTSID;	// TID
+	pBA->BaParamSet.field.TID = pTS->ts_common_info.t_spec.f.TSInfo.ucTSID;	// TID
 	// BufferSize: This need to be set according to A-MPDU vector
 	pBA->BaParamSet.field.BufferSize = 32;		// BufferSize: This need to be set according to A-MPDU vector
 	pBA->BaTimeoutValue = 0;					// Timeout value: Set 0 to disable Timer
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 1f16d1692c03..4faa89db8355 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -26,26 +26,24 @@ enum direction_value {
 };
 
 
-//
-// TS Info field in WMM TSPEC Element.
-// Ref:
-//	1. WMM spec 2.2.11: WME TSPEC Element, p.18.
-//	2. 8185 QoS code: QOS_TSINFO [def. in QoS_mp.h]
-//
-union qos_tsinfo {
-	u8		charData[3];
-	struct {
-		u8		ucTrafficType:1;			//WMM is reserved
-		u8		ucTSID:4;
-		u8		ucDirection:2;
-		u8		ucAccessPolicy:2;	//WMM: bit8=0, bit7=1
-		u8		ucAggregation:1;		//WMM is reserved
-		u8		ucPSB:1;				//WMMSA is APSD
-		u8		ucUP:3;
-		u8		ucTSInfoAckPolicy:2;		//WMM is reserved
-		u8		ucSchedule:1;			//WMM is reserved
-		u8		ucReserved:7;
-	} field;
+/*
+ * TS Info field in WMM TSPEC Element.
+ * Ref:
+ *	1. WMM spec 2.2.11: WME TSPEC Element, p.18.
+ *	2. 8185 QoS code: QOS_TSINFO [def. in QoS_mp.h]
+ * Note: sizeof 3 Bytes
+ */
+struct qos_tsinfo {
+	u16		ucTrafficType:1;	//WMM is reserved
+	u16		ucTSID:4;
+	u16		ucDirection:2;
+	u16		ucAccessPolicy:2;	//WMM: bit8=0, bit7=1
+	u16		ucAggregation:1;	//WMM is reserved
+	u16		ucPSB:1;		//WMMSA is APSD
+	u16		ucUP:3;
+	u16		ucTSInfoAckPolicy:2;	//WMM is reserved
+	u8		ucSchedule:1;		//WMM is reserved
+	u8		ucReserved:7;
 };
 
 //
@@ -56,7 +54,7 @@ typedef union _TSPEC_BODY {
 	u8		charData[55];
 
 	struct {
-		union qos_tsinfo	TSInfo;	//u8	TSInfo[3];
+		struct qos_tsinfo	TSInfo;	//u8	TSInfo[3];
 		u16	NominalMSDUsize;
 		u16	MaxMSDUsize;
 		u32	MinServiceItv;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index c21bf3d3b242..39a074621b3b 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -246,10 +246,10 @@ static struct ts_common_info *SearchAdmitTRStream(struct ieee80211_device *ieee,
 		if (!search_dir[dir])
 			continue;
 		list_for_each_entry(pRet, psearch_list, list){
-	//		IEEE80211_DEBUG(IEEE80211_DL_TS, "ADD:%pM, TID:%d, dir:%d\n", pRet->Addr, pRet->TSpec.f.TSInfo.field.ucTSID, pRet->TSpec.f.TSInfo.field.ucDirection);
+	//		IEEE80211_DEBUG(IEEE80211_DL_TS, "ADD:%pM, TID:%d, dir:%d\n", pRet->Addr, pRet->TSpec.f.TSInfo.ucTSID, pRet->TSpec.f.TSInfo.ucDirection);
 			if (memcmp(pRet->addr, Addr, 6) == 0)
-				if (pRet->t_spec.f.TSInfo.field.ucTSID == TID)
-					if(pRet->t_spec.f.TSInfo.field.ucDirection == dir) {
+				if (pRet->t_spec.f.TSInfo.ucTSID == TID)
+					if(pRet->t_spec.f.TSInfo.ucDirection == dir) {
 	//					printk("Bingo! got it\n");
 						break;
 					}
@@ -355,7 +355,7 @@ bool GetTs(
 			// For HCCA or WMMSA, TS cannot be addmit without negotiation.
 			//
 			TSPEC_BODY	TSpec;
-			union qos_tsinfo	*pTSInfo = &TSpec.f.TSInfo;
+			struct qos_tsinfo	*pTSInfo = &TSpec.f.TSInfo;
 			struct list_head	*pUnusedList =
 								(TxRxSelect == TX_DIR)?
 								(&ieee->Tx_TS_Unused_List):
@@ -383,15 +383,15 @@ bool GetTs(
 
 				IEEE80211_DEBUG(IEEE80211_DL_TS, "to init current TS, UP:%d, Dir:%d, addr:%pM\n", UP, Dir, Addr);
 				// Prepare TS Info releated field
-				pTSInfo->field.ucTrafficType = 0;			// Traffic type: WMM is reserved in this field
-				pTSInfo->field.ucTSID = UP;			// TSID
-				pTSInfo->field.ucDirection = Dir;			// Direction: if there is DirectLink, this need additional consideration.
-				pTSInfo->field.ucAccessPolicy = 1;		// Access policy
-				pTSInfo->field.ucAggregation = 0;		// Aggregation
-				pTSInfo->field.ucPSB = 0;				// Aggregation
-				pTSInfo->field.ucUP = UP;				// User priority
-				pTSInfo->field.ucTSInfoAckPolicy = 0;		// Ack policy
-				pTSInfo->field.ucSchedule = 0;			// Schedule
+				pTSInfo->ucTrafficType = 0;		// Traffic type: WMM is reserved in this field
+				pTSInfo->ucTSID = UP;			// TSID
+				pTSInfo->ucDirection = Dir;		// Direction: if there is DirectLink, this need additional consideration.
+				pTSInfo->ucAccessPolicy = 1;		// Access policy
+				pTSInfo->ucAggregation = 0;		// Aggregation
+				pTSInfo->ucPSB = 0;			// Aggregation
+				pTSInfo->ucUP = UP;			// User priority
+				pTSInfo->ucTSInfoAckPolicy = 0;		// Ack policy
+				pTSInfo->ucSchedule = 0;		// Schedule
 
 				MakeTSEntry(*ppTS, Addr, &TSpec, NULL, 0, 0);
 				AdmitTS(ieee, *ppTS, 0);
-- 
2.18.0

