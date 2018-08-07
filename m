Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E9AC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714E62198F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Fqq1ENJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714E62198F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388710AbeHGJVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:21:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42135 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388573AbeHGJVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:21:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so8098662pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 00:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BKOTPjfJZW4OCrb9bru7V1U96G3xnU+1nIGLlZK1D8o=;
        b=Fqq1ENJRS0Vb5JKgDhXlWPkpCW0/E6DEfbu5obPtu9oogm2ZYzuuCMjKR/iZ6b8Jrd
         Qg4EP6tVQ9x2lTSIf/smMYpXrb/PspdGKJKCd/RpREJXqIthv8JEzSBn4fkBiTXqMLVm
         GiYL+2IjOyH+mA1cnt6XyXviWogEljkCUI0H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKOTPjfJZW4OCrb9bru7V1U96G3xnU+1nIGLlZK1D8o=;
        b=biNOci7LQYjmsoaSRAmvImhWTxN4k+5sSAGKdUODVvUXUqOe9YaNt6dKutBEFRyQJN
         x6wvWyG4y/UtEbBmGrnzF++axkPMFM1kVOPC8GF1TJ3p2z3+yfm8uRawr6BoZiMjutaU
         NB8cyQahfbkIVbRuB/VxAl5YQiByMnMTNoOpGoais0KRqTyhCMUTndSg37RgyWaDDDks
         dFM4gtEdqg/jpPYiXY6ocvqSys/y1BUcjl+rPu6x6TQH3f17LAZXGCznlvPnC+kBZEuv
         uARaBY6NWA6uhysqlDVFz1U8KnxQGMwY+lmpKu5KztFJtpd3XZaGb39VQG5MB3WZA8Ra
         aXDA==
X-Gm-Message-State: AOUpUlEk2wGWQiPh/1+v/FZoDy4MrambegLsbPTunBMtkkJ+ricwifiS
        MWpqimivU5IpY8KZL5hBhDhMlA==
X-Google-Smtp-Source: AAOMgpcrD01nfbgKcCPNCvWn0uzV3hM8zoFcAlkUlZt4Fl42yY5U4tz2Kw4x5LZbDE4IF5qKQNlpKw==
X-Received: by 2002:a62:2c95:: with SMTP id s143-v6mr14094932pfs.3.1533625734114;
        Tue, 07 Aug 2018 00:08:54 -0700 (PDT)
Received: from localhost.localdomain ([183.82.226.112])
        by smtp.gmail.com with ESMTPSA id a15-v6sm1373195pfe.32.2018.08.07.00.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 00:08:53 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/3] ARM: dts: imx6ul-isiot: Move node definitions into dtsi
Date:   Tue,  7 Aug 2018 12:38:37 +0530
Message-Id: <20180807070838.24685-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20180807070838.24685-1-jagan@amarulasolutions.com>
References: <20180807070838.24685-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move usdhc2 and gpmi along with pinctrl nodes on
imx6ul-isiot.dtsi from dts files and mark it as 'disabled'
and the relevant dts will enable the status as 'okay'

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6ul-isiot-emmc.dts | 23 -----------
 arch/arm/boot/dts/imx6ul-isiot-nand.dts | 25 ------------
 arch/arm/boot/dts/imx6ul-isiot.dtsi     | 52 +++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 48 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-isiot-emmc.dts b/arch/arm/boot/dts/imx6ul-isiot-emmc.dts
index 464bd21930fd..1df3e376ae2c 100644
--- a/arch/arm/boot/dts/imx6ul-isiot-emmc.dts
+++ b/arch/arm/boot/dts/imx6ul-isiot-emmc.dts
@@ -14,28 +14,5 @@
 };
 
 &usdhc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc2>;
-	cd-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>;
-	bus-width = <8>;
-	no-1-8-v;
 	status = "okay";
 };
-
-&iomuxc {
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX6UL_PAD_NAND_RE_B__USDHC2_CLK      0x17070
-			MX6UL_PAD_NAND_WE_B__USDHC2_CMD      0x10070
-			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0  0x17070
-			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1  0x17070
-			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2  0x17070
-			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3  0x17070
-			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4  0x17070
-			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5  0x17070
-			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6  0x17070
-			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7  0x17070
-			MX6UL_PAD_NAND_ALE__USDHC2_RESET_B   0x17070
-		>;
-	};
-};
diff --git a/arch/arm/boot/dts/imx6ul-isiot-nand.dts b/arch/arm/boot/dts/imx6ul-isiot-nand.dts
index 84420ed47106..8c26d4d1a7bf 100644
--- a/arch/arm/boot/dts/imx6ul-isiot-nand.dts
+++ b/arch/arm/boot/dts/imx6ul-isiot-nand.dts
@@ -14,30 +14,5 @@
 };
 
 &gpmi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	nand-on-flash-bbt;
 	status = "okay";
 };
-
-&iomuxc {
-	pinctrl_gpmi_nand: gpmi-nand {
-		fsl,pins = <
-			MX6UL_PAD_NAND_CLE__RAWNAND_CLE         0xb0b1
-			MX6UL_PAD_NAND_ALE__RAWNAND_ALE         0xb0b1
-			MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B       0xb0b1
-			MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B 0xb000
-			MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B     0xb0b1
-			MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B       0xb0b1
-			MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B       0xb0b1
-			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00   0xb0b1
-			MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01   0xb0b1
-			MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02   0xb0b1
-			MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03   0xb0b1
-			MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04   0xb0b1
-			MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05   0xb0b1
-			MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06   0xb0b1
-			MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07   0xb0b1
-		>;
-	};
-};
diff --git a/arch/arm/boot/dts/imx6ul-isiot.dtsi b/arch/arm/boot/dts/imx6ul-isiot.dtsi
index ba66225fe86e..fe435484e69d 100644
--- a/arch/arm/boot/dts/imx6ul-isiot.dtsi
+++ b/arch/arm/boot/dts/imx6ul-isiot.dtsi
@@ -97,6 +97,13 @@
 	};
 };
 
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	nand-on-flash-bbt;
+	status = "disabled";
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -207,6 +214,15 @@
 	status = "okay";
 };
 
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	cd-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>;
+	bus-width = <8>;
+	no-1-8-v;
+	status = "disabled";
+};
+
 &iomuxc {
 	pinctrl_enet1: enet1grp {
 		fsl,pins = <
@@ -223,6 +239,26 @@
 		>;
 	};
 
+	pinctrl_gpmi_nand: gpmi-nand {
+		fsl,pins = <
+			MX6UL_PAD_NAND_CLE__RAWNAND_CLE         0xb0b1
+			MX6UL_PAD_NAND_ALE__RAWNAND_ALE         0xb0b1
+			MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B       0xb0b1
+			MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B 0xb000
+			MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B     0xb0b1
+			MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B       0xb0b1
+			MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B       0xb0b1
+			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00   0xb0b1
+			MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01   0xb0b1
+			MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02   0xb0b1
+			MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03   0xb0b1
+			MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04   0xb0b1
+			MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05   0xb0b1
+			MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06   0xb0b1
+			MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07   0xb0b1
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX6UL_PAD_UART4_TX_DATA__I2C1_SCL 0x4001b8b0
@@ -330,4 +366,20 @@
 			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3 0x170f9
 		>;
 	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK      0x17070
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD      0x10070
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0  0x17070
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1  0x17070
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2  0x17070
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3  0x17070
+			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4  0x17070
+			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5  0x17070
+			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6  0x17070
+			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7  0x17070
+			MX6UL_PAD_NAND_ALE__USDHC2_RESET_B   0x17070
+		>;
+	};
 };
-- 
2.18.0.321.gffc6fa0e3

