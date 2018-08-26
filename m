Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DB5C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1676208CA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqPEKMbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1676208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeH0A7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:59:03 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33432 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeH0A7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:59:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id h9-v6so9115124edr.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DXyJ1Ha+4UdRMD64wWaqawZNUL2cUasNOIsrsBiQwBw=;
        b=RqPEKMbGzHD77Y25ZcGWT8Xb0OpE6YWzisnxj6ML9sUQHhsveoI7yf2tQTjL1hQ/7W
         ulkf0G0IZKcQ6PN8RwnVHKX8p1jPPTo2DnPN93LR5cZUFr+UNHjCRySejSgtBXxyTJgw
         xi4DzkFR4Wq6G71TFFseAlT0cHbRr/takVDs5jvd/9A6KTAz5wM/S9i9POHHzrh1sGQf
         fce8LJEyn3knlt0ddDw5feeuMaOMrpMwTvE1HPplB12MGiqMlmZDZVIIg0nhWUQmqXSm
         +XXVRFrWGFvfFKb9a8dEAGOWLzsQR37X5k701gBDvAyR3etro2WgRI7qZ8Roz5EfcPuN
         e1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DXyJ1Ha+4UdRMD64wWaqawZNUL2cUasNOIsrsBiQwBw=;
        b=CsCz/8TwkW7AbuYMqGEGmOGTkEpQp+BBD7yRm+oXmV2GRmUrHhKn6H0QuIRTyu1hBA
         NDVh45HKpBSzM0vTrKAPxfLkdpEWoUoAhTRlSlTQCbwo4ZLaKTaPqTTyZgiKa3UU6RJM
         KKD0pHi7eu5aR+Gg4pLEbq9kg9HS8fCVxs+/XZvkdslqbT0eAm29lvD/TJuvsxdDOH3R
         T6Et+U7PDYuHHC+nG831kEDlbEhfl7fjcgkzSC7aGQFvFTCL21YZCSITrk4aCp9Ifu4m
         Pv1ax31b28uHUdgy5TkfDKwKJE3JxwUa8ehKX9zOyiOXrOMXQVDnb8WQK/6+FA0Qi0+6
         eRQg==
X-Gm-Message-State: APzg51DDMbTsIyGhTSk1VOA27x7gwYRlEvMOypv+zgRrl0L6V9k5Nsc9
        pXiMiuVgaYhGYVWtTPOqX06Z8FRT
X-Google-Smtp-Source: ANB0Vdbr9pHnrvZTeKcQ/9Mn5YpAQwQlQ9PXFYC8majfUA2aKurag8T0SOQ5y/yJObvyXFg83q4MQA==
X-Received: by 2002:a50:ce5e:: with SMTP id k30-v6mr13561030edj.207.1535318117390;
        Sun, 26 Aug 2018 14:15:17 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:15:16 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 16/21] staging:rtl8192u: Rename EEPROM_Default_ThermalMeter - Style
Date:   Sun, 26 Aug 2018 22:14:34 +0100
Message-Id: <20180826211439.14326-17-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the constant EEPROM_Default_ThermalMeter to
EEPROM_DEFAULT_THERNAL_METER, this change clears the checkpatch
issue with CamelCase naming.

This is purely a coding style change which should have no impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 drivers/staging/rtl8192u/r8192U_hw.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 836be2a0b330..b2853b90c496 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2439,7 +2439,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 				return ret;
 			priv->EEPROMThermalMeter = (u8)((u16)ret & 0x00ff);
 		} else
-			priv->EEPROMThermalMeter = EEPROM_Default_ThermalMeter;
+			priv->EEPROMThermalMeter = EEPROM_DEFAULT_THERNAL_METER;
 		RT_TRACE(COMP_EPROM, "ThermalMeter:%d\n", priv->EEPROMThermalMeter);
 		/* for tx power track */
 		priv->TSSI_13dBm = priv->EEPROMThermalMeter * 100;
diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index f98e6c2cf414..b485c7781d77 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -48,7 +48,7 @@
 #define EEPROM_TX_PW_INDEX_OFDM_24G_V1	0x2C	//0x2C~0x2E
 #define EEPROM_TX_PW_INDEX_VER		0x27	//0x27
 
-#define EEPROM_Default_ThermalMeter		0x7
+#define EEPROM_DEFAULT_THERNAL_METER		0x7
 #define EEPROM_Default_PwDiff			0x4
 #define EEPROM_Default_CrystalCap		0x5
 #define EEPROM_Default_TxPower			0x1010
-- 
2.18.0

