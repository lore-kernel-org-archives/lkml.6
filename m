Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD524C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8536520855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PStDuglL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfBAPnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:43:21 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45755 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfBAPnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:43:18 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so5344319lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9PxoL5qRhhi9/8I/MxsRIxkuMzLQLSJqsW5+iDKE8rA=;
        b=PStDuglLVi/EynWNiR1InZlzEGZ5OYkU5HFWgq5QoplmJTL4O34KrVjfcj4OOUPqad
         77Y6uoG42LSMSlWxaINvHygDh/ObRuI9PEnd3cJr1yHAdY5aaVCiFhwslEVpx296eUsD
         31mgZtYyYp6r22ptAJoGTiXLjsSghgc39vI9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9PxoL5qRhhi9/8I/MxsRIxkuMzLQLSJqsW5+iDKE8rA=;
        b=FllNvqmvMpQCrlQDjl4EUnbxOsPCWjSYILErUgcmLnB07ZyWaZ9KPfzwUSRruxfVtj
         bnyWhUQ7o54w1apd/j9Cjg/PMHZJLdTW66YHYYzXSG7sopk0JkudElSTUcU+r3AmOE6m
         wpsYGs2Vot1Y7tvU4fMqZhffqxGFrfpzcGVXFa/hNQqhHXMSrnDLdQxpH/Fpxn/4nnMg
         lZm8gjfj6CYUNKs/OYtbBhp5QIaGlUrMkNgcKcBCkhU8bMccya2Unh4M5qj4ENlN7yJF
         0/EKjmj9j/5zaY5knnl+ReOvt0n5hSf6RVRnIGt/SoadTyba1pNGDaDxSqZIRNItXXsm
         E69A==
X-Gm-Message-State: AJcUukcuA8LJ58x5OHl+pMObI4VXxVarcEtq7udZau84HxslLAuIxjaG
        LPvm57C2kOr3/TyVYcXBoItkKg==
X-Google-Smtp-Source: ALg8bN5I0y263rz3wbLQE+wVgVuLqZfYA9ozcouGzvSa3ePZ+MbpnFCFk4o/2h1mZ1TCk7wIq26/qw==
X-Received: by 2002:a19:910d:: with SMTP id t13mr30525083lfd.98.1549035795951;
        Fri, 01 Feb 2019 07:43:15 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
        by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:43:15 -0800 (PST)
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
Subject: [DO NOT MERGE][PATCH v7 18/23] arm64: allwinner: a64: pine64-lts: Enable Feiyang FY07024DI26A30-D DSI panel
Date:   Fri,  1 Feb 2019 21:12:27 +0530
Message-Id: <20190201154232.10505-19-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
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
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
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

