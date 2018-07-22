Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E873C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F8A20858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR60iMW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F8A20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbeGVXJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:09:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40444 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbeGVXI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:08:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id t6-v6so16014781wrn.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 15:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fx1PLd7611JrGFLSJCkVAvrK4+i6w2wL3vhUr2JZpOg=;
        b=nR60iMW+DhSeKB5moLeuqULkRaG4+Qz0jz0QVlp424na1fmMZpde/icyCW4wo54oTw
         Q2ZoDjPTXTx4iTTvDYA87ogXvLA3rjsKfaCt0/Rky7WgFbfDY2iGEN6KQEPg0YKs/Gli
         ueqIBRCix3QKoa3AxFeN/BXDwdC1WVfluYTih6SmHJbakLb/3fYEo627sxBLchLSfCnD
         6KxMCLuMdaFCzPvld92TJ/Pm5JZRwqcnBPtmVFiSs7ZbdyZqC85WbML+vpUh0kh2OZTT
         piYlQqQCZ1p/wi4RW0Xn8O85GlyfNoN49+47UvXkqfygiiosOje/gVxsOoB9wbqX1ynA
         Ydaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fx1PLd7611JrGFLSJCkVAvrK4+i6w2wL3vhUr2JZpOg=;
        b=lR8prkSb6W5MTS0fIA/HM0U+cUKOz9/GtPS0I3DJGJqbABGWVmensCCiWhjDywyRHO
         uKWMT1Y7j7wndqzvs8M6Jz7DnOCgREe1Oh0wmHyYa4zLMc97XkvpDAqQpm8xczOQOepD
         Ol7as/6E5jl5WGZmdeh0LTTPcZRKHf4247eQpeBP6N3U/oUYboVcp/I4HyyY6O3NaWFP
         bTXQIUJdbMrU2l+CYUI8pKZ6nKb2gkEmkYFhlsaLgFHEvD55wBBxRJp/XKZ+HDuljsad
         nIrqTRM2Kl78TmSkaaqCl7W4kcitOC2A5FEgqs569vdI9fEB6g4EVqYNwVNDWdaZLmHL
         8cZg==
X-Gm-Message-State: AOUpUlHlwzwxGvsPB2eMQo7egXtfvjs2PtbGakrxZlhIe+Xd8JzoHRS2
        JF9Qtq2pKCBtBZlIWFK1OmngQK1I32o=
X-Google-Smtp-Source: AAOMgpeJBGy7seSLDiNFZuUx1xGP2OWWPILdyoSMJgbloTI3P7wxJw2Zk+E52uhRYSUsHgEa/wA9rA==
X-Received: by 2002:adf:cd82:: with SMTP id q2-v6mr7058660wrj.118.1532297448229;
        Sun, 22 Jul 2018 15:10:48 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5870824wrt.29.2018.07.22.15.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:10:47 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/20] staging:rtl8192u: Remove unused page 1 definitions - Style
Date:   Sun, 22 Jul 2018 23:10:16 +0100
Message-Id: <20180722221035.14453-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722221035.14453-1-johnfwhitmore@gmail.com>
References: <20180722221035.14453-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all the "page 1" definitions as they are not used in code.

A lot of these definitions, if not all, fail checkpatch because of
CamelCase issues. Rather then change the names of unused constants
simply remove. This is a coding style change which should have no
impact on runtime execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phyreg.h | 31 ------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phyreg.h b/drivers/staging/rtl8192u/r819xU_phyreg.h
index c058a9537526..437f3bfcc399 100644
--- a/drivers/staging/rtl8192u/r819xU_phyreg.h
+++ b/drivers/staging/rtl8192u/r819xU_phyreg.h
@@ -5,37 +5,6 @@
 
 #define   RF_DATA				0x1d4					/* FW will write RF data in the register.*/
 
-/* Register duplicate register due to connection: RF_Mode, TRxRN, NumOf L-STF
- * page 1
- */
-#define rPMAC_Reset				0x100
-#define rPMAC_TxStart				0x104
-#define rPMAC_TxLegacySIG			0x108
-#define rPMAC_TxHTSIG1				0x10c
-#define rPMAC_TxHTSIG2				0x110
-#define rPMAC_PHYDebug				0x114
-#define rPMAC_TxPacketNum			0x118
-#define rPMAC_TxIdle				0x11c
-#define rPMAC_TxMACHeader0		0x120
-#define rPMAC_TxMACHeader1		0x124
-#define rPMAC_TxMACHeader2		0x128
-#define rPMAC_TxMACHeader3		0x12c
-#define rPMAC_TxMACHeader4		0x130
-#define rPMAC_TxMACHeader5		0x134
-#define rPMAC_TxDataType			0x138
-#define rPMAC_TxRandomSeed			0x13c
-#define rPMAC_CCKPLCPPreamble		0x140
-#define rPMAC_CCKPLCPHeader			0x144
-#define rPMAC_CCKCRC16				0x148
-#define rPMAC_OFDMRxCRC32OK		0x170
-#define rPMAC_OFDMRxCRC32Er		0x174
-#define rPMAC_OFDMRxParityEr			0x178
-#define rPMAC_OFDMRxCRC8Er		0x17c
-#define rPMAC_CCKCRxRC16Er			0x180
-#define rPMAC_CCKCRxRC32Er			0x184
-#define rPMAC_CCKCRxRC32OK			0x188
-#define rPMAC_TxStatus				0x18c
-
 /* page8 */
 #define rFPGA0_RFMOD				0x800  /* RF mode & CCK TxSC */
 #define rFPGA0_TxInfo				0x804
-- 
2.18.0

