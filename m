Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A318C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20ABD213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeTVVCHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20ABD213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeJDDeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 23:34:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33196 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeJDDeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 23:34:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id y140-v6so101061wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 13:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yWsu3wGCchnsXwPoM2PaJi+kcx2k5ZbbN46Fqi1SzwA=;
        b=jeTVVCHKGgCQf00fVxlyYqdlY/03+gNxGdqEv/NhIh6+p6naWe1Kh/KjNMdXkctJte
         6UOfuU2xdIORiOsiAE0Fg4epXt0vsUQIdu9mm6CxMC3MIZ3KUrjMDwSqu+GwCLpMDmYL
         MYEQ6KHNjDMVTymYC0KV/NmdaxxS5otuWL1QMaoIN1Jmz3OI1C0JQlEHNPp6zpjXc7ft
         H/eTJ+CgQPUr6I88dfGA27HlWxDl/sDEa1Ls6UqQk+SOO5mZy3OHmxobuW6jtW9TiBzH
         eAh9er8Fi69expNvGoufQnJnqSXJMLdAJrOcBmOX2v9Q48IH2Y7r1ChFzDPd2AfQUbS9
         8cBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yWsu3wGCchnsXwPoM2PaJi+kcx2k5ZbbN46Fqi1SzwA=;
        b=aZman2IzQY8csdYk8T1yzQvFioOBrw7YHRtlDSuV2wGDMY14UXDR32TZRo6z5GNeHK
         FYXeZolIYfngdeUgbR/Skl+DTThA7GQgnri0gqjHc78qGc8f/OnJiZB524VQTo4LnDnK
         5rsukWJ5OPH20b1Pu6Tohm9qRfQPzonkzaFS94JRvAloGDQYkAtmUONYwU9nfLTNjWpl
         BXcGQOepYWxTWFjiuzW3SrGaLY8PGIfl48unRm2zkwMAw5EGKBFAiVHmHCN4Ith0S402
         mzu1CI8/RYFRix4ru2tBS9AvzjusardyTa45a5P18yTx5h/ia/Yir9MRYsXReCFrtJ1I
         9ehQ==
X-Gm-Message-State: ABuFfogzIPf3LugTRuM2h4SGkP6UI+BWA9E6T3YvEBIj30tYLTGeYfN3
        rd9IehzwyYj0fDpyZtaN5fQ=
X-Google-Smtp-Source: ACcGV618sEQ6yofaXBZuuwvk/tb4rkaqV8PM+3DICX+0t3pneOgI/P6lF/S8sgNg+8T4puCTWwxdOA==
X-Received: by 2002:a1c:a9d4:: with SMTP id s203-v6mr2519073wme.58.1538599446833;
        Wed, 03 Oct 2018 13:44:06 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd55.dynamic.kabel-deutschland.de. [31.18.253.85])
        by smtp.gmail.com with ESMTPSA id h18-v6sm2242235wrb.82.2018.10.03.13.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 13:44:06 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: rtl8188eu: cleanup array declaration - style
Date:   Wed,  3 Oct 2018 22:43:58 +0200
Message-Id: <20181003204359.30676-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003204359.30676-1-straube.linux@gmail.com>
References: <20181003204359.30676-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup array declaration to clear two 'line over 80 characters'
checkpatch warnings and improve readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 32 ++++++++-----------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index f6171f07599d..f03ac89736de 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -3836,24 +3836,20 @@ Following are the initialization functions for WiFi MLME
 *****************************************************************************/
 
 static struct mlme_handler mlme_sta_tbl[] = {
-	{WIFI_ASSOCREQ,		"OnAssocReq",	&OnAssocReq},
-	{WIFI_ASSOCRSP,		"OnAssocRsp",	&OnAssocRsp},
-	{WIFI_REASSOCREQ,	"OnReAssocReq",	&OnAssocReq},
-	{WIFI_REASSOCRSP,	"OnReAssocRsp",	&OnAssocRsp},
-	{WIFI_PROBEREQ,		"OnProbeReq",	&OnProbeReq},
-	{WIFI_PROBERSP,		"OnProbeRsp",		&OnProbeRsp},
-
-	/*----------------------------------------------------------
-					below 2 are reserved
-	-----------------------------------------------------------*/
-	{0,					"DoReserved",		&DoReserved},
-	{0,					"DoReserved",		&DoReserved},
-	{WIFI_BEACON,		"OnBeacon",		&OnBeacon},
-	{WIFI_ATIM,			"OnATIM",		&OnAtim},
-	{WIFI_DISASSOC,		"OnDisassoc",		&OnDisassoc},
-	{WIFI_AUTH,			"OnAuth",		&OnAuthClient},
-	{WIFI_DEAUTH,		"OnDeAuth",		&OnDeAuth},
-	{WIFI_ACTION,		"OnAction",		&OnAction},
+	{WIFI_ASSOCREQ,	  "OnAssocReq",	  &OnAssocReq},
+	{WIFI_ASSOCRSP,	  "OnAssocRsp",	  &OnAssocRsp},
+	{WIFI_REASSOCREQ, "OnReAssocReq", &OnAssocReq},
+	{WIFI_REASSOCRSP, "OnReAssocRsp", &OnAssocRsp},
+	{WIFI_PROBEREQ,	  "OnProbeReq",	  &OnProbeReq},
+	{WIFI_PROBERSP,	  "OnProbeRsp",	  &OnProbeRsp},
+	{0,		  "DoReserved",	  &DoReserved},
+	{0,		  "DoReserved",	  &DoReserved},
+	{WIFI_BEACON,	  "OnBeacon",	  &OnBeacon},
+	{WIFI_ATIM,	  "OnATIM",	  &OnAtim},
+	{WIFI_DISASSOC,	  "OnDisassoc",	  &OnDisassoc},
+	{WIFI_AUTH,	  "OnAuth",	  &OnAuthClient},
+	{WIFI_DEAUTH,	  "OnDeAuth",	  &OnDeAuth},
+	{WIFI_ACTION,	  "OnAction",	  &OnAction},
 };
 
 int init_hw_mlme_ext(struct adapter *padapter)
-- 
2.19.0

