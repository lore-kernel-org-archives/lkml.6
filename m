Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CA8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBC7206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jg4iMty1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbeLNRCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:02:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45623 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbeLNRB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:01:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so5939665wrr.12;
        Fri, 14 Dec 2018 09:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B4O8JfeatvChFkMk3EJAU/HG6cwjD/q0Myik3lvKlpI=;
        b=Jg4iMty11a6nDq4Wto2EquzEo7uhQjiAi6VqymiKUXBc4rJ/MfYwihaJvSS1siw9g8
         r2a0xFy7h9VjywbBacCv6Tses+E4eR2MUPWoj8vGg3Rdgy7dhB35b2K7VaopmvZSSvyp
         9zR1+yWV6uMhLAwU+2XZWw3Bd3IfIF9gfKkhF+1/Nt+MC4BiMa9amXPCz5c4uhZ8i7pH
         2uYXkPjH/jswElmhZi4wOZ3ck4K1NknoGAEfTdb4CWn7Y7UG6tz5pzEdmIYyz1bxJs/R
         8Ft1oQnk++BOI6kHqkyXJI7SKRAI4QhlD0qyND/bjfoyOCi09scvOPOPLBfBUSC41Kcq
         Metw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B4O8JfeatvChFkMk3EJAU/HG6cwjD/q0Myik3lvKlpI=;
        b=h0Shg3CSDRA/gXGw5EJW6gJnLBx0aYHhFNOz4kIBxmGtbe7wvFJ0QFrAdneLAhw+SI
         UUyI5hf+rkqhXexO9m+lzn9p0GqVdY0p4oYVSNcq4jx+qG7UTLVo40W122gZ0wK2tjFs
         R17eGsr+tztjEncc+1BnRbYLocqSyNvVqn+TxAtdBH8YHHqpasSgCrCOjP7SmqxQOz5p
         EAlpPjQi4bshOHdYBUxXw7hUOov9IGli1IPXIyGEKSqiymJv4XgAMdMGFFmLfbSPQHVG
         Fv8OubRkU0gGfQgH9hbIBrRTNEZcfFb8CEn7mp4bspTqMvoPhgVD9TnBS3pvH25vw2PV
         rtEQ==
X-Gm-Message-State: AA+aEWazPYqZVsmdE9MAqVyjpcf3JKfPYmlQK+LYFZgPp/nW5jbpLKNv
        1d2dzvUubz8uZ6TQY8RA2xCciUZLpVn9Cy8BBsw=
X-Google-Smtp-Source: AFSGD/W5yvqsfM6loVKCkBHNQHEQXMq2kLJfFVorS7xNJ6Nr7JWBWvUMjygdld8PL8YjlnMcnMTNbg==
X-Received: by 2002:a05:6000:1c8:: with SMTP id t8mr3346074wrx.146.1544806915609;
        Fri, 14 Dec 2018 09:01:55 -0800 (PST)
Received: from centos-2gb-nbg1-1.localdomain (static.211.22.203.116.clients.your-server.de. [116.203.22.211])
        by smtp.gmail.com with ESMTPSA id 60sm7687814wrb.81.2018.12.14.09.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 09:01:54 -0800 (PST)
From:   jakob.wuhrer@gmail.com
To:     andy.gross@linaro.org, david.brown@linaro.org
Cc:     Jakob Wuhrer <jakobwuhrer@airmail.cc>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: Add more msm8996 uarts
Date:   Fri, 14 Dec 2018 18:01:31 +0100
Message-Id: <1544806891-12516-2-git-send-email-jakob.wuhrer@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544806891-12516-1-git-send-email-jakob.wuhrer@gmail.com>
References: <1544806891-12516-1-git-send-email-jakob.wuhrer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakob Wuhrer <jakobwuhrer@airmail.cc>

msm8996 has 12 uarts, but the devicetree only lists 3. Add the
pinmuxing and the main devicetree entries for the others.

Signed-off-by: Jakob Wuhrer <jakobwuhrer@airmail.cc>
---
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi | 524 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi      |  80 +++++
 2 files changed, 604 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
index 1d1f7f9..99056b6 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
@@ -495,4 +495,528 @@
 			bias-disable;
 		};
 	};
+
+	blsp1_uart0_2pins_default: blsp1_uart0_2pins {
+		pinmux {
+			function = "blsp_uart1";
+			pins = "gpio0", "gpio1";
+		};
+		pinconf {
+			pins = "gpio0", "gpio1";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart0_2pins_sleep: blsp1_uart0_2pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio0", "gpio1";
+		};
+		pinconf {
+			pins = "gpio0", "gpio1";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart0_4pins_default: blsp1_uart0_4pins {
+		pinmux {
+			function = "blsp_uart1";
+			pins = "gpio0", "gpio1", "gpio2", "gpio3";
+		};
+
+		pinconf {
+			pins = "gpio0", "gpio1", "gpio2", "gpio3";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart0_4pins_sleep: blsp1_uart0_4pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio0", "gpio1", "gpio2", "gpio3";
+		};
+
+		pinconf {
+			pins = "gpio0", "gpio1", "gpio2", "gpio3";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart1_2pins_default: blsp1_uart1_2pins {
+		pinmux {
+			function = "blsp_uart2";
+			pins = "gpio41", "gpio42";
+		};
+		pinconf {
+			pins = "gpio41", "gpio42";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart1_2pins_sleep: blsp1_uart1_2pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio41", "gpio42";
+		};
+		pinconf {
+			pins = "gpio41", "gpio42";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart1_4pins_default: blsp1_uart1_4pins {
+		pinmux {
+			function = "blsp_uart2";
+			pins = "gpio41", "gpio42", "gpio43", "gpio44";
+		};
+
+		pinconf {
+			pins = "gpio41", "gpio42", "gpio43", "gpio44";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart1_4pins_sleep: blsp1_uart1_4pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio41", "gpio42", "gpio43", "gpio44";
+		};
+
+		pinconf {
+			pins = "gpio41", "gpio42", "gpio43", "gpio44";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart2_2pins_default: blsp1_uart2_2pins {
+		pinmux {
+			function = "blsp_uart3";
+			pins = "gpio45", "gpio46";
+		};
+		pinconf {
+			pins = "gpio45", "gpio46";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart2_2pins_sleep: blsp1_uart2_2pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio45", "gpio46";
+		};
+		pinconf {
+			pins = "gpio45", "gpio46";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart2_4pins_default: blsp1_uart2_4pins {
+		pinmux {
+			function = "blsp_uart3";
+			pins = "gpio45", "gpio46", "gpio47", "gpio48";
+		};
+
+		pinconf {
+			pins = "gpio45", "gpio46", "gpio47", "gpio48";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart2_4pins_sleep: blsp1_uart2_4pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio45", "gpio46", "gpio47", "gpio48";
+		};
+
+		pinconf {
+			pins = "gpio45", "gpio46", "gpio47", "gpio48";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart3_2pins_default: blsp1_uart3_2pins {
+		pinmux {
+			function = "blsp_uart4";
+			pins = "gpio65", "gpio66";
+		};
+		pinconf {
+			pins = "gpio65", "gpio66";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart3_2pins_sleep: blsp1_uart3_2pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio65", "gpio66";
+		};
+		pinconf {
+			pins = "gpio65", "gpio66";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart3_4pins_default: blsp1_uart3_4pins {
+		pinmux {
+			function = "blsp_uart4";
+			pins = "gpio65", "gpio66", "gpio67", "gpio68";
+		};
+
+		pinconf {
+			pins = "gpio65", "gpio66", "gpio67", "gpio68";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart3_4pins_sleep: blsp1_uart3_4pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio65", "gpio66", "gpio67", "gpio68";
+		};
+
+		pinconf {
+			pins = "gpio65", "gpio66", "gpio67", "gpio68";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart4_2pins_default: blsp1_uart4_2pins {
+		pinmux {
+			function = "blsp_uart5";
+			pins = "gpio81", "gpio82";
+		};
+		pinconf {
+			pins = "gpio81", "gpio82";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart4_2pins_sleep: blsp1_uart4_2pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio81", "gpio82";
+		};
+		pinconf {
+			pins = "gpio81", "gpio82";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart4_4pins_default: blsp1_uart4_4pins {
+		pinmux {
+			function = "blsp_uart5";
+			pins = "gpio81", "gpio82", "gpio83", "gpio84";
+		};
+
+		pinconf {
+			pins = "gpio81", "gpio82", "gpio83", "gpio84";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart4_4pins_sleep: blsp1_uart4_4pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio81", "gpio82", "gpio83", "gpio84";
+		};
+
+		pinconf {
+			pins = "gpio81", "gpio82", "gpio83", "gpio84";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart5_2pins_default: blsp1_uart5_2pins {
+		pinmux {
+			function = "blsp_uart6";
+			pins = "gpio25", "gpio26";
+		};
+		pinconf {
+			pins = "gpio25", "gpio26";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart5_2pins_sleep: blsp1_uart5_2pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio25", "gpio26";
+		};
+		pinconf {
+			pins = "gpio25", "gpio26";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart5_4pins_default: blsp1_uart5_4pins {
+		pinmux {
+			function = "blsp_uart6";
+			pins = "gpio25", "gpio26", "gpio27", "gpio28";
+		};
+
+		pinconf {
+			pins = "gpio25", "gpio26", "gpio27", "gpio28";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp1_uart5_4pins_sleep: blsp1_uart5_4pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio25", "gpio26", "gpio27", "gpio28";
+		};
+
+		pinconf {
+			pins = "gpio25", "gpio26", "gpio27", "gpio28";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart0_2pins_default: blsp2_uart0_2pins {
+		pinmux {
+			function = "blsp_uart7";
+			pins = "gpio53", "gpio54";
+		};
+		pinconf {
+			pins = "gpio53", "gpio54";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart0_2pins_sleep: blsp2_uart0_2pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio53", "gpio54";
+		};
+		pinconf {
+			pins = "gpio53", "gpio54";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart0_4pins_default: blsp2_uart0_4pins {
+		pinmux {
+			function = "blsp_uart7";
+			pins = "gpio53", "gpio54", "gpio55", "gpio56";
+		};
+
+		pinconf {
+			pins = "gpio53", "gpio54", "gpio55", "gpio56";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart0_4pins_sleep: blsp2_uart0_4pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio53", "gpio54", "gpio55", "gpio56";
+		};
+
+		pinconf {
+			pins = "gpio53", "gpio54", "gpio55", "gpio56";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart3_2pins_default: blsp2_uart3_2pins {
+		pinmux {
+			function = "blsp_uart10";
+			pins = "gpio8", "gpio9";
+		};
+		pinconf {
+			pins = "gpio8", "gpio9";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart3_2pins_sleep: blsp2_uart3_2pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio8", "gpio9";
+		};
+		pinconf {
+			pins = "gpio8", "gpio9";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart3_4pins_default: blsp2_uart3_4pins {
+		pinmux {
+			function = "blsp_uart10";
+			pins = "gpio8", "gpio9", "gpio10", "gpio11";
+		};
+
+		pinconf {
+			pins = "gpio8", "gpio9", "gpio10", "gpio11";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart3_4pins_sleep: blsp2_uart3_4pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio8", "gpio9", "gpio10", "gpio11";
+		};
+
+		pinconf {
+			pins = "gpio8", "gpio9", "gpio10", "gpio11";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart4_2pins_alt_default: blsp2_uart4_2pins_alt {
+		pinmux {
+			function = "blsp_uart11";
+			pins = "gpio100", "gpio101";
+		};
+		pinconf {
+			pins = "gpio100", "gpio101";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart4_2pins_alt_sleep: blsp2_uart4_2pins_alt_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio100", "gpio101";
+		};
+		pinconf {
+			pins = "gpio100", "gpio101";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart4_2pins_default: blsp2_uart4_2pins {
+		pinmux {
+			function = "blsp_uart11";
+			pins = "gpio58", "gpio59";
+		};
+		pinconf {
+			pins = "gpio58", "gpio59";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart4_2pins_sleep: blsp2_uart4_2pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio58", "gpio59";
+		};
+		pinconf {
+			pins = "gpio58", "gpio59";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart4_4pins_default: blsp2_uart4_4pins {
+		pinmux {
+			function = "blsp_uart11";
+			pins = "gpio58", "gpio59", "gpio60", "gpio61";
+		};
+
+		pinconf {
+			pins = "gpio58", "gpio59", "gpio60", "gpio61";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart4_4pins_sleep: blsp2_uart4_4pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio58", "gpio59", "gpio60", "gpio61";
+		};
+
+		pinconf {
+			pins = "gpio58", "gpio59", "gpio60", "gpio61";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart5_2pins_default: blsp2_uart5_2pins {
+		pinmux {
+			function = "blsp_uart12";
+			pins = "gpio85", "gpio86";
+		};
+		pinconf {
+			pins = "gpio85", "gpio86";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart5_2pins_sleep: blsp2_uart5_2pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio85", "gpio86";
+		};
+		pinconf {
+			pins = "gpio85", "gpio86";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart5_4pins_default: blsp2_uart5_4pins {
+		pinmux {
+			function = "blsp_uart12";
+			pins = "gpio85", "gpio86", "gpio87", "gpio88";
+		};
+
+		pinconf {
+			pins = "gpio85", "gpio86", "gpio87", "gpio88";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart5_4pins_sleep: blsp2_uart5_4pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio85", "gpio86", "gpio87", "gpio88";
+		};
+
+		pinconf {
+			pins = "gpio85", "gpio86", "gpio87", "gpio88";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 13bb964..c2a5062 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -435,6 +435,16 @@
 			#clock-cells = <1>;
 		};
 
+		blsp1_uart0: serial@756f000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x0756f000 0x1000>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
 		blsp1_uart1: serial@7570000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x07570000 0x1000>;
@@ -445,6 +455,76 @@
 			status = "disabled";
 		};
 
+		blsp1_uart2: serial@7571000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x07571000 0x1000>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART3_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		blsp1_uart3: serial@7572000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x07572000 0x1000>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART4_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		blsp1_uart4: serial@7573000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x07573000 0x1000>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART5_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		blsp1_uart5: serial@7574000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x07574000 0x1000>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART6_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		blsp2_uart3: serial@75b2000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x075b2000 0x1000>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_UART4_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		blsp2_uart4: serial@75b3000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x075b3000 0x1000>;
+			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_UART5_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		blsp2_uart5: serial@75b4000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x075b4000 0x1000>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_UART6_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
 		blsp1_spi0: spi@7575000 {
 			compatible = "qcom,spi-qup-v2.2.1";
 			reg = <0x07575000 0x600>;
-- 
1.8.3.1

