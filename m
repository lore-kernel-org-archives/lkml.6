Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E24ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEFD20671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlzsijKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBEFD20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbeGZUn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:43:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33139 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731706AbeGZUn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:43:29 -0400
Received: by mail-ed1-f68.google.com with SMTP id x5-v6so2262817edr.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6VtpsT53rtc/yTVtKwOA8JG9W6fBpk+JEC05+9TjNoI=;
        b=MlzsijKbqvQOfIYpVCeRCJBGO/29u/lZIp8ciLDNYrfQ0suqeZHH6qn6PDeyZc2gA5
         YBwJEzV2euz4bY3lp3nLRwdmpVNumo2mDxed1UmKAFWegkske3OzhcQySY3iWzR65e0j
         nU0/q22/Z4vhU/DezOYycai8Ol4P0uud+l07vxq+Jkxy1fb1TnAr2KQJGJ1giU0Y3Axl
         XmAhFjBM0hh14tTDHAt9S+GKtuqTI4TFK5nb5MlTlpu0Yg9SiBWThu5/UV1Mx8AGYPtJ
         gorxOcfA8+Fid5fyIydfx9fsuI+uJy1E/mpsKliALiFVkjdz0t2oWVzo8gji6MFMUCMo
         DpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6VtpsT53rtc/yTVtKwOA8JG9W6fBpk+JEC05+9TjNoI=;
        b=eOzvP0k8X6vyUWW03ALwXrJlp8Av8MRYYsf2FDTyQGY1TKsuIDrw834wmV/x7fe3Lg
         vw5JqX6MkBwEdW+fY5JlDNC/84ugc+y0L2koLqs64i1Rn8kn45CutkAVOmjwE+/plOFG
         kuLr0msCmS53Rjp8j6GsjxtNs1/u9DjKFA6VKmxalB8tXmCBtM0O70g2Z3nOi1fZWE1e
         LY0RCUMPVCHydrItA8wIBAO5dX1vzR2wu4wNh/tiHMR2b9vkuUwyNf83TliUvTuBoAEz
         aSYCusgEoKHXXegBkSewEFVqnsxgc6I2mtfeQPstEnatg+wIAwg/cww+NKEjGEV6+7Se
         hwgQ==
X-Gm-Message-State: AOUpUlGThyAJTOZB8whupI4tYVR21KAY6dUFu0D71z4x8mNBnmpeCHIz
        5nNWOYLygTiNMjuypQqcaGIEJeTb
X-Google-Smtp-Source: AAOMgpcjQzehOJCyiiWWtqmtDS+ihw7zU/0Ijw/SSs1Qoiqnn2xd9OjMhHj8E6xA+Drp0yWMw+5UpQ==
X-Received: by 2002:a50:d2d7:: with SMTP id q23-v6mr4128035edg.183.1532633111942;
        Thu, 26 Jul 2018 12:25:11 -0700 (PDT)
Received: from localhost.localdomain ([109.76.149.40])
        by smtp.gmail.com with ESMTPSA id m20-v6sm1100853eds.5.2018.07.26.12.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:25:11 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 16/16] staging:rtl8192u: Rename eRFPath - Style
Date:   Thu, 26 Jul 2018 20:24:26 +0100
Message-Id: <20180726192426.31913-17-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726192426.31913-1-johnfwhitmore@gmail.com>
References: <20180726192426.31913-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the variable eRFPath to e_rfpath. This change resolves a
checkpatch issue with CamelCase naming. The variable name is used both
as a parameter name in function definitions, function prototypes and as
a local variable.

This change is purely a coding style change which should have no impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 120 +++++++++++++-------------
 drivers/staging/rtl8192u/r819xU_phy.h |  10 +--
 2 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index fb74b749fbcf..7ee10d49894b 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -34,11 +34,11 @@ static u32 RF_CHANNEL_TABLE_ZEBRA[] = {
  * function:  This function checks different RF type to execute legal judgement.
  *            If RF Path is illegal, we will return false.
  * input:     net_device	 *dev
- *            u32		 eRFPath
+ *            u32		 e_rfpath
  * output:    none
  * return:    0(illegal, false), 1(legal, true)
  *****************************************************************************/
-u8 rtl8192_phy_CheckIsLegalRFPath(struct net_device *dev, u32 eRFPath)
+u8 rtl8192_phy_CheckIsLegalRFPath(struct net_device *dev, u32 e_rfpath)
 {
 	u8 ret = 1;
 	struct r8192_priv *priv = ieee80211_priv(dev);
@@ -46,9 +46,9 @@ u8 rtl8192_phy_CheckIsLegalRFPath(struct net_device *dev, u32 eRFPath)
 	if (priv->rf_type == RF_2T4R) {
 		ret = 0;
 	} else if (priv->rf_type == RF_1T2R) {
-		if (eRFPath == RF90_PATH_A || eRFPath == RF90_PATH_B)
+		if (e_rfpath == RF90_PATH_A || e_rfpath == RF90_PATH_B)
 			ret = 1;
-		else if (eRFPath == RF90_PATH_C || eRFPath == RF90_PATH_D)
+		else if (e_rfpath == RF90_PATH_C || e_rfpath == RF90_PATH_D)
 			ret = 0;
 	}
 	return ret;
@@ -101,18 +101,18 @@ u32 rtl8192_QueryBBReg(struct net_device *dev, u32 reg_addr, u32 bitmask)
 }
 
 static u32 phy_FwRFSerialRead(struct net_device *dev,
-			      enum rf90_radio_path_e eRFPath,
+			      enum rf90_radio_path_e e_rfpath,
 			      u32 offset);
 
 static void phy_FwRFSerialWrite(struct net_device *dev,
-				enum rf90_radio_path_e eRFPath,
+				enum rf90_radio_path_e e_rfpath,
 				u32  offset,
 				u32  data);
 
 /******************************************************************************
  * function:  This function reads register from RF chip
  * input:     net_device        *dev
- *            rf90_radio_path_e eRFPath    //radio path of A/B/C/D
+ *            rf90_radio_path_e e_rfpath    //radio path of A/B/C/D
  *            u32               offset     //target address to be read
  * output:    none
  * return:    u32               readback value
@@ -124,12 +124,12 @@ static void phy_FwRFSerialWrite(struct net_device *dev,
  *            ---need more spec for this information.
  ******************************************************************************/
 static u32 rtl8192_phy_RFSerialRead(struct net_device *dev,
-				    enum rf90_radio_path_e eRFPath, u32 offset)
+				    enum rf90_radio_path_e e_rfpath, u32 offset)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	u32 ret = 0;
 	u32 new_offset = 0;
-	BB_REGISTER_DEFINITION_T *pPhyReg = &priv->PHYRegDef[eRFPath];
+	BB_REGISTER_DEFINITION_T *pPhyReg = &priv->PHYRegDef[e_rfpath];
 
 	rtl8192_setBBreg(dev, pPhyReg->rfLSSIReadBack, bLSSIReadBackData, 0);
 	/* Make sure RF register offset is correct */
@@ -138,20 +138,20 @@ static u32 rtl8192_phy_RFSerialRead(struct net_device *dev,
 	/* Switch page for 8256 RF IC */
 	if (priv->rf_chip == RF_8256) {
 		if (offset >= 31) {
-			priv->RfReg0Value[eRFPath] |= 0x140;
+			priv->RfReg0Value[e_rfpath] |= 0x140;
 			/* Switch to Reg_Mode2 for Reg 31-45 */
 			rtl8192_setBBreg(dev, pPhyReg->rf3wireOffset,
 					 bMaskDWord,
-					 priv->RfReg0Value[eRFPath]<<16);
+					 priv->RfReg0Value[e_rfpath]<<16);
 			/* Modify offset */
 			new_offset = offset - 30;
 		} else if (offset >= 16) {
-			priv->RfReg0Value[eRFPath] |= 0x100;
-			priv->RfReg0Value[eRFPath] &= (~0x40);
+			priv->RfReg0Value[e_rfpath] |= 0x100;
+			priv->RfReg0Value[e_rfpath] &= (~0x40);
 			/* Switch to Reg_Mode1 for Reg16-30 */
 			rtl8192_setBBreg(dev, pPhyReg->rf3wireOffset,
 					 bMaskDWord,
-					 priv->RfReg0Value[eRFPath]<<16);
+					 priv->RfReg0Value[e_rfpath]<<16);
 
 			new_offset = offset - 15;
 		} else {
@@ -179,10 +179,10 @@ static u32 rtl8192_phy_RFSerialRead(struct net_device *dev,
 
 	/* Switch back to Reg_Mode0 */
 	if (priv->rf_chip == RF_8256) {
-		priv->RfReg0Value[eRFPath] &= 0xebf;
+		priv->RfReg0Value[e_rfpath] &= 0xebf;
 
 		rtl8192_setBBreg(dev, pPhyReg->rf3wireOffset, bMaskDWord,
-				 priv->RfReg0Value[eRFPath] << 16);
+				 priv->RfReg0Value[e_rfpath] << 16);
 	}
 
 	return ret;
@@ -191,7 +191,7 @@ static u32 rtl8192_phy_RFSerialRead(struct net_device *dev,
 /******************************************************************************
  * function:  This function writes data to RF register
  * input:     net_device        *dev
- *            rf90_radio_path_e eRFPath  //radio path of A/B/C/D
+ *            rf90_radio_path_e e_rfpath  //radio path of A/B/C/D
  *            u32               offset   //target address to be written
  *            u32               data	 //the new register data to be written
  * output:    none
@@ -209,29 +209,29 @@ static u32 rtl8192_phy_RFSerialRead(struct net_device *dev,
  * ---------------------------------------------------------------------------
  *****************************************************************************/
 static void rtl8192_phy_RFSerialWrite(struct net_device *dev,
-				      enum rf90_radio_path_e eRFPath,
+				      enum rf90_radio_path_e e_rfpath,
 				      u32 offset,
 				      u32 data)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	u32 DataAndAddr = 0, new_offset = 0;
-	BB_REGISTER_DEFINITION_T	*pPhyReg = &priv->PHYRegDef[eRFPath];
+	BB_REGISTER_DEFINITION_T	*pPhyReg = &priv->PHYRegDef[e_rfpath];
 
 	offset &= 0x3f;
 	if (priv->rf_chip == RF_8256) {
 
 		if (offset >= 31) {
-			priv->RfReg0Value[eRFPath] |= 0x140;
+			priv->RfReg0Value[e_rfpath] |= 0x140;
 			rtl8192_setBBreg(dev, pPhyReg->rf3wireOffset,
 					 bMaskDWord,
-					 priv->RfReg0Value[eRFPath] << 16);
+					 priv->RfReg0Value[e_rfpath] << 16);
 			new_offset = offset - 30;
 		} else if (offset >= 16) {
-			priv->RfReg0Value[eRFPath] |= 0x100;
-			priv->RfReg0Value[eRFPath] &= (~0x40);
+			priv->RfReg0Value[e_rfpath] |= 0x100;
+			priv->RfReg0Value[e_rfpath] &= (~0x40);
 			rtl8192_setBBreg(dev, pPhyReg->rf3wireOffset,
 					 bMaskDWord,
-					 priv->RfReg0Value[eRFPath]<<16);
+					 priv->RfReg0Value[e_rfpath]<<16);
 			new_offset = offset - 15;
 		} else {
 			new_offset = offset;
@@ -250,15 +250,15 @@ static void rtl8192_phy_RFSerialWrite(struct net_device *dev,
 
 
 	if (offset == 0x0)
-		priv->RfReg0Value[eRFPath] = data;
+		priv->RfReg0Value[e_rfpath] = data;
 
 	/* Switch back to Reg_Mode0 */
 	if (priv->rf_chip == RF_8256) {
 		if (offset != 0) {
-			priv->RfReg0Value[eRFPath] &= 0xebf;
+			priv->RfReg0Value[e_rfpath] &= 0xebf;
 			rtl8192_setBBreg(dev, pPhyReg->rf3wireOffset,
 					 bMaskDWord,
-					 priv->RfReg0Value[eRFPath] << 16);
+					 priv->RfReg0Value[e_rfpath] << 16);
 		}
 	}
 }
@@ -266,7 +266,7 @@ static void rtl8192_phy_RFSerialWrite(struct net_device *dev,
 /******************************************************************************
  * function:  This function set specific bits to RF register
  * input:     net_device        dev
- *            rf90_radio_path_e eRFPath  //radio path of A/B/C/D
+ *            rf90_radio_path_e e_rfpath  //radio path of A/B/C/D
  *            u32               reg_addr //target addr to be modified
  *            u32               bitmask  //taget bit pos to be modified
  *            u32               data     //value to be written
@@ -275,26 +275,26 @@ static void rtl8192_phy_RFSerialWrite(struct net_device *dev,
  * notice:
  *****************************************************************************/
 void rtl8192_phy_SetRFReg(struct net_device *dev,
-			  enum rf90_radio_path_e eRFPath,
+			  enum rf90_radio_path_e e_rfpath,
 			  u32 reg_addr, u32 bitmask, u32 data)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	u32 reg, bitshift;
 
-	if (!rtl8192_phy_CheckIsLegalRFPath(dev, eRFPath))
+	if (!rtl8192_phy_CheckIsLegalRFPath(dev, e_rfpath))
 		return;
 
 	if (priv->Rf_Mode == RF_OP_By_FW) {
 		if (bitmask != bMask12Bits) {
 			/* RF data is 12 bits only */
-			reg = phy_FwRFSerialRead(dev, eRFPath, reg_addr);
+			reg = phy_FwRFSerialRead(dev, e_rfpath, reg_addr);
 			bitshift =  ffs(bitmask) - 1;
 			reg &= ~bitmask;
 			reg |= data << bitshift;
 
-			phy_FwRFSerialWrite(dev, eRFPath, reg_addr, reg);
+			phy_FwRFSerialWrite(dev, e_rfpath, reg_addr, reg);
 		} else {
-			phy_FwRFSerialWrite(dev, eRFPath, reg_addr, data);
+			phy_FwRFSerialWrite(dev, e_rfpath, reg_addr, data);
 		}
 
 		udelay(200);
@@ -302,14 +302,14 @@ void rtl8192_phy_SetRFReg(struct net_device *dev,
 	} else {
 		if (bitmask != bMask12Bits) {
 			/* RF data is 12 bits only */
-			reg = rtl8192_phy_RFSerialRead(dev, eRFPath, reg_addr);
+			reg = rtl8192_phy_RFSerialRead(dev, e_rfpath, reg_addr);
 			bitshift =  ffs(bitmask) - 1;
 			reg &= ~bitmask;
 			reg |= data << bitshift;
 
-			rtl8192_phy_RFSerialWrite(dev, eRFPath, reg_addr, reg);
+			rtl8192_phy_RFSerialWrite(dev, e_rfpath, reg_addr, reg);
 		} else {
-			rtl8192_phy_RFSerialWrite(dev, eRFPath, reg_addr, data);
+			rtl8192_phy_RFSerialWrite(dev, e_rfpath, reg_addr, data);
 		}
 	}
 }
@@ -324,20 +324,20 @@ void rtl8192_phy_SetRFReg(struct net_device *dev,
  * notice:
  *****************************************************************************/
 u32 rtl8192_phy_QueryRFReg(struct net_device *dev,
-			   enum rf90_radio_path_e eRFPath,
+			   enum rf90_radio_path_e e_rfpath,
 			   u32 reg_addr, u32 bitmask)
 {
 	u32 reg, bitshift;
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
 
-	if (!rtl8192_phy_CheckIsLegalRFPath(dev, eRFPath))
+	if (!rtl8192_phy_CheckIsLegalRFPath(dev, e_rfpath))
 		return 0;
 	if (priv->Rf_Mode == RF_OP_By_FW) {
-		reg = phy_FwRFSerialRead(dev, eRFPath, reg_addr);
+		reg = phy_FwRFSerialRead(dev, e_rfpath, reg_addr);
 		udelay(200);
 	} else {
-		reg = rtl8192_phy_RFSerialRead(dev, eRFPath, reg_addr);
+		reg = rtl8192_phy_RFSerialRead(dev, e_rfpath, reg_addr);
 	}
 	bitshift =  ffs(bitmask) - 1;
 	reg = (reg & bitmask) >> bitshift;
@@ -348,14 +348,14 @@ u32 rtl8192_phy_QueryRFReg(struct net_device *dev,
 /******************************************************************************
  * function:  We support firmware to execute RF-R/W.
  * input:     net_device        *dev
- *            rf90_radio_path_e eRFPath
+ *            rf90_radio_path_e e_rfpath
  *            u32               offset
  * output:    none
  * return:    u32
  * notice:
  ****************************************************************************/
 static u32 phy_FwRFSerialRead(struct net_device *dev,
-			      enum rf90_radio_path_e eRFPath,
+			      enum rf90_radio_path_e e_rfpath,
 			      u32 offset)
 {
 	u32		reg = 0;
@@ -372,7 +372,7 @@ static u32 phy_FwRFSerialRead(struct net_device *dev,
 	/* 2. Write RF register address. bit 12-19 */
 	data |= ((offset&0xFF)<<12);
 	/* 3. Write RF path.  bit 20-21 */
-	data |= ((eRFPath&0x3)<<20);
+	data |= ((e_rfpath&0x3)<<20);
 	/* 4. Set RF read indicator. bit 22=0 */
 	/* 5. Trigger Fw to operate the command. bit 31 */
 	data |= 0x80000000;
@@ -412,7 +412,7 @@ static u32 phy_FwRFSerialRead(struct net_device *dev,
 /******************************************************************************
  * function:  We support firmware to execute RF-R/W.
  * input:     net_device        *dev
- *            rf90_radio_path_e eRFPath
+ *            rf90_radio_path_e e_rfpath
  *            u32               offset
  *            u32               data
  * output:    none
@@ -420,7 +420,7 @@ static u32 phy_FwRFSerialRead(struct net_device *dev,
  * notice:
  ****************************************************************************/
 static void phy_FwRFSerialWrite(struct net_device *dev,
-				enum rf90_radio_path_e eRFPath,
+				enum rf90_radio_path_e e_rfpath,
 				u32 offset, u32 data)
 {
 	u8	time = 0;
@@ -436,7 +436,7 @@ static void phy_FwRFSerialWrite(struct net_device *dev,
 	/* 2. Write RF register address. bit 12-19 */
 	data |= ((offset&0xFF)<<12);
 	/* 3. Write RF path.  bit 20-21 */
-	data |= ((eRFPath&0x3)<<20);
+	data |= ((e_rfpath&0x3)<<20);
 	/* 4. Set RF write indicator. bit 22=1 */
 	data |= 0x400000;
 	/* 5. Trigger Fw to operate the command. bit 31=1 */
@@ -688,14 +688,14 @@ static void rtl8192_InitBBRFRegDef(struct net_device *dev)
  *            sure whether BB and RF is OK
  * input:     net_device        *dev
  *            hw90_block_e      CheckBlock
- *            rf90_radio_path_e eRFPath  //only used when checkblock is
+ *            rf90_radio_path_e e_rfpath  //only used when checkblock is
  *                                       //HW90_BLOCK_RF
  * output:    none
  * return:    return whether BB and RF is ok (0:OK, 1:Fail)
  * notice:    This function may be removed in the ASIC
  ******************************************************************************/
 u8 rtl8192_phy_checkBBAndRF(struct net_device *dev, enum hw90_block_e CheckBlock,
-			    enum rf90_radio_path_e eRFPath)
+			    enum rf90_radio_path_e e_rfpath)
 {
 	u8 ret = 0;
 	u32 i, CheckTimes = 4, reg = 0;
@@ -726,14 +726,14 @@ u8 rtl8192_phy_checkBBAndRF(struct net_device *dev, enum hw90_block_e CheckBlock
 
 		case HW90_BLOCK_RF:
 			WriteData[i] &= 0xfff;
-			rtl8192_phy_SetRFReg(dev, eRFPath,
+			rtl8192_phy_SetRFReg(dev, e_rfpath,
 					     WriteAddr[HW90_BLOCK_RF],
 					     bMask12Bits, WriteData[i]);
 			/* TODO: we should not delay for such a long time.
 			 * Ask SD3
 			 */
 			usleep_range(1000, 1000);
-			reg = rtl8192_phy_QueryRFReg(dev, eRFPath,
+			reg = rtl8192_phy_QueryRFReg(dev, e_rfpath,
 						     WriteAddr[HW90_BLOCK_RF],
 						     bMask12Bits);
 			usleep_range(1000, 1000);
@@ -962,18 +962,18 @@ void rtl8192_phy_updateInitGain(struct net_device *dev)
  * function:  This function read RF parameters from general head file,
  *            and do RF 3-wire
  * input:     net_device	*dev
- *            rf90_radio_path_e eRFPath
+ *            rf90_radio_path_e e_rfpath
  * output:    none
  * return:    return code show if RF configuration is successful(0:pass, 1:fail)
  * notice:    Delay may be required for RF configuration
  *****************************************************************************/
 u8 rtl8192_phy_ConfigRFWithHeaderFile(struct net_device *dev,
-				      enum rf90_radio_path_e	eRFPath)
+				      enum rf90_radio_path_e	e_rfpath)
 {
 
 	int i;
 
-	switch (eRFPath) {
+	switch (e_rfpath) {
 	case RF90_PATH_A:
 		for (i = 0; i < RadioA_ArrayLength; i = i+2) {
 
@@ -981,7 +981,7 @@ u8 rtl8192_phy_ConfigRFWithHeaderFile(struct net_device *dev,
 				mdelay(100);
 				continue;
 			}
-			rtl8192_phy_SetRFReg(dev, eRFPath,
+			rtl8192_phy_SetRFReg(dev, e_rfpath,
 					     Rtl8192UsbRadioA_Array[i],
 					     bMask12Bits,
 					     Rtl8192UsbRadioA_Array[i+1]);
@@ -996,7 +996,7 @@ u8 rtl8192_phy_ConfigRFWithHeaderFile(struct net_device *dev,
 				mdelay(100);
 				continue;
 			}
-			rtl8192_phy_SetRFReg(dev, eRFPath,
+			rtl8192_phy_SetRFReg(dev, e_rfpath,
 					     Rtl8192UsbRadioB_Array[i],
 					     bMask12Bits,
 					     Rtl8192UsbRadioB_Array[i+1]);
@@ -1011,7 +1011,7 @@ u8 rtl8192_phy_ConfigRFWithHeaderFile(struct net_device *dev,
 				mdelay(100);
 				continue;
 			}
-			rtl8192_phy_SetRFReg(dev, eRFPath,
+			rtl8192_phy_SetRFReg(dev, e_rfpath,
 					     Rtl8192UsbRadioC_Array[i],
 					     bMask12Bits,
 					     Rtl8192UsbRadioC_Array[i+1]);
@@ -1026,7 +1026,7 @@ u8 rtl8192_phy_ConfigRFWithHeaderFile(struct net_device *dev,
 				mdelay(100);
 				continue;
 			}
-			rtl8192_phy_SetRFReg(dev, eRFPath,
+			rtl8192_phy_SetRFReg(dev, e_rfpath,
 					     Rtl8192UsbRadioD_Array[i],
 					     bMask12Bits,
 					     Rtl8192UsbRadioD_Array[i+1]);
@@ -1267,7 +1267,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 	struct sw_chnl_cmd   RfDependCmd[MAX_RFDEPENDCMD_CNT];
 	u32		   RfDependCmdCnt;
 	struct sw_chnl_cmd  *CurrentCmd = NULL;
-	u8		   eRFPath;
+	u8		   e_rfpath;
 
 	RT_TRACE(COMP_CH, "%s() stage: %d, step: %d, channel: %d\n",
 		 __func__, *stage, *step, channel);
@@ -1384,9 +1384,9 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 				       (u8)CurrentCmd->para_2);
 			break;
 		case CMD_ID_RF_WRITE_REG:
-			for (eRFPath = 0; eRFPath < RF90_PATH_MAX; eRFPath++) {
+			for (e_rfpath = 0; e_rfpath < RF90_PATH_MAX; e_rfpath++) {
 				rtl8192_phy_SetRFReg(dev,
-						     (enum rf90_radio_path_e)eRFPath,
+						     (enum rf90_radio_path_e)e_rfpath,
 						     CurrentCmd->para_1,
 						     bZebra1_ChannelNum,
 						     CurrentCmd->para_2);
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 8ca869e8ee2f..c7ec3182857f 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -41,28 +41,28 @@ enum rf90_radio_path_e {
 	RF90_PATH_MAX				/* Max RF number 92 support */
 };
 
-u8 rtl8192_phy_CheckIsLegalRFPath(struct net_device *dev, u32 eRFPath);
+u8 rtl8192_phy_CheckIsLegalRFPath(struct net_device *dev, u32 e_rfpath);
 void rtl8192_setBBreg(struct net_device *dev, u32 reg_addr,
 		      u32 bitmask, u32 data);
 u32 rtl8192_QueryBBReg(struct net_device *dev, u32 reg_addr, u32 bitmask);
 void rtl8192_phy_SetRFReg(struct net_device *dev,
-			  enum rf90_radio_path_e eRFPath,
+			  enum rf90_radio_path_e e_rfpath,
 			  u32 reg_addr, u32 bitmask, u32 data);
 u32 rtl8192_phy_QueryRFReg(struct net_device *dev,
-			   enum rf90_radio_path_e eRFPath,
+			   enum rf90_radio_path_e e_rfpath,
 			   u32 reg_addr, u32 bitmask);
 void rtl8192_phy_configmac(struct net_device *dev);
 void rtl8192_phyConfigBB(struct net_device *dev, u8 ConfigType);
 u8 rtl8192_phy_checkBBAndRF(struct net_device *dev,
 			    enum hw90_block_e CheckBlock,
-			    enum rf90_radio_path_e eRFPath);
+			    enum rf90_radio_path_e e_rfpath);
 void rtl8192_BBConfig(struct net_device *dev);
 void rtl8192_phy_getTxPower(struct net_device *dev);
 void rtl8192_phy_setTxPower(struct net_device *dev, u8 channel);
 void rtl8192_phy_RFConfig(struct net_device *dev);
 void rtl8192_phy_updateInitGain(struct net_device *dev);
 u8 rtl8192_phy_ConfigRFWithHeaderFile(struct net_device *dev,
-				      enum rf90_radio_path_e eRFPath);
+				      enum rf90_radio_path_e e_rfpath);
 
 u8 rtl8192_phy_SwChnl(struct net_device *dev, u8 channel);
 void rtl8192_SetBWMode(struct net_device *dev,
-- 
2.18.0

