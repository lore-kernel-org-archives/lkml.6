Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B49AECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFECD2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePKA/yGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFECD2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbeGMU3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:29:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52332 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732598AbeGMU3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:29:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id o11-v6so3921231wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 13:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pIJbMGVi6XFz3ueKvViQahDRcg488MIyZX01Rt7pwG8=;
        b=ePKA/yGKw8YacgJZoTehDiXX/CqaiMQg0z8eIGT0iHa2UkoX6qNB3u0n+gAIPky2V9
         vAfEjHl2tMDHnGS8cUeDM2GQSX5YQ5UQ8wFAOxssdhTCK1VnFe3Lj2ZShafsIx2+96al
         kqvxVk+Knz2y9+hMNqOzfFtRxGt5tu4Vea86Y0u8DW5xCwZ9wUfmqRGAXr+HqjWGIOA1
         f2ASSarv4KujxDcos05WFwtqSMuplfgONSBnbqoUA5SEZV51xvobUxMzQiWn74lOFeFO
         Sf0tVCApbciS9vpvKIip6QlZHnxomwi7O5+Z8l+W5d/mPDO5jjbMfHx0rG2/W65GORjB
         zjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pIJbMGVi6XFz3ueKvViQahDRcg488MIyZX01Rt7pwG8=;
        b=BTm4gqhe8Hz+bLCrEvHyO19Rf1k4ReVu7Zy9f9mTOVJROb3Jl7Qnk9427NETlPy0es
         7PgFY4u5WKaJ+bT8AKki4PlLu+sKHs831ui0GrQm5KhUjP+cwxMTeVWUlAZckfmmHrHl
         GVFOXKbJMkQPKJ47DiIb+o4KXDEVBvs95d/asdaySLfa/0SnRLMEvyaordFEuqNupCFR
         GUGOFlDvg5KSpfPXdG7RTrvZQoM81n8gLzKViZBeYdeTfH5sCC91rspuH6TZS6DnJ4QB
         Q6yDlrznRXcD/M54WIyhicQrqtcWM/O9FtZFJZZaxAAL0C8l2dBE3WqFbGBzqCPYZ8wR
         ccOA==
X-Gm-Message-State: AOUpUlFB8WH7qyMMEP2vZEo84M3MvyWl/DYXhq0UZOMRgp2dfStYO4XH
        SYbtrmkxDY5ywzUkeRhWLW25YrY+
X-Google-Smtp-Source: AAOMgpdt0Q1mYmlJPhTDaSox2kxq7soxg/FD04PfjV1s8jKe9Nal26TG2mDshYykMKtJsNLnGrPWfw==
X-Received: by 2002:a1c:d0ce:: with SMTP id h197-v6mr4495887wmg.43.1531512812585;
        Fri, 13 Jul 2018 13:13:32 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id f6-v6sm14072677wrp.30.2018.07.13.13.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 13:13:31 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/10] staging:rtl8192u: Rename InactTimer > inact_timer - Style
Date:   Fri, 13 Jul 2018 21:12:42 +0100
Message-Id: <20180713201247.21428-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713201247.21428-1-johnfwhitmore@gmail.com>
References: <20180713201247.21428-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the struct TS_COMMON_INFO member InactTimer to inact_timer.
This change clears the checkpatch issue with CamelCase naming. The change
should not have any impact on runtime execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 4601e5fd3e9c..9c0998db220f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -18,7 +18,7 @@ enum TR_SELECT {
 struct TS_COMMON_INFO {
 	struct list_head		list;
 	struct timer_list		setup_timer;
-	struct timer_list		InactTimer;
+	struct timer_list		inact_timer;
 	u8				Addr[6];
 	TSPEC_BODY			TSpec;
 	QOS_TCLAS			TClass[TCLAS_NUM];
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index cda20ee023b2..04cc101f680e 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -148,7 +148,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 		// DLS related timer will be add here in the future!!
 		timer_setup(&pTxTS->TsCommonInfo.setup_timer, TsSetupTimeOut,
 			    0);
-		timer_setup(&pTxTS->TsCommonInfo.InactTimer, TsInactTimeout,
+		timer_setup(&pTxTS->TsCommonInfo.inact_timer, TsInactTimeout,
 			    0);
 		timer_setup(&pTxTS->TsAddBaTimer, TsAddBaProcess, 0);
 		timer_setup(&pTxTS->TxPendingBARecord.Timer, BaSetupTimeOut,
@@ -169,7 +169,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 		INIT_LIST_HEAD(&pRxTS->RxPendingPktList);
 		timer_setup(&pRxTS->TsCommonInfo.setup_timer, TsSetupTimeOut,
 			    0);
-		timer_setup(&pRxTS->TsCommonInfo.InactTimer, TsInactTimeout,
+		timer_setup(&pRxTS->TsCommonInfo.inact_timer, TsInactTimeout,
 			    0);
 		timer_setup(&pRxTS->RxAdmittedBARecord.Timer,
 			    RxBaInactTimeout, 0);
@@ -194,10 +194,10 @@ static void AdmitTS(struct ieee80211_device *ieee,
 		    struct TS_COMMON_INFO *pTsCommonInfo, u32 InactTime)
 {
 	del_timer_sync(&pTsCommonInfo->setup_timer);
-	del_timer_sync(&pTsCommonInfo->InactTimer);
+	del_timer_sync(&pTsCommonInfo->inact_timer);
 
 	if(InactTime!=0)
-		mod_timer(&pTsCommonInfo->InactTimer,
+		mod_timer(&pTsCommonInfo->inact_timer,
 			  jiffies + msecs_to_jiffies(InactTime));
 }
 
@@ -413,7 +413,7 @@ static void RemoveTsEntry(struct ieee80211_device *ieee, struct TS_COMMON_INFO *
 	//u32 flags = 0;
 	unsigned long flags = 0;
 	del_timer_sync(&pTs->setup_timer);
-	del_timer_sync(&pTs->InactTimer);
+	del_timer_sync(&pTs->inact_timer);
 	TsInitDelBA(ieee, pTs, TxRxSelect);
 
 	if(TxRxSelect == RX_DIR) {
-- 
2.18.0

