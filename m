Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB05C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CC020862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tQqO0VuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CC020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389566AbeG0TAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 15:00:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34092 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389008AbeG0Syh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so5796565wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4PqnnUuHb51dFlCTy+8td0ZTLtINeSsTb3q7LCUJANA=;
        b=tQqO0VuOa5jTXf8lWM3uf2nZKJEgQ9op7YafH3j2pK29WA0rBzWY3EYUfhLwx2JFux
         HwvBxQGqyBQveViHHLFVOjRHPH4qD9eGMBGy21CpTgm2yzhEEJaabszwbHjnar1+bkoe
         LHKl3NxKj4Rsjzz6w1m3zTSUWWC88lmdnpHVlkuHqKK6jF69jDZYxe2BK/w/ty+auJCh
         +gvC9+4AyjScL9w0/NwJANgPLpEvqw/7auUMjUVLf1gd2IVMm8ph/L6WgKy0RZgEkXJl
         siy2EVaYq+/50dzRXMBOFaujpam3WyGLpgEAMG486zfL+Mbby5nYg1L1uIWnJgOFKvct
         ZiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4PqnnUuHb51dFlCTy+8td0ZTLtINeSsTb3q7LCUJANA=;
        b=iX4z9wEppQiABGzu7MgnqwLO/D9nzbEFZc79wYcKuL9eUQb6SEK8INLb7JKGX15HxS
         ztdspB/69pOd99L6HdtpQBQ8QafNQQrtPUQAqypfFaQnTowJbVYOxvnSF7P82OvBOIV/
         ASpcB5OwpfqxxfBIAjTlwAckluif+LSwN3VNbex1BFW1fQEDnI810Dkp87hh1RYx5cei
         QBLJ6D7y60Idc49BmGdQAtsorKOnrnjvqmCZPaJNibo1VAvkcAEspwNREhVHcU7ZsqCa
         cgE/GEywzXCmvWyta/pivqMgaQDMMr+WBxaMLtjhCK1L98iAYEbbXkHG+OdCym+rniyB
         +MNg==
X-Gm-Message-State: AOUpUlHPs6K59GMbDyOYB40SLUBg4JtyBdur/1RFKRVLj1GXTz44iIi/
        uLVkyx9ef/Y92gcN47YVHV+5bYP27Yk=
X-Google-Smtp-Source: AAOMgpcTbqhv6/nUT0GZrzeThsK5TMSjPKkmZrWwbK9uYQDms0DlJruljFVYqDAb0Ark0mmGXSs1Zw==
X-Received: by 2002:adf:f28c:: with SMTP id k12-v6mr5335756wro.263.1532712703477;
        Fri, 27 Jul 2018 10:31:43 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:31:42 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/20] staging:rtl8192u: Rename TxCurSeq - Style
Date:   Fri, 27 Jul 2018 18:31:06 +0100
Message-Id: <20180727173123.27391-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727173123.27391-1-johnfwhitmore@gmail.com>
References: <20180727173123.27391-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable TxCurSeq to tx_cur_seq. This change clears
the checkpatch issue with CamelCase naming.

The changes are coding style changes which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c   | 4 ++--
 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
index 142b86b393dc..77ec1d5938be 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
@@ -342,7 +342,7 @@ static void ieee80211_tx_query_agg_cap(struct ieee80211_device *ieee,
 		}
 		else if (!pTxTs->bUsingBa)
 		{
-			if (SN_LESS(pTxTs->TxAdmittedBARecord.BaStartSeqCtrl.field.SeqNum, (pTxTs->TxCurSeq+1)%4096))
+			if (SN_LESS(pTxTs->TxAdmittedBARecord.BaStartSeqCtrl.field.SeqNum, (pTxTs->tx_cur_seq + 1) % 4096))
 				pTxTs->bUsingBa = true;
 			else
 				goto FORCED_AGG_SETTING;
@@ -589,7 +589,7 @@ static void ieee80211_query_seqnum(struct ieee80211_device *ieee,
 		{
 			return;
 		}
-		pTS->TxCurSeq = (pTS->TxCurSeq+1)%4096;
+		pTS->tx_cur_seq = (pTS->tx_cur_seq + 1) % 4096;
 	}
 }
 
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 686d4e917384..b217310f9875 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -630,7 +630,7 @@ TsInitAddBA(
 	// BufferSize: This need to be set according to A-MPDU vector
 	pBA->BaParamSet.field.BufferSize = 32;		// BufferSize: This need to be set according to A-MPDU vector
 	pBA->BaTimeoutValue = 0;					// Timeout value: Set 0 to disable Timer
-	pBA->BaStartSeqCtrl.field.SeqNum = (pTS->TxCurSeq + 3) % 4096;	// Block Ack will start after 3 packets later.
+	pBA->BaStartSeqCtrl.field.SeqNum = (pTS->tx_cur_seq + 3) % 4096;	// Block Ack will start after 3 packets later.
 
 	ActivateBAEntry(ieee, pBA, BA_SETUP_TIMEOUT);
 
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index e2c2001dc5ca..8bb55e537bfd 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -28,7 +28,7 @@ struct ts_common_info {
 
 struct tx_ts_record {
 	struct ts_common_info		ts_common_info;
-	u16				TxCurSeq;
+	u16				tx_cur_seq;
 	BA_RECORD			TxPendingBARecord;	/*  For BA Originator */
 	BA_RECORD			TxAdmittedBARecord;	/*  For BA Originator */
 /* 	QOS_DL_RECORD		DLRecord; */
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index e1ce4e5096bb..3dd42091ed9a 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -113,7 +113,7 @@ static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
 static void ResetTxTsEntry(struct tx_ts_record *pTS)
 {
 	ResetTsCommonInfo(&pTS->ts_common_info);
-	pTS->TxCurSeq = 0;
+	pTS->tx_cur_seq = 0;
 	pTS->bAddBaReqInProgress = false;
 	pTS->bAddBaReqDelayed = false;
 	pTS->bUsingBa = false;
-- 
2.18.0

