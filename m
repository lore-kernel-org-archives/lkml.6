Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82278ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390B420890
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuaQEPyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390B420890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeGNNMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 09:12:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38322 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeGNNMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 09:12:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id t2-v6so11980479edr.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 05:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oz1oIY9OAQW/r2I7eTF80dP2CHRT6nS59UOpTxk6Gi8=;
        b=WuaQEPyJljDAyL/5xHNenWxvzD9F//g8WI7A52qYqWAjCLTPg06p9+xzTa7g7nE53l
         5u3D2FmddpkkW8K2PcYQ7XHTi9UIuc3LZQgL0QZqPFXsvps1c2SFMVkA18Vd3Hxqv8Yn
         kuNLJxzoH7jN11O3tIgO+5VZS+IN7UqTK+CPrmvusLJ9TNQ+iARH8yHb3gMIe+RRWewr
         xqUMAg2JidQM0YbJO+O0QPp1MOULEmf8ixS9mARvT+AqhezmNRop8UUoMr1t9wuy6BuL
         Dy0npBUli0eEA1dT2IqRUm2i2JiSzJnayNgXq6ax8skdqTvJ/I9LCnEsFtOj3HMI/58A
         7RiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oz1oIY9OAQW/r2I7eTF80dP2CHRT6nS59UOpTxk6Gi8=;
        b=sQdBuY/IxyTRuASDjLmAYu9Ji1Iagjqqc0jK6q8pCrvARltRa3M00S98Ipg/MyGKk/
         WrgydWuHIQGpZO1v19BVqpYqivPhkXW+SjOQMj09n9+xzYvHUC5q/hDyTg+XObitB4MA
         kYabm32xVT2CCn91wNfkIQCgpCVgb69F+jb8zV2EnCdwENT31wni/L1AtLd+QsAgMOX5
         a2P/hEG7Us23xpVZzx1ZoS39YbRFq0Ytu1Cg1en9NTKqsROrOWnzxCmQFWVzYuO2fnV3
         8QlgWKwR/BN35LWffrkuNsWICRewCOefFXYfCNn9s0JgLPRsTRCX8NdjBDf7zKGUk7L4
         scbw==
X-Gm-Message-State: AOUpUlFU9sPVTHBbUwzaJwm+ylI+O5RfeOqolSLpWxfVu8KMlSLA7oK6
        YceQm70ofib/UHtb0SdXaqk=
X-Google-Smtp-Source: AAOMgpd+OvQlynuMSD3F2oVsHbZWyTHRwL/7sd9X8jhiNy6lzsazA+v6lN5mamGKY4WxTGUYc8PBLA==
X-Received: by 2002:a50:a762:: with SMTP id h89-v6mr10716817edc.261.1531572788082;
        Sat, 14 Jul 2018 05:53:08 -0700 (PDT)
Received: from arch.localdomain (x4db2bd54.dyn.telefonica.de. [77.178.189.84])
        by smtp.gmail.com with ESMTPSA id n10-v6sm16577396edr.59.2018.07.14.05.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 05:53:07 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/6] staging: rtl8188eu: rename Efuse_PowerSwitch
Date:   Sat, 14 Jul 2018 14:52:37 +0200
Message-Id: <20180714125241.15509-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180714125241.15509-1-straube.linux@gmail.com>
References: <20180714125241.15509-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function to avoid CamelCase.
Efuse_PowerSwitch -> efuse_power_switch

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c    | 8 ++++----
 drivers/staging/rtl8188eu/include/rtw_efuse.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index 367cb2cf8ad1..fa145cd89613 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -22,14 +22,14 @@ enum{
 	};
 
 /*
- * Function:	Efuse_PowerSwitch
+ * Function:	efuse_power_switch
  *
  * Overview:	When we want to enable write operation, we should change to
  *				pwr on state. When we stop write, we should switch to 500k mode
  *				and disable LDO 2.5V.
  */
 
-void Efuse_PowerSwitch(struct adapter *pAdapter, u8 bWrite, u8 PwrState)
+void efuse_power_switch(struct adapter *pAdapter, u8 bWrite, u8 PwrState)
 {
 	u8 tempval;
 	u16	tmpV16;
@@ -896,11 +896,11 @@ void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata)
  */
 static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 efuseType, u8 *Efuse)
 {
-	Efuse_PowerSwitch(pAdapter, false, true);
+	efuse_power_switch(pAdapter, false, true);
 
 	efuse_ReadEFuse(pAdapter, efuseType, 0, EFUSE_MAP_LEN_88E, Efuse);
 
-	Efuse_PowerSwitch(pAdapter, false, false);
+	efuse_power_switch(pAdapter, false, false);
 }
 
 /*
diff --git a/drivers/staging/rtl8188eu/include/rtw_efuse.h b/drivers/staging/rtl8188eu/include/rtw_efuse.h
index adfbf3571c8b..e125bab0caf1 100644
--- a/drivers/staging/rtl8188eu/include/rtw_efuse.h
+++ b/drivers/staging/rtl8188eu/include/rtw_efuse.h
@@ -82,7 +82,7 @@ u8 efuse_OneByteWrite(struct adapter *adapter, u16 addr, u8 data);
 
 void efuse_ReadEFuse(struct adapter *Adapter, u8 efuseType, u16 _offset,
 		u16 _size_byte, u8 *pbuf);
-void Efuse_PowerSwitch(struct adapter *adapt, u8 bWrite, u8  PwrState);
+void efuse_power_switch(struct adapter *adapt, u8 bWrite, u8  PwrState);
 int Efuse_PgPacketRead(struct adapter *adapt, u8 offset, u8 *data);
 bool Efuse_PgPacketWrite(struct adapter *adapter, u8 offset, u8 word, u8 *data);
 void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata);
-- 
2.18.0

