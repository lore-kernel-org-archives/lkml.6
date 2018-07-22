Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECECECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2988120854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujt4zwO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2988120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbeGVXKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:10:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39886 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730712AbeGVXJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:09:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so16019276wre.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 15:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FniwGQOu+qHw9aYQlWW5dLQ+1yz6XqiL4WWTg4ne1zc=;
        b=ujt4zwO0VMtdZP9wjC9EtKHNnhAGfOrtrIDk2oar7P0SLtfKEy6IjBokU7vMD0uBP0
         GvccyItse1HDC2lRozBRg//XpVAx2RNifJY0YvLoDx/z50NfDGScISfjvP+BGUuWfl6i
         O/rmFiXmS9QMX9aRXQhDoNn76T1lQasccGxmHladdA4piRXk4E/bZprHvx5qj9dUkWJF
         vEl6tRKJiDI6ZX/n/JQunmQiIwDamPHs4vVmE4rA2zAWLjYhCPSYRJsjOOo2HFv4CUQa
         RvIecN82bg9C1sxOh49dFXQR0IQ5bl98cosm2jkmfoTFhO4jD64JaJ9CO1gTbPJAFcA1
         bYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FniwGQOu+qHw9aYQlWW5dLQ+1yz6XqiL4WWTg4ne1zc=;
        b=JHwHZIHP9dRETKSaXbHaosk5W6fBieCtdBRNOpC20UV03/vjY8aLxmq405MP8c04RH
         kIBXY1Xx0gAj2jDXcNmN1dB7mBQavk0+yv5gW/6ekGu1nMDzdASlMIRVjr2yAk8GKPYe
         iyBVI5lILuPPaSZ2NVSTTDPzikhC7ERlo9yTI3rysVU/BP4ln6YUhMN7Mpvnk/yBow9B
         MpYabsZkJBz47XwR/cVa70fjPHr2MfN0Hv3B4b7bvzTPei9hfzDo+l5UzfCeabYR+k4D
         RYmd5Uj/K+mO0SH+KVtj8stLeNrfxZa1p6wmx88+EK9tt0sB17kJSu2X5AFceng7SfgF
         eyYQ==
X-Gm-Message-State: AOUpUlG6Xr+QRCAoM8Xy3fZbqHNINs7afBcLVUxEqfcXF8S+UeMNH0Sb
        uwCK8kfOKO58TiBuKiRckcPpqQJuboI=
X-Google-Smtp-Source: AAOMgpc9Mn4EJHB/ud37/kXzWAfmxVM0MMvb8fhlakUJ2faN8MGj3nt85nVyr7W0/YTJm+1/EAnAzw==
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr6857840wra.120.1532297456549;
        Sun, 22 Jul 2018 15:10:56 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5870824wrt.29.2018.07.22.15.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:10:55 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/20] staging:rtl8192u: Remove unused page d definitions - Style
Date:   Sun, 22 Jul 2018 23:10:21 +0100
Message-Id: <20180722221035.14453-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722221035.14453-1-johnfwhitmore@gmail.com>
References: <20180722221035.14453-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused 'page d' definitions. These definitions fail the
checkpatch CamelCase naming test. Rather then renaming unused
definitions they have simply been removed. This change is a coding
style change and should have no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phyreg.h | 27 ------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phyreg.h b/drivers/staging/rtl8192u/r819xU_phyreg.h
index 26d18a494fb4..661df18867dd 100644
--- a/drivers/staging/rtl8192u/r819xU_phyreg.h
+++ b/drivers/staging/rtl8192u/r819xU_phyreg.h
@@ -85,33 +85,6 @@
 /* page d */
 #define rOFDM1_LSTF				0xd00
 #define rOFDM1_TRxPathEnable		0xd04
-#define rOFDM1_CFO				0xd08
-#define rOFDM1_CSI1				0xd10
-#define rOFDM1_SBD				0xd14
-#define rOFDM1_CSI2				0xd18
-#define rOFDM1_CFOTracking			0xd2c
-#define rOFDM1_TRxMesaure1		0xd34
-#define rOFDM1_IntfDet				0xd3c
-#define rOFDM1_PseudoNoiseStateAB 0xd50
-#define rOFDM1_PseudoNoiseStateCD 0xd54
-#define rOFDM1_RxPseudoNoiseWgt   0xd58
-#define rOFDM_PHYCounter1			0xda0  /* cca, parity fail */
-#define rOFDM_PHYCounter2			0xda4  /* rate illegal, crc8 fail */
-
-#define rOFDM_PHYCounter3			0xda8  /* MCS not support */
-#define rOFDM_ShortCFOAB			0xdac
-#define rOFDM_ShortCFOCD			0xdb0
-#define rOFDM_LongCFOAB				0xdb4
-#define rOFDM_LongCFOCD				0xdb8
-#define rOFDM_TailCFOAB				0xdbc
-#define rOFDM_TailCFOCD				0xdc0
-#define rOFDM_PWMeasure1		0xdc4
-#define rOFDM_PWMeasure2		0xdc8
-#define rOFDM_BWReport				0xdcc
-#define rOFDM_AGCReport				0xdd0
-#define rOFDM_RxSNR				0xdd4
-#define rOFDM_RxEVMCSI				0xdd8
-#define rOFDM_SIGReport				0xddc
 
 /* page e */
 #define rTxAGC_Rate18_06			0xe00
-- 
2.18.0

