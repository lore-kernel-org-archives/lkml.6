Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7554ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8051420854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O21r0WCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8051420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387923AbeGVXJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:09:26 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50976 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387830AbeGVXJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:09:25 -0400
Received: by mail-wm0-f67.google.com with SMTP id v25-v6so14110244wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 15:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xBSWsJtomC9cen8dh0sz8+HU75k8hW8NMfZ46OHYLLM=;
        b=O21r0WCSotWg5CUNWQtZuqZlTxBoRzz5cUlRxsyU/PHRD2G0HUyAPoSxLOt4MDorV9
         A827qvQS9hOH0pxetXAt62L2YCWJO7XUWD2n7iyV+Lge6dzejpzNCSC4Xfw1ZE4M0z6j
         xwnZI4yzMyd4mFCoRkpXDEp/6ydp5ETbkCOyMySepP5zXEHg4PTmywRZaHZ66tHXLARr
         3gtkwCJ0/F7Nqzk+Mz9ToJ4sjA/5UJ+3fxYP2tK0oJfXrSSPlKpDGv83O+lZh3HjwqBW
         hcAY0+BjtHsurjAmtNOlwLaLpOSFwpP6eExPpJMEfVBmgRS1C7IP33z10kU44+z6kOQ1
         JWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xBSWsJtomC9cen8dh0sz8+HU75k8hW8NMfZ46OHYLLM=;
        b=qNtIQKqaFIVsO4o+ugcgH6fT+6Gxoca+KQk+KXIprTgSeDNkcv7qiPvS29n+fFT9Y5
         mDsTVFpkEVKtD9bt50wJ2ne9aaW2TefrfUwlCsMw5CGb+v9SP7ezC6p4CLYXKKhoTioO
         zQxMDgkfsLQ1Uo3UYG8JCfcfKU0vNnO+ZC1AkqSwKD5MTyr5/cMYS9DTCeVx658fcqV/
         o/FGLxKYkRJ/ttrH/HgFNcrTA1YqrPvPljzW54lW0SFm0WDDFo659VZfJLiKE/I3vrxM
         KOyTiBQa+wxCIIsNGuNSuyORD/0U0Ai0FFa6nQf0Hl9GA8az4rtjUVbWrn1WtsKfIlwz
         swrg==
X-Gm-Message-State: AOUpUlGSFSDspH6tGback95Cuf/H7SU3H9019fUCsdR9w+wUZ9dtucPL
        P6uOraHEg0ewMm2b8/yOvEl2DVx0raI=
X-Google-Smtp-Source: AAOMgpc/UXaWxNKSN/BICcHONt+Kucl443LeFyC2DHmuyyf/JVHL4Tik7U+47J9swrJGSmZJ9gGV4w==
X-Received: by 2002:a1c:3314:: with SMTP id z20-v6mr5728430wmz.95.1532297472015;
        Sun, 22 Jul 2018 15:11:12 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5870824wrt.29.2018.07.22.15.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:11:11 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 15/20] staging:rtl8192u: Remove unused page d Bit Mask definitions - Style
Date:   Sun, 22 Jul 2018 23:10:30 +0100
Message-Id: <20180722221035.14453-16-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722221035.14453-1-johnfwhitmore@gmail.com>
References: <20180722221035.14453-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused 'page d' Bit Mask definitions. These definitions will
fail the checkpatch CamelCase naming test. Since the definitions are
unused in code they have been removed, rather then renaming.

This is a coding style change which should not impact runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phyreg.h | 107 -----------------------
 1 file changed, 107 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phyreg.h b/drivers/staging/rtl8192u/r819xU_phyreg.h
index b0bcef2e73a6..671fd35297d5 100644
--- a/drivers/staging/rtl8192u/r819xU_phyreg.h
+++ b/drivers/staging/rtl8192u/r819xU_phyreg.h
@@ -123,113 +123,6 @@
 /* page-a */
 #define bCCKSideBand				0x10
 
-/* page d */
-#define bSTBCEn                  0x4
-#define bAntennaMapping          0x10
-#define bNss                     0x20
-#define bCFOAntSumD              0x200
-#define bPHYCounterReset         0x8000000
-#define bCFOReportGet            0x4000000
-#define bOFDMContinueTx          0x10000000
-#define bOFDMSingleCarrier       0x20000000
-#define bOFDMSingleTone          0x40000000
-/* #define bRxPath1                 0x01
- * #define bRxPath2                 0x02
- * #define bRxPath3                 0x04
- * #define bRxPath4                 0x08
- * #define bTxPath1                 0x10
- * #define bTxPath2                 0x20
- */
-#define bHTDetect                0x100
-#define bCFOEn                   0x10000
-#define bCFOValue                0xfff00000
-#define bSigTone_Re              0x3f
-#define bSigTone_Im              0x7f00
-#define bCounter_CCA             0xffff
-#define bCounter_ParityFail      0xffff0000
-#define bCounter_RateIllegal     0xffff
-#define bCounter_CRC8Fail        0xffff0000
-#define bCounter_MCSNoSupport    0xffff
-#define bCounter_FastSync        0xffff
-#define bShortCFO                0xfff
-#define bShortCFOTLength         12   /* total */
-#define bShortCFOFLength         11   /* fraction */
-#define bLongCFO                 0x7ff
-#define bLongCFOTLength          11
-#define bLongCFOFLength          11
-#define bTailCFO                 0x1fff
-#define bTailCFOTLength          13
-#define bTailCFOFLength          12
-
-#define bmax_en_pwdB             0xffff
-#define bCC_power_dB             0xffff0000
-#define bnoise_pwdB              0xffff
-#define bPowerMeasTLength        10
-#define bPowerMeasFLength        3
-#define bRx_HT_BW                0x1
-#define bRxSC                    0x6
-#define bRx_HT                   0x8
-
-#define bNB_intf_det_on          0x1
-#define bIntf_win_len_cfg        0x30
-#define bNB_Intf_TH_cfg          0x1c0
-
-#define bRFGain                  0x3f
-#define bTableSel                0x40
-#define bTRSW                    0x80
-
-#define bRxSNR_A                 0xff
-#define bRxSNR_B                 0xff00
-#define bRxSNR_C                 0xff0000
-#define bRxSNR_D                 0xff000000
-#define bSNREVMTLength           8
-#define bSNREVMFLength           1
-
-#define bCSI1st                  0xff
-#define bCSI2nd                  0xff00
-#define bRxEVM1st                0xff0000
-#define bRxEVM2nd                0xff000000
-
-#define bSIGEVM                  0xff
-#define bPWDB                    0xff00
-#define bSGIEN                   0x10000
-
-#define bSFactorQAM1             0xf
-#define bSFactorQAM2             0xf0
-#define bSFactorQAM3             0xf00
-#define bSFactorQAM4             0xf000
-#define bSFactorQAM5             0xf0000
-#define bSFactorQAM6             0xf0000
-#define bSFactorQAM7             0xf00000
-#define bSFactorQAM8             0xf000000
-#define bSFactorQAM9             0xf0000000
-#define bCSIScheme               0x100000
-
-#define bNoiseLvlTopSet          0x3
-#define bChSmooth                0x4
-#define bChSmoothCfg1            0x38
-#define bChSmoothCfg2            0x1c0
-#define bChSmoothCfg3            0xe00
-#define bChSmoothCfg4            0x7000
-#define bMRCMode                 0x800000
-#define bTHEVMCfg                0x7000000
-
-#define bLoopFitType             0x1
-#define bUpdCFO                  0x40
-#define bUpdCFOOffData           0x80
-#define bAdvUpdCFO               0x100
-#define bAdvTimeCtrl             0x800
-#define bUpdClko                 0x1000
-#define bFC                      0x6000
-#define bTrackingMode            0x8000
-#define bPhCmpEnable             0x10000
-#define bUpdClkoLTF              0x20000
-#define bComChCFO                0x40000
-#define bCSIEstiMode             0x80000
-#define bAdvUpdEqz               0x100000
-#define bUChCfg                  0x7000000
-#define bUpdEqz                  0x8000000
-
 /* page e */
 #define bTxAGCRate18_06			0x7f7f7f7f
 #define bTxAGCRate54_24			0x7f7f7f7f
-- 
2.18.0

