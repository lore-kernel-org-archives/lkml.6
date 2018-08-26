Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358E9C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA57216FA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWAJLhz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA57216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeH0A7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:59:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40220 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbeH0A7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:59:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id e19-v6so9111053edq.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R5RAHp55RPE2r8rtHSmaFp/YwX62XtujCkWslqSEarc=;
        b=iWAJLhz5bWRr1UViKW1tL/GcMkf3/GtUIygxWvVYLR1NvB4EAqLnKGiJELSj4n8VFC
         shHfdswUfuUSrMoYJc18a5AAA73auleB8DP6bNLPKYVgRY7tZXtgu/UXKeXUDyZ4cIok
         VPioTwchot6YD6JqiChiJWsySuSEodSb/UikTYcL84pnfaZx7LdK7AcIAfWtUtUPpgEZ
         0suJ7FnxODqQ1VLiBCrN612d4ARLiGRkcQ7BFDQ1Pd3koJ6BuI3fECI1hc/Zq4dHioEy
         4uU3BSCbGmgNP05gm78cEQO3ATgdlvJyXyiJ8RITbBv46oiQmNaEi41FiueUdfm9lLPY
         ozQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R5RAHp55RPE2r8rtHSmaFp/YwX62XtujCkWslqSEarc=;
        b=Y1mJ30pAxsNP9N1NJq3oGQUz53Gy50yAZubGxCXIzpuSHt5UuNwDcVHzwOvSTEuTUC
         /I0L7YQekBeiOTdljCohmg8pVBmG9iQBwv8/SSJvoAJ2G+iRoXw5CYHDqDvVxjHXn0Nv
         V5SZ5kazoe0rZxutMvlaBX4DJbI5m8rBWHdBEfT95t3udlaRXyrazpU3A6fwj2s3QBS/
         OACRv6Zs8HtB8Z5qInBE4HFtLDutOxfnR3IIvDVfNlp+BrWdbgjWpoNQge8cBwuUAaQ7
         53w7d0vntFnP2irdIMyVDRp+WFiyOKKzqb21RrUovdY/srFxwzC+yKn+zu1fnnTUB8aO
         tj/w==
X-Gm-Message-State: APzg51AGPGxwQHEwzAzVQsA+ptNW4bUW9Hf+SCCQ4klp/2WS3xGGA1PI
        BLY/HG+d2CW5o8Wcg3rh/9JK2h+M
X-Google-Smtp-Source: ANB0Vdbs/F8L/mY4gAl+jOFb3O8oMnLGJNfH0av2c1C+a/VSglurT8dTURmeDj3H+rcDHJv9xcKCgg==
X-Received: by 2002:a50:b764:: with SMTP id g91-v6mr14460210ede.187.1535318122560;
        Sun, 26 Aug 2018 14:15:22 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:15:21 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 20/21] staging:rtl8192u: Rename EEPROM_Customer_ID - Style
Date:   Sun, 26 Aug 2018 22:14:38 +0100
Message-Id: <20180826211439.14326-21-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the constant EEPROM_Customer_ID to EEPROM_CUSTOMER_ID,
this change clears the checkpatch issue with CamelCase naming.

This is purely a coding style change which should have no
impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 drivers/staging/rtl8192u/r8192U_hw.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 5bb0602e8a20..905484ac439f 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2388,7 +2388,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 		tmpValue = (u16)ret;
 		priv->eeprom_ChannelPlan = (tmpValue & 0xff00) >> 8;
 		priv->btxpowerdata_readfromEEPORM = true;
-		ret = eprom_read(dev, (EEPROM_Customer_ID >> 1)) >> 8;
+		ret = eprom_read(dev, (EEPROM_CUSTOMER_ID >> 1)) >> 8;
 		if (ret < 0)
 			return ret;
 		priv->eeprom_CustomerID = (u16)ret;
diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index af3f84065619..606ab46d1a0c 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -52,7 +52,7 @@
 #define EEPROM_DEFAULT_PW_DIFF			0x4
 #define EEPROM_DEFAULT_CRYSTAL_CAP		0x5
 #define EEPROM_DEFAULT_TX_POWER		0x1010
-#define EEPROM_Customer_ID			0x7B	//0x7B:CustomerID
+#define EEPROM_CUSTOMER_ID			0x7B	//0x7B:CustomerID
 #define EEPROM_ChannelPlan			0x16	//0x7C
 
 #define EEPROM_CID_RUNTOP				0x2
-- 
2.18.0

