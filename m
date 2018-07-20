Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D31ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD69720850
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD69720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbeGTRXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:23:48 -0400
Received: from mout.perfora.net ([74.208.4.196]:35487 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731305AbeGTRXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:23:48 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MXWro-1fU1Bp3VXK-00WX2I; Fri, 20 Jul 2018 18:34:32 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/2] ARM: dts: tegra20: restore address order
Date:   Fri, 20 Jul 2018 18:34:25 +0200
Message-Id: <20180720163426.4410-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:gI4bynWGfd6gLbGAu6DBJ9zYJaKK8v64b2DM6yPkeM9/2VwDhQO
 tR3JIUWd0ozyYUrdMP9FhUyBzl5i2GFTUs0ZUlUlL5Qv+nfR0N6sW9vJB8SkWY/g2fCgBCy
 +AdGbJfrHonqbBsdWEwWL+m6ZhUifRwPo/cYET4cWCk+kRXkSXsy1qFD3rr46JiT7V5D9eM
 lL1r6qefcbUGMaOHHoZvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v2E7j0hvQFA=:N/limeanUhf2AuAEtNfUK5
 tEKTzMXWmDhZZDW97siGAZMnmSvJ1oNN3atwOn3Kwz0RnsjRwFS77R40dX8yhRAw3rccPAytq
 qnRac1mZd2lyb3nCnYYfOJZYjBaknsfS7Dh1pcWSkQsrnxiOvvDa7ak+3fh7xnWYOr/kpQxbv
 u/4mY0xscF726vJlIo7K3AL2qvCh1ygoubClhc8FCLWeGbAVZJPj9tbVjKpcdzQ6x1SU6PHz4
 UmA19Ypj5ggPASszfjDEpKEe/38iNSLb8rUrcbsPZoFLeVZaPp97tt0rTfMFvd7RDyfj/BUt6
 7sjqNM1lmmDpfgQIFVBHqeGVUqNDsH55TomKfX8rynPxDEI4VlJdGXMhB7YGNQZsBAcW3HSJ9
 eEyZU4beEW3LKpd1H0ANYg5WeE6t58MAboN57avE4Z9Rlzbtvvo69wS/iv51aRqs8bvSIrrZz
 MgHexac3QM1ozNf87NL1xkLEfYn3iTPjF3ozF8Vxcam/74FZhehQ6IEWKFc5l2K9oKAaha2Di
 tkPFIrsqFB0mKg2JwxgaARMUz1yII8bidv/W0COr/GZZ7m0ZETfEXtuz9sQl3tWgQUk8or6kM
 HClvhqxfY1YjaC/p/gq4P8fB6iKm0Lr2BxmNAPCmn08STczZFeAEIU7JItCLT1+Z/bMRIeOWI
 FF2xNIrg2vNVB1snuec8+shJcS96fBPjfWWFFHWRaVvBfh6/1GVoQ2jeNYMs9JqVDZ1Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Commit 6c468f109884 ("ARM: dts: tegra: add Tegra20 NAND flash
controller node") introduced the nand-controller node. However, it got
added at the wrong spot not honoring the address order. Fix this.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20.dtsi | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 979f38293fe5..a22c6a8f8f83 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -419,19 +419,6 @@
 		status = "disabled";
 	};
 
-	gmi@70009000 {
-		compatible = "nvidia,tegra20-gmi";
-		reg = <0x70009000 0x1000>;
-		#address-cells = <2>;
-		#size-cells = <1>;
-		ranges = <0 0 0xd0000000 0xfffffff>;
-		clocks = <&tegra_car TEGRA20_CLK_NOR>;
-		clock-names = "gmi";
-		resets = <&tegra_car 42>;
-		reset-names = "gmi";
-		status = "disabled";
-	};
-
 	nand-controller@70008000 {
 		compatible = "nvidia,tegra20-nand";
 		reg = <0x70008000 0x100>;
@@ -447,6 +434,19 @@
 		status = "disabled";
 	};
 
+	gmi@70009000 {
+		compatible = "nvidia,tegra20-gmi";
+		reg = <0x70009000 0x1000>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0 0 0xd0000000 0xfffffff>;
+		clocks = <&tegra_car TEGRA20_CLK_NOR>;
+		clock-names = "gmi";
+		resets = <&tegra_car 42>;
+		reset-names = "gmi";
+		status = "disabled";
+	};
+
 	pwm: pwm@7000a000 {
 		compatible = "nvidia,tegra20-pwm";
 		reg = <0x7000a000 0x100>;
-- 
2.14.4

