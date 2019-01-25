Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67241C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FE5218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Z7E5sMFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfAYTna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:43:30 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:54218 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfAYTna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9O4uSXRhxsaAuCQYyls6kJ4Kf7OlEXEjJHiwxeI3NYU=; b=Z7E5sMFPwDGSGYZaLmXwoE566b
        uzywu6uqO3fZ2+1bvvNjp4/e0WMs4Mdwbl8NQMP3x56vg4o0o7/bvkwz+5dJmizgTUwamjc5glkO1
        fSIjNeUHcRnn6fWkIY4jRU6cf5O73rVsU68NZstTkHwPvC+vjOUnPdOkYuZvat9IwEgA=;
Received: from p200300ccfbcb43007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:fbcb:4300:7ee9:d3ff:fe1f:a246] helo=eeepc)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gn7Nn-0001K3-U7; Fri, 25 Jan 2019 20:43:20 +0100
Received: from andi by eeepc with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gn7Nm-0002us-KC; Fri, 25 Jan 2019 20:43:19 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] arm: dts: gta04: add gps support
Date:   Fri, 25 Jan 2019 20:43:10 +0100
Message-Id: <20190125194310.11170-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
which one is mounted so use the compatibility entry for w2sg0004
for all which will work for both.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
w2sg0004 bindings (together with the corresponding support is in
https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss gnss-next)
 arch/arm/boot/dts/omap3-gta04.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index e53d32691308..d58c117e429f 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -312,6 +312,12 @@
 		>;
        };
 
+	gps_pins: pinmux_gps_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT_PULLDOWN | MUX_MODE4) /* gpio145 */
+		>;
+	};
+
 	hdq_pins: hdq_pins {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x21c6, PIN_INPUT_PULLUP | MUX_MODE0) /* i2c3_sda.hdq */
@@ -644,6 +650,13 @@
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart2_pins>;
+	gps: gps {
+		compatible = "wi2wi,w2sg0004";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gps_pins>;
+		sirf,onoff-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
+		lna-supply = <&vsim>;
+	};
 };
 
 &uart3 {
-- 
2.11.0

