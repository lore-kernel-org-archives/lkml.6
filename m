Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2Ht7DMs7GVvILwAAmS7hNA
	; Thu, 07 Jun 2018 14:06:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0C250608B8; Thu,  7 Jun 2018 14:06:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q863Xl3c"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 410156063F;
	Thu,  7 Jun 2018 14:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 410156063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932936AbeFGOGb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:06:31 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42168 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753103AbeFGOGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:06:11 -0400
Received: by mail-wr0-f194.google.com with SMTP id w10-v6so9992970wrk.9;
        Thu, 07 Jun 2018 07:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OO/LsHhN1xE7K9dxbNgxucrz+2wUNhM5O8uYhzYm++g=;
        b=q863Xl3cYEUhoBTcB2JPc2YysPWqf7ToWZYngTrENgtOqHOmVTu0YHYIM7szkRugOh
         NEHD2rcjtToWfeDu+aWEs03LSIqPAEUA3SmByBs1obyt+wN8/W0HxSOEVwuIXHEuukbh
         xx7eEmQdnrrLprvXPL/sXZ+NrVn3gNCVYQoQ2aVrNYtamhRZv2Pz9JkC8BcVT4VEGi/t
         e5zLlIART7Dn9BF1sMwUGYApJwD37QKyCKB3nv43cTnWCW4QKV4YfINe4hJ41h64sRcn
         VJvS/QfXafn2kv52a/i1/jZPj77a4wltWM1Lyqox/3pcWCMYA18lz5TjYx4O7M5ASL7n
         ltRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OO/LsHhN1xE7K9dxbNgxucrz+2wUNhM5O8uYhzYm++g=;
        b=KPxvH12uGxwLCA4RGvcfxu0yxuX9ujjuXQGkLT07sgeX0nU2DlbCtclcPrkU266uLs
         KmQKJYvjV13E4YS7UJguZCEsQktiqNF1n9+ANPwiOrCVl1vUsfVkEFDzjyCKfIvSusNw
         ffM8NoEt55u/TxAGCjyLptwtOzkw3xacPW6fHv79ipH3hC8v+o587INmQzUFab7BycRv
         6p1lsvBlfXMpk9nqa1WODfZFJLASASICYP+8cRzVCTsBc6mpN29BUEmyLyTJAIs3WDgO
         uDYrNBCFxTRrPPZQ/ZG/P/+7CycwRDB/WelXXx5/NGYu+/4t7T09BbRDsR5nHkwaGT/w
         rVxQ==
X-Gm-Message-State: APt69E1aCjlaNXHGEhRWD/rJDJ7YE19Sm3vPwEN4v2GlVewnUDfPS3ok
        imtBqNFrBNR9GShNRYYJl9Y=
X-Google-Smtp-Source: ADUXVKJIl2StPnY6m6ms7CfwDipimrztRmSrIJO9gStms/mxvf3pnfas3EHLPD6lh+y4zNf+wTMxng==
X-Received: by 2002:adf:b92d:: with SMTP id k42-v6mr1887922wrf.116.1528380370024;
        Thu, 07 Jun 2018 07:06:10 -0700 (PDT)
Received: from cperon-Latitude-7490.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id 135-v6sm2032331wmx.21.2018.06.07.07.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:06:09 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH v6 5/5] ARM: dts: imx: add missing compatible and clock properties for EPIT
Date: Thu,  7 Jun 2018 16:05:44 +0200
Message-Id: <20180607140544.22268-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180607140544.22268-1-peron.clem@gmail.com>
References: <20180607140544.22268-1-peron.clem@gmail.com>
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
