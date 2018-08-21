Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95017C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C316217BE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs/8Yk/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C316217BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeHUUhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:37:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42799 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbeHUUhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:37:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id v17-v6so1881670wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b1q2bF8G/2S6mdZR+NWugq1ATCF4nr3WhOYBQr+DzJk=;
        b=Hs/8Yk/v2izkcHKXr3fTPTirYmjweYBp/CI4a/YdRhzRB2jyl3/V/2KdeqXH9aydtv
         +J22crwnnZ+T6JiM6RDxq1a/2eETrQRvvwYJwlACNoVJubczx1XRBK3+Prww7S16dOMR
         e/GnBWom5KZjVaeUHPmu9JGM//BbB48Yn186ozIw5mXU22foggECnW4Ut+3/Twu8hXUe
         bXZjoPcrqGOhe42J94vvkkGv1BL0GOkoQYUfevmGuzCiWN+muajJYsfLGG8cYBDbsEJj
         QzsczMFIQaMn3LSULgIxtD1UoJ5q7jlw50xW1i00TZByCWFzTXd7SqLn527u34US57q0
         sfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b1q2bF8G/2S6mdZR+NWugq1ATCF4nr3WhOYBQr+DzJk=;
        b=KDClvI/bKRuUg4xic4hncgclDNhOCK5tDqx3ABy/+JTFVb04539w8mMoYEcYiXhdL8
         7rTLoZkr/fB/GUCEKSQeGKl7zZPwisuM5M9jqy0VJWcCGuSQcNqL5bjalhS0J6A0RbaK
         u6tZBEi/PNpPTUjxbL5x04lAy7ANGmyw6xR7+AwNY/MkkysCtjfqxuM6X0day/mQeNK0
         TKu/VvoYXF5EQHS1H+TAVjsPkJrS3/NcI8v5tjs4ORNRzK1gzfPwvliUH2lqzIgKbchJ
         uA+G6jdVQL92cMM9AEjKvVaWsQOZfGWLCLtHYpY2P28RPYnN3bgbqPrQ8lr3abgiUfnR
         fTPA==
X-Gm-Message-State: APzg51Aw7GOnKEggiP/2lO06IdTKA2cooJjHT4CPRyAHRnBXfJO4cYiN
        2xdkBCTkFBWl5kzRAws1hFFVI7BLArA=
X-Google-Smtp-Source: ANB0VdamDpBJYwGiaWsBytrFvsSYCpH3W5aNZ0Y9RYXMjAFik8RJgKD/iA0Nj5tMUwPMeLzIMe7ucw==
X-Received: by 2002:adf:f984:: with SMTP id f4-v6mr6711395wrr.105.1534871763831;
        Tue, 21 Aug 2018 10:16:03 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 88-v6sm7564292wrf.95.2018.08.21.10.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:16:01 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 14/17] staging:rtl8192u: Rename BaParamSet - Style
Date:   Tue, 21 Aug 2018 18:15:34 +0100
Message-Id: <20180821171537.9330-15-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821171537.9330-1-johnfwhitmore@gmail.com>
References: <20180821171537.9330-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable BaParamSet to param_set. This clears the
checkpatch issue with CamelCase naming.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_BA.h   |  2 +-
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       | 28 +++++++++----------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
index 948888224f24..64f20c124456 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
@@ -53,7 +53,7 @@ struct ba_record {
 	struct timer_list		timer;
 	u8				valid;
 	u8				dialog_token;
-	union ba_param_set		BaParamSet;
+	union ba_param_set		param_set;
 	u16				BaTimeoutValue;
 	union sequence_control	BaStartSeqCtrl;
 };
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 21398892b0e5..f3c98b9e2765 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -90,7 +90,7 @@ static u8 RxTsDeleteBA(struct ieee80211_device *ieee, struct rx_ts_record *pRxTs
 void ResetBaEntry(struct ba_record *pBA)
 {
 	pBA->valid			= false;
-	pBA->BaParamSet.short_data	= 0;
+	pBA->param_set.short_data	= 0;
 	pBA->BaTimeoutValue		= 0;
 	pBA->dialog_token		= 0;
 	pBA->BaStartSeqCtrl.short_data	= 0;
@@ -151,7 +151,7 @@ static struct sk_buff *ieee80211_ADDBA(struct ieee80211_device *ieee, u8 *Dst, s
 	}
 	// BA Parameter Set
 
-	put_unaligned_le16(pBA->BaParamSet.short_data, tag);
+	put_unaligned_le16(pBA->param_set.short_data, tag);
 	tag += 2;
 	// BA Timeout Value
 
@@ -202,7 +202,7 @@ static struct sk_buff *ieee80211_DELBA(
 	memset(&DelbaParamSet, 0, 2);
 
 	DelbaParamSet.field.initiator	= (TxRxSelect == TX_DIR) ? 1 : 0;
-	DelbaParamSet.field.tid	= pBA->BaParamSet.field.tid;
+	DelbaParamSet.field.tid	= pBA->param_set.field.tid;
 
 	skb = dev_alloc_skb(len + sizeof(struct rtl_80211_hdr_3addr)); //need to add something others? FIXME
 	if (!skb) {
@@ -383,14 +383,14 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 	//
 	DeActivateBAEntry(ieee, pBA);
 	pBA->dialog_token = *pDialogToken;
-	pBA->BaParamSet = *pBaParamSet;
+	pBA->param_set = *pBaParamSet;
 	pBA->BaTimeoutValue = *pBaTimeoutVal;
 	pBA->BaStartSeqCtrl = *pBaStartSeqCtrl;
 	//for half N mode we only aggregate 1 frame
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
-	pBA->BaParamSet.field.buffer_size = 1;
+	pBA->param_set.field.buffer_size = 1;
 	else
-	pBA->BaParamSet.field.buffer_size = 32;
+	pBA->param_set.field.buffer_size = 32;
 	ActivateBAEntry(ieee, pBA, pBA->BaTimeoutValue);
 	ieee80211_send_ADDBARsp(ieee, dst, pBA, ADDBA_STATUS_SUCCESS);
 
@@ -400,10 +400,10 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 OnADDBAReq_Fail:
 	{
 		struct ba_record	BA;
-		BA.BaParamSet = *pBaParamSet;
+		BA.param_set = *pBaParamSet;
 		BA.BaTimeoutValue = *pBaTimeoutVal;
 		BA.dialog_token = *pDialogToken;
-		BA.BaParamSet.field.ba_policy = BA_POLICY_IMMEDIATE;
+		BA.param_set.field.ba_policy = BA_POLICY_IMMEDIATE;
 		ieee80211_send_ADDBARsp(ieee, dst, &BA, rc);
 		return 0; //we send RSP out.
 	}
@@ -513,7 +513,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 		pAdmittedBA->dialog_token = *pDialogToken;
 		pAdmittedBA->BaTimeoutValue = *pBaTimeoutVal;
 		pAdmittedBA->BaStartSeqCtrl = pPendingBA->BaStartSeqCtrl;
-		pAdmittedBA->BaParamSet = *pBaParamSet;
+		pAdmittedBA->param_set = *pBaParamSet;
 		DeActivateBAEntry(ieee, pAdmittedBA);
 		ActivateBAEntry(ieee, pAdmittedBA, *pBaTimeoutVal);
 	} else {
@@ -527,7 +527,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 OnADDBARsp_Reject:
 	{
 		struct ba_record	BA;
-		BA.BaParamSet = *pBaParamSet;
+		BA.param_set = *pBaParamSet;
 		ieee80211_send_DELBA(ieee, dst, &BA, TX_DIR, ReasonCode);
 		return 0;
 	}
@@ -624,11 +624,11 @@ TsInitAddBA(
 	DeActivateBAEntry(ieee, pBA);
 
 	pBA->dialog_token++;						// DialogToken: Only keep the latest dialog token
-	pBA->BaParamSet.field.amsdu_support = 0;	// Do not support A-MSDU with A-MPDU now!!
-	pBA->BaParamSet.field.ba_policy = Policy;	// Policy: Delayed or Immediate
-	pBA->BaParamSet.field.tid = pTS->ts_common_info.t_spec.ts_info.uc_tsid;	// TID
+	pBA->param_set.field.amsdu_support = 0;	// Do not support A-MSDU with A-MPDU now!!
+	pBA->param_set.field.ba_policy = Policy;	// Policy: Delayed or Immediate
+	pBA->param_set.field.tid = pTS->ts_common_info.t_spec.ts_info.uc_tsid;	// TID
 	// buffer_size: This need to be set according to A-MPDU vector
-	pBA->BaParamSet.field.buffer_size = 32;		// buffer_size: This need to be set according to A-MPDU vector
+	pBA->param_set.field.buffer_size = 32;		// buffer_size: This need to be set according to A-MPDU vector
 	pBA->BaTimeoutValue = 0;					// Timeout value: Set 0 to disable Timer
 	pBA->BaStartSeqCtrl.field.seq_num = (pTS->tx_cur_seq + 3) % 4096;	// Block Ack will start after 3 packets later.
 
-- 
2.18.0

