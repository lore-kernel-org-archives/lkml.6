Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52788C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094AA2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094AA2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbeHaTMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:12:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46555 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727599AbeHaTMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:12:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3B10020828; Fri, 31 Aug 2018 17:04:48 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0E5532071E;
        Fri, 31 Aug 2018 17:04:38 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] MIPS: generic: Add Network, SPI and I2C to ocelot_defconfig
Date:   Fri, 31 Aug 2018 17:04:34 +0200
Message-Id: <20180831150434.25050-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the integrated switch, and the SPI and I2C controller found
on MSCC Ocelot.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/configs/generic/board-ocelot.config | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/mips/configs/generic/board-ocelot.config b/arch/mips/configs/generic/board-ocelot.config
index aa815761d85e..f607888d2483 100644
--- a/arch/mips/configs/generic/board-ocelot.config
+++ b/arch/mips/configs/generic/board-ocelot.config
@@ -18,17 +18,25 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 
-CONFIG_GPIO_SYSFS=y
+CONFIG_NETDEVICES=y
+CONFIG_MSCC_OCELOT_SWITCH=y
+CONFIG_MSCC_OCELOT_SWITCH_OCELOT=y
+CONFIG_MDIO_MSCC_MIIM=y
+CONFIG_MICROSEMI_PHY=y
 
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MUX=y
+CONFIG_I2C_DESIGNWARE_PLATFORM=y
 
 CONFIG_SPI=y
 CONFIG_SPI_BITBANG=y
 CONFIG_SPI_DESIGNWARE=y
+CONFIG_SPI_DW_MMIO=y
 CONFIG_SPI_SPIDEV=y
 
+CONFIG_GPIO_SYSFS=y
+
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_OCELOT_RESET=y
 
-- 
2.19.0.rc1

