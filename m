Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FCFECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B0E2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxJEnoAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B0E2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbeGMU3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:29:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37157 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732598AbeGMU3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:29:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id n17-v6so10482628wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 13:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s8lTm1Z6epqq+e5BUDGyo/zMRNY8ddGA9ZGDa58gLvg=;
        b=rxJEnoAw0EQB2BhVdpzq+resRrni9f7529LmBYB/uAxOdBsHqXmKcE0iSMa78wQxUq
         7Sfbf2yvFYGbFPL5Ai3v/daSrkNqJeJwsBBXyZnybz8XaA6dlSctbJ5o8vURlcIpmZCq
         ViQYVvrGpxNGRW/PQTi2kTB+i8kuRyVWSNwCoXxgdbxkZEUlIsG4FxgqJ4RMofWHAQCi
         kSPb+hHAHyCEGBz6qpWWTtpEucIm52DY9V09jxNwKH6bSFoSBgHw6lq2lgowI2075DsC
         n50T2d12wHZyaxoTKhrCrVf8uBpFfBhGoWoX3buZj0SMO6X+cHAoeFsGsCmjc1MN3M2L
         UlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s8lTm1Z6epqq+e5BUDGyo/zMRNY8ddGA9ZGDa58gLvg=;
        b=Wrxrx/0dwYw6xhv/6OK9+Zdgd+ssM8vTlWq92zbnXkCiJoB94Yvtwm2IOIoKrT2zs1
         v4JLd8Zj64ozDcc0WG/M1g/1eStZpdyAtXUAg18P/Srd+ayn2qVwY4uqMLIoXCEJU0uZ
         nVDci1fjI0y4hRAwrBJ6OUVbg5j0aDJqP2D3jg/4r3UZYflzxBupzvlY3b12X+kmtvDg
         sza3RjA9Vid5D1dg8EAmWU59RcNL2VbKaAzQ8yG85XF3AV8NCeKArRGLmu3Ko0YdwAM0
         OSgf+LCy9zhSMnMhak0N9joNwGk754ejYXjDOx2b7V7mM2HsDc1tLW/MFeoPUF4N4s34
         5Zmw==
X-Gm-Message-State: AOUpUlGEem31hQMrPPoKWIbRUWl4Dngesk4L10rIpG3Tqh3uf7qsHAM1
        FgEuhr8K1xZochjFN6oWth7HWwtj
X-Google-Smtp-Source: AAOMgpdN0NrelWchRb1Lh2xNSzTHDTJ3QWYpvqp3x57H6zHNyMsnLvuhcdgE+5sp3xleoW655yyatw==
X-Received: by 2002:a1c:f902:: with SMTP id x2-v6mr4466942wmh.116.1531512817382;
        Fri, 13 Jul 2018 13:13:37 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id f6-v6sm14072677wrp.30.2018.07.13.13.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 13:13:36 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/10] staging:rtl8192u: Rename TClass > t_class - Style
Date:   Fri, 13 Jul 2018 21:12:45 +0100
Message-Id: <20180713201247.21428-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713201247.21428-1-johnfwhitmore@gmail.com>
References: <20180713201247.21428-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the struct TS_COMMON_INFO member variable from TClass to t_class. This
change clears the checkpatch issue with CamelCase Variable names. There should
be no impact on runtime execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index d84092d17441..4fee83f2589b 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -21,7 +21,7 @@ struct TS_COMMON_INFO {
 	struct timer_list		inact_timer;
 	u8				addr[6];
 	TSPEC_BODY			t_spec;
-	QOS_TCLAS			TClass[TCLAS_NUM];
+	QOS_TCLAS			t_class[TCLAS_NUM];
 	u8				TClasProc;
 	u8				TClasNum;
 };
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 8df665f4028d..bf4f60e6aacf 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -105,7 +105,7 @@ static void ResetTsCommonInfo(struct TS_COMMON_INFO *pTsCommonInfo)
 {
 	eth_zero_addr(pTsCommonInfo->addr);
 	memset(&pTsCommonInfo->t_spec, 0, sizeof(TSPEC_BODY));
-	memset(&pTsCommonInfo->TClass, 0, sizeof(QOS_TCLAS)*TCLAS_NUM);
+	memset(&pTsCommonInfo->t_class, 0, sizeof(QOS_TCLAS)*TCLAS_NUM);
 	pTsCommonInfo->TClasProc = 0;
 	pTsCommonInfo->TClasNum = 0;
 }
@@ -279,7 +279,7 @@ static void MakeTSEntry(struct TS_COMMON_INFO *pTsCommonInfo, u8 *Addr,
 		memcpy((u8 *)(&(pTsCommonInfo->t_spec)), (u8 *)pTSPEC, sizeof(TSPEC_BODY));
 
 	for(count = 0; count < TCLAS_Num; count++)
-		memcpy((u8 *)(&(pTsCommonInfo->TClass[count])), (u8 *)pTCLAS, sizeof(QOS_TCLAS));
+		memcpy((u8 *)(&(pTsCommonInfo->t_class[count])), (u8 *)pTCLAS, sizeof(QOS_TCLAS));
 
 	pTsCommonInfo->TClasProc = TCLAS_Proc;
 	pTsCommonInfo->TClasNum = TCLAS_Num;
-- 
2.18.0

