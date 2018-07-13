Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B083EECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EE42087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCOyTVXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EE42087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387800AbeGMU3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:29:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42748 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732598AbeGMU3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:29:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so6666677wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 13:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xjxZDzsokEgI1s4v1Jinm3xYUHy8ePWSjyZuHkoqqYk=;
        b=FCOyTVXN++/2EicRkF2RbYi+Ms16PFEtMqPN/9BIvVCInooCaJ2NiCLUOk8dG+D3ts
         N33SAdgPoRhPHVhmF3rTteZjL/LEv823m04IolgEtaLYF1bO4N9ddrhojYN9ejAbzAM1
         lcTJ4S8ZJRDhR34Gh2Logbtl6Og02anGlZwXdsjKfjOLzcFBCEZn3ZqwZ6W2hQFzIHWg
         pKaXFHuDcn/RC/jyFIhJBhzI44cik5r9aN78t5ifHJKjDmDbaZ5j+qyUPTuGrCOG1qSN
         LbswkbwAJeeCu/+4oPyXJo90ngz6W2JaNvNsy6OtUQsXR8miLPx7VzvFT3kbLf63c8kG
         ygMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xjxZDzsokEgI1s4v1Jinm3xYUHy8ePWSjyZuHkoqqYk=;
        b=c65YYLWeK+DeTsPguyxpUsKIGD2swm0QztEoLMR5lRzAIGyp6HP+XHM0XNBW5PEzgP
         3EtUlRY0KcBqtaemNFKyOycnnIB34146aXDOjI+vBRLG+WnS1+a03+7GVG3pKNMvCa+l
         rXRGV2i2Jv0MusK7Ma5rDOx6fQdDGMyfJS4qm60bhBpQFp83mz1YG/9exThs/1hmc43T
         uJZsVnP+yAljPxW+jOgaZVn9P1jIZwvYoNoQnF/PiAaqNLmhhNpQC8XH+uIr9ONCd+dD
         HXmENJ4dbazKdygGGAO516DIKoCR4IepTeuZ+0l0kFhefUrMSkDW8aohO93uVIdeWuKn
         OCoA==
X-Gm-Message-State: AOUpUlHmrsCRdUTnJl625kp6khUeNEs07E2gBPy6nkHuX7rcX1eaB2sr
        Xh8HNrT0ACSGZwMEWPB3c8DZqwLc
X-Google-Smtp-Source: AAOMgpduQ8pA1qhI2Gwv0wuCR1F1zlhhWzayaq2A12TKCg5rK416ovqV4J3NL0vouB0hRJGYbCnr3w==
X-Received: by 2002:a5d:574d:: with SMTP id q13-v6mr5714613wrw.24.1531512820353;
        Fri, 13 Jul 2018 13:13:40 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id f6-v6sm14072677wrp.30.2018.07.13.13.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 13:13:39 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/10] staging:rtl8192u: Rename TClasNum > t_clas_num - Style
Date:   Fri, 13 Jul 2018 21:12:47 +0100
Message-Id: <20180713201247.21428-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713201247.21428-1-johnfwhitmore@gmail.com>
References: <20180713201247.21428-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the struct TS_COMMON_INFO member variable TClasNum to t_clas_num. This
change clears the checkpatch issue with CamelCase naming. There should be no
impact on runtime execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index ffa2983b8f8f..79f129312ee9 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -23,7 +23,7 @@ struct TS_COMMON_INFO {
 	TSPEC_BODY			t_spec;
 	QOS_TCLAS			t_class[TCLAS_NUM];
 	u8				t_clas_proc;
-	u8				TClasNum;
+	u8				t_clas_num;
 };
 
 typedef struct _TX_TS_RECORD {
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 1a6a0b938b63..96842e9a28fd 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -107,7 +107,7 @@ static void ResetTsCommonInfo(struct TS_COMMON_INFO *pTsCommonInfo)
 	memset(&pTsCommonInfo->t_spec, 0, sizeof(TSPEC_BODY));
 	memset(&pTsCommonInfo->t_class, 0, sizeof(QOS_TCLAS)*TCLAS_NUM);
 	pTsCommonInfo->t_clas_proc = 0;
-	pTsCommonInfo->TClasNum = 0;
+	pTsCommonInfo->t_clas_num = 0;
 }
 
 static void ResetTxTsEntry(PTX_TS_RECORD pTS)
@@ -282,7 +282,7 @@ static void MakeTSEntry(struct TS_COMMON_INFO *pTsCommonInfo, u8 *Addr,
 		memcpy((u8 *)(&(pTsCommonInfo->t_class[count])), (u8 *)pTCLAS, sizeof(QOS_TCLAS));
 
 	pTsCommonInfo->t_clas_proc = TCLAS_Proc;
-	pTsCommonInfo->TClasNum = TCLAS_Num;
+	pTsCommonInfo->t_clas_num = TCLAS_Num;
 }
 
 
-- 
2.18.0

