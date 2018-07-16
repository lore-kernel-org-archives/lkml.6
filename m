Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A39ECDFB4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC84721480
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkYk0l1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC84721480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbeGPTeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:34:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34846 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbeGPTeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:34:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id b10-v6so30755409edi.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 12:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EKA5l7RKgoukR3AV+EVaGtu6SugmHgklDQvMILuZrvs=;
        b=LkYk0l1n2Aak84r2HlMgsaA6VxP4aUXZeUHymVqlug9L85NbLf+pjLuT9vJXFpVps5
         OkIt9vj5wr2W/XyrNvE9Ey8Qb8GwX/sDa90ldEaRFficFGoWRIjXlcnj16YH4k79mToZ
         wRSqpV+pFXDYMEXdf7kH+ruufXXdgwC7gTJUA6lTDPFDo7eHMTzljbe01Cq3AC6P/hY8
         ozsvQJe0sVuqOp3zJZnJG6HHQPby1OnTyn32u0n0O7HGig6IaXCGP/V/xhNL5pQP0J9q
         RhjVLxfB3ss8pmy7PVchSjnFSkTq0oSPrWVPXNnDF+++XR9SbgM0m3XZ6dfXvC7ChMUK
         62tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EKA5l7RKgoukR3AV+EVaGtu6SugmHgklDQvMILuZrvs=;
        b=U/YgimdHtZFrK4wK8fM8DI+XAEj2bYtkg1zey9GbagxFXP0z+0LZ+MhEw9UBLZosog
         KNDhRU5k04mwAH/mDousxkJnmTHOHx6ZxYMIWCgJhE+qvxh57rigAI17JWaHIkG7uHOA
         a17hnkLcMLSHSV89Lvzqs5ibFisUy+GiFawRK7Kyls/PFPrakc2CDvae4dIBsA+ZAvgp
         Yvk4VFuDgaeMtlBlcHYiUbs9Re5PzWadn22q6/vGRlUE+ddHFHQen/9iJrAdHRtIMMMU
         +4Eh3r90a0QPq990oszH2FsWlHSCfUxwM6efuGpM9dDm+hCQHIR9LWhM8GkfrlwCnZfR
         SHQw==
X-Gm-Message-State: AOUpUlFewdyLCba6Qn5H80m59QpIZBZ2KTs16dNUD4lw/5qysOb9Ezkh
        HG0YeaT7+9M9H0Tj/SUSd0bXeg==
X-Google-Smtp-Source: AAOMgpdU6DPbBJwHOyVswYHSf2Qw6K7p17hfT4I655E3eRxMRBY8IxIsEDMzy01VK01W1SO4QXCI3A==
X-Received: by 2002:a50:9662:: with SMTP id y89-v6mr18822860eda.32.1531767931346;
        Mon, 16 Jul 2018 12:05:31 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.220])
        by smtp.gmail.com with ESMTPSA id g14-v6sm19098643edm.25.2018.07.16.12.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 12:05:30 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 05/10] staging:rtl8192u: Rename InactTimer > inact_timer - Style
Date:   Mon, 16 Jul 2018 20:04:49 +0100
Message-Id: <20180716190454.31489-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716190454.31489-1-johnfwhitmore@gmail.com>
References: <20180716190454.31489-1-johnfwhitmore@gmail.com>
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
index 26384566d4f3..1613c3c5d447 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -18,7 +18,7 @@ enum tr_select {
 struct ts_common_info {
 	struct list_head		list;
 	struct timer_list		setup_timer;
-	struct timer_list		InactTimer;
+	struct timer_list		inact_timer;
 	u8				Addr[6];
 	TSPEC_BODY			TSpec;
 	QOS_TCLAS			TClass[TCLAS_NUM];
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index efe8392043c1..175d91218af8 100644
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
 		    struct ts_common_info *pTsCommonInfo, u32 InactTime)
 {
 	del_timer_sync(&pTsCommonInfo->setup_timer);
-	del_timer_sync(&pTsCommonInfo->InactTimer);
+	del_timer_sync(&pTsCommonInfo->inact_timer);
 
 	if(InactTime!=0)
-		mod_timer(&pTsCommonInfo->InactTimer,
+		mod_timer(&pTsCommonInfo->inact_timer,
 			  jiffies + msecs_to_jiffies(InactTime));
 }
 
@@ -413,7 +413,7 @@ static void RemoveTsEntry(struct ieee80211_device *ieee, struct ts_common_info *
 	//u32 flags = 0;
 	unsigned long flags = 0;
 	del_timer_sync(&pTs->setup_timer);
-	del_timer_sync(&pTs->InactTimer);
+	del_timer_sync(&pTs->inact_timer);
 	TsInitDelBA(ieee, pTs, TxRxSelect);
 
 	if(TxRxSelect == RX_DIR) {
-- 
2.18.0

