Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32686ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E062720873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWYHNRAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E062720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbeGMLiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:38:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40883 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbeGMLiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:38:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id e19-v6so24304010edq.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xP3REqSwbu6ZV2Sa/WPbzu+QjfnnUhXOU5XofI5GDFE=;
        b=oWYHNRALjHOlt4j2iv3dvPweLtVatFQY5qyiX8iQsdkPhEUDpt5olrkkM/NpSfwRQJ
         XO31kTND48EMNQdwoF3YzouM+s1USlFcSjYEvjUv6iH424PEkizVIz5HDWKyrlJvwE7H
         5CquwZnEsKF6pCHg4obdBqbt+K18uBMseSOXuBGz9Z+64FnSyocXz6r7fncprQp7cwUJ
         tVUbHyApUj7x+C2SUMVKnlLT1RJ7H4ZvM7RfXYCzqrefe7Q4PRADxBntDRMiyiAsxXez
         g+T755Op076zHwKapkebU4+cQNznfGf0vNQ1i9vEx2giTT7FGuo1LCO9SGauztbsfIhh
         +RCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xP3REqSwbu6ZV2Sa/WPbzu+QjfnnUhXOU5XofI5GDFE=;
        b=lQpddM2tltCFMAYzgomSWz0WdtP5U+vbc3e+cim+jbVZqNZnHrhQ5dbn0ZHBRGxhYm
         yGdUcVIpRHFf6V74PVWQj3JcvNEbsg5WkDR/BRNkEjghGvJ9H9D925S3DVjxkarWxVBB
         Wn0DFiVU1ZlPcueH/+CA2JcR0ay+oYX9Y5gQDHHLpGaJSLthTvdAe9f5CoDaF0I5BY39
         Kod7wBVQFDkt2CG6t6QFuzNBP+7P3OnhSuES/TAz/QW4nFj7r2B/MUj0Y5p9nmO/4OoV
         odslFJ36Ejg827IShyPChY7V8H2DqUg/1DUTyTHOJfGItSFYQfhxR9b/yAMCufyoZfe4
         TYGQ==
X-Gm-Message-State: AOUpUlH5/k9fRTe13i6M1B6gRp2iK1/zG7rpXtvbl4zlXy02443mR2qH
        z5/Js36ww/If/SYJkP1LLMybf7T+
X-Google-Smtp-Source: AAOMgpdZEDYu55FDGd/bMf0aJLMnX04dqJqE9Tt3/WUm1VqD4WXWtydP7xdmujg4MGJFN6Fq1XtL/g==
X-Received: by 2002:a50:b6e3:: with SMTP id f32-v6mr6757293ede.147.1531481024052;
        Fri, 13 Jul 2018 04:23:44 -0700 (PDT)
Received: from localhost.localdomain ([109.78.208.2])
        by smtp.gmail.com with ESMTPSA id r25-v6sm9392868edb.45.2018.07.13.04.23.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 04:23:42 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/13] staging:rtl8192u: remove typdef from enumeration HW90_BLOCK_E - Style
Date:   Fri, 13 Jul 2018 12:23:00 +0100
Message-Id: <20180713112311.544-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713112311.544-1-johnfwhitmore@gmail.com>
References: <20180713112311.544-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch warns about the creation of new types in code. This patch simply
removes the typedef from the enumeration HW90_BLOCK_E to clear this
warning. There should be no impact on run time code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 6 +++---
 drivers/staging/rtl8192u/r819xU_phy.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index bc86e6bfb8f5..0462de662eff 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -695,7 +695,7 @@ static void rtl8192_InitBBRFRegDef(struct net_device *dev)
  * return:    return whether BB and RF is ok (0:OK, 1:Fail)
  * notice:    This function may be removed in the ASIC
  ******************************************************************************/
-u8 rtl8192_phy_checkBBAndRF(struct net_device *dev, HW90_BLOCK_E CheckBlock,
+u8 rtl8192_phy_checkBBAndRF(struct net_device *dev, enum HW90_BLOCK_E CheckBlock,
 			    RF90_RADIO_PATH_E eRFPath)
 {
 	u8 ret = 0;
@@ -787,10 +787,10 @@ static void rtl8192_BB_Config_ParaFile(struct net_device *dev)
 
 	/* ----Ckeck FPGAPHY0 and PHY1 board is OK---- */
 	/* TODO: this function should be removed on ASIC */
-	for (eCheckItem = (HW90_BLOCK_E)HW90_BLOCK_PHY0;
+	for (eCheckItem = (enum HW90_BLOCK_E)HW90_BLOCK_PHY0;
 	     eCheckItem <= HW90_BLOCK_PHY1; eCheckItem++) {
 		/* don't care RF path */
-		status = rtl8192_phy_checkBBAndRF(dev, (HW90_BLOCK_E)eCheckItem,
+		status = rtl8192_phy_checkBBAndRF(dev, (enum HW90_BLOCK_E)eCheckItem,
 						  (RF90_RADIO_PATH_E)0);
 		if (status != 0) {
 			RT_TRACE((COMP_ERR | COMP_PHY),
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 4471a0e00936..0f680a04a468 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -34,13 +34,13 @@ extern u32 rtl819XRadioB_Array[];
 extern u32 rtl819XRadioC_Array[];
 extern u32 rtl819XRadioD_Array[];
 
-typedef enum _HW90_BLOCK {
+enum HW90_BLOCK_E {
 	HW90_BLOCK_MAC = 0,
 	HW90_BLOCK_PHY0 = 1,
 	HW90_BLOCK_PHY1 = 2,
 	HW90_BLOCK_RF = 3,
 	HW90_BLOCK_MAXIMUM = 4, /* Never use this */
-} HW90_BLOCK_E, *PHW90_BLOCK_E;
+};
 
 typedef enum _RF90_RADIO_PATH {
 	RF90_PATH_A = 0,			/* Radio Path A */
@@ -69,7 +69,7 @@ u32 rtl8192_phy_QueryRFReg(struct net_device *dev, RF90_RADIO_PATH_E eRFPath,
 void rtl8192_phy_configmac(struct net_device *dev);
 void rtl8192_phyConfigBB(struct net_device *dev, u8 ConfigType);
 u8 rtl8192_phy_checkBBAndRF(struct net_device *dev,
-			    HW90_BLOCK_E CheckBlock, RF90_RADIO_PATH_E eRFPath);
+			    enum HW90_BLOCK_E CheckBlock, RF90_RADIO_PATH_E eRFPath);
 void rtl8192_BBConfig(struct net_device *dev);
 void rtl8192_phy_getTxPower(struct net_device *dev);
 void rtl8192_phy_setTxPower(struct net_device *dev, u8 channel);
-- 
2.18.0

