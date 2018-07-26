Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467CEC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D931820671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTtqtPcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D931820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbeGZUn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:43:26 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38822 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731706AbeGZUn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:43:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id t2-v6so2253239edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JB/GTrX76xr+xN5pFnNlnVRB69YzJ/LSGwjVcBU1AYs=;
        b=rTtqtPcxnoIHSbfrfnVQoCrJpmZaXZ+8knCZAMDZB18WFpMTBM8387fqsmNm7Gobm1
         PTY6pIqBzFXhvlbbbZxmPAK2tiEqzxGKcqKXWl6TpCmh9hF3gTn5f1MjF/GWc/2EJqH5
         hv5Yu5/gC3+/+YYif4PLzcO7sDAuSO4kEkCNvX95gLEXA5Z7n+m7hlUgJbpq7/muDoHh
         b+cW2Vm+oSKuILUgiI8Z21GGJsJx0sosCqILTXvVAJ8P13E0nkiFyPjGo/5Gb2Xlbiy/
         1Vj06ggcKUY8RsmK0w9KJP5pL5gdgsdRvuDA/7zaIYyFPYvXZTZDVkwH53/gTec0+r95
         k0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JB/GTrX76xr+xN5pFnNlnVRB69YzJ/LSGwjVcBU1AYs=;
        b=ZNzR+XGlzrURiNbM3BRZvE2FIaTTwcpPucGsZWYbB/fLyfUXPv69A6wRxq2bGY0TCT
         XrEbzivXkQmGaemmcy2uXGQuun8lv8O7cZycc2Wt92YdiUOhmJSCnDrpTEqF5HiyYTmM
         7pXbXoLMXuulHdLMpnsGWhJSifzxQufmyrXdTCAcvzIBShGWXxUe+RB7OgazfJdgxBK0
         b+veGz4O+A9M9cFLmHOlXI4lF9AIQV9vxsjZ0kOtmtdmd2a35NcPRagSbF0j32sq6dE9
         hoyYfHrmV+zEicmBrP5xv3CKxhI9HoxJfm7UYepXeOpd6lecHfUSURvqVOKp6p2ZWN35
         GVrQ==
X-Gm-Message-State: AOUpUlE2z9Q5+ObF6hzRgryKzsrYNY6mRrVFWn5Eh+8HzeH0bB97xQTO
        ii5V4y23PpMNDHPNR5tgGoU8/jta
X-Google-Smtp-Source: AAOMgpd8GSEN+CZ0SfPvpOtivfMjJPLDgomwLuq/ixx28SGLzqugvGHQi9z2PvvVsgB6YF5P9Ke/ug==
X-Received: by 2002:aa7:c910:: with SMTP id b16-v6mr4276606edt.22.1532633108709;
        Thu, 26 Jul 2018 12:25:08 -0700 (PDT)
Received: from localhost.localdomain ([109.76.149.40])
        by smtp.gmail.com with ESMTPSA id m20-v6sm1100853eds.5.2018.07.26.12.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:25:07 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 14/16] staging:rtl8192u: Rename RF90_RADIO_PATH_E - Style
Date:   Thu, 26 Jul 2018 20:24:24 +0100
Message-Id: <20180726192426.31913-15-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726192426.31913-1-johnfwhitmore@gmail.com>
References: <20180726192426.31913-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the enumerated type RF90_RADIO_PATH_E to rf90_radio_path_e.
Whilst it is not flagged as an issue by checkpatch, types are meant
to be named in lowercase.

This change is purely a coding style change which should have no
impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8190_rtl8256.c | 42 ++++++++++++------------
 drivers/staging/rtl8192u/r8192U_core.c   |  4 +--
 drivers/staging/rtl8192u/r819xU_phy.c    | 38 ++++++++++-----------
 drivers/staging/rtl8192u/r819xU_phy.h    | 10 +++---
 4 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.c b/drivers/staging/rtl8192u/r8190_rtl8256.c
index 9f35dcb9e13e..9b7f822e9762 100644
--- a/drivers/staging/rtl8192u/r8190_rtl8256.c
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.c
@@ -41,16 +41,16 @@ void PHY_SetRF8256Bandwidth(struct net_device *dev, enum ht_channel_width Bandwi
 					|| priv->card_8192_version
 					== VERSION_819xU_B) { /* 8256 D-cut, E-cut, xiong: consider it later! */
 					rtl8192_phy_SetRFReg(dev,
-						(enum RF90_RADIO_PATH_E)eRFPath,
+						(enum rf90_radio_path_e)eRFPath,
 						0x0b, bMask12Bits, 0x100); /* phy para:1ba */
 					rtl8192_phy_SetRFReg(dev,
-						(enum RF90_RADIO_PATH_E)eRFPath,
+						(enum rf90_radio_path_e)eRFPath,
 						0x2c, bMask12Bits, 0x3d7);
 					rtl8192_phy_SetRFReg(dev,
-						(enum RF90_RADIO_PATH_E)eRFPath,
+						(enum rf90_radio_path_e)eRFPath,
 						0x0e, bMask12Bits, 0x021);
 					rtl8192_phy_SetRFReg(dev,
-						(enum RF90_RADIO_PATH_E)eRFPath,
+						(enum rf90_radio_path_e)eRFPath,
 						0x14, bMask12Bits, 0x5ab);
 				} else {
 					RT_TRACE(COMP_ERR, "PHY_SetRF8256Bandwidth(): unknown hardware version\n");
@@ -58,15 +58,15 @@ void PHY_SetRF8256Bandwidth(struct net_device *dev, enum ht_channel_width Bandwi
 				break;
 		case HT_CHANNEL_WIDTH_20_40:
 				if (priv->card_8192_version == VERSION_819xU_A || priv->card_8192_version == VERSION_819xU_B) { /* 8256 D-cut, E-cut, xiong: consider it later! */
-					rtl8192_phy_SetRFReg(dev, (enum RF90_RADIO_PATH_E)eRFPath, 0x0b, bMask12Bits, 0x300); /* phy para:3ba */
-					rtl8192_phy_SetRFReg(dev, (enum RF90_RADIO_PATH_E)eRFPath, 0x2c, bMask12Bits, 0x3df);
-					rtl8192_phy_SetRFReg(dev, (enum RF90_RADIO_PATH_E)eRFPath, 0x0e, bMask12Bits, 0x0a1);
+					rtl8192_phy_SetRFReg(dev, (enum rf90_radio_path_e)eRFPath, 0x0b, bMask12Bits, 0x300); /* phy para:3ba */
+					rtl8192_phy_SetRFReg(dev, (enum rf90_radio_path_e)eRFPath, 0x2c, bMask12Bits, 0x3df);
+					rtl8192_phy_SetRFReg(dev, (enum rf90_radio_path_e)eRFPath, 0x0e, bMask12Bits, 0x0a1);
 
 					if (priv->chan == 3 || priv->chan == 9)
 						/* I need to set priv->chan whenever current channel changes */
-						rtl8192_phy_SetRFReg(dev, (enum RF90_RADIO_PATH_E)eRFPath, 0x14, bMask12Bits, 0x59b);
+						rtl8192_phy_SetRFReg(dev, (enum rf90_radio_path_e)eRFPath, 0x14, bMask12Bits, 0x59b);
 					else
-						rtl8192_phy_SetRFReg(dev, (enum RF90_RADIO_PATH_E)eRFPath, 0x14, bMask12Bits, 0x5ab);
+						rtl8192_phy_SetRFReg(dev, (enum rf90_radio_path_e)eRFPath, 0x14, bMask12Bits, 0x5ab);
 				} else {
 					RT_TRACE(COMP_ERR, "PHY_SetRF8256Bandwidth(): unknown hardware version\n");
 					}
@@ -115,14 +115,14 @@ void phy_RF8256_Config_ParaFile(struct net_device *dev)
 	u8	ConstRetryTimes = 5, RetryTimes = 5;
 	u8 ret = 0;
 	/* Initialize RF */
-	for (eRFPath = (enum RF90_RADIO_PATH_E)RF90_PATH_A; eRFPath < priv->NumTotalRFPath; eRFPath++) {
+	for (eRFPath = (enum rf90_radio_path_e)RF90_PATH_A; eRFPath < priv->NumTotalRFPath; eRFPath++) {
 		if (!rtl8192_phy_CheckIsLegalRFPath(dev, eRFPath))
 			continue;
 
 		pPhyReg = &priv->PHYRegDef[eRFPath];
 
 		/* Joseph test for shorten RF config
-		 * pHalData->RfReg0Value[eRFPath] =  rtl8192_phy_QueryRFReg(dev, (enum RF90_RADIO_PATH_E)eRFPath, rGlobalCtrl, bMaskDWord);
+		 * pHalData->RfReg0Value[eRFPath] =  rtl8192_phy_QueryRFReg(dev, (enum rf90_radio_path_e)eRFPath, rGlobalCtrl, bMaskDWord);
 		 * ----Store original RFENV control type
 		 */
 		switch (eRFPath) {
@@ -146,12 +146,12 @@ void phy_RF8256_Config_ParaFile(struct net_device *dev)
 		rtl8192_setBBreg(dev, pPhyReg->rfHSSIPara2, b3WireAddressLength, 0x0);	/* Set 0 to 4 bits for Z-serial and set 1 to 6 bits for 8258 */
 		rtl8192_setBBreg(dev, pPhyReg->rfHSSIPara2, b3WireDataLength, 0x0);	/* Set 0 to 12 bits for Z-serial and 8258, and set 1 to 14 bits for ??? */
 
-		rtl8192_phy_SetRFReg(dev, (enum RF90_RADIO_PATH_E) eRFPath, 0x0, bMask12Bits, 0xbf);
+		rtl8192_phy_SetRFReg(dev, (enum rf90_radio_path_e) eRFPath, 0x0, bMask12Bits, 0xbf);
 
 		/* Check RF block (for FPGA platform only)----
 		 * TODO: this function should be removed on ASIC , Emily 2007.2.2
 		 */
-		if (rtl8192_phy_checkBBAndRF(dev, HW90_BLOCK_RF, (enum RF90_RADIO_PATH_E)eRFPath)) {
+		if (rtl8192_phy_checkBBAndRF(dev, HW90_BLOCK_RF, (enum rf90_radio_path_e)eRFPath)) {
 			RT_TRACE(COMP_ERR, "PHY_RF8256_Config():Check Radio[%d] Fail!!\n", eRFPath);
 			goto phy_RF8256_Config_ParaFile_Fail;
 		}
@@ -162,32 +162,32 @@ void phy_RF8256_Config_ParaFile(struct net_device *dev)
 		switch (eRFPath) {
 		case RF90_PATH_A:
 			while (RF3_Final_Value != RegValueToBeCheck && RetryTimes != 0) {
-				ret = rtl8192_phy_ConfigRFWithHeaderFile(dev, (enum RF90_RADIO_PATH_E)eRFPath);
-				RF3_Final_Value = rtl8192_phy_QueryRFReg(dev, (enum RF90_RADIO_PATH_E)eRFPath, RegOffSetToBeCheck, bMask12Bits);
+				ret = rtl8192_phy_ConfigRFWithHeaderFile(dev, (enum rf90_radio_path_e)eRFPath);
+				RF3_Final_Value = rtl8192_phy_QueryRFReg(dev, (enum rf90_radio_path_e)eRFPath, RegOffSetToBeCheck, bMask12Bits);
 				RT_TRACE(COMP_RF, "RF %d %d register final value: %x\n", eRFPath, RegOffSetToBeCheck, RF3_Final_Value);
 				RetryTimes--;
 			}
 			break;
 		case RF90_PATH_B:
 			while (RF3_Final_Value != RegValueToBeCheck && RetryTimes != 0) {
-				ret = rtl8192_phy_ConfigRFWithHeaderFile(dev, (enum RF90_RADIO_PATH_E)eRFPath);
-				RF3_Final_Value = rtl8192_phy_QueryRFReg(dev, (enum RF90_RADIO_PATH_E)eRFPath, RegOffSetToBeCheck, bMask12Bits);
+				ret = rtl8192_phy_ConfigRFWithHeaderFile(dev, (enum rf90_radio_path_e)eRFPath);
+				RF3_Final_Value = rtl8192_phy_QueryRFReg(dev, (enum rf90_radio_path_e)eRFPath, RegOffSetToBeCheck, bMask12Bits);
 				RT_TRACE(COMP_RF, "RF %d %d register final value: %x\n", eRFPath, RegOffSetToBeCheck, RF3_Final_Value);
 				RetryTimes--;
 			}
 			break;
 		case RF90_PATH_C:
 			while (RF3_Final_Value != RegValueToBeCheck && RetryTimes != 0) {
-				ret = rtl8192_phy_ConfigRFWithHeaderFile(dev, (enum RF90_RADIO_PATH_E)eRFPath);
-				RF3_Final_Value = rtl8192_phy_QueryRFReg(dev, (enum RF90_RADIO_PATH_E)eRFPath, RegOffSetToBeCheck, bMask12Bits);
+				ret = rtl8192_phy_ConfigRFWithHeaderFile(dev, (enum rf90_radio_path_e)eRFPath);
+				RF3_Final_Value = rtl8192_phy_QueryRFReg(dev, (enum rf90_radio_path_e)eRFPath, RegOffSetToBeCheck, bMask12Bits);
 				RT_TRACE(COMP_RF, "RF %d %d register final value: %x\n", eRFPath, RegOffSetToBeCheck, RF3_Final_Value);
 				RetryTimes--;
 			}
 			break;
 		case RF90_PATH_D:
 			while (RF3_Final_Value != RegValueToBeCheck && RetryTimes != 0) {
-				ret = rtl8192_phy_ConfigRFWithHeaderFile(dev, (enum RF90_RADIO_PATH_E)eRFPath);
-				RF3_Final_Value = rtl8192_phy_QueryRFReg(dev, (enum RF90_RADIO_PATH_E)eRFPath, RegOffSetToBeCheck, bMask12Bits);
+				ret = rtl8192_phy_ConfigRFWithHeaderFile(dev, (enum rf90_radio_path_e)eRFPath);
+				RF3_Final_Value = rtl8192_phy_QueryRFReg(dev, (enum rf90_radio_path_e)eRFPath, RegOffSetToBeCheck, bMask12Bits);
 				RT_TRACE(COMP_RF, "RF %d %d register final value: %x\n", eRFPath, RegOffSetToBeCheck, RF3_Final_Value);
 				RetryTimes--;
 			}
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index c99923d467a7..28592a8d6dd0 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2897,7 +2897,7 @@ static bool rtl8192_adapter_start(struct net_device *dev)
 			 */
 			for (eRFPath = 0; eRFPath < pHalData->NumTotalRFPath; eRFPath++)
 				PHY_SetRFReg(Adapter,
-					     (enum RF90_RADIO_PATH_E)eRFPath,
+					     (enum rf90_radio_path_e)eRFPath,
 					     0x4, 0xC00, 0x0);
 		} else if (pMgntInfo->RfOffReason > RF_CHANGE_BY_PS) {
 			/* H/W or S/W RF OFF before sleep. */
@@ -2923,7 +2923,7 @@ static bool rtl8192_adapter_start(struct net_device *dev)
 			 */
 			for (eRFPath = 0; eRFPath < pHalData->NumTotalRFPath; eRFPath++)
 				PHY_SetRFReg(Adapter,
-					     (enum RF90_RADIO_PATH_E)eRFPath,
+					     (enum rf90_radio_path_e)eRFPath,
 					     0x4, 0xC00, 0x0);
 		}
 	}
diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index c8c54484eab5..fb74b749fbcf 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -101,18 +101,18 @@ u32 rtl8192_QueryBBReg(struct net_device *dev, u32 reg_addr, u32 bitmask)
 }
 
 static u32 phy_FwRFSerialRead(struct net_device *dev,
-			      enum RF90_RADIO_PATH_E eRFPath,
+			      enum rf90_radio_path_e eRFPath,
 			      u32 offset);
 
 static void phy_FwRFSerialWrite(struct net_device *dev,
-				enum RF90_RADIO_PATH_E eRFPath,
+				enum rf90_radio_path_e eRFPath,
 				u32  offset,
 				u32  data);
 
 /******************************************************************************
  * function:  This function reads register from RF chip
  * input:     net_device        *dev
- *            RF90_RADIO_PATH_E eRFPath    //radio path of A/B/C/D
+ *            rf90_radio_path_e eRFPath    //radio path of A/B/C/D
  *            u32               offset     //target address to be read
  * output:    none
  * return:    u32               readback value
@@ -124,7 +124,7 @@ static void phy_FwRFSerialWrite(struct net_device *dev,
  *            ---need more spec for this information.
  ******************************************************************************/
 static u32 rtl8192_phy_RFSerialRead(struct net_device *dev,
-				    enum RF90_RADIO_PATH_E eRFPath, u32 offset)
+				    enum rf90_radio_path_e eRFPath, u32 offset)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	u32 ret = 0;
@@ -191,7 +191,7 @@ static u32 rtl8192_phy_RFSerialRead(struct net_device *dev,
 /******************************************************************************
  * function:  This function writes data to RF register
  * input:     net_device        *dev
- *            RF90_RADIO_PATH_E eRFPath  //radio path of A/B/C/D
+ *            rf90_radio_path_e eRFPath  //radio path of A/B/C/D
  *            u32               offset   //target address to be written
  *            u32               data	 //the new register data to be written
  * output:    none
@@ -209,7 +209,7 @@ static u32 rtl8192_phy_RFSerialRead(struct net_device *dev,
  * ---------------------------------------------------------------------------
  *****************************************************************************/
 static void rtl8192_phy_RFSerialWrite(struct net_device *dev,
-				      enum RF90_RADIO_PATH_E eRFPath,
+				      enum rf90_radio_path_e eRFPath,
 				      u32 offset,
 				      u32 data)
 {
@@ -266,7 +266,7 @@ static void rtl8192_phy_RFSerialWrite(struct net_device *dev,
 /******************************************************************************
  * function:  This function set specific bits to RF register
  * input:     net_device        dev
- *            RF90_RADIO_PATH_E eRFPath  //radio path of A/B/C/D
+ *            rf90_radio_path_e eRFPath  //radio path of A/B/C/D
  *            u32               reg_addr //target addr to be modified
  *            u32               bitmask  //taget bit pos to be modified
  *            u32               data     //value to be written
@@ -275,7 +275,7 @@ static void rtl8192_phy_RFSerialWrite(struct net_device *dev,
  * notice:
  *****************************************************************************/
 void rtl8192_phy_SetRFReg(struct net_device *dev,
-			  enum RF90_RADIO_PATH_E eRFPath,
+			  enum rf90_radio_path_e eRFPath,
 			  u32 reg_addr, u32 bitmask, u32 data)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
@@ -324,7 +324,7 @@ void rtl8192_phy_SetRFReg(struct net_device *dev,
  * notice:
  *****************************************************************************/
 u32 rtl8192_phy_QueryRFReg(struct net_device *dev,
-			   enum RF90_RADIO_PATH_E eRFPath,
+			   enum rf90_radio_path_e eRFPath,
 			   u32 reg_addr, u32 bitmask)
 {
 	u32 reg, bitshift;
@@ -348,14 +348,14 @@ u32 rtl8192_phy_QueryRFReg(struct net_device *dev,
 /******************************************************************************
  * function:  We support firmware to execute RF-R/W.
  * input:     net_device        *dev
- *            RF90_RADIO_PATH_E eRFPath
+ *            rf90_radio_path_e eRFPath
  *            u32               offset
  * output:    none
  * return:    u32
  * notice:
  ****************************************************************************/
 static u32 phy_FwRFSerialRead(struct net_device *dev,
-			      enum RF90_RADIO_PATH_E eRFPath,
+			      enum rf90_radio_path_e eRFPath,
 			      u32 offset)
 {
 	u32		reg = 0;
@@ -412,7 +412,7 @@ static u32 phy_FwRFSerialRead(struct net_device *dev,
 /******************************************************************************
  * function:  We support firmware to execute RF-R/W.
  * input:     net_device        *dev
- *            RF90_RADIO_PATH_E eRFPath
+ *            rf90_radio_path_e eRFPath
  *            u32               offset
  *            u32               data
  * output:    none
@@ -420,7 +420,7 @@ static u32 phy_FwRFSerialRead(struct net_device *dev,
  * notice:
  ****************************************************************************/
 static void phy_FwRFSerialWrite(struct net_device *dev,
-				enum RF90_RADIO_PATH_E eRFPath,
+				enum rf90_radio_path_e eRFPath,
 				u32 offset, u32 data)
 {
 	u8	time = 0;
@@ -688,14 +688,14 @@ static void rtl8192_InitBBRFRegDef(struct net_device *dev)
  *            sure whether BB and RF is OK
  * input:     net_device        *dev
  *            hw90_block_e      CheckBlock
- *            RF90_RADIO_PATH_E eRFPath  //only used when checkblock is
+ *            rf90_radio_path_e eRFPath  //only used when checkblock is
  *                                       //HW90_BLOCK_RF
  * output:    none
  * return:    return whether BB and RF is ok (0:OK, 1:Fail)
  * notice:    This function may be removed in the ASIC
  ******************************************************************************/
 u8 rtl8192_phy_checkBBAndRF(struct net_device *dev, enum hw90_block_e CheckBlock,
-			    enum RF90_RADIO_PATH_E eRFPath)
+			    enum rf90_radio_path_e eRFPath)
 {
 	u8 ret = 0;
 	u32 i, CheckTimes = 4, reg = 0;
@@ -790,7 +790,7 @@ static void rtl8192_BB_Config_ParaFile(struct net_device *dev)
 	     eCheckItem <= HW90_BLOCK_PHY1; eCheckItem++) {
 		/* don't care RF path */
 		status = rtl8192_phy_checkBBAndRF(dev, (enum hw90_block_e)eCheckItem,
-						  (enum RF90_RADIO_PATH_E)0);
+						  (enum rf90_radio_path_e)0);
 		if (status != 0) {
 			RT_TRACE((COMP_ERR | COMP_PHY),
 				 "PHY_RF8256_Config(): Check PHY%d Fail!!\n",
@@ -962,13 +962,13 @@ void rtl8192_phy_updateInitGain(struct net_device *dev)
  * function:  This function read RF parameters from general head file,
  *            and do RF 3-wire
  * input:     net_device	*dev
- *            RF90_RADIO_PATH_E eRFPath
+ *            rf90_radio_path_e eRFPath
  * output:    none
  * return:    return code show if RF configuration is successful(0:pass, 1:fail)
  * notice:    Delay may be required for RF configuration
  *****************************************************************************/
 u8 rtl8192_phy_ConfigRFWithHeaderFile(struct net_device *dev,
-				      enum RF90_RADIO_PATH_E	eRFPath)
+				      enum rf90_radio_path_e	eRFPath)
 {
 
 	int i;
@@ -1386,7 +1386,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 		case CMD_ID_RF_WRITE_REG:
 			for (eRFPath = 0; eRFPath < RF90_PATH_MAX; eRFPath++) {
 				rtl8192_phy_SetRFReg(dev,
-						     (enum RF90_RADIO_PATH_E)eRFPath,
+						     (enum rf90_radio_path_e)eRFPath,
 						     CurrentCmd->para_1,
 						     bZebra1_ChannelNum,
 						     CurrentCmd->para_2);
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index d9503996457d..1ad459cf05ae 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -33,7 +33,7 @@ enum hw90_block_e {
 	HW90_BLOCK_MAXIMUM = 4, /* Never use this */
 };
 
-enum RF90_RADIO_PATH_E {
+enum rf90_radio_path_e {
 	RF90_PATH_A = 0,			/* Radio Path A */
 	RF90_PATH_B = 1,			/* Radio Path B */
 	RF90_PATH_C = 2,			/* Radio Path C */
@@ -54,23 +54,23 @@ void rtl8192_setBBreg(struct net_device *dev, u32 reg_addr,
 		      u32 bitmask, u32 data);
 u32 rtl8192_QueryBBReg(struct net_device *dev, u32 reg_addr, u32 bitmask);
 void rtl8192_phy_SetRFReg(struct net_device *dev,
-			  enum RF90_RADIO_PATH_E eRFPath,
+			  enum rf90_radio_path_e eRFPath,
 			  u32 reg_addr, u32 bitmask, u32 data);
 u32 rtl8192_phy_QueryRFReg(struct net_device *dev,
-			   enum RF90_RADIO_PATH_E eRFPath,
+			   enum rf90_radio_path_e eRFPath,
 			   u32 reg_addr, u32 bitmask);
 void rtl8192_phy_configmac(struct net_device *dev);
 void rtl8192_phyConfigBB(struct net_device *dev, u8 ConfigType);
 u8 rtl8192_phy_checkBBAndRF(struct net_device *dev,
 			    enum hw90_block_e CheckBlock,
-			    enum RF90_RADIO_PATH_E eRFPath);
+			    enum rf90_radio_path_e eRFPath);
 void rtl8192_BBConfig(struct net_device *dev);
 void rtl8192_phy_getTxPower(struct net_device *dev);
 void rtl8192_phy_setTxPower(struct net_device *dev, u8 channel);
 void rtl8192_phy_RFConfig(struct net_device *dev);
 void rtl8192_phy_updateInitGain(struct net_device *dev);
 u8 rtl8192_phy_ConfigRFWithHeaderFile(struct net_device *dev,
-				      enum RF90_RADIO_PATH_E eRFPath);
+				      enum rf90_radio_path_e eRFPath);
 
 u8 rtl8192_phy_SwChnl(struct net_device *dev, u8 channel);
 void rtl8192_SetBWMode(struct net_device *dev,
-- 
2.18.0

