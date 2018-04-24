Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbeDXRra (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:47:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752891AbeDXRqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:46:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810FF21836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ARM: dts: exynos: Remove unnecessary address/size properties in dp-controller of Exynos5
Date: Tue, 24 Apr 2018 19:46:02 +0200
Message-Id: <20180424174602.3915-5-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180424174602.3915-1-krzk@kernel.org>
References: <20180424174602.3915-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "dp-controller" node is not a bus and it does not have children with
reg/ranges properties so remove address-cells and size-cells properties.
This fixes warnings for all Exynos5 boards:

    arch/arm/boot/dts/exynos5250-arndale.dtb: Warning (avoid_unnecessary_addr_size):
        /soc/dp-controller@145b0000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 359f49bdd4e2..5d2f0a06fbef 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -196,8 +196,6 @@
 			reg = <0x145B0000 0x1000>;
 			interrupts = <10 3>;
 			interrupt-parent = <&combiner>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			status = "disabled";
 		};
 
-- 
2.14.1
