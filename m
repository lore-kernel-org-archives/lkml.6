Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FA1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE281208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="KDr51vBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE281208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbeGaIvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:51:05 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.121]:13143 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732036AbeGaIur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533021113;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=mNmwYrugiIktR30VzIrhTtXImRZ/mtWjYFnjgzTgDxA=;
        b=KDr51vBWN5JlhScEQLUTbbJAtzXmcHWr6aDdS47AJ83cK9GOlyvphpVSARxnCtKpg7
        uI4JPWp8LYDQggRFtKdx3a/iSqjXbqZ6z3d3zwHxutCmVZRdGBcehVGpoxlIp+2HayE/
        BOD5eub0Vq86ihK5yvzW9SXmWfGOrzglvASsF0dyhTnKFnpDN0JwrwQJKUujOMFB3egW
        /bDqM8AU+Fl7EfiodwJcn2wHs3CoHtQAMz3cmJhTYVcLd77KjtaePTlahDu3ufjFpjaD
        rgen47xFlqR/qn/obQ7bAKevmpnRRt3tUCsP/qrAXa8OrPtiuMaLxL3jcb6UnUESpxir
        kxEA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1pxICp41QvXLM9PJBRQ"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6V7BkwOt
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 31 Jul 2018 09:11:46 +0200 (CEST)
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
Subject: [PATCH v2 27/32] ARM: dts: omap3-gta04a5: add support for PPS
Date:   Tue, 31 Jul 2018 09:11:30 +0200
Message-Id: <3a6fc8428f7ec414640821627f258b53e77b702d.1533021094.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPS receiver provides a 1PPS signal to a gpio.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04a5.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts b/arch/arm/boot/dts/omap3-gta04a5.dts
index d408eb05cdfa..e3f9e0969065 100644
--- a/arch/arm/boot/dts/omap3-gta04a5.dts
+++ b/arch/arm/boot/dts/omap3-gta04a5.dts
@@ -14,4 +14,22 @@
 	sound {
 		ti,jack-det-gpio = <&twl_gpio 2 GPIO_ACTIVE_HIGH>;	/* GTA04A5 only */
 	};
+
+	pps {
+		compatible = "pps-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pps_pins>;
+
+		gpios = <&gpio4 18 GPIO_ACTIVE_HIGH>; /* GPIN_114 */
+	};
+
+};
+
+&omap3_pmx_core {
+	pps_pins: pinmux_pps_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2138, PIN_INPUT | MUX_MODE4) /* gpin114 */
+		>;
+	};
+
 };
-- 
2.12.2

