Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341F0C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA53320672
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA53320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbeLFKKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:10:03 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43835 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFKKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:10:01 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so25610001qtj.10;
        Thu, 06 Dec 2018 02:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=WKTKeeoPoovjmKjKShsP5moqkMz1DOw8oWN17x0M8e8=;
        b=KmfwfS7G+SUvNx8zIv2TfdmYGYLw9RAq5GIRQIzD9NDaukUAtEV9GbomA6cl+U7Lum
         lq8XfLFZ/VmMv8don1wG2U1xtS1/qAehaa0bCMNTU+WnEk+D72TnzZazZ1uyCN53jor8
         K58aX1kW2tje8Uib1cYeWv4GruATVylYLyMYzqQPmDSl+A4OWtcRMX6WnGpZ5CWyDhyX
         9Ylb+enoSsmW3djBWGgOu6GjkYTppbKbySGtB1cXyZqXd/QlXjKOzkeLqnEvGQz0Phm0
         rCgIc+vF9Do2FxX2OpIrhrrqdT7teB2mlGhoxvFwB6JRP+vFXAcYhq+nSgB404Dll7jz
         Y28A==
X-Gm-Message-State: AA+aEWaLkT0wI3vlznFi5Uo9VKVMn3CX9YNfnVWg8JUXTmCG+pMIExut
        wjtsEl+rzZzukEF09zpUmqA=
X-Google-Smtp-Source: AFSGD/VmrVimEgdKdD+sPPVmytPqbMHUgsnGu5AHK3undpvWKcC1Q+bgEByHc6ZtPx7txc4VyEOndg==
X-Received: by 2002:ac8:498c:: with SMTP id f12mr26160102qtq.130.1544091000634;
        Thu, 06 Dec 2018 02:10:00 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id t43sm14033213qtc.53.2018.12.06.02.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 02:09:59 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Thu, 06 Dec 2018 08:09:53 -0200
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
Subject: [PATCH v2 6/9] ARM: dts: imx7d-pico: Improve WiFi regulator name
Date:   Thu,  6 Dec 2018 08:09:02 -0200
Message-Id: <20181206100905.15053-7-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206100905.15053-1-otavio@ossystems.com.br>
References: <20181206100905.15053-1-otavio@ossystems.com.br>
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

Changes in v2: None

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

