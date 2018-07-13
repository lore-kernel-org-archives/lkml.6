Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B897ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C36F208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaMrnN0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C36F208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732829AbeGMU3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:29:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33422 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731974AbeGMU3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:29:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id z6-v6so5300789wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 13:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TDNHAkr/s0q43pThDSUlNaQ+//1nhOhoG+qEgK1Stq8=;
        b=TaMrnN0PMP7kZYwhu7VIYzI2yC8YJoCcWYs1gRd8zX9hv1uCkG4YBc+YuDtw+0W3g9
         Fp3OLE3Y7VyLq8BLSuwG2/H2nLbZNChVT53p3ivv3r5+yGCaYuX+gmAluhjsoYduhja+
         pGDP0PwedRMl+MgJbItgTHMWWjF+H3VldfkvTDouH9dvMI1UKzWTQFl/Yo6QDFgF0/r0
         IOSZj7ynjIiGtrSaxKa62wuIWpVM3CAlMBSQCu3QYj6sCBV2/tAk535wfgRDePBxAnGX
         c0sbSmehCwWdCy6EDOLzGf87IXZi2wA3qjI9nXUogNdqFnzrJNWwqhJA8nJlLvafm8tF
         LYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TDNHAkr/s0q43pThDSUlNaQ+//1nhOhoG+qEgK1Stq8=;
        b=q8qZ6/86Tt4ctUnmek0YmFhNoWd6Zb9OMHTM4mqiBmhPxtpwsR7knjibrvAxTPuqb1
         FSpdry5YLRD5HnYVK+O5Cawe3lkOMiGBRJWLcjw/dye3nhQPLbg5kpD67eEuVDv9UXxi
         rfaaidyt+5vAeFdZWoDgs8qjAhZ32KRPBM8QonyQUf8f3vE8Qd/p5X29iJ7opxu9E7xR
         lm1teWapXbMlQbzy/MjylS8CfOhTP/aw/wMQXM1aFnekcVDVJGcPL3fg2SJJRJ+ljDJZ
         8i8kcEiJhc37NCbIVZL4Jayo8gCuKfiWdWAgQzZccQOyMdiuSM81By4i3qP9maIL0Xfi
         EngQ==
X-Gm-Message-State: AOUpUlHH034A7vEr/ootBamPqNEasDT1/U0JlfGU1C0blRHLjmRzGzd0
        G0lvwnH8bUJTP0s572YrHigQbWH8
X-Google-Smtp-Source: AAOMgpdpmSf9uHYeyt39X+aXT4dpau0UD5HP132/WNloNOWFtoWUqhU5X4pdpnh8veApwuNk/XUQgA==
X-Received: by 2002:a1c:1802:: with SMTP id 2-v6mr4491260wmy.81.1531512810977;
        Fri, 13 Jul 2018 13:13:30 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id f6-v6sm14072677wrp.30.2018.07.13.13.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 13:13:30 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/10] staging:rtl8192u: rename SetupTimer > setup_timer - Style
Date:   Fri, 13 Jul 2018 21:12:41 +0100
Message-Id: <20180713201247.21428-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713201247.21428-1-johnfwhitmore@gmail.com>
References: <20180713201247.21428-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the struct TS_COMMON_INFO member SetupTimer to setup_timer. This
clears the checkpatch issue with CamelCase variable names.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index bf1e01cde407..4601e5fd3e9c 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -17,7 +17,7 @@ enum TR_SELECT {
 
 struct TS_COMMON_INFO {
 	struct list_head		list;
-	struct timer_list		SetupTimer;
+	struct timer_list		setup_timer;
 	struct timer_list		InactTimer;
 	u8				Addr[6];
 	TSPEC_BODY			TSpec;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index cc6fdcb7c5fb..cda20ee023b2 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -146,7 +146,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 		pTxTS->num = count;
 		// The timers for the operation of Traffic Stream and Block Ack.
 		// DLS related timer will be add here in the future!!
-		timer_setup(&pTxTS->TsCommonInfo.SetupTimer, TsSetupTimeOut,
+		timer_setup(&pTxTS->TsCommonInfo.setup_timer, TsSetupTimeOut,
 			    0);
 		timer_setup(&pTxTS->TsCommonInfo.InactTimer, TsInactTimeout,
 			    0);
@@ -167,7 +167,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 	for(count = 0; count < TOTAL_TS_NUM; count++) {
 		pRxTS->num = count;
 		INIT_LIST_HEAD(&pRxTS->RxPendingPktList);
-		timer_setup(&pRxTS->TsCommonInfo.SetupTimer, TsSetupTimeOut,
+		timer_setup(&pRxTS->TsCommonInfo.setup_timer, TsSetupTimeOut,
 			    0);
 		timer_setup(&pRxTS->TsCommonInfo.InactTimer, TsInactTimeout,
 			    0);
@@ -193,7 +193,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 static void AdmitTS(struct ieee80211_device *ieee,
 		    struct TS_COMMON_INFO *pTsCommonInfo, u32 InactTime)
 {
-	del_timer_sync(&pTsCommonInfo->SetupTimer);
+	del_timer_sync(&pTsCommonInfo->setup_timer);
 	del_timer_sync(&pTsCommonInfo->InactTimer);
 
 	if(InactTime!=0)
@@ -412,7 +412,7 @@ static void RemoveTsEntry(struct ieee80211_device *ieee, struct TS_COMMON_INFO *
 {
 	//u32 flags = 0;
 	unsigned long flags = 0;
-	del_timer_sync(&pTs->SetupTimer);
+	del_timer_sync(&pTs->setup_timer);
 	del_timer_sync(&pTs->InactTimer);
 	TsInitDelBA(ieee, pTs, TxRxSelect);
 
-- 
2.18.0

