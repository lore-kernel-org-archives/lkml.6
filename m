Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C54C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBEF20890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DBEF20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=isi.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732176AbeGaA2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:28:11 -0400
Received: from mail-d.ads.isi.edu ([128.9.180.199]:33300 "EHLO
        mail-d.ads.isi.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeGaA2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:28:09 -0400
X-IronPort-AV: E=Sophos;i="5.51,424,1526367600"; 
   d="scan'208";a="2623818"
Received: from guest228.east.isi.edu (HELO localhost) ([65.123.202.228])
  by mail-d.ads.isi.edu with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 15:50:58 -0700
From:   Alexei Colin <acolin@isi.edu>
To:     Alexandre Bounine <alex.bou9@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>
Cc:     Alexei Colin <acolin@isi.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Paul Walters <jwalters@isi.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] x86: factor out RapidIO Kconfig menu
Date:   Mon, 30 Jul 2018 18:50:30 -0400
Message-Id: <20180730225035.28365-3-acolin@isi.edu>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180730225035.28365-1-acolin@isi.edu>
References: <20180730225035.28365-1-acolin@isi.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The menu entry is now defined in the rapidio subtree.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Paul Walters <jwalters@isi.edu>
Cc: x86@kernel.org
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

