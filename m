Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4868C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A90A2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ/Sb0Mq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfAaIzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:55:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39954 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfAaIzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:55:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so2310231wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 00:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gybmd0zI2FuhEwlh/WUjOKbn6A7eyvCLAinW5T6Jumg=;
        b=RJ/Sb0MqgdyoZABJKcVdK4uD3BJ/T0XLGpQzguTCfuLwFMN56QaIj9wtwYGQYwTWhT
         PEN6+gSOYbpDMWLC+gsOKAhIrsfMZV4/FFUYSig/X0b3JVOVKLvF2y3XXSV67pJ7DYtC
         9S55d/hcwRf1dbn6J2PXObyO1aX+OxkBhc9T2NADigGEn4m/ZyXUGSal/Usa+WOvxxqb
         saEtWu0P+4OFFxiSHGySPFtRIrYF5FOqCNKSXECszVJmUoz1MAyaXpfX/CxDjzeYKddf
         bNJtzTiwzuiz706NF3VzGlb6Sn2k/kZS0YJ4POGv7BiJcvEDUwex5iNlJMNBSLaD5V+T
         7Yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gybmd0zI2FuhEwlh/WUjOKbn6A7eyvCLAinW5T6Jumg=;
        b=j2hEu/RpLPU1hk/fIWowEFIxtC8xLvyAOQK63gh2ZfvbdDEeCWaK2RoQvvZW8xW9Vs
         Jeym2HUvbZBpcJ0zWLovLsCo2giM3f7gNVFHEFLMupFTIgwcDJPvnmRYQi16Ud4cH3n8
         MDt+wHfd+5ozjrqbe3/LSlvmePTCeMN9OfrnjJ3VI+eBbtQhvMMk3g/8xkj6IMXXTnxZ
         xbdMgDJ0i26o9pvxO0JSBH6m9FcFmlb29XBzWHXGu7dRmnGEMliueoRfHmNnJOKuQERR
         lbcMX3zlTfCpMiYZFpJzdVES+i5cK/MwoJxH03T9co0oo+435aQ55e7PFqu1ODwpErQQ
         YzaA==
X-Gm-Message-State: AJcUukefkvTKkk5bJyV/32tCyUznT5GCs32ElKdOt3HJ9WscvcUEa0rI
        yz6qi887Mji0kI5DOSSbX5Y=
X-Google-Smtp-Source: ALg8bN5uRTx5Nl9FJW/yaqIg0CVsFppDfrUR5TIyX3m6dGK1DSfQEwU9c3EQThT6LoUpwvh5/BBclg==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr32141445wrn.157.1548924941780;
        Thu, 31 Jan 2019 00:55:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id p10sm12626295wmd.14.2019.01.31.00.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 00:55:40 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: cleanup ODM_CmnInfoPtrArrayHook()
Date:   Thu, 31 Jan 2019 09:55:30 +0100
Message-Id: <20190131085530.5697-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert single case switch to if statement to cleanup and
simplify code in ODM_CmnInfoPtrArrayHook().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
index 1165ee278536..ba3c3e5a8216 100644
--- a/drivers/staging/rtl8188eu/hal/odm.c
+++ b/drivers/staging/rtl8188eu/hal/odm.c
@@ -209,17 +209,8 @@ void ODM_DMWatchdog(struct odm_dm_struct *pDM_Odm)
 
 void ODM_CmnInfoPtrArrayHook(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def CmnInfo, u16 Index, void *pValue)
 {
-	/*  Hook call by reference pointer. */
-	switch	(CmnInfo) {
-	/*  Dynamic call by reference pointer. */
-	case	ODM_CMNINFO_STA_STATUS:
+	if (CmnInfo == ODM_CMNINFO_STA_STATUS)
 		pDM_Odm->pODM_StaInfo[Index] = (struct sta_info *)pValue;
-		break;
-	/* To remove the compiler warning, must add an empty default statement to handle the other values. */
-	default:
-		/* do nothing */
-		break;
-	}
 }
 
 void odm_CommonInfoSelfInit(struct odm_dm_struct *pDM_Odm)
-- 
2.20.1

