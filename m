Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA20CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E3021522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrN6ojja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E3021522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733022AbeITFyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 01:54:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32966 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbeITFym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 01:54:42 -0400
Received: by mail-ed1-f65.google.com with SMTP id d8-v6so6382558edv.0;
        Wed, 19 Sep 2018 17:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Vog4lTzo21eb/OAjLxDy8xyaDP6vFPMB6wXFNZPDoMQ=;
        b=mrN6ojjanJFfs2viXYuEspBbO8X04PevUHQkf0u010ccGHNh3j96ssUzgYvdXwlXvR
         E+wsgmVDEDXcdNtbLxxENv1ehoJ/K7tZAhtJ76y3g64QBJ6wRw6Rl6dGoZ21yqWcdfb3
         7/5YDxTKJRIxqTeEaxgNV/kSmTfo8mgCTFzqRjpJ78+mL9g2fpRKcxK44/pALb67tk1y
         3ByKCaV+Q/kCItgE338csQ91BGq3zO7UYQvTlG5TXX0i7cnzYLjAIwD+9dwjTTE5zEdR
         De6Z7UcJjaqa9VbvaBLWOGIjS+e4eimQ9JmVrY67ukVpi/vyGvkSQ6XRauA9XxK2mBlH
         hLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vog4lTzo21eb/OAjLxDy8xyaDP6vFPMB6wXFNZPDoMQ=;
        b=pi929QjXf6OXP+Y19xQRrUQCEz57zVwIi6JJdPfmkU3nXmixVXpL/zzVZxpfrlPiE7
         brHuB2FO2VDNspOmcYNv2poYUkefRnQqxq1hsTiYqT+MaEMyT3Ua06u55jGYcY+cg9d6
         F5kdmSiF/8i9ovKpy88ZyEL5d96bzoX3gVVsHnjebQhB3DxaCDFNQAel4VwfhyS1KCF3
         86auTqcHhrbxgrAWd9ROQdmVSEByyWGcskCDP1sZu/R1veCVwR4L0bulmGx7rqYmC7kS
         tFzMxPlgtbHaJYM1Ek/cvMxA+LOl/4afYYRhrU/yH89f+gtANbg7LZR+FgN+kSruTt2l
         WP4Q==
X-Gm-Message-State: APzg51CeG1pM3LRzeTl19f64QBsvF51tq6r8WXzCVjpBNCcJ6tkz0wO9
        Ut2CjBNSNq+oUhFmmD0ntxs=
X-Google-Smtp-Source: ANB0VdZlFesRMGsVg0nq4QQWkKOjB3hdgBso+muYGE3UdtNtk04okhEj+ADN4SpvbqTkT7ir3U3sdg==
X-Received: by 2002:a50:871c:: with SMTP id i28-v6mr537997edb.13.1537402456451;
        Wed, 19 Sep 2018 17:14:16 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id x44-v6sm124853edd.1.2018.09.19.17.14.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 17:14:15 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: BCM63XX: Fix incorrect interrupt specifiers
Date:   Wed, 19 Sep 2018 17:14:01 -0700
Message-Id: <20180920001402.1585-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of our interrupts were incorrectly specified, fix both the PPI
and SPI interrupts to be correct.

Fixes: b5762cacc411 ("ARM: bcm63138: add NAND DT support")
Fixes: 46d4bca0445a ("ARM: BCM63XX: add BCM63138 minimal Device Tree")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm63138.dtsi | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/bcm63138.dtsi b/arch/arm/boot/dts/bcm63138.dtsi
index 43ee992ccdcf..6df61518776f 100644
--- a/arch/arm/boot/dts/bcm63138.dtsi
+++ b/arch/arm/boot/dts/bcm63138.dtsi
@@ -106,21 +106,23 @@
 		global_timer: timer@1e200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x1e200 0x20>;
-			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 11 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&axi_clk>;
 		};
 
 		local_timer: local-timer@1e600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x1e600 0x20>;
-			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
+						  IRQ_TYPE_EDGE_RISING)>;
 			clocks = <&axi_clk>;
 		};
 
 		twd_watchdog: watchdog@1e620 {
 			compatible = "arm,cortex-a9-twd-wdt";
 			reg = <0x1e620 0x20>;
-			interrupts = <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
+						  IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
 		armpll: armpll {
@@ -158,7 +160,7 @@
 		serial0: serial@600 {
 			compatible = "brcm,bcm6345-uart";
 			reg = <0x600 0x1b>;
-			interrupts = <GIC_SPI 32 0>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&periph_clk>;
 			clock-names = "periph";
 			status = "disabled";
@@ -167,7 +169,7 @@
 		serial1: serial@620 {
 			compatible = "brcm,bcm6345-uart";
 			reg = <0x620 0x1b>;
-			interrupts = <GIC_SPI 33 0>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&periph_clk>;
 			clock-names = "periph";
 			status = "disabled";
@@ -180,7 +182,7 @@
 			reg = <0x2000 0x600>, <0xf0 0x10>;
 			reg-names = "nand", "nand-int-base";
 			status = "disabled";
-			interrupts = <GIC_SPI 38 0>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "nand";
 		};
 
-- 
2.17.1

