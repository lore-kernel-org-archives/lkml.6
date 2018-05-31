Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbeEaWRH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 18:17:07 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:37564 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeEaWQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 18:16:42 -0400
From: Stefan Agner <stefan@agner.ch>
To: boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com
Cc: dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, mirza.krak@gmail.com,
        stefan@agner.ch, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] ARM: dts: tegra: add Tegra20 NAND flash controller node
Date: Fri,  1 Jun 2018 00:16:36 +0200
Message-Id: <20180531221637.6017-6-stefan@agner.ch>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180531221637.6017-1-stefan@agner.ch>
References: <20180531221637.6017-1-stefan@agner.ch>
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[23];
         BAYES_HAM(-3.00)[100.00%];
         RCVD_TLS_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:13030, ipnet:37.17.238.0/23, country:CH];
         TO_DN_NONE(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <dev@lynxeye.de>

Add basic controller device tree node to be extended by
individual boards. Use the assigned-clocks mechanism to set
NDFLASH clock to a sensible default rate of 150MHz.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/tegra20.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 0a7136462a1a..64911903ef99 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -425,6 +425,21 @@
 		status = "disabled";
 	};
 
+	nand: nand@70008000 {
+		compatible = "nvidia,tegra20-nand";
+		reg = <0x70008000 0x100>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA20_CLK_NDFLASH>;
+		clock-names = "nand";
+		resets = <&tegra_car 13>;
+		reset-names = "nand";
+		status = "disabled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		assigned-clocks = <&tegra_car TEGRA20_CLK_NDFLASH>;
+		assigned-clock-rates = <150000000>;
+	};
+
 	pwm: pwm@7000a000 {
 		compatible = "nvidia,tegra20-pwm";
 		reg = <0x7000a000 0x100>;
-- 
2.17.0
