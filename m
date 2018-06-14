Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 337ACC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6008208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6008208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964901AbeFNLDE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:03:04 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:60513 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S964851AbeFNLDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:03:02 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie2.idc.renesas.com with ESMTP; 14 Jun 2018 20:03:00 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id 2B7EB752F5;
        Thu, 14 Jun 2018 20:03:00 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,222,1526310000"; 
   d="scan'208";a="282525642"
Received: from unknown (HELO be1yocto.ree.adwin.renesas.com) ([172.29.43.62])
  by relmlii1.idc.renesas.com with ESMTP; 14 Jun 2018 20:02:56 +0900
From:   Michel Pollet <michel.pollet@bp.renesas.com>
To:     linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>
Cc:     phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 4/5] ARM: dts: Renesas RZN1D-DB Board base file
Date:   Thu, 14 Jun 2018 11:56:33 +0100
Message-Id: <1528973829-25493-5-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528973829-25493-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1528973829-25493-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a base device tree file for the RZN1-DB board, with only the
basic support allowing the system to boot to a prompt. Only one UART is
used, with only a single CPU running.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile                  |  1 +
 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 37a3de7..c07f077 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -819,6 +819,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
 	r8a7793-gose.dtb \
 	r8a7794-alt.dtb \
 	r8a7794-silk.dtb \
+	r9a06g032-rzn1d400-db.dtb \
 	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rv1108-evb.dtb \
diff --git a/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts b/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
new file mode 100644
index 0000000..4e57ae2
--- /dev/null
+++ b/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the RZN1D-DB Board
+ *
+ * Copyright (C) 2018 Renesas Electronics Europe Limited
+ *
+ */
+
+/dts-v1/;
+
+#include "r9a06g032.dtsi"
+
+/ {
+	model = "RZN1D-DB Board";
+	compatible = "renesas,rzn1d400-db", "renesas,r9a06g032";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.7.4

