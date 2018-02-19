Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeBSIUH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 03:20:07 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:54575 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbeBSITF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 03:19:05 -0500
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clabbe.montjoie@gmail.com,
        thomas.petazzoni@bootlin.com, mylene.josserand@bootlin.com,
        quentin.schulz@bootlin.com
Subject: [PATCH v3 4/7] ARM: dts: sun8i: Add R_CPUCFG device node for the A83T dtsi
Date: Mon, 19 Feb 2018 09:18:34 +0100
Message-Id: <20180219081837.15482-5-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180219081837.15482-1-mylene.josserand@bootlin.com>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R_CPUCFG is a collection of registers needed for SMP bringup
on clusters and cluster's reset.
For the moment, documentation about this register is found in
Allwinner's code only.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 3e7317ec3e43..7ae631fc04d5 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -714,6 +714,11 @@
 			#reset-cells = <1>;
 		};
 
+		r_cpucfg@1f01c00 {
+			compatible = "allwinner,sun8i-a83t-r-cpucfg";
+			reg = <0x1f01c00 0x100>;
+		};
+
 		r_pio: pinctrl@1f02c00 {
 			compatible = "allwinner,sun8i-a83t-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
-- 
2.11.0
