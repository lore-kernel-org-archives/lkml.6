Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADBAC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 15:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CF42147C
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 15:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S796dWnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CF42147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeIWVf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 17:35:27 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54326 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeIWVf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 17:35:26 -0400
Received: by mail-it1-f193.google.com with SMTP id f14-v6so7539352ita.4;
        Sun, 23 Sep 2018 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gD26wjGkbbVePHSu1FAQANtFZ8tqNNl0c4g4gtzYc/o=;
        b=S796dWnnxVw3jWdFMGqKx//dZFmhsp+5DFtBvphS3YrJK1ltv/+5lRyyyBLiVie/3g
         FT7XRfOn2zwyak2qYGOT7RSCRWIHTWE/gAHPPtnTPDCKQeirGc4J8lqQFuE/trUg+WWX
         vmV66L1vc/D9wjk6Aple9eOTM0Ke2DMAoCQMLF6UwXX5GQgZyrHz8OBjxyG8b/5jNkar
         DAySyX+GAzb19P+lgt+TzR3wZ3XBWwkXR2iKq5aNPIF+EaqkikWLPhPq+JaI8gv061tT
         e22zydlwDrzpRRkApEvvvgHSv1ZJ9xgRT5i+fMCmzApMEoZSvI9EejOV6vDXG8ZZoWWk
         +LfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gD26wjGkbbVePHSu1FAQANtFZ8tqNNl0c4g4gtzYc/o=;
        b=p+Q3sDlwezRyjL6o29egwBqx+tCPc90Y+8++LtxrOOQGd+o1i8KsYUaG2yyDLr5rga
         wT9PT0t22LhwFDslTL297XEVs518j2WHwDBFzRRBLK9o88GWShSjOdqs/f8SH8clY1ZF
         8wsM/EjVel0fUqUrVGCCsq9hxxUm8MceQGPv/1P1nV/H2RHLVjgNp7/MdAjnSHiK0AR3
         Ro4vwGtlcz/D+/pBAcxiR5smighY/LR0+L0NrYbLbj0JfmqhsaEu2pZaQeWQwA9iWrQ+
         n80DgAwSf+ahEac7eXV3aePxc7xgRPJDb2ufSgYtUu+gNWkw2hIQIXA18PTzVFZqgcqq
         ktUA==
X-Gm-Message-State: APzg51AOi5cArqd4u/JFzRC9T0Jypa3/CaXcee++rPBBrIWbr4PCRR5I
        aEbc+6s2ChY94VKSayFCeTQeJL48+GVTlw==
X-Google-Smtp-Source: ANB0Vda9WfV5x43/5fS4T4mwRDboebpU7e/PuhPSXc3bn4XCVd5tAxysr3xOniCqmyS9DK4YjW172g==
X-Received: by 2002:a02:3d02:: with SMTP id n2-v6mr5784712jan.79.1537717052701;
        Sun, 23 Sep 2018 08:37:32 -0700 (PDT)
Received: from localhost.localdomain (c-75-73-34-135.hsd1.mn.comcast.net. [75.73.34.135])
        by smtp.gmail.com with ESMTPSA id o141-v6sm2132531itg.35.2018.09.23.08.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 08:37:32 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 2/3] ARM: DTS: AM3517-EVM: Add support for UI board and Audio
Date:   Sun, 23 Sep 2018 10:37:17 -0500
Message-Id: <20180923153718.15095-2-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180923153718.15095-1-aford173@gmail.com>
References: <20180923153718.15095-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The full AM3517-EVM shipped with an add-on board which contained
two Audio codecs, a GPIO expander with a variety of buttons, and
some other features.  This patch enables these portions of the UI
board because they don't directly conflict with existing features.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/am3517-evm-ui.dtsi b/arch/arm/boot/dts/am3517-evm-ui.dtsi
new file mode 100644
index 000000000000..e841918c1c26
--- /dev/null
+++ b/arch/arm/boot/dts/am3517-evm-ui.dtsi
@@ -0,0 +1,220 @@
+/*
+ * Copyright (C) 2018 Logic PD, Inc - http://www.logicpd.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <dt-bindings/input/input.h>
+
+/ {
+	codec1 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "tlv320aic23-hifi";
+
+		simple-audio-card,widgets =
+			"Microphone", "Mic In",
+			"Line", "Line In",
+			"Line", "Line Out";
+
+		simple-audio-card,routing =
+			"Line Out", "LOUT",
+			"Line Out", "ROUT",
+			"LLINEIN", "Line In",
+			"RLINEIN", "Line In",
+			"MICIN", "Mic In";
+
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,frame-master = <&sound_master>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcbsp1>;
+		};
+
+		sound_master: simple-audio-card,codec {
+			sound-dai = <&tlv320aic23_1>;
+			system-clock-frequency = <12000000>;
+		};
+	};
+
+	codec2 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "tlv320aic23-hifi";
+
+		simple-audio-card,widgets =
+			"Microphone", "Mic In",
+			"Line", "Line In",
+			"Line", "Line Out";
+
+		simple-audio-card,routing =
+			"Line Out", "LOUT",
+			"Line Out", "ROUT",
+			"LLINEIN", "Line In",
+			"RLINEIN", "Line In",
+			"MICIN", "Mic In";
+
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&sound_master2>;
+		simple-audio-card,frame-master = <&sound_master2>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcbsp2>;
+		};
+
+		sound_master2: simple-audio-card,codec {
+			sound-dai = <&tlv320aic23_2>;
+			system-clock-frequency = <12000000>;
+		};
+	};
+
+	expander-keys {
+		compatible = "gpio-keys-polled";
+		poll-interval = <100>;
+
+		record {
+			label = "Record";
+			/* linux,code = <BTN_0>; */
+			gpios = <&tca6416_2 15 GPIO_ACTIVE_LOW>;
+		};
+
+		play {
+			label = "Play";
+			linux,code = <KEY_PLAY>;
+			gpios = <&tca6416_2 14 GPIO_ACTIVE_LOW>;
+		};
+
+		Stop {
+			label = "Stop";
+			linux,code = <KEY_STOP>;
+			gpios = <&tca6416_2 13 GPIO_ACTIVE_LOW>;
+		};
+
+		fwd {
+			label = "FWD";
+			linux,code = <KEY_FASTFORWARD>;
+			gpios = <&tca6416_2 12 GPIO_ACTIVE_LOW>;
+		};
+
+		rwd {
+			label = "RWD";
+			linux,code = <KEY_REWIND>;
+			gpios = <&tca6416_2 11 GPIO_ACTIVE_LOW>;
+		};
+
+		shift {
+			label = "Shift";
+			linux,code = <KEY_LEFTSHIFT>;
+			gpios = <&tca6416_2 10 GPIO_ACTIVE_LOW>;
+		};
+
+		Mode {
+			label = "Mode";
+			linux,code = <BTN_MODE>;
+			gpios = <&tca6416_2 9 GPIO_ACTIVE_LOW>;
+		};
+
+		Menu {
+			label = "Menu";
+			linux,code = <KEY_MENU>;
+			gpios = <&tca6416_2 8 GPIO_ACTIVE_LOW>;
+		};
+
+		Up {
+			label = "Up";
+			linux,code = <KEY_UP>;
+			gpios = <&tca6416_2 7 GPIO_ACTIVE_LOW>;
+		};
+
+		Down {
+			label = "Down";
+			linux,code = <KEY_DOWN>;
+			gpios = <&tca6416_2 6 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&i2c2 {
+	/* Audio codecs */
+	tlv320aic23_1: codec@1a {
+		compatible = "ti,tlv320aic23";
+		reg = <0x1a>;
+		#sound-dai-cells= <0>;
+		status = "okay";
+	};
+
+	tlv320aic23_2: codec@1b {
+		compatible = "ti,tlv320aic23";
+		reg = <0x1b>;
+		#sound-dai-cells= <0>;
+		status = "okay";
+	};
+};
+
+&i2c3 {
+	/* Audio codecs */
+	tlv320aic23_3: codec@1a {
+		compatible = "ti,tlv320aic23";
+		reg = <0x1a>;
+		#sound-dai-cells= <0>;
+		status = "okay";
+	};
+
+	/* GPIO Expanders */
+	tca6416_2: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&vdd_io_reg>;
+	};
+
+	tca6416_3: gpio@21 {
+		compatible = "ti,tca6416";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&vdd_io_reg>;
+	};
+
+	/* TVP5146 Analog Video decoder input */
+	tvp5146@5c {
+		compatible = "ti,tvp5146m2";
+		reg = <0x5c>;
+	};
+};
+
+&mcbsp1 {
+	status = "ok";
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp1_pins>;
+};
+
+&mcbsp2 {
+	status = "ok";
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp2_pins>;
+};
+
+&omap3_pmx_core {
+	mcbsp1_pins: pinmux_mcbsp1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2190, PIN_OUTPUT | MUX_MODE0)	/* mcbsp1_dx.mcbsp1_dx */
+			OMAP3_CORE1_IOPAD(0x2192, PIN_INPUT | MUX_MODE0)	/* mcbsp1_dx.mcbsp1_dr */
+			OMAP3_CORE1_IOPAD(0x2196, PIN_INPUT | MUX_MODE0)	/* mcbsp_clks.mcbsp1_fsx */
+			OMAP3_CORE1_IOPAD(0x2198, PIN_INPUT | MUX_MODE0)	/* mcbsp1_clkx.mcbsp1_clkx */
+		>;
+	};
+
+	mcbsp2_pins: pinmux_mcbsp2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x213c, PIN_INPUT | MUX_MODE0)	/* mcbsp2_fsx.mcbsp2_fsx */
+			OMAP3_CORE1_IOPAD(0x213e, PIN_INPUT | MUX_MODE0)	/* mcbsp2_clkx.mcbsp2_clkx */
+			OMAP3_CORE1_IOPAD(0x2140, PIN_INPUT | MUX_MODE0)	/* mcbsp2_dr.mcbsp2.dr */
+			OMAP3_CORE1_IOPAD(0x2142, PIN_OUTPUT | MUX_MODE0)	/* mcbsp2_dx.mcbsp2_dx */
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index 1d158cfda15f..d4d33cd7adad 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -9,6 +9,7 @@
 
 #include "am3517.dtsi"
 #include "am3517-som.dtsi"
+#include "am3517-evm-ui.dtsi"
 #include <dt-bindings/input/input.h>
 
 / {
-- 
2.17.1

