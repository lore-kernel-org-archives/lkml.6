Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C9DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020AD2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N68aYKHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020AD2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeIEWLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeIEWLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:11:48 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6134D205F4;
        Wed,  5 Sep 2018 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536169236;
        bh=qyNL+werNF896t6kFXhNbN7qBqzcEDzb6l8ITVfgEfk=;
        h=From:To:Subject:Date:From;
        b=N68aYKHu0bYusBHYTqavgFQeYjmpvLZOpZb3cv3J0CHRR4EtNOvhJXUdzpAf3GZOX
         QVdOPIn4qEqHbLICU24GHZ0aRL9I6P6SoaNmMYczRjoAfDzpyRgQD+sVVGGqVsZhGL
         6wjHakCqNH1ejO3PozcG6kIJdrt8tw+Mkh+b+0lE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maciej Purski <m.purski@samsung.com>,
        Simon Shields <simon@lineageos.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT] ARM: dts: exynos: Remove double SD card detect pin inversion
Date:   Wed,  5 Sep 2018 19:40:24 +0200
Message-Id: <20180905174024.28366-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDHCI standard, MMC host controller bindings and MMC core defines
card detect pin as active low.  Therefore there is no point to invert it
twice.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Tested only on Odroid U3. Tests on other platforms would be appreciated.
---
 arch/arm/boot/dts/exynos4210-universal_c210.dts | 3 +--
 arch/arm/boot/dts/exynos4412-midas.dtsi         | 3 +--
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 4e6ff97e1ec4..249bfbff1e20 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -537,8 +537,7 @@
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4>;
 	pinctrl-names = "default";
 	vmmc-supply = <&ldo5_reg>;
-	cd-gpios = <&gpx3 4 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpx3 4 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index c0476c290977..aed2f2e2b0d1 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -1269,8 +1269,7 @@
 
 &sdhci_2 {
 	bus-width = <4>;
-	cd-gpios = <&gpx3 4 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpx3 4 GPIO_ACTIVE_LOW>;
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4 &sdhci2_cd>;
 	pinctrl-names = "default";
 	vmmc-supply = <&ldo21_reg>;
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index a09e46c9dbc0..2caa3132f34e 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -539,8 +539,7 @@
 	pinctrl-names = "default";
 	vmmc-supply = <&ldo21_reg>;
 	vqmmc-supply = <&ldo4_reg>;
-	cd-gpios = <&gpk2 2 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpk2 2 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
2.14.1

