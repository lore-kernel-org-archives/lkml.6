Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB2DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941BF20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIsgTYwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941BF20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeH3Tsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34144 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbeH3Tsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id g33-v6so8533049wrd.1;
        Thu, 30 Aug 2018 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y/Fj6KILOvy4Hub0AlnmhTfrUDXUWebrPBRvX31vXgc=;
        b=TIsgTYwpO0JSXsFCAR1gBgU4yOWMOe7YlHBfRlrGLorlzSjKvfBEMgg5cZt11Oud2j
         i2DU+7SYH/UXgrqjScKBzQwBtQrpdWU9JP2Er/9rOkXzlqkKrNJIVsoHQ7opKHMlso6/
         dhslqj6NMOMt8pkEIkvJzkiP0tE0ni3IK/VhmYJrpx7OMb+BjvCTrUzpRn4Itwl5bbxg
         mlDVB9w1rF4pLCa85smzJZMdbdzlbGMzhvN32mie0bhHoH7vnoqFqxRyfD3pwr3aai2S
         MITLssiZJ2Od90VcPFzI4BijdPDVhDd1S9F0cnRKThVTQunMt6pd+QGNwfyOX/WZyqhz
         HKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y/Fj6KILOvy4Hub0AlnmhTfrUDXUWebrPBRvX31vXgc=;
        b=dHtcqfw/Y1KHhmqUkfj8NHb+7TgGKtmc5PvJj2XYYWt1oZLbWQls6E+VPxxjYUcP2N
         DXCNIMvyQjkZfMGc/hcqAMbBgrf/jrwBtpmlylNPy6NmJmggMOlapgV0xFUYun0itGvl
         QyNr+7dY6gGoQu8ns/bIvw0H3bmaq92ihSC2P7NNaGpuCwhzKJlPdYWUm0WtZ6bvwL7H
         uBl5LSRAkuAthLddI9g/or7W4fan0zpKmNvQS21VMGawpPJY1CuztA+bHrcSYqJKILDi
         +tC5hyAweJNcV4glT4oL8INDR1YnNsIPBlcCuNpSXv5HRuJybQk0IyaEyvy9wQFiH0X0
         bRGg==
X-Gm-Message-State: APzg51Bo2UBKV2+kh3cClF7TrO32+iw4Mr5v3qIEVRZJfVPpQ1OcAr4Z
        2mJ0snUKnzSDlT8xtoDIAQI=
X-Google-Smtp-Source: ANB0Vdbc61xQJObw7vzUpdLQCS/u4BaJGuaWXTUg2M+HtFLPJancYx3rVv+/+CbFv0zcDYP+W/DtZw==
X-Received: by 2002:adf:ffc7:: with SMTP id x7-v6mr3502999wrs.137.1535643950090;
        Thu, 30 Aug 2018 08:45:50 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:49 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 28/30] ARM: dts: sun8i: a83t: add support for the thermal sensor in A83T
Date:   Thu, 30 Aug 2018 17:45:16 +0200
Message-Id: <20180830154518.29507-29-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we have gained the support for the thermal sensor in A83T,
we can now add its device nodes to the device tree.

The A83T seems to have a broken IRQ 31, thus we use here IRQ 41.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 2be23d600957..f2f745930b08 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -757,6 +757,14 @@
 			clocks = <&osc24M>;
 		};
 
+		ths: thermal-sensor@1f04000 {
+			compatible = "allwinner,sun8i-a83t-ths";
+			reg = <0x01f04000 0x100>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			#thermal-sensor-cells = <1>;
+			#io-channel-cells = <0>;
+		};
+
 		watchdog@1c20ca0 {
 			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x01c20ca0 0x20>;
-- 
2.11.0

