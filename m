Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9822FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709A721841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeLRQIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:08:12 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36488 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbeLRQIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:08:10 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 316FD20A95; Tue, 18 Dec 2018 17:08:08 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 05A8C207D9;
        Tue, 18 Dec 2018 17:07:58 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [RESEND PATCH v2 1/3] arm64: dts: fsl: use a generic node name for m25p80 flashes
Date:   Tue, 18 Dec 2018 17:07:46 +0100
Message-Id: <20181218160750.6766-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a generic node name for the m25p80 flashes on ls1043 and ls1046 boards.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index dff3d648172e..8468e652a262 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -138,7 +138,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	qflash0: s25fl128s@0 {
+	qflash0: flash@0 {
 		compatible = "spansion,m25p80";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
index e58a8ca1386c..51a518b64053 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -167,7 +167,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	qflash0: s25fl128s@0 {
+	qflash0: flash@0 {
 		compatible = "spansion,m25p80";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
index a59b48203688..1e3d570412d2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
@@ -103,7 +103,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	qflash0: s25fs512s@0 {
+	qflash0: flash@0 {
 		compatible = "spansion,m25p80";
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -111,7 +111,7 @@
 		reg = <0>;
 	};
 
-	qflash1: s25fs512s@1 {
+	qflash1: flash@1 {
 		compatible = "spansion,m25p80";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.20.0

