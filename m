Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbeBJBoF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:44:05 -0500
Received: from mout.perfora.net ([74.208.4.197]:37797 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752172AbeBJBoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:44:03 -0500
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/6] ARM: dts: tegra: apalis-tk1: hog group for ethernet, pcie, reset gpios
Date: Sat, 10 Feb 2018 02:38:04 +0100
Message-Id: <20180210013806.28496-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180210013806.28496-1-marcel@ziswiler.com>
References: <20180210013806.28496-1-marcel@ziswiler.com>
X-Provags-ID: V03:K0:M3fmOvleO9n6WsFexiZLkA2W5ROjyWQlO+xNbgadPe6J7NQNF6C
 ngsQ7WXlMjlHjpM55ZQGY0xVlSxDFltb5ZaSYt43h8EsfwOIuPnsPyI+/7ypBaOTFkT5tb/
 R7HBJIEmN+3EoH4lPwaTWOeH71X6AIFQAklqK1osOu0VqVJdI6rn7dAGpDayiugHksVJ1wH
 /vAph89vAtXPaed337Q5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1vWfnneh4Lg=:j0CLIPZtbBrrURrtBi4lEM
 ePXWQlRp3Rw3d8S8IxZrno68B4zRelg/GojWL/tk/L+7ENoMBjv7cXp+BjKl934ei5jvEldfv
 qWbN91CcdndZ/jZNTC2g4AiU+151o8Qjx9IGBaRUR6ufR7VFepBicLAp67/nNSWkQE8hORMB/
 S3Lw5qRKqkDB2Lyzgg8kAAPr+BFzU7b/UbWegkoiWuYqVaWL2rvz46S7Ikrq6lKEx9oeGatYP
 yJVrBo6YhSUeKzvdIP5rP8oNH9ooHs4xXs5ZvR2RCCkU5LyryuR2PjzjT4r3jKS403BN2WtRr
 /GzPFpZLXXwhIDrICtfQbgbP5X5fnSFmFmTY5MWMIVHKLTdiW0/NE/0i4McsYQPciIcViXdlw
 KkHo5CVzD8HkJjiN9MvAhCL6jgylPESuqZgI+Tm4DDsCdpvcv3TR+aayO1fmVHeDWfA3MS5ft
 U0qvlFc6kz8bJONe58v7JGn7UWaMjfb+8/Mo6QnHs0fWlQcACURkAh8jY/CwYC0EwxPkxN0pJ
 K8vhDI0NtEN0N7GvSsnnINEeslC94HUkMdca6oPGXbLkeS9XNI8T3e6FRxE8ZcpjzTNrMo/xO
 0cJhMKR+I7ab6aH20wIRQL3JG1c4WLK4DZmZ7AUOwz5leTOhJwyfq/iELGpC0+8egpQd+5DDf
 /QG87ACKzOhoevBI0pgT4Zbva+G+pfzFv/s6iYhhcvTM/TjbfUWJdjUqOr/uFn/Hbx7mCvED6
 S7yY0xg/iYhhSf+N7WE5vifJHn9KVMMw7iQ1IA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

The Apalis TK1 module uses some dedicated GPIOs as I210 gigabit Ethernet
controller reset and to control RESET_MOCI aka reset module output
carrier input on MXM3 pin 26. The Apalis Evaluation Board furthermore
uses Apalis GPIO7 on MXM3 pin 15 as reset signal for its PLX PEX 8605
PCIe Switch.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis-eval.dts | 10 ++++++++++
 arch/arm/boot/dts/tegra124-apalis.dtsi     | 18 ++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
index af6c566e8ac4..f1010cefb993 100644
--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
@@ -275,3 +275,13 @@
 		vin-supply = <&reg_5v0>;
 	};
 };
+
+&gpio {
+	/* Apalis GPIO7 MXM3 pin 15 PLX PEX 8605 PCIe Switch Reset */
+	pex_perst_n {
+		gpio-hog;
+		gpios = <TEGRA_GPIO(DD, 1) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "PEX_PERST_N";
+	};
+};
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 44c31176ce90..b7648ce4565d 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -2070,3 +2070,21 @@
 		};
 	};
 };
+
+&gpio {
+	/* I210 Gigabit Ethernet Controller Reset */
+	lan_reset_n {
+		gpio-hog;
+		gpios = <TEGRA_GPIO(S, 2) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "LAN_RESET_N";
+	};
+
+	/* Control MXM3 pin 26 Reset Module Output Carrier Input */
+	reset_moci_ctrl {
+		gpio-hog;
+		gpios = <TEGRA_GPIO(U, 4) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "RESET_MOCI_CTRL";
+	};
+};
-- 
2.14.3
