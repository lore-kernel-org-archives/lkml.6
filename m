Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeBWNls (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:41:48 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52691 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbeBWNlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:41:45 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: arnd@arndb.de, geert@linux-m68k.org, horms@verge.net.au,
        magnus.damm@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] arm64: dts: renesas: r8a77965: Add #interrupt-cells property
Date: Fri, 23 Feb 2018 14:40:58 +0100
Message-Id: <1519393259-26108-7-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519393259-26108-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519393259-26108-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "#interrupt-cells" property and "interrupt-controller" label to
"interrupt-controller@e61c0000" device node.

This silences the following DTC compiler warnings:
Warning (interrupts_property): Missing interrupt-controller or
interrupt-map property in /soc/interrupt-controller@e61c0000
Warning (interrupts_property): Missing #interrupt-cells in
interrupt-parent /soc/interrupt-controller@e61c000

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 5dff176..0118956 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -316,6 +316,8 @@
 		};
 
 		intc_ex: interrupt-controller@e61c0000 {
+			#interrupt-cells = <2>;
+			interrupt-controller;
 			reg = <0 0xe61c0000 0 0x200>;
 			/* placeholder */
 		};
-- 
2.7.4
