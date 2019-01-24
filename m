Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523DAC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F19A21726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pDm2CF9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbfAXUAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:00:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32898 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729835AbfAXUAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:00:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so3552951pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=soUQzKMmxVLy4tGsbhoyX6SR8F/5vCDS2D75UzCy/p4=;
        b=pDm2CF9FEByve8QNGu0gfhjfwth1MWBhy/p3CB7KTTVbi8SWcZlwqxMz3Jj0FOQwJE
         hTiVNLIfFGYpkS/HEdtIdT3c4ofBZ2JFDLKeB0m54ERQiBG7t/2NK0InkdpBxqE0Qjoc
         BBEJPEQVYcjNZPvTxK8Qmvh3NG4ptucQ5FzRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=soUQzKMmxVLy4tGsbhoyX6SR8F/5vCDS2D75UzCy/p4=;
        b=Xld4owppsN7DiaQcAiZXZtMp0A4MUIy1Pz/BMMWwO2BIo6akIrGImsQboB3lreOygD
         robl06FVirDlQah/WyiLodbPPGuju4bw+eyOHVGGt+cXCElGK0RNDBVqblilzkCaEzr3
         tuPDg9WSNnKdZ+odb4XLNmrb7xizErYYPoN04ymhNDbuV8oldy0fm3qrnrIFwifAdEjm
         yS61UmHQ8U3Z7AzKJEfm7h68A8AXJsb21jtIl1ORqE72/nMZCEi6qaVOyp+01mZ23I2J
         6GGf4kNdLVFU/ECB10iFzvdJRBLCKo0xSpPWAPIAJb9Rf6s+zivnrWnyN+Z8AeWir7YA
         mZ0g==
X-Gm-Message-State: AJcUukdiO/yhP5LVW00hwTl4+ylvqEOy2EF0kQgtu/6Y4UfaMH7nQ6qo
        YIkDWCE1VAQF0JglePhEkf2JCw==
X-Google-Smtp-Source: ALg8bN7V/q3qfGMQdiguUqaCp/nOEgSFeiBDxo6NyBW78ZZ3lW3tUgTBZc4LEb1cspn/NZH8O7Mt/Q==
X-Received: by 2002:a63:9501:: with SMTP id p1mr7201961pgd.149.1548360051292;
        Thu, 24 Jan 2019 12:00:51 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.12.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 12:00:50 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [DO NOT MERGE] [PATCH v6 17/22] arm64: allwinner: a64: pine64-lts: Enable Feiyang FY07024DI26A30-D DSI panel
Date:   Fri, 25 Jan 2019 01:28:55 +0530
Message-Id: <20190124195900.22620-18-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feiyang FY07024DI26A30-D MIPI_DSI panel is desiged to attach with
DSI connector on pine64 boards, enable the same for pine64 LTS.

DSI panel connected via board DSI port with,
- DC1SW as AVDD supply
- DLDO2 as DVDD supply
- DLDO1 as VCC-DSI supply
- PD24 gpio for reset pin
- PH10 gpio for backlight enable pin

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../dts/allwinner/sun50i-a64-pine64-lts.dts   | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
index 72d6961dc312..341b1c035604 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
@@ -5,9 +5,48 @@
  */
 
 #include "sun50i-a64-sopine-baseboard.dts"
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Pine64 LTS";
 	compatible = "pine64,pine64-lts", "allwinner,sun50i-r18",
 		     "allwinner,sun50i-a64";
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <1 2 4 8 16 32 64 128 512>;
+		default-brightness-level = <8>;
+		enable-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* LCD-BL-EN: PH10 */
+	};
+};
+
+&de {
+	status = "okay";
+};
+
+&dphy {
+	status = "okay";
+};
+
+&dsi {
+	vcc-dsi-supply = <&reg_dldo1>;		/* VCC3V3-DSI */
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "feiyang,fy07024di26a30d";
+		reg = <0>;
+		avdd-supply = <&reg_dc1sw>;	/* VCC-LCD */
+		dvdd-supply = <&reg_dldo2>;	/* VCC-MIPI */
+		reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+		backlight = <&backlight>;
+	};
+};
+
+&r_pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&r_pwm_pin>;
+	status = "okay";
 };
-- 
2.18.0.321.gffc6fa0e3

