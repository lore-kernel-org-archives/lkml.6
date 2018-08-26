Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF557C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9954421722
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmWQaWJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9954421722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeH0A7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:59:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36494 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeH0A67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:58:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id f4-v6so6421362edq.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fzONzfAQpp2GpjezckLEYnmarhxBYKGvrywkidtzo6s=;
        b=dmWQaWJntTfSPQ3OIkW1E0scl94wM+RdMmZDh7QWBJnKM9YPCc28KwfrC1YfU1rTIL
         IJ7392osDaOPsDgQkgJFPG1JMltlcLF7tZIUpIUjR3Zh8V6UNZgTya45q9Et/KTGlDpf
         r3qvxo7IxmIx9Ul3NBIT79jm/PYAUyjpsfC5/2V+FP8juPXrOwiswzkrQK4yWvjs93Qt
         0ODlHCKSaSXMAvbiiBeeXxWb7W3S8kI9Cis09rKp9/7lMXCEZY4Ltmo5HcVzp7/3xx9N
         /Zg+HVcxVFGm+ibr7swFnWNHpzuYwjLrd7eFkGfXYPAfBymBc8UgkClA9zl3EHO3jERH
         0u7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fzONzfAQpp2GpjezckLEYnmarhxBYKGvrywkidtzo6s=;
        b=Y4zd3ghpwQnfaLQrY8vqtWftCqy61tkyq8nofj3SkVCadK1kMqwDafl0aGsjM4sQA5
         v5aBpUeOB6xRyUhTbbZCFe1IzhGnauNUeowjqIvetbT80A1DS+3GW4HxikOUW4YJNX5h
         Y80yRA2Nm+kGClw2gd8yeCmE+Z+ZyyIfEduhKXuQE40rEgrdts+ILiyo1eRFE0TH1OOv
         hRGKegxvtggfP7yTZ1hWA8SKg9Y0Gm6COQQRB1itlqjbT6OfDAY972kdJ7IV2qR8z3+Y
         MUQp3vbh5LEfC0rPjbTZ3VWBFMSHhsCgUXhYg063YVfiDhMMn/C9w25qvbym0Z7O6qiw
         j9bg==
X-Gm-Message-State: APzg51BC75/RHopid9GzYLzSadqk/L4vGMFsr5hDcmTPwoX/5als06zR
        d711+y9llcIZ87hdXwMta5IfomWJ
X-Google-Smtp-Source: ANB0VdZ9O0ETcYAJ7G8bA+2xuZZCNoNSk+Vr/3kw9p+QAiwwNovXvfPzzM+SRideOGJ4KJIg30pW7w==
X-Received: by 2002:a50:ac56:: with SMTP id w22-v6mr13788511edc.211.1535318114819;
        Sun, 26 Aug 2018 14:15:14 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:15:14 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 14/21] staging:rtl8192u: Rename EEPROM_TxPwIndex_CCK_V1 - Style
Date:   Sun, 26 Aug 2018 22:14:32 +0100
Message-Id: <20180826211439.14326-15-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the constant EEPROM_TxPwIndex_CCK_V1 to
EEPROM_TX_PW_INDEX_CCK_V1, this clears the checkpatch issue with
CamelCase naming.

This is purely a coding style change which should have no impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 4 ++--
 drivers/staging/rtl8192u/r8192U_hw.h   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 3742dd8410b2..67b4597d351e 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2498,7 +2498,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 			}
 		} else if (priv->EEPROM_Def_Ver == 1) {
 			if (bLoad_From_EEPOM) {
-				ret = eprom_read(dev, EEPROM_TxPwIndex_CCK_V1 >> 1);
+				ret = eprom_read(dev, EEPROM_TX_PW_INDEX_CCK_V1 >> 1);
 				if (ret < 0)
 					return ret;
 				tmpValue = ((u16)ret & 0xff00) >> 8;
@@ -2508,7 +2508,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 			priv->EEPROMTxPowerLevelCCK_V1[0] = (u8)tmpValue;
 
 			if (bLoad_From_EEPOM) {
-				ret = eprom_read(dev, (EEPROM_TxPwIndex_CCK_V1 + 2) >> 1);
+				ret = eprom_read(dev, (EEPROM_TX_PW_INDEX_CCK_V1 + 2) >> 1);
 				if (ret < 0)
 					return ret;
 				tmpValue = (u16)ret;
diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index a7d1a7f9faf0..d7f830bf9e94 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -44,7 +44,7 @@
 
 #define EEPROM_TX_PW_INDEX_CCK	0x23	//0x23
 #define EEPROM_TX_PW_INDEX_OFDM_24G	0x24	//0x24~0x26
-#define EEPROM_TxPwIndex_CCK_V1		0x29	//0x29~0x2B
+#define EEPROM_TX_PW_INDEX_CCK_V1	0x29	//0x29~0x2B
 #define EEPROM_TX_PW_INDEX_OFDM_24G_V1	0x2C	//0x2C~0x2E
 #define EEPROM_TxPwIndex_Ver		0x27	//0x27
 
-- 
2.18.0

