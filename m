Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753364AbeDQMxQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:53:16 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:57444 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752087AbeDQMxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:53:14 -0400
X-IronPort-AV: E=Sophos;i="5.48,463,1517842800";
   d="scan'208";a="277046845"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Kevin Hilman <khilman@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Carlo Caione <carlo@endlessm.com>,
        Frank Rowand <frank.rowand@sony.com>, Juri Lelli <juri.lelli@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/3] ARM: dts: Renesas RZ/N1D SMP enable method
Date: Tue, 17 Apr 2018 13:48:02 +0100
Message-Id: <1523969291-41756-4-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523969291-41756-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1523969291-41756-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a special enable method for the second CA7 of the Renesas RZ/N1D
(R9A06G032), as well as the default value for the "cpu-release-addr"
property.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 23c56d7..170376d 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -33,6 +33,8 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <1>;
+			enable-method = "renesas,r9a06g032-smp";
+			cpu-release-addr = <0x4000c204>;
 		};
 	};
 
-- 
2.7.4
