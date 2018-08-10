Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FB0C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2033822407
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWWoFm9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2033822407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeHJNVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:21:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42397 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbeHJNVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:21:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so7872528wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 03:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q1g9POELufXpsRs8mJhPT8irWuPt2QHeVoXNKMcReuQ=;
        b=uWWoFm9nEfc7Tj59I6Tn5dStqS20snyaZNApJWYFcTPba54Of7+KBtcGJjyP74rIe2
         BQOn35j57Nx1twdGMisnVY5B99UIQ4yFj+vbEsDDr1l4Vu7lpu08U1V/WQ5+doGFY+Sx
         PqdfnrMzUkZ1RC5XypmUWK5CezOkAKbxunwZ9kUr/gtI7chMvgUqCtcLj+AVPe0Hequm
         ypgIDFkj5zmylRJ3HYbw4RYLkdPhS7mj8wZJqCAkvmVfCnDTU1qGq34qGNnbB8i3Ivaq
         muxGabu+LEHVDowkgcfLDIZJXglOn29iq7knuGz/hFaTrwxJJ/YJeqkjiJ2Gq7i/0BmF
         +WcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q1g9POELufXpsRs8mJhPT8irWuPt2QHeVoXNKMcReuQ=;
        b=lbUGiNc9IzgCKPpGi+KaNyAylUGOWoO5worHgDdV+vN/cu6AOVYBhNwDm8ts6HMWDg
         wmJlXmzne5TAioclTje5mUPikAMYz51y6+H6JXtxWuYtNnTxv9rASoIzUuSdCK8KUWjC
         mwi3RPnCV+o9qVUbv+CNm81yuBKXi7BekU4KhkdrMLLjjBQLIPB0QHdMJnbFA37Qd0yb
         iKybAsHL6u6VNaJTaPAKPBqMMDn5SNhFgUde3YsuBEZFBYNSifhP8qOU6am+wr1UKblJ
         6rr/DeqNs3o7/zzOZAT5TD5b3Kj9YRSc3CbvA5OClHfxNd30VgPbkZYjmb/hMX6wSONl
         HDLg==
X-Gm-Message-State: AOUpUlHWTecs/N4Z3SUnbQm9wd8cPCOMtKmBPfcL31SErXysMSZbf4ic
        zhA5pBYFW9FJtE7U8sAEhsM=
X-Google-Smtp-Source: AA+uWPzH+SC0j672RE6gAqzDM1xYcpmFkzhs3QJvc72Cy0PPxPtU2flZhEydOhdJclELg1XniG6YJA==
X-Received: by 2002:adf:9443:: with SMTP id 61-v6mr3797146wrq.193.1533898312950;
        Fri, 10 Aug 2018 03:51:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id p14-v6sm14273994wru.0.2018.08.10.03.51.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 03:51:52 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 5/5] staging: rtl8188eu: use phydm_reg.h from rtlwifi
Date:   Fri, 10 Aug 2018 12:51:33 +0200
Message-Id: <20180810105133.31224-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810105133.31224-1-straube.linux@gmail.com>
References: <20180810105133.31224-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use rtlwifi/phydm/phydm_reg.h instead of odm_reg.h and
remove the now unused odm_reg.h.

All defines from odm_reg.h are defined with the same values
in rtlwifi/phydm/phydm_reg.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
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

