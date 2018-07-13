Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E10ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0585A2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF9ffF8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0585A2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbeGMU3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:29:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44676 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733009AbeGMU3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:29:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so26221107wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 13:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DkKhQJ4Pds0nZdicrR0hNgUOTeU+fUks0rdHCpFbvjk=;
        b=fF9ffF8PjmZ5Sp3BcDiGk13C9poX6exFpZWhY54G9XyTQgLI4mZxa+zgl+2D3/Gx1e
         PuKlHUgOvwom1tJIFNZxLLn8Szc/XX5ENP5IhftqVlrqZ6Zdl4tkwAoJmgrIvVsxRbKm
         Sfo0RVjxUS7Yc5D3KelgmcvXN3tBosFa38nLoKREx80wlWY4NJl1qOa+AblSUT96OIBR
         GH+XjCF5hzHU1LX30j2Hyjd64U46dbDgHLAjdfS/VEqfvTwvacbB0g5sUutZHG7CyN9/
         yNEWUeDj/sq/VaRaR0wFuM7vXR7+qlwc1KQBz2CfuGc78KpWJAfxRIiEsW96FlW43zN+
         RnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DkKhQJ4Pds0nZdicrR0hNgUOTeU+fUks0rdHCpFbvjk=;
        b=XFysFJCZHWCS9SraHvLLbl26wME31MRhioIOzvhtdhxMfd/CNfZMHYM7+FDvtw1UH1
         Al4f+CJrFWoObVNNCpEMUoAP86BLy9blTowGUIdUbSIRFIzkouAeFxUAYYLbbdIpJ7mk
         JLSqhgHJBpAuVUh/7Luee7s3PWxNOMkteKxz/jfTXyT1tKDHJlgToDHusm9Jwj+qsZBW
         Etnv+M21PDPCVe7EB7jzseqSquqk/6fDv/MT62MxkmVsezoBwpvnE1OdrQaVn+e/Oljw
         7I5yYYB2mq62rzHvUpM9NNH+kXjXjePDf0YWVs8c6NrQmLM5gHgGfncSxVPS30uP+d0s
         sZdw==
X-Gm-Message-State: AOUpUlGnHv3cODSO3jdCCsZaw2b9WyPiFvSWSC16XcbzETebPYjkmQFC
        CqxrAY1NJDAcnAaAbAjfHheeaTZz
X-Google-Smtp-Source: AAOMgpcSWnoHb1SVul2AnA4Har1tRi6aOC/nYcwhjutD9Lx1xuCaScVEHP/fOOOVxye7f7noIihvnw==
X-Received: by 2002:adf:d4c4:: with SMTP id w4-v6mr5627709wrk.185.1531512818856;
        Fri, 13 Jul 2018 13:13:38 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id f6-v6sm14072677wrp.30.2018.07.13.13.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 13:13:38 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 09/10] staging:trl8192u: Rename TClasProc > t_clas_proc - Style
Date:   Fri, 13 Jul 2018 21:12:46 +0100
Message-Id: <20180713201247.21428-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713201247.21428-1-johnfwhitmore@gmail.com>
References: <20180713201247.21428-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the struct TS_COMMON_INFO member variable TClasProc to
t_clas_proc. This change clears the checkpatch issue with CamelCase variable
names. There should be no impact on runtime execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 4fee83f2589b..ffa2983b8f8f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -22,7 +22,7 @@ struct TS_COMMON_INFO {
 	u8				addr[6];
 	TSPEC_BODY			t_spec;
 	QOS_TCLAS			t_class[TCLAS_NUM];
-	u8				TClasProc;
+	u8				t_clas_proc;
 	u8				TClasNum;
 };
 
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index bf4f60e6aacf..1a6a0b938b63 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -106,7 +106,7 @@ static void ResetTsCommonInfo(struct TS_COMMON_INFO *pTsCommonInfo)
 	eth_zero_addr(pTsCommonInfo->addr);
 	memset(&pTsCommonInfo->t_spec, 0, sizeof(TSPEC_BODY));
 	memset(&pTsCommonInfo->t_class, 0, sizeof(QOS_TCLAS)*TCLAS_NUM);
-	pTsCommonInfo->TClasProc = 0;
+	pTsCommonInfo->t_clas_proc = 0;
 	pTsCommonInfo->TClasNum = 0;
 }
 
@@ -281,7 +281,7 @@ static void MakeTSEntry(struct TS_COMMON_INFO *pTsCommonInfo, u8 *Addr,
 	for(count = 0; count < TCLAS_Num; count++)
 		memcpy((u8 *)(&(pTsCommonInfo->t_class[count])), (u8 *)pTCLAS, sizeof(QOS_TCLAS));
 
-	pTsCommonInfo->TClasProc = TCLAS_Proc;
+	pTsCommonInfo->t_clas_proc = TCLAS_Proc;
 	pTsCommonInfo->TClasNum = TCLAS_Num;
 }
 
-- 
2.18.0

