Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08472C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A405E20659
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7XQFhFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A405E20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeH0A64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:58:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41025 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeH0A6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:58:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id f38-v6so9098006edd.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s+dlk2tS6VA+X0HWR5IPXJtixuFJMEV2KaaF5BMlIuM=;
        b=h7XQFhFImw7/k1DmFVp27w6+jPIF4rMvslauOfaqrZdGbfWy5+fjOu4jqHDmVSHT+y
         ZUhIhAcFtaFHo21hWnVHoaFRDwc1sT9AEJz1qpPC7hR8ZLRyEV5ZMu5KGfLS3cf1IyHQ
         m2BcQwCYt+mNPgruzTPixGXWlbFH6yT/f+JBDHFkBZcIX+KgeDeO9Q3L56QvclaE7Wkc
         0WVFTLn3UhxKe+kIpKHMmHCoziNMXIWgSiIqUFKp6dS288TeLfRKvMN4SnV7hplw1y2W
         Yty6EDDIjWV5NeOPvbFjZHhfGWEqkXnP8jcpWsMffq2IED5XV452lT2qKQX2j5dZbF92
         nQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s+dlk2tS6VA+X0HWR5IPXJtixuFJMEV2KaaF5BMlIuM=;
        b=tDPcmoWX1agABz7IDQ5OqVEIcSc7ikeuZspmOGDAIHVhxXwC29/g5CFRKyDtp+Mt+2
         O3jbl4Fr/C0O6BEVbHcYxZd+nRcy+CRR2ufRTtUhg5MCAcYJ/qtjQZ8KGT3Z4eTnaBmo
         dGdIbSrXgVFUBzfIPWedGAmr1BvRFpP3OUXa9aCHlJpGYHxggWd561fuLFErAeR3WTi8
         v9xSKlpkJC++gYBbEVV+oulW4PiCqcijdal1Ku6LMwigBpBBkxp4QZ7Il4Z64ZxSVXC2
         V+wCfqBeNb+T+HAtRLEmBAKy/K0iu3jizBMaincIolk39qq+iH4LiY21aGhBLNkds0US
         Lapg==
X-Gm-Message-State: APzg51Au3MvoyuIVj84VdlATXMOZacu7FAYsy4ubTU3Jz7w+Wl1T/nTS
        RFhmt5Cd7wsA7Yyg+IsfrsivMmRu
X-Google-Smtp-Source: ANB0VdYBJUDULPsO3p/MyxRGbzg9RvXTTIiVjgOT4xSybqUB+hjndm5D0Ih2bBY5RG7k1EVpgS3p2A==
X-Received: by 2002:aa7:c584:: with SMTP id g4-v6mr4025546edq.124.1535318110837;
        Sun, 26 Aug 2018 14:15:10 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:15:09 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 11/21] staging:rtl8192u: Rename EEPROM_TxPwIndex_CCK - Style
Date:   Sun, 26 Aug 2018 22:14:29 +0100
Message-Id: <20180826211439.14326-12-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the constant EEPROM_TxPwIndex_CCK to EEPROM_TX_PW_INDEX_CCK.
This change clears the checkpatch issue with CamelCase naming.

The change is coding style in nature so should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 drivers/staging/rtl8192u/r8192U_hw.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 1c9b9da5e65b..83a61fcab53b 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2474,7 +2474,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 			int i;
 
 			if (bLoad_From_EEPOM) {
-				ret = eprom_read(dev, (EEPROM_TxPwIndex_CCK >> 1));
+				ret = eprom_read(dev, (EEPROM_TX_PW_INDEX_CCK >> 1));
 				if (ret < 0)
 					return ret;
 				priv->EEPROMTxPowerLevelCCK = ((u16)ret & 0xff) >> 8;
diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index 78e4d15e2579..437bb9212e47 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -42,7 +42,7 @@
 #define EEPROM_PW_DIFF		0x21	//0x21
 #define EEPROM_CRYSTAL_CAP	0x22	//0x22
 
-#define EEPROM_TxPwIndex_CCK	0x23	//0x23
+#define EEPROM_TX_PW_INDEX_CCK	0x23	//0x23
 #define EEPROM_TxPwIndex_OFDM_24G	0x24	//0x24~0x26
 #define EEPROM_TxPwIndex_CCK_V1		0x29	//0x29~0x2B
 #define EEPROM_TxPwIndex_OFDM_24G_V1	0x2C	//0x2C~0x2E
-- 
2.18.0

