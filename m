Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08099C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4332089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4332089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbeJATsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:48:53 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:32264 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728979AbeJATsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:48:52 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie2.idc.renesas.com with ESMTP; 01 Oct 2018 22:11:05 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id D95B081C16;
        Mon,  1 Oct 2018 22:11:05 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.54,327,1534777200"; 
   d="scan'208";a="292407217"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii1.idc.renesas.com with ESMTP; 01 Oct 2018 22:11:03 +0900
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms@verge.net.au>, linux-gpio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH v7 3/3] ARM: dts: r9a06g032: Add pinctrl node
Date:   Mon,  1 Oct 2018 14:10:26 +0100
Message-Id: <20181001131026.14635-4-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001131026.14635-1-phil.edworthy@renesas.com>
References: <20181001131026.14635-1-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides a pinctrl driver for the Renesas R9A06G032 SoC

Based on a patch originally written by Michel Pollet at Renesas.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v7:
 - No changes.

v6:
 - No changes.

v5:
 - No changes.

v4:
 - No changes.

v3:
 - No changes.

v2:
 - Add "renesas,rzn1-pinctrl" compatible fallback string
 - Register size corrected.
---
 arch/arm/boot/dts/r9a06g032.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index eaf94976ed6d..2322268bc862 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -165,6 +165,14 @@
 			status = "disabled";
 		};
 
+		pinctrl: pin-controller@40067000 {
+			compatible = "renesas,r9a06g032-pinctrl", "renesas,rzn1-pinctrl";
+			reg = <0x40067000 0x1000>, <0x51000000 0x480>;
+			clocks = <&sysctrl R9A06G032_HCLK_PINCONFIG>;
+			clock-names = "bus";
+			status = "okay";
+		};
+
 		gic: gic@44101000 {
 			compatible = "arm,cortex-a7-gic", "arm,gic-400";
 			interrupt-controller;
-- 
2.17.1

