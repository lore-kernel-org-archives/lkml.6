Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540F6C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126B421837
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd4fvI8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126B421837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeHUUhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:37:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34447 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeHUUhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:37:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id g33-v6so6460582wrd.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5Cqz1xsxWvPoUI3T4ak2u7MZytqIeXbkAwUzxttTXAg=;
        b=Gd4fvI8JCZmhNTZkzk9zTkZzhwkOWx1KRyOrPmmoZn70ebWI2kd5YIyTatLARhxlMb
         4WeiJltym2gnNswY+LRHwD5xllUR+3t6kvv4lSkqV1b3+lJgCQvr0uZLkK2xWwUu0Nh2
         B0IVGVFmaqxtGbbGt0MoA48H76gBPvp0mjvG96buFhMq8Si3xy62vascBGGcU+EmRFDl
         vocEHFFlb1HWe/mVoCkgIRhsReqgnNWldaBCNx1ZhuT9THbMXCfDXVOhGLDKQY9NzQj7
         UiMMIizwOVRKmVSC8Fm+YtBPSwAwwfDKAQ21z9pyzQhbB/LlwfvOGjCBr6iWm81YouIa
         PKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5Cqz1xsxWvPoUI3T4ak2u7MZytqIeXbkAwUzxttTXAg=;
        b=MmY0yY00+hJGlpYdgvoGEdQNOj9HlnkA19ODz/Lw9wO+H+tLl5PvJVhsEotHObUTX+
         A6eoL+tfu/rIRVYQQjfhZqxCWzaoALgyIrjqLnUlrErv/QIV1R1QB/vguPQwAGq22v4m
         /mp2jVuhK4Qt/5uwi8PI4/gWqAVJjR92ysOsBDXF0mvmWz54nI6xQ1VIBwGMaMZZdRSy
         TqoWzC53g0B46GrRGiNIn/R6KoARftvnXlYod7GUg3KBMxDG8eXGXtK9lYCfzWfS2dMe
         oWZuge+OwplpeG/Zk6o//aA/7RdFjNz/JGHsKIQSAGm3axhLbalw3pEZeoBl2qXqYZba
         6rPQ==
X-Gm-Message-State: AOUpUlHiBwb/9DiqEz8CVF+CpRrZJV5S1JqidwQuC1eFR2cZrII2zokc
        iQIP9yyqQGXCwK0loE4kIa7WYdcW7hc=
X-Google-Smtp-Source: AA+uWPyk9z8yt3JnpJbqK/9CUXdsNpz8NT2v+7T6FcigyYgaYd4aGPv/zFZ0N4tk7vq0Cy9X+2HV9g==
X-Received: by 2002:adf:8004:: with SMTP id 4-v6mr33809132wrk.130.1534871765349;
        Tue, 21 Aug 2018 10:16:05 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 88-v6sm7564292wrf.95.2018.08.21.10.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:16:04 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 15/17] staging:rtl8192u: Rename BaTimeoutValue - Style
Date:   Tue, 21 Aug 2018 18:15:35 +0100
Message-Id: <20180821171537.9330-16-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821171537.9330-1-johnfwhitmore@gmail.com>
References: <20180821171537.9330-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename BaTimeoutValue to timeout_value. This clears checkpatch issue
with CamelCase naming.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h    |  2 +-
 .../staging/rtl8192u/ieee80211/rtl819x_BAProc.c    | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
index 64f20c124456..01c30b1f44d2 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
@@ -54,7 +54,7 @@ struct ba_record {
 	u8				valid;
 	u8				dialog_token;
 	union ba_param_set		param_set;
-	u16				BaTimeoutValue;
+	u16				timeout_value;
 	union sequence_control	BaStartSeqCtrl;
 };
 
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index f3c98b9e2765..102252749c0b 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -91,7 +91,7 @@ void ResetBaEntry(struct ba_record *pBA)
 {
 	pBA->valid			= false;
 	pBA->param_set.short_data	= 0;
-	pBA->BaTimeoutValue		= 0;
+	pBA->timeout_value		= 0;
 	pBA->dialog_token		= 0;
 	pBA->BaStartSeqCtrl.short_data	= 0;
 }
@@ -155,7 +155,7 @@ static struct sk_buff *ieee80211_ADDBA(struct ieee80211_device *ieee, u8 *Dst, s
 	tag += 2;
 	// BA Timeout Value
 
-	put_unaligned_le16(pBA->BaTimeoutValue, tag);
+	put_unaligned_le16(pBA->timeout_value, tag);
 	tag += 2;
 
 	if (ACT_ADDBAREQ == type) {
@@ -384,14 +384,14 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 	DeActivateBAEntry(ieee, pBA);
 	pBA->dialog_token = *pDialogToken;
 	pBA->param_set = *pBaParamSet;
-	pBA->BaTimeoutValue = *pBaTimeoutVal;
+	pBA->timeout_value = *pBaTimeoutVal;
 	pBA->BaStartSeqCtrl = *pBaStartSeqCtrl;
 	//for half N mode we only aggregate 1 frame
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 	pBA->param_set.field.buffer_size = 1;
 	else
 	pBA->param_set.field.buffer_size = 32;
-	ActivateBAEntry(ieee, pBA, pBA->BaTimeoutValue);
+	ActivateBAEntry(ieee, pBA, pBA->timeout_value);
 	ieee80211_send_ADDBARsp(ieee, dst, pBA, ADDBA_STATUS_SUCCESS);
 
 	// End of procedure.
@@ -401,7 +401,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 	{
 		struct ba_record	BA;
 		BA.param_set = *pBaParamSet;
-		BA.BaTimeoutValue = *pBaTimeoutVal;
+		BA.timeout_value = *pBaTimeoutVal;
 		BA.dialog_token = *pDialogToken;
 		BA.param_set.field.ba_policy = BA_POLICY_IMMEDIATE;
 		ieee80211_send_ADDBARsp(ieee, dst, &BA, rc);
@@ -511,7 +511,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 		// Admitted condition
 		//
 		pAdmittedBA->dialog_token = *pDialogToken;
-		pAdmittedBA->BaTimeoutValue = *pBaTimeoutVal;
+		pAdmittedBA->timeout_value = *pBaTimeoutVal;
 		pAdmittedBA->BaStartSeqCtrl = pPendingBA->BaStartSeqCtrl;
 		pAdmittedBA->param_set = *pBaParamSet;
 		DeActivateBAEntry(ieee, pAdmittedBA);
@@ -629,7 +629,7 @@ TsInitAddBA(
 	pBA->param_set.field.tid = pTS->ts_common_info.t_spec.ts_info.uc_tsid;	// TID
 	// buffer_size: This need to be set according to A-MPDU vector
 	pBA->param_set.field.buffer_size = 32;		// buffer_size: This need to be set according to A-MPDU vector
-	pBA->BaTimeoutValue = 0;					// Timeout value: Set 0 to disable Timer
+	pBA->timeout_value = 0;					// Timeout value: Set 0 to disable Timer
 	pBA->BaStartSeqCtrl.field.seq_num = (pTS->tx_cur_seq + 3) % 4096;	// Block Ack will start after 3 packets later.
 
 	ActivateBAEntry(ieee, pBA, BA_SETUP_TIMEOUT);
-- 
2.18.0

