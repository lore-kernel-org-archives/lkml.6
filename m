Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03615C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 06:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D068D21736
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 06:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbeLXGxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 01:53:18 -0500
Received: from twhmllg3.macronix.com ([122.147.135.201]:10582 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeLXGxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 01:53:18 -0500
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id wBO6qemU051271;
        Mon, 24 Dec 2018 14:52:42 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        boris.brezillon@bootlin.com, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw, Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v4 2/2] dt-bindings: spi: Document Renesas R-Car Gen3 RPC controller bindings
Date:   Mon, 24 Dec 2018 14:52:38 +0800
Message-Id: <1545634358-17485-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545634358-17485-1-git-send-email-masonccyang@mxic.com.tw>
References: <1545634358-17485-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com wBO6qemU051271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings used by the Renesas R-Car Gen3 RPC controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
new file mode 100644
index 0000000..ba863d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
@@ -0,0 +1,37 @@
+Renesas R-Car Gen3 RPC controller Device Tree Bindings
+------------------------------------------------------
+
+Required properties:
+- compatible: should be "renesas,r8a77995-rpc"
+- #address-cells: should be 1
+- #size-cells: should be 0
+- reg: should contain 2 entries, one for the registers and one for the direct
+       mapping area
+- reg-names: should contain "regs" and "dirmap"
+- clock-names: should contain "rpc"
+- clocks: should contain 1 entries for the module's clock
+- renesas,rpc-mode: should contain "spi" for rpc spi mode or
+			   	   "hyperflash" for rpc hyerflash mode.
+
+Example:
+
+	rpc: rpc@ee200000 {
+		compatible = "renesas,r8a77995-rpc";
+		reg = <0 0xee200000 0 0x8100>, <0 0x08000000 0 0x4000000>;
+		reg-names = "regs", "dirmap";
+		clocks = <&cpg CPG_MOD 917>;
+		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+		resets = <&cpg 917>;
+		clock-names = "rpc";
+		renesas,rpc-mode = "spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		flash@0 {
+			compatible = "jedec,spi-nor";
+			reg = <0>;
+			spi-max-frequency = <40000000>;
+			spi-tx-bus-width = <1>;
+			spi-rx-bus-width = <1>;
+		};
+	};
-- 
1.9.1

