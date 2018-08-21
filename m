Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F47C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD5A2184F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTdEH4Nr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD5A2184F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeHUUl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:41:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35888 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbeHUUgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:36:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id w24-v6so3538388wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LidCv53AIP8clD6UJBXbfi59ivURG2LEZHmOreronVc=;
        b=ZTdEH4Nr21zQyoJlZpNJa5Irb0c91Cb0fNhgqKTtsPymwGIZD0JwdrsNoqzrFBK/xc
         VjRqTb7Pq7mJ/czxSf+B2MeXEl4JueCrDGXN2GgM/ceM2zeeabdK5hEAvuiE+6xnNwI1
         42InFiNQyyHkKpVFCEIT3juQI6Kv4MO8fwhGSE3VDbrb5bZOXKOdEI39JEnPwl8wXvSO
         45ZMFAjqGUx3SMvLEueQUs1awPZYVOkPccF26clBBqEgjnX8Hwe09Hmd3ctI2sX2m2RR
         W1RkxqQTWKaC5PdG1023RV1xuEcpZhOs0Cb/Qbft3jH1ly/cjFruKvDW8IDYlm0XYNvR
         JVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LidCv53AIP8clD6UJBXbfi59ivURG2LEZHmOreronVc=;
        b=ZDeNVWe4GG/Z51OVn9kjfJxqkNIhgkRDHjDFnLx8D48OuOdKJ/nF/jP0mr3ybjf+CP
         tWGywLPKRIIGuoJ+C2k0jb7kqhA7b5LwLYVKCo8BiHVWGgV5J5+6nSMEbv/KmGyZbT8Y
         qqFZ30T9sQJ6WE0QRDm/ZxMMXWOWH8pCVshDsY0dSbQpYtIMU6WzpZDJOCEM4q437i3S
         bddU5iexHMd1tlzcIWfUvlgxGMfIUeSmFOPe6KEFMIsfqqt5nSrasN5SFCPZ0hFmbA0+
         wkglg3B2HzD7LZ75+p6KgMKffgt2NbaquEd/hUbpNJ6MOvrqiBk/YtfgKbmJg6wMkhM7
         d+cg==
X-Gm-Message-State: APzg51AkHvNtxEE/tCFcr1ragUQWWLb5x6OQhXN+iwjvR+qbHPAMc0sA
        8812/kYOEFS91SlpHNgnMI3cM+39ZeI=
X-Google-Smtp-Source: ANB0VdYVcuBHLBwv3XG4BxRKBb5nV1nwUuwmLlh5VdCC8NHwoNnQ3mpVwhQNt3y1TEVnTHXVPp04Ow==
X-Received: by 2002:a1c:c019:: with SMTP id q25-v6mr175858wmf.148.1534871746845;
        Tue, 21 Aug 2018 10:15:46 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 88-v6sm7564292wrf.95.2018.08.21.10.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:15:46 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/17] staging:rtl8192u: Rename member variables - Style
Date:   Tue, 21 Aug 2018 18:15:24 +0100
Message-Id: <20180821171537.9330-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821171537.9330-1-johnfwhitmore@gmail.com>
References: <20180821171537.9330-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variables FragNum and SeqNum. This change clears
a checkpatch issue with CamelCase naming.

This is a coding style change and should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c   | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h     | 4 ++--
 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
index cc4049de975d..a61e3805437d 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
@@ -342,7 +342,7 @@ static void ieee80211_tx_query_agg_cap(struct ieee80211_device *ieee,
 		}
 		else if (!pTxTs->using_ba)
 		{
-			if (SN_LESS(pTxTs->tx_admitted_ba_record.BaStartSeqCtrl.field.SeqNum, (pTxTs->tx_cur_seq + 1) % 4096))
+			if (SN_LESS(pTxTs->tx_admitted_ba_record.BaStartSeqCtrl.field.seq_num, (pTxTs->tx_cur_seq + 1) % 4096))
 				pTxTs->using_ba = true;
 			else
 				goto FORCED_AGG_SETTING;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
index ec9bbddca3de..6bbabd9e6562 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
@@ -25,8 +25,8 @@ struct ieee80211_ADDBA_Req{
 union sequence_control {
 	u16 short_data;
 	struct {
-		u16	FragNum:4;
-		u16	SeqNum:12;
+		u16	frag_num:4;
+		u16	seq_num:12;
 	} field;
 };
 
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 6a95b47aa595..643fd891f476 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -630,7 +630,7 @@ TsInitAddBA(
 	// BufferSize: This need to be set according to A-MPDU vector
 	pBA->BaParamSet.field.BufferSize = 32;		// BufferSize: This need to be set according to A-MPDU vector
 	pBA->BaTimeoutValue = 0;					// Timeout value: Set 0 to disable Timer
-	pBA->BaStartSeqCtrl.field.SeqNum = (pTS->tx_cur_seq + 3) % 4096;	// Block Ack will start after 3 packets later.
+	pBA->BaStartSeqCtrl.field.seq_num = (pTS->tx_cur_seq + 3) % 4096;	// Block Ack will start after 3 packets later.
 
 	ActivateBAEntry(ieee, pBA, BA_SETUP_TIMEOUT);
 
-- 
2.18.0

