Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C525C65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEA120892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCxS6gWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DEA120892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbeLGUzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:55:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54286 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGUzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:55:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id z18so5601618wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 12:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WmUGrvOR9rSIC6K10sYyQi7VScVtxTglX2fTId1pmn0=;
        b=vCxS6gWspPcBBtI/MDrT77TtrAXsckQ3An1/RFPLxncT0+wVMwg8eCTBiZYQr0oyNR
         fMZ2hUsbV+s6IKCvPeL8q442p+x/qhoLJxwCbOKrMtVwdEgCgjSjdkMVC+rth0kqLIok
         P9LkV9WQ4etP/sDFuqBoosOncnXCUgAdyaquyyUtcnishtiFuCqBfmMmc5RRrEfcbZ6q
         A/jqmKvwDZ8a356E0zis5KgD6rhS/Olk9rfKsXLojBaGsOGQRadbFpZcv2TNHxXjBZDT
         0hCtsSsTCD552wnlItnWg+UnmhCgAcxNdZ+2xuXwd+lC2nNUc6uA0Efdzb1CdZ+crs7Y
         i1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WmUGrvOR9rSIC6K10sYyQi7VScVtxTglX2fTId1pmn0=;
        b=aL1CSPt0CQbz8e0FHbR4a9YDVSOBsGBJpAW5A1NY8K1ilA8HdlAWWQHJ8baLFxcRKl
         9DNZhzZLyzoRB76mATVhR7elpsMlhzFmwDiG8rQ9wk0sIrf9F2tEbyq9UnPevsUXZuZE
         yzlzIeoTk1jroLOM4hsjyTCYLKxcjSRhAI+BNlrk8ANSPoznUdN2rWUFCfSIWBY5Mdik
         +Ct2ycwcKyxmsfpRX07cvDeb462SHVvczPnad0F5xLO3lUsPKbR2s897papjuA+0EWtZ
         2E3kaU9oXsFmzefisyEtm7CTWJ3tD8rlZmivF8D0ar9+67qz5hl0gsKjn/2w5wjxea7w
         5mIw==
X-Gm-Message-State: AA+aEWZUUF6Zj/NJGn0Ilby+qP+dfQntymuy5KFtOguq65xDubcdRl8e
        2yVFuJ07GfA+s/7u0Ox8YxM=
X-Google-Smtp-Source: AFSGD/XKiFX8uOiF70MARdYLOKnaYIBh/NRoiZY3ddPkAQGQ01ssNSqlfA5xt7oPy/iFqA4yHrA/pQ==
X-Received: by 2002:a7b:c191:: with SMTP id y17mr3569097wmi.10.1544216129351;
        Fri, 07 Dec 2018 12:55:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id k128sm4059413wmd.37.2018.12.07.12.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 12:55:28 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8188eu: reuse Hal_GetChnlGroup88E()
Date:   Fri,  7 Dec 2018 21:55:15 +0100
Message-Id: <20181207205515.7290-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207205515.7290-1-straube.linux@gmail.com>
References: <20181207205515.7290-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use Hal_GetChnlGroup88E() instead of duplicating it's code
in get_rx_power_val_by_reg().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rf.c              | 17 +++--------------
 .../staging/rtl8188eu/hal/rtl8188e_hal_init.c   |  2 +-
 .../staging/rtl8188eu/include/rtl8188e_hal.h    |  2 ++
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rf.c b/drivers/staging/rtl8188eu/hal/rf.c
index 81e30a1a6bfd..6fe4daea8fd5 100644
--- a/drivers/staging/rtl8188eu/hal/rf.c
+++ b/drivers/staging/rtl8188eu/hal/rf.c
@@ -164,20 +164,9 @@ static void get_rx_power_val_by_reg(struct adapter *adapt, u8 channel,
 			/*  increase power diff defined by Realtek for regulatory */
 			if (hal_data->pwrGroupCnt == 1)
 				chnlGroup = 0;
-			if (hal_data->pwrGroupCnt >= hal_data->PGMaxGroup) {
-				if (channel < 3)
-					chnlGroup = 0;
-				else if (channel < 6)
-					chnlGroup = 1;
-				else if (channel < 9)
-					chnlGroup = 2;
-				else if (channel < 12)
-					chnlGroup = 3;
-				else if (channel < 14)
-					chnlGroup = 4;
-				else if (channel == 14)
-					chnlGroup = 5;
-			}
+			if (hal_data->pwrGroupCnt >= hal_data->PGMaxGroup)
+				Hal_GetChnlGroup88E(channel, &chnlGroup);
+
 			write_val = hal_data->MCSTxPowerLevelOriginalOffset[chnlGroup][index+(rf ? 8 : 0)] +
 					((index < 2) ? powerbase0[rf] : powerbase1[rf]);
 			break;
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
index 31e80d693f32..d5a1cf92ca6f 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
@@ -373,7 +373,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 	}
 }
 
-static void Hal_GetChnlGroup88E(u8 chnl, u8 *group)
+void Hal_GetChnlGroup88E(u8 chnl, u8 *group)
 {
 	if (chnl < 3)			/*  Channel 1-2 */
 		*group = 0;
diff --git a/drivers/staging/rtl8188eu/include/rtl8188e_hal.h b/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
index a86b07d3c82a..eb4655ecf6e0 100644
--- a/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
@@ -329,6 +329,8 @@ struct hal_data_8188e {
 	u8	UsbRxAggPageTimeout;
 };
 
+void Hal_GetChnlGroup88E(u8 chnl, u8 *group);
+
 /*  rtl8188e_hal_init.c */
 void _8051Reset88E(struct adapter *padapter);
 void rtl8188e_InitializeFirmwareVars(struct adapter *padapter);
-- 
2.19.2

