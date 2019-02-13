Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00348C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B01222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDWzlYBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392151AbfBMMeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:34:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34070 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392137AbfBMMeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:34:12 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so1113705plz.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 04:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=5wfuddSW6tp5kYw+zApWLVum/WpZ+TiS9aNH3MKdYzo=;
        b=YDWzlYBrahihGwb5mYJoLKo/xZVNfbd33CPt1cbrzZWuoYd4mrO9sghY/jilXAFcPb
         b+yIqYLo+3iLfK4qo47FIeJm2alKAr0zD7IigOBYuDuxyVSpMP81wwKWqbTBYYM32ikY
         7eP1H9UzdYWPJFg2EjQnEimpR2CCNOZFBn4j1318kKvcCLVBMmufv0TQAAgb3M4oLi1l
         30XJVvAP2EU26QLC1+acFBj30jN9YNYmUNZ9h8iy2/P/sF5ZNAOJHkXaW5iopbmtTGVe
         6FnpZ6gyNHgcI2r4cNt4APQ10EgSKsA5vc7FTpYqtJ3E7dF+lR4m5xxIEi9dEOxUb171
         KI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=5wfuddSW6tp5kYw+zApWLVum/WpZ+TiS9aNH3MKdYzo=;
        b=NyaQHyr7tIe+fjF467bLc+Aw0pX4LhUstjqAxwMmPwU2HAEmRfd/yr0etPvMpz98Um
         /rU6YH+xxpVgnztXjbh4vSBNOhFDaxEYGZ/Qt1hlv+LLsxIGaRmBg326v+EKYZwlykaV
         GHH1z9C8xOLUUz3BbXIJzoIyETo22sRRla8pekwfJalqiWyoxuA9m594eGypPcTSFBCY
         eUehG+ONlGTiyG5aAAQfNDhWlzlKeAXfF8ohTO80uO+X1Uy7+1yqZvQe10d4C8cJiXdD
         ZkgGECVI8T98M2d2H2ARHqZCUImB6EEKE93H9ffC7lCw3vlgEJq5OUazsBL+nkvNAnGQ
         hQ3Q==
X-Gm-Message-State: AHQUAuZ/kWEBYd/zQ75KldpiDQV4hqHxRxvcOGL1y05hjgFDsVUf2fh9
        pLfzk/LukuMaSNEWpj4dRDd0Tg==
X-Google-Smtp-Source: AHgI3IaSAf6j7onzDfTCKd/8Gy4kNKVuhVwJS5+E/ZiiK7RgY9Mi89ivH5Pa1AS62RhmQ6pxvoD77A==
X-Received: by 2002:a17:902:bd0b:: with SMTP id p11mr274548pls.259.1550061251528;
        Wed, 13 Feb 2019 04:34:11 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id l5sm21223640pgl.51.2019.02.13.04.34.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 04:34:10 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de
Cc:     olof@lixom.net, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH v2 1/5] arm64: dts: sprd: Remove PMIC INTC irq trigger type
Date:   Wed, 13 Feb 2019 20:32:45 +0800
Message-Id: <b6a32917d1e231277d240a4084bebb6ad91247e3.1550060544.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1550060543.git.baolin.wang@linaro.org>
References: <cover.1550060543.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1550060543.git.baolin.wang@linaro.org>
References: <cover.1550060543.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Spreadtrum PMIC INTC controller has no registers to set trigger type,
since it is always high level trigger as default. So remove its child
devices' irq trigger type setting and change #interrupt-cells to 1.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index 82bd642..f2f2aa5 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -13,7 +13,7 @@
 		spi-max-frequency = <26000000>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-controller;
-		#interrupt-cells = <2>;
+		#interrupt-cells = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
@@ -43,14 +43,14 @@
 			compatible = "sprd,sc27xx-rtc", "sprd,sc2731-rtc";
 			reg = <0x280>;
 			interrupt-parent = <&sc2731_pmic>;
-			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <2>;
 		};
 
 		pmic_eic: gpio@300 {
 			compatible = "sprd,sc27xx-eic";
 			reg = <0x300>;
 			interrupt-parent = <&sc2731_pmic>;
-			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <5>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -69,7 +69,7 @@
 			compatible = "sprd,sc27xx-adc", "sprd,sc2731-adc";
 			reg = <0x480>;
 			interrupt-parent = <&sc2731_pmic>;
-			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <0>;
 			#io-channel-cells = <1>;
 			hwlocks = <&hwlock 4>;
 		};
-- 
1.7.9.5

