Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DA2C28CF6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 01:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92DD20894
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 01:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zbIi7B+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92DD20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbeG2DHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 23:07:17 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:43135 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731693AbeG2DHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 23:07:16 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w6T1cSvf018756;
        Sun, 29 Jul 2018 10:38:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w6T1cSvf018756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532828309;
        bh=Lqv9ZVFTYuRmzqFp0qYHSrBBrLT2rYs14kwg8dFCKUg=;
        h=From:To:Cc:Subject:Date:From;
        b=zbIi7B+3IcBHFHcTWm8uO+5U6ZxjqTxyELmrg8zf5YQsgZT1X4WvbZsbUwhDMs3TE
         0BXusS1h+SZ8Vb516K0KGw4XQyYz6PPCzdSETWZIPwty4r4OQ4+5lhmYjGSMDgYj7S
         INbua1bjjCCG6C5BbZpHxEHd2QM4KTdf4PiRYX+EQbEeyFPATgCW+tiAas2qS06Frz
         ecWShGj+PNGPvHQWi0ezEFpl/pLF2uF+Ll2KZ0nG4VClHG57pBdEsH0btyzhb90ubI
         ww85D3nCDsqRTs3qpa399gb0GDOZXjb0tnIKB8Q6BOenR5CKi2CYIMPwJP9DS24hw/
         7L1Yw+zdA8lBg==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] microblaze: delete wrong comment about machine_early_init
Date:   Sun, 29 Jul 2018 10:38:13 +0900
Message-Id: <1532828293-20074-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

machine_early_init is defined in arch/microblaze/kernel/setup.c
I do not see mach-* directory for MicroBlaze.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/microblaze/kernel/head.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/microblaze/kernel/head.S b/arch/microblaze/kernel/head.S
index 4655ff3..f264fdc 100644
--- a/arch/microblaze/kernel/head.S
+++ b/arch/microblaze/kernel/head.S
@@ -341,11 +341,6 @@ start_here:
 	/* Initialize r31 with current task address */
 	addik	r31, r0, init_task
 
-	/*
-	 * Call platform dependent initialize function.
-	 * Please see $(ARCH)/mach-$(SUBARCH)/setup.c for
-	 * the function.
-	 */
 	addik	r11, r0, machine_early_init
 	brald	r15, r11
 	nop
-- 
2.7.4

