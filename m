Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD18AC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C92208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hN7ezOZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C92208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeH0A6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:58:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33421 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeH0A6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:58:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id h9-v6so9114956edr.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q7iF+6/WgU+L/4JOc2l3hZjZsRlo45S/H5eki14GVck=;
        b=hN7ezOZ2QR3lYBVlAuy4HGzIuS3Vp8UoVQvsaHwY9q1SzFbU1Lj8vLU1TUHfywCD9R
         4IUtMroP3oluNHjVTInMQbX0yeoffXmOj42nnHNq79/Z+r3GbfhS3y4PaBINPCnikvga
         HlC6KzFQmrvSlAl4C+vugc1DkxKRKt2a3OIpxfCDNpp8JfBZ2wdh8/j0S4mdHDTWsfd8
         /rbIucdaW5aTzAnVIjTZDuFG8HPWeZJu0tCRxSR1csiHlv2B2wtMhsP/L27vY2faH0eE
         TBuwBPfqMvWeATA/V+Wq1zvalzvWnBrSiPlFZM0bhrMFzbi/qprDtUA2gHxnRTuoyrzd
         IOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q7iF+6/WgU+L/4JOc2l3hZjZsRlo45S/H5eki14GVck=;
        b=Xt+APeNb3uRrLvFxkBSEjcblMtP2i+sYpkmukADxRfDvuLzhC1O049zWVQcnjrBH8v
         dqLbeigl2QwXd516Lx9Qr7om9axFNb17oWwUMzRive/PeMajMpDKQNRPKYdkxb4n5Jsp
         ZWfhzPyavD4uXFETveDJXaRe4x00xykHbg0/j/pxR+3HhcyMO4cECKSofDHs92N4yswL
         QYmhVRzSezxz5OVyyGFCITpB2DzolAY5TFg3yy+K57K3V4V3kQbaoVG+HcwUsTAt+kXV
         TmLPaSAfdBqLo4PPxDd/g7tWYwd3vbgQsdryQTWF8vGexC8Yy4weGf772jvFhPMbxafB
         ilQw==
X-Gm-Message-State: APzg51D7Yqinju4eFlb8XxghwWpc6N2Ucz92uBGJk6w4TkUal6Gxfo8I
        uA3KcnimZxsd+FNsajuoMiV9iw5h
X-Google-Smtp-Source: ANB0VdYBC9TLdJquDsurLQcI2w8lZxay9+kazj6AuIeADw+DoQ4dt+PWaunwDOZYP2NIP6oaIHv78A==
X-Received: by 2002:aa7:c9c2:: with SMTP id i2-v6mr3421698edt.308.1535318106767;
        Sun, 26 Aug 2018 14:15:06 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:15:06 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/21] staging:rtl8192u: Rename EEPROM_ThermalMeter - Style
Date:   Sun, 26 Aug 2018 22:14:26 +0100
Message-Id: <20180826211439.14326-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename EEPROM_ThermalMeter to EEPROM_THERMAL_METER. This change clears
the checkpatch issue with CamelCase naming.

This change is a coding style change which should not impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 drivers/staging/rtl8192u/r8192U_hw.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 913b8ed9dc56..5c9581bb4916 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2434,7 +2434,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 		RT_TRACE(COMP_EPROM, "TxPowerDiff:%d\n", priv->EEPROMTxPowerDiff);
 		/* read ThermalMeter from EEPROM */
 		if (bLoad_From_EEPOM) {
-			ret = eprom_read(dev, (EEPROM_ThermalMeter >> 1));
+			ret = eprom_read(dev, (EEPROM_THERMAL_METER >> 1));
 			if (ret < 0)
 				return ret;
 			priv->EEPROMThermalMeter = (u8)((u16)ret & 0x00ff);
diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index 9b235579e8fd..8a94a159e16c 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -38,7 +38,7 @@
 #define EEPROM_NODE_ADDRESS_BYTE_0	0x0C
 
 #define EEPROM_TX_POWER_DIFF	0x1F
-#define EEPROM_ThermalMeter	0x20
+#define EEPROM_THERMAL_METER	0x20
 #define EEPROM_PwDiff		0x21	//0x21
 #define EEPROM_CrystalCap	0x22	//0x22
 
-- 
2.18.0

