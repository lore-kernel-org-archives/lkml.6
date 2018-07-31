Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD156C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BD320857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRoFLQp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BD320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbeGaWmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:42:47 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34190 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732355AbeGaWmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:42:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id h1-v6so5864228eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dxHyOCIQuvmrfrRM+rS/+ekyf8+TSbmgSEFW4tIuhaA=;
        b=dRoFLQp+kprJRNneyPu3HB46MmoKVt1KRi0PyD55oH6QfjiGVJkZZPR/Hp9mGwdvl4
         Ltmci8T75BnF0P0lpdG11W/2a2CQ2JcQ9UzsRYaIGAs9A11rMmdISu+83aelcSQt8NTT
         97eU8fLXMH4UzNgnBpmNNBOlt3S/E+57eXY/hUjPBeUHgzwGgzf+wndaeZhtbXME5cNW
         HUsJsFOidlmDOJUZZL8U2REjJKvv6G7nGr8A/rjzpDh+xUqjIAkxiGSgrlG6xadmZ8qi
         xT15INzf233LDfjAOndgmW2s49zBiSS+rV/5MfzeC3a4tN/PpfylnFGf9V0lLtmuZ6Ds
         /MlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dxHyOCIQuvmrfrRM+rS/+ekyf8+TSbmgSEFW4tIuhaA=;
        b=Ii5qa99PtGQpI8RYJoOTNLEN8G0bHMJG4gbZCZBdi9fTc2z7E+oThoJlZfasFKUJoF
         Xwxve0ArB1MPdXENnxs6h4gS0nfhuZClyBw439bs7Y6J3ugsGPdCkeMxMlmQzlLZ/tA3
         dM/gAoNgsIMpp5fkctaadMwj3wZPF9fbi+7yw+lLsfwuXHv/v1UWM76+9wgCFDm5lWL0
         kb+1hCh6fk/3FnDnfZ/kZqBO6MC/AaXa+WmvfJEVZzGfzX475lyRM4fKCW0p5Qkvsdk5
         aM4T8daw5RQxEUMHLl5feL4SMVh6tmUsQ/Eah96hC7qK2nmcOLyrJ48N37QRhVH4ESEe
         +lMQ==
X-Gm-Message-State: AOUpUlE70lFbNzRPi9hqlea7NQXZ5XjErgdrMcxG+3VRPiPjs87ZZnHY
        Ji8kUT2EpG0MxcC7rij2mE2vIKSz
X-Google-Smtp-Source: AAOMgpdrZPU/ualUsFODo3h7F80AbZ7PQnvW4gureu90FN3cSlTYVPP3oEPytv1HZdzkp7lZZiLyJQ==
X-Received: by 2002:a50:b702:: with SMTP id g2-v6mr1091779ede.139.1533070834777;
        Tue, 31 Jul 2018 14:00:34 -0700 (PDT)
Received: from localhost.localdomain ([109.77.253.253])
        by smtp.gmail.com with ESMTPSA id j42-v6sm4143373eda.2.2018.07.31.14.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 14:00:33 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/14] staging:rtl8192u: Rename members of struct qos_tsinfo - Style
Date:   Tue, 31 Jul 2018 21:59:55 +0100
Message-Id: <20180731210005.17452-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731210005.17452-1-johnfwhitmore@gmail.com>
References: <20180731210005.17452-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member variables of struct qos_tsinfo all cause checkpatch issues
with CamelCase naming. As the variables are used in so few places the
changes are combined into this single patch.

Additionally the member variable usReserved is never used in code so
has been removed.

These are all coding style changes which should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       |  2 +-
 .../staging/rtl8192u/ieee80211/rtl819x_Qos.h  | 20 ++++++++---------
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       | 22 +++++++++----------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 4e8bcc25ad2c..96fab43c1cfe 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -626,7 +626,7 @@ TsInitAddBA(
 	pBA->DialogToken++;						// DialogToken: Only keep the latest dialog token
 	pBA->BaParamSet.field.AMSDU_Support = 0;	// Do not support A-MSDU with A-MPDU now!!
 	pBA->BaParamSet.field.BAPolicy = Policy;	// Policy: Delayed or Immediate
-	pBA->BaParamSet.field.TID = pTS->ts_common_info.t_spec.f.TSInfo.ucTSID;	// TID
+	pBA->BaParamSet.field.TID = pTS->ts_common_info.t_spec.f.TSInfo.uc_tsid;	// TID
 	// BufferSize: This need to be set according to A-MPDU vector
 	pBA->BaParamSet.field.BufferSize = 32;		// BufferSize: This need to be set according to A-MPDU vector
 	pBA->BaTimeoutValue = 0;					// Timeout value: Set 0 to disable Timer
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 4faa89db8355..d36a14197b4c 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -34,16 +34,16 @@ enum direction_value {
  * Note: sizeof 3 Bytes
  */
 struct qos_tsinfo {
-	u16		ucTrafficType:1;	//WMM is reserved
-	u16		ucTSID:4;
-	u16		ucDirection:2;
-	u16		ucAccessPolicy:2;	//WMM: bit8=0, bit7=1
-	u16		ucAggregation:1;	//WMM is reserved
-	u16		ucPSB:1;		//WMMSA is APSD
-	u16		ucUP:3;
-	u16		ucTSInfoAckPolicy:2;	//WMM is reserved
-	u8		ucSchedule:1;		//WMM is reserved
-	u8		ucReserved:7;
+	u16		uc_traffic_type:1;	        //WMM is reserved
+	u16		uc_tsid:4;
+	u16		uc_direction:2;
+	u16		uc_access_policy:2;	        //WMM: bit8=0, bit7=1
+	u16		uc_aggregation:1;	        //WMM is reserved
+	u16		uc_psb:1;		        //WMMSA is APSD
+	u16		uc_up:3;
+	u16		uc_ts_info_ack_policy:2;	//WMM is reserved
+	u8		uc_schedule:1;		        //WMM is reserved
+	u8:7;
 };
 
 //
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 39a074621b3b..076278dae321 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -248,8 +248,8 @@ static struct ts_common_info *SearchAdmitTRStream(struct ieee80211_device *ieee,
 		list_for_each_entry(pRet, psearch_list, list){
 	//		IEEE80211_DEBUG(IEEE80211_DL_TS, "ADD:%pM, TID:%d, dir:%d\n", pRet->Addr, pRet->TSpec.f.TSInfo.ucTSID, pRet->TSpec.f.TSInfo.ucDirection);
 			if (memcmp(pRet->addr, Addr, 6) == 0)
-				if (pRet->t_spec.f.TSInfo.ucTSID == TID)
-					if(pRet->t_spec.f.TSInfo.ucDirection == dir) {
+				if (pRet->t_spec.f.TSInfo.uc_tsid == TID)
+					if(pRet->t_spec.f.TSInfo.uc_direction == dir) {
 	//					printk("Bingo! got it\n");
 						break;
 					}
@@ -383,15 +383,15 @@ bool GetTs(
 
 				IEEE80211_DEBUG(IEEE80211_DL_TS, "to init current TS, UP:%d, Dir:%d, addr:%pM\n", UP, Dir, Addr);
 				// Prepare TS Info releated field
-				pTSInfo->ucTrafficType = 0;		// Traffic type: WMM is reserved in this field
-				pTSInfo->ucTSID = UP;			// TSID
-				pTSInfo->ucDirection = Dir;		// Direction: if there is DirectLink, this need additional consideration.
-				pTSInfo->ucAccessPolicy = 1;		// Access policy
-				pTSInfo->ucAggregation = 0;		// Aggregation
-				pTSInfo->ucPSB = 0;			// Aggregation
-				pTSInfo->ucUP = UP;			// User priority
-				pTSInfo->ucTSInfoAckPolicy = 0;		// Ack policy
-				pTSInfo->ucSchedule = 0;		// Schedule
+				pTSInfo->uc_traffic_type = 0;		// Traffic type: WMM is reserved in this field
+				pTSInfo->uc_tsid = UP;			// TSID
+				pTSInfo->uc_direction = Dir;		// Direction: if there is DirectLink, this need additional consideration.
+				pTSInfo->uc_access_policy = 1;		// Access policy
+				pTSInfo->uc_aggregation = 0;		// Aggregation
+				pTSInfo->uc_psb = 0;			// Aggregation
+				pTSInfo->uc_up = UP;			// User priority
+				pTSInfo->uc_ts_info_ack_policy = 0;	// Ack policy
+				pTSInfo->uc_schedule = 0;		// Schedule
 
 				MakeTSEntry(*ppTS, Addr, &TSpec, NULL, 0, 0);
 				AdmitTS(ieee, *ppTS, 0);
-- 
2.18.0

