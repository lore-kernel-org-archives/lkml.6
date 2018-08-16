Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAE7C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE941214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE941214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389103AbeHPKJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:09:00 -0400
Received: from mail.zhinst.com ([212.126.164.102]:55938 "EHLO mail.zhinst.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbeHPKJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:09:00 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Aug 2018 06:08:59 EDT
Received: from ziws08.zhinst.com ([10.42.0.7])
        by mail.zhinst.com (Kerio Connect 9.2.7 patch 2) with ESMTP;
        Thu, 16 Aug 2018 09:05:18 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Ley Foon Tan <lftan@altera.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        nios2-dev@lists.rocketboards.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nios2: kconfig: remove duplicate DEBUG_STACK_USAGE symbol defintions
Date:   Thu, 16 Aug 2018 09:05:18 +0200
Message-Id: <20180816070518.10441-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.18.0.130.g98da2f6b3e4a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DEBUG_STACK_USAGE is already defined in lib/Kconfig.debug

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/nios2/Kconfig.debug | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/nios2/Kconfig.debug b/arch/nios2/Kconfig.debug
index 7a49f0d28d14..f1da8a7b17ff 100644
--- a/arch/nios2/Kconfig.debug
+++ b/arch/nios2/Kconfig.debug
@@ -3,15 +3,6 @@
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
 
-config DEBUG_STACK_USAGE
-	bool "Enable stack utilization instrumentation"
-	depends on DEBUG_KERNEL
-	help
-	  Enables the display of the minimum amount of free stack which each
-	  task has ever had available in the sysrq-T and sysrq-P debug output.
-
-	  This option will slow down process creation somewhat.
-
 config EARLY_PRINTK
 	bool "Activate early kernel debugging"
 	default y
-- 
2.18.0.130.g98da2f6b3e4a


