Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDA4C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8668E23FD9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hxN8HdUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8668E23FD9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932933AbeGFOnP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:43:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35390 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932612AbeGFOnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:43:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id h40-v6so4445388wrh.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 07:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=qCNnR86Cw8AyGhCJOnz8hTrxVhif/iokCoLw2iFdxwM=;
        b=hxN8HdULpVLaJBC3IYO+neMXN8Y3zYoFE6fusYsWU3JVzF5oKMTt7LEXiTlIf6OjE/
         RfYdIK70entwr8Mm+J9xRbgoOpy5IF1kw99a8P40pRuuNZV8bHAl+jJmzQtouIgoIqQn
         2iPHS20IeK2eJf8dw3OxF5S8MTtaT6KhC6xThWkG2Vq+u/wHoA0O7gWjxW6kFp7gPIbT
         GgXz05uyLvbEPOxYReWCsnU2Q18hdjqMjcELALq2/xLlECSghQm3bAW4lDp14DPU/EOj
         SrP2yKJPgRg7hlrbPVMTeZGQoXI5LX6vajFMpYg9i5jljVFmC24ns75Y6BbS5n0cijSv
         p2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qCNnR86Cw8AyGhCJOnz8hTrxVhif/iokCoLw2iFdxwM=;
        b=Br/bXdGgLr5PnL2F0iR5TBPHXVrEoBfASt0rYiaeb2zgd78dxGhXt6TFaYt796zsi6
         lica8nttjgQhDi5KhsQgRfVuNF1YPBGy5CC4q1Q4SSn7qVu5nmjxqE6XvjAqD9TtTIwz
         vpuR6DvNjdJu5Gt3x2IBl35Av7uzDM0iiqMC0vz1kpr+M3RQDrRhBZJ3Cwf+EsGlB3xL
         oRcfACwmkdt+TJrL1okvRew4AwMwOL5o84SmsFA2lIWbIQxkPXUsjnVfejrJDBiZtMgc
         PFGpWt6/8svdPd8NQWeUap6XTLu+ThBRLzrH19KmNO8DUxeivDqBjNzx4gmz71beddqN
         68TA==
X-Gm-Message-State: APt69E1g6nMtFz53BA3dAkiOLWcZAPN1RUTgjyMZjEpKomdwrIV2+jFq
        tTL8+Cq9GCGV/bjV7JVC7Un08TTN
X-Google-Smtp-Source: AAOMgpesLPIgN8AxJwaIWvIkevA3wXFUXH/xLHBFx4rtR9yvxdG/AsJkRUafMUHLpnSCSQSn0HxxmQ==
X-Received: by 2002:adf:b3d4:: with SMTP id x20-v6mr8086742wrd.272.1530888191454;
        Fri, 06 Jul 2018 07:43:11 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id y13-v6sm21357451wrc.55.2018.07.06.07.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 07:43:10 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] ARM64: dts: meson-axg: add the audio clock controller
Date:   Fri,  6 Jul 2018 16:43:05 +0200
Message-Id: <20180706144305.30116-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the audio clock controller which is part of the audio bus
This controller takes 8 input plls, and the usual clock gate, from the
main clock controller. It provides the clocs for the all the devices of
the audio subsystem, such as tdms, spdif, pdm, etc.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

Resend to fix typo reported by Martin in the commit description.
(Thx Martin !)

Kevin,

Please note that this change depends on the axg audio clock bindings [0].
It explains the problem reported by kbuild robot
It will be part of our PR to clock in this cycle.

As usual, I've prepared a topic branch with the DT changes for you.
Please, let me know when you need a tag on it.

Cheers
Jerome

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

