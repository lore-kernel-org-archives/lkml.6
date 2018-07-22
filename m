Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AF6C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9112420878
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8ddcQAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9112420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387868AbeGVXJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:09:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43343 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387830AbeGVXJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:09:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so16029753wrv.10
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 15:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2QhVxUq+Qr8j5XLMxhy/3sgwiSaPxByFoEuth90QhDA=;
        b=F8ddcQAUGTcwb/CHYoShPOppHbvGkYJET7x4RvU/oX1+S88DyHcxXsqkzCgkl5pukh
         okVlFQ6Len16c3Izd9hBJ19XxoYH2bVCT7Xibe9az5snwaBQZr4SJjP/ytKGjKlIg9Qh
         S/EIrPfSUXZmFjBYL9QjDpJr9VLYRg4x8R+bmrGzwrm0GrAK3Wp3PwrDNsVu/IinWz9V
         gkzGjPJhytbCDzP+KfZHl77hh8GDtPF13R2mQnoTkOtDWUdvKUzG+jbbYuwnvoiHTWQT
         Fjy/pI4+mdQcUdG2fXivEjsX1tEJjSFRVp6ZlzEuBTGSLhBgutethk4z5LpwH6qNjHJW
         brPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2QhVxUq+Qr8j5XLMxhy/3sgwiSaPxByFoEuth90QhDA=;
        b=gLaN+arjQL1bFy4Px4rvMHTtdQs+NmEgq43bFTO4dxOPuYtnwn/SQrW+9M8VM2F5F5
         cVmVcVBnW9ZXuC2EqvJeBWf2KZLXKVtn5zXQh0dWepkfbsMvQjfBxmZSWr6AnRFxL9Cl
         buMO++h8+qmSYHFZk1WcoAAI5lftDC9BfLt2xp5Ew47jwlT8MLR6o34rYCUXECrorAK9
         olU2I8+aTPlXGvpVhOWE8Ypysl1vySRfjgaMFWDas6DGptyUMwuV37jdmgLNnvm4L92t
         oUpUM7ScmMgg0C0wFHhWKsVZAL7gj3+KwMnsQoSr7wiidrnPVgyP8dUZ9vDMcpch7Ymy
         o0Cw==
X-Gm-Message-State: AOUpUlHLfx+n8gXzy7zyWh19nn7RHZ1+H7r3LXSIW/NiaJGLoizKU8y7
        KKHAC+6XriWe78J+orldeJKB0mReO8g=
X-Google-Smtp-Source: AAOMgpfkCEnF67LKOm5H/jSnT74xjQ8S2rwZVmD1DRCG4SLgrhOJeFDKOiAFOOc57+q/iSnFVzTBjw==
X-Received: by 2002:adf:8325:: with SMTP id 34-v6mr6571127wrd.67.1532297468371;
        Sun, 22 Jul 2018 15:11:08 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5870824wrt.29.2018.07.22.15.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:11:07 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 13/20] staging:rtl8192u: Remove unused page-a Bit Mask definitions - Style
Date:   Sun, 22 Jul 2018 23:10:28 +0100
Message-Id: <20180722221035.14453-14-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722221035.14453-1-johnfwhitmore@gmail.com>
References: <20180722221035.14453-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused 'page-a' Bit Mask definitions. These definitions will
fail the checkpatch CamelCase naming tests, rather then renaming, as the
definitions are unused, they have simply been removed.

This is a coding style change and should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phyreg.h | 78 ------------------------
 1 file changed, 78 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phyreg.h b/drivers/staging/rtl8192u/r819xU_phyreg.h
index 53beef72ceda..af98067c0de0 100644
--- a/drivers/staging/rtl8192u/r819xU_phyreg.h
+++ b/drivers/staging/rtl8192u/r819xU_phyreg.h
@@ -121,85 +121,7 @@
 #define bXtalCap					0x0f000000
 
 /* page-a */
-#define bCCKBBMode				0x3
-#define bCCKTxPowerSaving			0x80
-#define bCCKRxPowerSaving			0x40
 #define bCCKSideBand				0x10
-#define bCCKScramble				0x8
-#define bCCKAntDiversity			0x8000
-#define bCCKCarrierRecovery		0x4000
-#define bCCKTxRate				0x3000
-#define bCCKDCCancel				0x0800
-#define bCCKISICancel				0x0400
-#define bCCKMatchFilter				0x0200
-#define bCCKEqualizer				0x0100
-#define bCCKPreambleDetect			0x800000
-#define bCCKFastFalseCCA			0x400000
-#define bCCKChEstStart				0x300000
-#define bCCKCCACount				0x080000
-#define bCCKcs_lim					0x070000
-#define bCCKBistMode				0x80000000
-#define bCCKCCAMask				0x40000000
-#define bCCKTxDACPhase			0x4
-#define bCCKRxADCPhase			0x20000000   /* r_rx_clk */
-#define bCCKr_cp_mode0			0x0100
-#define bCCKTxDCOffset				0xf0
-#define bCCKRxDCOffset				0xf
-#define bCCKCCAMode				0xc000
-#define bCCKFalseCS_lim				0x3f00
-#define bCCKCS_ratio				0xc00000
-#define bCCKCorgBit_sel				0x300000
-#define bCCKPD_lim					0x0f0000
-#define bCCKNewCCA				0x80000000
-#define bCCKRxHPofIG				0x8000
-#define bCCKRxIG					0x7f00
-#define bCCKLNAPolarity				0x800000
-#define bCCKRx1stGain				0x7f0000
-#define bCCKRFExtend				0x20000000 /* CCK Rx initial gain polarity */
-#define bCCKRxAGCSatLevel			0x1f000000
-#define bCCKRxAGCSatCount			0xe0
-#define bCCKRxRFSettle				0x1f       /* AGCsamp_dly */
-#define bCCKFixedRxAGC				0x8000
-/* #define bCCKRxAGCFormat			0x4000 */   /* remove to HSSI register 0x824 */
-#define bCCKAntennaPolarity			0x2000
-#define bCCKTxFilterType			0x0c00
-#define bCCKRxAGCReportType		0x0300
-#define bCCKRxDAGCEn				0x80000000
-#define bCCKRxDAGCPeriod			0x20000000
-#define bCCKRxDAGCSatLevel		0x1f000000
-#define bCCKTimingRecovery			0x800000
-#define bCCKTxC0					0x3f0000
-#define bCCKTxC1					0x3f000000
-#define bCCKTxC2					0x3f
-#define bCCKTxC3					0x3f00
-#define bCCKTxC4					0x3f0000
-#define bCCKTxC5					0x3f000000
-#define bCCKTxC6					0x3f
-#define bCCKTxC7					0x3f00
-#define bCCKDebugPort				0xff0000
-#define bCCKDACDebug				0x0f000000
-#define bCCKFalseAlarmEnable			0x8000
-#define bCCKFalseAlarmRead			0x4000
-#define bCCKTRSSI					0x7f
-#define bCCKRxAGCReport				0xfe
-#define bCCKRxReport_AntSel			0x80000000
-#define bCCKRxReport_MFOff			0x40000000
-#define bCCKRxRxReport_SQLoss		0x20000000
-#define bCCKRxReport_Pktloss			0x10000000
-#define bCCKRxReport_Lockedbit		0x08000000
-#define bCCKRxReport_RateError		0x04000000
-#define bCCKRxReport_RxRate			0x03000000
-#define bCCKRxFACounterLower		0xff
-#define bCCKRxFACounterUpper		0xff000000
-#define bCCKRxHPAGCStart			0xe000
-#define bCCKRxHPAGCFinal			0x1c00
-
-#define bCCKRxFalseAlarmEnable		0x8000
-#define bCCKFACounterFreeze			0x4000
-
-#define bCCKTxPathSel				0x10000000
-#define bCCKDefaultRxPath			0xc000000
-#define bCCKOptionRxPath			0x3000000
 
 /* page c */
 #define bNumOfSTF					0x3
-- 
2.18.0

