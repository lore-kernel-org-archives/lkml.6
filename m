Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C856C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328A520845
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZmqWGVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328A520845
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeH0A65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:58:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45122 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeH0A64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:58:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id p52-v6so9085656eda.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8aPdfZbeon7ztYqZZszvjJuCXdwbpIVwfOM3PLn6hys=;
        b=uZmqWGVOsBecWy5anmdfo9pFVqzM1SvS9GusLBEXVdYL4WE0JMcEZKnk5MHkcFdej1
         mRWzRXehC8u33Y0elmuUUW4Ix7c0GoZk/tmdfSLX+ibiPmdTOi9mKdoN98NSdaLyu+S/
         nFWm9Lf1ouAPUFVPRtC7+bjIUCt8DauAkWcl5hdY7BJc0S7JR8Q2xXQh9qvt4Nx2Y0/z
         TjCf8sNmCLiV8a3IYFP46G4YQO/UlbLsV8ALHGN5cX6iY8Rqwx0S6k0NtaFiFo/5ersv
         9y2CFqb5MEW4jfPbMh84P96G8ixepw09Du54aCB3RQS/z8S2yBsDSjYNtkHfaofNnmeT
         FcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8aPdfZbeon7ztYqZZszvjJuCXdwbpIVwfOM3PLn6hys=;
        b=GcLY35kpB0ZuYiq3ss51xj9SGUpVDzRpGVHwNWZAambBVV+4u4qUDYWHYoEGd+3ckE
         Xu9zw90aAqSMATwjxoAooBwcVLMyBAjQ8SaDJ9pVgaPBWpNIF3Nw/dafmz2hTMU0BTED
         E8cz+xXeJFoOOf934yfLEtsMe+bQtlYxLfMd4S9eSWEVq7VziNkpJYLpwhVkqN5WyRTg
         3tkCV9SFoEnVIkajgu9a9tlq4PG0k8W5Ghk55oxBdg+useSzsLEgx3QiZM2E4x9ME68x
         3zhEtnl53fy4cTRze6d+YrVSNGgH+yBzoCSkADj2+uyFXpd98zxqrFHlH6PUMFD6njZH
         /+sQ==
X-Gm-Message-State: APzg51CFOy7p1y4NRpbs7v73uBGFzXJxZ9MR19uR9vzda45Pz8dQRVRN
        GIN5fmn1s7tazHk0Ql2Yq+zpUHuX
X-Google-Smtp-Source: ANB0VdbP3jhG2QhC6u5wy05zNPoopcPv9dMmUwZE3So2z55731GkFilhxt2kyX9nw99OxGhe5ZnFug==
X-Received: by 2002:a50:cd9d:: with SMTP id p29-v6mr13228366edi.159.1535318112117;
        Sun, 26 Aug 2018 14:15:12 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:15:11 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 12/21] staging:rtl8192u: Rename EEPROM_TxPwIndex_OFDM_24G_V1 - STYLE
Date:   Sun, 26 Aug 2018 22:14:30 +0100
Message-Id: <20180826211439.14326-13-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the constant EEPROM_TxPwIndex_OFDM_24G_V1 to
EEPROM_TX_PW_INDEX_OFDM_24G_V1, this change clears the checkpatch
issue with CamelCase naming.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 4 ++--
 drivers/staging/rtl8192u/r8192U_hw.h   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 83a61fcab53b..7189249a898f 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2517,12 +2517,12 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 			*((u16 *)(&priv->EEPROMTxPowerLevelCCK_V1[1])) = tmpValue;
 			if (bLoad_From_EEPOM)
 				tmpValue = eprom_read(dev,
-					EEPROM_TxPwIndex_OFDM_24G_V1 >> 1);
+					EEPROM_TX_PW_INDEX_OFDM_24G_V1 >> 1);
 			else
 				tmpValue = 0x1010;
 			*((u16 *)(&priv->EEPROMTxPowerLevelOFDM24G[0])) = tmpValue;
 			if (bLoad_From_EEPOM)
-				tmpValue = eprom_read(dev, (EEPROM_TxPwIndex_OFDM_24G_V1 + 2) >> 1);
+				tmpValue = eprom_read(dev, (EEPROM_TX_PW_INDEX_OFDM_24G_V1 + 2) >> 1);
 			else
 				tmpValue = 0x10;
 			priv->EEPROMTxPowerLevelOFDM24G[2] = (u8)tmpValue;
diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index 437bb9212e47..4cf3a7fc705e 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -45,7 +45,7 @@
 #define EEPROM_TX_PW_INDEX_CCK	0x23	//0x23
 #define EEPROM_TxPwIndex_OFDM_24G	0x24	//0x24~0x26
 #define EEPROM_TxPwIndex_CCK_V1		0x29	//0x29~0x2B
-#define EEPROM_TxPwIndex_OFDM_24G_V1	0x2C	//0x2C~0x2E
+#define EEPROM_TX_PW_INDEX_OFDM_24G_V1	0x2C	//0x2C~0x2E
 #define EEPROM_TxPwIndex_Ver		0x27	//0x27
 
 #define EEPROM_Default_ThermalMeter		0x7
-- 
2.18.0

