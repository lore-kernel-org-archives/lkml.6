Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF03C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7097420843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7097420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeIARRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:17:54 -0400
Received: from mout.perfora.net ([74.208.4.197]:48259 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbeIARRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:17:54 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MXoiP-1gRpMK10Z5-00Wnof; Sat, 01 Sep 2018 15:05:47 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 17/19] ARM: tegra: apalis-tk1: get rid of fake clocks simple bus
Date:   Sat,  1 Sep 2018 15:05:02 +0200
Message-Id: <20180901130504.14318-18-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901130504.14318-1-marcel@ziswiler.com>
References: <20180901130504.14318-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:mgMHr2fomEsXavhfaj4EHEhNnJUyQwbhok3AUU/aHXrrUsAMjKa
 8LeiBJGBDZ8aiE2Yw65BhvPeYyKPyrzY0E+l40Jvl3c+VlqGhIAMGHms+bVHDMmWs3Ting7
 XONxfEaAzsWvaknn2poT0R8r4LvgxZyPRwOuDA3E4GNS93s1jmSbym2VYK9Vp47cP6FFKhv
 CXbbDR5M42f5ap8QpGPYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SbJfI7zqvFk=:AVoc2QO9FnGpUPpQ4o5pH3
 MjUluBjEE15ZoHYd5OkXDPOGxN5nOXp/54xep7folSG5CcZOxLdrfs3FsFKN25l+zXTeRC3Ke
 212gsTGfIa/lXXDK1Y0dnI8K1pQHE/wH5p4gAj08m/vhKmfjSjxt343xzTLVHmPuQw+Si5asU
 nmhDrsPmaGWwdDelKUbPbgzKHVZ33CqBElJRRrLcHUhcnUjJbXiTpst5tPRUr4xe0+UARaIF8
 2kJCEFEO0Gqr7Kq4RIGH4KgCBaYdIQrE8xomwa1IRIZER4TwDAe5N3UX2P45xRi+MJWY87ZKW
 90ajOFR3m/wc9ZAGNLSYbFc3Ah0nntqAf42gH5rUo6jIQM384JjfMjWhcWr4U8t2nq+tSQaxI
 ZwwcuF4c4J6a5Qz0nKZ2hcFsKlSWcbgaXLKT5wX2E8vZJuCTSHBZMyWqwDdC9B23zkOpAbgab
 dixlr+OYLgHylgDURJhO1mmCSG5Jmokbew39lNnMxebl0cO28jHtwWV8PSSG2832xfDiwGXV8
 QY2Fk7q4TGdRqomh2xLI+86rS5jiGEJH9i+Xx9pAXf0G1odO/5dOq7TUOV3xJBKphsaoH+VV0
 up+/R44IMoWUZkzUHkatpp5CA8eP7OEh8klOoK+7X7gt19o8GHVRMpRECjssKwU/nLiNLbuC5
 JvgaZxbDBDzyscZMtwgPvZ71h8f7TkgQ8aKpM20aA1DP9pxKYS4NJUKsd3pPYO9ozMZE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Get rid of the fake clocks simple bus and use node names as per the
actual schematics.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Get rid of fake clocks simple bus as suggested by Rob.

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 15 ++++-----------
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 15 ++++-----------
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 6d36521448ce..7fe61f1baadd 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -1931,17 +1931,10 @@
 		};
 	};
 
-	clocks {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		clk32k_in: clock@0 {
-			compatible = "fixed-clock";
-			reg = <0>;
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-		};
+	clk32k_in: osc3 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
 	};
 
 	cpus {
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index a8f1306b5cd7..62af3dc97ede 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1961,17 +1961,10 @@
 		};
 	};
 
-	clocks {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		clk32k_in: clock@0 {
-			compatible = "fixed-clock";
-			reg = <0>;
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-		};
+	clk32k_in: osc3 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
 	};
 
 	cpus {
-- 
2.14.4

