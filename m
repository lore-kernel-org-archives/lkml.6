Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeBJBnt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:43:49 -0500
Received: from mout.perfora.net ([74.208.4.197]:53511 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751087AbeBJBnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:43:46 -0500
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/6] arm: tegra: apalis-tk1: set critical trips
Date: Sat, 10 Feb 2018 02:38:01 +0100
Message-Id: <20180210013806.28496-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180210013806.28496-1-marcel@ziswiler.com>
References: <20180210013806.28496-1-marcel@ziswiler.com>
X-Provags-ID: V03:K0:SqSLnO3YejxxAFcuVAbb4AmAGp5i0tWs+awj+4DXEFqke2dAEcU
 RE+H7xixerBRmB3M4ApNJYfvYOynRmZ/6l9AutOIVPuiHexqE5H7SxFqSKlpgP9wLxdmK04
 h1XB1NPvn5ihz0pkK80zDIS2luqr3avPiyG6tXG91J3hS07DR8UEPSn2oz8QFfK/26bA18T
 t8NDvULsd89hEkTMx90bg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F3uqRVSdY+U=:1CzV+1f8CTmuFQxOX1roIC
 P1WBB4gg3flUWnye6dCvCPpYxknV7WBdXoJzzCgzj6/nSaSfpC5PRkh2BHczTL7g27cmTYNQF
 Y118it/K/TXGUQ1q8AFYmausnLIghkQi0TxW0jTtWawiHyFYhmIHN+Sj84veNqTvDfEzT8M2u
 YwYCyMZhrRupuCIw6Keu/SRl6KsrlRDZ+yeBKN1DeAF3Qh//wpDvkg+ujw9bhB/tNkafqIDyC
 rIeJXF5v+qDMZvgaFEM4uYg1j21GbV9lOOgycFL/d1lW/wURCLuqMn95Kri5zd/pWyXLa18cS
 RH4oxG24d2WL5pmUgl77oS8lBOn3rJyyFMGkudAvAhduRYPF009s3fJgyc7C3jNuG08K6j8ce
 HcJ8a/O2ZLQe/dLbc6/5qHVKFHTwj7Y6ZbzdkBy2X42zZG/m4D4KrQq1D5ygeNvToD7etH+Qb
 Y1rOHLe832YZB+7c6V6MvFiPUL2at0DxerJJ6AiV0Q38ex6N+x5o1DHNjZEsEO5wBByuxJsRU
 d9ZvfqtJZaLfxqD9dO8TRkRPhot0x9ApmXC05sJI7y5yAHUhFAMR/bXRme1+GFMJarY8/ia12
 k+Bpvw7SIeK8q5VlOBHiaaus69qefbo4oSuXbEkm3sERUgYKR6/EG/abz9UFbqUgyvivAkkPi
 lrZgp/3jNTdJRssYpbQb8R8w2xS6Rqt7DrdQXKmZXnXKttyX8WwumZVXu0wMxh9nB7QwumPL0
 LuCpf4AME0qaAvVAi5TY4sb9fAzeCmJ1p0JRXA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Set "critical" trip temperatures for cpu, gpu, mem and pllx
thermal zones. These trips can trigger shut down or reset.

Similar to commit 40823f8e267f ("arm: tegra: set critical
trips for Tegra124").

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis.dtsi | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 7aef8928e115..be45b6753916 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -2041,53 +2041,32 @@
 	thermal-zones {
 		cpu {
 			trips {
-				trip@0 {
+				cpu-shutdown-trip {
 					temperature = <101000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
-
-			cooling-maps {
-				/*
-				 * There are currently no cooling maps because
-				 * there are no cooling devices
-				 */
-			};
 		};
 
 		mem {
 			trips {
-				trip@0 {
+				mem-shutdown-trip {
 					temperature = <101000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
-
-			cooling-maps {
-				/*
-				 * There are currently no cooling maps because
-				 * there are no cooling devices
-				 */
-			};
 		};
 
 		gpu {
 			trips {
-				trip@0 {
+				gpu-shutdown-trip {
 					temperature = <101000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
-
-			cooling-maps {
-				/*
-				 * There are currently no cooling maps because
-				 * there are no cooling devices
-				 */
-			};
 		};
 	};
 };
-- 
2.14.3
