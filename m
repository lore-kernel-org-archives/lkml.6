Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E00C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E9C2170B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2a6mtcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E9C2170B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeH0A6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:58:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40208 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeH0A6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:58:50 -0400
Received: by mail-ed1-f68.google.com with SMTP id e19-v6so9110785edq.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kaOJPUXJ8LNX6LYKDjxBfwrX0n9kPBSAwSeHymfufOY=;
        b=W2a6mtcVNLTMu4CWrZrSu9FkMEqJ9IR8ks6vsEEmsk6yg6JdjVNgwuRkLuo3ttbFx9
         iUIMtMJtFG7ru10ulJ+KaqWSOHN+2pQI1hbKZIWtxVFdmTQ4fj5+/2eOubXPZtfuDlGj
         dJ1MldYq7irxwhL3y/S7GDU1qgPZsQKpl8V7ihMEd3Ni+bVvTq4XfBACWlZkHFjLJilr
         +nhipil3kd66NrWtpFu6CoNC6Mn87NyhZx4hL9XPPdGsCs7WXwHO8znFALP+3VXJVy2b
         ohNUysiUk87w41CiwciEasytAVzxfvA6BwflQFWb2+lcC4Q5zXvytWj7IJmSZbxNQhH+
         +Jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kaOJPUXJ8LNX6LYKDjxBfwrX0n9kPBSAwSeHymfufOY=;
        b=cc0VpP31eixQ9jfrLoP3IbivQCUZXzhjmSO2d9cS9Szk1xlOc2oYsgP/3sRf4PAzU9
         Eo2uK+M+H8bEmOoYbMZt7Y6gCgYYIStmMQrYYcWB9QehSL9TtDSKhbSvIGd/YrP+EqqT
         OVozzACe5lkfue5YvDB6u0jWuFzFV2QZ5Sc09T8/J6Ob1ukeYOlBJ+ABIqvkSSgLQO24
         c4qWSTz1VNBnV7MK6AGjVKD0gzwPLLzvuAVc+zTI5SrNEqaDv1ApHVYAoyysT7qsy9r6
         2kav229k/ISLXqmd753JV/93SGIpto60ccvrGoX34Slh77sXW745ZhWPkHJzbsGkAqmL
         AIAg==
X-Gm-Message-State: APzg51DsLi+3BH1CUXCpvQ/W604/9+nugID1lZpt+RaCRmK5T1Ct/vP1
        +K07I16Ara0aiBWhhTqjBQaS0fyR
X-Google-Smtp-Source: ANB0VdbJ6ij0GLV+uSiRTSVqfFuE96kgr030/2AVcT3DoPFPSjcjhCIgpIqyJemm6loeSWn2x4S/sA==
X-Received: by 2002:a50:b410:: with SMTP id b16-v6mr14061487edh.190.1535318105491;
        Sun, 26 Aug 2018 14:15:05 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:15:04 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/21] staging:rtl8192u: Rename EEPROM_TxPowerDiff - Style
Date:   Sun, 26 Aug 2018 22:14:25 +0100
Message-Id: <20180826211439.14326-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename EEPROM_TxPowerDiff to EEPROM_TX_POWER_DIFF. This change clears
the checkpatch issue with CamelCase naming.

This change is purely a coding style change which should have no
impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 drivers/staging/rtl8192u/r8192U_hw.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 3b89f2669754..913b8ed9dc56 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2425,7 +2425,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 	if (priv->card_8192_version == VERSION_819XU_A) {
 		/* read Tx power gain offset of legacy OFDM to HT rate */
 		if (bLoad_From_EEPOM) {
-			ret = eprom_read(dev, (EEPROM_TxPowerDiff >> 1));
+			ret = eprom_read(dev, (EEPROM_TX_POWER_DIFF >> 1));
 			if (ret < 0)
 				return ret;
 			priv->EEPROMTxPowerDiff = ((u16)ret & 0xff00) >> 8;
diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index 22f837f5b709..9b235579e8fd 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -37,7 +37,7 @@
 #define EEPROM_PID		0x04
 #define EEPROM_NODE_ADDRESS_BYTE_0	0x0C
 
-#define EEPROM_TxPowerDiff	0x1F
+#define EEPROM_TX_POWER_DIFF	0x1F
 #define EEPROM_ThermalMeter	0x20
 #define EEPROM_PwDiff		0x21	//0x21
 #define EEPROM_CrystalCap	0x22	//0x22
-- 
2.18.0

