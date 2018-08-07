Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD2AC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B988221A18
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OJ5x4AmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B988221A18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388689AbeHGIba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 04:31:30 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:39875 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbeHGIbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 04:31:19 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w776HYgf009463;
        Tue, 7 Aug 2018 15:17:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w776HYgf009463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533622658;
        bh=CDsPjvZxJ6vyqPNJqrby0MCDRw1rWBu5Y5NaXcK1G3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJ5x4AmHN6VIFmYNTxCtwlLy0Ot0EiENcE7MxUthfOaokJrPYNdRhR3b0K6zrksJS
         TjuA2uKk5Yx4JJ5LXRD5F822Ar/4kfg4nqkZhO9J8THjWkNV8l5zePdY7m0asmQnEk
         udBfk8ilzuka0J6HOontqOpx+R2DPVgR482+hupoEplVV+HrMLl3VcANwmGhrTNEcJ
         6wSLlCc3i8Klln5WhV3ORlDZO7cjVS4OW7NAj7K7JPpXGDWwx4N9F8xWhf+WxjIyKG
         anO9qtofaJw2QAN+QItI68eF6Pj/x1K6PAvbqTTNxkMnFw6JW1Mg2uzbLmhxjkVcoG
         pJ78+Td23/1KA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [v0.1 PATCH 3/7] dt-bindings: mmc: add DT binding for UniPhier SD/eMMC controller
Date:   Tue,  7 Aug 2018 15:17:18 +0900
Message-Id: <1533622642-13989-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
References: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This SD/eMMC controller is used for UniPhier SoC family.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../devicetree/bindings/mmc/uniphier-sd.txt        | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/uniphier-sd.txt

diff --git a/Documentation/devicetree/bindings/mmc/uniphier-sd.txt b/Documentation/devicetree/bindings/mmc/uniphier-sd.txt
new file mode 100644
index 0000000..49dd0fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/uniphier-sd.txt
@@ -0,0 +1,60 @@
+UniPhier SD/eMMC controller
+
+Required properties:
+- compatible: should be one of the following:
+    "socionext,uniphier-sd-v2.91" - IP version 2.91
+    "socionext,uniphier-sd-v3.1"  - IP version 3.1
+    "socionext,uniphier-sd-v3.1b" - IP version 3.1 (bug-fix ver.) [1]
+- reg: offset and length of the register set for the device.
+- interrupts: a single interrupt specifier.
+- clocks: a single clock specifier of the controller clock.
+- reset-names: should contain the following:
+    "host"   - mandatory for all versions
+    "bridge" - should exist only for "socionext,uniphier-sd-v2.91"
+    "hw"     - should exist if eMMC hw reset line is available
+- resets: a list of reset specifiers, corresponding to the reset-names
+
+[1] There are two different controller cores for version 3.1.  The early
+    release had a bug in the DMA RX channel.  The issue was fixed later,
+    but the version number was not incremented.  Hence, the latter has
+    'b' at the end of its compatible string.
+
+Optional properties:
+- pinctrl-names: if present, should contain the following:
+    "default" - should exist for all instances
+    "uhs"     - should exist for SD instance with UHS support
+- pinctrl-0: pin control state for the default mode
+- pinctrl-1: pin control state for the UHS mode
+- dma-names: should be "rx-tx" if present.
+  This property can exist only for "socionext,uniphier-sd-v2.91".
+- dmas: a single DMA channel specifier
+  This property can exist only for "socionext,uniphier-sd-v2.91".
+- bus-width: see mmc.txt
+- cap-sd-highspeed: see mmc.txt
+- cap-mmc-highspeed: see mmc.txt
+- sd-uhs-sdr12: see mmc.txt
+- sd-uhs-sdr25: see mmc.txt
+- sd-uhs-sdr50: see mmc.txt
+- cap-mmc-hw-reset: should exist if reset-names contains "hw". see mmc.txt
+- non-removable: see mmc.txt
+
+Example:
+
+	sd: sdhc@5a400000 {
+		compatible = "socionext,uniphier-sd-v2.91";
+		reg = <0x5a400000 0x200>;
+		interrupts = <0 76 4>;
+		pinctrl-names = "default", "uhs";
+		pinctrl-0 = <&pinctrl_sd>;
+		pinctrl-1 = <&pinctrl_sd_uhs>;
+		clocks = <&mio_clk 0>;
+		reset-names = "host", "bridge";
+		resets = <&mio_rst 0>, <&mio_rst 3>;
+		dma-names = "rx-tx";
+		dmas = <&dmac 4>;
+		bus-width = <4>;
+		cap-sd-highspeed;
+		sd-uhs-sdr12;
+		sd-uhs-sdr25;
+		sd-uhs-sdr50;
+	};
-- 
2.7.4

