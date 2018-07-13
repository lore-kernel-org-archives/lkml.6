Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC189ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A8320873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRO06aOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A8320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbeGMLiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:38:04 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36801 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbeGMLiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:38:03 -0400
Received: by mail-ed1-f67.google.com with SMTP id t3-v6so24316925eds.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dBQETJdZtPnO0QoGLFhILEodNxg5ztalIzKVMDAwVGc=;
        b=LRO06aOmApqUJZLfXL5QhW8aJApK2+5owzvo+tfSN52yIZpe0bl/pcZs7eZpnqE4Rl
         xwupWvjX0JdfP2/dYGmQxui/5c9pserMWa5qMYyQl99e5Qa0PHTTRBRNILPr1v1Prn4u
         vuM4In+53LFn/PxvUv4ig0CTle/zpO/MITVOe0YGwqzAoiVv1Bn8myvhotRiWdtHwdkR
         Rf6Qsw98PlnoYpXVHLVRCPSX6Xlt/1g07zGpbB0mKYWjuFsl/iRf34DY5Rc5zizhgpYn
         NjKYnaMtfvlSrkioGJNQ6YQFaatXKAXOkLIisi0RJyfPJ8F7ocu1r5BndR3735RYg85E
         tieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dBQETJdZtPnO0QoGLFhILEodNxg5ztalIzKVMDAwVGc=;
        b=KjWJoAPjGXpqZttmnQxVb2Uqwq0wbGBKcWuqElLE2rlKQhlLVlr483iAiEDoZZN5bx
         LlNplG3ajuAOZV2E1vNciIOuLKRxUNu4RwPnRZjdQVQcadpHKGzrbtO0JLF81xJLFaWK
         L7rj6lXydP0IJ11rlHDIIFAMjwsms5aP2zLJbQlj2BmAN9gNoWyYWgzQoybSQXr6IEVQ
         lDihgdVE2kMaTP7Pyow9z+qJPp1yMcEcJjXcrzcMdf3brRvh6/4tz5KiTyVJk/YNPRl6
         QGcx4pzjjeu7ebPvxAORJvMaDHb9Osi7MV2ChbPbzHBreppfxrnGkbFivsyREMu1HeZz
         AUWQ==
X-Gm-Message-State: AOUpUlESl4dJ0RlII02GXXdrd4+W9Wjrn3yXfC/71ZXZQk7sqMMk3z7P
        O8AePvAQi/Sw3O+KRkFbnmgQ8pbt
X-Google-Smtp-Source: AAOMgpfdNlZb5UpfP7QyF93S3JqrFPcZ9LU7YlzwZxsrqbE2LE8rNAWnNj94iRlZhdcEl3rqz33BZw==
X-Received: by 2002:a50:83e6:: with SMTP id 93-v6mr1772138edi.164.1531481026066;
        Fri, 13 Jul 2018 04:23:46 -0700 (PDT)
Received: from localhost.localdomain ([109.78.208.2])
        by smtp.gmail.com with ESMTPSA id r25-v6sm9392868edb.45.2018.07.13.04.23.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 04:23:45 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/13] staging:rtl8192u: Remove typdef from enumeration RF90_RADIO_PATH_E - Style
Date:   Fri, 13 Jul 2018 12:23:01 +0100
Message-Id: <20180713112311.544-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713112311.544-1-johnfwhitmore@gmail.com>
References: <20180713112311.544-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch warns about the creation of new types. This patch simply removes
the typedef from the enumeration RF90_RADIO_PATH_E to clear this checkpatch
warning. There should be no impact on run time code execution, as this is a
coding style issue only.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8190_rtl8256.c | 42 ++++++++++++------------
 drivers/staging/rtl8192u/r8192U_core.c   |  4 +--
 drivers/staging/rtl8192u/r819xU_phy.c    | 31 ++++++++++-------
 drivers/staging/rtl8192u/r819xU_phy.h    | 15 +++++----
 4 files changed, 51 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.c b/drivers/staging/rtl8192u/r8190_rtl8256.c
index 02bdd933f05b..9f35dcb9e13e 100644
--- a/drivers/staging/rtl8192u/r8190_rtl8256.c
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.c
@@ -41,16 +41,16 @@ void PHY_SetRF8256Bandwidth(struct net_device *dev, enum ht_channel_width Bandwi
 					|| priv->card_8192_version
 					== VERSION_819xU_B) { /* 8256 D-cut, E-cut, xiong: consider it later! */
 					rtl8192_phy_SetRFReg(dev,
-						(RF90_RADIO_PATH_E)eRFPath,
+						(enum RF90_RADIO_PATH_E)eRFPath,
 						0x0b, bMask12Bits, 0x100); /* phy para:1ba */
 					rtl8192_phy_SetRFReg(dev,
-						(RF90_RADIO_PATH_E)eRFPath,
+						(enum RF90_RADIO_PATH_E)eRFPath,
 						0x2c, bMask12Bits, 0x3d7);
 					rtl8192_phy_SetRFReg(dev,
-						(RF90_RADIO_PATH_E)eRFPath,
+						(enum RF90_RADIO_PATH_E)eRFPath,
 						0x0e, bMask12Bits, 0x021);
 					rtl8192_phy_SetRFReg(dev,
-						(RF90_RADIO_PATH_E)eRFPath,
+						(enum RF90_RADIO_PATH_E)eRFPath,
 						0x14, bMask12Bits, 0x5ab);
 				} else {
 					RT_TRACE(COMP_ERR, "PHY_SetRF8256Bandwidth(): unknown hardware version\n");
@@ -58,15 +58,15 @@ void PHY_SetRF8256Bandwidth(struct net_device *dev, enum ht_channel_width Bandwi
 				break;
 		case HT_CHANNEL_WIDTH_20_40:
 				if (priv->card_8192_version == VERSION_819xU_A || priv->card_8192_version == VERSION_819xU_B) { /* 8256 D-cut, E-cut, xiong: consider it later! */
-					rtl8192_phy_SetRFReg(dev, (RF90_RADIO_PATH_E)eRFPath, 0x0b, bMask12Bits, 0x300); /* phy para:3ba */
-					rtl8192_phy_SetRFReg(dev, (RF90_RADIO_PATH_E)eRFPath, 0x2c, bMask12Bits, 0x3df);
-					rtl8192_phy_SetRFReg(dev, (RF90_RADIO_PATH_E)eRFPath, 0x0e, bMask12Bits, 0x0a1);
+					rtl8192_phy_SetRFReg(dev, (enum RF90_RADIO_PATH_E)eRFPath, 0x0b, bMask12Bits, 0x300); /* phy para:3ba */
+					rtl8192_phy_SetRFReg(dev, (enum RF90_RADIO_PATH_E)eRFPath, 0x2c, bMask12Bits, 0x3df);
+					rtl8192_phy_SetRFReg(dev, (enum RF90_RADIO_PATH_E)eRFPath, 0x0e, bMask12Bits, 0x0a1);
 
 					if (priv->chan == 3 || priv->chan == 9)
 						/* I need to set priv->chan whenever current channel changes */
-						rtl8192_phy_SetRFReg(dev, (RF90_RADIO_PATH_E)eRFPath, 0x14, bMask12Bits, 0x59b);
+						rtl8192_phy_SetRFReg(dev, (enum RF90_RADIO_PATH_E)eRFPath, 0x14, bMask12Bits, 0x59b);
 					else
-						rtl8192_phy_SetRFReg(dev, (RF90_RADIO_PATH_E)eRFPath, 0x14, bMask12Bits, 0x5ab);
+						rtl8192_phy_SetRFReg(dev, (enum RF90_RADIO_PATH_E)eRFPath, 0x14, bMask12Bits, 0x5ab);
 				} else {
 					RT_TRACE(COMP_ERR, "PHY_SetRF8256Bandwidth(): unknown hardware version\n");
 					}
@@ -115,14 +115,14 @@ void phy_RF8256_Config_ParaFile(struct net_device *dev)
 	u8	ConstRetryTimes = 5, RetryTimes = 5;
 	u8 ret = 0;
 	/* Initialize RF */
-	for (eRFPath = (RF90_RADIO_PATH_E)RF90_PATH_A; eRFPath < priv->NumTotalRFPath; eRFPath++) {
+	for (eRFPath = (enum RF90_RADIO_PATH_E)RF90_PATH_A; eRFPath < priv->NumTotalRFPath; eRFPath++) {
 		if (!rtl8192_phy_CheckIsLegalRFPath(dev, eRFPath))
 			continue;
 
 		pPhyReg = &priv->PHYRegDef[eRFPath];
 
 		/* Joseph test for shorten RF config
-		 * pHalData->RfReg0Value[eRFPath] =  rtl8192_phy_QueryRFReg(dev, (RF90_RADIO_PATH_E)eRFPath, rGlobalCtrl, bMaskDWord);
+		 * pHalData->RfReg0Value[eRFPath] =  rtl8192_phy_QueryRFReg(dev, (enum RF90_RADIO_PATH_E)eRFPath, rGlobalCtrl, bMaskDWord);
 		 * ----Store original RFENV control type
 		 */
 		switch (eRFPath) {
@@ -146,12 +146,12 @@ void phy_RF8256_Config_ParaFile(struct net_device *dev)
 		rtl8192_setBBreg(dev, pPhyReg->rfHSSIPara2, b3WireAddressLength, 0x0);	/* Set 0 to 4 bits for Z-serial and set 1 to 6 bits for 8258 */
 		rtl8192_setBBreg(dev, pPhyReg->rfHSSIPara2, b3WireDataLength, 0x0);	/* Set 0 to 12 bits for Z-serial and 8258, and set 1 to 14 bits for ??? */
 
-		rtl8192_phy_SetRFReg(dev, (RF90_RADIO_PATH_E) eRFPath, 0x0, bMask12Bits, 0xbf);
+		rtl8192_phy_SetRFReg(dev, (enum RF90_RADIO_PATH_E) eRFPath, 0x0, bMask12Bits, 0xbf);
 
 		/* Check RF block (for FPGA platform only)----
 		 * TODO: this function should be removed on ASIC , Emily 2007.2.2
 		 */
-		if (rtl8192_phy_checkBBAndRF(dev, HW90_BLOCK_RF, (RF90_RADIO_PATH_E)eRFPath)) {
+		if (rtl8192_phy_checkBBAndRF(dev, HW90_BLOCK_RF, (enum RF90_RADIO_PATH_E)eRFPath)) {
 			RT_TRACE(COMP_ERR, "PHY_RF8256_Config():Check Radio[%d] Fail!!\n", eRFPath);
 			goto phy_RF8256_Config_ParaFile_Fail;
 		}
@@ -162,32 +162,32 @@ void phy_RF8256_Config_ParaFile(struct net_device *dev)
 		switch (eRFPath) {
 		case RF90_PATH_A:
 			while (RF3_Final_Value != RegValueToBeCheck && RetryTimes != 0) {
-				ret = rtl8192_phy_ConfigRFWithHeaderFile(dev, (RF90_RADIO_PATH_E)eRFPath);
-				RF3_Final_Value = rtl8192_phy_QueryRFReg(dev, (RF90_RADIO_PATH_E)eRFPath, RegOffSetToBeCheck, bMask12Bits);
+				ret = rtl8192_phy_ConfigRFWithHeaderFile(dev, (enum RF90_RADIO_PATH_E)eRFPath);
+				RF3_Final_Value = rtl8192_phy_QueryRFReg(dev, (enum RF90_RADIO_PATH_E)eRFPath, RegOffSetToBeCheck, bMask12Bits);
 				RT_TRACE(COMP_RF, "RF %d %d register final value: %x\n", eRFPath, RegOffSetToBeCheck, RF3_Final_Value);
 				RetryTimes--;
 			}
 			break;
 		case RF90_PATH_B:
 			while (RF3_Final_Value != RegValueToBeCheck && RetryTimes != 0) {
-				ret = rtl8192_phy_ConfigRFWithHeaderFile(dev, (RF90_RADIO_PATH_E)eRFPath);
-				RF3_Final_Value = rtl8192_phy_QueryRFReg(dev, (RF90_RADIO_PATH_E)eRFPath, RegOffSetToBeCheck, bMask12Bits);
+				ret = rtl8192_phy_ConfigRFWithHeaderFile(dev, (enum RF90_RADIO_PATH_E)eRFPath);
+				RF3_Final_Value = rtl8192_phy_QueryRFReg(dev, (enum RF90_RADIO_PATH_E)eRFPath, RegOffSetToBeCheck, bMask12Bits);
 				RT_TRACE(COMP_RF, "RF %d %d register final value: %x\n", eRFPath, RegOffSetToBeCheck, RF3_Final_Value);
 				RetryTimes--;
 			}
 			break;
 		case RF90_PATH_C:
 			while (RF3_Final_Value != RegValueToBeCheck && RetryTimes != 0) {
-				ret = rtl8192_phy_ConfigRFWithHeaderFile(dev, (RF90_RADIO_PATH_E)eRFPath);
-				RF3_Final_Value = rtl8192_phy_QueryRFReg(dev, (RF90_RADIO_PATH_E)eRFPath, RegOffSetToBeCheck, bMask12Bits);
+				ret = rtl8192_phy_ConfigRFWithHeaderFile(dev, (enum RF90_RADIO_PATH_E)eRFPath);
+				RF3_Final_Value = rtl8192_phy_QueryRFReg(dev, (enum RF90_RADIO_PATH_E)eRFPath, RegOffSetToBeCheck, bMask12Bits);
 				RT_TRACE(COMP_RF, "RF %d %d register final value: %x\n", eRFPath, RegOffSetToBeCheck, RF3_Final_Value);
 				RetryTimes--;
 			}
 			break;
 		case RF90_PATH_D:
 			while (RF3_Final_Value != RegValueToBeCheck && RetryTimes != 0) {
-				ret = rtl8192_phy_ConfigRFWithHeaderFile(dev, (RF90_RADIO_PATH_E)eRFPath);
-				RF3_Final_Value = rtl8192_phy_QueryRFReg(dev, (RF90_RADIO_PATH_E)eRFPath, RegOffSetToBeCheck, bMask12Bits);
+				ret = rtl8192_phy_ConfigRFWithHeaderFile(dev, (enum RF90_RADIO_PATH_E)eRFPath);
+				RF3_Final_Value = rtl8192_phy_QueryRFReg(dev, (enum RF90_RADIO_PATH_E)eRFPath, RegOffSetToBeCheck, bMask12Bits);
 				RT_TRACE(COMP_RF, "RF %d %d register final value: %x\n", eRFPath, RegOffSetToBeCheck, RF3_Final_Value);
 				RetryTimes--;
 			}
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 848239e24859..b5ce3ee89e9f 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2897,7 +2897,7 @@ static bool rtl8192_adapter_start(struct net_device *dev)
 			 */
 			for (eRFPath = 0; eRFPath < pHalData->NumTotalRFPath; eRFPath++)
 				PHY_SetRFReg(Adapter,
-					     (RF90_RADIO_PATH_E)eRFPath,
+					     (enum RF90_RADIO_PATH_E)eRFPath,
 					     0x4, 0xC00, 0x0);
 		} else if (pMgntInfo->RfOffReason > RF_CHANGE_BY_PS) {
 			/* H/W or S/W RF OFF before sleep. */
@@ -2923,7 +2923,7 @@ static bool rtl8192_adapter_start(struct net_device *dev)
 			 */
 			for (eRFPath = 0; eRFPath < pHalData->NumTotalRFPath; eRFPath++)
 				PHY_SetRFReg(Adapter,
-					     (RF90_RADIO_PATH_E)eRFPath,
+					     (enum RF90_RADIO_PATH_E)eRFPath,
 					     0x4, 0xC00, 0x0);
 		}
 	}
diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 0462de662eff..3df4775e1f99 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -108,11 +108,13 @@ u32 rtl8192_QueryBBReg(struct net_device *dev, u32 reg_addr, u32 bitmask)
 	return (reg & bitmask) >> bitshift;
 }
 
-static u32 phy_FwRFSerialRead(struct net_device *dev, RF90_RADIO_PATH_E eRFPath,
+static u32 phy_FwRFSerialRead(struct net_device *dev,
+			      enum RF90_RADIO_PATH_E eRFPath,
 			      u32 offset);
 
 static void phy_FwRFSerialWrite(struct net_device *dev,
-				RF90_RADIO_PATH_E eRFPath, u32  offset,
+				enum RF90_RADIO_PATH_E eRFPath,
+				u32  offset,
 				u32  data);
 
 /******************************************************************************
@@ -130,7 +132,7 @@ static void phy_FwRFSerialWrite(struct net_device *dev,
  *            ---need more spec for this information.
  ******************************************************************************/
 static u32 rtl8192_phy_RFSerialRead(struct net_device *dev,
-				    RF90_RADIO_PATH_E eRFPath, u32 offset)
+				    enum RF90_RADIO_PATH_E eRFPath, u32 offset)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	u32 ret = 0;
@@ -215,7 +217,8 @@ static u32 rtl8192_phy_RFSerialRead(struct net_device *dev,
  * ---------------------------------------------------------------------------
  *****************************************************************************/
 static void rtl8192_phy_RFSerialWrite(struct net_device *dev,
-				      RF90_RADIO_PATH_E eRFPath, u32 offset,
+				      enum RF90_RADIO_PATH_E eRFPath,
+				      u32 offset,
 				      u32 data)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
@@ -279,7 +282,8 @@ static void rtl8192_phy_RFSerialWrite(struct net_device *dev,
  * return:    none
  * notice:
  *****************************************************************************/
-void rtl8192_phy_SetRFReg(struct net_device *dev, RF90_RADIO_PATH_E eRFPath,
+void rtl8192_phy_SetRFReg(struct net_device *dev,
+			  enum RF90_RADIO_PATH_E eRFPath,
 			  u32 reg_addr, u32 bitmask, u32 data)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
@@ -327,7 +331,8 @@ void rtl8192_phy_SetRFReg(struct net_device *dev, RF90_RADIO_PATH_E eRFPath,
  * return:    u32               data     //the readback register value
  * notice:
  *****************************************************************************/
-u32 rtl8192_phy_QueryRFReg(struct net_device *dev, RF90_RADIO_PATH_E eRFPath,
+u32 rtl8192_phy_QueryRFReg(struct net_device *dev,
+			   enum RF90_RADIO_PATH_E eRFPath,
 			   u32 reg_addr, u32 bitmask)
 {
 	u32 reg, bitshift;
@@ -357,7 +362,8 @@ u32 rtl8192_phy_QueryRFReg(struct net_device *dev, RF90_RADIO_PATH_E eRFPath,
  * return:    u32
  * notice:
  ****************************************************************************/
-static u32 phy_FwRFSerialRead(struct net_device *dev, RF90_RADIO_PATH_E eRFPath,
+static u32 phy_FwRFSerialRead(struct net_device *dev,
+			      enum RF90_RADIO_PATH_E eRFPath,
 			      u32 offset)
 {
 	u32		reg = 0;
@@ -422,7 +428,8 @@ static u32 phy_FwRFSerialRead(struct net_device *dev, RF90_RADIO_PATH_E eRFPath,
  * notice:
  ****************************************************************************/
 static void phy_FwRFSerialWrite(struct net_device *dev,
-				RF90_RADIO_PATH_E eRFPath, u32 offset, u32 data)
+				enum RF90_RADIO_PATH_E eRFPath,
+				u32 offset, u32 data)
 {
 	u8	time = 0;
 	u32	tmp;
@@ -696,7 +703,7 @@ static void rtl8192_InitBBRFRegDef(struct net_device *dev)
  * notice:    This function may be removed in the ASIC
  ******************************************************************************/
 u8 rtl8192_phy_checkBBAndRF(struct net_device *dev, enum HW90_BLOCK_E CheckBlock,
-			    RF90_RADIO_PATH_E eRFPath)
+			    enum RF90_RADIO_PATH_E eRFPath)
 {
 	u8 ret = 0;
 	u32 i, CheckTimes = 4, reg = 0;
@@ -791,7 +798,7 @@ static void rtl8192_BB_Config_ParaFile(struct net_device *dev)
 	     eCheckItem <= HW90_BLOCK_PHY1; eCheckItem++) {
 		/* don't care RF path */
 		status = rtl8192_phy_checkBBAndRF(dev, (enum HW90_BLOCK_E)eCheckItem,
-						  (RF90_RADIO_PATH_E)0);
+						  (enum RF90_RADIO_PATH_E)0);
 		if (status != 0) {
 			RT_TRACE((COMP_ERR | COMP_PHY),
 				 "PHY_RF8256_Config(): Check PHY%d Fail!!\n",
@@ -969,7 +976,7 @@ void rtl8192_phy_updateInitGain(struct net_device *dev)
  * notice:    Delay may be required for RF configuration
  *****************************************************************************/
 u8 rtl8192_phy_ConfigRFWithHeaderFile(struct net_device *dev,
-				      RF90_RADIO_PATH_E	eRFPath)
+				      enum RF90_RADIO_PATH_E	eRFPath)
 {
 
 	int i;
@@ -1387,7 +1394,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 		case CmdID_RF_WriteReg:
 			for (eRFPath = 0; eRFPath < RF90_PATH_MAX; eRFPath++) {
 				rtl8192_phy_SetRFReg(dev,
-						     (RF90_RADIO_PATH_E)eRFPath,
+						     (enum RF90_RADIO_PATH_E)eRFPath,
 						     CurrentCmd->Para1,
 						     bZebra1_ChannelNum,
 						     CurrentCmd->Para2);
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 0f680a04a468..d93da2360649 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -42,13 +42,13 @@ enum HW90_BLOCK_E {
 	HW90_BLOCK_MAXIMUM = 4, /* Never use this */
 };
 
-typedef enum _RF90_RADIO_PATH {
+enum RF90_RADIO_PATH_E {
 	RF90_PATH_A = 0,			/* Radio Path A */
 	RF90_PATH_B = 1,			/* Radio Path B */
 	RF90_PATH_C = 2,			/* Radio Path C */
 	RF90_PATH_D = 3,			/* Radio Path D */
 	RF90_PATH_MAX				/* Max RF number 92 support */
-} RF90_RADIO_PATH_E, *PRF90_RADIO_PATH_E;
+};
 
 #define bMaskByte0                0xff
 #define bMaskByte1                0xff00
@@ -62,21 +62,24 @@ u8 rtl8192_phy_CheckIsLegalRFPath(struct net_device *dev, u32 eRFPath);
 void rtl8192_setBBreg(struct net_device *dev, u32 reg_addr,
 		      u32 bitmask, u32 data);
 u32 rtl8192_QueryBBReg(struct net_device *dev, u32 reg_addr, u32 bitmask);
-void rtl8192_phy_SetRFReg(struct net_device *dev, RF90_RADIO_PATH_E eRFPath,
+void rtl8192_phy_SetRFReg(struct net_device *dev,
+			  enum RF90_RADIO_PATH_E eRFPath,
 			  u32 reg_addr, u32 bitmask, u32 data);
-u32 rtl8192_phy_QueryRFReg(struct net_device *dev, RF90_RADIO_PATH_E eRFPath,
+u32 rtl8192_phy_QueryRFReg(struct net_device *dev,
+			   enum RF90_RADIO_PATH_E eRFPath,
 			   u32 reg_addr, u32 bitmask);
 void rtl8192_phy_configmac(struct net_device *dev);
 void rtl8192_phyConfigBB(struct net_device *dev, u8 ConfigType);
 u8 rtl8192_phy_checkBBAndRF(struct net_device *dev,
-			    enum HW90_BLOCK_E CheckBlock, RF90_RADIO_PATH_E eRFPath);
+			    enum HW90_BLOCK_E CheckBlock,
+			    enum RF90_RADIO_PATH_E eRFPath);
 void rtl8192_BBConfig(struct net_device *dev);
 void rtl8192_phy_getTxPower(struct net_device *dev);
 void rtl8192_phy_setTxPower(struct net_device *dev, u8 channel);
 void rtl8192_phy_RFConfig(struct net_device *dev);
 void rtl8192_phy_updateInitGain(struct net_device *dev);
 u8 rtl8192_phy_ConfigRFWithHeaderFile(struct net_device *dev,
-				      RF90_RADIO_PATH_E eRFPath);
+				      enum RF90_RADIO_PATH_E eRFPath);
 
 u8 rtl8192_phy_SwChnl(struct net_device *dev, u8 channel);
 void rtl8192_SetBWMode(struct net_device *dev,
-- 
2.18.0

