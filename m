Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0053C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7725B20883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkUJAhcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7725B20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbeGZUnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:43:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44460 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731706AbeGZUnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:43:17 -0400
Received: by mail-ed1-f67.google.com with SMTP id f23-v6so2239189edr.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7CgE9zehoQyQ0jh3mEH72fL+37+2Qz/bKvfm2L8Sqz8=;
        b=RkUJAhcBhkEZiA8q8UyHWPvTPIMOlfZtPB8TXvtu6HXAKj2b88pK4zsj+25O+o3Zz9
         21WEduZnNf3X6guPfKkJ0svfQ3o2C5R+I6r7fa8+jMGc0exe9ieFKd071mwEuK7KPrgR
         Il0TJ5OAR/sosC3Wc7hNWMGt5OkXwofaCT3Oa9Ba/QRQMlktQ47fSh1zlyTVm8+OgrD3
         5HTSsOjPiGOZSnfwJOlHiR1VZYUKWk9BFaMU4E6YoQE0+Wsr9VzDSoANwkN/8dxTycza
         phtelpoXjxw8ANSJlCrLuUbTiduKmQQKuJoFD9flaoiRFFfqYiXaNsExmSUUHEOGmaU8
         YNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7CgE9zehoQyQ0jh3mEH72fL+37+2Qz/bKvfm2L8Sqz8=;
        b=CUfcAtonpaToo3r2eBoqeCZNySGsmhAdw1ZHQ0u50G4epVu16dXU+Mcyat4i5cHaXr
         0AFibnWUjVEe4FKN/E5yE19s7I0n44fY/dcaVFdYYLpBXyPc+iGoCboEOkIp4d75J6zC
         WBGxNk3IEsELKDU8KZhiQ5ZroHeOcKTdjNdqBIAGe//OcziR/8UEbq4OppCcnXCUqa+I
         2HY9vhLVspLuL49EMoz0k/PHE7OaDf0o8RBJAzvSrNZ5EvjI7yF5NVaZ7VJAfyHsoOxh
         7r+lxi73BcDV+d+pcJsDZK2a/FxQVTUxPazI0MbzFso4oy3EhhV9fhKqjOT+EvmnYxnh
         Bh6A==
X-Gm-Message-State: AOUpUlHEaJZGKMWCEl9iYJwj4cZJuy69fWy1O7ZyAFF8Ir1JOlxvDeFX
        iBNjh2/S/bUYlyLRC9jSWwLV8L2q
X-Google-Smtp-Source: AAOMgpcAF234/6YwwDl2Oaa1Ih35ZQoWDLUup9whhIOVBH1Z9RLabrTgj2aCDOn4bc33nGCtT6jBqw==
X-Received: by 2002:a50:8854:: with SMTP id c20-v6mr4117576edc.146.1532633101557;
        Thu, 26 Jul 2018 12:25:01 -0700 (PDT)
Received: from localhost.localdomain ([109.76.149.40])
        by smtp.gmail.com with ESMTPSA id m20-v6sm1100853eds.5.2018.07.26.12.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:25:00 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 09/16] staging:rtl8192u: Remove proxy rtl819XRadioA_Array - Style
Date:   Thu, 26 Jul 2018 20:24:19 +0100
Message-Id: <20180726192426.31913-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726192426.31913-1-johnfwhitmore@gmail.com>
References: <20180726192426.31913-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The array rtl819XRadioA_Array serves as a proxy array for the actual
array Rtl8192UsbRadioA_Array. This implementation seems to serve no
other purpose then to obscure the actually array Rtl8192UsbRadioA_Array.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 7 +++----
 drivers/staging/rtl8192u/r819xU_phy.h | 1 -
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index cf7b09f9818a..775dfa847b93 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -29,7 +29,6 @@ static u32 RF_CHANNEL_TABLE_ZEBRA[] = {
 };
 
 #define rtl819XMACPHY_Array Rtl8192UsbMACPHY_Array
-#define rtl819XRadioA_Array  Rtl8192UsbRadioA_Array
 #define rtl819XRadioB_Array Rtl8192UsbRadioB_Array
 #define rtl819XRadioC_Array Rtl8192UsbRadioC_Array
 #define rtl819XRadioD_Array Rtl8192UsbRadioD_Array
@@ -981,14 +980,14 @@ u8 rtl8192_phy_ConfigRFWithHeaderFile(struct net_device *dev,
 	case RF90_PATH_A:
 		for (i = 0; i < RadioA_ArrayLength; i = i+2) {
 
-			if (rtl819XRadioA_Array[i] == 0xfe) {
+			if (Rtl8192UsbRadioA_Array[i] == 0xfe) {
 				mdelay(100);
 				continue;
 			}
 			rtl8192_phy_SetRFReg(dev, eRFPath,
-					     rtl819XRadioA_Array[i],
+					     Rtl8192UsbRadioA_Array[i],
 					     bMask12Bits,
-					     rtl819XRadioA_Array[i+1]);
+					     Rtl8192UsbRadioA_Array[i+1]);
 			mdelay(1);
 
 		}
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 808a11c475a4..7c4b89a5c592 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -25,7 +25,6 @@ struct sw_chnl_cmd {
 	u32		        ms_delay;
 } __packed;
 
-extern u32 rtl819XRadioA_Array[];
 extern u32 rtl819XRadioB_Array[];
 extern u32 rtl819XRadioC_Array[];
 extern u32 rtl819XRadioD_Array[];
-- 
2.18.0

