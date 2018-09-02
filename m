Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F39C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6FE20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6FE20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeIBO0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:26:44 -0400
Received: from mout.perfora.net ([74.208.4.194]:40815 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbeIBOZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:28 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LwYMD-1fpxsg1EaN-018FTY; Sun, 02 Sep 2018 12:10:05 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 26/37] ARM: tegra: colibri_t20: annotate/move sd card detect
Date:   Sun,  2 Sep 2018 12:08:55 +0200
Message-Id: <20180902100906.25792-27-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:R7RUuWKSO3LtuiMkNDV8xmgffdIjKVKiJRPT1uEmb6jtz8RAy/A
 p3t7zzNyqZMZRac4yYVQH7wZ5w0E7K9Pg0L9tlNWHbNFzPPtmCT27ghKQ7xRiTwgwcJLXEY
 5VX7Ial4Z1afB63seQP0M/hyzD6L9t1LHdnBjpZk74PmPRtDOwLuHYEFB0S9AVtaYq7NCYK
 PQrJDN54bhMVp8t4S5crA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aiXRSdUXs30=:UHdTqqiaO6ZLbv+l67FYdB
 8Xw8WzxPymz+6p+wh72whiUbmphyc4S8D4wMxFlG4aDTf+wvN0/OuM99qz/tw8t9nzgz5W9m/
 Rhm230bpcyeTXisttE/1vDypq164Kev3obowkdgKp+HmPhnFJdad6UxSVdtxoe8DTi+eL5HZt
 VaHh+cas++QQ8YHcWs2veSfS1CYpFo5Aay0NhZtkPRxmWNTO+aTRXxWMXndTOeSy3TKAUIJV/
 xzyQLGWyMHq7jijojVIWIcNLWyAuXiCxI1JDajGQgjB8/zgHm69QCAXjgp+OlYou+DnCvchPe
 NKMJDhHpmFDvOyPZKXo9eqMr8bisDR92yuN50kjfIQ/eeW/FIdZPwWQHH84dRmqhjlAIerGSl
 D6ACv0b1mp5Ly7Y6YIXfKW4/nv2Xs/e0RjK8i9jOyZR/vvcxFprKiUSI6ZSRJdtDOg2G0wsDh
 F26T7ELut5JcFZ53twSe6MrmlXt82tY9MW3+rYDOpi1aKklGCUe9zetu4OF+lE/yujgS4Ortb
 MRiF5U+gEqjSmh1ioeZv8y0eakatSGFfBpnd37SVJISn5PWMgAYwuX/hEx0rxeL9pgsh4NSxV
 8c5H4DmpgMQmEdubSxmcjN7HLNOSX2pJ+JjXekIdbnL9SrWvP3FcR/RRJtAl1fYlG6i9raTyJ
 j7pTEXZPjURrFxwfesa40Vvljk+fZvqJorXUG7OEO4beMQKGezysgL0gy8y6xdVJIfrg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate the SD card, its detect pin and move the SD card detect GPIO
definition from the module to the carrier board more in-line with our
other device trees.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 2 ++
 arch/arm/boot/dts/tegra20-colibri.dtsi     | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index 7a7530820188..1583d5118302 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -163,9 +163,11 @@
 		vbus-supply = <&reg_usbh_vbus>;
 	};
 
+	/* SD/MMC */
 	sdhci@c8000600 {
 		status = "okay";
 		bus-width = <4>;
+		cd-gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_LOW>; /* MMCD */
 		no-1-8-v;
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index aba56b447bcd..6b82485ff58e 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -698,10 +698,6 @@
 		vbus-supply = <&reg_lan_v_bus>;
 	};
 
-	sdhci@c8000600 {
-		cd-gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_LOW>;
-	};
-
 	clocks {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.14.4

