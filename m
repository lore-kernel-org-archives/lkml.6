Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4B4C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7D62242B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="w9oBE1kR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7D62242B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753861AbeGELhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:37:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40495 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753499AbeGELhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:37:22 -0400
Received: by mail-wm0-f66.google.com with SMTP id z13-v6so10303911wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 04:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=qku/T/pR5C6YXO7lG6OESExkwmaRoJeCJ/Pf+ChRuAQ=;
        b=w9oBE1kRV6TMmeR2bR/w02wye+irGNyKfQM5C9wfbiHMaailgUBKV/97qOg9WSkRml
         P+F6WC3VZ3w4LfJ0DgqgNpHs65zGvi3eMsfqwjg4Uyx5NMpcCUPCBAQEJvp1du2kuHD2
         7VvbmpboXKgc7mTX5P4wo+QaKDUjN1vBKPEDYqt2iB7Y/pLNDSPSfL1gPBkQfyyegzEU
         DqmV3Z26hytyaDyZGH5xDEJDFTDXjA9fCpiQDa0FnQsaDnRuljpxSWrUep9eDfXVAbXY
         xGfac7fv9lISQnfYWeaXLlpJheKdUNxhj23P/GJVw91M+AfoVdQI+OCPpqIChawuOUSA
         uKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qku/T/pR5C6YXO7lG6OESExkwmaRoJeCJ/Pf+ChRuAQ=;
        b=NbXo+zHYG/IH3LHZpJu2qjw3L7Zt9vSorADoB+Dyq/V+SNIToAynsWEhsH/jKwiyw1
         9K+XG1OWUPZpSW6YxG/f3xwLY6dsjNirTxjSpNxNKtSWOFlXoXR194Ykn9eSv/hPN8rS
         89VSIcha8T3lyiZUKaoPhn1YUKvmk0dLddbGREilHZbwVZQy2YFL8Lr4gOtYvJlnUmfz
         FJ+kKsvGc6mZA+nyJRpwb+86plBTIVyrwO1LKdayd9qYZ6NsR1B6T0llI7VqW97Rq7P3
         3no7b4J+qzIEdG0waDb+H58oLg+3lopcPNxurV0D/3rfWSoUqjAutRVQXf2lpBRMnTn5
         4gsA==
X-Gm-Message-State: APt69E1KinMrNHuZloDcoooN2rYRc9PggoKI9MTwDykgiZpMljYKJC4x
        qAeci5+KZWjLL7PMp1XjvRH0Zg==
X-Google-Smtp-Source: AAOMgpcsv4zH0f8fFoHeas73nIpTpU8nRflEzefIH9t/wCDNi1UVo9DB9Ljtj48tyVRmkOteBGBRtw==
X-Received: by 2002:a1c:8312:: with SMTP id f18-v6mr4036892wmd.127.1530790640978;
        Thu, 05 Jul 2018 04:37:20 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id q8-v6sm11408030wmb.3.2018.07.05.04.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 04:37:20 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM64: dts: meson-axg: add the audio clock controller
Date:   Thu,  5 Jul 2018 13:37:13 +0200
Message-Id: <20180705113713.15267-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the audio clock controller which is part of the audio bus
This controller takes 8 input plls, and the usual clock gate, from the
main clock controller. It provides for the all the devices of the audio
subsystem, such as tdms, spdif, pdm, etc.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

Kevin,

Please note that this change depends on the axg audio clock bindings [0].
It will be part of our PR to clock in this cycle.

As usual, I've prepared a topic branch with the DT changes for you.
Please, let me know when you need a tag on it.

Cheers
Jerome

[0]: https://lkml.kernel.org/r/20180522163457.13834-6-jbrunet@baylibre.com

arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index aa1a42407466..56d334be9f85 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/axg-audio-clkc.h>
 #include <dt-bindings/clock/axg-clkc.h>
 #include <dt-bindings/clock/axg-aoclkc.h>
 #include <dt-bindings/gpio/meson-axg-gpio.h>
@@ -155,6 +156,41 @@
 			};
 		};
 
+		audio: bus@ff642000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xff642000 0x0 0x2000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xff642000 0x0 0x2000>;
+
+			clkc_audio: clock-controller@0 {
+				compatible = "amlogic,axg-audio-clkc";
+				reg = <0x0 0x0 0x0 0xb4>;
+				#clock-cells = <1>;
+
+				clocks = <&clkc CLKID_AUDIO>,
+					 <&clkc CLKID_MPLL0>,
+					 <&clkc CLKID_MPLL1>,
+					 <&clkc CLKID_MPLL2>,
+					 <&clkc CLKID_MPLL3>,
+					 <&clkc CLKID_HIFI_PLL>,
+					 <&clkc CLKID_FCLK_DIV3>,
+					 <&clkc CLKID_FCLK_DIV4>,
+					 <&clkc CLKID_GP0_PLL>;
+				clock-names = "pclk",
+					      "mst_in0",
+					      "mst_in1",
+					      "mst_in2",
+					      "mst_in3",
+					      "mst_in4",
+					      "mst_in5",
+					      "mst_in6",
+					      "mst_in7";
+
+				resets = <&reset RESET_AUDIO>;
+			};
+		};
+
 		cbus: bus@ffd00000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xffd00000 0x0 0x25000>;
-- 
2.14.4

