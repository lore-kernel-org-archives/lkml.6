Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACF0ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BDE20B80
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSVvUZPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BDE20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbeGPTeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:34:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39096 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731221AbeGPTeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:34:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id w14-v6so30761422eds.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 12:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gaOacuA2ODk1L17e/+J9oY/OoXrVG/ZCnRNPWw1mGWQ=;
        b=mSVvUZPly3IP5eYWzosmHYCIw2UQrXo27uH3EZR0JP/Z7l3Vp1oKRXFZrt3o0eQckn
         s2j0OTC5PBlD+siRVOrC5oaWcK0M0bYPlddV5jYdAjNQ7S145Ae70gLpErNqWhhm67AW
         C9nhfBWydNJDRHYF99Mr6QJZd5Lv67nrqaZ4hfmlcelqTYWnWwGRVckC8F6RIh5d5F+L
         9XMu9VS32GNhCMpACUzSadf8KKCPmy5NxDYb6tSQFrdJXvxq7XdSePVSUztInPyo0Vr5
         L9+0hW1HWlbg2aZcTTQ1+7QkXWTgf5LIqC5TZBPhfQqxuOTmq9+h82PTnN28U9jjVGIb
         jI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gaOacuA2ODk1L17e/+J9oY/OoXrVG/ZCnRNPWw1mGWQ=;
        b=K54+CWzwok4mY7Y+m2h1rk7Zr2uMHZ3iBBtFZ4FgYF3Ceau7D85XdZQbYTo064dQ42
         2wGaHyMam19FPhwUyqeHpt6theGqbvN26DTlLd43tF0agcBRctrl7eSLVSiqKqz+VAng
         soBSiqcoQ59FWqMMC5peAGlQL7e4TiSL6+nerf17CApXqDmSUHip+Y+jeDl93OOsrCIg
         H+m/qN+MIMeM5sHiAijl7efgNLkw+iEBwdNu3tCKjpX8LCpTGbuCu//6H/XqSPS1Qit2
         WR1I8HFYC1KktRXKFcwhLaMBrUC+JpQifjAXRddqCC/kfGF1hJ8tMO85opXD/oVuR4w7
         zaRg==
X-Gm-Message-State: AOUpUlHZ1Sx9ez5FnUwiyOp2tpw+Huzv7In9M772yXGlnSm3yDWorSwR
        j0P7Dfkh9ynJo3TfkkUewvTC9w==
X-Google-Smtp-Source: AAOMgpf4lS+7TwV0MfOvaCafScEWpiR/spgbJs2J1jyTrvrXmtuNco9mfLV9W5VEBuOvZGzN/swMuQ==
X-Received: by 2002:aa7:d88c:: with SMTP id u12-v6mr18521774edq.116.1531767935858;
        Mon, 16 Jul 2018 12:05:35 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.220])
        by smtp.gmail.com with ESMTPSA id g14-v6sm19098643edm.25.2018.07.16.12.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 12:05:35 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 08/10] staging:rtl8192u: Rename TClass > t_class - Style
Date:   Mon, 16 Jul 2018 20:04:52 +0100
Message-Id: <20180716190454.31489-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716190454.31489-1-johnfwhitmore@gmail.com>
References: <20180716190454.31489-1-johnfwhitmore@gmail.com>
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
index 4c1b2e27cf94..3bf48a04a68e 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -21,7 +21,7 @@ struct ts_common_info {
 	struct timer_list		inact_timer;
 	u8				addr[6];
 	TSPEC_BODY			t_spec;
-	QOS_TCLAS			TClass[TCLAS_NUM];
+	QOS_TCLAS			t_class[TCLAS_NUM];
 	u8				TClasProc;
 	u8				TClasNum;
 };
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index f9f4196f43fa..b5fede650b81 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -105,7 +105,7 @@ static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
 {
 	eth_zero_addr(pTsCommonInfo->addr);
 	memset(&pTsCommonInfo->t_spec, 0, sizeof(TSPEC_BODY));
-	memset(&pTsCommonInfo->TClass, 0, sizeof(QOS_TCLAS)*TCLAS_NUM);
+	memset(&pTsCommonInfo->t_class, 0, sizeof(QOS_TCLAS)*TCLAS_NUM);
 	pTsCommonInfo->TClasProc = 0;
 	pTsCommonInfo->TClasNum = 0;
 }
@@ -279,7 +279,7 @@ static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *Addr,
 		memcpy((u8 *)(&(pTsCommonInfo->t_spec)), (u8 *)pTSPEC, sizeof(TSPEC_BODY));
 
 	for(count = 0; count < TCLAS_Num; count++)
-		memcpy((u8 *)(&(pTsCommonInfo->TClass[count])), (u8 *)pTCLAS, sizeof(QOS_TCLAS));
+		memcpy((u8 *)(&(pTsCommonInfo->t_class[count])), (u8 *)pTCLAS, sizeof(QOS_TCLAS));
 
 	pTsCommonInfo->TClasProc = TCLAS_Proc;
 	pTsCommonInfo->TClasNum = TCLAS_Num;
-- 
2.18.0

