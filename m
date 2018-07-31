Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E19CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6E7208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="ViNluQm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6E7208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbeGaIv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:51:58 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.124]:28070 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732087AbeGaIuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533021111;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=+lAF3nFIlHT9KeAKDLVjcm5r4vPlQ6TpsyDfXfqa81U=;
        b=ViNluQm2ZysWb/aEPvNpNK5rwlhOOfrJ0Yvps8yztkg4xzb174jrxqaVBsk6S8ozF/
        QF72GvQToh93lo+P9/MVZzVx4huKNvHWh0ua3j/KCTRNF/nwSpjgO22tZ8eObCqB71Du
        LdzZWcP+XRPP1vdr2UFQh+cNHnQj3ZqoM5nyGP5RFmQ1/fvpVguCfqqg9P9Inc/9hdG6
        /fmLrRLUujrtk4qU0NJDkGmwOQ1I76irZIxUK29fz/PFUNgRWGaiv6w5UveTBlpldpfZ
        DCaF5DXP1KP+gEnSh3fWL/AowHHGO9WR6hO5bXUJNaXlQfWl84+8lbvFjWGeXB9wIhtH
        Zncg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1pxICp41QvXLM9PJBRQ"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6V7BiwOm
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 31 Jul 2018 09:11:44 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     ladis@linux-mips.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Marek Belisko <marek@goldelico.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 21/32] ARM: dts: omap3-gta04: add mcbsp (audio subsystem) nodes
Date:   Tue, 31 Jul 2018 09:11:24 +0200
Message-Id: <ebd8921ed01403aad71772b994d5bc6398500cb6.1533021093.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GTA04 audio system makes use of all four McBSP ports, so enable and
connect them with pinmux.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 39f0eb8f65b0..571ea4e0a087 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -771,8 +771,31 @@
 	};
 };
 
-&mcbsp2 {
-	status = "okay";
+&mcbsp1 { /* FM Transceiver PCM */
+	status = "ok";
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp1_pins>;
+};
+
+&mcbsp2 { /* TPS65950 I2S */
+	status = "ok";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp2_pins>;
+};
+
+&mcbsp3 { /* Bluetooth PCM */
+	status = "ok";
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp3_pins>;
+};
+
+&mcbsp4 { /* GSM voice PCM */
+	status = "ok";
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp4_pins>;
 };
 
 &hdqw1w {
@@ -780,10 +803,6 @@
         pinctrl-0 = <&hdq_pins>;
 };
 
-&mcbsp4 {
-	status = "okay";
-};
-
 /* image signal processor within OMAP3 SoC */
 &isp {
 	ports {
-- 
2.12.2

