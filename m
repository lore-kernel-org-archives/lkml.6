Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeDFNIp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:08:45 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42821 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbeDFNIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:08:41 -0400
X-Originating-IP: 2.224.242.101
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        laurent.pinchart@ideasonboard.com, niklas.soderlund@ragnatech.se,
        sergei.shtylyov@cogentembedded.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] arm64: dts: renesas: eagle: Enable DU
Date: Fri,  6 Apr 2018 15:08:10 +0200
Message-Id: <1523020092-25540-6-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523020092-25540-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1523020092-25540-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable DU for Renesas R-Car V3M Eagle board.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
index 3c5f598..144b847 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
@@ -76,6 +76,11 @@
 		function = "i2c0";
 	};
 
+	du_pins: du {
+		groups = "du_rgb666", "du_sync", "du_oddf", "du_clk_out";
+		function = "du";
+	};
+
 	scif0_pins: scif0 {
 		groups = "scif0_data";
 		function = "scif0";
@@ -93,3 +98,9 @@
 
 	status = "okay";
 };
+
+&du {
+	pinctrl-0 = <&du_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
2.7.4
