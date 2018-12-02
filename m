Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3265C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D892082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D892082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbeLBV0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:26:16 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42470 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeLBV0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:26:16 -0500
Received: by mail-qk1-f196.google.com with SMTP id m5so6206170qka.9;
        Sun, 02 Dec 2018 13:26:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=SSJcnJIlvA4z4mukhMH1EJTr/0iElpSHaSOrD3HzAZg=;
        b=IXBD8FBR3OlYm6K1wEGwqf6ZpLOv5blI2W30h32u3N21yCmNo91KiurMbuflWNwXGg
         OmZKs+A3nO+DonEEUkrJEJkmdULzp+wSlOwMmPscx1+6+AumZG9x67XWWg1RhEDYebYo
         m4jAIffpmlDMXG3fkHvqa7gzIWk+XCY30mlNclDF6bszUPZcpmZIUdvh6qQMSgJ+8KET
         qaQfvuVHDaJRF8O+qTFkvLXaTLpz0a+0HQ5zV04Ajtp47rm1IqY/04iTYjsa77SqSriW
         pLE4e18GKTwI6Db6Tw7eigxgoQhGiaAUUTsPW80LTUbb4GBROScBw30/cxSaszlGAPMQ
         fUnw==
X-Gm-Message-State: AA+aEWa3vwRTtZBN0LIjQDXeAJo/TbDF3lvDiYjJQ1V8LzWAG730g2eR
        xLnvcIYaFQuJWtTEwz/3dSpnNYBe
X-Google-Smtp-Source: AFSGD/UU7E+CEOKGvU9LmjKiLwMWvJTFo6OgPGEo9uSi8ADcHcxaK9h3Rq/du2jaYVq2eN1++HWvrQ==
X-Received: by 2002:a37:d91:: with SMTP id 139mr13066177qkn.26.1543785972922;
        Sun, 02 Dec 2018 13:26:12 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id s9sm7408116qta.35.2018.12.02.13.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 13:26:12 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 02 Dec 2018 19:26:06 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 6/9] ARM: dts: imx7d-pico: Improve WiFi regulator name
Date:   Sun,  2 Dec 2018 19:25:17 -0200
Message-Id: <20181202212520.16650-7-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202212520.16650-1-otavio@ossystems.com.br>
References: <20181202212520.16650-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are different models of WiFi being used in the SoM and the
handle name was too restrictive. This reworks it to a more generic and
meaningful name.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/imx7d-pico.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 35791a1adabf..417f034fb354 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -13,11 +13,11 @@
 		reg = <0x80000000 0>;
 	};
 
-	reg_ap6212: regulator-ap6212 {
+	reg_wlreg_on: regulator-wlreg_on {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_ap6212>;
-		regulator-name = "AP6212";
+		pinctrl-0 = <&pinctrl_reg_wlreg_on>;
+		regulator-name = "wlreg_on";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio4 16 GPIO_ACTIVE_HIGH>;
@@ -241,7 +241,7 @@
 	non-removable;
 	keep-power-in-suspend;
 	wakeup-source;
-	vmmc-supply = <&reg_ap6212>;
+	vmmc-supply = <&reg_wlreg_on>;
 	mmc-pwrseq = <&usdhc2_pwrseq>;
 	status = "okay";
 };
@@ -302,7 +302,7 @@
 		>;
 	};
 
-	pinctrl_reg_ap6212: regap6212grp {
+	pinctrl_reg_wlreg_on: regregongrp {
 		fsl,pins = <
 			MX7D_PAD_ECSPI1_SCLK__GPIO4_IO16	0x59
 		>;
-- 
2.19.2

