Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EBDC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 12:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F108217C7
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 12:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZF4QvDBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F108217C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeHEOQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 10:16:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51469 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbeHEOQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 10:16:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so10967536wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 05:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JqWH3/vPx++ikeXfxr3X5OvHRvIV5vtfmlvKrAEZjQY=;
        b=ZF4QvDBrjgmxgqhHjT4skdJVYbtLwWeUuZnq+39xXHb2ECm8M7GUqxDUn9dwyBpLp1
         mVZZHFajod45KReCJsMrpzoQq4bdZNgiNA23+GTve3v8LySwyOwemC54Rvf+GzKW3R5Q
         0QKrtlevniytCo5KGBduktj+c7KiiLPv60IzT9d1C0tWJePBxi22zIToMD8JXG3p+rlO
         W7HvoVRBkwDi+by57N3/dW9hncKF7HyQXx2J2JWYV1mRd71jJkBnZWX62ek4CB6joLuS
         rPAVvdT3rWZ7c7GWU5lAOU7AucQPm6kXyDPepiVI6sLj6s0kebA0gDHb7YPyyhC1kXZ4
         qgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JqWH3/vPx++ikeXfxr3X5OvHRvIV5vtfmlvKrAEZjQY=;
        b=anYns3xoZXwJ2iTiJPXr4SL1D/6hxX3MCJPSuZTB+IiHl/7YzJsR6nHlxw2SP2LYJC
         2NPJt/goIl0t7ZqfIp021JQsqhwvESvl/f/Jm9lL/bA0+6SrjUXrK09DEKHiVplPax3T
         z9lKrNXkgA4GGOQkfNViRV57VdOhyvoo4d6ITdW6pRXzkYjgWK6kQHVhg8q6qEdu17m6
         lG945Tb2ktETzukBihDj/j+szJMNNDaFA3qKRpawq2+okicAzIKkoreUkjP4SwRjio4B
         xF1SyKsFQJkRNUM+en7i4MBzQOTJdX+UxDi7FP6qp32MiSvSlayPTVclH0me3giLF6f/
         nKPw==
X-Gm-Message-State: AOUpUlFc2F2bBx6mUkvnad005MK9nlZZ42v6LWDBWSCIVkXtYw9HVtd7
        SbC9KFVK4IQS4g6RIyZk55E=
X-Google-Smtp-Source: AAOMgpeG7HSswkCYh2HgKFMdBhW8giG4cmpVGwyrLVIXmRzG60Gmr90sVdnM6twZSdPOHXppZIZvcg==
X-Received: by 2002:a1c:851:: with SMTP id 78-v6mr8700244wmi.11.1533471128162;
        Sun, 05 Aug 2018 05:12:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:8569:71c8:6dba:bb41])
        by smtp.gmail.com with ESMTPSA id j8-v6sm11072857wrn.50.2018.08.05.05.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 05:12:07 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: use phydm_regdefine11n.h from rtlwifi
Date:   Sun,  5 Aug 2018 14:11:54 +0200
Message-Id: <20180805121154.1740-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use rtlwifi/phydm/phydm_regdefine11n.h instead of odm_RegDefine11N.h
and remove the now unused odm_RegDefine11N.h.

The defines from odm_RegDefine11N.h are defined with the same values
in rtlwifi/phydm/phydm_regdefine11n.h.

There is one define that is named different, but that one is not
used in the rtl8188eu code.

rtl8188eu: #define ODM_REG_RX_PATH_11N 0xC04
rtlwifi: #defnie ODM_REG_BB_RX_PATH_11N 0xC04

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../rtl8188eu/include/odm_RegDefine11N.h      | 158 ------------------
 .../staging/rtl8188eu/include/odm_precomp.h   |   2 +-
 2 files changed, 1 insertion(+), 159 deletions(-)
 delete mode 100644 drivers/staging/rtl8188eu/include/odm_RegDefine11N.h

diff --git a/drivers/staging/rtl8188eu/include/odm_RegDefine11N.h b/drivers/staging/rtl8188eu/include/odm_RegDefine11N.h
deleted file mode 100644
index 8663a8ccc75d..000000000000
--- a/drivers/staging/rtl8188eu/include/odm_RegDefine11N.h
+++ /dev/null
@@ -1,158 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-
-#ifndef	__ODM_REGDEFINE11N_H__
-#define __ODM_REGDEFINE11N_H__
-
-
-/* 2 RF REG LIST */
-#define	ODM_REG_RF_MODE_11N				0x00
-#define	ODM_REG_RF_0B_11N				0x0B
-#define	ODM_REG_CHNBW_11N				0x18
-#define	ODM_REG_T_METER_11N				0x24
-#define	ODM_REG_RF_25_11N				0x25
-#define	ODM_REG_RF_26_11N				0x26
-#define	ODM_REG_RF_27_11N				0x27
-#define	ODM_REG_RF_2B_11N				0x2B
-#define	ODM_REG_RF_2C_11N				0x2C
-#define	ODM_REG_RXRF_A3_11N				0x3C
-#define	ODM_REG_T_METER_92D_11N			0x42
-#define	ODM_REG_T_METER_88E_11N			0x42
-
-
-
-/* 2 BB REG LIST */
-/* PAGE 8 */
-#define	ODM_REG_BB_CTRL_11N				0x800
-#define	ODM_REG_RF_PIN_11N				0x804
-#define	ODM_REG_PSD_CTRL_11N				0x808
-#define	ODM_REG_TX_ANT_CTRL_11N			0x80C
-#define	ODM_REG_BB_PWR_SAV5_11N			0x818
-#define	ODM_REG_CCK_RPT_FORMAT_11N		0x824
-#define	ODM_REG_RX_DEFAULT_A_11N		0x858
-#define	ODM_REG_RX_DEFAULT_B_11N		0x85A
-#define	ODM_REG_BB_PWR_SAV3_11N			0x85C
-#define	ODM_REG_ANTSEL_CTRL_11N			0x860
-#define	ODM_REG_RX_ANT_CTRL_11N			0x864
-#define	ODM_REG_PIN_CTRL_11N				0x870
-#define	ODM_REG_BB_PWR_SAV1_11N			0x874
-#define	ODM_REG_ANTSEL_PATH_11N			0x878
-#define	ODM_REG_BB_3WIRE_11N			0x88C
-#define	ODM_REG_SC_CNT_11N				0x8C4
-#define	ODM_REG_PSD_DATA_11N			0x8B4
-/* PAGE 9 */
-#define	ODM_REG_ANT_MAPPING1_11N		0x914
-#define	ODM_REG_ANT_MAPPING2_11N		0x918
-/* PAGE A */
-#define	ODM_REG_CCK_ANTDIV_PARA1_11N	0xA00
-#define	ODM_REG_CCK_CCA_11N				0xA0A
-#define	ODM_REG_CCK_ANTDIV_PARA2_11N	0xA0C
-#define	ODM_REG_CCK_ANTDIV_PARA3_11N	0xA10
-#define	ODM_REG_CCK_ANTDIV_PARA4_11N	0xA14
-#define	ODM_REG_CCK_FILTER_PARA1_11N	0xA22
-#define	ODM_REG_CCK_FILTER_PARA2_11N	0xA23
-#define	ODM_REG_CCK_FILTER_PARA3_11N	0xA24
-#define	ODM_REG_CCK_FILTER_PARA4_11N	0xA25
-#define	ODM_REG_CCK_FILTER_PARA5_11N	0xA26
-#define	ODM_REG_CCK_FILTER_PARA6_11N	0xA27
-#define	ODM_REG_CCK_FILTER_PARA7_11N	0xA28
-#define	ODM_REG_CCK_FILTER_PARA8_11N	0xA29
-#define	ODM_REG_CCK_FA_RST_11N			0xA2C
-#define	ODM_REG_CCK_FA_MSB_11N			0xA58
-#define	ODM_REG_CCK_FA_LSB_11N			0xA5C
-#define	ODM_REG_CCK_CCA_CNT_11N			0xA60
-#define	ODM_REG_BB_PWR_SAV4_11N			0xA74
-/* PAGE B */
-#define	ODM_REG_LNA_SWITCH_11N			0xB2C
-#define	ODM_REG_PATH_SWITCH_11N			0xB30
-#define	ODM_REG_RSSI_CTRL_11N			0xB38
-#define	ODM_REG_CONFIG_ANTA_11N			0xB68
-#define	ODM_REG_RSSI_BT_11N				0xB9C
-/* PAGE C */
-#define	ODM_REG_OFDM_FA_HOLDC_11N		0xC00
-#define	ODM_REG_RX_PATH_11N				0xC04
-#define	ODM_REG_TRMUX_11N				0xC08
-#define	ODM_REG_OFDM_FA_RSTC_11N		0xC0C
-#define	ODM_REG_RXIQI_MATRIX_11N		0xC14
-#define	ODM_REG_TXIQK_MATRIX_LSB1_11N	0xC4C
-#define	ODM_REG_IGI_A_11N				0xC50
-#define	ODM_REG_ANTDIV_PARA2_11N		0xC54
-#define	ODM_REG_IGI_B_11N					0xC58
-#define	ODM_REG_ANTDIV_PARA3_11N		0xC5C
-#define	ODM_REG_BB_PWR_SAV2_11N			0xC70
-#define	ODM_REG_RX_OFF_11N				0xC7C
-#define	ODM_REG_TXIQK_MATRIXA_11N		0xC80
-#define	ODM_REG_TXIQK_MATRIXB_11N		0xC88
-#define	ODM_REG_TXIQK_MATRIXA_LSB2_11N	0xC94
-#define	ODM_REG_TXIQK_MATRIXB_LSB2_11N	0xC9C
-#define	ODM_REG_RXIQK_MATRIX_LSB_11N	0xCA0
-#define	ODM_REG_ANTDIV_PARA1_11N		0xCA4
-#define	ODM_REG_OFDM_FA_TYPE1_11N		0xCF0
-/* PAGE D */
-#define	ODM_REG_OFDM_FA_RSTD_11N		0xD00
-#define	ODM_REG_OFDM_FA_TYPE2_11N		0xDA0
-#define	ODM_REG_OFDM_FA_TYPE3_11N		0xDA4
-#define	ODM_REG_OFDM_FA_TYPE4_11N		0xDA8
-/* PAGE E */
-#define	ODM_REG_TXAGC_A_6_18_11N		0xE00
-#define	ODM_REG_TXAGC_A_24_54_11N		0xE04
-#define	ODM_REG_TXAGC_A_1_MCS32_11N	0xE08
-#define	ODM_REG_TXAGC_A_MCS0_3_11N		0xE10
-#define	ODM_REG_TXAGC_A_MCS4_7_11N		0xE14
-#define	ODM_REG_TXAGC_A_MCS8_11_11N	0xE18
-#define	ODM_REG_TXAGC_A_MCS12_15_11N	0xE1C
-#define	ODM_REG_FPGA0_IQK_11N			0xE28
-#define	ODM_REG_TXIQK_TONE_A_11N		0xE30
-#define	ODM_REG_RXIQK_TONE_A_11N		0xE34
-#define	ODM_REG_TXIQK_PI_A_11N			0xE38
-#define	ODM_REG_RXIQK_PI_A_11N			0xE3C
-#define	ODM_REG_TXIQK_11N				0xE40
-#define	ODM_REG_RXIQK_11N				0xE44
-#define	ODM_REG_IQK_AGC_PTS_11N			0xE48
-#define	ODM_REG_IQK_AGC_RSP_11N			0xE4C
-#define	ODM_REG_BLUETOOTH_11N			0xE6C
-#define	ODM_REG_RX_WAIT_CCA_11N			0xE70
-#define	ODM_REG_TX_CCK_RFON_11N			0xE74
-#define	ODM_REG_TX_CCK_BBON_11N			0xE78
-#define	ODM_REG_OFDM_RFON_11N			0xE7C
-#define	ODM_REG_OFDM_BBON_11N			0xE80
-#define		ODM_REG_TX2RX_11N				0xE84
-#define	ODM_REG_TX2TX_11N				0xE88
-#define	ODM_REG_RX_CCK_11N				0xE8C
-#define	ODM_REG_RX_OFDM_11N				0xED0
-#define	ODM_REG_RX_WAIT_RIFS_11N		0xED4
-#define	ODM_REG_RX2RX_11N				0xED8
-#define	ODM_REG_STANDBY_11N				0xEDC
-#define	ODM_REG_SLEEP_11N				0xEE0
-#define	ODM_REG_PMPD_ANAEN_11N			0xEEC
-
-
-
-
-
-
-
-/* 2 MAC REG LIST */
-#define	ODM_REG_BB_RST_11N				0x02
-#define	ODM_REG_ANTSEL_PIN_11N			0x4C
-#define	ODM_REG_EARLY_MODE_11N			0x4D0
-#define	ODM_REG_RSSI_MONITOR_11N		0x4FE
-#define	ODM_REG_EDCA_VO_11N				0x500
-#define	ODM_REG_EDCA_VI_11N				0x504
-#define	ODM_REG_EDCA_BE_11N				0x508
-#define	ODM_REG_EDCA_BK_11N				0x50C
-#define	ODM_REG_TXPAUSE_11N				0x522
-#define	ODM_REG_RESP_TX_11N				0x6D8
-#define	ODM_REG_ANT_TRAIN_PARA1_11N	0x7b0
-#define	ODM_REG_ANT_TRAIN_PARA2_11N	0x7b4
-
-
-/* DIG Related */
-#define	ODM_BIT_IGI_11N					0x0000007F
-
-
-#endif
diff --git a/drivers/staging/rtl8188eu/include/odm_precomp.h b/drivers/staging/rtl8188eu/include/odm_precomp.h
index 4d0dd12645bd..658a938df4c1 100644
--- a/drivers/staging/rtl8188eu/include/odm_precomp.h
+++ b/drivers/staging/rtl8188eu/include/odm_precomp.h
@@ -24,7 +24,7 @@
 #include "odm.h"
 #include "odm_HWConfig.h"
 #include "odm_debug.h"
-#include "odm_RegDefine11N.h"
+#include "../../rtlwifi/phydm/phydm_regdefine11n.h"
 
 #include "hal8188e_rate_adaptive.h" /* for RA,Power training */
 #include "rtl8188e_hal.h"
-- 
2.18.0

