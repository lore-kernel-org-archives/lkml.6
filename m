Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81011C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 18:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5329820882
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 18:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbeLWSY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 13:24:28 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:53606 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbeLWSY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 13:24:28 -0500
Received: from localhost.localdomain (85-76-87-228-nat.elisa-mobile.fi [85.76.87.228])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id C94E9B00E0;
        Sun, 23 Dec 2018 20:24:24 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        linux-omap@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ARM: OMAP: DTS: N950/N9: fix onenand timings
Date:   Sun, 23 Dec 2018 20:24:13 +0200
Message-Id: <20181223182413.29123-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a758f50f10cf ("mtd: onenand: omap2: Configure driver from DT")
started using DT specified timings for GPMC, and as a result the
OneNAND stopped working on N950/N9 as we had wrong values in the DT.
Fix by updating the values to bootloader timings that have been tested
to be working on both Nokia N950 and N9.

Fixes: a758f50f10cf ("mtd: onenand: omap2: Configure driver from DT")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/boot/dts/omap3-n950-n9.dtsi | 42 ++++++++++++++++++----------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index 0d9b85317529..e142e6c70a59 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -370,6 +370,19 @@
 		compatible = "ti,omap2-onenand";
 		reg = <0 0 0x20000>;	/* CS0, offset 0, IO size 128K */
 
+		/*
+		 * These timings are based on CONFIG_OMAP_GPMC_DEBUG=y reported
+		 * bootloader set values when booted with v4.19 using both N950
+		 * and N9 devices (OneNAND Manufacturer: Samsung):
+		 *
+		 *   gpmc cs0 before gpmc_cs_program_settings:
+		 *   cs0 GPMC_CS_CONFIG1: 0xfd001202
+		 *   cs0 GPMC_CS_CONFIG2: 0x00181800
+		 *   cs0 GPMC_CS_CONFIG3: 0x00030300
+		 *   cs0 GPMC_CS_CONFIG4: 0x18001804
+		 *   cs0 GPMC_CS_CONFIG5: 0x03171d1d
+		 *   cs0 GPMC_CS_CONFIG6: 0x97080000
+		 */
 		gpmc,sync-read;
 		gpmc,sync-write;
 		gpmc,burst-length = <16>;
@@ -379,26 +392,27 @@
 		gpmc,device-width = <2>;
 		gpmc,mux-add-data = <2>;
 		gpmc,cs-on-ns = <0>;
-		gpmc,cs-rd-off-ns = <87>;
-		gpmc,cs-wr-off-ns = <87>;
+		gpmc,cs-rd-off-ns = <122>;
+		gpmc,cs-wr-off-ns = <122>;
 		gpmc,adv-on-ns = <0>;
-		gpmc,adv-rd-off-ns = <10>;
-		gpmc,adv-wr-off-ns = <10>;
-		gpmc,oe-on-ns = <15>;
-		gpmc,oe-off-ns = <87>;
+		gpmc,adv-rd-off-ns = <15>;
+		gpmc,adv-wr-off-ns = <15>;
+		gpmc,oe-on-ns = <20>;
+		gpmc,oe-off-ns = <122>;
 		gpmc,we-on-ns = <0>;
-		gpmc,we-off-ns = <87>;
-		gpmc,rd-cycle-ns = <112>;
-		gpmc,wr-cycle-ns = <112>;
-		gpmc,access-ns = <81>;
+		gpmc,we-off-ns = <122>;
+		gpmc,rd-cycle-ns = <148>;
+		gpmc,wr-cycle-ns = <148>;
+		gpmc,access-ns = <117>;
 		gpmc,page-burst-access-ns = <15>;
 		gpmc,bus-turnaround-ns = <0>;
 		gpmc,cycle2cycle-delay-ns = <0>;
 		gpmc,wait-monitoring-ns = <0>;
-		gpmc,clk-activation-ns = <5>;
-		gpmc,wr-data-mux-bus-ns = <30>;
-		gpmc,wr-access-ns = <81>;
-		gpmc,sync-clk-ps = <15000>;
+		gpmc,clk-activation-ns = <10>;
+		gpmc,wr-data-mux-bus-ns = <40>;
+		gpmc,wr-access-ns = <117>;
+
+		gpmc,sync-clk-ps = <15000>; /* TBC; Where this value came? */
 
 		/*
 		 * MTD partition table corresponding to Nokia's MeeGo 1.2
-- 
2.17.0

