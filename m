Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EF8C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9E72089B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9E72089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbeGZR6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:58:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38647 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730030AbeGZR6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:58:46 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1BE0520908; Thu, 26 Jul 2018 18:41:07 +0200 (CEST)
Received: from localhost (unknown [88.128.80.18])
        by mail.bootlin.com (Postfix) with ESMTPSA id D526B20893;
        Thu, 26 Jul 2018 18:40:56 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] MIPS: TXx9: remove useless RTC definitions
Date:   Thu, 26 Jul 2018 18:40:54 +0200
Message-Id: <20180726164054.9092-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC definitions were moved to the driver, remove them from the platform
header.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/include/asm/txx9/tx4939.h | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/arch/mips/include/asm/txx9/tx4939.h b/arch/mips/include/asm/txx9/tx4939.h
index 6d667087f2aa..f173bef405d3 100644
--- a/arch/mips/include/asm/txx9/tx4939.h
+++ b/arch/mips/include/asm/txx9/tx4939.h
@@ -101,13 +101,6 @@ struct tx4939_irc_reg {
 	struct tx4939_le_reg maskext;
 };
 
-struct tx4939_rtc_reg {
-	__u32 ctl;
-	__u32 adr;
-	__u32 dat;
-	__u32 tbc;
-};
-
 struct tx4939_crypto_reg {
 	struct tx4939_le_reg csr;
 	struct tx4939_le_reg idesptr;
@@ -369,26 +362,6 @@ struct tx4939_vpc_desc {
 #define TX4939_CLKCTR_SIO0RST	0x00000002
 #define TX4939_CLKCTR_CYPRST	0x00000001
 
-/*
- * RTC
- */
-#define TX4939_RTCCTL_ALME	0x00000080
-#define TX4939_RTCCTL_ALMD	0x00000040
-#define TX4939_RTCCTL_BUSY	0x00000020
-
-#define TX4939_RTCCTL_COMMAND	0x00000007
-#define TX4939_RTCCTL_COMMAND_NOP	0x00000000
-#define TX4939_RTCCTL_COMMAND_GETTIME	0x00000001
-#define TX4939_RTCCTL_COMMAND_SETTIME	0x00000002
-#define TX4939_RTCCTL_COMMAND_GETALARM	0x00000003
-#define TX4939_RTCCTL_COMMAND_SETALARM	0x00000004
-
-#define TX4939_RTCTBC_PM	0x00000080
-#define TX4939_RTCTBC_COMP	0x0000007f
-
-#define TX4939_RTC_REG_RAMSIZE	0x00000100
-#define TX4939_RTC_REG_RWBSIZE	0x00000006
-
 /*
  * CRYPTO
  */
-- 
2.18.0

