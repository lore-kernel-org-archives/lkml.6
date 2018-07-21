Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C0DECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087EA2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKAS3F/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087EA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeGUUUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:20:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38829 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbeGUUUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:20:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id t25-v6so3447103wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 12:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WIZqfHE1Qd80RpmMC7xIFyi6hrHhzmdnHXbUwW0bY2w=;
        b=pKAS3F/EbqyhWMs2rGzvQLC7HgNx/JoNOY9sGoW/y5waCH3TW+qDUHF0s/a/p8J4x6
         tef9St3k0M3wCJFIlLtiyedvf3t8kn/oUOLtUF6eK9YIza4S2e1XCQCdHw/lmLRZsTI4
         N0IhH/eCqxI1y5Y1ZfwgQ3o6yEEUHcBtJhc0g6CLLXuI3J9MyMYWrnRI++s3nDS3VyVk
         ptAsHvWwSEBiADtb5pnYlh1cj6viKfUZoAXgX5oFGCkBkjGr0XQQa5sRRY5nPsmVvzeu
         P/nsZiCMtKoW47JAD4NTViMOKpQrrN0q7dJsiVM59KnZ5hA7OuzVs6hskYYISndRgAeo
         cRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WIZqfHE1Qd80RpmMC7xIFyi6hrHhzmdnHXbUwW0bY2w=;
        b=l/lYQ2+bGUabbT9F9tSGnnxsuP+k/r+co12x/5G+O/w+w+HDMqByLoq63NJVbl0LuU
         ywxLOTudYi+Eq4PYCdbbBp9cyEdPhgloOmovObMKNx8Ka4L6b7J9pTSq73km55HtawHc
         ronKdvT8Vzn36tTpfbCaSuHTN/KutOkI8r9A3sZxubC3zcubM5viUznvdbkDiuttEg/8
         s04gwOWkVOiT9GdTS//xBYIzD2JvJd6FjzWA1Ja6MPKTTOkLLw7Xj9ax2vOQ+Kbwlb4b
         rzK3m5vpcEO91A9APB7mTHJaib3Gkdyyxtijq+0HpT1KWh8NsKnkrQECC9dbSQcZivnm
         N1fQ==
X-Gm-Message-State: AOUpUlFarlLu1RQAE0j8jx0Jh/twygJFRxNso2ubk+YmUeU1mYX+ehmo
        oRLhMd8QJeE3XnHbFultTdysEqIS
X-Google-Smtp-Source: AAOMgpfreeX9tK6pOyvmHmE1HuvyTqMhAjBLGvC6H7Tc+e4DzGs7kwWZ6Gksno5waFARbKziyxF46A==
X-Received: by 2002:a1c:8a0f:: with SMTP id m15-v6mr4218365wmd.33.1532201179926;
        Sat, 21 Jul 2018 12:26:19 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e196-v6sm11788615wmf.46.2018.07.21.12.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:26:19 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 02/10] staging:rtl8192u: Rename TClasNum > t_clas_num - Style
Date:   Sat, 21 Jul 2018 20:25:44 +0100
Message-Id: <20180721192552.5378-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721192552.5378-1-johnfwhitmore@gmail.com>
References: <20180721192552.5378-1-johnfwhitmore@gmail.com>
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

