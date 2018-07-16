Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE8BECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C42D208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImP3kGRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C42D208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbeGPTe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:34:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42296 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbeGPTe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:34:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4-v6so2355105edp.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 12:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WIZqfHE1Qd80RpmMC7xIFyi6hrHhzmdnHXbUwW0bY2w=;
        b=ImP3kGRS5tQAl1gPX5l5OnPApkL3E9SoibfGXPpr49WtUMNubZzmVd+sFp4YQDZA47
         EewAgWDkxpAmZt9FwPcwF1tA8qXXJVqxNsAM58mPvtaYzU+WjadmJpxNNTvJEfQi/rAz
         bNivvGeaIVyEhkgbNhh/MyKbiNmXXmdMIEqUqoXVqo5A2QmN60OCN8dk2pZLnRRrDtCl
         yPMJKKvOcNXMGelp4JUZcVSGWKJ7l3Cy2QdHCTndBrlCTkZ/ss034NQjWCz0OfVxaQbV
         tKVzy6c7JHwOoCDenPSKak/wLSw9+WOSTH89xkI/63Mo6apLV6g18OlLA3Beew3Flmjf
         dOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WIZqfHE1Qd80RpmMC7xIFyi6hrHhzmdnHXbUwW0bY2w=;
        b=Dwzo4acXtt4O2Z0JgiU3fpYfhsbH5k19uBqNWDmCw/yNgUtZzT8NA6zSUUkLczp3ZB
         y/WkN0Ezq8rYh40IZq7oHiyi4d9WcMBaOsiG5+LqL7/3rrj3svVAK8yI0sszK8+1iQjT
         k1e1WF8HJQyKjzGEiYovq9i5lK99UT4oNLLoL6xAq/TrIJaBDfjTzi77KgGss1Wb30YR
         Aa9ysUXwbC97Yk+7XhRPzymY8sE4pAtgFxqThM8TO8upqAd0n6WbfKo8kwmWRQY6zvCb
         6p/znFI0e493g3b/fE3LEkiBkDT9OR9DgsiIbSXvHy8IajgJfh9fS8RGFhrkXPOdlzmz
         ViPg==
X-Gm-Message-State: AOUpUlGev/o/FH8eqAQssCL2Y2FgRyGd5YBx8FHjZ6tqeeYYRdE0o+y+
        OOmCCL1QCMnotuyEf92/kbww2A==
X-Google-Smtp-Source: AAOMgpelns5BtfZDTF3QlSsecq/OWx5pIp+/9pYGhRwmW59PTB03Q1o3oHPm4pzrloAazMoGCfnGGg==
X-Received: by 2002:a50:af45:: with SMTP id g63-v6mr19180476edd.30.1531767938743;
        Mon, 16 Jul 2018 12:05:38 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.220])
        by smtp.gmail.com with ESMTPSA id g14-v6sm19098643edm.25.2018.07.16.12.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 12:05:38 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 10/10] staging:rtl8192u: Rename TClasNum > t_clas_num - Style
Date:   Mon, 16 Jul 2018 20:04:54 +0100
Message-Id: <20180716190454.31489-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716190454.31489-1-johnfwhitmore@gmail.com>
References: <20180716190454.31489-1-johnfwhitmore@gmail.com>
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
index a183198afb31..3da1ef6ef105 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -23,7 +23,7 @@ struct ts_common_info {
 	TSPEC_BODY			t_spec;
 	QOS_TCLAS			t_class[TCLAS_NUM];
 	u8				t_clas_proc;
-	u8				TClasNum;
+	u8				t_clas_num;
 };
 
 typedef struct _TX_TS_RECORD {
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 8b2bb0a69b01..4b2da7f31166 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -107,7 +107,7 @@ static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
 	memset(&pTsCommonInfo->t_spec, 0, sizeof(TSPEC_BODY));
 	memset(&pTsCommonInfo->t_class, 0, sizeof(QOS_TCLAS)*TCLAS_NUM);
 	pTsCommonInfo->t_clas_proc = 0;
-	pTsCommonInfo->TClasNum = 0;
+	pTsCommonInfo->t_clas_num = 0;
 }
 
 static void ResetTxTsEntry(PTX_TS_RECORD pTS)
@@ -282,7 +282,7 @@ static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *Addr,
 		memcpy((u8 *)(&(pTsCommonInfo->t_class[count])), (u8 *)pTCLAS, sizeof(QOS_TCLAS));
 
 	pTsCommonInfo->t_clas_proc = TCLAS_Proc;
-	pTsCommonInfo->TClasNum = TCLAS_Num;
+	pTsCommonInfo->t_clas_num = TCLAS_Num;
 }
 
 
-- 
2.18.0

