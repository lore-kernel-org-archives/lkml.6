Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D218C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038C0223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAjXp5I/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038C0223F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeHJJrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:47:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53687 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeHJJrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:47:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so795724wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 00:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=33p3yG2IFPmurjZ6CYknFZJ4X3RruEdrh2lVtZw4qbQ=;
        b=JAjXp5I/TPln1yvcBcjapmRF05EJCXA0Xg6FVUaSpXLX7zEDQTnQjYt/qlkQnhMeA2
         +U2S+rd+arx9uyu3fRfWiWrT3/U5KNR18jDFvEoRyrt1OoCnWnUAjzsprxGbjiihYric
         rL03S8ckD/dsggU5UXrW5st2WHUM93stKi7oatHHPpDf4tb/a5JOAvV3avr2lXibZOJM
         fATIx2GGP79gDLf5iTtdpq/b9rgDwSo9nJoR4sqdlzGlwtLamCNNVag2koZ3dDZ3MNpc
         gdeijI+70OQQEwZ0v/SlS0MBuOoAjkIDtHRGmeyNWTEca2KK8sgX7WLSSMtLLJE3LT44
         wgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=33p3yG2IFPmurjZ6CYknFZJ4X3RruEdrh2lVtZw4qbQ=;
        b=KwI4g6bJXmP1Tbp3/ADZ/3+LmEjz2s+xhCSOmcc7ICwF9Kva/mw8FHE1q95f05F9bT
         d6mEthWEeb9PfGVjtHqBTrFHqo8Ye52CToNhm2DRu4iS1IekQ2bSgyu4eM+eRe/kaBMf
         F3SfnroNN9umJKNZek44CruKpD/NeJw7a4F2Z4yJ6uWKRGdTzASfPeFp/VwG24KMLh8n
         lZMlmvHKNo+ZjbQ5AOHFm78L3LJWywEq1nILv/zHpW2lfqNXg2po8ydGzwhH07f4wSlj
         cEeEJSkZ7VClwW8QQ0KbpBLeE9fQpmDl8s6Hx8ZyNn97TmL8GlLFMurOWNdiTAQt6L3B
         WRxw==
X-Gm-Message-State: AOUpUlEVkw5Rwapjl2ZypWR4KE1RP7dZfLqviVhrwux0xbgPY8JmXYw8
        uyucwZyvFTGMDIgDI5ss4C8=
X-Google-Smtp-Source: AA+uWPx5DpvgC9vBfZWDuF6INhRceez85ytInylqUJRGQ+Rtrqc2ayt4C/WkHVa7CoCPd8G2uNT5Ig==
X-Received: by 2002:a1c:4c0e:: with SMTP id z14-v6mr742220wmf.89.1533885531039;
        Fri, 10 Aug 2018 00:18:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id k4-v6sm13253875wrl.12.2018.08.10.00.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 00:18:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 5/5] staging: rtl8188eu: use phydm_reg.h from rtlwifi
Date:   Fri, 10 Aug 2018 09:18:33 +0200
Message-Id: <20180810071833.1661-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810071833.1661-1-straube.linux@gmail.com>
References: <20180810071833.1661-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use rtlwifi/phydm/phydm_reg.h instead of odm_reg.h and
remove the now unused odm_reg.h.

All defines from odm_reg.h are defined with the same values
in rtlwifi/phydm/phydm_reg.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/include/odm_precomp.h   |   2 +-
 drivers/staging/rtl8188eu/include/odm_reg.h   | 106 ------------------
 2 files changed, 1 insertion(+), 107 deletions(-)
 delete mode 100644 drivers/staging/rtl8188eu/include/odm_reg.h

diff --git a/drivers/staging/rtl8188eu/include/odm_precomp.h b/drivers/staging/rtl8188eu/include/odm_precomp.h
index 658a938df4c1..0cf7f82b805f 100644
--- a/drivers/staging/rtl8188eu/include/odm_precomp.h
+++ b/drivers/staging/rtl8188eu/include/odm_precomp.h
@@ -29,7 +29,7 @@
 #include "hal8188e_rate_adaptive.h" /* for RA,Power training */
 #include "rtl8188e_hal.h"
 
-#include "odm_reg.h"
+#include "../../rtlwifi/phydm/phydm_reg.h"
 
 #include "odm_rtl8188e.h"
 
diff --git a/drivers/staging/rtl8188eu/include/odm_reg.h b/drivers/staging/rtl8188eu/include/odm_reg.h
deleted file mode 100644
index b56549ba1256..000000000000
--- a/drivers/staging/rtl8188eu/include/odm_reg.h
+++ /dev/null
@@ -1,106 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-/*  */
-/*  File Name: odm_reg.h */
-/*  */
-/*  Description: */
-/*  */
-/*  This file is for general register definition. */
-/*  */
-/*  */
-/*  */
-#ifndef	__HAL_ODM_REG_H__
-#define __HAL_ODM_REG_H__
-
-/*  */
-/*  Register Definition */
-/*  */
-
-/* MAC REG */
-#define	ODM_BB_RESET					0x002
-#define	ODM_DUMMY						0x4fe
-#define	ODM_EDCA_VO_PARAM			0x500
-#define	ODM_EDCA_VI_PARAM			0x504
-#define	ODM_EDCA_BE_PARAM			0x508
-#define	ODM_EDCA_BK_PARAM			0x50C
-#define	ODM_TXPAUSE					0x522
-
-/* BB REG */
-#define	ODM_FPGA_PHY0_PAGE8			0x800
-#define	ODM_PSD_SETTING				0x808
-#define	ODM_AFE_SETTING				0x818
-#define	ODM_TXAGC_B_6_18				0x830
-#define	ODM_TXAGC_B_24_54			0x834
-#define	ODM_TXAGC_B_MCS32_5			0x838
-#define	ODM_TXAGC_B_MCS0_MCS3		0x83c
-#define	ODM_TXAGC_B_MCS4_MCS7		0x848
-#define	ODM_TXAGC_B_MCS8_MCS11		0x84c
-#define	ODM_ANALOG_REGISTER			0x85c
-#define	ODM_RF_INTERFACE_OUTPUT		0x860
-#define	ODM_TXAGC_B_MCS12_MCS15	0x868
-#define	ODM_TXAGC_B_11_A_2_11		0x86c
-#define	ODM_AD_DA_LSB_MASK			0x874
-#define	ODM_ENABLE_3_WIRE			0x88c
-#define	ODM_PSD_REPORT				0x8b4
-#define	ODM_R_ANT_SELECT				0x90c
-#define	ODM_CCK_ANT_SELECT			0xa07
-#define	ODM_CCK_PD_THRESH			0xa0a
-#define	ODM_CCK_RF_REG1				0xa11
-#define	ODM_CCK_MATCH_FILTER			0xa20
-#define	ODM_CCK_RAKE_MAC				0xa2e
-#define	ODM_CCK_CNT_RESET			0xa2d
-#define	ODM_CCK_TX_DIVERSITY			0xa2f
-#define	ODM_CCK_FA_CNT_MSB			0xa5b
-#define	ODM_CCK_FA_CNT_LSB			0xa5c
-#define	ODM_CCK_NEW_FUNCTION		0xa75
-#define	ODM_OFDM_PHY0_PAGE_C		0xc00
-#define	ODM_OFDM_RX_ANT				0xc04
-#define	ODM_R_A_RXIQI					0xc14
-#define	ODM_R_A_AGC_CORE1			0xc50
-#define	ODM_R_A_AGC_CORE2			0xc54
-#define	ODM_R_B_AGC_CORE1			0xc58
-#define	ODM_R_AGC_PAR					0xc70
-#define	ODM_R_HTSTF_AGC_PAR			0xc7c
-#define	ODM_TX_PWR_TRAINING_A		0xc90
-#define	ODM_TX_PWR_TRAINING_B		0xc98
-#define	ODM_OFDM_FA_CNT1				0xcf0
-#define	ODM_OFDM_PHY0_PAGE_D		0xd00
-#define	ODM_OFDM_FA_CNT2				0xda0
-#define	ODM_OFDM_FA_CNT3				0xda4
-#define	ODM_OFDM_FA_CNT4				0xda8
-#define	ODM_TXAGC_A_6_18				0xe00
-#define	ODM_TXAGC_A_24_54			0xe04
-#define	ODM_TXAGC_A_1_MCS32			0xe08
-#define	ODM_TXAGC_A_MCS0_MCS3		0xe10
-#define	ODM_TXAGC_A_MCS4_MCS7		0xe14
-#define	ODM_TXAGC_A_MCS8_MCS11		0xe18
-#define	ODM_TXAGC_A_MCS12_MCS15		0xe1c
-
-/* RF REG */
-#define	ODM_GAIN_SETTING				0x00
-#define	ODM_CHANNEL					0x18
-
-/* Ant Detect Reg */
-#define	ODM_DPDT						0x300
-
-/* PSD Init */
-#define	ODM_PSDREG					0x808
-
-/* 92D Path Div */
-#define	PATHDIV_REG					0xB30
-#define	PATHDIV_TRI					0xBA0
-
-
-/*  */
-/*  Bitmap Definition */
-/*  */
-
-#define	BIT_FA_RESET					BIT(0)
-
-
-
-#endif
-- 
2.18.0

