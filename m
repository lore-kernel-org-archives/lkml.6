Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A16C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4AF223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4AF223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387968AbeKOVcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:32:23 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:38234 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbeKOVcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 16:32:23 -0500
Received: from ramsan.of.borg ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id 0BQu1z00W3XaVaC01BQurE; Thu, 15 Nov 2018 12:24:55 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1gNFlW-00087u-SP; Thu, 15 Nov 2018 12:24:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gNEUm-0004gB-34; Thu, 15 Nov 2018 11:03:32 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: Correct meaning of SCU in HAVE_ARM_SCU help txt
Date:   Thu, 15 Nov 2018 11:03:30 +0100
Message-Id: <20181115100330.17943-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the ARM Cortex-A5 and Cortex-A9 Technical Reference
Manuals, SCU stands for "Snoop Control Unit".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 91be74d8df658ccd..1b7c73facaed9849 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1347,7 +1347,7 @@ config SCHED_SMT
 config HAVE_ARM_SCU
 	bool
 	help
-	  This option enables support for the ARM system coherency unit
+	  This option enables support for the ARM snoop control unit
 
 config HAVE_ARM_ARCH_TIMER
 	bool "Architected timer support"
-- 
2.17.1

