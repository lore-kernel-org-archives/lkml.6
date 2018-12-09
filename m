Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55269C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 13:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C612081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 13:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNTI8/6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C612081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeLINyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 08:54:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46290 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeLINyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 08:54:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so7880719wrt.13;
        Sun, 09 Dec 2018 05:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nvq5FeHdEvsC0QZW7YnkE+ErsIu1+CoQUcHwhHtd2Mw=;
        b=oNTI8/6I/N+Lri3nlZqGuDVy43qFNHyxQMnQD2ym+vqTGdRJG27o2kM/6CJIWLW8b8
         7Zh/O+T5cgUPLzQygnhoUIMOMwgrpmmO0VXGoBOnVU4VZFXreIogQknsUqwCkbbqe7+6
         wm9DYyT6Of3UsVhlHLawK1SeGdptancOtD3yy6bfLRNOawPix2OKKcPOfueWJgxf/KRn
         MzM8FwsagwWk55bp007X+PPisBRR61cp0+RcaVe8sjuA9JaU9q3HjgzQHUZi5TcC9KvZ
         m3UEHwXmzqKOd2AXd/YB4ipZivTl/yH2kZb3itM+nM/VMNlQz3i24AY/EPpiYendhgxM
         eHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nvq5FeHdEvsC0QZW7YnkE+ErsIu1+CoQUcHwhHtd2Mw=;
        b=UU0aUy2kvrY6/4jbtJVkrzsUGv1AQh2HuzpMDnLUGLBVkkDSvumxzaflYJnm/XlHgs
         bHq2L4Odw6e8Cw2jkUfpIL+BA6n2D+K6oqwKg3QhP5n4ww13/hNlMNPdY3AlZmuOpr3i
         G2I7rUA2ebX+8O1zKkZ6gaCnoAnS+yKrUnd0jTllUHfa3Kr2/FpE3+TMCcA2ea8qaceY
         AiayT1IOY99In7OtHsAInOQ8vEKhBsm0gFOlvw/ikPUfv7I+du8JwsA7OaLtjNq0BWuC
         MisuAvssRwECArLlni1FDmyMJmX5BjAu+9ih4Fcu0FYWrmO1xPxlTuhHFSTVmJbm/X26
         lnYg==
X-Gm-Message-State: AA+aEWbNm7/7uuFcvJbig8SFS64dw2WfGQmkdzzaD/jmgt6guD1jwDeq
        z4Ma6uuF98ks08vJamHlWokzBGBUcBU=
X-Google-Smtp-Source: AFSGD/VhyUmIRtPC1D93cWFMO2ecJtzWUe6d6EFp5CsCV6CKLI48EhgF/ZM3TPrZR2fpTzLZzDoqpA==
X-Received: by 2002:adf:f401:: with SMTP id g1mr7257279wro.103.1544363668064;
        Sun, 09 Dec 2018 05:54:28 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (dgv239.neoplus.adsl.tpnet.pl. [83.23.177.239])
        by smtp.gmail.com with ESMTPSA id k128sm12271795wmd.37.2018.12.09.05.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Dec 2018 05:54:27 -0800 (PST)
From:   cezary.gapinski@gmail.com
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
Subject: [PATCH 4/5] ARM: dts: stm32: add SPI support on STM32F429 SoC
Date:   Sun,  9 Dec 2018 14:53:55 +0100
Message-Id: <1544363636-12161-5-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
References: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

This patch adds all SPI instances of the STM32F429 SoC.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 8d6f028..8dbec00 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -314,6 +314,26 @@
 			status = "disabled";
 		};
 
+		spi2: spi@40003800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f4-spi";
+			reg = <0x40003800 0x400>;
+			interrupts = <36>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(SPI2)>;
+			status = "disabled";
+		};
+
+		spi3: spi@40003C00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f4-spi";
+			reg = <0x40003C00 0x400>;
+			interrupts = <51>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(SPI3)>;
+			status = "disabled";
+		};
+
 		usart2: serial@40004400 {
 			compatible = "st,stm32-uart";
 			reg = <0x40004400 0x400>;
@@ -523,6 +543,26 @@
 			status = "disabled";
 		};
 
+		spi1: spi@40013000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f4-spi";
+			reg = <0x40013000 0x400>;
+			interrupts = <35>;
+			clocks = <&rcc 0 STM32F4_APB2_CLOCK(SPI1)>;
+			status = "disabled";
+		};
+
+		spi4: spi@40013400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f4-spi";
+			reg = <0x40013400 0x400>;
+			interrupts = <84>;
+			clocks = <&rcc 0 STM32F4_APB2_CLOCK(SPI4)>;
+			status = "disabled";
+		};
+
 		syscfg: system-config@40013800 {
 			compatible = "syscon";
 			reg = <0x40013800 0x400>;
@@ -587,6 +627,26 @@
 			};
 		};
 
+		spi5: spi@40015000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f4-spi";
+			reg = <0x40015000 0x400>;
+			interrupts = <85>;
+			clocks = <&rcc 0 STM32F4_APB2_CLOCK(SPI5)>;
+			status = "disabled";
+		};
+
+		spi6: spi@40015400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f4-spi";
+			reg = <0x40015400 0x400>;
+			interrupts = <86>;
+			clocks = <&rcc 0 STM32F4_APB2_CLOCK(SPI6)>;
+			status = "disabled";
+		};
+
 		pwrcfg: power-config@40007000 {
 			compatible = "syscon";
 			reg = <0x40007000 0x400>;
-- 
2.7.4

