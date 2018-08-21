Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E54C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFDA217C7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4wrwvoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEFDA217C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeHUUhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:37:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37768 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeHUUhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:37:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so3527400wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lbmZ7PVbs9yocaJVjV81kBAckt+AY2P0pR3r1RKDDTg=;
        b=I4wrwvoyYh7AMoY9buPzqtWcAWH1xdmNd6uivT8QvanL/kWNHqBGisMZfcehkryn6r
         7HFXd9g6hKouVeieW3ygmAtoeGNIMEGkVV1Ms7hmNQHqwBlQJAfyUo5R98g3ivwWHOIV
         +GriHGlhHdRAfyGAhlqWhnhiJgk0Yl0H9sqA2NqeSHiTeJ3mZBTqH/7ylnoIcewB0Xy6
         YY3965b5fkc5ZioU6gwvb+jb/eWSpeuc0VY2cIRyBnTttBjqhAtTUbhs5UfeKqFza6UH
         FLnuJuXUxe/zQC0n7gMt8tpUffJ3Je5dfHYjJ2hJYYV1Gukdj4DZyScr8O6SIUUKKI+r
         8/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lbmZ7PVbs9yocaJVjV81kBAckt+AY2P0pR3r1RKDDTg=;
        b=NVKPydynxZCrQUb/OGi73LkD26TjLGBYW/fioFK2INCkvzONbPQKvrlvQEWvVD2Zwu
         KOR/Xpic+ta/hCvEuMiBH7PfRaMQ342fV+ZtS+mYOXa8e5SVoEjHc14gqsz2xic1VxwT
         8JYCiZwTY2X2TaL/+AlGY1i28VpJ1c2MJ4E++a8vh8/TvsSOK7anv72vMGeUoP4iA68M
         wf1Vc9+3mTndzv/O7rV5hSyZSL6KbNLvswRdapRWxAgfQKQuxYgjfHss5osXG60JwWMT
         XJwzK2hi586SNqGPdnNIIg1ziXqlITe0DfMVUVqNx5LxVucGLnabF1/XOUQmL5AQZT7y
         4KAw==
X-Gm-Message-State: APzg51D1dPcQS2ITNx4GDEOPSvNYYsV2IkgQzQ2KHLlounA6i290LyAi
        dduG8P5tz1QuaABkr/bHLRazuYp3Ku0=
X-Google-Smtp-Source: ANB0VdbWFK5YrDuaghC8Mml2DTAirU0/oFJQQPzrxnVV1mmI7C12UK4bKSoNEwmjAdZ+/9K44qMYmA==
X-Received: by 2002:a1c:ae94:: with SMTP id x142-v6mr162125wme.125.1534871766869;
        Tue, 21 Aug 2018 10:16:06 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 88-v6sm7564292wrf.95.2018.08.21.10.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:16:06 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 16/17] staging:rtl8192u: Rename BaStartSeqCtrl - Style
Date:   Tue, 21 Aug 2018 18:15:36 +0100
Message-Id: <20180821171537.9330-17-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821171537.9330-1-johnfwhitmore@gmail.com>
References: <20180821171537.9330-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename BaStartSeqCtrl to start_seq_ctrl. This change clears the
checkpatch issue with CamelCase naming.

This is a coding style change which should not impact runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c   |  2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h     |  2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
index a7850b04c81b..024fa2702546 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
@@ -342,7 +342,7 @@ static void ieee80211_tx_query_agg_cap(struct ieee80211_device *ieee,
 		}
 		else if (!pTxTs->using_ba)
 		{
-			if (SN_LESS(pTxTs->tx_admitted_ba_record.BaStartSeqCtrl.field.seq_num, (pTxTs->tx_cur_seq + 1) % 4096))
+			if (SN_LESS(pTxTs->tx_admitted_ba_record.start_seq_ctrl.field.seq_num, (pTxTs->tx_cur_seq + 1) % 4096))
 				pTxTs->using_ba = true;
 			else
 				goto FORCED_AGG_SETTING;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
index 01c30b1f44d2..1a494ecf05ac 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
@@ -55,7 +55,7 @@ struct ba_record {
 	u8				dialog_token;
 	union ba_param_set		param_set;
 	u16				timeout_value;
-	union sequence_control	BaStartSeqCtrl;
+	union sequence_control	start_seq_ctrl;
 };
 
 #endif //end _BATYPE_H_
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 102252749c0b..109445407cec 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -93,7 +93,7 @@ void ResetBaEntry(struct ba_record *pBA)
 	pBA->param_set.short_data	= 0;
 	pBA->timeout_value		= 0;
 	pBA->dialog_token		= 0;
-	pBA->BaStartSeqCtrl.short_data	= 0;
+	pBA->start_seq_ctrl.short_data	= 0;
 }
 //These functions need porting here or not?
 /*******************************************************************************************************************************
@@ -160,7 +160,7 @@ static struct sk_buff *ieee80211_ADDBA(struct ieee80211_device *ieee, u8 *Dst, s
 
 	if (ACT_ADDBAREQ == type) {
 	// BA Start SeqCtrl
-		memcpy(tag, (u8 *)&(pBA->BaStartSeqCtrl), 2);
+		memcpy(tag, (u8 *)&(pBA->start_seq_ctrl), 2);
 		tag += 2;
 	}
 
@@ -385,7 +385,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 	pBA->dialog_token = *pDialogToken;
 	pBA->param_set = *pBaParamSet;
 	pBA->timeout_value = *pBaTimeoutVal;
-	pBA->BaStartSeqCtrl = *pBaStartSeqCtrl;
+	pBA->start_seq_ctrl = *pBaStartSeqCtrl;
 	//for half N mode we only aggregate 1 frame
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 	pBA->param_set.field.buffer_size = 1;
@@ -512,7 +512,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 		//
 		pAdmittedBA->dialog_token = *pDialogToken;
 		pAdmittedBA->timeout_value = *pBaTimeoutVal;
-		pAdmittedBA->BaStartSeqCtrl = pPendingBA->BaStartSeqCtrl;
+		pAdmittedBA->start_seq_ctrl = pPendingBA->start_seq_ctrl;
 		pAdmittedBA->param_set = *pBaParamSet;
 		DeActivateBAEntry(ieee, pAdmittedBA);
 		ActivateBAEntry(ieee, pAdmittedBA, *pBaTimeoutVal);
@@ -630,7 +630,7 @@ TsInitAddBA(
 	// buffer_size: This need to be set according to A-MPDU vector
 	pBA->param_set.field.buffer_size = 32;		// buffer_size: This need to be set according to A-MPDU vector
 	pBA->timeout_value = 0;					// Timeout value: Set 0 to disable Timer
-	pBA->BaStartSeqCtrl.field.seq_num = (pTS->tx_cur_seq + 3) % 4096;	// Block Ack will start after 3 packets later.
+	pBA->start_seq_ctrl.field.seq_num = (pTS->tx_cur_seq + 3) % 4096;	// Block Ack will start after 3 packets later.
 
 	ActivateBAEntry(ieee, pBA, BA_SETUP_TIMEOUT);
 
-- 
2.18.0

