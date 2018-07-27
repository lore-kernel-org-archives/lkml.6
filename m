Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E36DC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5587520862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1u1W1Lk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5587520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389458AbeG0TAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 15:00:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35544 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389182AbeG0Syp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so6334346wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EgK6N/suRl41YvBH3TraRIHSKJEog8TTZhKrKCSc/CM=;
        b=e1u1W1Lk7p47cSY00v0l5WKnxQAG5YHWwYJL+bLE5PXbgGq2D+L+YdnAMwcvANX2wQ
         QejelaV/rrKR6SxAp0CcFUHV/XfxxC1NIFPi6yE0+YwW65ffayV5pURPT1WtRIydnE66
         AdXpckq+GFJ8UvxenoXkBsJFrR/PxOLEgITPF88IsfTQwPWnr7Nlflaq8I43ai8X6bHc
         ly74XgTICtLAcuEAl1eqqGvuCA/wPHuRtU6nnlJgQz1bBU/eEJospjQwOZekY5cmxXrM
         mZonmcPz88NYSjo78Cv5XF0/uG3vzMCK/Hm0ngQaCZrYxi2KeBBaryydhxmYQ91K/B6Q
         FhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EgK6N/suRl41YvBH3TraRIHSKJEog8TTZhKrKCSc/CM=;
        b=PR3h4b2AlEM4lKK7oSy20mS2q/V8WughVE2QQ4260VXzB8s7dVKGxXJ2fwGCNelRnG
         P0qLw7U4Q0CcYpxvzRChyBdIxOSMZt5kB1g5h8YMfhWr89UNjQOhDERWD3hPb084Fdnl
         nqwupslCGUe2AVvfHlSNzMuxxFJnzFwkHSTiqIbYA7DDEwZpAa69RLzlPDqczbjU24W1
         aXNG3XvUKr9IndKLSrGyukBoFDiMIrEuSyO3NmY0z7vT8n6vUnOuKe+KXeG9v19dJ9VL
         5EGEiWEWm0TLU0sZdaHe8h/mG6Nk+G7sJ8OE7P0HjMjHBIBKSRTK37stZzgEYk2RuPwj
         5/zQ==
X-Gm-Message-State: AOUpUlGc9nfPx4VjNLiqJRrtobQ0nkSyf63ecqgIu3dAlGENKiJkcess
        oHUFqkChWBD+EOQFvgtvWCtqOjpml1E=
X-Google-Smtp-Source: AAOMgpfRGZE0+Jg1WR9WgWGKJkX8ioe5jGxtplvM3PiCz5dFtv8lGrEr5otZS+J7kOIyLKGalg1VHA==
X-Received: by 2002:a1c:e708:: with SMTP id e8-v6mr5213064wmh.134.1532712710819;
        Fri, 27 Jul 2018 10:31:50 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:31:50 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/20] staging:rtl8192u: Rename bUsingBa - Style
Date:   Fri, 27 Jul 2018 18:31:11 +0100
Message-Id: <20180727173123.27391-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727173123.27391-1-johnfwhitmore@gmail.com>
References: <20180727173123.27391-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable bUsingBa to using_ba. This change clears the
checkpatch issue with CamelCase naming.

The resulting changes are purely coding style and should not impact
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c   | 4 ++--
 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
index 2fb9464f6ec3..cc4049de975d 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
@@ -340,10 +340,10 @@ static void ieee80211_tx_query_agg_cap(struct ieee80211_device *ieee,
 			TsStartAddBaProcess(ieee, pTxTs);
 			goto FORCED_AGG_SETTING;
 		}
-		else if (!pTxTs->bUsingBa)
+		else if (!pTxTs->using_ba)
 		{
 			if (SN_LESS(pTxTs->tx_admitted_ba_record.BaStartSeqCtrl.field.SeqNum, (pTxTs->tx_cur_seq + 1) % 4096))
-				pTxTs->bUsingBa = true;
+				pTxTs->using_ba = true;
 			else
 				goto FORCED_AGG_SETTING;
 		}
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 93967e56916c..7bd2d0fb2ebb 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -594,7 +594,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb)
 			return -1;
 		}
 
-		pTxTs->bUsingBa = false;
+		pTxTs->using_ba = false;
 		pTxTs->add_ba_req_in_progress = false;
 		pTxTs->add_ba_req_delayed = false;
 		del_timer_sync(&pTxTs->TsAddBaTimer);
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 4c11ed776c25..4cb53c75f438 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -34,7 +34,7 @@ struct tx_ts_record {
 /* 	QOS_DL_RECORD		DLRecord; */
 	u8				add_ba_req_in_progress;
 	u8				add_ba_req_delayed;
-	u8				bUsingBa;
+	u8				using_ba;
 	struct timer_list		TsAddBaTimer;
 	u8				num;
 };
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index ba7763265c08..09fb339203aa 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -116,7 +116,7 @@ static void ResetTxTsEntry(struct tx_ts_record *pTS)
 	pTS->tx_cur_seq = 0;
 	pTS->add_ba_req_in_progress = false;
 	pTS->add_ba_req_delayed = false;
-	pTS->bUsingBa = false;
+	pTS->using_ba = false;
 	ResetBaEntry(&pTS->tx_admitted_ba_record); //For BA Originator
 	ResetBaEntry(&pTS->tx_pending_ba_record);
 }
-- 
2.18.0

