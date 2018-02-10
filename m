Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeBJBjY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:39:24 -0500
Received: from mout.perfora.net ([74.208.4.197]:34355 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751343AbeBJBjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:39:22 -0500
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] ARM: dts: tegra: use proper irq type definitions
Date: Sat, 10 Feb 2018 02:33:23 +0100
Message-Id: <20180210013326.27771-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180210013326.27771-1-marcel@ziswiler.com>
References: <20180210013326.27771-1-marcel@ziswiler.com>
X-Provags-ID: V03:K0:TweU5n4bZEUqKWyWQf5zO8B3GPXYz5/PABh0rpIKz0mEOVEEfuB
 pe5mzxB/jH5CxhEQs3TQsJlJpO7QS7oBVEowQNzNxvFb96VghOv/msHFEpiI9me9i7XKykG
 UD5RO3aqLpsWKrHcJoGYiK/FN9rCYQo5eC1zzDv5i10uEcYo3CLY2EI0xFWxFhdcVzoikQ+
 xk1y0WMx7A2wvF2FGMzXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M/4vwavD2HI=:WyNaSJPF9koC1ZQiYPaixO
 Qs9UGNDaFiHtFs/SXNj90QdvI+oFJcF4LY/0xeEN8aTeoP8hu5iUtvKB0y0B5hH+WZ14ZBwZ4
 glV/FvnnGAyQCGrYRhlV8UBsOWLne/R4IISl7YbNurBiQbBvYcvTEdIMD10jLwdqzCrK1LtQ4
 HtJ7GnzeIegbf1IDZlLklBqpssdZQmHx6hqx1llCQt5iC+q2iIj42VEQqas5yNhumWfXXNKZF
 UY1Qn9Mqj52dmudddWwO0eWZChFafkt9up7e+33luOzBo2wkaQnQzLCyGIjeXAt8FkjywuG0k
 R4i75Sqv2Q0fzBphYTgEwHe7p2641klB6KfMj+YQr4qe9ebN6qq1wzDz4WJDAI2LxtIGjUSa3
 jQFrBpJOfzkVcZCi6q3CzDCBzHkV/gP+KedQbWeTcoC5UvZMac1r82VKf7/8azLk/8z0QD/8Z
 zlcHEB3suZMa4HNmOBNgzdWA3kTLbxekSnhTA4IsAS/ZGewMiSP85GmUd9mlC3AlMLF3brvs9
 Dv4DEt5ZZ/P68IqvUnqui+OIb8y/U/1/fXiPVUW+uoGSCM9dBsngA4A1cJ3l28uAAa5tRI+ea
 Svne59RtEAlQJHntEPI9Sgq5s5NmUjQ7OZd5Bf4Gy2WHsVZ0FV8+dQJuE3cddZyQLHKbfj3U3
 yvT0xtVwusa4OX0oWM5ub7MoeBYKCV8BqqZ1AwW3GeFmKs86cVWj4FJT9JqN3uSdinj+3CleU
 iXjFG8QAWVgo1GDXRNK9YqkT0iW/p1lx8f5+5g==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This switches a few interrupt definitions that were using either
GPIO_ACTIVE_HIGH or GPIO_ACTIVE_LOW as IRQ type, which is invalid.

This is mostly a cosmetic change, that doesn't affect any driver.

Analogous to Paul's commit 38333641b6dd ("ARM: tegra: nyan: Use proper
IRQ type definitions").

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/tegra114-dalmore.dts        | 2 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts     | 2 +-
 arch/arm/boot/dts/tegra124-venice2.dts        | 4 ++--
 arch/arm/boot/dts/tegra30-apalis.dtsi         | 4 ++--
 arch/arm/boot/dts/tegra30-beaver.dts          | 2 +-
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index acd6cf51b15b..eafff16765b4 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -780,7 +780,7 @@
 			compatible = "realtek,rt5640";
 			reg = <0x1c>;
 			interrupt-parent = <&gpio>;
-			interrupts = <TEGRA_GPIO(W, 3) GPIO_ACTIVE_HIGH>;
+			interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_EDGE_FALLING>;
 			realtek,ldo1-en-gpios =
 				<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index d112f85e66ed..6dbcf84dafbc 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1418,7 +1418,7 @@
 			compatible = "realtek,rt5639";
 			reg = <0x1c>;
 			interrupt-parent = <&gpio>;
-			interrupts = <TEGRA_GPIO(H, 4) GPIO_ACTIVE_HIGH>;
+			interrupts = <TEGRA_GPIO(H, 4) IRQ_TYPE_EDGE_FALLING>;
 			realtek,ldo1-en-gpios =
 				<&gpio TEGRA_GPIO(R, 2) GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 32d9079f025b..c0469ea149d2 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -613,7 +613,7 @@
 			compatible = "maxim,max98090";
 			reg = <0x10>;
 			interrupt-parent = <&gpio>;
-			interrupts = <TEGRA_GPIO(H, 4) GPIO_ACTIVE_HIGH>;
+			interrupts = <TEGRA_GPIO(H, 4) IRQ_TYPE_EDGE_FALLING>;
 		};
 	};
 
@@ -859,7 +859,7 @@
 					reg = <0x9>;
 					interrupt-parent = <&gpio>;
 					interrupts = <TEGRA_GPIO(J, 0)
-							GPIO_ACTIVE_HIGH>;
+							IRQ_TYPE_EDGE_BOTH>;
 					ti,ac-detect-gpios = <&gpio
 							TEGRA_GPIO(J, 0)
 							GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index faa8cd2914e8..bfb7913c0657 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -657,7 +657,7 @@
 			reg = <1>;
 			clocks = <&clk16m>;
 			interrupt-parent = <&gpio>;
-			interrupts = <TEGRA_GPIO(W, 3) GPIO_ACTIVE_LOW>;
+			interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_EDGE_RISING>;
 			spi-max-frequency = <10000000>;
 		};
 	};
@@ -672,7 +672,7 @@
 			reg = <0>;
 			clocks = <&clk16m>;
 			interrupt-parent = <&gpio>;
-			interrupts = <TEGRA_GPIO(W, 2) GPIO_ACTIVE_LOW>;
+			interrupts = <TEGRA_GPIO(W, 2) IRQ_TYPE_EDGE_RISING>;
 			spi-max-frequency = <10000000>;
 		};
 	};
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 5331a8f7dcf8..36b85a0ab0eb 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -1762,7 +1762,7 @@
 			compatible = "realtek,rt5640";
 			reg = <0x1c>;
 			interrupt-parent = <&gpio>;
-			interrupts = <TEGRA_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+			interrupts = <TEGRA_GPIO(X, 3) IRQ_TYPE_EDGE_FALLING>;
 			realtek,ldo1-en-gpios =
 				<&gpio TEGRA_GPIO(X, 2) GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 3c5fb2430212..b307feb7c330 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -79,7 +79,7 @@
 			reg = <0>;
 			clocks = <&clk16m>;
 			interrupt-parent = <&gpio>;
-			interrupts = <TEGRA_GPIO(S, 0) GPIO_ACTIVE_LOW>;
+			interrupts = <TEGRA_GPIO(S, 0) IRQ_TYPE_EDGE_RISING>;
 			spi-max-frequency = <10000000>;
 		};
 		spidev0: spi@1 {
-- 
2.14.3
