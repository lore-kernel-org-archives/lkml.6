Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81864C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4687220880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4687220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbeILVQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:16:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60177 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbeILVQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:16:39 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AEE75208DC; Wed, 12 Sep 2018 18:11:26 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3DF4C2071D;
        Wed, 12 Sep 2018 18:11:26 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v6 6/7] ARM: configs: at91: use new TCB timer driver
Date:   Wed, 12 Sep 2018 18:11:21 +0200
Message-Id: <20180912161122.7717-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0.rc2
In-Reply-To: <20180912161122.7717-1-alexandre.belloni@bootlin.com>
References: <20180912161122.7717-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unselecting ATMEL_TCLIB switches the TCB timer driver from tcb_clksrc to
timer-atmel-tcb.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 -
 arch/arm/configs/sama5_defconfig   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index e4b1be66b3f5..09f262e59fef 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -64,7 +64,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=4
 CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_ATMEL_TCLIB=y
 CONFIG_ATMEL_SSC=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 2080025556b5..f2bbc6339ca6 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -75,7 +75,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=4
 CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_ATMEL_TCLIB=y
 CONFIG_ATMEL_SSC=y
 CONFIG_EEPROM_AT24=y
 CONFIG_SCSI=y
-- 
2.19.0.rc2

