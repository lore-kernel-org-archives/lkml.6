Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B50FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162BC2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrAw8ymc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162BC2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeI0Bb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:31:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45169 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeI0Bbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:31:55 -0400
Received: by mail-ed1-f67.google.com with SMTP id h6-v6so1410722eds.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fPSMEieqLNu+tZwjxU8VaEiKULhwhAlrL7pZpaHM1IY=;
        b=RrAw8ymcgmcDOvRo8WRBoR9UvQE+SYf9govFXtmLyARVar4FL0euqTV5VBzuNMhPz8
         xWr49iioGgzVeaZ3TdOj5WBdw1gS9WDbaK/ggxisYU4bF9bGNxvn9fJL7Ce7WwhAOpvs
         L0G/3k9nVPpfrMnIcLM+ICQBrv0GJK5BP2UVq1aCb59CqnVQ7hxT68DNKWWRl6kr0GgQ
         L66pkCF9iKpEOYTsQ/PpQgGtEx4CYpLChE3Y26t5qkIcd1f+lYR2mz3aMkyzm/AS56h2
         cVQUz94FSKFK3oxJL9T0qZTGRJWqdZdp7CtT05o4dnB6Lr589qZFiEwwlz5Ojb6E0wdg
         +TyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fPSMEieqLNu+tZwjxU8VaEiKULhwhAlrL7pZpaHM1IY=;
        b=IdVSX4WWD6Gl5I17VX+TokOEPfktpTQYDL1p9dDOv3yyxaF1ocCFxjLDkT9+c0vyXe
         WIrrHMjK/s1V7LQDsgyOAsKJ0wwS9NqKL0r04SHTTr6XbcyRqr7ukxtvgvmUdDD7GYtW
         ZKF11+SiJlada/ON179a4C4bSBzuRSLeE23hdJrS7Nr9b+iW9T9IdsihteU+CbfxSZs2
         3OWrY0hIdSzh1rT637pnNP7yEtTRZzwTzQNFSulxxM0arbNERgLkBlmqaygUnZksn844
         ikzveOzdC/YFlrEgIgZNHR3c/UVS/6SYrjMW2OMIvxGCHdcLiVHygp7ndhevOqJm6Fi2
         /9Ow==
X-Gm-Message-State: ABuFfohuqnz22Dq/7SB6kmhtstRha3J4IhoWZd8gniK6FzojnvtSjsTC
        mXeoG2py7r5hT1aH3jvyKLhjcTnS
X-Google-Smtp-Source: ACcGV63zcl9JdnEO6cT1SG8nRyx0v/23aJC18QPxibAvgcu57QYsosfc60RUZpjiLyad6l6dL5iGbw==
X-Received: by 2002:a50:c201:: with SMTP id n1-v6mr12448300edf.11.1537989447597;
        Wed, 26 Sep 2018 12:17:27 -0700 (PDT)
Received: from localhost.localdomain ([109.78.196.57])
        by smtp.gmail.com with ESMTPSA id k13-v6sm91417eda.72.2018.09.26.12.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:17:26 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/13] staging:rtl8192u: Move HTSetConnectBwModeCallback() - Style
Date:   Wed, 26 Sep 2018 20:16:55 +0100
Message-Id: <20180926191704.16322-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180926191704.16322-1-johnfwhitmore@gmail.com>
References: <20180926191704.16322-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function HTSetConnectBwModeCallback() is only used in the file
in which it is defined, so has been changed to being of type 'static'.

Additionally the function is defined after it is used so a prototype
was included in the file. This prototype, in the middle of the file
has been removed and the function implementation moved so that it is
defined before it is used in the file.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/ieee80211.h    |  1 -
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       | 47 +++++++++----------
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index 8c91cb29fc9d..8aa536d79900 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -2379,7 +2379,6 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee,
 extern u8 MCS_FILTER_ALL[];
 extern u16 MCS_DATA_RATE[2][2][77];
 u8 HTCCheck(struct ieee80211_device *ieee, u8 *pFrame);
-//extern void HTSetConnectBwModeCallback(unsigned long data);
 void HTResetIOTSetting(PRT_HIGH_THROUGHPUT pHTInfo);
 bool IsHTHalfNmodeAPs(struct ieee80211_device *ieee);
 u16 TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate);
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 977a1e5c9b52..c73a8058cf87 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -1011,7 +1011,6 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	pHTInfo->CurrentOpMode = pPeerHTInfo->OptMode;
 }
 
-void HTSetConnectBwModeCallback(struct ieee80211_device *ieee);
 /*
  *function:  initialize HT info(struct PRT_HIGH_THROUGHPUT)
  *   input:  struct ieee80211_device*	ieee
@@ -1228,6 +1227,29 @@ u8 HTCCheck(struct ieee80211_device *ieee, u8 *pFrame)
 	return false;
 }
 
+static void HTSetConnectBwModeCallback(struct ieee80211_device *ieee)
+{
+	PRT_HIGH_THROUGHPUT pHTInfo = ieee->pHTInfo;
+
+	IEEE80211_DEBUG(IEEE80211_DL_HT, "======>%s()\n", __func__);
+
+	if (pHTInfo->bCurBW40MHz) {
+		if (pHTInfo->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_UPPER)
+			ieee->set_chan(ieee->dev, ieee->current_network.channel + 2);
+		else if (pHTInfo->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_LOWER)
+			ieee->set_chan(ieee->dev, ieee->current_network.channel - 2);
+		else
+			ieee->set_chan(ieee->dev, ieee->current_network.channel);
+
+		ieee->SetBWModeHandler(ieee->dev, HT_CHANNEL_WIDTH_20_40, pHTInfo->CurSTAExtChnlOffset);
+	} else {
+		ieee->set_chan(ieee->dev, ieee->current_network.channel);
+		ieee->SetBWModeHandler(ieee->dev, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
+	}
+
+	pHTInfo->bSwBwInProgress = false;
+}
+
 /*
  * This function set bandwidth mode in protocol layer.
  */
@@ -1278,26 +1300,3 @@ void HTSetConnectBwMode(struct ieee80211_device *ieee, enum ht_channel_width Ban
 
 //	spin_unlock_irqrestore(&(ieee->bw_spinlock), flags);
 }
-
-void HTSetConnectBwModeCallback(struct ieee80211_device *ieee)
-{
-	PRT_HIGH_THROUGHPUT pHTInfo = ieee->pHTInfo;
-
-	IEEE80211_DEBUG(IEEE80211_DL_HT, "======>%s()\n", __func__);
-
-	if (pHTInfo->bCurBW40MHz) {
-		if (pHTInfo->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_UPPER)
-			ieee->set_chan(ieee->dev, ieee->current_network.channel + 2);
-		else if (pHTInfo->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_LOWER)
-			ieee->set_chan(ieee->dev, ieee->current_network.channel - 2);
-		else
-			ieee->set_chan(ieee->dev, ieee->current_network.channel);
-
-		ieee->SetBWModeHandler(ieee->dev, HT_CHANNEL_WIDTH_20_40, pHTInfo->CurSTAExtChnlOffset);
-	} else {
-		ieee->set_chan(ieee->dev, ieee->current_network.channel);
-		ieee->SetBWModeHandler(ieee->dev, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
-	}
-
-	pHTInfo->bSwBwInProgress = false;
-}
-- 
2.18.0

