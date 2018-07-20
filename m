Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0AEECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FDA20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="U8IBI5Mu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FDA20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeGTJjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:39:01 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:40367 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbeGTJjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:39:01 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w6K8ovEH003659;
        Fri, 20 Jul 2018 17:50:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w6K8ovEH003659
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532076658;
        bh=ElVTfAtpF+Li2o7JcJGIcbW42IpderFSv7LmvIkB7V4=;
        h=From:To:Cc:Subject:Date:From;
        b=U8IBI5Mums7rZTsD9ar+/0TpL2nFJO6SjeLk4asAFr66B89FjGXmMOx7XUGnhZKLV
         clc5OT+lv2QpveFFe1hNM/cCKYUjmP+T6IxaUR4KrPpNnm58BplN9Dn7708E76oyUW
         dE+DOvC3cg/Ql5jphGBAOo8l3sCbB22Nkt5uE25/mStZR+Y0qV3/B+/Os4YNL9Dira
         gm6muI8714AGZF2Y1pW1JemzI9O8yicHGSoxnCpnKLav366jSnQX9nMffiVGJnb/1V
         UwAJttCNFo5JAoytdS+m9A7owm7lKIfgjlGUT+D+i0Y8mtnkpU2jrH6INn3MXkernB
         BVtVZ+nI2sKeg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/2] ARM: uniphier: dts: add more clocks to Denali NAND controller node
Date:   Fri, 20 Jul 2018 17:50:44 +0900
Message-Id: <1532076645-10769-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Catch up with the new binding of the Denali IP where three clocks,
"nand", "nand_x", "ecc" are required.

For UniPhier SoCs, the "nand_x" and "ecc" are tied up because they
are both 200MHz.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4.dtsi  | 3 ++-
 arch/arm/boot/dts/uniphier-pro4.dtsi | 3 ++-
 arch/arm/boot/dts/uniphier-pro5.dtsi | 3 ++-
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 3 ++-
 arch/arm/boot/dts/uniphier-sld8.dtsi | 3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 37950ad..2a17066 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -347,7 +347,8 @@
 			interrupts = <0 65 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand2cs>;
-			clocks = <&sys_clk 2>;
+			clock-names = "nand", "nand_x", "ecc";
+			clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
 			resets = <&sys_rst 2>;
 		};
 	};
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 49539f0..da88ccc 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -394,7 +394,8 @@
 			interrupts = <0 65 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
-			clocks = <&sys_clk 2>;
+			clock-names = "nand", "nand_x", "ecc";
+			clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
 			resets = <&sys_rst 2>;
 		};
 	};
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index 06c2cef..40a84f2 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -439,7 +439,8 @@
 			interrupts = <0 65 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand2cs>;
-			clocks = <&sys_clk 2>;
+			clock-names = "nand", "nand_x", "ecc";
+			clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
 			resets = <&sys_rst 2>;
 		};
 	};
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 641d961..1903752 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -528,7 +528,8 @@
 			interrupts = <0 65 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand2cs>;
-			clocks = <&sys_clk 2>;
+			clock-names = "nand", "nand_x", "ecc";
+			clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
 			resets = <&sys_rst 2>;
 		};
 	};
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index e9b9b4f..dc723bf 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -351,7 +351,8 @@
 			interrupts = <0 65 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand2cs>;
-			clocks = <&sys_clk 2>;
+			clock-names = "nand", "nand_x", "ecc";
+			clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
 			resets = <&sys_rst 2>;
 		};
 	};
-- 
2.7.4

