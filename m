Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAE4C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F2E218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="PKFP6OYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfAaSHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:07:08 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:43826 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbfAaSG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H0Tis6IjbQNc+fhhasNQsHQgzjddKfbMGzHek0faQ9U=; b=PKFP6OYgLX+jlR/z6zZ4EXzp7
        VAEvzL+1gPSG1X5mBhvxAQk+723N8YdpnSRBb7bLO73wXqVrzzVyuk4A+lJnr9vjapEkp9g/DXJwp
        Elc3D4HTtekr/s0GewuRMy0xDlEOEtaxfslPw617o83plyoWmxTYIa5xFrlBYnXt0XxiM=;
Received: from p5dcc395f.dip0.t-ipconnect.de ([93.204.57.95] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gpGjf-0001J0-5k; Thu, 31 Jan 2019 19:06:47 +0100
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gpGje-0003mc-Cm; Thu, 31 Jan 2019 19:06:46 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Johan Hovold <johan@kernel.org>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, letux-kernel@openphoenux.org,
        tony@atomide.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        bcousson@baylibre.com, linux-omap@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 2/2] arm: dts: gta04: add gps support
Date:   Thu, 31 Jan 2019 19:06:40 +0100
Message-Id: <20190131180640.14480-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190131180640.14480-1-andreas@kemnade.info>
References: <20190131180640.14480-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
which one is mounted so use the compatibility entry for w2sg0004
for all which will work for both.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v3:
- converted to a patchset
- added vcc-supply

Changes in v2:
- some s/gps/gnss/
- not added vcc-supply because the regulator is not modelled
  in dts at all

w2sg0004 bindings are in next-20190129

 arch/arm/boot/dts/omap3-gta04.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 02d8274a2f47..4ea0f7dc37c6 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -320,6 +320,12 @@
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
@@ -652,6 +658,14 @@
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart2_pins>;
+	gnss: gnss {
+		compatible = "wi2wi,w2sg0004";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gps_pins>;
+		sirf,onoff-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
+		lna-supply = <&vsim>;
+		vcc-supply = <&ldo_3v3>;
+	};
 };
 
 &uart3 {
-- 
2.11.0

