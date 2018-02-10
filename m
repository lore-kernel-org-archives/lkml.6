Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbeBJBmN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:42:13 -0500
Received: from mout.perfora.net ([74.208.4.196]:46639 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751030AbeBJBmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:42:11 -0500
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] ARM: dts: tegra: apalis/colibri: remove unneeded reg property
Date: Sat, 10 Feb 2018 02:36:38 +0100
Message-Id: <20180210013638.28164-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180210013638.28164-1-marcel@ziswiler.com>
References: <20180210013638.28164-1-marcel@ziswiler.com>
X-Provags-ID: V03:K0:HXC2BMx25r6LY0GGXMX7IlR/+NHKwCqm6KlyciQV/O465LBXPTQ
 4OvAviZeD21bDlGALi3toxMXq2ZvqRKHqcTI6aA6S5DXBSeGHZT4W0LDzX3hjZp9ZPSqQYw
 pAzFhoKqPg5X6A+Du2zajlOJfUq3mgtd5RD5KHBiUcs26e7o8QUwXLp4qpr+0UJrlpgIUx5
 KejWHoESMKnBVDvK+bTVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N93NCQEnO4g=:tU17mC+1j3XplVlAu3PPG7
 +GSztFgxouoTI9IR3PUINSMVWMOAd4IXqZXqZj2gxXm199+X3TBk4DGr5Z1dlDDAYtdDNfTsG
 rcVC18yUqpHV7v07TYEJwd8gc9aMSEnegQyMCRWLBxKlW9KQL5BOBRfI/UjaxYJjq+MjWjZE3
 u7cUYsGp3v4bKfQX0B2qTH4XNPz1HKbSQ0uZJ72KotfW3kCRbFOO5996uUzPSgdDv2Rsu3egs
 tnsC7WYwuovd0nMjWUTNmyEyaD3Pt0k021ecoCtesfxwK99r13QHuGhGALQ8ewglz5pZ6QUeV
 0XKmkCwpSry66jAL+lHfdnQiBVvmZ7P4wRc7Nt8ryRg401UecYPJ/Izy4hHNE0tXK7fYjgFz2
 hc6Wa2P4pWp0A1gSC0zJte0A/9dSODJl0yX7OSwgUiEUNrUl7DUBOPLONrID6HvdYmiFB4Vlz
 YSBw9SiYDTclQnzcgrifZE7ARnCJxWxfuz+EfWkC8CG7HQF+gj6K2Df/67sXcZsVM14ClKdDY
 V+nHZ5O5EWHx4FVBnEbu+whXPM1/hB+F1ikGHQ8O9Dg0ySuqVlyU1QcEMZelxH+420Ay7gsXH
 Ef+wEXfzNd+PqMwz1wkge/ecHbzsHnbD9rTgFiR4KzkdaPyIA9L/xOK/0aEydc+8rK0B53hKu
 5u8AwJQEsikNz4PUTEgwVDryQZ8TcOePEahPBi1maJ0gRQE/288XrfQqA7muHZdTqwqfCCjas
 czbtaTWUaKAfYygDN7COhOVLzH2qqjSo4piAEg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

As described in
Documentation/devicetree/bindings/input/touchscreen/stmpe.txt there is
no 'reg' property under stmpe_touchscreen, so remove it to fix the
following build warning with W=1:

arch/arm/boot/dts/tegra30-apalis-eval.dtb:
Warning (unit_address_vs_reg): Node
/i2c@7000d000/stmpe811@41/stmpe_touchscreen has a reg or ranges
property, but no unit name

Similar to commit 89277e8e2679 ("ARM: dts: imx6qdl-apalis: Remove
unneeded reg property").

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis.dtsi  | 1 -
 arch/arm/boot/dts/tegra30-colibri.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 676a4c4b1512..d1d21ec2a844 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -597,7 +597,6 @@
 
 			stmpe_touchscreen@0 {
 				compatible = "st,stmpe-ts";
-				reg = <0>;
 				/* 3.25 MHz ADC clock speed */
 				st,adc-freq = <1>;
 				/* 8 sample average control */
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 1f77273521bf..c44d8c40c410 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -363,7 +363,6 @@
 
 			stmpe_touchscreen {
 				compatible = "st,stmpe-ts";
-				reg = <0>;
 				/* 3.25 MHz ADC clock speed */
 				st,adc-freq = <1>;
 				/* 8 sample average control */
-- 
2.14.3
