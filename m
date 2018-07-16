Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6892ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A210208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOEMlAr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A210208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbeGPTeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:34:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:47043 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbeGPTeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:34:21 -0400
Received: by mail-ed1-f68.google.com with SMTP id o8-v6so3244792edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 12:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gcBuwqWSP6+vFYumXh7M1ZPwXkow5LaKmJDCOnDhMVA=;
        b=dOEMlAr+JLl0ia6mIseWzHEqz1CE26rGbfjbGJjh4vGSQlGhqCcW0pqILbORXlbiVc
         Gwy2lXr9g+W7+B4m03BaMqq6PiFl1FQkAAycBpTzN0hPl6tqJJMy93zINRcMTXCbCbZ9
         H3JAvsXH6AeOu3Fh+rxQ5q+VfvpLG/ggINVl+2VjaEJ5TrBAP+oxm974poUELkW/0xEd
         LQHOeT02Ij4lKM2NwVJV4yWCANFNL8iwN1qXjtBZopbu9nhT1QwfFFva3w8UcXAwmiKK
         XVOTSmHkE/2K4GGt0jScz5h3DIRj49zTEL0wSwzfIaRLfw4V9klOk2U9M3OPeNW0mg63
         1qGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gcBuwqWSP6+vFYumXh7M1ZPwXkow5LaKmJDCOnDhMVA=;
        b=HsBuIe525PWfRUvFr4CzUlkiyU+B5h+oR+64dBuvfduUGaVmY3lG+JGI8c2JvA7dET
         jChL9dBr8Q4ocWDCQPpjz9QouL0yWguLSxliKvty5R8PH7j46FqUTwB85UicTr1nfSpq
         EDKm5Nm6KksIfIpmS1aj42+4dbBfeQFJqQKMySi/xQKywSFEAHfec90qWE7O7AD25/R7
         VLlRKwAK9Mk9H/KC52H1bJ7Mp2OmiPPz+B4MwvUkBnTrRniwd/0+0cnremZyRdIXrNks
         PwDr9RuwW+V2PH9+4PRmHE+k0NNRfFymv5CO4HgyloozmPI28LgibV57tIOMd955Hxrz
         U+6g==
X-Gm-Message-State: AOUpUlGK4unD2v2WC8cBSGrtjnU55Im/9Cla+T8nPTWVl5iQaLietUTB
        Mip/dJS/cF0V056DRk2pW2Z/bw==
X-Google-Smtp-Source: AAOMgpfan9773YNUa8rb05CCllo07VHdYYz8FTAaSNyx7Be9pcWLNJFJWipbQj83/o7JkJgvUqPEXg==
X-Received: by 2002:a50:8367:: with SMTP id 94-v6mr17876517edh.5.1531767934417;
        Mon, 16 Jul 2018 12:05:34 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.220])
        by smtp.gmail.com with ESMTPSA id g14-v6sm19098643edm.25.2018.07.16.12.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 12:05:33 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 07/10] staging:rtl8192u: Rename TSpec > t_spec - Style
Date:   Mon, 16 Jul 2018 20:04:51 +0100
Message-Id: <20180716190454.31489-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716190454.31489-1-johnfwhitmore@gmail.com>
References: <20180716190454.31489-1-johnfwhitmore@gmail.com>
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
index 297c498aef6a..2c7d3ab1b5f7 100644
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
index 62c6fc513540..4c1b2e27cf94 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -20,7 +20,7 @@ struct ts_common_info {
 	struct timer_list		setup_timer;
 	struct timer_list		inact_timer;
 	u8				addr[6];
-	TSPEC_BODY			TSpec;
+	TSPEC_BODY			t_spec;
 	QOS_TCLAS			TClass[TCLAS_NUM];
 	u8				TClasProc;
 	u8				TClasNum;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 72a5fc0bbb47..f9f4196f43fa 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -104,7 +104,7 @@ static void TsAddBaProcess(struct timer_list *t)
 static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
 {
 	eth_zero_addr(pTsCommonInfo->addr);
-	memset(&pTsCommonInfo->TSpec, 0, sizeof(TSPEC_BODY));
+	memset(&pTsCommonInfo->t_spec, 0, sizeof(TSPEC_BODY));
 	memset(&pTsCommonInfo->TClass, 0, sizeof(QOS_TCLAS)*TCLAS_NUM);
 	pTsCommonInfo->TClasProc = 0;
 	pTsCommonInfo->TClasNum = 0;
@@ -248,8 +248,8 @@ static struct ts_common_info *SearchAdmitTRStream(struct ieee80211_device *ieee,
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
@@ -276,7 +276,7 @@ static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *Addr,
 	memcpy(pTsCommonInfo->addr, Addr, 6);
 
 	if(pTSPEC != NULL)
-		memcpy((u8 *)(&(pTsCommonInfo->TSpec)), (u8 *)pTSPEC, sizeof(TSPEC_BODY));
+		memcpy((u8 *)(&(pTsCommonInfo->t_spec)), (u8 *)pTSPEC, sizeof(TSPEC_BODY));
 
 	for(count = 0; count < TCLAS_Num; count++)
 		memcpy((u8 *)(&(pTsCommonInfo->TClass[count])), (u8 *)pTCLAS, sizeof(QOS_TCLAS));
-- 
2.18.0

