Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703DDC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9C5208B9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOO9yRaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9C5208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389231AbeG0Syq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:54:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39783 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389161AbeG0Syq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so6258906wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kif7pAaxwph1Eo0fHFWpgYULBiZ55JMRwOR3Ti+GniU=;
        b=jOO9yRaAEutqgJXtvxwjd9SxtwV+GlBHvtskJ/EaX8IajVyZ5UNr2T3S7CbTjoMrX0
         TrW73zKqjc3vuuuDKt9JYLbZdL9d/M3TK/NnC8/GlaCDZUDxTusRPXKNIcVIMEG00HI1
         m/ijzNZCn5rFLKXji+xFuamtb7Jtxa5SXjqdrP2Ru6LjmHyD/lpqUwMKIicDiM5dd298
         JpHzVX26Loc4fZsWi0zyKXjlLF4fL8/9aFx8MdUT4v6Ucwvupej2B2G4xDTBSszGRYsO
         vGqR+EBSXWXJx84evtw24Mrn6KAGtitAGaZ7HDJSqQCV91laTB7UWPXGr08r2hIgzcoj
         98KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kif7pAaxwph1Eo0fHFWpgYULBiZ55JMRwOR3Ti+GniU=;
        b=lnl7znXqry8G9D/fTfyQID8Jk68U67jcOIgT4lbIeV0TiJwRW+zKrW2/8Rl9WGKw8/
         XVnSs4R0mncfodFXbIhjBShv3T0TkzC/UeV3wGB8TVTAiGgkjfU0AwUMNNiN6ar4KRWQ
         7qVg8ZHRZtJFeT9WVfV/2tZ3/Pngs+MSGUuzDR+xx5HYd0/TNiGZPels97pJcvYFzghF
         UJX6Fc2O1BlfxsWzsHzd88Sxm1dAhDbDtSqSFnPdUN7d1fTbm41SE4Lb1w3Ykm0LbhCn
         MuwlC2D3xUCF+rzDYd1PguDbztCgP68c4ohs2wk1aIaxRRXsDCDVzYY8EH4aKT+h6Txi
         BdcQ==
X-Gm-Message-State: AOUpUlFGprpnNCRHskIH4EclBYwu/Dlch7n3fWYnlcMkPMwb80yL66fP
        M19D+PH1cTkPaTTf2DtFHiHNWTLY3ZA=
X-Google-Smtp-Source: AAOMgpc+0P8/jNt8VlMpETvaf5vRVKE/V2PwmoAQFVXWKvq3M6aM0Lt8o1X8Dx1HRawL+PzSysPTZw==
X-Received: by 2002:a1c:e54:: with SMTP id 81-v6mr5336965wmo.84.1532712712231;
        Fri, 27 Jul 2018 10:31:52 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:31:51 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 09/20] staging:rtl8192u: Rename TsAddBaTimer - Style
Date:   Fri, 27 Jul 2018 18:31:12 +0100
Message-Id: <20180727173123.27391-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727173123.27391-1-johnfwhitmore@gmail.com>
References: <20180727173123.27391-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable TsAddBaTimer to ts_add_ba_timer. This change
clears the checkpatch issue with CamelCase naming.

The resulting changes are coding style in nature and as such should not
have any impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c |  4 ++--
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 7bd2d0fb2ebb..01bf9f3488ab 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -597,8 +597,8 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb)
 		pTxTs->using_ba = false;
 		pTxTs->add_ba_req_in_progress = false;
 		pTxTs->add_ba_req_delayed = false;
-		del_timer_sync(&pTxTs->TsAddBaTimer);
-		//PlatformCancelTimer(Adapter, &pTxTs->TsAddBaTimer);
+		del_timer_sync(&pTxTs->ts_add_ba_timer);
+		//PlatformCancelTimer(Adapter, &pTxTs->ts_add_ba_timer);
 		TxTsDeleteBA(ieee, pTxTs);
 	}
 	return 0;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 4cb53c75f438..b878ff5f7d0f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -35,7 +35,7 @@ struct tx_ts_record {
 	u8				add_ba_req_in_progress;
 	u8				add_ba_req_delayed;
 	u8				using_ba;
-	struct timer_list		TsAddBaTimer;
+	struct timer_list		ts_add_ba_timer;
 	u8				num;
 };
 
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 09fb339203aa..399e97ce62b4 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -92,7 +92,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
  ********************************************************************************************************************/
 static void TsAddBaProcess(struct timer_list *t)
 {
-	struct tx_ts_record *pTxTs = from_timer(pTxTs, t, TsAddBaTimer);
+	struct tx_ts_record *pTxTs = from_timer(pTxTs, t, ts_add_ba_timer);
 	u8 num = pTxTs->num;
 	struct ieee80211_device *ieee = container_of(pTxTs, struct ieee80211_device, TxTsRecord[num]);
 
@@ -150,7 +150,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 			    0);
 		timer_setup(&pTxTS->ts_common_info.inact_timer, TsInactTimeout,
 			    0);
-		timer_setup(&pTxTS->TsAddBaTimer, TsAddBaProcess, 0);
+		timer_setup(&pTxTS->ts_add_ba_timer, TsAddBaProcess, 0);
 		timer_setup(&pTxTS->tx_pending_ba_record.Timer, BaSetupTimeOut,
 			    0);
 		timer_setup(&pTxTS->tx_admitted_ba_record.Timer,
@@ -448,7 +448,7 @@ static void RemoveTsEntry(struct ieee80211_device *ieee, struct ts_common_info *
 //#endif
 	} else {
 		struct tx_ts_record *pTxTS = (struct tx_ts_record *)pTs;
-		del_timer_sync(&pTxTS->TsAddBaTimer);
+		del_timer_sync(&pTxTS->ts_add_ba_timer);
 	}
 }
 
@@ -526,11 +526,11 @@ void TsStartAddBaProcess(struct ieee80211_device *ieee, struct tx_ts_record *pTx
 		pTxTS->add_ba_req_in_progress = true;
 		if(pTxTS->add_ba_req_delayed)	{
 			IEEE80211_DEBUG(IEEE80211_DL_BA, "TsStartAddBaProcess(): Delayed Start ADDBA after 60 sec!!\n");
-			mod_timer(&pTxTS->TsAddBaTimer,
+			mod_timer(&pTxTS->ts_add_ba_timer,
 				  jiffies + msecs_to_jiffies(TS_ADDBA_DELAY));
 		} else {
 			IEEE80211_DEBUG(IEEE80211_DL_BA,"TsStartAddBaProcess(): Immediately Start ADDBA now!!\n");
-			mod_timer(&pTxTS->TsAddBaTimer, jiffies+10); //set 10 ticks
+			mod_timer(&pTxTS->ts_add_ba_timer, jiffies+10); //set 10 ticks
 		}
 	} else {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "%s()==>BA timer is already added\n", __func__);
-- 
2.18.0

