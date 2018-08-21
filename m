Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1A8C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F49321837
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCFzkXaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F49321837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeHUUhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:37:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37762 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeHUUhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:37:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so3527024wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+v3RZZcADke3FZgn0buvPXW0+ejiY3WlYPCa2us/30U=;
        b=lCFzkXaAG2wDJjRI7f8TkFHvYZrQ6cOavIdwvdUBjZNOif93KnO7swxxaJSApVoIwG
         wPEXPcwDv3PQR32fMycMsCEbU+qpoG2JUNvG2bkzqZWxxijljrVvH0TTjigyJVRaJSGs
         LohoRpQ1fn7JP3JI7wV2It9l07e6cCLVGR9JiBb7REjMKzUss5UvvM5VL9fp72k6dDJo
         TsGVMpnvblQn5q7uWuISwYNb3+AYqLtZWfh+MXpwd9mJH2fmFcUe00JgEOesIyAbvUX/
         HVLCjSO1Eok68VHpZWTeIxCH9sM+qHuUZLT28R2JaxMfkZ71ds/LIG/SvIJKLVYEOTtg
         htMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+v3RZZcADke3FZgn0buvPXW0+ejiY3WlYPCa2us/30U=;
        b=N5ZuoW3sVGxe8YtJT2PetWpRTLPyELOFVRB/3gj0e+bmpOZMAqYxoUE0sQZOlOAjL8
         CyO3O7WpqmAP3D43jm1mpTds/zqL95w2rBLRbP0H4NGITEmHXqoN9ZR8hHoALCsXGiOZ
         QNfAftPo/dl8whtywONdHXAivc4oOdUf8peri6L9Ol39yAZaJaNlH8V3heoC5Ntv7AgP
         P3VXhjoRabkKj4Bu4hqKosMu37r/fD6ed6TJufYrBg7DyMQYO4lqMyvUq+iyl2avRTqw
         eHDk1lmeLqxOA3lvrEGq57QImW/XLZkmphutpJldTb0N5OuiE5/e/UYPamOfCjXFKjC3
         qrKQ==
X-Gm-Message-State: APzg51AixJ4Y8VK64WuahIB183jg6XKEp0SGduYTHpqaYVyVIxcbH+Vn
        +OhFubnxM4/uQ30wnDuLwM99NXHqpJg=
X-Google-Smtp-Source: ANB0VdZ3be5LTET8dqXuzHH7ApqVknvtZx9ZXSoTeuhWT3XUl8WBelpvBi5zDFJiLBTxtu97W05SXQ==
X-Received: by 2002:a1c:adca:: with SMTP id w193-v6mr146636wme.147.1534871757754;
        Tue, 21 Aug 2018 10:15:57 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 88-v6sm7564292wrf.95.2018.08.21.10.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:15:56 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 11/17] staging:rtl8192u: Rename member variable Timer - Style
Date:   Tue, 21 Aug 2018 18:15:31 +0100
Message-Id: <20180821171537.9330-12-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821171537.9330-1-johnfwhitmore@gmail.com>
References: <20180821171537.9330-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable Timer to all lowercase to clear the
checkpatch issue with CamelCase naming.

This change is purely a coding style change which should have no impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h     |  2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 10 +++++-----
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c |  6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
index b1697cb483ff..a36e8ecc6c59 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
@@ -50,7 +50,7 @@ union delba_param_set {
 };
 
 struct ba_record {
-	struct timer_list		Timer;
+	struct timer_list		timer;
 	u8				bValid;
 	u8				DialogToken;
 	union ba_param_set		BaParamSet;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index cb84335468ab..3e88333688ea 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -20,7 +20,7 @@ static void ActivateBAEntry(struct ieee80211_device *ieee, struct ba_record *pBA
 {
 	pBA->bValid = true;
 	if (Time != 0)
-		mod_timer(&pBA->Timer, jiffies + msecs_to_jiffies(Time));
+		mod_timer(&pBA->timer, jiffies + msecs_to_jiffies(Time));
 }
 
 /********************************************************************************************************************
@@ -31,7 +31,7 @@ static void ActivateBAEntry(struct ieee80211_device *ieee, struct ba_record *pBA
 static void DeActivateBAEntry(struct ieee80211_device *ieee, struct ba_record *pBA)
 {
 	pBA->bValid = false;
-	del_timer_sync(&pBA->Timer);
+	del_timer_sync(&pBA->timer);
 }
 /********************************************************************************************************************
  *function: deactivete BA entry in Tx Ts, and send DELBA.
@@ -669,7 +669,7 @@ TsInitDelBA(struct ieee80211_device *ieee, struct ts_common_info *pTsCommonInfo,
  ********************************************************************************************************************/
 void BaSetupTimeOut(struct timer_list *t)
 {
-	struct tx_ts_record *pTxTs = from_timer(pTxTs, t, tx_pending_ba_record.Timer);
+	struct tx_ts_record *pTxTs = from_timer(pTxTs, t, tx_pending_ba_record.timer);
 
 	pTxTs->add_ba_req_in_progress = false;
 	pTxTs->add_ba_req_delayed = true;
@@ -678,7 +678,7 @@ void BaSetupTimeOut(struct timer_list *t)
 
 void TxBaInactTimeout(struct timer_list *t)
 {
-	struct tx_ts_record *pTxTs = from_timer(pTxTs, t, tx_admitted_ba_record.Timer);
+	struct tx_ts_record *pTxTs = from_timer(pTxTs, t, tx_admitted_ba_record.timer);
 	struct ieee80211_device *ieee = container_of(pTxTs, struct ieee80211_device, TxTsRecord[pTxTs->num]);
 	TxTsDeleteBA(ieee, pTxTs);
 	ieee80211_send_DELBA(
@@ -691,7 +691,7 @@ void TxBaInactTimeout(struct timer_list *t)
 
 void RxBaInactTimeout(struct timer_list *t)
 {
-	struct rx_ts_record *pRxTs = from_timer(pRxTs, t, rx_admitted_ba_record.Timer);
+	struct rx_ts_record *pRxTs = from_timer(pRxTs, t, rx_admitted_ba_record.timer);
 	struct ieee80211_device *ieee = container_of(pRxTs, struct ieee80211_device, RxTsRecord[pRxTs->num]);
 
 	RxTsDeleteBA(ieee, pRxTs);
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index d46d8f468671..317d275edeb0 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -151,9 +151,9 @@ void TSInitialize(struct ieee80211_device *ieee)
 		timer_setup(&pTxTS->ts_common_info.inact_timer, TsInactTimeout,
 			    0);
 		timer_setup(&pTxTS->ts_add_ba_timer, TsAddBaProcess, 0);
-		timer_setup(&pTxTS->tx_pending_ba_record.Timer, BaSetupTimeOut,
+		timer_setup(&pTxTS->tx_pending_ba_record.timer, BaSetupTimeOut,
 			    0);
-		timer_setup(&pTxTS->tx_admitted_ba_record.Timer,
+		timer_setup(&pTxTS->tx_admitted_ba_record.timer,
 			    TxBaInactTimeout, 0);
 		ResetTxTsEntry(pTxTS);
 		list_add_tail(&pTxTS->ts_common_info.list, &ieee->Tx_TS_Unused_List);
@@ -171,7 +171,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 			    0);
 		timer_setup(&pRxTS->ts_common_info.inact_timer, TsInactTimeout,
 			    0);
-		timer_setup(&pRxTS->rx_admitted_ba_record.Timer,
+		timer_setup(&pRxTS->rx_admitted_ba_record.timer,
 			    RxBaInactTimeout, 0);
 		timer_setup(&pRxTS->rx_pkt_pending_timer, RxPktPendingTimeout, 0);
 		ResetRxTsEntry(pRxTS);
-- 
2.18.0

