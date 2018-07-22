Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F556C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FD720858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjtbZi9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FD720858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387888AbeGVXJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:09:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41753 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387780AbeGVXJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:09:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so16020321wrr.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 15:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PnR8g7TciTlzYEfiSpmMyXlmOgNT7OEGdNmNpXj9P/A=;
        b=rjtbZi9+KFOKvmtmPDjhHslSKYKPF/7blzqXPfxmt8sdDVujEAuI+LouqNTLs+xKpO
         KC5K2ehJ/X7mHNK+nhGmtz2tBedoTgBCyO8AgdJuX0yWgZnfgY6Q3AouUJ9OWd0rr4RT
         orUu4SN4QLABCNaTlUGCFL26bUXE1mSipBStGh+U5erx6HwWKAlHpkfkroMvvvRkpRgP
         8gB138XPlSaLzxkh1tZrB0LkcuuggWL59ff4ou7G6mG7WxO4DlX+gFze2qp3Irv03oOh
         WvyaQZsdZGIFrL54SR2Nzpp/IhEBPVgw8cvaz4hYaDZasX2mX7b2LyqI8K/DDWyKqz4e
         1U0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PnR8g7TciTlzYEfiSpmMyXlmOgNT7OEGdNmNpXj9P/A=;
        b=rICwiGOK19p5HjU8qhBy8vE5ueslUSjhQdPAyH9iztxZfN+Xj1jsu2oO1czaMQTKDN
         sIPBGmifCDngUInrSi8jcVTdCgu6+xcSX60+cBCtNNEAThMMvE/luZ1nZYHU0LfRcXH1
         slZpyuwz3v/ni+lcRsa+GSYD45eC81A79VMOfYBWJT6bja2MEIKKCKgyzQ6+n4JDkez8
         sy1tGFfJ8E4PhOx1qwkstNcX12jiHz8RsFlK+x0uFPP+FXNGW3MrEcG3NSzLQEGK2GZY
         sCYeHRsouNCmDwvyOtv08E7S/wCDWLzVVtbIP7uXAkIN3x1Nc5b5vnVAYBU+pD7k0K0P
         P36Q==
X-Gm-Message-State: AOUpUlGvGVjZ8XP/ACNm5ohh6sFKgEi6Bv9NTXE3j49v8iGl1PIm8uRw
        Z55cpWGl8+daxhRi373ktwXsLRCj8wQ=
X-Google-Smtp-Source: AAOMgpfjsoMEUBOfEUCcwFFxQMC5CuXr2MLdznMyma/I66IH0w4iArSsAq8YCpmWQKR6Wj4OFH7DuA==
X-Received: by 2002:adf:e0cc:: with SMTP id e12-v6mr6692412wri.199.1532297470163;
        Sun, 22 Jul 2018 15:11:10 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5870824wrt.29.2018.07.22.15.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:11:09 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 14/20] staging:rtl8192u: Remove unused page c Bit Mask definitions - Style
Date:   Sun, 22 Jul 2018 23:10:29 +0100
Message-Id: <20180722221035.14453-15-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722221035.14453-1-johnfwhitmore@gmail.com>
References: <20180722221035.14453-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused 'page c' Bit Mask definitions. These definitions will
fail the checkpatch CamelCase naming test. Rather then renaming, as the
definitions are unused in code, they have simply been removed.

The change is a coding style change which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phyreg.h | 163 -----------------------
 1 file changed, 163 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phyreg.h b/drivers/staging/rtl8192u/r819xU_phyreg.h
index af98067c0de0..b0bcef2e73a6 100644
--- a/drivers/staging/rtl8192u/r819xU_phyreg.h
+++ b/drivers/staging/rtl8192u/r819xU_phyreg.h
@@ -123,169 +123,6 @@
 /* page-a */
 #define bCCKSideBand				0x10
 
-/* page c */
-#define bNumOfSTF					0x3
-#define bShift_L					0xc0
-#define bGI_TH						0xc
-#define bRxPathA					0x1
-#define bRxPathB					0x2
-#define bRxPathC					0x4
-#define bRxPathD					0x8
-#define bTxPathA					0x1
-#define bTxPathB					0x2
-#define bTxPathC					0x4
-#define bTxPathD					0x8
-#define bTRSSIFreq					0x200
-#define bADCBackoff					0x3000
-#define bDFIRBackoff					0xc000
-#define bTRSSILatchPhase			0x10000
-#define bRxIDCOffset					0xff
-#define bRxQDCOffset					0xff00
-#define bRxDFIRMode				0x1800000
-#define bRxDCNFType				0xe000000
-#define bRXIQImb_A					0x3ff
-#define bRXIQImb_B					0xfc00
-#define bRXIQImb_C					0x3f0000
-#define bRXIQImb_D					0xffc00000
-#define bDC_dc_Notch				0x60000
-#define bRxNBINotch					0x1f000000
-#define bPD_TH						0xf
-#define bPD_TH_Opt2				0xc000
-#define bPWED_TH					0x700
-#define bIfMF_Win_L					0x800
-#define bPD_Option					0x1000
-#define bMF_Win_L					0xe000
-#define bBW_Search_L				0x30000
-#define bwin_enh_L					0xc0000
-#define bBW_TH						0x700000
-#define bED_TH2						0x3800000
-#define bBW_option					0x4000000
-#define bRatio_TH					0x18000000
-#define bWindow_L					0xe0000000
-#define bSBD_Option					0x1
-#define bFrame_TH					0x1c
-#define bFS_Option					0x60
-#define bDC_Slope_check				0x80
-#define bFGuard_Counter_DC_L			0xe00
-#define bFrame_Weight_Short			0x7000
-#define bSub_Tune					0xe00000
-#define bFrame_DC_Length			0xe000000
-#define bSBD_start_offset			0x30000000
-#define bFrame_TH_2				0x7
-#define bFrame_GI2_TH				0x38
-#define bGI2_Sync_en				0x40
-#define bSarch_Short_Early			0x300
-#define bSarch_Short_Late			0xc00
-#define bSarch_GI2_Late				0x70000
-#define bCFOAntSum				0x1
-#define bCFOAcc						0x2
-#define bCFOStartOffset				0xc
-#define bCFOLookBack				0x70
-#define bCFOSumWeight				0x80
-#define bDAGCEnable					0x10000
-#define bTXIQImb_A					0x3ff
-#define bTXIQImb_B					0xfc00
-#define bTXIQImb_C					0x3f0000
-#define bTXIQImb_D					0xffc00000
-#define bTxIDCOffset					0xff
-#define bTxQDCOffset					0xff00
-#define bTxDFIRMode				0x10000
-#define bTxPesudoNoiseOn			0x4000000
-#define bTxPesudoNoise_A			0xff
-#define bTxPesudoNoise_B			0xff00
-#define bTxPesudoNoise_C			0xff0000
-#define bTxPesudoNoise_D			0xff000000
-#define bCCADropOption				0x20000
-#define bCCADropThres				0xfff00000
-#define bEDCCA_H					0xf
-#define bEDCCA_L					0xf0
-#define bLambda_ED               0x300
-#define bRxInitialGain           0x7f
-#define bRxAntDivEn              0x80
-#define bRxAGCAddressForLNA      0x7f00
-#define bRxHighPowerFlow         0x8000
-#define bRxAGCFreezeThres        0xc0000
-#define bRxFreezeStep_AGC1       0x300000
-#define bRxFreezeStep_AGC2       0xc00000
-#define bRxFreezeStep_AGC3       0x3000000
-#define bRxFreezeStep_AGC0       0xc000000
-#define bRxRssi_Cmp_En           0x10000000
-#define bRxQuickAGCEn            0x20000000
-#define bRxAGCFreezeThresMode    0x40000000
-#define bRxOverFlowCheckType     0x80000000
-#define bRxAGCShift              0x7f
-#define bTRSW_Tri_Only           0x80
-#define bPowerThres              0x300
-#define bRxAGCEn                 0x1
-#define bRxAGCTogetherEn         0x2
-#define bRxAGCMin                0x4
-#define bRxHP_Ini                0x7
-#define bRxHP_TRLNA              0x70
-#define bRxHP_RSSI               0x700
-#define bRxHP_BBP1               0x7000
-#define bRxHP_BBP2               0x70000
-#define bRxHP_BBP3               0x700000
-#define bRSSI_H                  0x7f0000     /* the threshold for high power */
-#define bRSSI_Gen                0x7f000000   /* the threshold for ant diversity */
-#define bRxSettle_TRSW           0x7
-#define bRxSettle_LNA            0x38
-#define bRxSettle_RSSI           0x1c0
-#define bRxSettle_BBP            0xe00
-#define bRxSettle_RxHP           0x7000
-#define bRxSettle_AntSW_RSSI     0x38000
-#define bRxSettle_AntSW          0xc0000
-#define bRxProcessTime_DAGC      0x300000
-#define bRxSettle_HSSI           0x400000
-#define bRxProcessTime_BBPPW     0x800000
-#define bRxAntennaPowerShift     0x3000000
-#define bRSSITableSelect         0xc000000
-#define bRxHP_Final              0x7000000
-#define bRxHTSettle_BBP          0x7
-#define bRxHTSettle_HSSI         0x8
-#define bRxHTSettle_RxHP         0x70
-#define bRxHTSettle_BBPPW        0x80
-#define bRxHTSettle_Idle         0x300
-#define bRxHTSettle_Reserved     0x1c00
-#define bRxHTRxHPEn              0x8000
-#define bRxHTAGCFreezeThres      0x30000
-#define bRxHTAGCTogetherEn       0x40000
-#define bRxHTAGCMin              0x80000
-#define bRxHTAGCEn               0x100000
-#define bRxHTDAGCEn              0x200000
-#define bRxHTRxHP_BBP            0x1c00000
-#define bRxHTRxHP_Final          0xe0000000
-#define bRxPWRatioTH             0x3
-#define bRxPWRatioEn             0x4
-#define bRxMFHold                0x3800
-#define bRxPD_Delay_TH1          0x38
-#define bRxPD_Delay_TH2          0x1c0
-#define bRxPD_DC_COUNT_MAX       0x600
-/* #define bRxMF_Hold               0x3800 */
-#define bRxPD_Delay_TH           0x8000
-#define bRxProcess_Delay         0xf0000
-#define bRxSearchrange_GI2_Early 0x700000
-#define bRxFrame_Guard_Counter_L 0x3800000
-#define bRxSGI_Guard_L           0xc000000
-#define bRxSGI_Search_L          0x30000000
-#define bRxSGI_TH                0xc0000000
-#define bDFSCnt0                 0xff
-#define bDFSCnt1                 0xff00
-#define bDFSFlag                 0xf0000
-
-#define bMFWeightSum             0x300000
-#define bMinIdxTH                0x7f000000
-
-#define bDAFormat                0x40000
-
-#define bTxChEmuEnable           0x01000000
-
-#define bTRSWIsolation_A         0x7f
-#define bTRSWIsolation_B         0x7f00
-#define bTRSWIsolation_C         0x7f0000
-#define bTRSWIsolation_D         0x7f000000
-
-#define bExtLNAGain              0x7c00
-
 /* page d */
 #define bSTBCEn                  0x4
 #define bAntennaMapping          0x10
-- 
2.18.0

