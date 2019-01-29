Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E855C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1185B2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="XKeuJj2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfA2RVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:21:17 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:37972 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbfA2RVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q02OT52LJozxNt+IuqQzeAMwZp8ebOhE+fFqvQxJJng=; b=XKeuJj2pt0XN91RukC2a9Wvojb
        j0e4x0WlSwU+R8PC00NF38493IH6N1S993QjnPgLBwO+5AJFBPk1t1JcVNB9NGO/AwiyCaOExbDNP
        Zlkb/Zc+4a4Y0PPySekqZVhdsauNyev6q9nM9CUMnR7FZ8CJ++cVXQUByxpZuysnKXmc=;
Received: from p200300ccfbd4d9007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:fbd4:d900:7ee9:d3ff:fe1f:a246] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1goX4N-0007VS-B7; Tue, 29 Jan 2019 18:21:07 +0100
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1goNzE-0003uO-Fo; Tue, 29 Jan 2019 08:39:12 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2] arm: dts: gta04: add gps support
Date:   Tue, 29 Jan 2019 08:38:43 +0100
Message-Id: <20190129073843.14979-1-andreas@kemnade.info>
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
Changes in v2:
- some s/gps/gnss/
- not added vcc-supply because the regulator is not modelled
  in dts at all

w2sg0004 bindings are in next-20190129

https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss gnss-next
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
+	gnss: gnss {
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

