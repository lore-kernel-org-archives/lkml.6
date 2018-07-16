Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863D8ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42509208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIFW+nEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42509208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbeGPTeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:34:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41484 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbeGPTeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:34:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id s24-v6so14571166edr.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 12:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F9cNfMjeUVYjis2PO9z/kaiGpZ9SbXNz2HCdhoGsT44=;
        b=qIFW+nEQey0o/Co90vY+j2WAoNMOIhD5F9KIghT9riBKMLgztwDXuZ1ENuahwiuMz0
         +1Va5OTGaX7A4QmtFluYZo5cEUcWrfCSxzujje7UMwzVzA5agIFcnlTP6QBEJw7vINRu
         kUoscP0eN44dzsuaPfXYRDpLPHVkPKSKlP8Ovswiz49AOSFy2D+25ZFLNj2eUJIzxa64
         6e+vBDtkfvcflQZPCbSRtEGB2kBIvTU6bTefNhSeXD2OAhnt5TkzBiXNIiuhsYDWitce
         7iDY6iY0KecuPOudc9MwfWzHN2raydsQ3zXL6uwR8fI3A8OqVZcBWV3ZHtUY85AkIQ2p
         o1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F9cNfMjeUVYjis2PO9z/kaiGpZ9SbXNz2HCdhoGsT44=;
        b=nXcqA21qNxAxnPWMYGeXJ20jd4zSUfWQ7r7Sbydmp3SHUjrXNq5pKE7ee5rOXpWi5X
         LCHNP+uEoTIbI5D+OPEIEx/RjCZ9Z0ZSH1gY84JYTXsx0z0+hvB314RuZaXEP4Xv52VN
         p+p+7VuAd2v+0WBJQkXCpOcAVHpdaZr6Q45WsPrlO/QhjBJpVueFM1a8l6sWFHgG6mye
         mD+YoxNOg6uOxcflZ45z3RSnZhr5gMPQmJ0z+RKWW+0ZAVAg/9adaJNApYyA/nPEk+Fz
         nggjYHv4no3vGGX0XodylqvEKxwnvzZGoIPWorYs76GK5FVXo5NNsNSuiXVcoPfnILHl
         hnLg==
X-Gm-Message-State: AOUpUlGwTqn59tDlt3zM4XLoAl0+fZi4qFmNXM5hA2WJPIq8iIvLqp4v
        p2L3pTHBB5xSR6rqcz/9IUCkmg==
X-Google-Smtp-Source: AAOMgpd95Gfpd6LRlPaXKJBt/sOz1RtVrVNC2KxiCzLSqpaO4AvuTIB5aEGuWAIhzvrq9PW3GwWC/g==
X-Received: by 2002:a50:aca3:: with SMTP id x32-v6mr18063556edc.41.1531767937285;
        Mon, 16 Jul 2018 12:05:37 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.220])
        by smtp.gmail.com with ESMTPSA id g14-v6sm19098643edm.25.2018.07.16.12.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 12:05:36 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 09/10] staging:trl8192u: Rename TClasProc > t_clas_proc - Style
Date:   Mon, 16 Jul 2018 20:04:53 +0100
Message-Id: <20180716190454.31489-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716190454.31489-1-johnfwhitmore@gmail.com>
References: <20180716190454.31489-1-johnfwhitmore@gmail.com>
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
index 3bf48a04a68e..a183198afb31 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -22,7 +22,7 @@ struct ts_common_info {
 	u8				addr[6];
 	TSPEC_BODY			t_spec;
 	QOS_TCLAS			t_class[TCLAS_NUM];
-	u8				TClasProc;
+	u8				t_clas_proc;
 	u8				TClasNum;
 };
 
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index b5fede650b81..8b2bb0a69b01 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -106,7 +106,7 @@ static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
 	eth_zero_addr(pTsCommonInfo->addr);
 	memset(&pTsCommonInfo->t_spec, 0, sizeof(TSPEC_BODY));
 	memset(&pTsCommonInfo->t_class, 0, sizeof(QOS_TCLAS)*TCLAS_NUM);
-	pTsCommonInfo->TClasProc = 0;
+	pTsCommonInfo->t_clas_proc = 0;
 	pTsCommonInfo->TClasNum = 0;
 }
 
@@ -281,7 +281,7 @@ static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *Addr,
 	for(count = 0; count < TCLAS_Num; count++)
 		memcpy((u8 *)(&(pTsCommonInfo->t_class[count])), (u8 *)pTCLAS, sizeof(QOS_TCLAS));
 
-	pTsCommonInfo->TClasProc = TCLAS_Proc;
+	pTsCommonInfo->t_clas_proc = TCLAS_Proc;
 	pTsCommonInfo->TClasNum = TCLAS_Num;
 }
 
-- 
2.18.0

