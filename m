Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB6DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331A72098B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tql8Vd08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331A72098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeH0A7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:59:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40218 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbeH0A7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:59:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id e19-v6so9111030edq.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ijc77Geakt3FjvLUHA/yY1yHPCqcB6a0owRiQBigIdE=;
        b=tql8Vd08nd3Rsy3yTWml6QDKC96seOai1ShQD24PTwllrxG5KPjwAlCtuWXlZbvh+H
         +mhK1Qp10iZPewybiP+PA8lWxtVKDuBWs9cbA5qLCPg9h417nMk11QHUGMGs/yRbazGn
         zrI6e57/yvM13UdzEI4FE1re9tAJufxHBbgz5dbAeSiFlWQcMV3pjNSrzOM8yaR9czsa
         ulPz01KHDv0JJIbbidGmhuNoqzmHFzHFxrhk2xJs61r/dZsGDuvAKAVGB4+AxWgUs0MY
         Np/CDd0m5VTMiOs7H/37OmEp6g8Qwnpdr9yVi5dDvYEAMmpSQ/8PbSueU1uYyFZ4/2tB
         CDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ijc77Geakt3FjvLUHA/yY1yHPCqcB6a0owRiQBigIdE=;
        b=HpC0xpbykkZngpH39apkjn6z7+pKv05mxL1Nma8uLxzhAps8H7iMvpeGFFIiiwK+NW
         XKMGXJIjoUKURP2hUxIgZYmyYysCeHvpZmRJ81WnpbG/xKY3UBQyY+wApUjb+YNGBNLt
         /tbqMmvivUS3GmQIEuIsfA/HQgvRUs+iRdOvFedvQtVANuPQC/FGlnN70zXC9Iep/zzD
         /J8YuBX6dK8Su7QgoV1JSuim7kC+t6YsKAC0scFyuZOr905KaOf6T/20mHtp7fnzz7Cn
         G21A5lWqE7WOoAb9fQA0U4Ap0Y3fQfBlI4pSYlTeIrD5Qn6OUvAZkTXOBph3vFKY9beJ
         l1mA==
X-Gm-Message-State: APzg51BhFmD+Lk/H7KimWRE0yXTeBUE4xCH+NHm1yM6tmN9txWYdl0KN
        F/ldaFDpRcDUlJPvaNDapdQdx9Hs
X-Google-Smtp-Source: ANB0VdZK3eLlPQ703BUIGXD0jEeQyJpzCFYagYCiw7G9vC3xI5DhLMuiq2FAV5E2DyhhK/Dm4u+Llg==
X-Received: by 2002:aa7:d707:: with SMTP id t7-v6mr13332662edq.250.1535318119958;
        Sun, 26 Aug 2018 14:15:19 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:15:19 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 18/21] staging:rtl8192u: Rename EEPROM_Default_CrystalCap - Style
Date:   Sun, 26 Aug 2018 22:14:36 +0100
Message-Id: <20180826211439.14326-19-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the constant EEPROM_Default_CrystalCap to
EEPROM_DEFAULT_CRYSTAL_CAP, this clears the checkpatch issue with
CamelCase naming.

This is purely a coding style change which should have no impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 drivers/staging/rtl8192u/r8192U_hw.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index adc8d2e7fb61..236c4dee7921 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2459,7 +2459,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 				return ret;
 			priv->EEPROMCrystalCap = (u16)ret & 0x0f;
 		} else
-			priv->EEPROMCrystalCap = EEPROM_Default_CrystalCap;
+			priv->EEPROMCrystalCap = EEPROM_DEFAULT_CRYSTAL_CAP;
 		RT_TRACE(COMP_EPROM, "CrystalCap = %d\n", priv->EEPROMCrystalCap);
 		/* get per-channel Tx power level */
 		if (bLoad_From_EEPOM) {
diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index 79826e289207..923d8ab5939d 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -50,7 +50,7 @@
 
 #define EEPROM_DEFAULT_THERNAL_METER		0x7
 #define EEPROM_DEFAULT_PW_DIFF			0x4
-#define EEPROM_Default_CrystalCap		0x5
+#define EEPROM_DEFAULT_CRYSTAL_CAP		0x5
 #define EEPROM_Default_TxPower			0x1010
 #define EEPROM_Customer_ID			0x7B	//0x7B:CustomerID
 #define EEPROM_ChannelPlan			0x16	//0x7C
-- 
2.18.0

