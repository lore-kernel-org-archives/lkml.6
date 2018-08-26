Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FEDC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BEED2172A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aC1toV+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BEED2172A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeH0C35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 22:29:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35225 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeH0C35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 22:29:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so2513657edq.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 15:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pun/4tr1105TkVGALARew0+lhhY01+nz/F0Aju9q72Y=;
        b=aC1toV+Y+AD+ltcrbMGJ7HPSfjt1xdWvEJckxkiz3TBE4nc6F9sjjtKynYhqVfxNgM
         OFA0Mnt5EC8d8BjB6FtGIhVYoRNChORqropMVrRysrsERrQoa4O8gHTaZXmFpB9W1TkR
         sgJ33nO8ogZe59aTVWt51XhAmrN/Dfwe+6WUbq46K7uxlFW3wF1GdkcpvQjcDhH1AHMi
         MuMmpwFaI4k9hsXG8DBQE74Q6p02CRSNuHcMMAniKL8ii1HswLbJxnLAEvHWZhv4Di6c
         ctDjxCzG3NvrSlSZc1NphgprrwNqjnLDefCK07S5jKxnWZDPXEafJeI/t61WvCdCk70Q
         vOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pun/4tr1105TkVGALARew0+lhhY01+nz/F0Aju9q72Y=;
        b=Nid/9FB9/ps0GQP5LC0maNkCaY+u5iyLB5chMzytZ0mRQSOYnFhvVrfQswj6XbQYQz
         90dWxTmUgYQ2LjxbGOyMaMmKpXxrORmta6xNi6XN4GaiTU4+tXE6YK5jl8D7mltG4RPO
         9bI4p8O+TCvyq7vQijE8oprd4/K/1jQE+KnguGQXmBaR3zj7Z8FB4GCcFpixfFjuL3Yc
         3J3vcHv2hOgzyIcCmjSutwKt5+dA0qvIJnAzsTYySZwHrkj8A7IAwOi1SgWI/lHdXWiO
         pNOxWAwyBKte+8Pb9qADkRX/JBd0Qy0ozl1H1yZ/RVEdTjt7NBA6FZaKivrGG3+gZ8jg
         CB+A==
X-Gm-Message-State: APzg51CfUv3hBSWz+GPEJOPDxTD5reRSw7bBVnvseDDH5gpxh7e1+vlQ
        VItClgnv/CiGCqH84KjEhedGjxBI
X-Google-Smtp-Source: ANB0VdYcWVuwkqrL00D+eIxIIvBExIjbl7RJscEPPDtzKVguX7Rdz/LOVzA79GeXOzEpl70CY4zYdQ==
X-Received: by 2002:a50:de03:: with SMTP id z3-v6mr13989766edk.245.1535323557965;
        Sun, 26 Aug 2018 15:45:57 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id a33-v6sm5519165eda.2.2018.08.26.15.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 15:45:57 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 2/6] staging:rtl8192u: Rename function PHY_RF8256_Config() - Style
Date:   Sun, 26 Aug 2018 23:45:29 +0100
Message-Id: <20180826224533.16020-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826224533.16020-1-johnfwhitmore@gmail.com>
References: <20180826224533.16020-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the function PHY_RF8256_Config() to phy_rf8256_config(). This
change clears the checkpatch issue with CamelCase naming.

This is a simple coding style change which should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8190_rtl8256.c | 4 ++--
 drivers/staging/rtl8192u/r8190_rtl8256.h | 2 +-
 drivers/staging/rtl8192u/r819xU_phy.c    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.c b/drivers/staging/rtl8192u/r8190_rtl8256.c
index 8916a1069b38..8cc7b0d46a02 100644
--- a/drivers/staging/rtl8192u/r8190_rtl8256.c
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.c
@@ -85,7 +85,7 @@ void phy_set_rf8256_bandwidth(struct net_device *dev, enum ht_channel_width Band
  * Return:      NONE
  *--------------------------------------------------------------------------
  */
-void PHY_RF8256_Config(struct net_device *dev)
+void phy_rf8256_config(struct net_device *dev)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	/* Initialize general global value
@@ -152,7 +152,7 @@ void phy_RF8256_Config_ParaFile(struct net_device *dev)
 		 * TODO: this function should be removed on ASIC , Emily 2007.2.2
 		 */
 		if (rtl8192_phy_checkBBAndRF(dev, HW90_BLOCK_RF, (enum rf90_radio_path_e)eRFPath)) {
-			RT_TRACE(COMP_ERR, "PHY_RF8256_Config():Check Radio[%d] Fail!!\n", eRFPath);
+			RT_TRACE(COMP_ERR, "phy_rf8256_config():Check Radio[%d] Fail!!\n", eRFPath);
 			goto phy_RF8256_Config_ParaFile_Fail;
 		}
 
diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.h b/drivers/staging/rtl8192u/r8190_rtl8256.h
index 25f5c8b72e92..b58aab020e51 100644
--- a/drivers/staging/rtl8192u/r8190_rtl8256.h
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.h
@@ -16,7 +16,7 @@
 #define RTL819X_TOTAL_RF_PATH 2 /* for 8192U */
 void phy_set_rf8256_bandwidth(struct net_device *dev,
 			      enum ht_channel_width bandwidth);
-void PHY_RF8256_Config(struct net_device *dev);
+void phy_rf8256_config(struct net_device *dev);
 void phy_RF8256_Config_ParaFile(struct net_device *dev);
 void PHY_SetRF8256CCKTxPower(struct net_device *dev, u8	powerlevel);
 void PHY_SetRF8256OFDMTxPower(struct net_device *dev, u8 powerlevel);
diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 77ded1efc3a3..4ecd12923b93 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -793,7 +793,7 @@ static void rtl8192_BB_Config_ParaFile(struct net_device *dev)
 						  (enum rf90_radio_path_e)0);
 		if (status != 0) {
 			RT_TRACE((COMP_ERR | COMP_PHY),
-				 "PHY_RF8256_Config(): Check PHY%d Fail!!\n",
+				 "phy_rf8256_config(): Check PHY%d Fail!!\n",
 				 eCheckItem-1);
 			return;
 		}
@@ -940,7 +940,7 @@ void rtl8192_phy_RFConfig(struct net_device *dev)
 
 	switch (priv->rf_chip) {
 	case RF_8256:
-		PHY_RF8256_Config(dev);
+		phy_rf8256_config(dev);
 		break;
 	default:
 		RT_TRACE(COMP_ERR, "error chip id\n");
-- 
2.18.0

