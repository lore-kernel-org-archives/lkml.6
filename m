Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF46C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396BA2542D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396BA2542D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964963AbeGBIWj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:22:39 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48836 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933637AbeGBIVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:21:23 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 389DB293A4; Mon,  2 Jul 2018 04:21:19 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <5fd5279d30eeb82c753985aa672c71bd37a062fa.1530519301.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1530519301.git.fthain@telegraphics.com.au>
References: <cover.1530519301.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v4 07/11] macintosh/via-pmu: Explicitly specify
 CONFIG_PPC_PMAC dependencies
Date:   Mon,  2 Jul 2018 04:21:19 -0400 (EDT)
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

