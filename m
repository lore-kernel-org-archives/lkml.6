Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id R7CTMeuZHlsITAAAmS7hNA
	; Mon, 11 Jun 2018 15:50:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DC452607A4; Mon, 11 Jun 2018 15:50:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIgOh7aU"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 42C2C60792;
	Mon, 11 Jun 2018 15:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42C2C60792
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933236AbeFKPuh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:50:37 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:54550 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754247AbeFKPuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:50:15 -0400
Received: by mail-wm0-f44.google.com with SMTP id o13-v6so15510597wmf.4;
        Mon, 11 Jun 2018 08:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DOA0LyoDvKV7pGnT1HdgrLomwKraTsyZFrDgi7Oi1h8=;
        b=NIgOh7aUi4GAcdep4ugPYwwCq6/qEfYz3yeXmTsWZYJ9oLX2BAu0dqnvDWfS9URHQg
         +jD81qqwsrSGhUayEKzonQfH4bJ/ULBZTnoCFEwcaQwBbteN6zHJYNLKaE0k4SLZt3vP
         I3mzr7GVjJotHthEFhuQ7DJBPBmJHr3oR4sIDpSIf6F9ko6osbKd6rmeOaRJ+DfuN4/d
         TuO6aGjezZFBjtfniEhManoTjseqacaVG4rbdomFwAzSxLtec4C+Ag6gd9c96hE8hbFb
         RgqO4K5sGzKIKGK1I/y5GhK4ypkRsXVRulWNRN0OjodpI9GCgmR/qFBzZWqQ1SUGGWim
         jg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DOA0LyoDvKV7pGnT1HdgrLomwKraTsyZFrDgi7Oi1h8=;
        b=IM23JhzM24GnqctJXpSsmcYxERzHrV4yKhiUg3tMVOQ1CMyBhAqoWbtEQduenBRhUx
         8NPfJvlBfXgZcKwjtkZqOmX3JO/rbAhsjhBB3b648jsh8AUJNc74LPblan4rDtv0rnin
         eS3wvHQPwaTSS5sBZKSrBSNGlWULtfofeYLazr1qIryc/6PjAs4CQsc21Y5VNvgeujfu
         ekTZdxqwEn4g+fPYDRKU1RXsuboAXbpWGsd53GmFN8c6e61E1v2qvQBu4j6tzdYkmMbu
         VQEeQHIrgxsAxZK6r9iV23Qfni9FhAstb5frWreKnEqUWT7oWh+UaxPFV6qRScbuQh7t
         z/sA==
X-Gm-Message-State: APt69E2Gnf59+4jXdt8PpLQkDz4QSdrACLtVq7Czd4zyEavmfhTcBDYs
        3mLzCJbEqCuaHVegnXnkMoo=
X-Google-Smtp-Source: ADUXVKIhEz4UZmHphJQjU9p/FzKUS3YzsmJro7FxGv2quBNoYmj/uGc8NLbmfFim+yIL3MI0or4jSA==
X-Received: by 2002:a1c:99cf:: with SMTP id b198-v6mr7891976wme.15.1528732213889;
        Mon, 11 Jun 2018 08:50:13 -0700 (PDT)
Received: from cperon-Latitude-7490.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id n11-v6sm30308862wro.13.2018.06.11.08.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 08:50:12 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Stefan Agner <stefan@agner.ch>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH v7 5/5] ARM: dts: imx: add missing compatible and clock properties for EPIT
Date: Mon, 11 Jun 2018 17:50:01 +0200
Message-Id: <20180611155001.3506-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611155001.3506-1-peron.clem@gmail.com>
References: <20180611155001.3506-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Didier <colin.didier@devialet.com>

Add missing compatible and clock properties for EPIT node.

Signed-off-by: Colin Didier <colin.didier@devialet.com>
Signed-off-by: Clément Peron <clement.peron@devialet.com>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/imx25.dtsi   |  8 ++++++--
 arch/arm/boot/dts/imx6qdl.dtsi | 10 ++++++++--
 arch/arm/boot/dts/imx6sl.dtsi  | 10 ++++++++--
 arch/arm/boot/dts/imx6sx.dtsi  | 10 ++++++++--
 arch/arm/boot/dts/imx6ul.dtsi  | 10 ++++++++--
 5 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index cf70df20b19c..15fd4308dad8 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -396,15 +396,19 @@
 			};
 
 			epit1: timer@53f94000 {
-				compatible = "fsl,imx25-epit";
+				compatible = "fsl,imx25-epit", "fsl,imx31-epit";
 				reg = <0x53f94000 0x4000>;
 				interrupts = <28>;
+				clocks = <&clks 83>;
+				status = "disabled";
 			};
 
 			epit2: timer@53f98000 {
-				compatible = "fsl,imx25-epit";
+				compatible = "fsl,imx25-epit", "fsl,imx31-epit";
 				reg = <0x53f98000 0x4000>;
 				interrupts = <27>;
+				clocks = <&clks 84>;
+				status = "disabled";
 			};
 
 			gpio4: gpio@53f9c000 {
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index c003e62bf290..65c4ee07454c 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -843,14 +843,20 @@
 				};
 			};
 
-			epit1: epit@20d0000 { /* EPIT1 */
+			epit1: timer@20d0000 {
+				compatible = "fsl,imx6qdl-epit", "fsl,imx31-epit";
 				reg = <0x020d0000 0x4000>;
 				interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6QDL_CLK_EPIT1>;
+				status = "disabled";
 			};
 
-			epit2: epit@20d4000 { /* EPIT2 */
+			epit2: timer@20d4000 {
+				compatible = "fsl,imx6qdl-epit", "fsl,imx31-epit";
 				reg = <0x020d4000 0x4000>;
 				interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6QDL_CLK_EPIT2>;
+				status = "disabled";
 			};
 
 			src: src@20d8000 {
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index ab6a7e2e7e8f..d63f8ebbc8a1 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -671,14 +671,20 @@
 				};
 			};
 
-			epit1: epit@20d0000 {
+			epit1: timer@20d0000 {
+				compatible = "fsl,imx6sl-epit", "fsl,imx31-epit";
 				reg = <0x020d0000 0x4000>;
 				interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SL_CLK_EPIT1>;
+				status = "disabled";
 			};
 
-			epit2: epit@20d4000 {
+			epit2: timer@20d4000 {
+				compatible = "fsl,imx6sl-epit", "fsl,imx31-epit";
 				reg = <0x020d4000 0x4000>;
 				interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SL_CLK_EPIT2>;
+				status = "disabled";
 			};
 
 			src: src@20d8000 {
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 49c7205b8db8..2b30559d3270 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -736,14 +736,20 @@
 				};
 			};
 
-			epit1: epit@20d0000 {
+			epit1: timer@20d0000 {
+				compatible = "fsl,imx6sx-epit", "fsl,imx31-epit";
 				reg = <0x020d0000 0x4000>;
 				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SX_CLK_EPIT1>;
+				status = "disabled";
 			};
 
-			epit2: epit@20d4000 {
+			epit2: timer@20d4000 {
+				compatible = "fsl,imx6sx-epit", "fsl,imx31-epit";
 				reg = <0x020d4000 0x4000>;
 				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SX_CLK_EPIT2>;
+				status = "disabled";
 			};
 
 			src: src@20d8000 {
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 1241972b16ba..d5f765da1ee2 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -658,14 +658,20 @@
 				};
 			};
 
-			epit1: epit@20d0000 {
+			epit1: timer@20d0000 {
+				compatible = "fsl,imx6ul-epit", "fsl,imx31-epit";
 				reg = <0x020d0000 0x4000>;
 				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_EPIT1>;
+				status = "disabled";
 			};
 
-			epit2: epit@20d4000 {
+			epit2: timer@20d4000 {
+				compatible = "fsl,imx6ul-epit", "fsl,imx31-epit";
 				reg = <0x020d4000 0x4000>;
 				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_EPIT2>;
+				status = "disabled";
 			};
 
 			src: src@20d8000 {
-- 
2.17.1
