Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752817AbeB0KXe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:23:34 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39831 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752674AbeB0KXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:23:32 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org, horms@verge.net.au,
        sergei.shtylyov@cogentembedded.com, magnus.damm@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/10] arm64: dts: renesas: draak: Override EtherAVB phy-mode
Date: Tue, 27 Feb 2018 11:22:47 +0100
Message-Id: <1519726974-23160-4-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519726974-23160-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519726974-23160-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the PHY interface installed on the Draak board, provides TX
channel delay, make the "phy-mode" property a board-specific one, meant
to override the one specified in the SoC DTSI.

Follow up patches will reset the r8a77995 SoC DTSI to use "rgmii" mode
and let the board file override that.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index af07da2..af18a09 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -108,6 +108,7 @@
 	pinctrl-names = "default";
 	renesas,no-ether-link;
 	phy-handle = <&phy0>;
+	phy-mode = "rgmii-txid";
 	status = "okay";
 
 	phy0: ethernet-phy@0 {
-- 
2.7.4
