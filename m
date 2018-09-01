Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77783C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8C920845
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8C920845
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeIARRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:17:38 -0400
Received: from mout.perfora.net ([74.208.4.197]:58993 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbeIARRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:17:37 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LrtKS-1flaey2I2w-013ff6; Sat, 01 Sep 2018 15:05:31 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 08/19] ARM: tegra: apalis-tk1: reorder backlight properties
Date:   Sat,  1 Sep 2018 15:04:53 +0200
Message-Id: <20180901130504.14318-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901130504.14318-1-marcel@ziswiler.com>
References: <20180901130504.14318-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:fkeIgvFKgoiKQTjKKNGpwsyO9SvJp0pkYlt8JTmu2+AExTdsIVb
 lGWyK8I9OUKTUVd4O+qkiERioQNUbPlNqc0CJKZOeZlvYAizQjlU22qxcNynt5M0gem1YDH
 q/BV7DI4Dx8CzRKejBxPn5D3y+4742jg/2I8tFOkXLX4aigrJGPeCCA63xTtXt6vjDmNtjo
 /Ljyix0R4swOwncrHnStQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RPQhcywww7Y=:AVO4GqX9ez8TttytTNPMS8
 ke808tm6/tJYYDMahtUDwpu6xgHIzvc9w3MG32WgggIbQcB/zoMZV/nCvsVXiY2e+ZjX3eDVM
 YBJ11Zg2eunOAGQeDu8HtQE96SsDtiS37Gsbq0AZCIHKJPxitNm0mBY67l7BUeBQQbvgUFOAP
 s1XnBJJUvYemkNLbzyM+dXoRllkqmYGomchOElkPo80MZziKqM5s/2WcUXKp51M+gh1KKFZxd
 66TlMzOrjAep0z2ZBjeYmrj223t3vJjanoMAH4Inm7ZUQdxwfWIpl1B0nWERonpRiW5Dk0dWf
 MAxcM5NPHG7qieJzxsUJllO7EUT5vmXE5Vulj+mPlhPd3vw2rfE3aQmjRTrdzbVMMiVgdcEzo
 bM6pSOCBbVVPkTb5PeKOdKQhx3gAJErjY99mvHuT58a0V6rmX2vaRo1E3u3aTfuxw3gXxV24T
 BVjAAX7S6StmrAJsW4ydiZQaI1UuDmC5E/qs9bDyKqRsJPoqXruYBwxE/Aryr5YieYzmPssgd
 eSUEytpmY7KEqVnjXFasaWHuDfuR1eK28SH/5MmXIKqC+uy6ZdOeF7WibnrDtyEaiOlEa6ipi
 WUYrDhCQrRStH9SIo5V0K1j/zwhTrSKqlcSIwDrsHj10mzAp2XL5B3JM7H0V12r9pfI2hsS2o
 DyEbpPGSfBtBy1zFGmVDDHvR6vsQcJ8Eon47i2zH6CXr3lNNaoaGBn4G255SHDHi61Vo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder backlight properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra124-apalis-eval.dts      | 2 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
index c2e918d345de..d9805fc97f5e 100644
--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
@@ -228,12 +228,12 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 3 5000000>; /* BKL1_PWM */
 		brightness-levels = <255 231 223 207 191 159 127 0>;
 		default-brightness-level = <6>;
 		/* BKL1_ON */
 		enable-gpios = <&gpio TEGRA_GPIO(BB, 5) GPIO_ACTIVE_HIGH>;
 		power-supply = <&reg_3v3>;
+		pwms = <&pwm 3 5000000>; /* BKL1_PWM */
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
index eebcc013771e..aafaf2c3e195 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
@@ -193,12 +193,12 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 3 5000000>; /* BKL1_PWM */
 		brightness-levels = <255 231 223 207 191 159 127 0>;
 		default-brightness-level = <6>;
 		/* BKL1_ON */
 		enable-gpios = <&gpio TEGRA_GPIO(BB, 5) GPIO_ACTIVE_HIGH>;
 		power-supply = <&reg_3v3>;
+		pwms = <&pwm 3 5000000>; /* BKL1_PWM */
 	};
 
 	gpio-keys {
-- 
2.14.4

