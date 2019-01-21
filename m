Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E637C282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D013C20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TBJVsmq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfAUHjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:39:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33459 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbfAUHj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:39:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so9416878plo.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=5wfuddSW6tp5kYw+zApWLVum/WpZ+TiS9aNH3MKdYzo=;
        b=TBJVsmq9SwsUa5AhC2yO9XS+8Y2Gb8Kr8LjezLadJmuXsgGfusLZJVottgxoApjWA1
         NUBiI3D9z/5C9zLI24XFGOP7gg7sBHd+O6mUScFWUjqS0CaZUep5sD79sl0uH7ydjhB+
         HaXic/wvGDMxjQi4MwJa6LzT29QvfIxs6yf/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=5wfuddSW6tp5kYw+zApWLVum/WpZ+TiS9aNH3MKdYzo=;
        b=EcM7DvkmW6t8c0U1VecIB4l9idLOqOesw4orSlx2ErP966s7ghAz5tqGvWGMYFOZ4J
         VrJ3d/Tefjl+08lajSIW+KkDUaNBHpRwU45+Z5ptuPotfOtgwQ+axwnd0GCOnon1QmK4
         Hw5vJLXHOVVxEXG+euK3uFcCGAJ1eOpjzEZ/JdReH6+QDJpfnXsyBg01qPmCD5pYQSZM
         dyXpuE7fcJYESF6kIKiU1U2r8mtGK9s1kzWcwYXrmoDzL8PoC4yMFF+H5o+Djt1Q8KqW
         xJ04uidad0aeFJHnWYyIE93jTTwhZEIvO7rSaXQN1a14Q0tRfZKZGPWKy6dNM4BZqoK0
         40FA==
X-Gm-Message-State: AJcUukdG222jcZYvx7W+D+sW7fnISE+MRL86pcRvPvXTCFkJw+Ur3WQg
        4KVzOW4Yx3d4PzlZcmDhebwg7w==
X-Google-Smtp-Source: ALg8bN4b+zcG8uMM54HVPij1o+1kGsedHZcVQYga9e1/iukaWsgMw+36iYZJ6Tg0h0ZeRIOKfy2lKQ==
X-Received: by 2002:a17:902:b090:: with SMTP id p16mr29147808plr.190.1548056368629;
        Sun, 20 Jan 2019 23:39:28 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h19sm15583083pfn.114.2019.01.20.23.39.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Jan 2019 23:39:27 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        olof@lixom.net, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 1/4] arm64: dts: sprd: Remove PMIC INTC irq trigger type
Date:   Mon, 21 Jan 2019 15:38:28 +0800
Message-Id: <b6a32917d1e231277d240a4084bebb6ad91247e3.1548052878.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1548052878.git.baolin.wang@linaro.org>
References: <cover.1548052878.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1548052878.git.baolin.wang@linaro.org>
References: <cover.1548052878.git.baolin.wang@linaro.org>
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

