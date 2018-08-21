Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5A5C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E75217B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdQlk7VM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E75217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeHUUgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:36:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35893 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeHUUgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:36:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id w24-v6so3538606wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HHBNLdjSnqoIZ22rY2JfCJoPpdoguC5H7G+iOmDzPMs=;
        b=ZdQlk7VMDMCTbNQR+yiXfVnzmMCjsFYBInRVYXoeZxv2XmdGEmNl+fMY2Td76PYmkT
         UeVIQeZBxqO+xc2WU726ZFmJLMtshc1UTgsUc3FM1lriN3f4QST/W6h4gHJICb7pKlmm
         oYmrb+yv6TfWTjlfaASsINh3npNSSqe7Sn+Fj5gtk745XEHTwqZNB9T+0K6hapEzocLu
         sYF9ITom9IeJR8ScrQmoSXIdgEgMFT5vdUFUp01FdEYHOm4CnsICy1kHWJT50/JwqvS7
         tBVuE+bDzx/tZm+vY52vfnyBk7ZlGVQ5mBPJieUF7nX+ywtLv368ZuWjS9iWRwia+CgW
         bIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HHBNLdjSnqoIZ22rY2JfCJoPpdoguC5H7G+iOmDzPMs=;
        b=t+VoqjkNvxv9XveEdO8d/f8G7rOrBqhxcRGY0z91DlbGCJ/vrW2kAmdwuuhHGBBJLt
         NZc7bGcRm2wht4MDPVVdyAT1dHAhM8TCCYq55/h3s0YxacnVj3D1LH/L6m3OtM9Psur8
         dHLD4g95OrPKKsJDzYN2vL/Kr+iUY4GMMdLfuE1NESkEq9GsZPPU6E7e851oFkOo3H3k
         makjkfl2VkFP53A5y6m4xXgCwWvQl9cI37sT5D+O9nkZ2MoLCC2PnlUWLq90UMR4JaDt
         hv1dwxz4P2fix6RI66jBdSwjxhVfJpz2HOPmMpP0rCjVxxxmlqdzvR8QUZrjyi+QZzOG
         XH6A==
X-Gm-Message-State: APzg51Cbcan7NlzqgDcGIlUL9qnTEluVf2UH8pCIp4bhcbs7qaSrJDJm
        TPENdTUZa8BHNoJMgupFUe28POQIAUs=
X-Google-Smtp-Source: ANB0Vda90n1+5RSLg6WcIMJKpzFBH/LsLFlfo6qgeaNWZ3+o/DC06CVjIDNwOiMQfAnUjcBSv00T5g==
X-Received: by 2002:a1c:9c56:: with SMTP id f83-v6mr146176wme.135.1534871751356;
        Tue, 21 Aug 2018 10:15:51 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 88-v6sm7564292wrf.95.2018.08.21.10.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:15:50 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/17] staging:rtl8192u: Rename ba_param_set members - Style
Date:   Tue, 21 Aug 2018 18:15:27 +0100
Message-Id: <20180821171537.9330-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821171537.9330-1-johnfwhitmore@gmail.com>
References: <20180821171537.9330-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variables of union ba_param_set to clear the
checkpatch issue with CamelCase naming:

AMSDU_Support  to  amsdu_support
BAPolicy       to  ba_policy
TID            to  tid
BufferSize     to  buffer_size

These are coding style changes which should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_BA.h   |  8 +++---
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       | 28 +++++++++----------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
index d3730fc6c8fe..8beae1af63a1 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
@@ -33,10 +33,10 @@ union sequence_control {
 union ba_param_set {
 	u16 short_data;
 	struct {
-		u16 AMSDU_Support:1;
-		u16 BAPolicy:1;
-		u16 TID:4;
-		u16 BufferSize:10;
+		u16 amsdu_support:1;
+		u16 ba_policy:1;
+		u16 tid:4;
+		u16 buffer_size:10;
 	} field;
 };
 
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 1a9271548b94..42f458b4ece0 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -202,7 +202,7 @@ static struct sk_buff *ieee80211_DELBA(
 	memset(&DelbaParamSet, 0, 2);
 
 	DelbaParamSet.field.Initiator	= (TxRxSelect == TX_DIR) ? 1 : 0;
-	DelbaParamSet.field.TID	= pBA->BaParamSet.field.TID;
+	DelbaParamSet.field.TID	= pBA->BaParamSet.field.tid;
 
 	skb = dev_alloc_skb(len + sizeof(struct rtl_80211_hdr_3addr)); //need to add something others? FIXME
 	if (!skb) {
@@ -362,7 +362,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 			ieee,
 			(struct ts_common_info **)(&pTS),
 			dst,
-			(u8)(pBaParamSet->field.TID),
+			(u8)(pBaParamSet->field.tid),
 			RX_DIR,
 			true)) {
 		rc = ADDBA_STATUS_REFUSED;
@@ -371,10 +371,10 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 	}
 	pBA = &pTS->rx_admitted_ba_record;
 	// To Determine the ADDBA Req content
-	// We can do much more check here, including BufferSize, AMSDU_Support, Policy, StartSeqCtrl...
+	// We can do much more check here, including buffer_size, AMSDU_Support, Policy, StartSeqCtrl...
 	// I want to check StartSeqCtrl to make sure when we start aggregation!!!
 	//
-	if (pBaParamSet->field.BAPolicy == BA_POLICY_DELAYED) {
+	if (pBaParamSet->field.ba_policy == BA_POLICY_DELAYED) {
 		rc = ADDBA_STATUS_INVALID_PARAM;
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "BA Policy is not correct in %s()\n", __func__);
 		goto OnADDBAReq_Fail;
@@ -388,9 +388,9 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 	pBA->BaStartSeqCtrl = *pBaStartSeqCtrl;
 	//for half N mode we only aggregate 1 frame
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
-	pBA->BaParamSet.field.BufferSize = 1;
+	pBA->BaParamSet.field.buffer_size = 1;
 	else
-	pBA->BaParamSet.field.BufferSize = 32;
+	pBA->BaParamSet.field.buffer_size = 32;
 	ActivateBAEntry(ieee, pBA, pBA->BaTimeoutValue);
 	ieee80211_send_ADDBARsp(ieee, dst, pBA, ADDBA_STATUS_SUCCESS);
 
@@ -403,7 +403,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 		BA.BaParamSet = *pBaParamSet;
 		BA.BaTimeoutValue = *pBaTimeoutVal;
 		BA.DialogToken = *pDialogToken;
-		BA.BaParamSet.field.BAPolicy = BA_POLICY_IMMEDIATE;
+		BA.BaParamSet.field.ba_policy = BA_POLICY_IMMEDIATE;
 		ieee80211_send_ADDBARsp(ieee, dst, &BA, rc);
 		return 0; //we send RSP out.
 	}
@@ -461,7 +461,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 			ieee,
 			(struct ts_common_info **)(&pTS),
 			dst,
-			(u8)(pBaParamSet->field.TID),
+			(u8)(pBaParamSet->field.tid),
 			TX_DIR,
 			false)) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "can't get TS in %s()\n", __func__);
@@ -498,7 +498,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 		// We can compare the value of BA parameter set that Peer returned and Self sent.
 		// If it is OK, then admitted. Or we can send DELBA to cancel BA mechanism.
 		//
-		if (pBaParamSet->field.BAPolicy == BA_POLICY_DELAYED) {
+		if (pBaParamSet->field.ba_policy == BA_POLICY_DELAYED) {
 			// Since this is a kind of ADDBA failed, we delay next ADDBA process.
 			pTS->add_ba_req_delayed = true;
 			DeActivateBAEntry(ieee, pAdmittedBA);
@@ -624,11 +624,11 @@ TsInitAddBA(
 	DeActivateBAEntry(ieee, pBA);
 
 	pBA->DialogToken++;						// DialogToken: Only keep the latest dialog token
-	pBA->BaParamSet.field.AMSDU_Support = 0;	// Do not support A-MSDU with A-MPDU now!!
-	pBA->BaParamSet.field.BAPolicy = Policy;	// Policy: Delayed or Immediate
-	pBA->BaParamSet.field.TID = pTS->ts_common_info.t_spec.ts_info.uc_tsid;	// TID
-	// BufferSize: This need to be set according to A-MPDU vector
-	pBA->BaParamSet.field.BufferSize = 32;		// BufferSize: This need to be set according to A-MPDU vector
+	pBA->BaParamSet.field.amsdu_support = 0;	// Do not support A-MSDU with A-MPDU now!!
+	pBA->BaParamSet.field.ba_policy = Policy;	// Policy: Delayed or Immediate
+	pBA->BaParamSet.field.tid = pTS->ts_common_info.t_spec.ts_info.uc_tsid;	// TID
+	// buffer_size: This need to be set according to A-MPDU vector
+	pBA->BaParamSet.field.buffer_size = 32;		// buffer_size: This need to be set according to A-MPDU vector
 	pBA->BaTimeoutValue = 0;					// Timeout value: Set 0 to disable Timer
 	pBA->BaStartSeqCtrl.field.seq_num = (pTS->tx_cur_seq + 3) % 4096;	// Block Ack will start after 3 packets later.
 
-- 
2.18.0

