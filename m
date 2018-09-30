Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528D1C64EB1
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7DE2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAfQqflD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7DE2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbeJAC1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:27:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52856 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbeJAC1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:27:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id 189-v6so6345328wmw.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 12:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tc/mW12bt8NG6FO+2FjBE6uSOZID/zAOL79X00wvyic=;
        b=YAfQqflDQT7aIA79CgbqkC2bU11CtXaUPUIZpjkyJcSUE6+3b5mPAIhFbRdKiN2Mci
         TKklQoByRq7wOaQvF2BmaYWOx//54ae8nbKKfoiTIX79bhMuTRPppMAdhwet9wyauQjt
         JUmaoTR7HMKdxuGHswwVqnD6ytriNQM8C4sLacGhKv7R9JzNtKrVlsw9fYyxIOqVMC7H
         x84AIQMd6CBMHpOfMJdG8VFu6lDNhHt9TAGxfRQncVHrT/HPDe7ZaKnng5EsO0813MiP
         7RZyqOnor85WSl0mAN/NAPaQ6/w9hwLh30wCbDkhFre5p1mhxB3uKWQ363TzNiFRHyKr
         97MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tc/mW12bt8NG6FO+2FjBE6uSOZID/zAOL79X00wvyic=;
        b=dlmKxwQi4xZnrTPSNR1K+0oTAmhpluYp2dJHrsRs/pcgkgs0TYf7Ru8vsYlG2WQz+C
         msSrA7phLhzSFG5UMvJGabq3G1VOj29Deufyw3rS7xaJYSoIA35hvDP9n2Akbx9l4UhC
         ykbYtgb6iIF9i5UxD+kfiCsvv9Ov3JA2X+1eETBCXf4W14Z9Sj6XM2TGGuHjkz3Y9Owp
         E6LpkhcIY2UNuMjF2ez8pJOoEH5TicRNLxP/QnuSyJxZ+kPNtGg+b1cqS2+RPHYLfHBz
         /pRf7/OuENNYYqVddaVQIlJijJclXRhuFT/YyNmAzDM/Cd9XURzkYmUArx7PZK4Th9kg
         cRSA==
X-Gm-Message-State: ABuFfojfDZY/jta3BW3yrxXFOnmi2Ws+p7Tjd5iDx3OIw3xl5Lgu08+u
        OgUFSro8McxbG8DKZkEXdTE=
X-Google-Smtp-Source: ACcGV61e/nAMjT6NXRSQ0eMcyV1Ui1ERgHnwH0C9ZL3389oBoJvvHOaeFENBrlPJsVrxpZ3F78Uy0g==
X-Received: by 2002:a1c:700a:: with SMTP id l10-v6mr6827793wmc.90.1538337210679;
        Sun, 30 Sep 2018 12:53:30 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd19.dynamic.kabel-deutschland.de. [31.18.253.25])
        by smtp.gmail.com with ESMTPSA id w26-v6sm6500775wmi.27.2018.09.30.12.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 12:53:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 11/19] staging: rtl8188eu: rename parameter of odm_SignalScaleMapping()
Date:   Sun, 30 Sep 2018 21:53:02 +0200
Message-Id: <20180930195310.1531-11-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930195310.1531-1-straube.linux@gmail.com>
References: <20180930195310.1531-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename parameter of odm_SignalScaleMapping() to avoid CamelCase.
CurrSig -> currsig

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 31 ++++++++++----------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index 6d7c379c4444..25a6531ddf02 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -26,26 +26,27 @@ static u8 odm_query_rxpwrpercentage(s8 antpower)
 
 /*  2012/01/12 MH MOve some signal strength smooth method to MP HAL layer. */
 /*  IF other SW team do not support the feature, remove this section.?? */
-static s32 odm_SignalScaleMapping(struct odm_dm_struct *dm_odm, s32 CurrSig)
+static s32 odm_SignalScaleMapping(struct odm_dm_struct *dm_odm, s32 currsig)
 {
 	s32 RetSig = 0;
 
-	if (CurrSig >= 51 && CurrSig <= 100)
+	if (currsig >= 51 && currsig <= 100)
 		RetSig = 100;
-	else if (CurrSig >= 41 && CurrSig <= 50)
-		RetSig = 80 + ((CurrSig - 40) * 2);
-	else if (CurrSig >= 31 && CurrSig <= 40)
-		RetSig = 66 + (CurrSig - 30);
-	else if (CurrSig >= 21 && CurrSig <= 30)
-		RetSig = 54 + (CurrSig - 20);
-	else if (CurrSig >= 10 && CurrSig <= 20)
-		RetSig = 42 + (((CurrSig - 10) * 2) / 3);
-	else if (CurrSig >= 5 && CurrSig <= 9)
-		RetSig = 22 + (((CurrSig - 5) * 3) / 2);
-	else if (CurrSig >= 1 && CurrSig <= 4)
-		RetSig = 6 + (((CurrSig - 1) * 3) / 2);
+	else if (currsig >= 41 && currsig <= 50)
+		RetSig = 80 + ((currsig - 40) * 2);
+	else if (currsig >= 31 && currsig <= 40)
+		RetSig = 66 + (currsig - 30);
+	else if (currsig >= 21 && currsig <= 30)
+		RetSig = 54 + (currsig - 20);
+	else if (currsig >= 10 && currsig <= 20)
+		RetSig = 42 + (((currsig - 10) * 2) / 3);
+	else if (currsig >= 5 && currsig <= 9)
+		RetSig = 22 + (((currsig - 5) * 3) / 2);
+	else if (currsig >= 1 && currsig <= 4)
+		RetSig = 6 + (((currsig - 1) * 3) / 2);
 	else
-		RetSig = CurrSig;
+		RetSig = currsig;
+
 	return RetSig;
 }
 
-- 
2.19.0

