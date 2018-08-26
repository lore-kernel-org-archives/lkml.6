Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279CEC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51572172C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAiCUJUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51572172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeH0A71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:59:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35808 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbeH0A7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:59:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so2442095edq.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=go/3oPjUK3uBy/0qsrvskikyuDYNZy6DNooY5ssNlt4=;
        b=rAiCUJUD3yKGFHxba02IUMewvKtOIk2CHRw/izlXgXOvcWWC+kXn+XyXOE6xORBUwx
         DGoZsk28qyS857U+5RU3+JM0/QnH7M2T7kVrPDnY3oYtW1/DG5+L88cHRgnPMSC4n+kN
         xDpwWChWeOcErTUXb4q/RDzQ5377HMVofa1YXopMmjd1JaHJ9JpfzStkEDoGIrPVI+jA
         sIRFzCy6YWx6eQcwqDTe00HLhj/8SnfxfDRn1HhvOne7WbvGgjfg4uEY0M5+PR+lSsde
         /weuq0DF4hTH60Gy2QX5gdIN8uCGUFGVlWsNSuG9WXrN0rE8aQxZ/WF5YnozKHSH8ZEi
         MrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=go/3oPjUK3uBy/0qsrvskikyuDYNZy6DNooY5ssNlt4=;
        b=TOnb34Ibu9AZdXq2IoVxidUEWqlPPGpazXFHRRUa1UbjWtRDoxxHPXULcjwxB4mT+n
         8QQzP4AYeE9Fa+gUXXFhFz/mi/sRmtlO/ZxTzWdZUzxvZOI/dHM1ruuX/qFxWAPkivje
         R9fj1Qs7UPB27AkuJrIFz3VourQb9VrHmIchXCcHFwVeGYYWvD3lzsUe7yyl97nvwBuA
         t4IfoDtepGUHlZxygcI+sVJoj+hUNp69QvyTJ4QU+RhGJYg5U8+6epjQYdvasaEZGr1k
         amnbrbh5V6KjYsrKPezAe2xw+W5S29ixK4kHIhxuqkq+/LpyE/9yA9XfUznDrqzVoAwq
         vbrQ==
X-Gm-Message-State: APzg51BnKo2X2cssE7nVqhfoldZTDIBp7ZmjhIHZvF9Rz0doHwxS03rP
        3HQ8cdqABSxc4YIjXT0zzI2JP268
X-Google-Smtp-Source: ANB0VdZ6dvHJ2tOiXc+ROcsxrZEeg47c0j/1f5eHzdd1ByMPmzwSBl51gB1/dAMhcmM01p9zd26czg==
X-Received: by 2002:a50:94c4:: with SMTP id t4-v6mr13498548eda.306.1535318118671;
        Sun, 26 Aug 2018 14:15:18 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.15.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:15:18 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 17/21] staging:rtl8192u: Rename EEPROM_Default_PwDiff - Style
Date:   Sun, 26 Aug 2018 22:14:35 +0100
Message-Id: <20180826211439.14326-18-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the constant EEPROM_Default_PwDiff to EEPROM_DEFAULT_PW_DIFF,
this clears the checkpatch issue with CamelCase naming.

This change is purely a coding style change which should have no
impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 drivers/staging/rtl8192u/r8192U_hw.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index b2853b90c496..adc8d2e7fb61 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2450,7 +2450,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 				return ret;
 			priv->EEPROMPwDiff = ((u16)ret & 0x0f00) >> 8;
 		} else
-			priv->EEPROMPwDiff = EEPROM_Default_PwDiff;
+			priv->EEPROMPwDiff = EEPROM_DEFAULT_PW_DIFF;
 		RT_TRACE(COMP_EPROM, "TxPwDiff:%d\n", priv->EEPROMPwDiff);
 		/* Read CrystalCap from EEPROM */
 		if (bLoad_From_EEPOM) {
diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index b485c7781d77..79826e289207 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -49,7 +49,7 @@
 #define EEPROM_TX_PW_INDEX_VER		0x27	//0x27
 
 #define EEPROM_DEFAULT_THERNAL_METER		0x7
-#define EEPROM_Default_PwDiff			0x4
+#define EEPROM_DEFAULT_PW_DIFF			0x4
 #define EEPROM_Default_CrystalCap		0x5
 #define EEPROM_Default_TxPower			0x1010
 #define EEPROM_Customer_ID			0x7B	//0x7B:CustomerID
-- 
2.18.0

