Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D818C43334
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE572086A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzqm/2/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE572086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeH0A6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:58:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40202 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeH0A6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:58:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id e19-v6so9110703edq.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6Usxd8oCDmvqjFHo1YBT7oamHuDbNjZrQsDaFcuepYc=;
        b=bzqm/2/JYAqMmrNQmMErL39vSj+rmuhMo4rvodXbq/4izMIdq6mWewuswgatAxCkMF
         kMy88X1TgqaQ5qF5xDJ14tgdBWYvMDMRbIG0oZssf40Jh88zlYv8CBZtbaVoprDNBjnN
         2FhhTmsGsKe1djjipepmSkk2HxCufSGx4iPyMPNhb6l4JFr3g6sN4B8XcA+55Tf/D01h
         Rx9v1aXUE2g0d8aPhRyA3ilZjDqcz/hqYRyqNg2nwjzemYqtUhXyP27FuJdAvkOmsiiD
         m/eCZ0/AQQzE/QWisBKE+pGtvnA7BrVGZQ8L5ae51zTgK8Fdgbv8t+o26jnVk0+4Hjd6
         vYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6Usxd8oCDmvqjFHo1YBT7oamHuDbNjZrQsDaFcuepYc=;
        b=rwNp+9ZfWV1hfokK4GlTLregojo/zBvNsnMHdJMcWHGt2iwLcXwUuF/1zwns8VdRWr
         5MiEQA9hQxE9v2iojafRbs0fmveB3Uwr+hrNGwBiVJPzRNpV0+DepAbIdqJv++GryYBv
         hzYLOz2Cz+LSkCqkHq5Wq8dEJqmcfoWZC/5mc/RHDcSoPezmR/0ehGF+8D1ykma9lNpW
         GNEF9snLmCoj8cx/22MwDAy9KlNDpCLz5eVpJvQqPLDYTF4vC1VfbdI2fIk6UlY/UFPc
         E8yrPhG/ua34Md8Wyy9k5esVNyg8Sva22dAE1gnUqPkepJiIATvvaIEh8pSuXaRbzxNB
         nWLQ==
X-Gm-Message-State: APzg51A//Ubzw0XPd74V1w1asQaf0fBYALViJqgZx75huGCpXawi25Dm
        LrzgK32OuGf4Q/+yZfGUGO6hloXC
X-Google-Smtp-Source: ANB0Vdb03Db0CZL2NgHIS4Dl9wi/Mva39N+wvmlTfVMsWvRHjhgRV9vNqEdgK3ja3XJPKFMicvSAyA==
X-Received: by 2002:a50:a207:: with SMTP id 7-v6mr13888582edl.48.1535318101069;
        Sun, 26 Aug 2018 14:15:01 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:15:00 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/21] staging:rtl8192u: Refactor BaseBand_Config_Type - Style
Date:   Sun, 26 Aug 2018 22:14:22 +0100
Message-Id: <20180826211439.14326-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the type to baseband_config_type to clear the checkpatch issue
with CamelCase naming. Remove the 'typedef' directive to clear the
issue with defining new types.

As it is only used in the file r819xU_phy.c the type has been moved
to the r819xU_phy.h file.

The enumerated type is only used as a parameter to the function
rtl8192_phyConfigBB. Previously that parameter used type 'u8' so no
compiler typechecking was being performed. The parameter type has been
corrected.

These changes are coding style changes and as such should have no
impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_hw.h  |  4 ----
 drivers/staging/rtl8192u/r819xU_phy.c | 11 ++++++-----
 drivers/staging/rtl8192u/r819xU_phy.h |  5 +++++
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index f91dd20fa568..0b5fb42e5427 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -20,10 +20,6 @@
 #ifndef R8192_HW
 #define R8192_HW
 
-typedef enum _BaseBand_Config_Type {
-	BaseBand_Config_PHY_REG = 0,			//Radio Path A
-	BaseBand_Config_AGC_TAB = 1,			//Radio Path B
-} BaseBand_Config_Type, *PBaseBand_Config_Type;
 #define	RTL8187_REQT_READ	0xc0
 #define	RTL8187_REQT_WRITE	0x40
 #define	RTL8187_REQ_GET_REGS	0x05
diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index a6d7ad1f6d79..ee1e39e887ff 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -511,7 +511,8 @@ void rtl8192_phy_configmac(struct net_device *dev)
  * notice:    BB parameters may change all the time, so please make
  *            sure it has been synced with the newest.
  *****************************************************************************/
-static void rtl8192_phyConfigBB(struct net_device *dev, u8 ConfigType)
+static void rtl8192_phyConfigBB(struct net_device *dev,
+				enum baseband_config_type ConfigType)
 {
 	u32 i;
 
@@ -525,7 +526,7 @@ static void rtl8192_phyConfigBB(struct net_device *dev, u8 ConfigType)
 		Rtl8190AGCTAB_Array_Table = Rtl819XAGCTAB_ArrayDTM;
 	}
 #endif
-	if (ConfigType == BaseBand_Config_PHY_REG) {
+	if (ConfigType == BASEBAND_CONFIG_PHY_REG) {
 		for (i = 0; i < PHY_REG_1T2RArrayLength; i += 2) {
 			rtl8192_setBBreg(dev, Rtl8192UsbPHY_REG_1T2RArray[i],
 					 bMaskDWord,
@@ -535,7 +536,7 @@ static void rtl8192_phyConfigBB(struct net_device *dev, u8 ConfigType)
 				 i, Rtl8192UsbPHY_REG_1T2RArray[i],
 				 Rtl8192UsbPHY_REG_1T2RArray[i+1]);
 		}
-	} else if (ConfigType == BaseBand_Config_AGC_TAB) {
+	} else if (ConfigType == BASEBAND_CONFIG_AGC_TAB) {
 		for (i = 0; i < AGCTAB_ArrayLength; i += 2) {
 			rtl8192_setBBreg(dev, Rtl8192UsbAGCTAB_Array[i],
 					 bMaskDWord, Rtl8192UsbAGCTAB_Array[i+1]);
@@ -802,7 +803,7 @@ static void rtl8192_BB_Config_ParaFile(struct net_device *dev)
 	rtl8192_setBBreg(dev, rFPGA0_RFMOD, bCCKEn|bOFDMEn, 0x0);
 	/* ----BB Register Initilazation---- */
 	/* ==m==>Set PHY REG From Header<==m== */
-	rtl8192_phyConfigBB(dev, BaseBand_Config_PHY_REG);
+	rtl8192_phyConfigBB(dev, BASEBAND_CONFIG_PHY_REG);
 
 	/* ----Set BB reset de-Active---- */
 	read_nic_dword(dev, CPU_GEN, &reg_u32);
@@ -810,7 +811,7 @@ static void rtl8192_BB_Config_ParaFile(struct net_device *dev)
 
 	/* ----BB AGC table Initialization---- */
 	/* ==m==>Set PHY REG From Header<==m== */
-	rtl8192_phyConfigBB(dev, BaseBand_Config_AGC_TAB);
+	rtl8192_phyConfigBB(dev, BASEBAND_CONFIG_AGC_TAB);
 
 	/* ----Enable XSTAL ---- */
 	write_nic_byte_E(dev, 0x5e, 0x00);
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index c938fd8eb51c..8c2933264407 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -7,6 +7,11 @@
 #define MAX_RFDEPENDCMD_CNT 16
 #define MAX_POSTCMD_CNT 16
 
+enum baseband_config_type {
+	BASEBAND_CONFIG_PHY_REG = 0,			//Radio Path A
+	BASEBAND_CONFIG_AGC_TAB = 1,			//Radio Path B
+};
+
 enum switch_chan_cmd_id {
 	CMD_ID_END,
 	CMD_ID_SET_TX_PWR_LEVEL,
-- 
2.18.0

