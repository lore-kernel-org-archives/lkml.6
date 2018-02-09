Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbeBIRwp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 12:52:45 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35843 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbeBIRwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:52:42 -0500
X-Google-Smtp-Source: AH8x224VOK9OuJ1wGcrzMSEx4Zwxd+WHjQxTyfpzJvKSPRvvjaRpHss2jfkKMY2nsxvJVV3DeeGfwg==
From: Philipp Rossak <embed3d@gmail.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH 2/3] arm: dts: sun6i: a31s: bpi-m2: improve pmic properties
Date: Fri,  9 Feb 2018 18:52:35 +0100
Message-Id: <20180209175236.21215-3-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180209175236.21215-1-embed3d@gmail.com>
References: <20180209175236.21215-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eldoin is supplied from the dcdc1 regulator. The N_VBUSEN pin is
connected to an external power regulator (SY6280AAC).
With this commit we update the pmic binding properties to support
those features.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
index a8d86211c8f3..556528386858 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -162,6 +162,8 @@
 		reg = <0x68>;
 		interrupt-parent = <&nmi_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		eldoin-supply = <&reg_dcdc1>;
+		x-powers,drive-vbus-en;
 	};
 };
 
-- 
2.11.0
