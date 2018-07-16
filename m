Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E640ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADCF208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNbgNL37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADCF208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbeGPTeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:34:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39086 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbeGPTeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:34:17 -0400
Received: by mail-ed1-f67.google.com with SMTP id w14-v6so30761225eds.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 12:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m8WHhBVEoUoJt521U03ig4Ozuw1ODsMW1K6rkzMJBJ4=;
        b=mNbgNL37gytNICC+dm0g5zn7Uh6HV9B90Q4wlMWcOQJTeVgF5PrG9Al1ThjcAuNVYu
         LzLMGh2KfPW3jmCkS8NGQ1YRTxsgqBtaBwHngHrOdT5lH+9bxOAapOHkMGY52tx9RTf4
         dJkBXiq6sTgKcYPtDrO2NtponxWs+X0VrcUkVnPeyuR6zuAHsvR48Bne+6VyCF/BAzMT
         rPGLfll9/24Z9ds89nPwVwTCcQN8UDdYlnUa7XdZkXg8OvFR48V6OqDq+Fyz5Nq08peC
         0Mgyeu6BtvfIpwy/eSRHsNrrM6EbovHdWNh5RLe46Kntfp8I9WVBu76mFH+cKxpnc4Hv
         xfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m8WHhBVEoUoJt521U03ig4Ozuw1ODsMW1K6rkzMJBJ4=;
        b=IX6Yg+fq0m56ochLDfqy8lFNAvopFokB0MYlcAhW2MSfMp6GwD0fowJ7jfwWLzdNPl
         dr1HpTJqnuOwMpxSlq8msDYmC70VzqKbk3DgFYyyypyRoYGmXFhvyNJY1Q64NAO1HGlc
         Vv3oNpO2JhFWyjRJdSuYR8RxPWfZIE0JXJFXFg3D+frYLlmg0XYFbllhGtTFLKoL7HY3
         4Ee+7oxEQw+EeTNr9mJ7BEK6KYJ29j1f1ZbO8M59haXTw8MZbLUXlKkodDbQjGfjxgzb
         B8SJyD61a/N/meD+cbY5P1XcNXqBPgMgqNbwqCF8vol63BpjQBW4I9xWV8NXifNBfddW
         TzLQ==
X-Gm-Message-State: AOUpUlEd6D0VsVUaGBZCcO4oi1m7JE8W+elV0dhrwG6ZWmK4vuQ9AbW6
        Oy0qezYsSsLfpxCZm0KuaMFLrg==
X-Google-Smtp-Source: AAOMgpe3NZYr4374z28gqsuAPUfZSNCpwzI0xwNATyrJGfQGlCdJBWSYrbSHV/w01F2pt3t71frZdA==
X-Received: by 2002:a50:ed09:: with SMTP id j9-v6mr17831342eds.28.1531767929883;
        Mon, 16 Jul 2018 12:05:29 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.220])
        by smtp.gmail.com with ESMTPSA id g14-v6sm19098643edm.25.2018.07.16.12.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 12:05:29 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 04/10] staging:rtl8192u: rename SetupTimer > setup_timer - Style
Date:   Mon, 16 Jul 2018 20:04:48 +0100
Message-Id: <20180716190454.31489-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716190454.31489-1-johnfwhitmore@gmail.com>
References: <20180716190454.31489-1-johnfwhitmore@gmail.com>
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
index 0a0420aa91cf..26384566d4f3 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -17,7 +17,7 @@ enum tr_select {
 
 struct ts_common_info {
 	struct list_head		list;
-	struct timer_list		SetupTimer;
+	struct timer_list		setup_timer;
 	struct timer_list		InactTimer;
 	u8				Addr[6];
 	TSPEC_BODY			TSpec;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 24abdad52ed6..efe8392043c1 100644
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
 		    struct ts_common_info *pTsCommonInfo, u32 InactTime)
 {
-	del_timer_sync(&pTsCommonInfo->SetupTimer);
+	del_timer_sync(&pTsCommonInfo->setup_timer);
 	del_timer_sync(&pTsCommonInfo->InactTimer);
 
 	if(InactTime!=0)
@@ -412,7 +412,7 @@ static void RemoveTsEntry(struct ieee80211_device *ieee, struct ts_common_info *
 {
 	//u32 flags = 0;
 	unsigned long flags = 0;
-	del_timer_sync(&pTs->SetupTimer);
+	del_timer_sync(&pTs->setup_timer);
 	del_timer_sync(&pTs->InactTimer);
 	TsInitDelBA(ieee, pTs, TxRxSelect);
 
-- 
2.18.0

