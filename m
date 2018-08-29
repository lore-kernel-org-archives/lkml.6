Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0429C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4F02086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4F02086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbeH2MKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:38 -0400
Received: from mout.perfora.net ([74.208.4.196]:59025 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727746AbeH2MKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:37 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MCaCy-1g3DLZ1auA-009NIq; Wed, 29 Aug 2018 10:14:47 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 16/31] ARM: tegra: colibri_t20: iris: display controller rgb panel support
Date:   Wed, 29 Aug 2018 10:13:52 +0200
Message-Id: <20180829081407.11304-17-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:eVx5MtL2bI11swC1p8AdjcxSklH0HVplrOu1R1ZaLEDurhrJLab
 PnoxkXM2jJgdJZh0eJsoDHouE+Zy4fPmXNwspDi1ifND47aJyjF157d0CczKbA7KGq+yJde
 hadgNTxnxVoF8c5NA1AgsoiOLw5d2K0lC0GLb3Tn8OW/scI0PudKtn27wgcQikdBLZTl/Jv
 EgeXTthadrrO8mqqVZoGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oXZ72T5K66Q=:wanBeDJY6T2ipVCmKnRRhn
 gcsmnNeK8WlDZX8Kzt8OE+THUgsQS3lsNkRxKOOfplhRW6hKUV9zgUER2cS0X3wVUfKD+SoKm
 1wdd5Yy58pgfAjVLgoV+VEDCfDYfugJPQtNqowmiEtAEn295VtjodIcHghUih7orUT91QGIna
 Ue5B/+rvUcXU8AmM08ICuqYvc8go2+ONLgHfUpLtEI9Y4VB3JHdehPH3vFfNQcikEO5Z9u0sn
 7UV3ZXkddDCnUYKX288a7QqrwGb1topQsz7HFIT9VMqRtBwOcFfjabBcJ60K1QzfjXFff69Yx
 ScgIRyme6BUkJvXHtXJsVgoxiModh6KuVLxUKGvEh4WNKsNTdIhnSUGVRJGXby61iHFFhCy3H
 Y0icczCd9KV3zkUB+BfLTtlj6wUO6TxxdBqlSHhIRKUlJnYASZOlrJkmDv6MwIQUrh+P9f4Lk
 ViJqejbrNIpXOpz46tC7YZF70CuQstC4rkN5T6Q2B+HGeBM73e3Zh32LLrlfi78ioOwPx3EwG
 c2Z0QggupGXEckeurQNC3JU6U3jsT/HxY+futxNIsnT43I9TXl8P921np2Z8WLSjZNxIH51Ti
 sR2noXCwilPxxwhOQtnTXmS/bQFeztUP3JZAOFhNoMLcNurdVi/Ews5ZbYwxUn5Iq1zE9qPBj
 /9bmkXD1K6Mg5jEWZJ/Z3qCSY8nKPIulppUZWJHEDg0h+W1o3FLXGbGPEikWDy+IfJIE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add display controller parallel RGB panel support incl. backlight PWM.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index be531d4c2ae8..e5e26a6c2861 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -21,6 +21,13 @@
 	};
 
 	host1x@50000000 {
+		dc@54200000 {
+			rgb {
+				status = "okay";
+				nvidia,panel = <&panel>;
+			};
+		};
+
 		hdmi@54280000 {
 			status = "okay";
 			hdmi-supply = <&reg_5v0>;
@@ -99,6 +106,10 @@
 		status = "okay";
 	};
 
+	pwm@7000a000 {
+		status = "okay";
+	};
+
 	/*
 	 * GEN1_I2C: I2C_SDA/SCL on SODIMM pin 194/196 (e.g. RTC on carrier
 	 * board)
@@ -149,6 +160,26 @@
 		no-1-8-v;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <255 128 64 32 16 8 4 0>;
+		default-brightness-level = <6>;
+		/* BL_ON */
+		enable-gpios = <&gpio TEGRA_GPIO(T, 4) GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_3v3>;
+		pwms = <&pwm 0 5000000>; /* PWM<A> */
+	};
+
+	panel: panel {
+		/*
+		 * edt,et057090dhu: EDT 5.7" LCD TFT
+		 * edt,et070080dh6: EDT 7.0" LCD TFT
+		 */
+		compatible = "edt,et057090dhu", "simple-panel";
+		backlight = <&backlight>;
+		power-supply = <&reg_3v3>;
+	};
+
 	reg_3v3: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "3.3V";
-- 
2.14.4

