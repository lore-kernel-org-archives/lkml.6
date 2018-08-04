Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DF7C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBBE217BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8LO9JL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBBE217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733135AbeHDLTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:19:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54664 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732384AbeHDLTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:19:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so8696809wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 02:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eIM+oFDIyMU+vtuKm+REDkQwP8mECokcffPrDbr4N84=;
        b=j8LO9JL+hfWXpxzJrokOSjRNmp0tv1Cr5Vu971Ur2US9lHe1sP3WXuM9/fD4E0XsBQ
         mCZrhASLaPQbnPNkvZhkjsrPkhfAWdZSfAWoTyR3Z0WrLAOR3uupz6fPFFm09irmd4+9
         psa78rj8GVD9pWRHXqR3pyk3rd2j9/t1bdw7UdRguTA9w6UHb834o/KOlcYVHDnCZvfa
         XZ3gWhltP3Q9ZQYfBHBS9v3wf+BHwSvKHHpRUyHzUSszLKFsdnx0WtXkHbU8nK40KjV+
         92B2p3Bg99kvcG/VLHgJljXdLgUd+8SktKMDPZGx0zfZx0xSBvOgji5/JYhrqycUVwDD
         AMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eIM+oFDIyMU+vtuKm+REDkQwP8mECokcffPrDbr4N84=;
        b=k3n1dIyn3fyIJ6uqh2rnjHhh2FSZf/NYS77/QQ0cYjl1gtjbhhJZeMUufOkThU0ecZ
         kGLJS86tceRC/KUAAgZEJUkOAVsWIMU4FeYKqSO3Iyq5loB8ck95KiNpNZTod3Sm7IfJ
         eDIwHhBUo+edZzqHrxQyUao2aXMd7mQWNgOKHTO9cASHUOfsm5Q4n21mhgu09nK/iJeg
         XyDiGVYZFnHLUEfg7FaXOyG91s+KBiczULbrDOjR6iR+ef3TAousTRYwwLmcja9AhpS3
         UUMVyIfVYEqm5sH/xeqhT5Oj8BdH9oLItXlaeE4/bFVDVr078cId7b83jpKsTT01EApJ
         Bihg==
X-Gm-Message-State: AOUpUlGnwMzquMG5WZ7upLj+LRy+8HLGFw1alO80oeDf5xdp27vMAmOI
        wGHo/gkJOUSl1z9a+lCXmNwpNN1imf0=
X-Google-Smtp-Source: AAOMgpe11qWx1d6kjVTHXUmzoFGkNYqfrNU6BXI0A55kAoWiTMY7Qt7yQajtk43jsEk0sYE8gKkvmA==
X-Received: by 2002:a1c:92:: with SMTP id 140-v6mr6484251wma.87.1533374346723;
        Sat, 04 Aug 2018 02:19:06 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id q188-v6sm2710040wmd.36.2018.08.04.02.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 02:19:05 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 1/7] staging:rtl8192u: Remove typedef and rename QOS_TCLAS - Style
Date:   Sat,  4 Aug 2018 10:18:53 +0100
Message-Id: <20180804091859.6729-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804091859.6729-1-johnfwhitmore@gmail.com>
References: <20180804091859.6729-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the typedef from the union QOS_TCLAS, which causes a checkpatch
issue with defining new types. In addition, as a type, the name should
be in lowercase so has been changed.

These are coding style changes and should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     | 6 +++---
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 5cf00a2e08ae..823ba363e0ab 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -14,7 +14,7 @@ enum tr_select {
 	RX_DIR = 1,
 };
 
-typedef union _QOS_TCLAS {
+union qos_tclas {
 
 	struct _TYPE_GENERAL {
 		u8		Priority;
@@ -63,7 +63,7 @@ typedef union _QOS_TCLAS {
 		u8		Mask;
 		u16		TagType;
 	} TYPE2_8021Q;
-} QOS_TCLAS, *PQOS_TCLAS;
+};
 
 struct ts_common_info {
 	struct list_head		list;
@@ -71,7 +71,7 @@ struct ts_common_info {
 	struct timer_list		inact_timer;
 	u8				addr[6];
 	struct tspec_body		t_spec;
-	QOS_TCLAS			t_class[TCLAS_NUM];
+	union qos_tclas			t_class[TCLAS_NUM];
 	u8				t_clas_proc;
 	u8				t_clas_num;
 };
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index de06cd11ab65..d46d8f468671 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -105,7 +105,7 @@ static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
 {
 	eth_zero_addr(pTsCommonInfo->addr);
 	memset(&pTsCommonInfo->t_spec, 0, sizeof(struct tspec_body));
-	memset(&pTsCommonInfo->t_class, 0, sizeof(QOS_TCLAS)*TCLAS_NUM);
+	memset(&pTsCommonInfo->t_class, 0, sizeof(union qos_tclas)*TCLAS_NUM);
 	pTsCommonInfo->t_clas_proc = 0;
 	pTsCommonInfo->t_clas_num = 0;
 }
@@ -265,7 +265,7 @@ static struct ts_common_info *SearchAdmitTRStream(struct ieee80211_device *ieee,
 }
 
 static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *Addr,
-			struct tspec_body *pTSPEC, PQOS_TCLAS pTCLAS, u8 TCLAS_Num,
+			struct tspec_body *pTSPEC, union qos_tclas *pTCLAS, u8 TCLAS_Num,
 			u8 TCLAS_Proc)
 {
 	u8	count;
@@ -279,7 +279,7 @@ static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *Addr,
 		memcpy((u8 *)(&(pTsCommonInfo->t_spec)), (u8 *)pTSPEC, sizeof(struct tspec_body));
 
 	for(count = 0; count < TCLAS_Num; count++)
-		memcpy((u8 *)(&(pTsCommonInfo->t_class[count])), (u8 *)pTCLAS, sizeof(QOS_TCLAS));
+		memcpy((u8 *)(&(pTsCommonInfo->t_class[count])), (u8 *)pTCLAS, sizeof(union qos_tclas));
 
 	pTsCommonInfo->t_clas_proc = TCLAS_Proc;
 	pTsCommonInfo->t_clas_num = TCLAS_Num;
-- 
2.18.0

