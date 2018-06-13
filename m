Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 30E44C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4903208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4903208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935358AbeFMKjN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:39:13 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47976 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935235AbeFMKiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:38:04 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id EF435285CD; Wed, 13 Jun 2018 06:38:01 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <f760116a6fb63c15ac2545f52abde40ae2599e4c.1528885172.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1528885172.git.fthain@telegraphics.com.au>
References: <cover.1528885172.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v3 07/12] macintosh/via-pmu: Make CONFIG_PPC_PMAC Kconfig deps
 explicit
Date:   Wed, 13 Jun 2018 06:38:01 -0400 (EDT)
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

