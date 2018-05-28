Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755737AbeE1TOF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 15:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755716AbeE1TOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 15:14:00 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v2] Documentation: dt-bindings: Explicitly mark Samsung Exynos SoC bindings as unstable
Date: Mon, 28 May 2018 21:13:27 +0200
Message-Id: <20180528191327.23772-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

Samsung Exynos SoCs and boards related bindings evolved since the initial
introduction, but initially the bindings were minimal and a bit incomplete
(they never described all the hardware modules available in the SoCs).
Since then some significant (not fully compatible) changes have been
already committed a few times (like gpio replaced by pinctrl, display ddc,
mfc reserved memory, some core clocks added to various hardware modules,
added more required nodes).

On the other side there are no boards which have device tree embedded in
the bootloader. Device tree blob is always compiled from the kernel tree
and updated together with the kernel image.

Thus to avoid further adding a bunch of workarounds for old/missing
bindings, make development of new platforms easier and allow to make
cleanup of the existing code and device tree files, lets mark some
Samsung Exynos SoC platform bindings as unstable. This means that
bindings can may change at any time and users should use the dtb file
compiled from the same kernel source tree as the kernel image.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Rebase
2. Add specific compatibles to mark unstable.

v1 is here:
https://patchwork.kernel.org/patch/9477963/

Previous tags (not applying due to change in contents):
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 .../devicetree/bindings/arm/samsung/exynos.txt     | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos.txt

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos.txt b/Documentation/devicetree/bindings/arm/samsung/exynos.txt
new file mode 100644
index 000000000000..7410cb79e4b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos.txt
@@ -0,0 +1,26 @@
+Samsung Exynos SoC Family Device Tree Bindings
+---------------------------------------------------------------
+
+Work in progress statement:
+
+Following Device Tree files and bindings applying to Samsung Exynos SoCs and
+boards are considered "unstable":
+
+ - samsung,exynos5433* (all compatibles related to Exynos5433)
+ - samsung,exynos7* (all compatibles related to Exynos7)
+ - samsung,tm2-audio
+ - samsung,mfc-v10
+ - samsung,exynos*-mipi-dsi
+ - samsung,exynos5-dp
+ - samsung,exynos*-hdmi
+ - samsung,exynos*-hdmiddc
+ - samsung,exynos*-hdmiphy
+ - samsung,exynos*-mixer
+ - samsung,exynos*-fimd
+
+Any Samsung Exynos device tree binding mentioned may change at any time. Be
+sure to use a device tree binary and a kernel image generated from the same
+source tree.
+
+Please refer to Documentation/devicetree/bindings/ABI.txt for a definition of a
+stable binding/ABI.
-- 
2.14.1
