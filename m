Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CCFECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7A42064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7A42064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbeGQO4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:56:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42157 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731607AbeGQO4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:56:25 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4418220765; Tue, 17 Jul 2018 16:23:30 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1C218207B4;
        Tue, 17 Jul 2018 16:23:20 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5/5] mips: dts: mscc: enable spi and NOR flash support on ocelot PCB123
Date:   Tue, 17 Jul 2018 16:23:14 +0200
Message-Id: <20180717142314.32337-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ocelot PCB123 has a SPI NOR connected on its SPI bus.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
index 4ccd65379059..2266027759f9 100644
--- a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
+++ b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
@@ -26,6 +26,16 @@
 	status = "okay";
 };
 
+&spi {
+	status = "okay";
+
+	flash@0 {
+		compatible = "macronix,mx25l25635f", "jedec,spi-nor";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
+};
+
 &mdio0 {
 	status = "okay";
 };
-- 
2.18.0

