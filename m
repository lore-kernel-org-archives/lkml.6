Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED46C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF5921735
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTO9k1it"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF5921735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeH0C37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 22:29:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45515 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0C36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 22:29:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id p52-v6so9156942eda.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 15:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ny3xpdYE4GZoyfGDid0DJcIY/falZyAeou8iEb9Rgr0=;
        b=WTO9k1itg12Rti7ouETqvwnMcEXg6hJ9g+6RLnigd4X07rRiKdxTwOIHJs17JElzxr
         TbNxGY2kg+4pWC0aIp9wxlSi2YhxAkPuDnEdqYf174x563TD2K8HmV4CGyCbX5iFTNNt
         jfcnvfK4RqU8lG++pRokie3WyftWtIzxYZREZkkb5ILJTQvCME9jtkdBmlQBGLRW1F7h
         ylvDcqHcj1kkFBQIfFtSAYlc8MKPV8BOvSIsz/xPQ/U5kuuVfWp5jwMB7IGrBOWbcjM/
         xaSRPeVjUBpiM0DUb9zYbJzWQgpj5amCsIwCB2bMDYx8FhJBjZUdszsz/6zVhIv+KBsi
         +9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ny3xpdYE4GZoyfGDid0DJcIY/falZyAeou8iEb9Rgr0=;
        b=pjxy5yeRL2COdTQ422ltACZUadKwrxJDRFQQiqROiI4VpQudBg76NtQlQTfSU+K0ns
         Ly2Ix/UBi42pKnMmlDRKCL7Zk4F1BoGqKugjAFIDN8CzBmPLsb6/o7yrk+Ekaa2uIYVP
         DdPRmjilhefNLQiNfxxvd9w5yUxT9PTnK6nm+BJFOtDsZcQlTIVbte9wk/IqZZ8MX+/q
         F0CFRjbZ3ZFXDcEYdIuwsFcU1XgE5QCxpmpmLsVHJGY9lRHUBr2+i3bttwlchCfrJ8ny
         LfxRLsMLI4pqyzPXvbkipG5C49btwE0LDua3AJeu5sxilpBTuzZE87/aE5x/EeFy7U7K
         Rt2w==
X-Gm-Message-State: APzg51Bhf5sT6YNE6gT/u4BDOzvy2GZ3yz+gnXK15E8j6jzKlcFitZDI
        baC9cIQWpdv7nT7GGX+wNCArLdqi
X-Google-Smtp-Source: ANB0VdaTo29WN4kRsdUcSA7MPHBLjjel6xzvkd8Iu3NRpmwVMfhW7j1pa2m4EsJe9+MXDsSTvNHXTQ==
X-Received: by 2002:a50:89d3:: with SMTP id h19-v6mr14069770edh.140.1535323559250;
        Sun, 26 Aug 2018 15:45:59 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id a33-v6sm5519165eda.2.2018.08.26.15.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 15:45:58 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 3/6] staging:rtl8192u: Refactor phy_RF8256_Config_ParaFile() - Style
Date:   Sun, 26 Aug 2018 23:45:30 +0100
Message-Id: <20180826224533.16020-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826224533.16020-1-johnfwhitmore@gmail.com>
References: <20180826224533.16020-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the function phy_RF8256_Config_ParaFile() to
phy_rf8256_config_para_file(). This change clears the checkpatch issue
with CamelCase naming.

Additionally as the function is only ever used in one file,
(r8190_rtl8256.c), the function prototype has been removed from the
header file, (r8190_rtl8256.h).

These changes are purely coding style in nature and should have no
impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8190_rtl8256.c | 11 ++++++++---
 drivers/staging/rtl8192u/r8190_rtl8256.h |  1 -
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.c b/drivers/staging/rtl8192u/r8190_rtl8256.c
index 8cc7b0d46a02..7dbed5e4ea8b 100644
--- a/drivers/staging/rtl8192u/r8190_rtl8256.c
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.c
@@ -14,6 +14,11 @@
 #include "r819xU_phy.h"
 #include "r8190_rtl8256.h"
 
+/*
+ * Forward declaration of local functions
+ */
+static void phy_rf8256_config_para_file(struct net_device *dev);
+
 /*--------------------------------------------------------------------------
  * Overview:	set RF band width (20M or 40M)
  * Input:       struct net_device*	dev
@@ -94,7 +99,7 @@ void phy_rf8256_config(struct net_device *dev)
 	 */
 	priv->NumTotalRFPath = RTL819X_TOTAL_RF_PATH;
 	/* Config BB and RF */
-	phy_RF8256_Config_ParaFile(dev);
+	phy_rf8256_config_para_file(dev);
 }
 /*--------------------------------------------------------------------------
  * Overview:    Interface to config 8256
@@ -103,7 +108,7 @@ void phy_rf8256_config(struct net_device *dev)
  * Return:      NONE
  *--------------------------------------------------------------------------
  */
-void phy_RF8256_Config_ParaFile(struct net_device *dev)
+static void phy_rf8256_config_para_file(struct net_device *dev)
 {
 	u32	u4RegValue = 0;
 	u8	eRFPath;
@@ -207,7 +212,7 @@ void phy_RF8256_Config_ParaFile(struct net_device *dev)
 		}
 
 		if (ret) {
-			RT_TRACE(COMP_ERR, "phy_RF8256_Config_ParaFile():Radio[%d] Fail!!", eRFPath);
+			RT_TRACE(COMP_ERR, "phy_rf8256_config_para_file():Radio[%d] Fail!!", eRFPath);
 			goto phy_RF8256_Config_ParaFile_Fail;
 		}
 
diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.h b/drivers/staging/rtl8192u/r8190_rtl8256.h
index b58aab020e51..891d7510cea1 100644
--- a/drivers/staging/rtl8192u/r8190_rtl8256.h
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.h
@@ -17,7 +17,6 @@
 void phy_set_rf8256_bandwidth(struct net_device *dev,
 			      enum ht_channel_width bandwidth);
 void phy_rf8256_config(struct net_device *dev);
-void phy_RF8256_Config_ParaFile(struct net_device *dev);
 void PHY_SetRF8256CCKTxPower(struct net_device *dev, u8	powerlevel);
 void PHY_SetRF8256OFDMTxPower(struct net_device *dev, u8 powerlevel);
 
-- 
2.18.0

