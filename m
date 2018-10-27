Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF31C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 22:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD9F20848
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 22:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jordan-borgner.de header.i=@jordan-borgner.de header.b="GqQrcrS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD9F20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jordan-borgner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbeJ1HPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 03:15:22 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:13486 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbeJ1HPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 03:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1540679570;
        s=strato-dkim-0002; d=jordan-borgner.de;
        h=Message-ID:Subject:Cc:To:From:Date:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=LSo0IHIKdmvgDH2IGoyKPA94pTgExEunSp3hhECrTKg=;
        b=GqQrcrS3D2eFUns497/9W4Gp0CeBdZ98S4Gv9CpBENluoUR2mfSmc/p3okN3scoTIW
        f6tMLY1cs/udyr1e+HupIsTznRvlL0imQZhYRDZkpTP9vwNcLcXzlWpFmeElotPHzQ0l
        TUDFTZkdSQqigra9cID5fSuR6CS5h45Htl231tBvhTf9oIw3Fk23UeUvoQ9pcRJ2Yu/s
        jmA1NAMd75aA1NGWRDJpqi412DDOLJ1gUqQKZBYQFXE+AGi+uFEZIvfezP40iISactYT
        QTYG1vTjje8mf+pGdlPhE1jDhxaIxVq4RiqH7Y3iX69rCqye+uZLH5xKvLfnMs8nr1lE
        tNLg==
X-RZG-AUTH: ":IW0NeWCidO14P1liib3FUweRdVVCz7ay1c0SPzCKsLZUvHozh80V6gGoQeGJaantMcUcRJe5mIbtCrgHkxjLdFkZv9oPPumBhWbcpcqg9jlP4A=="
X-RZG-CLASS-ID: mo00
Received: from JordanDesktop
        by smtp.strato.de (RZmta 44.3 AUTH)
        with ESMTPSA id z07cbcu9RMWWsJT
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 28 Oct 2018 00:32:32 +0200 (CEST)
Date:   Sat, 27 Oct 2018 23:32:31 +0100
From:   Jordan Borgner <mail@jordan-borgner.de>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: [PATCH] arch/x86/boot/memory.c: Touched up coding-style issues
Message-ID: <20181027223231.pyigrae7mhl2xil2@JordanDesktop>
MIME-Version: 1.0
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-arch-x86-boot-memory.c-Fixed-coding-style-issues.patch"
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added missing parentheses to sizeof() function in detect_memory_e820().

Removed unnecessary braces in detect_memory_e801().

Replaced three if-statements with a ternary if-statement and 
removed an unnecessary integer variable in detect_memory().

This is my first patch I hope it is okay.

Signed-off-by: Jordan Borgner <mail@jordan-borgner.de>
---
 linux-4.19/arch/x86/boot/memory.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/linux-4.19/arch/x86/boot/memory.c b/linux-4.19/arch/x86/boot/memory.c
index d9c28c8..a6124af 100644
--- a/linux-4.19/arch/x86/boot/memory.c
+++ b/linux-4.19/arch/x86/boot/memory.c
@@ -26,7 +26,7 @@ static int detect_memory_e820(void)
 
 	initregs(&ireg);
 	ireg.ax  = 0xe820;
-	ireg.cx  = sizeof buf;
+	ireg.cx  = sizeof(buf);
 	ireg.edx = SMAP;
 	ireg.di  = (size_t)&buf;
 
@@ -88,11 +88,11 @@ static int detect_memory_e801(void)
 		oreg.bx = oreg.dx;
 	}
 
-	if (oreg.ax > 15*1024) {
+	if (oreg.ax > 15*1024)
 		return -1;	/* Bogus! */
-	} else if (oreg.ax == 15*1024) {
+	else if (oreg.ax == 15*1024)
 		boot_params.alt_mem_k = (oreg.bx << 6) + oreg.ax;
-	} else {
+	else
 		/*
 		 * This ignores memory above 16MB if we have a memory
 		 * hole there.  If someone actually finds a machine
@@ -101,7 +101,6 @@ static int detect_memory_e801(void)
 		 * map.
 		 */
 		boot_params.alt_mem_k = oreg.ax;
-	}
 
 	return 0;
 }
@@ -121,16 +120,7 @@ static int detect_memory_88(void)
 
 int detect_memory(void)
 {
-	int err = -1;
-
-	if (detect_memory_e820() > 0)
-		err = 0;
-
-	if (!detect_memory_e801())
-		err = 0;
-
-	if (!detect_memory_88())
-		err = 0;
-
-	return err;
+	return (detect_memory_e820() > 0 ||
+		!detect_memory_e801()    ||
+		!detect_memory_88()) ? 0 : -1;
 }
-- 
2.11.0

