Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0139C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CF820841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFTejWRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CF820841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbeGaWmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:42:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39631 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732355AbeGaWmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:42:49 -0400
Received: by mail-ed1-f65.google.com with SMTP id h4-v6so5851122edi.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=41k4OU9f4Xo9xpA+i0Focu67RSwUbTbTivtVuGpJxw4=;
        b=bFTejWRVKO0tAGf9hZIEwm8h4vD9OqzCNXidRQT/CViTWGExyKtqhPVXdk2el1iiW9
         ZfJzH4J3njinNnQTJTU0cmwKsOwwIckEKQdALcp39tmQryJA1H9moRHBl8hiISRMIRAw
         fI9WQjTbwDjrtQb3rj7rovR/NHrX/Fris0nTjIgho/pIT7/cwKiy8ef0eUfYf/KmDWd/
         ctF6cA78PJIEayakoDYjDweECbxXjBhLcfx7oM1xY8o5/Nhw2W7s+UvgVBObt40IVLpQ
         J4UlO5iRMzUuffTSp9tT0wq/CermF3BKUdjtU89kHYNozo45zoNOr1CEFw55Ap0vqJ86
         nf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=41k4OU9f4Xo9xpA+i0Focu67RSwUbTbTivtVuGpJxw4=;
        b=clC4rT1UgWZdFIg3jfVUkr+mqWRSnJRSqm3ImY2TT1E9WGmsWgYew05bNw4io8oNwX
         BBq/FEF8KGfxKylEfjQaZl/GUY0+qsHMnaH4c4kB0ZbkK+uRoEqDNFjXFSGHO41ZZdRd
         /n5/qx4z0XnBAvdFDczdKIie03KsscA2csVblunzUeO15zyLTPEEuu3X7eeCLupf07sW
         QRx+TbJm6jWpkShId5XDAgCmP8xNd2M1rvXA65yL9dbR4auKFzkC6DHswX78rucKzLq0
         bO+NAETkDkMFX//iHE5Sc2PDlQ2fxXfC/AKatB45s/QAu0DKbN2bM3DIYrpNpsDqBn+r
         LDwg==
X-Gm-Message-State: AOUpUlFn2aIf2Br9nvXDgD/dcwTrWqG8eP5iLHI7x1/IIYpaO/Z7rgTw
        IyvBVuo2LPIauklphOYkX5i5dMWJ
X-Google-Smtp-Source: AAOMgpeemB6mL6sf7eNmq9VNeVYoD9TlUAJmip8whGtSIaRtuxxKcLRraCw9yymnEXfEezhIgoSPTQ==
X-Received: by 2002:a50:d59d:: with SMTP id v29-v6mr1095678edi.307.1533070837845;
        Tue, 31 Jul 2018 14:00:37 -0700 (PDT)
Received: from localhost.localdomain ([109.77.253.253])
        by smtp.gmail.com with ESMTPSA id j42-v6sm4143373eda.2.2018.07.31.14.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 14:00:37 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/14] staging:rtl8192u: Rename TSInfo - Style
Date:   Tue, 31 Jul 2018 21:59:57 +0100
Message-Id: <20180731210005.17452-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731210005.17452-1-johnfwhitmore@gmail.com>
References: <20180731210005.17452-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename TSInfo, the memeber variable of struct tspec_body to ts_info.
This change clears the checkpatch issue with CamelCase naming.

This is a coding style change which should not impact runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h    | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index d35f10c695e4..01b631c2a180 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -626,7 +626,7 @@ TsInitAddBA(
 	pBA->DialogToken++;						// DialogToken: Only keep the latest dialog token
 	pBA->BaParamSet.field.AMSDU_Support = 0;	// Do not support A-MSDU with A-MPDU now!!
 	pBA->BaParamSet.field.BAPolicy = Policy;	// Policy: Delayed or Immediate
-	pBA->BaParamSet.field.TID = pTS->ts_common_info.t_spec.TSInfo.uc_tsid;	// TID
+	pBA->BaParamSet.field.TID = pTS->ts_common_info.t_spec.ts_info.uc_tsid;	// TID
 	// BufferSize: This need to be set according to A-MPDU vector
 	pBA->BaParamSet.field.BufferSize = 32;		// BufferSize: This need to be set according to A-MPDU vector
 	pBA->BaTimeoutValue = 0;					// Timeout value: Set 0 to disable Timer
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index a4cecf4cc756..db0392cfd6d4 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -52,7 +52,7 @@ struct qos_tsinfo {
  * Note: sizeof 55 bytes
  */
 struct tspec_body {
-	struct qos_tsinfo	TSInfo;	//u8	TSInfo[3];
+	struct qos_tsinfo	ts_info;	//u8	TSInfo[3];
 	u16	NominalMSDUsize;
 	u16	MaxMSDUsize;
 	u32	MinServiceItv;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index bd2b4e5dfa60..e0ccabadec22 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -246,10 +246,10 @@ static struct ts_common_info *SearchAdmitTRStream(struct ieee80211_device *ieee,
 		if (!search_dir[dir])
 			continue;
 		list_for_each_entry(pRet, psearch_list, list){
-	//		IEEE80211_DEBUG(IEEE80211_DL_TS, "ADD:%pM, TID:%d, dir:%d\n", pRet->Addr, pRet->TSpec.TSInfo.ucTSID, pRet->TSpec.TSInfo.ucDirection);
+	//		IEEE80211_DEBUG(IEEE80211_DL_TS, "ADD:%pM, TID:%d, dir:%d\n", pRet->Addr, pRet->TSpec.ts_info.ucTSID, pRet->TSpec.ts_info.ucDirection);
 			if (memcmp(pRet->addr, Addr, 6) == 0)
-				if (pRet->t_spec.TSInfo.uc_tsid == TID)
-					if(pRet->t_spec.TSInfo.uc_direction == dir) {
+				if (pRet->t_spec.ts_info.uc_tsid == TID)
+					if(pRet->t_spec.ts_info.uc_direction == dir) {
 	//					printk("Bingo! got it\n");
 						break;
 					}
@@ -355,7 +355,7 @@ bool GetTs(
 			// For HCCA or WMMSA, TS cannot be addmit without negotiation.
 			//
 			struct tspec_body	TSpec;
-			struct qos_tsinfo	*pTSInfo = &TSpec.TSInfo;
+			struct qos_tsinfo	*pTSInfo = &TSpec.ts_info;
 			struct list_head	*pUnusedList =
 								(TxRxSelect == TX_DIR)?
 								(&ieee->Tx_TS_Unused_List):
-- 
2.18.0

