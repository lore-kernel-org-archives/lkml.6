Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BB1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14635208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14635208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=isi.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbeGaQKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:10:44 -0400
Received: from mail-d.ads.isi.edu ([128.9.180.199]:62437 "EHLO
        mail-d.ads.isi.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732222AbeGaQKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:10:44 -0400
X-IronPort-AV: E=Sophos;i="5.51,427,1526367600"; 
   d="scan'208";a="2634415"
Received: from guest228.east.isi.edu (HELO localhost) ([65.123.202.228])
  by mail-d.ads.isi.edu with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2018 07:30:08 -0700
From:   Alexei Colin <acolin@isi.edu>
To:     Alexandre Bounine <alex.bou9@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>
Cc:     Alexei Colin <acolin@isi.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        John Paul Walters <jwalters@isi.edu>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/6] x86: factor out RapidIO Kconfig menu
Date:   Tue, 31 Jul 2018 10:29:50 -0400
Message-Id: <20180731142954.30345-3-acolin@isi.edu>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731142954.30345-1-acolin@isi.edu>
References: <20180731142954.30345-1-acolin@isi.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The menu entry is now defined in the rapidio subtree.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: John Paul Walters <jwalters@isi.edu>
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mips@linux-mips.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexei Colin <acolin@isi.edu>
---
 arch/x86/Kconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 27fce7e84357..6f057000e486 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2828,14 +2828,6 @@ config AMD_NB
 
 source "drivers/pcmcia/Kconfig"
 
-config RAPIDIO
-	tristate "RapidIO support"
-	depends on PCI
-	default n
-	help
-	  If enabled this option will include drivers and the core
-	  infrastructure code to support RapidIO interconnect devices.
-
 source "drivers/rapidio/Kconfig"
 
 config X86_SYSFB
-- 
2.18.0

