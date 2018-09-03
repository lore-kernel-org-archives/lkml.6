Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62130C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FA520843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26FA520843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeICS3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:29:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37561 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbeICS3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:29:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3DFE0208AE; Mon,  3 Sep 2018 16:08:43 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0ECC820618;
        Mon,  3 Sep 2018 16:08:43 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 1/5] arm64: dts: fsl: use a generic node name for m25p80 flashes
Date:   Mon,  3 Sep 2018 16:08:36 +0200
Message-Id: <20180903140840.23648-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0.rc1
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
index c7b8d2c009cd..af972e91d6bc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -136,7 +136,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	qflash0: s25fl128s@0 {
+	qflash0: flash@0 {
 		compatible = "spansion,m25p80";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
index e69306e6b0b1..219068220b84 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -165,7 +165,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	qflash0: s25fl128s@0 {
+	qflash0: flash@0 {
 		compatible = "spansion,m25p80";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
index 440e111651d5..df676b30357b 100644
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
2.19.0.rc1

