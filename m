Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030516AbeBNOLN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:11:13 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45703 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030308AbeBNOKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:10:30 -0500
X-Google-Smtp-Source: AH8x226JKuV4u83zWvCyAQxT3HnRkceXzM24YkbCz119RZ+LDnW5toLi0lS3xR4zKJs5ITgI2QGl6g==
From: Philipp Rossak <embed3d@gmail.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v2 1/2] arm: dts: sun6i: a31s: bpi-m2: improve pmic properties
Date: Wed, 14 Feb 2018 15:10:24 +0100
Message-Id: <20180214141025.22171-2-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180214141025.22171-1-embed3d@gmail.com>
References: <20180214141025.22171-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eldoin is supplied from the dcdc1 regulator. The N_VBUSEN pin is
connected to an external power regulator (SY6280AAC).
With this commit we update the pmic binding properties to support
those features.

Fixes: 7daa21370075 ("ARM: dts: sunxi: Add regulators for Sinovoip
BPI-M2")

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
index 51e6f1d21c32..fb34f32502cf 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -163,6 +163,8 @@
 		reg = <0x68>;
 		interrupt-parent = <&nmi_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		eldoin-supply = <&reg_dcdc1>;
+		x-powers,drive-vbus-en;
 	};
 };
 
-- 
2.11.0
