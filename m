Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9330C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9B720870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="IWecl7Dt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfAaGYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 01:24:21 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:42414 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfAaGYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 01:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ESvNzyT0wyj+OT6DuotyvZjiN/RsN64MpIArWgl4DGA=; b=IWecl7Dtv9IXgxOx6g4NK7lNi1
        bmg1C5pqqY6hfM01lDdTRIakTSTMxk8QP3FwHWTMMLdNH4+Ad1J2AngEe02qmv+xuo8SpRpEdpxdI
        Y58f2Gw0DCMofDfG1Akmk1Umwcyj0oQtt6ivSz6VJUwWUcjvV5vguCLZ/z55IW8qhTeg=;
Received: from hsvpn34.hotsplots.net ([176.74.57.181] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gp5lk-0000cG-3a; Thu, 31 Jan 2019 07:24:13 +0100
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gp5lQ-0007B1-NI; Thu, 31 Jan 2019 07:23:52 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] arm: dts: gta04: add pinctrl settings for wkup domain
Date:   Thu, 31 Jan 2019 07:23:38 +0100
Message-Id: <20190131062338.27547-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is one button and a notifier for incoming phone
calls/text messages for which we should wakeup from
suspend.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index d58c117e429f..6f11bf3ee4ed 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -224,6 +224,15 @@
 	};
 };
 
+&omap3_pmx_wkup {
+	gpio1_pins: pinmux_gpio1_pins {
+		pinctrl-single,pins = <
+			OMAP3_WKUP_IOPAD(0x2a14, PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE4) /* sys_boot5.gpio_7 */
+			OMAP3_WKUP_IOPAD(0x2a1a, PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE4) /* sys_clkout.gpio_10 */
+		>;
+	};
+};
+
 &omap3_pmx_core {
 	pinctrl-names = "default";
 	pinctrl-0 = <
@@ -642,6 +651,11 @@
 	status = "disabled";
 };
 
+&gpio1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio1_pins>;
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>;
-- 
2.11.0

