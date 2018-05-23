Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932381AbeEWJ4r (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:56:47 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36615 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932315AbeEWJ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:56:37 -0400
X-Google-Smtp-Source: AB8JxZr9UMFZ5vyadxrsxjxE941czDTYtpSicvEIS4hZx08aaOt295qEu8dsZgoqKByl1o8U15UExw==
From: Esben Haabendal <esben.haabendal@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Esben Haabendal <eha@deif.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm: dts: ls1021a: Enable I2C DMA support
Date: Wed, 23 May 2018 11:56:23 +0200
Message-Id: <20180523095623.3347-5-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523095623.3347-1-esben.haabendal@gmail.com>
References: <20180523095623.3347-1-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

Gives substantial performance improvement for transfers larger than 16
bytes (DMA_THRESHOLD).  Smaller transfers are unaffected.

Signed-off-by: Esben Haabendal <eha@deif.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c55d479971cc..1e5640701c65 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -363,6 +363,8 @@
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen 4 1>;
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 39>, <&edma0 1 38>;
 			status = "disabled";
 		};
 
@@ -374,6 +376,8 @@
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen 4 1>;
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 37>, <&edma0 1 36>;
 			status = "disabled";
 		};
 
@@ -385,6 +389,8 @@
 			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen 4 1>;
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 35>, <&edma0 1 34>;
 			status = "disabled";
 		};
 
-- 
2.17.0
