Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id w8oWLVzpGVv6EwAAmS7hNA
	; Fri, 08 Jun 2018 02:26:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A63516089E; Fri,  8 Jun 2018 02:26:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 39CCF601B4;
	Fri,  8 Jun 2018 02:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 39CCF601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932195AbeFHC0K (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 22:26:10 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:58560 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752626AbeFHCYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 22:24:30 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 406A82A333; Thu,  7 Jun 2018 22:24:29 -0400 (EDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <f760116a6fb63c15ac2545f52abde40ae2599e4c.1528423341.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1528423341.git.fthain@telegraphics.com.au>
References: <cover.1528423341.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 07/12] macintosh/via-pmu: Make CONFIG_PPC_PMAC Kconfig deps
 explicit
Date: Thu,  7 Jun 2018 22:24:29 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, CONFIG_ADB_PMU depends on CONFIG_PPC_PMAC. When this gets
relaxed to CONFIG_PPC_PMAC || CONFIG_MAC, those Kconfig symbols with
implicit deps on PPC_PMAC will need explicit deps. Add them now.
No functional change.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 9c6452b38c36..26abae4c899d 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -79,7 +79,7 @@ config ADB_PMU
 
 config ADB_PMU_LED
 	bool "Support for the Power/iBook front LED"
-	depends on ADB_PMU
+	depends on PPC_PMAC && ADB_PMU
 	select NEW_LEDS
 	select LEDS_CLASS
 	help
@@ -122,7 +122,7 @@ config PMAC_MEDIABAY
 
 config PMAC_BACKLIGHT
 	bool "Backlight control for LCD screens"
-	depends on ADB_PMU && FB = y && (BROKEN || !PPC64)
+	depends on PPC_PMAC && ADB_PMU && FB = y && (BROKEN || !PPC64)
 	select FB_BACKLIGHT
 	help
 	  Say Y here to enable Macintosh specific extensions of the generic
-- 
2.16.4
